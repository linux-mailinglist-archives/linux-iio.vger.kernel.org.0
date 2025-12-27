Return-Path: <linux-iio+bounces-27374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8F9CDFF9F
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 17:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB12130262A7
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 16:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC731314B73;
	Sat, 27 Dec 2025 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2LZ14gm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75E2367AC;
	Sat, 27 Dec 2025 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766854320; cv=none; b=LaZ/1RG30DnxFDrCbaY5aqUs2w6N90DfkRy0LA/HP9s/UAfEmuzzonuk/TskjONv5S+qoTV7OIa7j1/WSGX+AJMXkhWdp0TuugwIPFD7oOXMqIGZbWHEJ7vi32nSLDgW8MxdMfdfFtdWAyxsoyw/UByF2sf8+uYKQiOnYLeolAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766854320; c=relaxed/simple;
	bh=c0JcVoTQxAAAJ5t95wAYByPRVM9xZpuZPeaGOYypuhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbSN/VCY3iY0TbzQCpr+7x1IyKVn70es0/AVyQBeXV1nATRYjEWpwBfefbAesLFN7DHWqCJWHjIzbj7+IrKtBuU7wSHdl+KikV8s8sIzNqEDoNBGQ7O1MPQFjdmVY6MmgZJZX9UYp0JsW5P8O/Gs+MypLFSNsqtOcHuhVJ/LJiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2LZ14gm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAE6C4CEF1;
	Sat, 27 Dec 2025 16:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766854320;
	bh=c0JcVoTQxAAAJ5t95wAYByPRVM9xZpuZPeaGOYypuhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s2LZ14gmWcuC1YynRWv5MLy8csxKbUkmULvUYsGGAHp5/pPuLy8Ns3RZgl0C/+vNg
	 yTsZXWZbN635POnhJP1fVpy+YT9JzKtQS6eEoxiUn61vG57UCeQPloDFMp532BM4cL
	 z18PG08KSddEYEKGmHiecyeUZ1felXtum3YK6WMOPIRsVN5fclz1sDHmAeG++xoNAB
	 53hPM3nHJOrDhNIiECHNfgl473VrlCBEKvkCKUTzczqnXPliy7TCBcO7/j7YvRszw0
	 w5s9M4bl6KoSb/9/N5pqkx17PtbrqsrYSveWumsOfIdQ3E0ZI5YXnNxJniQg56JTyQ
	 DvS693ZWB9yxw==
Date: Sat, 27 Dec 2025 16:51:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 1/6] dt-bindings: iio: frequency: add adf41513
Message-ID: <20251227165149.2e4c4751@jic23-huawei>
In-Reply-To: <2tpnfgcrr4k27ghdz4ciwkoekf3gof4l4rnp5xr7ukxi37ouls@c33ey3kytevc>
References: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
	<20251219-adf41513-iio-driver-v2-1-be29a83d5793@analog.com>
	<20251221165928.324db536@jic23-huawei>
	<2tpnfgcrr4k27ghdz4ciwkoekf3gof4l4rnp5xr7ukxi37ouls@c33ey3kytevc>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Dec 2025 19:45:11 +0000
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> Hi Jonathan, thanks for your time.
> 
> On 25/12/21 04:59PM, Jonathan Cameron wrote:
> > On Fri, 19 Dec 2025 12:34:48 +0000
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >   
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > dt-bindings for ADF41513, an ultralow noise PLL frequency synthesizer that
> > > can be used to implement local oscillators (LOs) as high as 26.5 GHz.
> > > Most properties refer to existing PLL driver properties (e.g. ADF4350).  
> > 
> > "Refer" implies a cross reference in this document.   Based upon is probably a better
> > way to put this.
> > 
> > Otherwise I've mostly commented on properties that to me don't sound like
> > they belong in the dt-binding as they are policy things that we want
> > to make runtime configurable.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > 
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > ---
> > >  .../bindings/iio/frequency/adi,adf41513.yaml       | 246 +++++++++++++++++++++
> > >  MAINTAINERS                                        |   7 +
> > >  2 files changed, 253 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
> > > new file mode 100644
> > > index 000000000000..01ceb2a7d21b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
> > > @@ -0,0 +1,246 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/frequency/adi,adf41513.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices ADF41513 PLL Frequency Synthesizer
> > > +
> > > +maintainers:
> > > +  - Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > +
> > > +description:
> > > +  The ADF41513 is an ultralow noise frequency synthesizer that can be used to
> > > +  implement local oscillators (LOs) as high as 26.5 GHz in the upconversion and
> > > +  downconversion sections of wireless receivers and transmitters. The ADF41510
> > > +  supports frequencies up to 10 GHz.
> > > +
> > > +  https://www.analog.com/en/products/adf41513.html
> > > +  https://www.analog.com/en/products/adf41510.html
> > > +
> > > +$ref: /schemas/spi/spi-peripheral-props.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,adf41510
> > > +      - adi,adf41513
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  spi-max-frequency:
> > > +    maximum: 25000000
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +    description: Clock that provides the reference input frequency.
> > > +
> > > +  avdd1-supply:
> > > +    description: PFD and Up and Down Digital Driver Power Supply (3.3 V)
> > > +
> > > +  avdd2-supply:
> > > +    description: RF Buffer and Prescaler Power Supply (3.3 V)
> > > +
> > > +  avdd3-supply:
> > > +    description: N Divider Power Supply (3.3 V)
> > > +
> > > +  avdd4-supply:
> > > +    description: R Divider and Lock Detector Power Supply (3.3 V)
> > > +
> > > +  avdd5-supply:
> > > +    description: Sigma-Delta Modulator and SPI Power Supply (3.3 V)
> > > +
> > > +  vp-supply:
> > > +    description: Charge Pump Power Supply (3.3 V)
> > > +
> > > +  enable-gpios:
> > > +    description:
> > > +      GPIO that controls the chip enable pin. A logic low on this pin
> > > +      powers down the device and puts the charge pump output into
> > > +      three-state mode.
> > > +    maxItems: 1
> > > +
> > > +  lock-detect-gpios:
> > > +    description:
> > > +      GPIO for lock detect functionality. When configured for digital lock
> > > +      detect, this pin will output a logic high when the PLL is locked.  
> > 
> > This seems to be one potential use of the muxout pin.  So to me feels like
> > a policy decision that belongs with the driver or userspace, not in dt.
> > mux-out-gpios:
> > would make more sense to me.
> > Some of the potential settings probably don't make sense but then we just
> > don't support those in the driver if this is connected to a gpio.  
>  
> Actually, there is the DLD pin (separate pin from muxout) dedicated for lock detection.

