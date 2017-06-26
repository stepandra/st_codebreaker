require 'spec_helper'

module StCodebreaker
  RSpec.describe Interface do
    subject(:app) { Interface.new }

    describe '#initialize' do
      it 'create game instance' do
        expect(app.instance_variable_get(:@game)).to be_an_instance_of(Game)
      end
    end

    describe '#greeting' do
      before do
        allow(app).to receive(:print)
      end
      context 'incorrect input' do
        it 'notify for wrong input' do
          expect(app).to receive(:gets).and_return('else')
          expect(app).to receive(:print).with('Incorrect input')
          app.greeting
        end
      end
      context 'when 1' do
        it 'starts game' do
          expect(app).to receive(:gets).and_return('1')
          expect(app).to receive(:play)
          app.greeting
        end
      end
      context 'when 2' do
        it 'show game stats' do
          expect(app).to receive(:gets).and_return('2')
          expect(app).to receive(:show_stats)
          app.greeting
        end
      end
      context 'when 3' do
        it 'exit' do
          expect(app).to receive(:gets).and_return('3')
          # expect(app).to receive(:exit)
          app.greeting
        end
      end
    end

    describe '#save_stats' do
      # before do
      #   allow(app).to receive(:puts)
      # end
      # after { File.delete('../stats.txt') if File.exist?('../stats.txt') }

      # it 'sends "Input your name: "' do
      #   allow(app).to receive(:exit).and_return 1
      #   subject.save_stats
      # end

      it 'adds new score to stats' do
        allow($stdin).to receive(:gets).and_return('Name')
        app.save_stats
        expect(app.save_stats).to change(app.read_stats).by(1)
      end

      it 'exit' do
        expect { game; exit }.to raise_error(SystemExit)
      end
    end

    describe '#play' do
      before do
        allow(app).to receive(:puts)
        allow(app).to receive(:print)
      end

      context 'when h' do
        it 'output hint' do
          expect(app).to receive(:gets).and_return('h')
          expect(app.instance_variable_get(:@game)).to recieve(hint)
          app.play
        end
      end
    end
  end
end
