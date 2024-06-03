Return-Path: <linux-iio+bounces-5670-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 728B78D7F5D
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 11:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D271F20EE0
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 09:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FC584FCD;
	Mon,  3 Jun 2024 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGC/cocO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EF183CA3;
	Mon,  3 Jun 2024 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407975; cv=none; b=ByUfHKa0ShatoFNO6We/81Qnp9M6TQ6Ky1dpINPOLCmagESPgppYSYh5HeDda7A5TGVj/pVKRO58esXoD+L9I12UlL/pzkyUnBMJTO4RmoBM3FlKXNzZcdadyKO6Ife+RdGc7u3yKhX4qTvapJoJ3j+yf/F6QJ02nqBIwiT7NMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407975; c=relaxed/simple;
	bh=IufiulmqMrcrRzFQ22YYMKzsGUhBoCuQetCFFGWAepY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVP1qpxpHxlJLwlKD2zlTqJ/qZIFBJSXda6api1j6wPByT9oqZucBMBzUCwg0B+J5vbM+stlP4LDHhxfU+sjRikfHC1Tnvfe3q56yFTIj6iw+/NLFotP/KSJB2qbDy6I2PStU/DjOw3BAR4gJGd0HBMBQaVt7ZwQiZehfFggEZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGC/cocO; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a69024f2433so108343366b.2;
        Mon, 03 Jun 2024 02:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717407972; x=1718012772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qqb3EXks2EmyRdhzocsRq7snOHHNOo7GIMpgk1sEpAY=;
        b=RGC/cocOa7/YvnoYBRwaevgQOof6910e59Gg7C5cOvxTYX+hS/jRQ276QFGz94R+9O
         XVH9pb2OwSu1P7dBZsstIet0Kci4UErIej22AaUVd2Dj0jWSvOpGqoAsgsqFzSB+Zi27
         2btv/JUdwLNHSp2FI7ucDY3rS+Eu3G2RkXMuACdFONC9wpr5BHjYOilwqKZdjEF/8HCv
         U+Dpn6k/w9inex3TR0WrUS3Dyq2/7NEXpYDsLqR6LpwD8DUhivfW5YTGkECUtojI9LuO
         +YeK6GGJZqWJIR8aw/yntMueE2bGL5RTBNtTdBkc49U+A8u+3IzPQa8WBu9Dxa2Y84EH
         n7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717407972; x=1718012772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqb3EXks2EmyRdhzocsRq7snOHHNOo7GIMpgk1sEpAY=;
        b=QANLCHpcgiQNxkaFs321Fyj053U1m1Q8Czgqo67lTQkXFhtbkMEdTYnemEOFjeHPOM
         GEUF3Ff66z2ITyZqA6gkRB0+gJf6FXOuBaVJC/pnbSdoLNl59sF90odo1zm1qb57tF8N
         FLJmmzvyGpUYZuoAGfLedlmPQLIAT7O7mRsUPkwFt84ipkKdZD6p97f0L+Lam7J/HZL7
         oBsDwmz/eRXHoPYUCv0rqtensfLIMM7G25REcmav0LlLe9FzrYypR5xPtvV1aL1OasM9
         GSN75h4+8Md2zLojnrFJUPHxIKphf2ruSPfUaPEO5N4G6OqtMzY4yU4XEFjrnwNSFfs7
         ICsw==
X-Forwarded-Encrypted: i=1; AJvYcCUBhNZyY5RhwnarhFCg9uPzXq6lJHG61kzKgSx623iH06FEoLXHFFhhfKrm7PAB3tHXdQRB0VZuyGA23JSte3ho5lYbHmJVPqvyxNnRqaP21zlnI5zabdn7QdRfMIc0Gll7pD31vIeTdPs1i4S6tEvYBdqF5U7xxTJ4xEPOG9fioZo4jQ==
X-Gm-Message-State: AOJu0Yw2T8rfdcj2Fw798dALrRst7jUFmJES7nhAkD+WaSiX1AhwSnRr
	RX8WS5nRrhiVxtVxjy5G/8Ce3b3JepJ2YvJFTfQA671RK9M3Qc3/
X-Google-Smtp-Source: AGHT+IHOSOGnfAYbQBVL2r5KArH7f+QqQEcRWItCKNuRsHLbH/tMOJEGP/Rj4nccxkDrmcF4XJSZHA==
X-Received: by 2002:a17:906:2b0e:b0:a68:f5fe:ac8a with SMTP id a640c23a62f3a-a68f5feacc4mr238139966b.64.1717407971972;
        Mon, 03 Jun 2024 02:46:11 -0700 (PDT)
