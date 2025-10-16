Return-Path: <linux-iio+bounces-25152-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C70BBE4588
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 17:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65CAA359CEA
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 15:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9894A34F475;
	Thu, 16 Oct 2025 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r216waoA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E71FC110;
	Thu, 16 Oct 2025 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629780; cv=none; b=aHzR1WxS3NQBKffX5gTH91cO0CtlyXVyHfkhkmeCtJHd2/S8aM3sI5vJyI+PgDagFlHugJ9c0/aHAIRqwjQsuFJneKJl9OXpkCswD8eJLiIuoCf5q7JnTCfzXZh/mpZrEE7S96D4tJIGp5XV/Ur+pSJn4Bqk6s0BlwtMGy8dmzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629780; c=relaxed/simple;
	bh=NFYIkBLM3OEB8SQa5m+C+i2IctqueXEd07opv0q3Ha8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfTN+0zWStjQyJNk+mdcrX2vA6+dfZDJtEdMkPLAzYwQmSYZug719AMgiHluWVTA98Lyte4GEHGbYgOI9CHNo6An3R2FQGlLvtk/PWsNF4Axikd9HaONU6des3kgjZpAVazzKf8GssUTuBxUZjmYJBjT5VaPSLU8PJYFTeZtLZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r216waoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED5EC4CEFB;
	Thu, 16 Oct 2025 15:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629779;
	bh=NFYIkBLM3OEB8SQa5m+C+i2IctqueXEd07opv0q3Ha8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r216waoA3F8fSYJdMEObu+or/nHQKg/gtyqN4IaCbsuXeNKnEXx3+xucAB8pCbOUZ
	 DRDVjPYOs3l9nZTvJVHRm6rs/mUKbsix5GIz3TC20qAL0hVzXP29yuR9Ku3vYEGR7i
	 b1XXLaNyg1kAXCewuEHk9b2IMIfjjgOx01ouNk5Im2/UG48QCaIzhh/bu2Y+/ieo0M
	 KUaMNoid/pJuX3ORjZ5D+7KCH1sLLzLpXaFecFyAcXOMbCDihu1nb0xJCDacLL+/3t
	 gFVuyW6JW4u0NjLpKRgIgH0XS+n2sNeGDnsLQ6njCo3LVh23+gfnL946BNdWnQwFUH
	 pwTWKPPF0JW5w==
Message-ID: <57def480-6f42-4f84-a9ff-3452520b3c3f@kernel.org>
Date: Thu, 16 Oct 2025 17:49:33 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: Add the Renesas RZ/N1 ADC
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pascal Eberhard <pascal.eberhard@se.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
 <20251015142816.1274605-2-herve.codina@bootlin.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251015142816.1274605-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/10/2025 16:28, Herve Codina (Schneider Electric) wrote:
> +  clocks:
> +    items:
> +      - description: APB internal bus clock
> +      - description: ADC clock
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: adc-clk

Just 'adc'

clk is redundant

> +
> +  power-domains:
> +    maxItems: 1
> +
> +  adc1-avdd-supply:
> +    description:
> +      ADC1 analog power supply.
> +
> +  adc1-vref-supply:
> +    description:
> +      ADC1 reference voltage supply.
> +
> +  adc2-avdd-supply:
> +    description:
> +      ADC2 analog power supply.
> +
> +  adc2-vref-supply:
> +    description:
> +      ADC2 reference voltage supply.
> +
> +  '#io-channel-cells':
> +    const: 1
> +    description: |
> +      Channels numbers available:
> +        if ADC1 is used (i.e. adc1-{avdd,vref}-supply present):
> +          - 0: ADC1 IN0
> +          - 1: ADC1 IN1
> +          - 2: ADC1 IN2
> +          - 3: ADC1 IN3
> +          - 4: ADC1 IN4
> +          - 5: ADC1 IN6
> +          - 6: ADC1 IN7
> +          - 7: ADC1 IN8
> +        if ADC2 is used (i.e. adc2-{avdd,vref}-supply present):
> +          - 8: ADC2 IN0
> +          - 9: ADC2 IN1
> +          - 10: ADC2 IN2
> +          - 11: ADC2 IN3
> +          - 12: ADC2 IN4
> +          - 13: ADC2 IN6
> +          - 14: ADC2 IN7
> +          - 15: ADC2 IN8
> +
> +additionalProperties: false

This goes just before example
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - '#io-channel-cells'
> +
> +dependencies:
> +  # None or both adc1-avdd-supply / adc1-vref-supply should be present
> +  adc1-avdd-supply: [ adc1-vref-supply ]
> +  adc1-vref-supply: [ adc1-avdd-supply ]
> +  # None or both adc2-avdd-supply / adc2-vref-supply should be present
> +  adc2-avdd-supply: [ adc2-vref-supply ]
> +  adc2-vref-supply: [ adc2-avdd-supply ]

Above seems unnecessary. The anyOf below should already enforce that, no?

> +
> +# At least one of avvd/vref supplies
> +anyOf:
> +  - required:
> +      - adc1-vref-supply
> +      - adc1-avdd-supply
> +  - required:
> +      - adc2-vref-supply
> +      - adc2-avdd-supply
> +



Best regards,
Krzysztof

