# frozen_string_literal: true

require 'stats'

describe Stats do
  stats = nil
  before { stats = described_class.new(Time.at(1)) }

  describe '#probe' do
    context 'with valid proble input' do
      it 'prints probe details' do
        expect(stats.probe('url', Time.at(2), Time.at(3)))
          .to eq('00:02 : (GET url) : 1.0000s')
      end
    end
  end

  describe '#totals' do
    context 'with valid probes were recorded' do
      it 'prints stats details' do
        stats.probe('url', Time.at(2), Time.at(3))
        expect(stats.totals).to eq <<~TPL
          ---
          Total running time: 2.0000s
          Total probes made 1
          Average probe time: 1.0000s
          Min probe time: 1.0000s
          Max probe time: 1.0000s
        TPL
      end
    end
  end
end
