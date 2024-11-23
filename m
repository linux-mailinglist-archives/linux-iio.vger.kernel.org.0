Return-Path: <linux-iio+bounces-12548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884C39D69E4
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 17:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03677161792
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324565103F;
	Sat, 23 Nov 2024 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcovsgUL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D978F376E0;
	Sat, 23 Nov 2024 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732378304; cv=none; b=L5cnusfM710XRSmQmcS1cecLO6LeCZTtv143SDmgeXxxbuKLLl9sxytPu3Pj1mv5OLiJ5Tf2d5U+OZ23Fab+GaZigljOl+GMIbIwdeNQexRPKg7B/TdreVRWV673V2olPjd2t88D/4eaJnLE0mYdlH/Dxdmftd71it/3SpT1D/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732378304; c=relaxed/simple;
	bh=g18tIdDWIrEz/MlWEIRwjzIdSb4DyithcPpWM1gVK2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGdyq4YKMIC2vB/Cuz8HKoaPtbWIHorj/iy4Exp9J8WkYpsu/v0A5Eydb4uQo7j3ysilTQzqKtnZxV6PAFBrMpgFEtqQbOYzJVV8e/PyJFgJzZcqW0b+YQqfgvbNXVtYLg2xgWCNYb4m2VE6JYTvqr+xcdqaOPJPJLZMh6haP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcovsgUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643FAC4CECD;
	Sat, 23 Nov 2024 16:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732378303;
	bh=g18tIdDWIrEz/MlWEIRwjzIdSb4DyithcPpWM1gVK2c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CcovsgULrYrYuDeXclH0/UykDUBz5A1nT3jz2ljUOglzJcKv0KII02nUPvubzaSWK
	 Tlrw1x9F1CtgR3KMC5DmTYCwXGhS9nsFG7r6vjD67pUcKH4uoqgSQcCTVk/wk2WxkH
	 i4jofVOdPwsv2gigF7nco7a+X8jzNrOlAqsS82IyyxkSzymC2of9tSllskTgfzLxwr
	 iBw6gqH5mEjcCeukH6ZbUUieQXDOT13lVXFqoE8QzAvINU7/0JlAcCeLTRtM3y2IYi
	 G+cTHaq5TgL48ojypt1KbolgjM99SNiIiU6D7e5dZbPyw+tnPcaO12qGRWJeDGc4UT
	 q3rMQXqmjywDg==
Message-ID: <7a512b1a-1b04-4fee-93e9-ddffc38233fc@kernel.org>
Date: Sat, 23 Nov 2024 17:11:36 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1732020224.git.marcelo.schmitt@analog.com>
 <dd7fd54585e1230d2da86b5e3d4ed770256b0af2.1732020224.git.marcelo.schmitt@analog.com>
 <5kz6ghe56yiprlvhyduv7olcrajvejyvulcpjav6doiyvr6dcl@6qlt4nebp4gb>
 <Z0CkOTGhGhfV18OG@debian-BULLSEYE-live-builder-AMD64>
 <a311de1b-cd59-4f67-9bd1-61596a54c8cd@kernel.org>
 <Z0D0e6mNKlVAXp0z@debian-BULLSEYE-live-builder-AMD64>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Z0D0e6mNKlVAXp0z@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/11/2024 22:15, Marcelo Schmitt wrote:
> On 11/22, Krzysztof Kozlowski wrote:
>> On 22/11/2024 16:33, Marcelo Schmitt wrote:
>>>>
>>>>> +      - items:
>>>>> +          - enum:
>>>>> +              - adi,ad7942
>>>>> +          - const: adi,ad7946
>>>>> +
>>>>> +      - const: adi,ad7983
>>>>> +      - items:
>>>>> +          - enum:
>>>>> +              - adi,ad7980
>>>>> +              - adi,ad7988-5
>>>>> +              - adi,ad7686
>>>>> +              - adi,ad7685
>>>>
>>>> Keep alphabetical order.
>>>
>>> Do the fallbacks declared here have any impact on the match try order or on how
>>> the compatible list should be ordered?
>>
>> I don't understand, we do not talk about fallbacks. I also do not
>> understand at all how this relates to my comment.
> 
> I was wondering if the arrangement in which compatible strings appear in dt doc
> could be used to suggest the sequence to add them to the compatible property of a
> device node in a dts. Apparently, the arrangement of compatible strings in dt doc
> has nothing to do with how they can appear in a dts file. Will sort them in
> alphabetical order.

We talk here about enum. Enum enumerates, so obviously they cannot
appear one after another.

> 
>>
>>> The only significant difference between each group of devices is the sample rate.
>>> A faster device can read at slower sample rates so if somebody knows to have
>>> a 16-bit pseudo-differential PulSAR but doesn't know about the exact model they
>>> could have a compatible like
>>>       compatible = "adi,ad7980", "adi,ad7988-5", "adi,ad7686", "adi,ad7685",
>>>                    "adi,ad7988-1", "adi,ad7983";
>>
>> Can't you autodetect this?
> 
> There is no way of detecting the maximum sample rate other than the compatible
> string or, maybe, running a data capture.


