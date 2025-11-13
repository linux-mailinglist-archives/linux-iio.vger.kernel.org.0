Return-Path: <linux-iio+bounces-26194-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE502C579ED
	for <lists+linux-iio@lfdr.de>; Thu, 13 Nov 2025 14:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31ABF3552D4
	for <lists+linux-iio@lfdr.de>; Thu, 13 Nov 2025 13:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C475E351FC1;
	Thu, 13 Nov 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQQN8ukn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D390351FA7
	for <linux-iio@vger.kernel.org>; Thu, 13 Nov 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040029; cv=none; b=k+ey4BH6xCVh4lArip6ZYUWe/8lYHx5E1MGN47pK4GnKVvl0HcY+G3jY/0LHrB+vEUkElQuWbEyLTLCjuI6hI/O+MOSEWTSlnv1JEmItxgWR/M85htgfndENrqPkf75Z2e6GwhnVMTsFGaZCxqTs/xdICZclSfMcCwrxLVocMX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040029; c=relaxed/simple;
	bh=CWufZ3aWICevbswGJdfZFHdWkmCHzWxSngqMWXLAGNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnwPbSRW1BiHsJaVy52/gzC5Pn0kjS3EFFw9zmyG0L/wOyJ8g5u9h53ZjScU8hZRktxo61+7gb3ZpA7Xwbu9sVDmB91W5K8DEykOVBMoJsP4UPMct3GwnXzLDVW4Xz9nLOC5GaHSsFhoLPw46H8Ciyp288in64srL7BXP0j2zns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQQN8ukn; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ba599137cf7so703316a12.0
        for <linux-iio@vger.kernel.org>; Thu, 13 Nov 2025 05:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763040026; x=1763644826; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mR9RWIL7H8zmL2WU5RCX+NFeC7ROJ5E1DQWYfodq40c=;
        b=JQQN8ukne1tUxo5fkFN5UsAYrxG2FuozHekS+axMBKtoOu8Ges1sBc51mj6Bqckoi6
         UJGW5xqwZd09sCSDdbWeGD64we6323sZ5htbdCk1raeP8joDNPMj75aWTUYYCNQEPHss
         pNvTl64f5niamnPN+x9Plzv8fFk+qt0pF35O5aCG0ozRb+z6pGHOmJ1LRUzcjA69moQ+
         q9kA3MmFNi/bLGSYY+EPQJn52xqk7keZY1EZaSTzyJBXzjA+UDEzhjkU/EN5u2Za+FUD
         Pxms6uNOMMiATWkCAFaq2jWq4KiQiVbPqOkRr3CY0KztMYqBY88P2Of2ceJ2GHkeIjfj
         OJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040026; x=1763644826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mR9RWIL7H8zmL2WU5RCX+NFeC7ROJ5E1DQWYfodq40c=;
        b=kngkEnqPkxrAHtnSwRX3asi2MBz7CKk2iOqF5lry3J38gF2/Pj4LCuuh7GNnEreu+w
         kPxJm1JxPnBVA0eU5MOVYDiFwDq0DtlSx0RxwCxW9u7AQOh6vSE8ku9FijHXW1ge3P7k
         SfhmWBA1Lt3oHtKa6EGxEoeeH4dr5bpvyzenrTsfjw0IT7t67oFArgmCeloElSgUoeoR
         9NRjf1J42aUHrYlgEqKSOqXHg9Q77hly0a/YzN4zzjCCRfFGuYqzfN+JWSQFr1IWeIoL
         scEXfheQQFYJEmcAXyt2D9UW71xrycPzQkzugiRkMht0GHfG4qTS5tEH+qhptr7occQ4
         DGOg==
X-Forwarded-Encrypted: i=1; AJvYcCX2QgCg/sVSx8IhE0PEWl/WnRmeTcguE+rL1rrFzbmtoD8UyZ2QFJMW3jsold77aTbTzB/vGGP+2fo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+lpq04lLirAr4cYA6SdJ4sLgL3JYu0fE4LN7QxxZCVRR1axg0
	sn8xEaLWz1PfPRYmA52aMeY/w8a5LJSMO0xmkT/ddFWn9+GVHY3fSEFk
