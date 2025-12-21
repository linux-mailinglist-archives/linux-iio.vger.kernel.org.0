Return-Path: <linux-iio+bounces-27275-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C53CD4326
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 17:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70359300819F
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 16:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F882F616B;
	Sun, 21 Dec 2025 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj15zKMK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7774221FB4;
	Sun, 21 Dec 2025 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766336378; cv=none; b=LkH0rUM03w1vZF78PGfHxWuqlz3Bh9ZbAylgrrgGdCCaG145xYwu8CZOCgQUZ014r+B9oDERS8k5uPOONLxRz3/B4csO+RVziJYLTYA4Kdtp0XdUyHd14WuFCX32zkckndbqz7lNo6UsEiNio3JLOJErCmLhtDbWXPC/l+sbE5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766336378; c=relaxed/simple;
	bh=r+2x0m0Sjhi76q2a8ISBmIMeXp9OsJ1rjjjuyh2yzaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8ceUMOIfGH7gzAlw1BxgyeWQRileQ3ZegcwJyuUKrLZPi5NK9InzcamcTlpm2WhGOvC/iN58Rz97dI5qzaIPMbBXOfa55J8cm7/9GFlox2fzWSOOrVw1LCGt9NPA0PmMXU+tLXudvgaDPgi1n3IgS1y7tmwqzwHyOOpHLQggdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj15zKMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EE5C4CEFB;
	Sun, 21 Dec 2025 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766336378;
	bh=r+2x0m0Sjhi76q2a8ISBmIMeXp9OsJ1rjjjuyh2yzaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fj15zKMKm4mzkUhek/GHKKpPTACpZFDD1qelSwxwsXNG1//kitLv02oRAmrnkC+1k
	 Pkz39rG+vaX1oaBvw9jeGgXBOKWylCvNsuJLi1H+IGifam9eF2C55FEK+sXwLII1x6
	 vMDzLAwkW6aBbSgjKaBUrgDae/FdWnW2o7TZS/Vs39zlrCQFvAMOyaXmOh64GAWtmi
	 Pgry6s72yQZHN4m/tJjd1nUxjzr3Qmc/JBAEB2/bDx4bxFL/3vy1ovfvEzlDS/CDV9
	 kyx7BiSwyHomwDEED3G3PwSThMILJFbChOmfXYXcfBbTHiC10VFK8p3pMij4OHsD3X
	 WVnAh0uqPhgog==
Date: Sun, 21 Dec 2025 16:59:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 1/6] dt-bindings: iio: frequency: add adf41513
Message-ID: <20251221165928.324db536@jic23-huawei>
In-Reply-To: <20251219-adf41513-iio-driver-v2-1-be29a83d5793@analog.com>
References: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
	<20251219-adf41513-iio-driver-v2-1-be29a83d5793@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Dec 2025 12:34:48 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> dt-bindings for ADF41513, an ultralow noise PLL frequency synthesizer that
> can be used to implement local oscillators (LOs) as high as 26.5 GHz.
> Most properties refer to existing PLL driver properties (e.g. ADF4350).

"Refer" implies a cross reference in this document.   Based upon is probably a better
way to put this.

Otherwise I've mostly commented on properties that to me don't sound like
they belong in the dt-binding as they are policy things that we want
to make runtime configurable.

Thanks,

Jonathan

> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  .../bindings/iio/frequency/adi,adf41513.yaml       | 246 +++++++++++++++++++++
>  MAINTAINERS                                        |   7 +
>  2 files changed, 253 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
> new file mode 100644
> index 000000000000..01ceb2a7d21b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
> @@ -0,0 +1,246 @@
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
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
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
> +  avdd1-supply:
> +    description: PFD and Up and Down Digital Driver Power Supply (3.3 V)
> +
> +  avdd2-supply:
> +    description: RF Buffer and Prescaler Power Supply (3.3 V)
> +
> +  avdd3-supply:
> +    description: N Divider Power Supply (3.3 V)
> +
> +  avdd4-supply:
> +    description: R Divider and Lock Detector Power Supply (3.3 V)
> +
> +  avdd5-supply:
> +    description: Sigma-Delta Modulator and SPI Power Supply (3.3 V)
> +
> +  vp-supply:
> +    description: Charge Pump Power Supply (3.3 V)
> +
> +  enable-gpios:
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

This seems to be one potential use of the muxout pin.  So to me feels like
a policy decision that belongs with the driver or userspace, not in dt.
mux-out-gpios:
would make more sense to me.
Some of the potential settings probably don't make sense but then we just
don't support those in the driver if this is connected to a gpio.

> +    maxItems: 1
> +
> +  adi,power-up-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint64
> +    minimum: 1000000000
> +    maximum: 26500000000
> +    default: 10000000000
> +    description:
> +      The PLL tunes to this frequency (in Hz) during the initialization
> +      sequence. This property should be set to a frequency supported by the
> +      loop filter and VCO used in the design. Range is 1 GHz to 26.5 GHz for
> +      ADF41513, and 1 GHz to 10 GHz for ADF41510.

Why is this in DT?  Feels like this should be done by userspace control
prior to setting an enable rather than being in DT.

