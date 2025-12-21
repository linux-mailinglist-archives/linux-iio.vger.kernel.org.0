Return-Path: <linux-iio+bounces-27300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8159CD4511
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 20:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F1FB300D41E
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1896F3090D7;
	Sun, 21 Dec 2025 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiXbbWx4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F9239570
	for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766346324; cv=none; b=qXl9UAkU5A7TAt6VtDqSm81HRsA7COabpJKqffXrRzs+oXyj9XkJaaSpXQ+bQ3ojM7qLd/IqSG2deyQarnhWniBtL/QNzQZAawJGowbNGXvyHekst87rKh1naF/+l/a3uLTiFKoSuJ5QlJvblTd9noc+TDVp9E/RkIlHJdnopMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766346324; c=relaxed/simple;
	bh=cSTfWtKPoKhckOr3jRJj3j0TxOGe28VrRa/l9N3NMqw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLYf/jkTGi9CeJMdqbStvnvlJi00/WXTkVtYt7fzgXQg965pvQszcshff8xXeCqNGFcA77VEZOoc874bxk5wWTuHO9ojxOv+1KT+/aRNA9w5/Lh0iz+0lj5xv2CTeUV0YaPgf4izTyHUPr7Z2w5+7clho9DKdAsrbCOAW4N6hn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiXbbWx4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso22818535e9.2
        for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 11:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766346321; x=1766951121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iTecQnEOiM4cqOp9HNhUH1paLZE1WIZf/qWmCV1hARc=;
        b=aiXbbWx4JAxuuenNxxGmwCK9I8wnpWsE1uKCotfZEiKsxJyf2c6psPkMa2gwWP8pbN
         GWdmM9wbY2LmqIXtMGfCc9gVllEjNNF+UPb0xT9Pb5DPvyjp/dELdw+yPpZf081LznlA
         xyyplTa+ziAT6++NznzWc9S3b2tf+vGHxwgXf/VcfiDjgCBFbK7stMHvGjLRKxGzKS6/
         ifvmHqelQ17NMry3RmtBqn6k2fkzr4dHPo14KRvT/cjl6PLsnYHQr0AIQXhTBEayPsfL
         wAATmITRBCMTZ7igRGwZDLnm8ROg7zxXoUdRXOz86IGuHtPV2iuA7T/PJGfVgB2vqvw/
         QwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766346321; x=1766951121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTecQnEOiM4cqOp9HNhUH1paLZE1WIZf/qWmCV1hARc=;
        b=ls/txPUyoe1GkzW0LUhMgEhBU4GgOBNpCjELaRFGV9Ev5GEjo45qnX9aHCxUsWPHKn
         m6aOn3Ia1OD3SWcnmsiYDlSRFoqRK1rXTTreTmRvdGpyNJIM5VXQritb13v5vt6mTAk1
         7pgyTxqRfxzFARBuXDGg+pAXC6VrEz4EaqxsEXi3BZ1AkqOgg/T/xRCzCnNWNTMsc7CC
         SBaM09TZUJOWhZmPH4W7uoQpvI2b41bdL4aUUCgWRut2wSIeFtvzGvR0R7sTQlF3Vvhq
         //9pMFdKF+KgIOpgm03dIf5ty8IRKzECTnze8t8JSy1njcxH05WKoUK+RfJrMe1Bv4Fo
         B16w==
X-Forwarded-Encrypted: i=1; AJvYcCW6CxFrNbHB+xCfVZCf6IO4YrFfH2PhfyxQ5pk7R5+OqwbKOEaAzroUYjpYIJehEBPDx06JzClagoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNj1503kBdCCvYS4MmfSjJ3yCSjp2G0E0DilKSs6LxrqWqm8pZ
	rTruaXIPGL7TzEge6CmSJCMUxH9ukB31WYyUv+8wydyZQnui87aTqKVRTq8jOw==
X-Gm-Gg: AY/fxX7O0Sw/9kjdHzPA6RDG3lotNp0YhMlAlJQYyKTOdeyeV282bjpEzUVJKeFZ4wM
	DIkMJOAsmj7m71sEgMP1VNd9Jk+1e3FhuPriR/z36F1IhZZpV4yl5KVaJlXl3EHA2UsWxRkLdC5
	MFFOuUtb5XxgiF0QdCDsOEj+qwQfcKAYTlyHCyaof5ZDav8ej6yv840G8yuqO26KGw4bEErFra/
	Fvdc4cxFOak9wjvluRYhpTQoQ2wQrriiua7tb4Xlaa72dr9yRFaFQdoCtrHs7at2OrkbTebCEYg
	dzgj7agCHaemknmvDqzviaRukPVrNR+/GCaow5MBwoLc0pJ25f32J/bzPeKvxhwLY6EHmWzB9c0
	y0KC71d4siV+PMibuJENlXa1uqmq/uBEWSy5NkvcpKu3I/ZR5VSCkyVoCfYtAZLltVyz1iTTXtE
	/62NgV3lBKpkNIaYYXJN12mM3A3JAkS34vv/1mJL+gYNnTjpllvA6Dhy1n+0Rz+3if2qcKVPwqC
	qKM