X-Gm-Gg: ASbGnctr6sG2L4QxyWrA2CEKsOh2Qjm8nVpw9PaJSMMCbKFElbx7/J6JdcvUZtogU+I
	EnVc0rpyYBcXMItybqdry97GXQL4amXuMK0lBDx9ppsSwEwzvnxFMHb+WlhNKFZ8Pfnaqlh2zl1
	JfKxyFuzfTAOtA2VUEmxsJAOaX/HNRzj5kL9ccMa2feGgSQFg9P5w/g9+6OXdHDLQRamWFExHZL
	aHfm3mePQB54s+js+Jadler1GDlcmLgmuM5XzNAyoZ8FBDN/hC4ntO3cDayivm9wCvJVxQKSywY
	qznvi9445MEahOzNOUnV5ePN6a/7UACSwxi7tLkNtwwnEP2PLV82yJiHj8Yz+w+sPdkLP4k1rdn
	kaPeKOLVLxkp7chk/JfPfWRrrPGbS0yNfs8pxaxOosD9znEvheb7DDjrhM/KMnYpjTsbAanVYPK
	PPnFu5oj+tEA==
X-Google-Smtp-Source: AGHT+IFL27X63nvi0VP0wYBacQeGW9sANAuXPW2TawVdUInxz68hcU4j60ThwM3hzBhLfP46DW8t8g==
X-Received: by 2002:a17:902:f610:b0:295:395c:ebf9 with SMTP id d9443c01a7336-2984ee2960cmr79762635ad.55.1763040026180;
        Thu, 13 Nov 2025 05:20:26 -0800 (PST)
Received: from localhost ([2804:30c:1661:8a00:578a:911c:ac25:24a6])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2985c2bed39sm26108565ad.77.2025.11.13.05.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 05:20:25 -0800 (PST)
Date: Thu, 13 Nov 2025 10:21:44 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/3] dt-bindings: iio: frequency: add adf41513
Message-ID: <aRXbaMGbxdbwgUhi@debian-BULLSEYE-live-builder-AMD64>
References: <20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com>
 <20251110-adf41513-iio-driver-v1-2-2df8be0fdc6e@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251110-adf41513-iio-driver-v1-2-2df8be0fdc6e@analog.com>

Hi Rodrigo,

Many comments inline in addition to what Krzysztof has already mentioned.

On 11/10, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> ultralow noise PLL frequency synthesizer that can be used to
> implement local oscillators (LOs) as high as 26.5 GHz
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  .../bindings/iio/frequency/adi,adf41513.yaml       | 268 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 269 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
> new file mode 100644
> index 000000000000..7e1ad80d68af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
> @@ -0,0 +1,268 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,adf41513.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADF41513 PLL Frequency Synthesizer
> +
> +maintainers:
> +  - Rodrigo Alencar <rodrigo.alencar@analog.com>
> +
> +description:
> +  The ADF41513 is an ultralow noise frequency synthesizer that can be used to
> +  implement local oscillators (LOs) as high as 26.5 GHz in the upconversion and
> +  downconversion sections of wireless receivers and transmitters. The ADF41510
> +  supports frequencies up to 10 GHz.
> +
> +  https://www.analog.com/en/products/adf41513.html
> +  https://www.analog.com/en/products/adf41510.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adf41510
> +      - adi,adf41513
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 25000000
> +
> +  clocks:
> +    maxItems: 1
> +    description: Clock that provides the reference input frequency.
> +
> +  '#clock-cells':
> +    const: 0
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description: Power supply for the device (3.3V)
I see we can have AVDD1 == ... == AVDD5 == VP == 3.3V.
But we should document them all here in case somebody wants to use a separate
supply for any of those.