> +
> +  adi,reference-div-factor:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 32
> +    default: 1
> +    description:
> +      Value for the reference division factor (R Counter). The driver will
> +      increment R Counter as needed to achieve a PFD frequency within the
> +      allowed range. High R counter values will reduce the PFD frequency, which
> +      lowers the frequency resolution, and affects phase noise performance.

Why is this in DT?  Is there not a 'best' choice to be made given a particular
input frequency and desired output frequency?

> +
> +  adi,reference-doubler-enable:
> +    description:
> +      Enables the reference doubler. The maximum reference frequency when
> +      the doubler is enabled is 225 MHz.
As above. 
> +    type: boolean
> +
> +  adi,reference-div2-enable:
> +    description:
> +      Enables the reference divide-by-2 function. This provides a 50%
> +      duty cycle signal to the PFD.
As above.
> +    type: boolean
> +
> +  adi,charge-pump-resistor-ohms:
> +    minimum: 1800
> +    maximum: 10000
> +    default: 2700
> +    description:
> +      External charge pump resistor (R_SET) value in ohms. This sets the maximum
> +      charge pump current along with the charge pump current setting.
> +
> +  adi,charge-pump-current-microamp:
> +    description:
> +      Charge pump current (I_CP) in microamps. The value will be rounded to the
> +      nearest supported value. Range of acceptable values depends on the
> +      charge pump resistor value, such that 810 mV <= I_CP * R_SET <= 12960 mV.
> +      This value depends on the loop filter design.
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

This needs explanation of 'why' it should be in DT?  To me it seems mostly
to be a debug feature that should be controlled perhaps via a debugfs interface.
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
> +  adi,lock-detector-count:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 64
> +    description:
> +      Sets the value for Lock Detector count of the PLL, which determines the
> +      number of consecutive phase detector cycles that must be within the lock
> +      detector window before lock is declared. Lower values increase the lock
> +      detection sensitivity.
> +    enum: [2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192]

Sounds like policy.  Maybe it is related to the circuit design and there
is a right choice for  particular board? If not we should figure out how to leave
this to userspace control.  Probably as some form of event property.

> +
> +  adi,phase-resync-period-ns:
> +    default: 0
> +    description:
> +      When this value is non-zero, enable phase resync functionality, which
> +      produces a consistent output phase offset with respect to the input
> +      reference. The value specifies the resync period in nanoseconds, used
> +      to configure clock dividers with respect to the PFD frequency. This value
> +      should be set to a value that is at least as long as the worst case lock
> +      time, i.e., it depends mostly on the loop filter design.
> +
> +  adi,le-sync-enable:
> +    description:
> +      Synchronizes Load Enable (LE) transitions with the reference signal to
> +      avoid asynchronous glitches in the output. This is recommended when using
> +      the PLL as a frequency synthesizer, where reference signal will always be
> +      present while the device is being configured. When using the PLL as a
> +      frequency tracker, where the reference signal may be absent for long
> +      periods of time, LE sync should be disabled.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - avdd1-supply
> +  - avdd2-supply
> +  - avdd3-supply
> +  - avdd4-supply
> +  - avdd5-supply
> +  - vp-supply
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pll@0 {
> +            compatible = "adi,adf41513";
> +            reg = <0>;
> +            spi-max-frequency = <10000000>;
> +            clocks = <&ref_clk>;
> +            avdd1-supply = <&vdd_3v3>;
> +            avdd2-supply = <&vdd_3v3>;
> +            avdd3-supply = <&vdd_3v3>;
> +            avdd4-supply = <&vdd_3v3>;
> +            avdd5-supply = <&vdd_3v3>;
> +            vp-supply = <&vdd_3v3>;
> +
> +            adi,power-up-frequency = /bits/ 64 <12000000000>;
> +            adi,charge-pump-current-microamp = <2400>;
> +            adi,phase-detector-polarity-positive-enable;
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pll@0 {
> +            compatible = "adi,adf41513";
> +            reg = <0>;
> +            spi-max-frequency = <25000000>;
> +            clocks = <&ref_clk>;
> +            avdd1-supply = <&avdd1_3v3>;
> +            avdd2-supply = <&avdd2_3v3>;
> +            avdd3-supply = <&avdd3_3v3>;
> +            avdd4-supply = <&avdd4_3v3>;
> +            avdd5-supply = <&avdd5_3v3>;
> +            vp-supply = <&vp_3v3>;
> +            enable-gpios = <&gpio0 10 GPIO_ACTIVE_HIGH>;
> +            lock-detect-gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>;
> +
> +            adi,power-up-frequency = /bits/ 64 <15500000000>;
> +            adi,charge-pump-current-microamp = <3600>;
> +            adi,charge-pump-resistor-ohms = <2700>;
> +            adi,reference-doubler-enable;
> +            adi,muxout-select = "lock_detect";
> +            adi,lock-detector-count = <64>;
> +            adi,phase-resync-period-ns = <0>;
> +            adi,phase-detector-polarity-positive-enable;
> +            adi,le-sync-enable;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 29340394ac9d..1c1343f21160 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1601,6 +1601,13 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
>  F:	drivers/iio/amplifiers/ada4250.c
>  
> +ANALOG DEVICES INC ADF41513 DRIVER
> +M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
> +
>  ANALOG DEVICES INC ADF4377 DRIVER
>  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
>  L:	linux-iio@vger.kernel.org
> 


