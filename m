Return-Path: <linux-iio+bounces-8419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7134C94EEFE
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 15:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282132839D5
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 13:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21A0181B82;
	Mon, 12 Aug 2024 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wi54Mqfm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9356217E902;
	Mon, 12 Aug 2024 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470966; cv=none; b=ZR0NcT2k9r4HfDJml9RUsTnlf92LdTHZZkfc8TypR/bKt99UUwwjgGqKTCKorQEpppUpxZglbtrcw9voP2zwekUqq1sbNG/9nbnl6sqnHbuWS/9MUclDnG8JcJgaubSHZ6/Qr8/FtjI8ufeDgWFADp4YqMSTPiTF0G+aLd55K6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470966; c=relaxed/simple;
	bh=GTR3DnfBi9dZ7CspCPQKAAliJgS85XfsdaOrowMKtFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPLMAHKufPba2EMathI0s+FFLGwTDK8xBh/zHpshz9JPNjai0F48IpGRuMtwfYSJPohFSxzsCSR7vYRUFyi/RrIyW1ZI6WTwtT+iofzdaAylqNPlOarBdhztFeQr3kL2jWM+CpIDih5j18j0QIWdxE43GseyAUMGIdcZTPPogZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wi54Mqfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B434C32782;
	Mon, 12 Aug 2024 13:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723470966;
	bh=GTR3DnfBi9dZ7CspCPQKAAliJgS85XfsdaOrowMKtFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wi54MqfmZ20q1kqeTBMgQKudL+Vq4w3L2TGSF+FSjc8Jcz2BZdpX5kmXeBTLGvJrZ
	 ogp8DCahVjaLhB3eSsQ2NyV41/xrZ2AqBoGOy+q8XzViZ7bpGgv8x3y4jHBv/D31Eo
	 yMoOKN4aMNKNpkl7R1+JFpHNNrUsRbcS+uy+WyttR/NmlhvhNrlMCNAmTPCXqZAG6Y
	 dqnhj08HGLFMzAkDyfCQ3YbLbAb/ufQJw9ThoDE7S1W+JrmGHQFUzWclCsC/oP8OWr
	 O9x4S1GauCCcvdiM3i8ukdWPjcauok52j7brflZD3ijxWVEyr+pLrdE9NPE7L8aAh6
	 S6f61GxWKfCVg==
Message-ID: <c1e63a22-2dd7-48ab-9b98-ffd9f8b08a1b@kernel.org>
Date: Mon, 12 Aug 2024 15:55:58 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc: add AD762x/AD796x ADCs
To: Trevor Gamblin <tgamblin@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Lechner <dlechner@baylibre.com>,
 Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20240809-ad7625_r1-v2-0-f85e7ac83150@baylibre.com>
 <20240809-ad7625_r1-v2-1-f85e7ac83150@baylibre.com>
 <03eca85c-50d7-4ff0-a5b6-83e3322cb04d@kernel.org>
 <f8a7754e-0f6b-4802-985b-d8817892ecbb@baylibre.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <f8a7754e-0f6b-4802-985b-d8817892ecbb@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/08/2024 15:41, Trevor Gamblin wrote:
> 
> On 2024-08-10 8:10 a.m., Krzysztof Kozlowski wrote:
>> On 09/08/2024 20:41, Trevor Gamblin wrote:
>>> Add a binding specification for the Analog Devices Inc. AD7625,
>>> AD7626, AD7960, and AD7961 ADCs.
>>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> +allOf:
>>> +  - if:
>>> +      required:
>>> +        - ref-supply
>>> +    then:
>>> +      # refin-supply is not needed if ref-supply is given
>> Not needed or not allowed? Schema says the latter.
> Yes, this is poor wording on my part. I will fix it to say "not allowed".

so just drop it. No need to repeat schema - it is obvious from the
comment. OTOH, if you want to keep any of such comments, then make it
useful - explain WHY it is not allowed. Because the WHY is not visible
from the code.

>>
>>> +      properties:
>>> +        refin-supply: false
>>> +  - if:
>>> +      required:
>>> +        - refin-supply
>>> +    then:
>>> +      # ref-supply is not needed if refin-supply is given
>>> +      properties:
>>> +        ref-supply: false
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - adi,ad7625
>>> +              - adi,ad7626
>>> +    then:
>>> +      properties:
>>> +        en2-gpios: false
>>> +        en3-gpios: false
>>> +        adi,en2-always-on: false
>>> +        adi,en3-always-on: false
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - adi,ad7960
>>> +              - adi,ad7961
>>> +    then:
>>> +      # ad796x parts must have one of the two supplies
>>> +      oneOf:
>>> +        - required: [ref-supply]
>>> +        - required: [refin-supply]
>> That's duplicating first and second if. And all three - comment, first
>> if:then: and this one here is kind of contradictory so I don't know what
>> you want to achieve.
> 
> It sounds like there's a better way for me to specify this, but I'm not 
> exactly sure how.
> 
> The AD762x parts can operate without external references, so the intent 
> was that neither REF nor REFIN was required in the bindings, but if one 
> is given then the other can't be.
> 
> For the AD796x parts, one of REF or REFIN must be provided, but not 
> both. If REFIN is provided, then REF doesn't need an input because a 
> reference voltage is generated on REF. If REF is provided, then REFIN is 
> tied to ground.
> 
> Maybe there's a simpler way for me to specify the whole block?

Ah, now I see. Looks correct. I am not sure if it could be coded simpler.

Best regards,
Krzysztof


