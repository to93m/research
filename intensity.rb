#音響インテンシティの計算 音源収録は今週中に行う 先行してプログラムを組む
#時刻tの音響インテンシティ
#t を決めなければいけない t[ms] 収録音源の中央部とか使えばいいのか？

#マイクロホンの角度，マイク間距離を設定 理想的な状態を想定する

require "./read_wave.rb"
require "./plot.rb"
include Math

rho = 1#媒質の密度
time = 1 #[s]
t_sample = (time * 16000).to_i #
theta = 90 #音源の入射角度
microphon_distance = 3.0 #マイクロホン間隔[cm]

input_wave = read_wave("Whitenoise.raw", 's')

a_diff = microphon_distance * sin(theta) / 340.0 * 100.0 #
diff_sample = a_diff * 16000.0

diff_sample.to_i.times{input_wave << 0}

mic1_data = input_wave[0..t_sample]
mic2_data = input_wave[diff_sample.to_i..(diff_sample + t_sample)]

x_axis = (0..t_sample).to_a
#plot(x_axis, mic1_data)
#plot(x_axis, mic2_data)

#積分部
pressure_diff ||= []
(t_sample).times{|i|
  pressure_diff << mic1_data[i].to_i - mic2_data[i].to_i
}

sampling = 1 / 16000.0
integral_res = 0
(t_sample).times{|i|
  integral_res += pressure_diff[i] * sampling
}

mean_power = mic1_data[t_sample] + mic2_data[t_sample] / 2

p intensity = -(1 / rho) * mean_power * integral_res

