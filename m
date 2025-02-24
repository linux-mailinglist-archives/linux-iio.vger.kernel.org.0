Return-Path: <linux-iio+bounces-16035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DAEA42DD4
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 21:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796B13B2414
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 20:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3E424290A;
	Mon, 24 Feb 2025 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsGM5Hqa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC9D15886C;
	Mon, 24 Feb 2025 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429066; cv=none; b=dcpxR8Jn4r5E0AdykmUQ1I+lqcZP4gs+0Ucr5jMsuqM/2D5FSCsfLLwWG2ySJZKtJvJra6zE/jlb3Ev58FxBMF2UwyjP1ahStUSaf7QzYW36keIaLba8sMjmlkwsXEa/Q6ux0epZz57KC5JEk0zfUyYI01m8Ks65U3zKuyqGJKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429066; c=relaxed/simple;
	bh=L8IZghbWBb1FZ+oD2PukBSn8EeW2fG7tEPS95geHYCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqFzPfF3A7IW8zaRbyLGnPhJxEwRl+t1HmnRNBjpp/bkN88oKE2YvVVWWXjNTqfrQ3lo/mmix4Bqswo03uLnXQCZ6wF6KApzzCLwYJngKWcc2VY5uKY3HynHgut0h+mgMM9JVK18GMWUJ0rH5lVsOyCXYov5Pn9VlIkW763LFg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsGM5Hqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF15C4CEDD;
	Mon, 24 Feb 2025 20:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740429065;
	bh=L8IZghbWBb1FZ+oD2PukBSn8EeW2fG7tEPS95geHYCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WsGM5HqaAucAaiS7PAROvBe7UYvBT1EQy7FUyX/EntMrSEoGBOEW0pmFQ2FdwEygf
	 B7AnI+DJV7MboF4vz2Goncoa6fTgsa2N9S5OM1UZRqpZqMrAA+VKGGbLkyubseaUrW
	 2T8lSbPOKlhSljpJ/oXnaaiEzPmlrlLAkg1FXNXRcisGSbdMguauXendyMcnbzhfJx
	 a+yqldGEqA68z1FwAV+TOBFEGRcogS6nH+MnvU30d4TVAG32gVAK5FLRrmlv5pV7Fk
	 m749g371WW+fh+Pxq6cLd2UipiQCucafSaj6gXAC54qQCEq1srEHrMHqwOyT9C4HjZ
	 M6wJRsC5MlSdA==
Date: Mon, 24 Feb 2025 14:31:03 -0600
From: Rob Herring <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: mfd: Document TI LM3533 MFD
Message-ID: <20250224203103.GA4043445-robh@kernel.org>
References: <20250224114815.146053-1-clamor95@gmail.com>
 <20250224114815.146053-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224114815.146053-2-clamor95@gmail.com>