X-Google-Smtp-Source: AGHT+IFTts7ykm/dTtNEBPERRiikHRCeJkCXmDKtdntcwtIRm4AZRPX9IX3X0hecxYJbCjN/4/xU4Q==
X-Received: by 2002:a05:600c:4e8f:b0:479:3a89:121d with SMTP id 5b1f17b1804b1-47d1959c74fmr90402945e9.36.1766346320235;
        Sun, 21 Dec 2025 11:45:20 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19346dfcsm185559065e9.1.2025.12.21.11.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 11:45:19 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 21 Dec 2025 19:45:11 +0000
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 1/6] dt-bindings: iio: frequency: add adf41513
Message-ID: <2tpnfgcrr4k27ghdz4ciwkoekf3gof4l4rnp5xr7ukxi37ouls@c33ey3kytevc>
References: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
 <20251219-adf41513-iio-driver-v2-1-be29a83d5793@analog.com>
 <20251221165928.324db536@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221165928.324db536@jic23-huawei>


Hi Jonathan, thanks for your time.

On 25/12/21 04:59PM, Jonathan Cameron wrote:
> On Fri, 19 Dec 2025 12:34:48 +0000
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > dt-bindings for ADF41513, an ultralow noise PLL frequency synthesizer that
> > can be used to implement local oscillators (LOs) as high as 26.5 GHz.
> > Most properties refer to existing PLL driver properties (e.g. ADF4350).
> 
> "Refer" implies a cross reference in this document.   Based upon is probably a better
> way to put this.
> 
> Otherwise I've mostly commented on properties that to me don't sound like
> they belong in the dt-binding as they are policy things that we want
> to make runtime configurable.
> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > ---
> >  .../bindings/iio/frequency/adi,adf41513.yaml       | 246 +++++++++++++++++++++
> >  MAINTAINERS                                        |   7 +
> >  2 files changed, 253 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
> > new file mode 100644
> > index 000000000000..01ceb2a7d21b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
> > @@ -0,0 +1,246 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/frequency/adi,adf41513.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices ADF41513 PLL Frequency Synthesizer
> > +
> > +maintainers:
> > +  - Rodrigo Alencar <rodrigo.alencar@analog.com>
> > +
> > +description:
> > +  The ADF41513 is an ultralow noise frequency synthesizer that can be used to
> > +  implement local oscillators (LOs) as high as 26.5 GHz in the upconversion and
> > +  downconversion sections of wireless receivers and transmitters. The ADF41510
> > +  supports frequencies up to 10 GHz.
> > +
> > +  https://www.analog.com/en/products/adf41513.html
> > +  https://www.analog.com/en/products/adf41510.html
> > +
> > +$ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,adf41510
> > +      - adi,adf41513
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 25000000
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description: Clock that provides the reference input frequency.
> > +
> > +  avdd1-supply:
> > +    description: PFD and Up and Down Digital Driver Power Supply (3.3 V)
> > +
> > +  avdd2-supply:
> > +    description: RF Buffer and Prescaler Power Supply (3.3 V)
> > +
> > +  avdd3-supply:
> > +    description: N Divider Power Supply (3.3 V)
> > +
> > +  avdd4-supply:
> > +    description: R Divider and Lock Detector Power Supply (3.3 V)
> > +
> > +  avdd5-supply:
> > +    description: Sigma-Delta Modulator and SPI Power Supply (3.3 V)
> > +
> > +  vp-supply:
> > +    description: Charge Pump Power Supply (3.3 V)
> > +
> > +  enable-gpios:
> > +    description:
> > +      GPIO that controls the chip enable pin. A logic low on this pin
> > +      powers down the device and puts the charge pump output into
> > +      three-state mode.
> > +    maxItems: 1
> > +
> > +  lock-detect-gpios:
> > +    description:
> > +      GPIO for lock detect functionality. When configured for digital lock
> > +      detect, this pin will output a logic high when the PLL is locked.
> 
> This seems to be one potential use of the muxout pin.  So to me feels like
> a policy decision that belongs with the driver or userspace, not in dt.
> mux-out-gpios:
> would make more sense to me.
> Some of the potential settings probably don't make sense but then we just
> don't support those in the driver if this is connected to a gpio.
 
Actually, there is the DLD pin (separate pin from muxout) dedicated for lock detection.

> > +    maxItems: 1
> > +
> > +  adi,power-up-frequency:
> > +    $ref: /schemas/types.yaml#/definitions/uint64
> > +    minimum: 1000000000
> > +    maximum: 26500000000
> > +    default: 10000000000
> > +    description:
> > +      The PLL tunes to this frequency (in Hz) during the initialization
> > +      sequence. This property should be set to a frequency supported by the
> > +      loop filter and VCO used in the design. Range is 1 GHz to 26.5 GHz for
> > +      ADF41513, and 1 GHz to 10 GHz for ADF41510.
> 
> Why is this in DT?  Feels like this should be done by userspace control
> prior to setting an enable rather than being in DT.

The initialization sequence of the PLL requires the write of all the registers.
This property exist so that meaningful values are written at start up.
Here it is desired to have a frequency value that is within the range supported
by the loop-filter and the external VCO.  
 
