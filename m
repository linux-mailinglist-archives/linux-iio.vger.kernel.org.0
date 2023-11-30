Return-Path: <linux-iio+bounces-505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56A47FEE85
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 13:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 513C5B20E14
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 12:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1B03E482;
	Thu, 30 Nov 2023 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCVHg0bh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F07D46
	for <linux-iio@vger.kernel.org>; Thu, 30 Nov 2023 04:04:34 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a18f732dc83so53562066b.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Nov 2023 04:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701345873; x=1701950673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRCtcNkJ77JXUPZTujxx1H5XbSMZZjKvuPCS7KxSurY=;
        b=CCVHg0bhsJRzQDyuWcKxRXqSAR/LWbbfyB0dvVQ1Rm3GOA3KwWwXuRf8tO2WediAiv
         PvUfKqmnLclAhIXJ+9UEBcykahcyjFnjl6bvO8z4ltzr6eU2tTOs3byPWD6xworKGlZC
         q5Eq/iHns5tPx5C4hczEC8e7ppmPAfPMZlrUCZ+43qbHs1TS2M1/UGwcEIbNm0oIie8r
         Sz2TnFBMFCTW/ye4LpLdnE/bHz8eZ3pcRGfI5Z8R/aGBCheVV0fZ3eCl50+xg9qIiDRC
         uCFcDTW0EfQQX/tTtG+7Uy+YUpWC/qxXQxaCJxOoJ65NW6XInntUq0teVTqukDGR25at
         OR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701345873; x=1701950673;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRCtcNkJ77JXUPZTujxx1H5XbSMZZjKvuPCS7KxSurY=;
        b=uKwagweR2H4C2PqW/aTXs/FsIumAoV9o7zYq0Xv6BJF8q/rhYjifGeX3JEDpbNeMoj
         T/TcfMkHtJDilg1jl11tUHyhNBa6tojzR1HNcL+uDbp4pgNq7dMg11RhSm15/W5DYNkC
         ZJbZLKnQVZz1hvFBE/q/lypUyO3AA2D2o6U8v4O3GOH6m5iZj/8RIMXF79fmh0b9WSOs
         M/o2O6G9ROFwDj9rUo3eUT8vYaf0/ank1KnZL9izFWCs7DAuJbPVg5xymQSb7IQ1VXQz
         6AWbBRj6JQd3aniOJ4u+OSUnslWfCJu2lexNY7mudSZtFUROWRBjEu7vyNAxZoSBO18u
         GDpQ==
X-Gm-Message-State: AOJu0YwQDDsxtliZD9f/WsD59bJ2UtRoG+SML5r61yayamNp2iJM6vHj
	f/Us5Ibd35RFsI+VV0i5qoDQaA==
X-Google-Smtp-Source: AGHT+IEVI6Nlfc628ZBLtCCJLe63pG4/Qf38669I1Pt06984uhagdGU+5ELZAH/j2H3cuQ3N/VeyfA==
X-Received: by 2002:a17:906:1006:b0:a18:7350:82d with SMTP id 6-20020a170906100600b00a187350082dmr1405094ejm.16.1701345872912;
        Thu, 30 Nov 2023 04:04:32 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id v9-20020aa7d9c9000000b0054b1fca00c7sm486173eds.74.2023.11.30.04.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 04:04:32 -0800 (PST)
Message-ID: <ff066aef-b2f7-42db-b6bf-05bb4a7736a9@linaro.org>
Date: Thu, 30 Nov 2023 13:04:30 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Content-Language: en-US
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Jonathan Cameron <jic23@kernel.org>
References: <20231129170425.3562-1-petre.rodan@subdimension.ro>
 <1bda0a63-6fc9-4fc0-953b-7d618f77b268@linaro.org> <ZWhXgTZ-M3Qj7xoS@sunspire>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZWhXgTZ-M3Qj7xoS@sunspire>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/11/2023 10:36, Petre Rodan wrote:
> 
> good morning.
> 
> On Thu, Nov 30, 2023 at 09:31:45AM +0100, Krzysztof Kozlowski wrote:
>> On 29/11/2023 18:04, Petre Rodan wrote:
>>> Adds binding for digital Honeywell TruStability HSC and SSC series
>>> pressure and temperature sensors.
>>> Communication is one way. The sensor only requires 4 bytes worth of
>>> clock pulses on both i2c and spi in order to push the data out.
>>> The i2c address is hardcoded and depends on the part number.
>>> There is no additional GPIO control.
>>>
>>> Datasheet:
>>> https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf [HSC]
>>> Datasheet:
>>> https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf [SSC]
>>> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
>>
>> This is a friendly reminder during the review process.
>>
>> It looks like you received a tag and forgot to add it.
>>
>> If you do not know the process, here is a short explanation:
>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>> versions, under or above your Signed-off-by tag. Tag is "received", when
>> provided in a message replied to you on the mailing list. Tools like b4
>> can help here. However, there's no need to repost patches *only* to add
>> the tags. The upstream maintainer will do that for tags received on the
>> version they apply.
>>
>> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
>>
>> If a tag was not added on purpose, please state why and what changed.
> 
> thank you for the clarification.
> not going to lie, this entire process is overwhelming. I'm trying to generate
> the least amount of noise on this very busy list and yet here I am being the
> loudest one. who whould have thougth that being prudent and running two
> consecutive commands of `git send-email` would produce out-of-thread patches on
> your end, or that b4 or whatever you use would not pick up tags already present
> for a patch?
> 
> I'd like to thank everyone commenting on my stupid patch and rest assured that
> most of the mistakes you point out are a learning lesson on the receiving side.
> keep them coming and excuse the noise, it will fade away soon.
> 
> and regarding the bindings file, there have been no changes to it since the tag.
> 

Sure, no worries.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