> +
> +  chip-enable-gpios:
> +    description:
> +      GPIO that controls the chip enable pin. A logic low on this pin
> +      powers down the device and puts the charge pump output into
> +      three-state mode.
> +    maxItems: 1
> +
> +  lock-detect-gpios:
> +    description:
> +      GPIO for lock detect functionality. When configured for digital lock
> +      detect, this pin will output a logic high when the PLL is locked.
> +    maxItems: 1
> +
> +  adi,power-up-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint64
> +    minimum: 1000000000
> +    maximum: 26500000000
> +    default: 10000000000
> +    description:
> +      The PLL tunes to this frequency (in Hz) on driver probe.
> +      Range is 1 GHz to 26.5 GHz for ADF41513, and 1 GHz to 10 GHz for ADF41510.
The PLL settings are also controllable at runtime and independent of hw
connections, right? Can't this be just a sw/driver default instead of a dt
property?

> +
> +  adi,reference-div-factor:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 32
> +    description:
> +      Reference division factor (R Counter). If not specified, the driver
> +      will calculate the optimal value automatically.
> +
> +  adi,reference-doubler-enable:
> +    description:
> +      Enables the reference doubler. The maximum reference frequency when
> +      the doubler is enabled is 225 MHz.
> +    type: boolean
This also seems like runtime configuration. At first glance, my feeling is that
it impacts the output frequency and thus should probably be somehow handled
in adf41513_write() IIO_CHAN_INFO_FREQUENCY case. By the way, if IIO_VAL_INT_64
format allows setting the frequency resolution in sub-Hz (see comment in driver file),
then I also suggest to use usual IIO _raw interfaces, e.g.

static const struct iio_info adf41513_info = {
  .write_raw = adf41513_write(),
	.write_raw_get_fmt = adf41513_write_raw_get_fmt(),
	.debugfs_reg_access = &adf41513_reg_access,
};

> +
> +  adi,reference-div2-enable:
> +    description:
> +      Enables the reference divide-by-2 function. This provides a 50%
> +      duty cycle signal to the PFD.
> +    type: boolean
This one also seems to be associated with output frequency and runtime
configurable, no?

> +
> +  adi,charge-pump-current-microamp:
> +    minimum: 450
> +    maximum: 7200
> +    default: 2400
> +    description:
> +      Charge pump current in microamps. The value will be rounded to the
> +      nearest supported value.
> +
> +  adi,charge-pump-resistor-ohms:
> +    minimum: 1800
> +    maximum: 10000
> +    default: 2700
> +    description:
> +      External charge pump resistor value in ohms. This sets the maximum
> +      charge pump current along with the charge pump current setting.

hmm these charge-pump props seem a bit tricky. IIUC, the achievable charge pump
output currents depend on the charge pump resistor value and the cp output
current would be something that a user would latter want to fine tune at
runtime. I'd keep adi,charge-pump-resistor-ohms only, pick a default for the
pump current, then provide an IIO attribute to allow tweaking the charge pump
current for fine tuning the loop filter frequency response. This might need
a new IIO ABI.

> +
> +  adi,muxout-select:
> +    description:
> +      On chip multiplexer output selection.
> +      high_z - MUXOUT Pin set to high-Z. (default)
> +      muxout_high - MUXOUT Pin set to high.
> +      muxout_low - MUXOUT Pin set to low.
> +      f_div_rclk - MUXOUT Pin set to R divider output
> +      f_div_nclk - MUXOUT Pin set to N divider output
> +      lock_detect - MUXOUT Pin set to Digital lock detect
> +      serial_data - MUXOUT Pin set to Serial data output
> +      readback - MUXOUT Pin set to Readback mode
> +      f_div_clk1 - MUXOUT Pin set to CLK1 divider output
> +      f_div_rclk_2 - MUXOUT Pin set to R divider/2 output
> +      f_div_nclk_2 - MUXOUT Pin set to N divider/2 output
> +    enum: [high_z, muxout_high, muxout_low, f_div_rclk, f_div_nclk, lock_detect,
> +           serial_data, readback, f_div_clk1, f_div_rclk_2, f_div_nclk_2]

