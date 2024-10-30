Return-Path: <linux-iio+bounces-11591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E6A9B5BE4
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 07:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50EC1F239B3
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 06:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85731D27B9;
	Wed, 30 Oct 2024 06:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHvLtR4J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFDC63CB;
	Wed, 30 Oct 2024 06:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270588; cv=none; b=h9pCCITEGyZB5lXK4fyIrVTgYpLKlTGDvJ9q+o6WsJ7r2GgUtabK0KwQXMcp8yT6ZCKBVxM6yJyPip32ibksaLBWFT5+d/GM96WCa8rNLZRts46L9XNIxKPGiO1Jhhu/tHthXQPnQ4urDgztY+hgBw3sxDZpvkMgXXJorFFwkWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270588; c=relaxed/simple;
	bh=q/reVklIgQGFIN5gh6Xfpd1rZQ23cRzXzBo6YAM+4BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGo9qx+bSie75HYJ3aaoBcj24RzqUPWQMHkiqQ+7ZFmPMgbOabtVnSYj1cun9opil/imIxfI+6MXrFLV/WqAzVTJyanbNfC6CMXTHPNLs9kip6WM8GzUHFbx8Bu6mH3kSyN6M5Ep6UOyfgI9yHmDLeTH8XqU9j95XkPqHyFIfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHvLtR4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48443C4CEE4;
	Wed, 30 Oct 2024 06:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730270587;
	bh=q/reVklIgQGFIN5gh6Xfpd1rZQ23cRzXzBo6YAM+4BU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PHvLtR4JnFkSFnYQx+ny7SWEbD2MrQGvhhHC9dRJTfNj6daBH02g0flC1sJLgM256
	 KXviE+dIWXqIaTteoEa9SJKXYH8xylcRaRN23+hyMi8lSBp84yFU6vGno2LjEYEooW
	 tSSCSVU+KktdSrHZJXoKfobvhNeowdBRD0hEjwjqzaM+Tx+Q94LN5f6dbwVdFS4au2
	 bmCcl2vpGp1j/ZapyWoPkoS+CfyAahcFRxQJ+Q0XGyhJHaw9Qv2prKJOCTgGeckwwa
	 EDMqoN9aYq+yKMt5UCbYI+lzJ7lMhljGfdODmFtCVbvtHF8SWoVqmAN3QF2pSqOmtn
	 UOv8zb7HyKzfw==
Date: Wed, 30 Oct 2024 07:43:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Sebastian Reichel <sre@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mfd: sprd,sc2731: convert to YAML
Message-ID: <ki4wvjslncrngwpz7qukknzgdsjkxvrhitem7i5lof6ggyhu4e@tviovrd2wi77>
References: <ZyExK01iprBHhGm6@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyExK01iprBHhGm6@standask-GA-A55M-S2HP>

On Tue, Oct 29, 2024 at 08:02:03PM +0100, Stanislav Jakubek wrote:

Thank you for your patch. There is something to discuss/improve.

> +description: |
> +  Spreadtrum PMICs belonging to the SC27xx series integrate all mobile handset
> +  power management, audio codec, battery management and user interface support
> +  functions in a single chip. They have 6 major functional blocks:
> +    - DCDCs to support CPU, memory
> +    - LDOs to support both internal and external requirements
> +    - Battery management system, such as charger, fuel gauge
> +    - Audio codec
> +    - User interface functions, such as indicator, flash LED and so on
> +    - IC level interface, such as power on/off control, RTC, typec and so on
> +
> +properties:
> +  $nodename:
> +    pattern: '^pmic@[0-9a-f]+$'
> +
> +  compatible:
> +    enum:
> +      - sprd,sc2720
> +      - sprd,sc2721
> +      - sprd,sc2723
> +      - sprd,sc2730
> +      - sprd,sc2731
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +  spi-max-frequency: true

This means:
1. You forgot to ref spi-peripheral-props
2. This is not needed and use use unevaluatedProperties: false.

Just like all SPI devices.

Unless this is not SPI?


> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  regulators:
> +    type: object
> +    $ref: /schemas/regulator/sprd,sc2731-regulator.yaml#
> +
> +patternProperties:
> +  "^adc@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/iio/adc/sprd,sc2720-adc.yaml#
> +
> +  "^charger@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/power/supply/sc2731-charger.yaml#
> +
> +  "^efuse@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/nvmem/sprd,sc2731-efuse.yaml#

I don't think this was merged. You still have dependency.

Try yourself - apply this patch on the maintainers tree and test it.

You can solve it by listing here compatibles and additionalProperties:
true (see Qcom mdss bindings)



> +
> +  "^fuel-gauge@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/power/supply/sc27xx-fg.yaml#
> +
> +  "^gpio@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/gpio/sprd,gpio-eic.yaml#
> +
> +  "^led-controller@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/leds/sprd,sc2731-bltc.yaml#
> +
> +  "^rtc@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/rtc/sprd,sc2731-rtc.yaml#
> +
> +  "^vibrator@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/input/sprd,sc27xx-vibrator.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - spi-max-frequency
> +  - '#address-cells'

Keep consistent quotes, either ' or ".

> +  - '#interrupt-cells'
> +  - '#size-cells'

Best regards,
Krzysztof


