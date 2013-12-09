Plugin.create :fizzbuzz do
  def generate_reply(start, screen_name)
    result = "@#{screen_name}"
    n = start
    while result.size < 140 do
      result << ' '
      result << 'fizz' if flag3 = n % 3 == 0
      result << 'buzz' if flag5 = n % 5 == 0
      result << n.to_s if !flag3 && !flag5
      n += 1
    end
    result[0..(result.rindex(' ') - 1)]
  end

  on_mention do |service, msgs|
    msgs.select{|m| m[:message] =~ /^@#{Service.primary.idname} fizzbuzz \d+$/o}.each do |msg|
      n = msg[:message].split[-1].to_i
      sn = msg[:user].idname
      Service.primary.update(message: generate_reply(n, sn), replyto: msg.message)
    end
  end
end