Received: from [10.76.84.176] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68a9fdfb3dsm343701866b.154.2024.06.03.02.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 02:46:11 -0700 (PDT)
Message-ID: <efa10caa-5e78-4f3f-8cca-c61d7a01e6fd@gmail.com>
Date: Mon, 3 Jun 2024 12:46:10 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: Jonathan Cameron <jic23@kernel.org>,
 Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240531-ad4111-v4-0-64607301c057@analog.com>
 <20240531-ad4111-v4-1-64607301c057@analog.com>
 <20240601193512.0e17992b@jic23-huawei>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <20240601193512.0e17992b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/06/2024 21:35, Jonathan Cameron wrote:
> On Fri, 31 May 2024 22:42:27 +0300
> Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> 
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>
>> Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.
>>
>> AD411x family ADCs support a VCOM pin. The purpose of this pin is to
>> offer a dedicated common-mode voltage input for single-ended channels.
>> This pin is specified as supporting a differential channel with VIN10 on
>> model AD4116.
>>
>> AD4111/AD4112 support current channels. Support is implemented using
>> single-channel and "adi,current-channel".
>>
>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> I like the common-mode-channel solution to the pseudo differential
> description. It makes things explicit whilst avoiding an ugly differential
> but not differential mess.
> 
> However, it feels like a general thing to me not a vendor specific one.
> Perhaps makes sense to put in adc.yaml?
> 

Sure

> One other question that is more me being curious and failing to understand
> the datasheet than a request to change anything.
>> ---
>>  .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 192 ++++++++++++++++++++-
>>  1 file changed, 190 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>> index ea6cfcd0aff4..d8474eee553e 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>> @@ -19,7 +19,18 @@ description: |
>>    primarily for measurement of signals close to DC but also delivers
>>    outstanding performance with input bandwidths out to ~10kHz.
>>  
>> +  Analog Devices AD411x ADC's:
>> +  The AD411X family encompasses a series of low power, low noise, 24-bit,
>> +  sigma-delta analog-to-digital converters that offer a versatile range of
>> +  specifications. They integrate an analog front end suitable for processing
>> +  fully differential/single-ended and bipolar voltage inputs.
>> +
>>    Datasheets for supported chips:
>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4111.pdf
>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4112.pdf
>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4114.pdf
>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4115.pdf
>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4116.pdf
>>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-2.pdf
>>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-4.pdf
>>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7173-8.pdf
>> @@ -31,6 +42,11 @@ description: |
>>  properties:
>>    compatible:
>>      enum:
>> +      - adi,ad4111
>> +      - adi,ad4112
>> +      - adi,ad4114
>> +      - adi,ad4115
>> +      - adi,ad4116
>>        - adi,ad7172-2
>>        - adi,ad7172-4
>>        - adi,ad7173-8
>> @@ -129,10 +145,54 @@ patternProperties:
>>          maximum: 15
>>  
>>        diff-channels:
>> +        description: |
>> +          This property is used for defining the inputs of a differential
>> +          voltage channel. The first value is the positive input and the second
>> +          value is the negative input of the channel.
>> +
>> +          Family AD411x supports a dedicated VINCOM voltage input.
>> +          To select it set the second channel to 16.
>> +            (VIN2, VINCOM) -> diff-channels = <2 16>
>> +
>> +          There are special values that can be selected besides the voltage
>> +          analog inputs:
>> +            21: REF+
>> +            22: REF−
>> +          Supported only by AD7172-2, AD7172-4, AD7175-2, AD7175-8, AD7177-2:
>> +            19: ((AVDD1 − AVSS)/5)+
>> +            20: ((AVDD1 − AVSS)/5)−
> 
> That's what it says on the datasheet (so fine to copy that here) but I'm curious, what does
> that mean in practice?  How can we have negative and postive signals of the difference
> between two power supply voltages where I'm fairly sure AVDD1 always greater than AVSS.
>

I have not tested that as I do not have a model that supports this wired up.
If I had to guess they are the same signal but one should be connected to the
positive input, one to the negative input...but I could be wrong.
 
> Anyhow, that's a problem for the person reading the datasheet to figure out :)
>  
>> +
>>          items:
>>            minimum: 0
>>            maximum: 31
>>  
>> +      single-channel:
>> +        description: |
>> +          This property is used for defining a current channel or the positive
>> +          input of a voltage channel (single-ended or pseudo-differential).
>> +
>> +          Models AD4111 and AD4112 support current channels.
>> +            Example: (IIN2+, IIN2−) -> single-channel = <2>
>> +          To correctly configure a current channel set the "adi,current-channel"
>> +          property to true.
>> +
>> +          To configure a single-ended/pseudo-differential channel set the
>> +          "adi,common-mode-channel" property to the desired negative voltage input.
>> +
>> +          When used as a voltage channel, special inputs are valid as well.
>> +        minimum: 0
>> +        maximum: 31
>> +
>> +      adi,common-mode-channel:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description:
>> +          This property is used for defining the negative input of a
>> +          single-ended or pseudo-differential voltage channel.
>> +
>> +          Special inputs are valid as well.
>> +        minimum: 0
>> +        maximum: 31
>> +
> 