Ah. I'd missed that.  I can't figure out why it is also routed
to the muxout and whether that signal is the same.  Ah well, doesn't
matter with this one being the DLD pin.

> 
> > > +    maxItems: 1
> > > +
> > > +  adi,power-up-frequency:
> > > +    $ref: /schemas/types.yaml#/definitions/uint64
> > > +    minimum: 1000000000
> > > +    maximum: 26500000000
> > > +    default: 10000000000
> > > +    description:
> > > +      The PLL tunes to this frequency (in Hz) during the initialization
> > > +      sequence. This property should be set to a frequency supported by the
> > > +      loop filter and VCO used in the design. Range is 1 GHz to 26.5 GHz for
> > > +      ADF41513, and 1 GHz to 10 GHz for ADF41510.  
> > 
> > Why is this in DT?  Feels like this should be done by userspace control
> > prior to setting an enable rather than being in DT.  
> 
> The initialization sequence of the PLL requires the write of all the registers.
> This property exist so that meaningful values are written at start up.
> Here it is desired to have a frequency value that is within the range supported
> by the loop-filter and the external VCO.  
>  
> > > +
> > > +  adi,reference-div-factor:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    minimum: 1
> > > +    maximum: 32
> > > +    default: 1
> > > +    description:
> > > +      Value for the reference division factor (R Counter). The driver will
> > > +      increment R Counter as needed to achieve a PFD frequency within the
> > > +      allowed range. High R counter values will reduce the PFD frequency, which
> > > +      lowers the frequency resolution, and affects phase noise performance.  
> > 
> > Why is this in DT?  Is there not a 'best' choice to be made given a particular
> > input frequency and desired output frequency?  
> 
> When designing the external circuitry to the PLL, customers often refers to
> https://www.analog.com/en/lp/resources/adisimpll.html
> which is a piece of software that assists the choice of some parts and
> simulates performance metrics. After having the suggested design simulated,
> it turns out that the reference signal path defines the output frequency
> of the Phase-Frequency Detector (PFD), which is set as a constraint for
> the loop-filter design. Therefore, those properties (reference-div-factor,
> reference-doubler-enable and reference-div2-enable) are meant to reflect
> a hardware constraint for a PFD frequency value expected by the loop-filter/VCO

Makes sense.  Thanks for the details.  Perhaps add a little more on this
to the binding description to make it clear these are design time thing.

