Return-Path: <linux-iio+bounces-26834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB5DCAAA9E
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 17:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1F13300E45B
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 16:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4F42F5496;
	Sat,  6 Dec 2025 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXr0e7XE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C0B2AD37;
	Sat,  6 Dec 2025 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765040308; cv=none; b=dsSntyLAvbJN1tXL0QeeiKslat1buKqK90L1aA2Pj3WgU6rXsIjrPJOcDFpXqyf2JBy9G/SRl6EoUZ+H+m+NBhyCbeN5eifv6qrDTQewSL2Ok/wmKc5SLc1mKg5mhzd8tzrDnUi4qGrtSUB89SMBahNQNuSoIL4MqUR0EGpk020=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765040308; c=relaxed/simple;
	bh=6Zhv27VdXpGMAcVcOTzB70FyIM3NnPAumRSIO9oiPpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i01ZHVDSFXbLBiGvYEgqY7AW2lkOdIQQUcZqIytbOocXJ2FCJYj+0m9CWp6pbDFqQYobCaU4z8fbhf0auEA5rMGoiinBo7CNi/9zM7wI3/UbJsmt4pRupk7wWgoDrTLNdhLC838OYZvmwRByBLx686hctJ9jR69z7JmHU2GBUO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXr0e7XE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372D4C4CEF5;
	Sat,  6 Dec 2025 16:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765040308;
	bh=6Zhv27VdXpGMAcVcOTzB70FyIM3NnPAumRSIO9oiPpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aXr0e7XEBzQvtH5E9l4XZwWEKnNVr+qZLuN6MXnJpgwTLktHGEE8S47kGI/P4arMN
	 gOxLyek2A4UAl3V1WH4jZ/1Gp92zE088X9bUGsRTDFrBGUsdraQg5uVAVdr0bZFBgs
	 LBxJRASHGZBj16A7R+U+axBgL7D4JObz9gPqjK20vK4CRIlvDPthKEWjbXygKl6nfZ
	 adv5pM1lSlNTZdyRUmQhXYEEN6oSl05RxvNXhd8b/gNGK2Ep1PP4TUfWqNZ4OKSX4C
	 ZTYzpiMgnWFdVCLl+wwYHafSGBAx/+diCWicp0T4gHnwUuM75oeuVUIJCiaTf53TWJ
	 ZhapW1P2p4sVg==
Date: Sat, 6 Dec 2025 16:58:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] dt-bindings: iio: adc: Add adi,ad4062
Message-ID: <20251206165822.778606e1@jic23-huawei>
In-Reply-To: <20251205-staging-ad4062-v3-1-8761355f9c66@analog.com>
References: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
	<20251205-staging-ad4062-v3-1-8761355f9c66@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Dec 2025 16:12:02 +0100
Jorge Marques <jorge.marques@analog.com> wrote:

> Add dt-bindings for AD4062 family, devices AD4060/AD4062, low-power with
> monitor capabilities SAR ADCs. Each variant of the family differs in
> resolution. The device contains two outputs (gp0, gp1). The outputs can
> be configured for range of options, such as threshold and data ready.
> The device uses a 2-wire I3C interface.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4062.yaml    | 124 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 130 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
> new file mode 100644
> index 0000000000000..a7a2ad761d1f0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
> @@ -0,0 +1,124 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2024 Analog Devices Inc.

It's changed enough in the versions posted that probably wants to at
least include 2025.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4062.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4062 ADC family device driver
> +
> +maintainers:
> +  - Jorge Marques <jorge.marques@analog.com>
> +
> +description: |
> +  Analog Devices AD4062 Single Channel Precision SAR ADC family
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4060.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4062.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4060
> +      - adi,ad4062
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      The interrupt pins are digital outputs that can be configured at runtime
> +      as multiple interrupt signals. Each can be configured as GP_INTR, RDY,
> +      DEV_EN, logic low, logic high and DEV_RDY (GP1 only).
This is a bit confused.  logic low / logic high aren't interrupt signals so I'd
not mention them here.  Maybe something less detailed such as

    Two pins are available that can be configured as either a general purpose
    digital output, device enable signal (used to synchronise other parts of
    the signal chain with ADC sampling), device ready (GP1 only) or various
    interrupt signals. If intended for use as a GPIO or device enable, will not
    present here.

For the binding I'm not sure we care about which interrupts are possible.
I guess even for device ready we might treat it as a onetime interrupt. Probably poll
it though - which requires a GPIO not an interrupt binding.  If we don't need
to use that mode (and can poll a register or something like that) then no need
to mention that bit.

> RDY is the
> +      active-low data ready signal, indicates when new ADC data are ready to
> +      read. DEV_EN synchronizes the enable and power-down states of signal
> +      chain devices with the ADC sampling instant. DEV_RDY is an active-high
> +      signal that indicates when the device is ready to accept serial interface
> +      communications. In GP_INTR mode, the interrupt outputs one of the
> +      threshold detection interrupt signals (MIN_INTR, MAX_INTR or either).
> +    minItems: 1
> +    items:
> +      - description:
> +          GP0 pin, cannot be configured as DEV_RDY.
> +      - description:
> +          GP1 pin, can be configured to any setting.
> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: gp0
> +      - const: gp1
> +
> +  gpio-controller:
> +    description:
> +      Marks the device node as a GPIO controller. GPs not listed as interrupts
> +      are exposed as a GPO.
> +
> +  '#gpio-cells':
> +    const: 2
> +    description:
> +      The first cell is the GPIO number and the second cell specifies
> +      GPIO flags, as defined in <dt-bindings/gpio/gpio.h>.
> +
> +  vdd-supply:
> +    description: Analog power supply.
> +
> +  vio-supply:
> +    description: Digital interface logic power supply.
> +
> +  ref-supply:
> +    description:
> +      Reference voltage to set the ADC full-scale range. If not present,
> +      vdd-supply is used as the reference voltage.
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - vio-supply
> +
> +allOf:
> +  - $ref: /schemas/i3c/i3c.yaml#



