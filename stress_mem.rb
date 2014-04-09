@retained = []
@rand = Random.new(1)
 
MAX_STRING_SIZE = 100
 
def stress(allocate_count, retain_count, chunk_size)
  chunk = []
  while retain_count > 0 || allocate_count > 0
    if retain_count == 0 || (@rand.rand < 0.5 && allocate_count > 0)
      chunk << " " * (@rand.rand * MAX_STRING_SIZE).to_i
      allocate_count -= 1
      if chunk.length > chunk_size
        chunk = []
      end
    else
      @retained << " " * (@rand.rand * MAX_STRING_SIZE).to_i
      retain_count -= 1
    end
  end
end
 
start = Time.now
stress(10_000_000, 600_000, 200_000)
 
puts "Duration: #{(Time.now - start).to_f}"
vsz,rss = `ps aux | grep #{Process.pid} | grep -v grep | awk '{ print $5; print $6; }'`.split("\n")
 
puts "VSZ: #{vsz} RSS: #{rss}"