On Mon, Feb 24, 2025 at 01:48:13PM +0200, Svyatoslav Ryhel wrote:
> Add bindings for the LM3533 - a complete power source for backlight, keypad
> and indicator LEDs in smartphone handsets. The high-voltage inductive boost
> converter provides the power for two series LED strings display backlight
> and keypad functions.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/mfd/ti,lm3533.yaml    | 231 ++++++++++++++++++
>  1 file changed, 231 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,lm3533.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml b/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml
> new file mode 100644
> index 000000000000..c8ac6d4424aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml
> @@ -0,0 +1,231 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,lm3533.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI LM3533 Complete Lighting Power Solution
> +
> +description: >
> +  The LM3533 is a complete power source for backlight, keypad, and indicator LEDs
> +  in smartphone handsets. The high-voltage inductive boost converter provides the
> +  power for two series LED strings display backlight and keypad functions.
> +
> +  https://www.ti.com/product/LM3533
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: ti,lm3533
> +
> +  reg:
> +    maxItems: 1
> +
> +  enable-gpios:
> +    description: GPIO to use to enable/disable the backlight (HWEN pin).
> +    maxItems: 1
> +
> +  ti,boost-ovp-microvolt:
> +    description:
> +      Boost OVP select (16V, 24V, 32V, 40V)
> +    enum: [ 16000000, 24000000, 32000000, 40000000 ]
> +    default: 16000000
> +
> +  ti,boost-freq-hz:
> +    description:
> +      Boost frequency select (500KHz or 1MHz)
> +    enum: [ 500000, 1000000 ]
> +    default: 500000
> +
> +  light-sensor:
> +    type: object
> +    description:
> +      Properties for an illumination sensor.
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        const: ti,lm3533-als
> +
> +      ti,resistor-value-ohm:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Internal configuration resister value when ALS is in Analog Sensor
> +          mode and PWM mode is disabled.
> +        minimum: 1575
> +        maximum: 200000
> +
> +      ti,pwm-mode:
> +        type: boolean
> +        description:
> +          Switch for mode in which ALS is running. If this propertly is set
> +          then ALS is running in PWM mode, internal resistor value is set to
> +          high-impedance (0) and resistor-value-ohm propertly is ignored.
> +
> +    required:
> +      - compatible
> +
> +required:
> +  - compatible
> +  - reg
> +  - enable-gpios
> +  - light-sensor
> +  - backlight-0
> +  - backlight-1
> +  - led-0
> +  - led-1
> +  - led-2
> +  - led-3
> +
> +patternProperties:
> +  "^backlight-[01]$":
> +    type: object
> +    description:
> +      Properties for a backlight device.
> +
> +    $ref: /schemas/leds/backlight/common.yaml#
> +
> +    properties:
> +      compatible:
> +        const: ti,lm3533-backlight
> +
> +      default-brightness: true
> +
> +      ti,max-current-microamp:
> +        description:
> +          Maximum current in µA with a 800 µA step.
> +        enum: [ 5000, 5800, 6600, 7400, 8200, 9000, 9800,
> +                10600, 11400, 12200, 13000, 13800, 14600,
> +                15400, 16200, 17000, 17800, 18600, 19400,
> +                20200, 21000, 21800, 22600, 23400, 24200,
> +                25000, 25800, 26600, 27400, 28200, 29000,
> +                29800 ]
> +        default: 5000
> +
> +      ti,pwm-config-mask:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Control Bank PWM Configuration Register mask that allows to configure
> +          PWM input in Zones 0-4
> +          BIT(0) - PWM Input is enabled
> +          BIT(1) - PWM Input is enabled in Zone 0
> +          BIT(2) - PWM Input is enabled in Zone 1
> +          BIT(3) - PWM Input is enabled in Zone 2
> +          BIT(4) - PWM Input is enabled in Zone 3
> +          BIT(5) - PWM Input is enabled in Zone 4
> +
> +      ti,linear-mapping-mode:
> +        description:
> +          Enable linear mapping mode. If disabled, then it will use exponential
> +          mapping mode in which the ramp up/down appears to have a more uniform
> +          transition to the human eye.
> +        type: boolean
> +
> +      ti,hardware-controlled:
> +        description:
> +          Each backlight has its own voltage Control Bank (A and B) and there are
> +          two HVLED sinks which by default are linked to respective Bank. Setting
> +          this property will link both sinks to a Control Bank of backlight where
> +          property is defined.
> +        type: boolean
> +
> +    required:
> +      - compatible
> +
> +    additionalProperties: false
> +
> +  "^led-[0-3]$":
> +    type: object
> +    description:
> +      Properties for a led device.
> +
> +    $ref: /schemas/leds/common.yaml#
> +
> +    properties:
> +      compatible:
> +        const: ti,lm3533-leds
> +
> +      linux,default-trigger: true
> +
> +      ti,max-current-microamp:
> +        description:
> +          Maximum current in µA with a 800 µA step.
> +        enum: [ 5000, 5800, 6600, 7400, 8200, 9000, 9800,
> +                10600, 11400, 12200, 13000, 13800, 14600,
> +                15400, 16200, 17000, 17800, 18600, 19400,
> +                20200, 21000, 21800, 22600, 23400, 24200,
> +                25000, 25800, 26600, 27400, 28200, 29000,
> +                29800 ]
> +        default: 5000
> +
> +      ti,pwm-config-mask:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Same descryption and function as for backlight.
> +
> +    required:
> +      - compatible
> +
> +    additionalProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        led-controller@36 {
> +            compatible = "ti,lm3533";
> +            reg = <0x36>;
> +
> +            enable-gpios = <&gpio 110 GPIO_ACTIVE_HIGH>;
> +
> +            ti,boost-ovp-microvolt = <24000000>;
> +            ti,boost-freq-hz = <500000>;
> +
> +            backlight-0 {
> +                compatible = "ti,lm3533-backlight";
> +
> +                ti,max-current-microamp = <23400>;
> +                default-brightness = <113>;
> +                ti,hardware-controlled;
> +            };
> +
> +            backlight-1 {
> +                compatible = "ti,lm3533-backlight";
> +                status = "disabled";

Examples should be enabled. Drop status.

With those fixed,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

> +            };
> +
> +            led-0 {
> +                compatible = "ti,lm3533-leds";
> +                status = "disabled";
> +            };
> +
> +            led-1 {
> +                compatible = "ti,lm3533-leds";
> +                status = "disabled";
> +            };
> +
> +            led-2 {
> +                compatible = "ti,lm3533-leds";
> +                status = "disabled";
> +            };
> +
> +            led-3 {
> +                compatible = "ti,lm3533-leds";
> +                status = "disabled";
> +            };
> +
> +            light-sensor {
> +                compatible = "ti,lm3533-als";
> +                status = "disabled";
> +            };
> +        };
> +    };
> +...
> -- 
> 2.43.0
> 

