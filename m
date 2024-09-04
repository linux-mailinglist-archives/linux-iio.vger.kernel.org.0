Return-Path: <linux-iio+bounces-9115-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB1696B16F
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 08:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9985EB255E7
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 06:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794C612DD90;
	Wed,  4 Sep 2024 06:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1CX2RCw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AF4823DE;
	Wed,  4 Sep 2024 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430857; cv=none; b=lQfS3VFaimDELhdBWJjtsr/daTJbMQhq2UCSHeux9MrS8Cz2FeeEcYWu+DtvRo2tIyT1YdFCfl5HzIBflmHG8U9M9K96tzmnVuSYxw+7uuVfJ2VGS8p5TNZ4OvUqrD7jPZMM1s/aFJpc/k/c8cMFhhiOV/TkJle7wm2mG6taICU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430857; c=relaxed/simple;
	bh=XqKUL6PEj2w3yGnDvCFP5iYhWwifl9fcAkAZ+Lvf5m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEvruexD+sSH3AtkxnwDdAk9tLMkNOyQEZBAu5mtDClM8gs0CN+Pg9HMTx8WsiY1y/jm4g6krQlo46LQwCnWrHaKaOia+g4wRMwsazu9GWxsXk2syElg7o2YHqSx9uLeRiHE51N/mJ6edrS3iiE3b5no6eDMiXK6vVcI0OWY1BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1CX2RCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5826DC4CEC2;
	Wed,  4 Sep 2024 06:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725430856;
	bh=XqKUL6PEj2w3yGnDvCFP5iYhWwifl9fcAkAZ+Lvf5m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d1CX2RCwSXHJgdMt7ZU/FvX6Q+58x3EsWxxiq10DcjYzX0ehrL939LU5gHSqJiNd6
	 6hguHW0RuDrJe5XDKjz6OJpZWbi6NWX0bce4l1NbwxtLUS+QrbLj1U50B6YeivMTXu
	 kjuH6SdCs1WdqFHwRx/j4C5zzZkADDzTJ6DnC9pQjzI9J1lt6F4WmNBZsQgkAgSFgF
	 yZxkQ4cQnYG1bOTtNTKTJhMK5HLDmJeKp7YBh9TYPsdPtrdblFuX8VisXjD7UgFuhQ
	 H+rtWYeznSalOj9IkYsfZJmztzTaH9S7/0vHfRP+bLRqIeVkB5FWN6XJMc8/2eDwvC
	 UszGS3FIk/0lg==
Date: Wed, 4 Sep 2024 08:20:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mariel Tinaco <Mariel.Tinaco@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Conor Dooley <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: add docs for ad8460
Message-ID: <pp3r4ygrialun2x6vtghp27ianggjzs3g3436b6mi6mttfy57a@q7kcwolkkn27>
References: <20240904023040.23352-1-Mariel.Tinaco@analog.com>
 <20240904023040.23352-2-Mariel.Tinaco@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240904023040.23352-2-Mariel.Tinaco@analog.com>

On Wed, Sep 04, 2024 at 10:30:39AM +0800, Mariel Tinaco wrote:
> This adds the bindings documentation for the 14-bit

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> High Voltage, High Current, Waveform Generator
> Digital-to-Analog converter.
> 
> Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>
> ---
>  .../bindings/iio/dac/adi,ad8460.yaml          | 154 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 161 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml

> +  adi,range-microvolt:
> +    description: Voltage output range specified as <minimum, maximum>
> +    oneOf:

This oneOf does not make sense. There is only one condition. Drop.

> +      - items:
> +          - enum: [0, -10000000, -20000000, -30000000, -40000000, -55000000]
> +          - enum: [10000000, 20000000, 30000000, 40000000, 55000000]

What's the default? It's not a required property.

> +
> +  adi,range-microamp:
> +    description: Current output range specified as <minimum, maximum>
> +    oneOf:
> +      - items:
> +          - enum: [-50000, -100000, -300000, -500000, -1000000]

I don't understand why 0 is not listed here.

> +          - enum: [50000, 100000, 300000, 500000, 1000000]
> +      - items:
> +          - const: 0
> +          - enum: [50000, 100000, 300000, 500000, 1000000]
> +

What's the default? It's not a required property.

> +  adi,max-millicelsius:
> +    description: Overtemperature threshold
> +    default: 50000
> +    minimum: 20000
> +    maximum: 150000
> +
> +  shutdown-reset-gpios:
> +    description: Corresponds to SDN_RESET pin. To exit shutdown
> +      or sleep mode, pulse SDN_RESET HIGH, then leave LOW.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: Manual Power On Reset (POR). Pull this GPIO pin
> +      LOW and then HIGH to reset all digital registers to default
> +    maxItems: 1
> +
> +  shutdown-gpios:
> +    description: Corresponds to SDN_IO pin. Shutdown may be
> +      initiated by the user, by pulsing SDN_IO high. To exit shutdown,
> +      pulse SDN_IO low, then float.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks

Some supplies are for sure required. Devices rarely can operate without
power provided.

> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +additionalProperties: false

unevaluatedProperties instead.

Best regards,
Krzysztof


