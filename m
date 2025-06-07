Return-Path: <linux-iio+bounces-20305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7801EAD0E9E
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 18:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF82B188D206
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 16:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8FB1F5828;
	Sat,  7 Jun 2025 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WslmEZNY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF6FE573;
	Sat,  7 Jun 2025 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749314730; cv=none; b=RBK6d1xxaKq6c2/MjL6p3EqgxSn49lSqqeyfB9qH+rkqXm3hLAO9m8ldBP9jueZ3ANdfbUO4Gzrx84ArmODNA+3t1KePgulPVdrFvCTnaZJKtHsc18giIcKS19NWRxNwO8k5mmZ0G4GO8VMCDJiRrQx38XGuxXfBRG3HB+CtxZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749314730; c=relaxed/simple;
	bh=k+xKV5fZbAc70QC7FeAlBD1nfPEHF0Qe55V3oNTpWCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnrXBM18ds+eXhBNuX82luzDj43aO+KWRCxyfscEOtsFrqMCW5svWGg7iEO0neK9dxgOCkEJ+U7kR9qjhcQhsLoH8wLSikyVqVvTiCY+CmiAsBxxzLfxQX0+PmNFO+q0eWWRiOeKSGfY2M/H10Hh9ileA8d8MP3ViZlKfVRqGQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WslmEZNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85333C4CEE4;
	Sat,  7 Jun 2025 16:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749314729;
	bh=k+xKV5fZbAc70QC7FeAlBD1nfPEHF0Qe55V3oNTpWCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WslmEZNY1Ag19zwrbOw9MiyrTGxaKodJT1yYtt8Zhc9d2OUZ52KYlP02ftzfEyfUI
	 eM7aeO3v2BYsYWuiIm/kfk51RNKAtyqrOO9HEzcm0psnn83MVZ8ndWmf3tOf6dRPY8
	 cXrulSq2W7KDr+m+w2imGMXsgISGoYETHuLx9RpRoBdE3lDQJaQXBo4CxmUhpokIxH
	 HVPmP9OXIpXxz5KUIWX+MGku9xdApwsv90iE7vpqER36CAkBvNMxSxIGn5j5MEj3+c
	 eE1fcv2fE5ZR6GaOtwGE6dmkLzxYwYXx8HkN/wWuOAEyzIBCEIaJ067VZNemgphXyw
	 FQIh5LlbQOxnA==
Date: Sat, 7 Jun 2025 17:45:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linus.walleij@linaro.org>,
 <brgl@bgdev.pl>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v4 01/11] dt-bindings: iio: adc: Add AD4170
Message-ID: <20250607174521.6dee54fb@jic23-huawei>
In-Reply-To: <187e038cb9e7dbe3991149885cb0a4b30376660c.1748829860.git.marcelo.schmitt@analog.com>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
	<187e038cb9e7dbe3991149885cb0a4b30376660c.1748829860.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Jun 2025 08:36:24 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add device tree documentation for AD4170 and similar sigma-delta ADCs.
> The AD4170 is a 24-bit, multichannel, sigma-delta ADC.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v3 -> v4
> - Dropped sensor-node and most of defs.
> - Updated external sensor props to have similar name and type of adi,ad4130 ones.
> - Added constraints to properties related to external bridge sensor excitation.
> 
> Some explanation about the constraints to weigh scale sensor types.
> 
> The predefined ACX1, ACX1 negated, ACX2, and ACX2 negated signals are used to AC
> excite external bridge circuits and are output on GPIO2, GPIO0, GPIO3, and
> GPIO1, respectively. If only two pins are specified for AC excitation, only ACX1
> and ACX2 (GPIO2 and GPIO3) are used. Because of that, if AC excitation is
> specified/requested, then those specific GPIO pins must be used with the bridge.
> Otherwise, the bridge won't get properly excited and we also cannot guarantee to
> avoid short-circuit conditions since the level set to GPIOs to DC excite the
> bridge depends on the GPIO number. See AD4170 datasheet Figure 113 Weigh Scale
> (AC Excitation) for the reference circuit diagram.
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4170-4.pdf#unique_149_Connect_42_ID10354
> 
>  .../bindings/iio/adc/adi,ad4170.yaml          | 543 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 550 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> new file mode 100644
> index 000000000000..87b6e821fdb8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> @@ -0,0 +1,543 @@

> +
> +$defs:
> +  reference-buffer:
> +    description: |
> +      Enable precharge buffer, full buffer, or skip reference buffering of
> +      the positive/negative voltage reference. Because the output impedance
> +      of the source driving the voltage reference inputs may be dynamic, RC

RC?

> +      combinations of those inputs can cause DC gain errors if the reference
> +      inputs go unbuffered into the ADC. Enable reference buffering if the
> +      provided reference source has dynamic high impedance output. Note the
> +      absolute voltage allowed on REFINn+ and REFINn- inputs is from
> +      AVSS - 50 mV to AVDD + 50 mV when the reference buffers are disabled
> +      but narrows to AVSS to AVDD when reference buffering is enabled or in
> +      precharge mode. The valid options for this property are:
> +      0: Reference precharge buffer.
> +      1: Full reference buffering.
> +      2: Bypass reference buffers (buffering disabled).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +    default: 1

> +
> +  interrupts:
> +    description:
> +      Interrupt for signaling the completion of conversion results. The data
> +      ready signal (RDY) used as interrupt is by default provided on the SDO
> +      pin. Alternatively, it can be provided on the DIG_AUX1 pin in which case
> +      the chip disables the RDY function on SDO. Thus, there can be only one
> +      data ready interrupt enabled at a time.
> +    maxItems: 1
> +
> +  interrupt-names:
> +    description:
> +      Specify which pin should be configured as Data Ready interrupt.
> +    enum:
> +      - sdo
> +      - dig_aux1
> +    maxItems: 1
> +    default: sdo

