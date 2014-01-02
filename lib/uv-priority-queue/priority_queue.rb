module UV
    class PriorityQueue
        include Enumerable

        def initialize(opts = {}, loop = ::Libuv::Loop.current, &blk)
            blk ||= lambda { |x, y| (x <=> y) == 1 }
            fifo_blk = nil
            @fifo = !!opts[:fifo]
            if @fifo
                fifo_blk = lambda do |x,y|
                    if x[0] == y[0]
                        x[1] < y[1]
                    else
                        blk.call(x[0], y[0])
                    end
                end
            end
            @heap = Containers::Heap.new(&(fifo_blk || blk))
            @callbacks = []
            @loop = loop || ::Libuv::Loop.default
        end

        def size
            @heap.size
        end

        def push(obj, pri)
            pri = [pri, Time.now.to_i] if @fifo
            @loop.schedule do
                @heap.push(pri, obj)
                @callbacks.shift.call(@heap.pop) until @heap.empty? || @callbacks.empty?
            end
        end

        def clear
            @heap.clear
        end

        def empty?
            @heap.empty?
        end

        def has_priority?(priority)
            @heap.has_key?(priority)
        end

        def next
            @heap.next
        end

        def pop(callback = nil, &blk)
            callback ||= blk
            @loop.schedule do
                if @heap.empty?
                    @callbacks << callback
                else
                    callback.call @heap.pop
                end
            end
            nil
        end

        def delete(pri)
            @heap.delete(pri)
        end

    end
end
