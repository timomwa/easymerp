module SequenceGenHelper
  def createSeq(sequence)
    @sequence = sequence

    if(@sequence.prefix.nil? || @sequence.prefix.empty?)
      @sequence.prefix = @sequence.name
    end

    if(@sequence.suffix.nil? || @sequence.suffix.empty?)
      @sequence.suffix = ''
    end

    if(@sequence.next_val.nil? || @sequence.next_val == 0)
      @sequence.next_val = 10000
    end

    @sequence.save

    @sequence
  end

  def getSeq(seq_name)
    @seq_name = seq_name
    @sequencef = Sequence.find_by(name: @seq_name)

    if(@sequencef.nil?)
      @sequencef = Sequence.new
      @sequencef.name = @seq_name
      @sequencef = createSeq @sequencef
    end

    @sequencef.next_val = (@sequencef.next_val + 1);
    @sequencef.save
    @sequencef.prefix+@sequencef.next_val.to_s+@sequencef.suffix
  end

end