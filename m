Return-Path: <linux-iio+bounces-215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4A77F29E9
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 11:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A0F4B21280
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 10:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E806E3D38A;
	Tue, 21 Nov 2023 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnrlbR5r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D688ABA;
	Tue, 21 Nov 2023 02:14:02 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b3f6dd612cso3291374b6e.3;
        Tue, 21 Nov 2023 02:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700561642; x=1701166442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2rBM84BPH3h1OTNeKF8gkahQrwyTUFEFO20bhp2Xhd8=;
        b=NnrlbR5r2soU9t9TIxVn4YCusKvlrRaEi0T8vpS8rWNE+v5AsTWn9/BZRr0voePTJ5
         QEHDRO4gXSuBe7Lv4RFCKHi29Z5vzwejmjSltA8PhW9+2wcK0PBxYM3pQ9Q5deSiWnSe
         2rm7mEjEDuFUGgW2/psCCHo3+trO66a2MGh5zN8/WOs73A25an1jKkzfFKEJcVDR8hGS
         ATkdtpwRIkdh4IGk+mRCKzB4VwcoBsDSz5c6B7AL3WRBfA4YAmTRJRfY9GfYFgCen6Xk
         ataR/stE8KyTMbn0X5lY2pjHuXs2lyQZYfY/rJixs7ICYw0a0YowXHzDMuTjkfPX+Z+T
         9uuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700561642; x=1701166442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rBM84BPH3h1OTNeKF8gkahQrwyTUFEFO20bhp2Xhd8=;
        b=lyrUmH7F0xDY6rQw2zatLt4YtEUoB35hleeUWE/o1nC9kevJNk2aD38Xi5ucWSrHlj
         ViF/vgq7YmyuFTVLp2D/Mm5v3ljqaAm4dfVLIIshRJbUV8U5GX9KBjS8NOLw9i68KUTk
         /7i2Ce///a1Fha1IjHDCOrfcX7MeaL1lioXj6vxzEXlmrW5YN+HdXRdKW2bnW96NJyCq
         jQHDkCd4AxkUa+y1Rv4DfeVkAwDYaJ28x63ANGovTsDY7TXpqBoL3eubfAuE/DFUEnPl
         GkanEsWQbp1+mIVN/nbw0++5v4difDly7S2kZ4Zrj8LJWA3ePCVRLkQ2UwmbaaWlEUkv
         BPkw==
X-Gm-Message-State: AOJu0YxBGzATvMOISZ+kPK7dVUoKe/DO/7QFlSjfRcwkKkrbImRu/jJG
	bjKTGblZ7xUy5Tj7jc5rQCMM3XEDqQbKsg==
X-Google-Smtp-Source: AGHT+IGhEXVp30ly+W+J0Vq5BReMmqT7YvixSbVC5mluqZTiIrvaPLLb925ROrcuhxW/NFuCjXOCsQ==
X-Received: by 2002:a05:6871:7b0c:b0:1f5:c7bb:8f2d with SMTP id pf12-20020a0568717b0c00b001f5c7bb8f2dmr12045321oac.35.1700561642127;
        Tue, 21 Nov 2023 02:14:02 -0800 (PST)
Received: from ?IPV6:2401:4900:2353:8963:b940:1ac0:2fbc:6b6? ([2401:4900:2353:8963:b940:1ac0:2fbc:6b6])
        by smtp.gmail.com with ESMTPSA id f2-20020a056a0022c200b0064fd4a6b306sm7538948pfj.76.2023.11.21.02.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 02:14:01 -0800 (PST)
Message-ID: <4eb9d00a-a672-40a8-a923-d728432b1250@gmail.com>
Date: Tue, 21 Nov 2023 15:42:18 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: chemical: add aosong,ags02ma
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Jonathan Cameron <jic23@kernel.org>
References: <20231121095800.2180870-1-anshulusr@gmail.com>
 <20231121095800.2180870-2-anshulusr@gmail.com>
 <81149957-0403-4e41-8405-77ef8bfa3c8c@linaro.org>
Content-Language: en-US
From: Anshul Dalal <anshulusr@gmail.com>
In-Reply-To: <81149957-0403-4e41-8405-77ef8bfa3c8c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/21/23 15:33, Krzysztof Kozlowski wrote:
> On 21/11/2023 10:57, Anshul Dalal wrote:
>> Add bindings for Aosong AGS02MA TVOC sensor.
>>
>> The sensor communicates over i2c with the default address 0x1a.
>> TVOC values can be read in the units of ppb and ug/m^3 at register 0x00.
>>
>> Datasheet:
>>   https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
>> Product-Page:
>>   http://www.aosong.com/m/en/products-33.html
>>
> 
> 
>> +---
>> +$id: http://devicetree.org/schemas/iio/chemical/aosong,ags02ma.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Aosong AGS02MA VOC Sensor
>> [..]
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        light-sensor@1a {
> 
> 
> You called it chemical, so why this is here light-sensor?

I was working on a binding for a light sensor in parallel at that time,
I probably forgot to change this when copying the example from the light
sensor.

Would be replaced by "voc-sensor" in the next revision, apologies for
any inconvenience.

Thanks for the review.

Best Regards,
Anshul

