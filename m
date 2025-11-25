Return-Path: <linux-iio+bounces-26449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBC4C844E2
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 10:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FDA24E76D3
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 09:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754332E9ECA;
	Tue, 25 Nov 2025 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPnnOJhQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233182EBBB3;
	Tue, 25 Nov 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764064262; cv=none; b=agbzTj/kI4gdj+pjTnfDgnynLdYib/ncbPZ8kEMDJhKRGc1H5q0hrvWczUCNoyEMb72Es7yGXMUwdiVwu1jvGjFKQ6mQUm/+hXjeByU+H7Vlbara78RWOcs0GI5H0ICB3xoNVeCU8Lx7viiO/ZeQMt3oVoLGzTGzrmUDqLgDI/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764064262; c=relaxed/simple;
	bh=DUYCCbWHsiD2RMZpZykM5t7g4XZ2yTPNXDlMZFrTIA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrdAuZMVl9k0nr/mNisL1SjrwaHSJnfr/PE+uzknKbJ1GGo/vYaWXlMP8OElAVyFfAu8py05OdpKc9EGZEZk14a/h3IvLGGepRjmmc9NWjeLd3j7QU4aGXlJvBxJVIF15rzPcUM0CA/dxQfdNiR+gwgwOx7XJBX9nYEwMl0WvPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPnnOJhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34627C4CEF1;
	Tue, 25 Nov 2025 09:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764064261;
	bh=DUYCCbWHsiD2RMZpZykM5t7g4XZ2yTPNXDlMZFrTIA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPnnOJhQUA7OCoH7YfhA7+VGQ24L+WgnHeCdv26m6Bx/1zjXxIp0ca16FnQqsRgUs
	 e+JJgln5gm1qAgb+vRi6k/MrlfuobCUl5m9VOjlpJOlDGzNunndD49KGr4Gn9xwH6S
	 VNGZtQE3QNcy/BZrCM5H8GtG/K/i6SkLQwT8EDjTcE+Qm8/zXmfeMptdl30daWUF/a
	 Im8S54CLgqDJActCSitxn7JB0VnMDWl34S5SMaR97pFm9tfV3HgBZDKvw5c8s2izs1
	 Ec12iV0qtSwQ4CbENbsgmOxxsdBKYnm1vnLGGeUfIQ5BQ6WxKrzytL2KREc0FZf9qZ
	 zJaxvMAeUnTpA==
Date: Tue, 25 Nov 2025 10:50:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 1/9] dt-bindings: iio: adc: Add adi,ad4062
Message-ID: <20251125-marvellous-camel-of-kindness-d274ee@kuoka>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
 <20251124-staging-ad4062-v2-1-a375609afbb7@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251124-staging-ad4062-v2-1-a375609afbb7@analog.com>

On Mon, Nov 24, 2025 at 10:18:00AM +0100, Jorge Marques wrote:
> Add dt-bindings for AD4062 family, devices AD4060/AD4062, low-power with
> monitor capabilities SAR ADCs. Each variant of the family differs in
> resolution. The device contains two outputs (gp0, gp1). The outputs can
> be configured for range of options, such as threshold and data ready.
> The device uses a 2-wire I3C interface.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4062.yaml    | 123 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 129 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
> new file mode 100644
> index 0000000000000..a25af66dd64d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4062.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2024 Analog Devices Inc.
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
> +      DEV_EN, logic low, logic high and DEV_RDY (GP1 only). RDY is the
> +      active-low data ready signal, indicates when new ADC data are ready to
> +      read. DEV_EN synchronizes the enable and power-down states of signal
> +      chain devices with the ADC sampling instant. DEV_RDY is an active-high
> +      signal that indicates when the device is ready to accept serial interface
> +      communications. In GP_INTR mode, the interrupt outputs one of the
> +      threshold detection interrupt signals (MIN_INTR, MAX_INTR or either).
> +    minItems: 1

So the wire/pin can be physically disconnected?

> +    items:
> +      - description:
> +          gp0, interrupt line for GP0 pin, cannot be configured as DEV_RDY.

Write concise statements - duplicating gp0 is not helping. "GP0 pin,
cannot be configured as DEV_RDY."

"GP1 pin, can be configured to any setting."


> +      - description:
> +          gp1, interrupt line for GP1 pin, can be configured to any setting.
> +
> +  interrupt-names:

Why this is not matching interrupts in number of items?

> +    items:
> +      - const: gp0
> +      - const: gp1
> +
> +  gpio-controller:
> +    description:
> +      Marks the device node as a GPIO controller. GPs not listed in
> +      interrupt-names are exposed as a GPO.

"not listed as interrupts are..."

> +
> +  '#gpio-cells':
> +    const: 2
> +    description:
> +      The first cell is the GPIO number and the second cell specifies
> +      GPIO flags, as defined in <dt-bindings/gpio/gpio.h>.

Best regards,
Krzysztof