> > +
> > +  adi,reference-div-factor:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 1
> > +    maximum: 32
> > +    default: 1
> > +    description:
> > +      Value for the reference division factor (R Counter). The driver will
> > +      increment R Counter as needed to achieve a PFD frequency within the
> > +      allowed range. High R counter values will reduce the PFD frequency, which
> > +      lowers the frequency resolution, and affects phase noise performance.
> 
> Why is this in DT?  Is there not a 'best' choice to be made given a particular
> input frequency and desired output frequency?

When designing the external circuitry to the PLL, customers often refers to
https://www.analog.com/en/lp/resources/adisimpll.html
which is a piece of software that assists the choice of some parts and
simulates performance metrics. After having the suggested design simulated,
it turns out that the reference signal path defines the output frequency
of the Phase-Frequency Detector (PFD), which is set as a constraint for
the loop-filter design. Therefore, those properties (reference-div-factor,
reference-doubler-enable and reference-div2-enable) are meant to reflect
a hardware constraint for a PFD frequency value expected by the loop-filter/VCO

> > +
> > +  adi,reference-doubler-enable:
> > +    description:
> > +      Enables the reference doubler. The maximum reference frequency when
> > +      the doubler is enabled is 225 MHz.
> As above.

explained above as part of a hardware constraint for external circuitry design

> > +    type: boolean
> > +
> > +  adi,reference-div2-enable:
> > +    description:
> > +      Enables the reference divide-by-2 function. This provides a 50%
> > +      duty cycle signal to the PFD.
> As above.

same

> > +    type: boolean
> > +
> > +  adi,charge-pump-resistor-ohms:
> > +    minimum: 1800
> > +    maximum: 10000
> > +    default: 2700
> > +    description:
> > +      External charge pump resistor (R_SET) value in ohms. This sets the maximum
> > +      charge pump current along with the charge pump current setting.
> > +
> > +  adi,charge-pump-current-microamp:
> > +    description:
> > +      Charge pump current (I_CP) in microamps. The value will be rounded to the
> > +      nearest supported value. Range of acceptable values depends on the
> > +      charge pump resistor value, such that 810 mV <= I_CP * R_SET <= 12960 mV.
> > +      This value depends on the loop filter design.
> > +
> > +  adi,muxout-select:
> > +    description:
> > +      On chip multiplexer output selection.
> > +      high_z - MUXOUT Pin set to high-Z. (default)
> > +      muxout_high - MUXOUT Pin set to high.
> > +      muxout_low - MUXOUT Pin set to low.
> > +      f_div_rclk - MUXOUT Pin set to R divider output
> > +      f_div_nclk - MUXOUT Pin set to N divider output
> > +      lock_detect - MUXOUT Pin set to Digital lock detect
> > +      serial_data - MUXOUT Pin set to Serial data output
> > +      readback - MUXOUT Pin set to Readback mode
> > +      f_div_clk1 - MUXOUT Pin set to CLK1 divider output
> > +      f_div_rclk_2 - MUXOUT Pin set to R divider/2 output
> > +      f_div_nclk_2 - MUXOUT Pin set to N divider/2 output
> > +    enum: [high_z, muxout_high, muxout_low, f_div_rclk, f_div_nclk, lock_detect,
> > +           serial_data, readback, f_div_clk1, f_div_rclk_2, f_div_nclk_2]
> 
> This needs explanation of 'why' it should be in DT?  To me it seems mostly
> to be a debug feature that should be controlled perhaps via a debugfs interface.

There has been a discussion on that, and I understand the concerns.
Altough it looks like a debug pin, I suppose some board designs might
expect the muxout pin to be working as a specific function.
The device driver provides register access through the debugfs interface,
so worst case, the muxout select value could be changed there.

> > +
> > +  adi,muxout-level-1v8-enable:
> > +    description:
> > +      Set MUXOUT and DLD logic levels to 1.8V. Default is 3.3V.
> > +    type: boolean
> > +
> > +  adi,phase-detector-polarity-positive-enable:
> > +    description:
> > +      Set phase detector polarity to positive. Default is negative.
> > +      Use positive polarity with non-inverting loop filter and VCO with
> > +      positive tuning slope, or with inverting loop filter and VCO with
> > +      negative tuning slope.
> > +    type: boolean
> > +
> > +  adi,lock-detector-count:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 64
> > +    description:
> > +      Sets the value for Lock Detector count of the PLL, which determines the
> > +      number of consecutive phase detector cycles that must be within the lock
> > +      detector window before lock is declared. Lower values increase the lock
> > +      detection sensitivity.
> > +    enum: [2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192]
> 
> Sounds like policy.  Maybe it is related to the circuit design and there
> is a right choice for  particular board? If not we should figure out how to leave
> this to userspace control.  Probably as some form of event property.

There was also a internal discussion around that. I'd say that this might
be related to the application where the design is being used. There should
be value on making it configurable at runtime, mostly for tunning for
specific needs, but this is not a value to be changed at runtime in
field-deployed products.

kind regards,

Rodrigo Alencar

