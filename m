Return-Path: <linux-iio+bounces-62-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE397EB5A4
	for <lists+linux-iio@lfdr.de>; Tue, 14 Nov 2023 18:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5E71F2509C
	for <lists+linux-iio@lfdr.de>; Tue, 14 Nov 2023 17:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88F72C19A;
	Tue, 14 Nov 2023 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMb2uT+v"
X-Original-To: linux-iio@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82912C198
	for <linux-iio@vger.kernel.org>; Tue, 14 Nov 2023 17:39:15 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEFF10A
	for <linux-iio@vger.kernel.org>; Tue, 14 Nov 2023 09:39:13 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-670e7ae4a2eso58481956d6.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Nov 2023 09:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699983553; x=1700588353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9XiKxA5VDNsAvUBLkxgGxX4wbMhEnlVk81pKqwltiZQ=;
        b=ZMb2uT+v7ygOzsfntA28Bh+4DWVDZGkW6HMt5NiRVBPEdNlR4Q+Qf9LGBSrpMd5MdI
         lGXAO0rNTQdfHlZ5fZWCjQBXqxiVjKSzVLFelsgYetMqebQoCgLig7DpEej3ZYxE3G8+
         AmvbWwb/21ZTqPLe/74l6y0FLBRYP/y7bGXxbw6g3dRdaCEiNucurH3ZUoT2Abpj/f6z
         2aJ2qAwyhAZi6QkviXw1Ol8GpZFP3yRO6wK4skwmad4Xun9dPWbvt8NUeGE2vwqqb4gu
         3s7IvBbqgtY2lx2hov7gZR4cKCt99OCPryZSUOMwoi25mpMK40Z402mAn5yh+fsgoWsX
         L0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699983553; x=1700588353;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XiKxA5VDNsAvUBLkxgGxX4wbMhEnlVk81pKqwltiZQ=;
        b=hmTYpy5EXtBDUvCWjB7T33dJ3Rrgr8nB0s9JhGZ8vK7O/bymh9Fyixk15MwNXeH5sN
         HfKWD4Yoxo/TNT0hatQtdrAuqw60Ra6eo5hKOlxNzLgp/uWwR2h84V4FFX40yUms02qq
         P3vEpZod6Z9W7vF7+BTc41oslD5JJXu7T8Eia7BbTS30N7gWSDeYKy2Z69o5aqafkpkP
         VgR1nvWa/AMxGzTLUBB8PzWak0poAvopsLiMeJJX4Hg2j98r+wf1P6D+OooLBvZxcoen
         4WEpT02nDbO/JA8oYzRJ0R8cvnNdD6jGhO3GjdiCJQ+C2mvtU8M++HFpCMo82Zxpm2Pt
         GNfw==
X-Gm-Message-State: AOJu0YynwUEC7G5mXBlFT2Q+M27yRs8/7EKk+hp6SA8klEJBQjUGfC7/
	Ss03z82qig55TYC4OZxwWer3qA==
X-Google-Smtp-Source: AGHT+IHyPfODvFvqlazTjiSu6P7NjTZkmBilmM93IuC7GXNUAOoY2aRTwpkj8O8rEzQl+QB2+V7iUw==
X-Received: by 2002:a0c:ebcb:0:b0:66f:b580:8836 with SMTP id k11-20020a0cebcb000000b0066fb5808836mr4364269qvq.1.1699983552768;
        Tue, 14 Nov 2023 09:39:12 -0800 (PST)
Received: from [172.25.83.73] ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id n12-20020a056214008c00b0066d1d2242desm3086378qvr.120.2023.11.14.09.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 09:39:12 -0800 (PST)
Message-ID: <124c97ca-0c2c-4b92-8d8e-99d589daf2da@linaro.org>
Date: Tue, 14 Nov 2023 18:39:09 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: ad7192: Add AD7194 support
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Maksim Kiselev <bigunclemax@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Cosmin Tanislav <demonsingur@gmail.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Ibrahim Tilki <Ibrahim.Tilki@analog.com>, ChiaEn Wu <chiaen_wu@richtek.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231105193132.47009-1-alisadariana@gmail.com>
 <20231105193132.47009-3-alisadariana@gmail.com>
 <e5c9eaaa-a8f3-4ca5-acf6-9ff714a07898@linaro.org>
 <500eec71-e2f4-4f43-8bc9-6d4914b2493c@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <500eec71-e2f4-4f43-8bc9-6d4914b2493c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/11/2023 17:02, Alisa-Dariana Roman wrote:
> On 06.11.2023 10:56, Krzysztof Kozlowski wrote:
>> On 05/11/2023 20:31, alisadariana@gmail.com wrote:
>>> From: Alisa-Dariana Roman <alisa.roman@analog.com>
>>>
>>> Unlike the other AD719Xs, AD7194 has configurable differential
>>> channels. The default configuration for these channels can be changed
>>> from the devicetree.
>>>
>>> Also add an example for AD7194 devicetree.
>>>
>>> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
>>> ---
>>>   .../bindings/iio/adc/adi,ad7192.yaml          | 69 +++++++++++++++++++
>>>   1 file changed, 69 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>> index 16def2985ab4..b9a9f7b20670 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>> @@ -21,8 +21,15 @@ properties:
>>>         - adi,ad7190
>>>         - adi,ad7192
>>>         - adi,ad7193
>>> +      - adi,ad7194
>>>         - adi,ad7195
>>>   
>>> +  '#address-cells':
>>> +    const: 1
>>> +
>>> +  '#size-cells':
>>> +    const: 0
>>> +
>>>     reg:
>>>       maxItems: 1
>>>   
>>> @@ -96,6 +103,31 @@ required:
>>>     - spi-cpol
>>>     - spi-cpha
>>>   
>>> +patternProperties:
>>> +  "^channel@([0-9a-f])$":
>>> +    type: object
>>> +    $ref: adc.yaml
>>> +    unevaluatedProperties: false
>>> +
>>> +    properties:
>>> +      reg:
>>> +        description: The channel index.
>>> +        minimum: 0
>>> +        maximum: 7
>>
>> Your pattern a bit above is not correct then: [0-7]
>>
>>> +
>>> +      diff-channels:
>>> +        description: |
>>> +          The differential channel pair for Ad7194 configurable channels. The
>>> +          first channel is the positive input, the second channel is the
>>> +          negative input.
>>> +        items:
>>> +          minimum: 1
>>> +          maximum: 16
>>> +
>>> +    required:
>>> +      - reg
>>> +      - diff-channels
>>> +
>>>   allOf:
>>>     - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>>   
>>> @@ -127,3 +159,40 @@ examples:
>>>               adi,burnout-currents-enable;
>>>           };
>>>       };
>>> +  - |
>>> +    spi {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        adc@0 {
>>> +            #address-cells = <1>;
>>> +            #size-cells = <0>;
>>> +            compatible = "adi,ad7194";
>>> +            reg = <0>;
>>> +            spi-max-frequency = <1000000>;
>>> +            spi-cpol;
>>> +            spi-cpha;
>>> +            clocks = <&ad7192_mclk>;
>>> +            clock-names = "mclk";
>>> +            interrupts = <25 0x2>;
>>> +            interrupt-parent = <&gpio>;
>>> +            dvdd-supply = <&dvdd>;
>>> +            avdd-supply = <&avdd>;
>>> +            vref-supply = <&vref>;
>>> +
>>> +            adi,refin2-pins-enable;
>>> +            adi,rejection-60-Hz-enable;
>>> +            adi,buffer-enable;
>>> +            adi,burnout-currents-enable;
>>> +
>>> +            channel@0 {
>>
>> Why cannot you add this to the existing example?
>>
>>
>>
>> Best regards,
>> Krzysztof
>>
> I added another example to highlight the fact that only AD7194 supports 
> configurable channels. How should I proceed?

Bindings did not tell that, so it seems you miss that part - allOf
constraining channels per variant.

Best regards,
Krzysztof