Devices do not have version/revision/model register?

> 
>>
>>>
>>> to try from fastest to slowest device.
>>> The dt doc would indicate that order in the fallback list?
>>>       - items:
>>>           - enum:
>>>               - adi,ad7980    # Fastest 16-bit pseudo-differential ADC
>>>               - adi,ad7988-5  # 2nd fastest 16-bit pseudo-differential ADC
>>>               - adi,ad7686    # 3rd fastest 16-bit pseudo-differential ADC
>>>               - adi,ad7685    # 4th fastest 16-bit pseudo-differential ADC
>>>               - adi,ad7988-1  # 5th fastest 16-bit pseudo-differential ADC
>>>           - const: adi,ad7983 # Slowest 16-bit pseudo-differential ADC
>>
> [...]
>>>
>>> writing-bindings.rst says "DO use fallback compatibles when devices are the same
>>> as or a subset of prior implementations."
>>> But, how can we use fallbacks properly?
>>
>> How DT spec and tutorials like elinux ask... What is exactly the problem
>> or question?
> 
> Never mind. Do the bellow follow the preferred syntax?
> 
>       - items:
>           - enum:
>               - adi,ad7980
>               - adi,ad7685
>               - adi,ad7686
>               - adi,ad7988-1
>               - adi,ad7988-5
>           - const: adi,ad7983
> 
>       - items:
>           - enum:
>               - adi,ad7688
>               - adi,ad7693
>           - const: adi,ad7687
> 
>       - items:
>           - enum:
>               - adi,ad7982
>               - adi,ad7984
>               - adi,ad7690
>           - const: adi,ad7691
> 
>       - enum:
>           - adi,ad7942
>           - adi,ad7946
>           - adi,ad7984

Yes

> 
>>
>>> From Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml I'm
>>
>> How LVDS bridge is related to this one here?
> 
> Aside from having compatible fallbacks, not related.
> 
>>
>>> inferring only one fallback should be provided per group of devices.
>>>
>>>>
>>>>> +              - adi,ad7988-1
>>>>> +          - const: adi,ad7983
>>>>> +
>>>>> +      - const: adi,ad7688
>>>>> +      - items:
>>>>> +          - enum:
>>>>> +              - adi,ad7693
>>>>> +              - adi,ad7687
>>>>> +          - const: adi,ad7688
>>>>> +
>>>>> +      - const: adi,ad7984
>>>>> +      - items:
>>>>> +          - enum:
>>>>> +              - adi,ad7982
>>>>> +              - adi,ad7690
>>>>> +              - adi,ad7691
>>>>> +          - const: adi,ad7984
>>>>> +
>>>>>    reg:
>>>>>      maxItems: 1
>>>>>  
>>>>> @@ -133,6 +178,32 @@ required:
>>>>>    - ref-supply
>>>>>  
>>>>>  allOf:
>>>>> +  # Single-channel PulSAR devices have SDI either tied to VIO, GND, or host CS.
>>>>> +  - if:
>>>>> +      properties:
>>>>> +        compatible:
>>>>> +          contains:
>>>>> +            enum:
>>>>> +              - adi,ad7685
>>>>
>>>> Why do you need this? It's fallback is already here.
>>>
>>> So dtbs_check can provide an error message if for example compatible = "adi,ad7687";
>>> and adi,sdi-pin = "sdi";
>>
>>
>> I mean this compatible, not if clause.
> 
> dtbs_check don't show an error message if the allOf list only has the fallback
> compatible for adi,ad7685 and a device node has both 
> compatible = "adi,ad7685" and adi,sdi-pin = "sdi".

It must and your compatibles should not affect it. I don't know which
code you are testing, but I even tested the correct approach and it
correctly shows error.


> 
> The new set of devices that will be supported by this binding don't have a
> configuration register like the previous ones did. Because the PulSAR devices
> don't have a config reg, they don't support all features of AD4000-like devices
> and thus fewer IIO ABI interfaces are provided to user space. Though, AD4000
> devices also can be wired in a way that no reg access is possible, in which
> case they provide the same IIO interfaces that PulSAR devices do. The difference
> is on what is connected to the peripheral SDI pin. When AD4000 SDI is connected
> to SPI controller MOSI line, more interfaces are provided because the config
> reg can be accessed to set additional features. But that is not an option for
> PulSAR devices. Even if controller MOSI is connected to a PulSAR device, we
> cannot provide the additional interfaces because every attempt to use them would
> fail (the device has no register to configure). No datasheets mentions
> connecting a PulSAR device SDI pin to a SPI MOSI line. All datasheets show
> PulSAR SDI pin connected either to VIO (high), GND (low), or controller CS.
> 
> IMHO, it would be nice to have dtbs_check warn about invalid SDI pin
> configuration otherwise it may only be noticed on driver probe.
> Anyway, I'm also fine keeping only the fallback compatibles in the allOf list
> if that makes dt maintainers happy.

Only fallbacks go there,


Best regards,
Krzysztof

