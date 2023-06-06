# frozen_string_literal: true

# Stats class for recording and displaying probe stats
class Stats
  ROW_TPL = '%<time>s : (GET %<url>s) : %<duration>.4fs'
  TOTALS_TPL = <<~TPL
    ---
    Total running time: %<total_time>.4fs
    Total probes made %<total_probes>s
    Average probe time: %<avg_rsp_time>.4fs
    Min probe time: %<min_rsp_time>.4fs
    Max probe time: %<max_rsp_time>.4fs
  TPL

  def initialize(start_time)
    @start_time = start_time
    @end_time = start_time
    @probes = []
  end

  def probe(url, start_probe_time, end_probe_time)
    @end_time = end_probe_time
    duration = end_probe_time - start_probe_time
    @probes.push(duration)
    row({
          time: start_probe_time.strftime('%M:%S'),
          duration: duration,
          url: url
        })
  end

  def row(values)
    format(ROW_TPL, values)
  end

  def totals
    values = {
      total_time: @end_time - @start_time,
      total_probes: @probes.length,
      avg_rsp_time: @probes.sum.fdiv(@probes.size),
      min_rsp_time: @probes.min,
      max_rsp_time: @probes.max
    }
    format(TOTALS_TPL, values)
  end
end
