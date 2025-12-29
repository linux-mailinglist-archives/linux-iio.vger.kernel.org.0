Return-Path: <linux-iio+bounces-27407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B4CCE632B
	for <lists+linux-iio@lfdr.de>; Mon, 29 Dec 2025 09:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0AA53007273
	for <lists+linux-iio@lfdr.de>; Mon, 29 Dec 2025 08:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA317220F2C;
	Mon, 29 Dec 2025 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLc6qFRo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B862288B1
	for <linux-iio@vger.kernel.org>; Mon, 29 Dec 2025 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766995482; cv=none; b=P3OGSzADK6oFfABchurbFj+oH/mNwzirAlPrgPo2dG/2quDRSZh4eWkXIUKHKt9sKNLkUsJvQeXvdSwGXk/StgNzhjd4zE1ehZfmPYAVr6XRuUkUM290Tx7HmphFclV1gcuZOOZ97n6G+lHxk+jFKHF0ThVRjw9kTd24wuNyIoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766995482; c=relaxed/simple;
	bh=QGq4DPJ0jJ/rHKZagYA/Gwi/I8NZNKw39yi03vPCY6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2L46QefJ/GWxGybsVh/IXSqyxQrFbqgzFnOKY6YQpg8Bgffxu8bg0TVh/jCGc00qB50NTuh/L6IRdGjqe/pYTGX7+a/d97JLop0Kf5s7tg4GY1/ypCuzsHSUJd7j0VAEIxF6q9RfFoJ1EUE2WwJttbjYd9lq8dENaIDntSc+eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLc6qFRo; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-598eaafa587so10009659e87.3
        for <linux-iio@vger.kernel.org>; Mon, 29 Dec 2025 00:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766995479; x=1767600279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wxgtnknbp9U58qvY6RDKQlVjrvd1hHGIvUEbNeV4crE=;
        b=BLc6qFRoSzSMuhUVgLfr+SKtUyeDN56/SWuzC48loOe3rmTRkm2u4lidvNDywmKSc6
         mz2esSwArgp46wP8Of+G1P1cPtMWiyDkkY1gqvytByNBte7o5OYz4KXvXX/G6fqt5V0P
         seoYiDL+9PoqdZRrB1WMHZzjFZCEx1CX7e4Wvqle1Y/YHRPuzHnZybUliruJctCJf7yL
         neVsGA3XyIRIZhzIxFuUpiLNqzHBwwmSwtZWHogWKq/P1OD4S92F/HAqd8DNpBbA5enA
         qrDae9Xxk3FEwjhXfVvRKRx64AM0xfesOeCK6BIUMc7NoM/Og//qCO71l3ZDQ4Ln6iBp
         Oxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766995479; x=1767600279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wxgtnknbp9U58qvY6RDKQlVjrvd1hHGIvUEbNeV4crE=;
        b=OC5JQIGLdEO9InmdZUrrMrxY0Inu8Urrf/Mot76RSW2gvSeRZSkDufqsEVy/KaV/yN
         1XzhSiAFmBKvRH48+1mv3XOBx7lDVF5HaYRdax+mX9zcx0apvxDoy+9hb+2vy29e5lyO
         aX2tBpFXVQEuhraokx4hxCMRxDkX7rSO36SquU0tP2tKksrbfJyOSXaakIN2fcoeWkav
         4pOAyW21wpS2fLH492I1L8aw2lWLDdvn/Tj0rNn55mvwle+WJaUlkBXAM3XfRtpENNp6
         8Oz60c76YgVDMxQdmOtxD1mAp5qNII2fBHhY4Wn//VNCx1xSnFEZ4tnLGwpk86O+ISfc
         pGYw==
X-Gm-Message-State: AOJu0YyZwMoDexch9Brwrqt8A2aAoT7vEQp657gTMdid4C7A678rgwHJ
	njxXL4Ud/6hj2NEI4UocJgIGzL35EKo0IP+RwgNkPN3LOymjXLFMec8T
