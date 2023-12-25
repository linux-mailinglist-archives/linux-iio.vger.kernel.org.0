Return-Path: <linux-iio+bounces-1256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A0381E0E8
	for <lists+linux-iio@lfdr.de>; Mon, 25 Dec 2023 14:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5361F22195
	for <lists+linux-iio@lfdr.de>; Mon, 25 Dec 2023 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5440C524B8;
	Mon, 25 Dec 2023 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DdP6NzjU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D951C5A
	for <linux-iio@vger.kernel.org>; Mon, 25 Dec 2023 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-554cffbad2fso795570a12.1
        for <linux-iio@vger.kernel.org>; Mon, 25 Dec 2023 05:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703511245; x=1704116045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4o+SIPtv+npV17Pzay9SK/koHZbp3RfZeUHqh9OZTU=;
        b=DdP6NzjUST8X9/NEzhCWV1fK+qUHQ3rxPtsSYYJV/CbQcU2uBK2ZQOxtwqJr9NTjqh
         eYrhoJySlZmDJzyFfIqv82obOxL/u2wYPoA1QRFUvKzavE8lqG6H1sUebaOEJqt5/Izi
         kks8umYmF6JjaTH2Q75GjTNLrecmBPBEK1LddlKusRgQZH6MP6SfCLHUFRSJh6DKzsRj
         XEQh01QBUfVoZIYP3rBtXWM5jvQknO8oi68hR43eX0vmbBA0GlDTZXwKMYRktmaIcqq+
         /7bnyBUpOv5okZiSwLWt+/WVqtCXM558tVath2nZBGt9hWfDYn3TONpf1XwxXUYlITNa
         E2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703511245; x=1704116045;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4o+SIPtv+npV17Pzay9SK/koHZbp3RfZeUHqh9OZTU=;
        b=kRiAiBPFuu0xrKT4Wpicuqj44uZsUGEcXnfMN+G7iAXTdHKOT12T8lr0gdwWJgUuab
         ywzDvR5vE1vHm8kEaDJe910AFtIbPTnw1vOZEVWituh+G5FLpwZp7jllOYc63SANGPXF
         a9hqUDROW7AdKOgcVmcfsIV8eI35fJ0eoplM9GaVz7Xz6mJFn0vlQXUhJia6VdSLx54C
         eBq5CJCf7wHqiMWMIUcmHE8cij+Ftzxghvh/75Wb0azuTfvFonFfcR0ytS7p05QcLxAQ
         0Ol3yTUbmvLIRFfd4urNkVzsYr6PoByzJMG0/2lsWt/2DNFpZ8EiVc1951twZra4GorQ
         k+8g==
X-Gm-Message-State: AOJu0Yw7QncNr4apHVxrjDAWmYzhNRPLq2A3tFVM3ttiCjBzCmxaz7zw
	fNpuneSsCWVOicic21DCwKiKl6yyJP9Mhg==
X-Google-Smtp-Source: AGHT+IFDGGIxW1fwuPVpBx1JXx4XqM9Okg4nVldObZOLTNFVBfgoGvIR0pErEjihDwzUpJwqoOv/zQ==
X-Received: by 2002:a50:935a:0:b0:54c:b889:9c11 with SMTP id n26-20020a50935a000000b0054cb8899c11mr2380971eda.98.1703511245435;
        Mon, 25 Dec 2023 05:34:05 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id en2-20020a17090728c200b00a2609ff4119sm773235ejc.213.2023.12.25.05.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 05:34:05 -0800 (PST)
Message-ID: <503bc876-59d1-4fcb-b0b5-2dd88c62987c@linaro.org>
Date: Mon, 25 Dec 2023 14:34:04 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] dt-bindings: iio: pressure:
 honeywell,mprls0025pa.yaml add pressure-triplet
Content-Language: en-US
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
 <20231224143500.10940-3-petre.rodan@subdimension.ro>
 <49525adf-1540-4801-8cdf-be1c0fe640f6@linaro.org> <ZYmCOVvgcElnxRuH@sunspire>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZYmCOVvgcElnxRuH@sunspire>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/12/2023 14:23, Petre Rodan wrote:
> 
> hello Krzysztof,
> 
> On Mon, Dec 25, 2023 at 01:57:39PM +0100, Krzysztof Kozlowski wrote:
>> On 24/12/2023 15:34, Petre Rodan wrote:
>>> @@ -54,14 +57,6 @@ properties:
>>>        If not present the device is not reset during the probe.
>>>      maxItems: 1
>>>
>>> -  honeywell,pmin-pascal:
>>> -    description:
>>> -      Minimum pressure value the sensor can measure in pascal.
>>> -
>>> -  honeywell,pmax-pascal:
>>> -    description:
>>> -      Maximum pressure value the sensor can measure in pascal.
>>> -
>>>    honeywell,transfer-function:
>>>      description: |
>>>        Transfer function which defines the range of valid values delivered by the
>>> @@ -72,17 +67,52 @@ properties:
>>>      enum: [1, 2, 3]
>>>      $ref: /schemas/types.yaml#/definitions/uint32
>>>
>>> +  honeywell,pressure-triplet:
>>
>> Why not putting it just before existing properties?
> 
> I'd like to have pmin-pascal, pmax-pascal as the last two honeywell specific
> properties, since they are not to be used unless someone has custom silicon.
> so we will still have a block moved just like above.
> the most logic order is the one I proposed above:
> 
> honeywell,transfer-function:
> [..]
> honeywell,pressure-triplet:
> [..]
> honeywell,pmin-pascal:
> [..]
> honeywell,pmax-pascal:
> [..]
> 
> since the last 3 are tied together as we will see below.
> is there any reason you want this order to change?

I just don't get why moving the code instead of adding new property next
to them.

The order is often alphabetical.

> 
>>> +  honeywell,pmin-pascal:
>>> +    description:
>>> +      Minimum pressure value the sensor can measure in pascal.
>>> +      To be specified only if honeywell,pressure-triplet is not set.
>>
>> The last sentence is redundant - schema should enforce that.
> 
> when someone generates the dtbo files via
> 
> cpp -nostdinc -I include -I ${LINUX_SRC}/include/ -I arch -undef -x assembler-with-cpp ${file}.dts "${BUILD_DIR}/${file}.dts.preprocessed"
> dtc -@ -I dts -O dtb -o "${BUILD_DIR}/${file}.dtbo" "${BUILD_DIR}/${file}.dts.preprocessed"

And how this command matters? DT overlays are checked, so error is printed.

> 
> the schema is not checked in any way.

When I run `make` the schema is also not checked, so is it an argument
to add anything to the binding? No. Drop redundant text.

> so unless people can be bothered to understand the yaml intricacies in the
> bindings file, I feel they need to see that redundant information there, see below.



> 
>>> +oneOf:
>>> +  - required:
>>> +      - honeywell,pmin-pascal
>>> +      - honeywell,pmax-pascal
>>> +  - required:
>>> +      - honeywell,pressure-triplet
>>> +
>>> +allOf:
>>> +  - if:
>>> +      required:
>>> +        - honeywell,pressure-triplet
>>> +    then:
>>> +      properties:
>>> +        honeywell,pmin-pascal: false
>>> +        honeywell,pmax-pascal: false
>>
>> This allOf is not needed.
> 
> speaking for intricacies, if the allOf is removed, then a binding containing
> 
> honeywell,pmax-pascal = <840000>;
> honeywell,pressure-triplet = "0015PA";
> 
> would be considered to be correct by the schema, but that would be the incorrect
> result. so afaict allOf needs to stay, and so does the redundant text.

Really? Did you test it?

Best regards,
Krzysztof


