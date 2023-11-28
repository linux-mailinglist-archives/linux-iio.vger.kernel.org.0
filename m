Return-Path: <linux-iio+bounces-452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A9F7FB6C7
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 11:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE241C2139B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Nov 2023 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039944D586;
	Tue, 28 Nov 2023 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gVf67ccn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC251A5
	for <linux-iio@vger.kernel.org>; Tue, 28 Nov 2023 02:10:02 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54bb9024378so260267a12.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Nov 2023 02:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701166201; x=1701771001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRKLm3GeDhVb7hzoc89dRTVqf1sUD3rpLsrtfhJVINk=;
        b=gVf67ccnRsQU+rlz6Qs68F3PtG0lnED3M2YyM1tD6IxE4mkCOFr21Z/GUVGtjS764f
         X4Dz90cTkAwZLbYDy6hPGhE8AjtprY7OKUJrTEs759ouG5timDd1wI/gRpqUuAACXBVo
         jMHkGJgwSy1KHzixWvXDWEIMffFGCPn9NsNHSmcwM+PXQLBEM+Dz86sc6zqwAVqlsd2l
         lZuArOrbrkymS3R6PpdcApEgy64Hf3kGhCrlK3lT57AvIaA4hegAjh1eAcQUYd6Rk8ji
         ikAZJvkYHQNIyVGVAEApPjsBRXCCKEGswZPbyCBB8GhhOX7LENI/OYyTjaTK5Wuv41q5
         JXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701166201; x=1701771001;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRKLm3GeDhVb7hzoc89dRTVqf1sUD3rpLsrtfhJVINk=;
        b=DPEKYP3dGK1VbSJcNaAakyykQsp3FukUFHhUANuk5sH/5nPgOBjH1z+nwNqx3CdAM8
         oyVy6gGP2TTfkmMVDsTXUQwVkG5qhvYMaTyPiekQpjn3wc1UV28mpUB9sl+kDrOaIfc4
         rQJHddRV67eY8dinjxfzMNmvw73b4NnjJvRF1F0/gY1UGiV6U+PPrMe6smPitzyNRaEP
         HCsAlj7AH2gcD5IJ8+0gxW/lEwfT0uyi5hh2AfKthPMPdBWfy1sxDZwbLsKgIUNolWrI
         NXS+AY7RZ9kE4R9RbZJXVWVBjldx0aHgcV9fDQmkxeAik5+S5n2sSLtfamDD11DG60Tg
         Sj6A==
X-Gm-Message-State: AOJu0Yx6DS+CO4/IaauMt1UsztMxWuV2OIfCpgvW/QJuB7A0TiOKbf4l
	9NxVQXYvFkG1AUhGY6Sljxf5yg==
X-Google-Smtp-Source: AGHT+IGWSEQ3rImrnDAk5hKWtdzbYU4YuZiUnIPIi+N4a087UizInSNl0ZSrWCzYJcaYH0wMyX0ykQ==
X-Received: by 2002:a17:906:41:b0:a09:589f:94b4 with SMTP id 1-20020a170906004100b00a09589f94b4mr9269807ejg.63.1701166200750;
        Tue, 28 Nov 2023 02:10:00 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709067d8b00b009dddec5a96fsm6711516ejo.170.2023.11.28.02.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:10:00 -0800 (PST)
Message-ID: <b8c7cf3f-57bb-415e-872c-3ac69a52972b@linaro.org>
Date: Tue, 28 Nov 2023 11:09:57 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: adi,ad5791.yaml: Add support for
 controlling RBUF
Content-Language: en-US
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20231127-ad5791-michael-stuff-v1-0-04167b3edc56@analog.com>
 <20231127-ad5791-michael-stuff-v1-1-04167b3edc56@analog.com>
 <30a74f59-6230-48d5-a872-a9bee0cc5b4f@linaro.org>
 <5ad34779b6ad50f7f00c99f27e171f34628cebe0.camel@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <5ad34779b6ad50f7f00c99f27e171f34628cebe0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/11/2023 11:11, Nuno Sá wrote:
> On Tue, 2023-11-28 at 10:33 +0100, Krzysztof Kozlowski wrote:
>> On 27/11/2023 16:55, Nuno Sa via B4 Relay wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>
>> Subject: drop ".yaml"
> 
> Will do...
> 
>>
>>> This patch adds support for an external amplifier to be connected in a
>>
>> Please do not use "This commit/patch", but imperative mood. See longer
>> explanation here:
>> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
> 
> ack...
> 
>>
>>> gain of two configuration.
>>>
>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>>> ---
>>>  Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
>>> b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
>>> index 3a84739736f6..c81285d84db7 100644
>>> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
>>> @@ -26,6 +26,11 @@ properties:
>>>    vdd-supply: true
>>>    vss-supply: true
>>>  
>>> +  adi,rbuf-gain2-en:
>>> +    description: Specify to allow an external amplifier to be connected in
>>> a
>>> +      gain of two configuration.
>>
>> I don't understand this. Without this property external amplifier is not
>> allowed to be connected? This sounds like some policy, but should rather
>> focus on hardware.
>>
> 
> Well, this really translates in a different configuration in the device. If this
> is set then the device is configured to allow an external amplifier to be
> connected in a gain of two configuration which depends on the HW setup you want
> the chip to be.
> 
> The description already states pretty much what the datasheet says. So while I
> understand it's a fair question from you (you don't have the time to check all
> datasheets for reviews you do), I'm not sure there's much more to add into the
> description of the property.
> 

OK, it's fine there. With earlier fixes:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