I don't think this should be a dt property. The mux output can be controlled at
runtime by updating register 12. Also, if somebody sets, for example,
'muxout_high' here, then the user would not be able to set the mux output to
something else latter? Would not be able to output the configured RF output
frequency for the example?

> +
> +  adi,muxout-level-1v8-enable:
> +    description:
> +      Set MUXOUT and DLD logic levels to 1.8V. Default is 3.3V.
> +    type: boolean
> +
> +  adi,phase-detector-polarity-positive-enable:
> +    description:
> +      Set phase detector polarity to positive. Default is negative.
> +      Use positive polarity with non-inverting loop filter and VCO with
> +      positive tuning slope, or with inverting loop filter and VCO with
> +      negative tuning slope.
> +    type: boolean
> +
> +  adi,lock-detect-precision:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 3
> +    description:
> +      Lock detector precision setting. Controls the sensitivity of the
> +      lock detector. Lower values of precision increases the lock detector
> +      window size.
This sounds more like something that could be supported through an IIO device
attribute.

> +
> +  adi,lock-detect-count:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 7
> +    description: |
> +      Lock detector count setting (3-bit value). Determines the number of
> +      consecutive phase detector cycles that must be within the lock detector
> +      window before lock is declared. The count grows in powers of two of the
> +      programmed value:
> +      - if adi,fast-lock-enable is set count = 2 * 2^value
> +      - if adi,fast-lock-enable is not set count = 64 * 2^value
> +
> +  adi,lock-detect-bias-microamp:
> +    description:
> +      Lock detector bias current. Controls the lock detector window size
> +      along with the lock detector precision setting. Lower bias current
> +      increases the window size.
> +    enum: [10, 20, 30, 40]
> +
> +  adi,fast-lock-enable:
> +    description:
> +      Enable fast lock mode. This changes the lock detector clock selection
> +      for faster lock indication.
> +    type: boolean
adi,lock-detect-count, adi,lock-detect-bias-microamp, and adi,fast-lock-enable
also sound like they could be IIO device properties.

> +
> +  adi,phase-resync-enable:
> +    description:
> +      Enable phase resync functionality. This produces a consistent output
> +      phase offset with respect to the input reference.
> +    type: boolean
IIUC, this would work similarly to the description of out_altvoltageY_phase ABI,
except the phase would be relative to the reference clock instead of a second
output channel. New IIO ABI? Or, maybe, provide out_altvoltage0_frequency and
out_altvoltage1_frequency? One of the altvoltageY would be the frequency of
muxout while the other would be the frequency of the reference clock. Then phase
resync would be supported through out_altvoltageY_phase. Not sure if having
a "virtual" output channel would be misleading, though. Extending the
out_altvoltageY_phase ABI might be an alternative.

> +
> +  adi,12bit-clk-divider:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 4095
> +    description:
> +      CLK1 divider value used when adi,phase-resync-enable is set
> +
> +  adi,12bit-clk2-divider:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 4095
> +    description:
> +      CLK2 divider value used when adi,phase-resync-enable is set
CLK1 and CLK2 would be calculated by the driver according to the value set
through out_altvoltageY_phase (if the idea above makes sense). Then
adi,12bit-clk-divider and adi,12bit-clk2-divider would also not be needed.

> +
> +  adi,le-sync-enable:
> +    description:
> +      Synchronize the rising edge of LE on an SPI write with the falling
> +      edge of the reference signal to prevent glitches.
> +    type: boolean
> +
> +  adi,freq-resolution:
> +    $ref: /schemas/types.yaml#/definitions/uint64
> +    minimum: 1
> +    default: 1000000
> +    description:
> +      Initial frequency resolution in micro-Hz (µHz) for the algorithm to achieve.
> +      This influences the choice between fixed and variable modulus modes.
> +      Default is 1000000 µHz (1 Hz).
This one also looks like it could be a driver default instead of a dt prop.


Best regards,
Marcelo

