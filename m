Return-Path: <linux-iio+bounces-26853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8FFCAACF4
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 20:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66CE8303E012
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 19:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762632C029F;
	Sat,  6 Dec 2025 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slrxhPwb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295A770808;
	Sat,  6 Dec 2025 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765049615; cv=none; b=B+tItqE+ImpzzR6Y2CA5J9walZzipL+1ouECxWTEtm53bQloHZJZGIghneet+/iXUN3GdFLi7Q9M0xB4sQ9unXi0uYZZXUB8OLLtGFQxe7+Dd53ClRSZMDEjUJHNOwgRjtkpJrlD4ad63o2LxIkgE9bH7s8HRoK5V9GLmK9UImo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765049615; c=relaxed/simple;
	bh=4TdOeISXIS7RYSnOS5MuusUKETBU9vTTwZkRbmkDU8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tl9Fs0Kk2gwNCglj9BD5dj/b7WGOpFbKfvSEnHy8S+FG6csfc0ebVOp9zQCrs9rX7xgdbjJgMc5v8zcoqMuLOdFE8dlJ780uxmRPbElZJA+ySbs+bkwYtZflcHwWvowizcrKYaJYLggYGbrk1LbPrCc2sYhKDD5ELZYme3Z3u60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slrxhPwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD90C4CEF5;
	Sat,  6 Dec 2025 19:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765049615;
	bh=4TdOeISXIS7RYSnOS5MuusUKETBU9vTTwZkRbmkDU8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=slrxhPwbPeoohT0uhNdVmkoJMAvKfd4WKWcwj2Gl8LPmkI3ePNFe1Yn472uMSNwqM
	 bIOvJ3tUpeLFHVVJHhJNFbqmA2a91rYGwY52q2HYkXXl3N9Z7zz3EczwPZjkx/K8aB
	 RkJLMaYk3NJUVJ6go4TUTUQwqWuUCEabeuy6dGDep0D0ehtL0n1Qg0Ho8XHDXEV/KC
	 y5h1aRZABNJi5tT9mcm72+Zoe3lsREP0qAmq1ViDrr6DqUeoghoCRgG5GekOWUQpKC
	 grwe2KkbAH2Tu1xTGBvh7aete7vIFX2StXqjo3FOnjs0r3tsFVv2To8jeQiED/YYg5
	 fRZlvP4kLkBBg==
Date: Sat, 6 Dec 2025 19:33:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Tobias Sperling
 <tobias.sperling@softing.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: adc: Add TI ADS1018/ADS1118
Message-ID: <20251206193324.1d0e6fef@jic23-huawei>
In-Reply-To: <20251204-ads1x18-v6-1-2ae4a2f8e90c@gmail.com>
References: <20251204-ads1x18-v6-0-2ae4a2f8e90c@gmail.com>
	<20251204-ads1x18-v6-1-2ae4a2f8e90c@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Dec 2025 13:01:27 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Add documentation for Texas Instruments ADS1018 and ADS1118
> analog-to-digital converters.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
A couple of trivial things that aren't worth a respin.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/ti,ads1018.yaml    | 82 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 88 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
> new file mode 100644
> index 000000000000..93c9b2921a54
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1018.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI ADS1018/ADS1118 SPI analog to digital converter
> +
> +maintainers:
> +  - Kurt Borja <kuurtb@gmail.com>
> +
> +description: |
> +  The ADS1018/ADS1118 is a precision, low-power, 12-bit or 16-bit, noise-free,
If you spin again: 12-bit/16-bit
to align with ADS1018/ADS1118 earlier in the line.
Otherwise it sounds like each can do either mode.

I'd also drop the noise-free.  To me that seems overly optimistic marketing and
it doesn't add anything useful.


> +  analog-to-digital converter (ADC). It integrates a programmable gain amplifier
> +  (PGA), voltage reference, oscillator and high-accuracy temperature sensor.
> +
> +  Datasheets:
> +    - ADS1018: https://www.ti.com/lit/ds/symlink/ads1018.pdf
> +    - ADS1118: https://www.ti.com/lit/ds/symlink/ads1118.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads1018
> +      - ti,ads1118
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  spi-max-frequency:
> +    maximum: 4000000
> +
> +  spi-cpha: true
> +
> +  interrupts:
> +    description: DOUT/DRDY (Data Out/Data Ready) line.
> +    maxItems: 1
> +
> +  drdy-gpios:
> +    description:
> +      Extra GPIO line connected to DOUT/DRDY (Data Out/Data Ready). This allows
> +      distinguishing between interrupts triggered by the data-ready signal and
> +      interrupts triggered by an SPI transfer.
> +    maxItems: 1
> +
> +  '#io-channel-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "ti,ads1118";
> +            reg = <0>;
> +
> +            spi-max-frequency = <4000000>;
> +            spi-cpha;
> +
> +            vdd-supply = <&vdd_3v3_reg>;
> +
> +            interrupts-extended = <&gpio 14 IRQ_TYPE_EDGE_FALLING>;
> +            drdy-gpios = <&gpio 14 GPIO_ACTIVE_LOW>;
> +        };
> +    };