I think I'd prefer to see it always provided as there is no strong
reason to prefer one as the default.

>
> +      adi,excitation-pin-0:
> +        $ref: '#/$defs/excitation-pin'
> +
> +      adi,excitation-pin-1:
> +        $ref: '#/$defs/excitation-pin'
> +
> +      adi,excitation-pin-2:
> +        $ref: '#/$defs/excitation-pin'
> +
> +      adi,excitation-pin-3:
> +        $ref: '#/$defs/excitation-pin'
> +
> +      adi,excitation-current-0-microamp:
> +        description:
> +          Excitation current in microamperes to be applied to pin specified in
> +          adi,excitation-pin-0 while this channel is active.
> +        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]

What motivated mix of using $ref and here where there is a lot of repetition?
I don't mind which approach is used, but a mix seems the worst option.

> +        default: 0
> +
> +      adi,excitation-current-1-microamp:
> +        description:
> +          Excitation current in microamperes to be applied to pin specified in
> +          adi,excitation-pin-1 while this channel is active.
> +        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
> +        default: 0
> +
> +      adi,excitation-current-2-microamp:
> +        description:
> +          Excitation current in microamperes to be applied to pin specified in
> +          adi,excitation-pin-2 while this channel is active.
> +        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
> +        default: 0
> +
> +      adi,excitation-current-3-microamp:
> +        description:
> +          Excitation current in microamperes to be applied to pin specified in
> +          adi,excitation-pin-3 while this channel is active.
> +        enum: [0, 10, 50, 100, 250, 500, 1000, 1500]
> +        default: 0
> +
> +      adi,excitation-ac:
> +        type: boolean
> +        description:
> +          Whether the external sensor has to be AC or DC excited. When omitted,
> +          it is DC excited.

> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - iovdd-supply
> +  - spi-cpol
> +  - spi-cpha
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "adi,ad4170";
> +            reg = <0>;
> +            spi-max-frequency = <20000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            avdd-supply = <&avdd>;
> +            iovdd-supply = <&iovdd>;
> +            clocks = <&clk>;
> +            clock-names = "xtal";
> +            interrupt-parent = <&gpio_in>;

In examples I don't think we tend to specify interrupt-parent.
That's covered fine by the interrupt bindings.

As above, I'd prefer to always see interrupt-names as well so
we have it really visible which one this is.


> +            interrupts = <0 IRQ_TYPE_EDGE_FALLING>;

> +            adi,vbias-pins = <7>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;

> +        };
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "adi,ad4170";
> +            reg = <0>;
> +            spi-max-frequency = <20000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            avdd-supply = <&avdd>;
> +            iovdd-supply = <&iovdd>;
> +            #clock-cells = <0>;
> +            clock-output-names = "ad4170-clk16mhz";
> +            interrupt-parent = <&gpio_in>;
> +            interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            // Sample AIN0 with respect to AIN1 throughout AVDD/AVSS input range
> +            // Differential bipolar. If AVSS < 0V, differential true bipolar
> +            channel@0 {
> +                reg = <0>;
> +                bipolar;
> +                diff-channels = <0 1>;
> +                adi,reference-select = <3>;
> +            };
> +            // Sample AIN2 with respect to DGND throughout AVDD/DGND input range
> +            // Pseudo-differential unipolar
> +            channel@1 {
> +                reg = <1>;
> +                single-channel = <2>;
> +                common-mode-channel = <24>;
> +                adi,reference-select = <3>;
> +            };
> +            // Sample AIN3 with respect to 2.5V throughout AVDD/AVSS input range
> +            // Pseudo-differential bipolar
> +            channel@2 {
> +                reg = <2>;
> +                bipolar;
> +                single-channel = <3>;
> +                common-mode-channel = <29>;
> +                adi,reference-select = <3>;
> +            };
> +            // Sample AIN4 with respect to DGND throughout AVDD/AVSS input range
> +            // Pseudo-differential bipolar
> +            channel@3 {
> +                reg = <3>;
> +                bipolar;
> +                single-channel = <4>;
> +                common-mode-channel = <24>;
> +                adi,reference-select = <3>;
> +            };
> +            // Sample AIN5 with respect to 2.5V throughout AVDD/AVSS input range
> +            // Pseudo-differential unipolar (AD4170 datasheet page 46 example)
> +            channel@4 {
> +                reg = <4>;
> +                single-channel = <5>;
> +                common-mode-channel = <29>;
> +                adi,reference-select = <3>;
> +            };
> +            // Sample AIN6 with respect to 2.5V throughout REFIN+/REFIN- input range
> +            // Pseudo-differential bipolar
> +            channel@5 {
> +                reg = <5>;
> +                bipolar;
> +                single-channel = <6>;
> +                common-mode-channel = <29>;
> +                adi,reference-select = <0>;
> +            };
> +            // Weigh scale sensor
> +            channel@6 {
> +                reg = <6>;
> +                bipolar;
> +                diff-channels = <7 8>;
> +                adi,reference-select = <0>;
> +                adi,sensor-type = "weighscale";
> +                adi,excitation-pin-0 = <17>;
> +                adi,excitation-pin-1 = <18>;
> +                adi,excitation-pin-2 = <19>;
> +                adi,excitation-pin-3 = <20>;
> +                adi,excitation-ac;
> +            };
> +        };
> +    };
> +...
> +

