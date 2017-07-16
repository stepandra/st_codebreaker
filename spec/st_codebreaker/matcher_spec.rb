require 'spec_helper'

module StCodebreaker
  RSpec.describe Matcher do
    subject { Matcher.new([1, 2, 1, 2], [2, 1, 2, 1]) }
    describe '#new' do
      it 'receive secret code and user guess' do
        expect { subject }.not_to raise_exception
      end

      it 'saves secret code' do
        expect(subject.instance_variable_get(:@secret)).to eq [1, 2, 1, 2]
      end

      it 'saves guess code' do
        expect(subject.instance_variable_get(:@guess)).to eq [2, 1, 2, 1]
      end
    end

    describe '#exact_match' do
      context 'with no matches' do
        it 'returns 0' do
          matcher = Matcher.new('1234','5555')
          expect(matcher.exact_match).to eq 0
        end
      end

      context 'with 1 exact match' do
        it 'returns 1' do
          matcher = Matcher.new('1234','1555')
          expect(matcher.exact_match).to eq 1
        end
      end

      context 'with 1 number match' do
        it 'returns 0' do
          matcher = Matcher.new('1234','2555')
          expect(matcher.exact_match).to eq 0
        end
      end

      context 'with 1 exact match and 1 number match' do
        it 'returns 1' do
          matcher = Matcher.new('1234','1525')
          expect(matcher.exact_match).to eq 1
        end
      end
    end

    describe '#number_match_count' do
      context 'with no matches' do
        it 'returns 0' do
          matcher = Matcher.new('1234','5555')
          expect(matcher.number_match).to eq 0
        end
      end

      context 'with 1 number match' do
        it 'returns 1' do
          matcher = Matcher.new('1234','2555')
          expect(matcher.number_match).to eq 1
        end
      end

      context 'with 1 exact match' do
        it 'returns 0' do
          matcher = Matcher.new('1234','1555')
          expect(matcher.number_match).to eq 0
        end
      end

      context 'with 1 exact match and 1 number match' do
        it 'returns 1' do
          matcher = Matcher.new('1234','1525')
          expect(matcher.exact_match).to eq 1
        end
      end

      context 'with 1 exact match duplicated in guess' do
        it 'returns 0' do
          matcher = Matcher.new('1234','1155')
          expect(matcher.number_match).to eq 0
        end
      end
    end
  end
end