> 
> > > +
> > > +  adi,reference-doubler-enable:
> > > +    description:
> > > +      Enables the reference doubler. The maximum reference frequency when
> > > +      the doubler is enabled is 225 MHz.  
> > As above.  
> 
> explained above as part of a hardware constraint for external circuitry design
> 
> > > +    type: boolean
> > > +
> > > +  adi,reference-div2-enable:
> > > +    description:
> > > +      Enables the reference divide-by-2 function. This provides a 50%
> > > +      duty cycle signal to the PFD.  
> > As above.  
> 
> same
> 
> > > +    type: boolean
> > > +
> > > +  adi,charge-pump-resistor-ohms:
> > > +    minimum: 1800
> > > +    maximum: 10000
> > > +    default: 2700
> > > +    description:
> > > +      External charge pump resistor (R_SET) value in ohms. This sets the maximum
> > > +      charge pump current along with the charge pump current setting.
> > > +
> > > +  adi,charge-pump-current-microamp:
> > > +    description:
> > > +      Charge pump current (I_CP) in microamps. The value will be rounded to the
> > > +      nearest supported value. Range of acceptable values depends on the
> > > +      charge pump resistor value, such that 810 mV <= I_CP * R_SET <= 12960 mV.
> > > +      This value depends on the loop filter design.
> > > +
> > > +  adi,muxout-select:
> > > +    description:
> > > +      On chip multiplexer output selection.
> > > +      high_z - MUXOUT Pin set to high-Z. (default)
> > > +      muxout_high - MUXOUT Pin set to high.
> > > +      muxout_low - MUXOUT Pin set to low.
> > > +      f_div_rclk - MUXOUT Pin set to R divider output
> > > +      f_div_nclk - MUXOUT Pin set to N divider output
> > > +      lock_detect - MUXOUT Pin set to Digital lock detect
> > > +      serial_data - MUXOUT Pin set to Serial data output
> > > +      readback - MUXOUT Pin set to Readback mode
> > > +      f_div_clk1 - MUXOUT Pin set to CLK1 divider output
> > > +      f_div_rclk_2 - MUXOUT Pin set to R divider/2 output
> > > +      f_div_nclk_2 - MUXOUT Pin set to N divider/2 output
> > > +    enum: [high_z, muxout_high, muxout_low, f_div_rclk, f_div_nclk, lock_detect,
> > > +           serial_data, readback, f_div_clk1, f_div_rclk_2, f_div_nclk_2]  
> > 
> > This needs explanation of 'why' it should be in DT?  To me it seems mostly
> > to be a debug feature that should be controlled perhaps via a debugfs interface.  
> 
> There has been a discussion on that, and I understand the concerns.
> Altough it looks like a debug pin, I suppose some board designs might
> expect the muxout pin to be working as a specific function.
> The device driver provides register access through the debugfs interface,
> so worst case, the muxout select value could be changed there.

I'd like to know if there are known to be such designs in the wild before
supporting this in DT.  It feels very speculative.  The nature of the many
way mux makes me think it's pretty unlikely that the intent is to use
this as an input to external circuitry.

> 
> > > +
> > > +  adi,muxout-level-1v8-enable:
> > > +    description:
> > > +      Set MUXOUT and DLD logic levels to 1.8V. Default is 3.3V.
> > > +    type: boolean
> > > +
> > > +  adi,phase-detector-polarity-positive-enable:
> > > +    description:
> > > +      Set phase detector polarity to positive. Default is negative.
> > > +      Use positive polarity with non-inverting loop filter and VCO with
> > > +      positive tuning slope, or with inverting loop filter and VCO with
> > > +      negative tuning slope.
> > > +    type: boolean
> > > +
> > > +  adi,lock-detector-count:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    default: 64
> > > +    description:
> > > +      Sets the value for Lock Detector count of the PLL, which determines the
> > > +      number of consecutive phase detector cycles that must be within the lock
> > > +      detector window before lock is declared. Lower values increase the lock
> > > +      detection sensitivity.
> > > +    enum: [2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192]  
> > 
> > Sounds like policy.  Maybe it is related to the circuit design and there
> > is a right choice for  particular board? If not we should figure out how to leave
> > this to userspace control.  Probably as some form of event property.  
> 
> There was also a internal discussion around that. I'd say that this might
> be related to the application where the design is being used. There should
> be value on making it configurable at runtime, mostly for tunning for
> specific needs, but this is not a value to be changed at runtime in
> field-deployed products.

Add something about detection of lock being something that is dependent on
external circuitry and so there is an optimal value to put here that is
expected to be fixed.

Thanks,

Jonathan

> 
> kind regards,
> 
> Rodrigo Alencar
> 