X-Gm-Gg: AY/fxX7mZerG6a3ijmXfES4TcgWUudtZzOwkYAighXBFNFKabJLyS+CuBKMuWTcR6Pb
	Vt8qx1fvTwJF9uc1AMaZVItvF00Z3ekHKyr7GOIvZjieJ2cPmh1VCeH5JvzAgRyf7/s0nmHT/Sf
	5R2s6YgHYg2+03TZIt+XjbX0P7s8GaMEIYrR0c9RGemWKy53OtJKbIFDSso4Qpoc0bFCOzr6jEQ
	jckDZWiZqo1LZbHlUNTi/RYhUZXvl/wXUizx1Hdd1I8M1XNCfUFvcbcsZWnUJVs887/d7P6VyeN
	hVgusKt9ZzA/pQFRtO3r7qT7qmY62klmeq2vnG9zXy4A/ZyhGGABQqYeRMhtBzJpf1ztsqT/yeL
	xKIqO7DAMNyFRlNnwqYhkPIS6DQosP1DT84c5j0umirNeRQ5LniVmB19c/HhOHxeYhWZl2RG+Fz
	h9E8iYOY8s/hAk99J7qFKz5aObMoOeEVoXburraqLsHBbleBG/kFfR6qniAhp4IdU8zSzw
X-Google-Smtp-Source: AGHT+IHv7BrFv+9Bmci9Wx37WLq70y+3/7ZdPTcagW7BQFhWX9hxw3OqjOFGnEeRtNerT1X0WbSrPA==
X-Received: by 2002:a05:6512:4016:b0:598:f4cb:aafd with SMTP id 2adb3069b0e04-59a17d958b8mr11139461e87.19.1766995478827;
        Mon, 29 Dec 2025 00:04:38 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b30f7c322sm4395390e87.59.2025.12.29.00.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 00:04:38 -0800 (PST)
Message-ID: <c386a4bd-9c7d-4b4d-b614-fdec424d57a0@gmail.com>
Date: Mon, 29 Dec 2025 10:04:36 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add Texas Instruments TLA 2528
To: David Lechner <dlechner@baylibre.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jonathan Cameron <jic23@kernel.org>, nuno.sa@analog.com,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Eason Yang <j2anfernee@gmail.com>,
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 duje@dujemihanovic.xyz, herve.codina@bootlin.com,
 Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <20251223155534.220504-1-maxime.chevallier@bootlin.com>
 <20251223155534.220504-2-maxime.chevallier@bootlin.com>
 <56c03c7f-1e5b-4586-beb0-47a1fa3bc86c@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <56c03c7f-1e5b-4586-beb0-47a1fa3bc86c@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/12/2025 20:26, David Lechner wrote:
> On 12/23/25 9:55 AM, Maxime Chevallier wrote:
>> The TI TLA 2528 is a simple 8 channel, 12-bit ADC? Add a binding
> 
> TLA2528 (no space). Also, why the "?"?
> 
>> documentation for it.
>>
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>> ---
>>   .../bindings/iio/adc/ti,tla2528.yaml          | 48 +++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml b/Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
>> new file mode 100644
>> index 000000000000..0ee326d77014
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
>> @@ -0,0 +1,48 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/ti,tla2528.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments TLA2528 8-channel 12bit I2C ADC
> 
> 12-bit
> 
>> +
>> +maintainers:
>> +  - Maxime Chevallier <maxime.chevallier@bootlin.com>
>> +
>> +description: |
>> +  12bit 8-channel I2C ADC.
> 
> The title already says this. Either drop it or add new info.
> 
> Also, don't need the |.
> 
>> +
>> +properties:
>> +  compatible:
>> +    const: ti,tla2528
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  vref-supply:
>> +    description: Supply for 2.35V to 5.5V reference voltage
> 
> According the the datasheet, there are AVDD and DVDD supplies.
> Nothing named VREF or REF.
> 
> So instead:
> 
> avdd-supply: true
> dvdd-supply: true
> 
> 
> It looks like inputs can also be used as GPIOs, so
> 
> gpio-controller: true
> #gpio-cells:
>    const: 2
> 
> would be appropriate (it doesn't matter if the driver doesn't
> implement it, we know what the correct bindings are).
> 
>> +
>> +  "#io-channel-cells":
>> +    const: 1

I didn't check the data-sheet, but if the pins can be set to be GPIOs or 
ADC inputs, then I would require channels to be specified. It's only 8 
channels, so always listing channels that are present shouldn't be that 
big of a problem - and it should avoid one to add extra properties to 
denote channels used for GPIO if GPIOs need to be supported.

Well, I am not insisting this, there are folks that know this stuff 
better than I :)


Yours,
	-- Matti

---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

