function [power] = calculatePower(sig_ext, sig_inh, amp_ext, amp_inh)
    power = (sig_ext * amp_ext) / (sig_inh * amp_inh);
end