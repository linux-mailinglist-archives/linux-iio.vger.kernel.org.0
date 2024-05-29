Return-Path: <linux-iio+bounces-5444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165328D37EB
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 15:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A397B22B00
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6370719BBA;
	Wed, 29 May 2024 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMG+0x2X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B189171AD;
	Wed, 29 May 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989939; cv=none; b=bTUEyTOLjbAM2/aoUjWIXtms+g9ZqDIyVoAO1qeXfrz92anX1e3iYkHmi0uKHTCrgxmYgdEAAMK2gUVYOfhdYucVEQWQlY1jcGZY8BbKI2nItpB9KbJIaUAEsyYsVQnJ8DdoPofMTR3XJowezy5EdrwzytuswPUdyQBKLsEcZoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989939; c=relaxed/simple;
	bh=+l6x6i3kHtqLonQfr69W4feqb/M1K6UTmYJxPGqj/lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQ0gyI9P0Up3lpHColjbwhsgEcW3Aoh1xFOTCD7G6gvuchY2DYwPLVIfDgWG/hjSGIUay73TcLYDL4u/gH5kzj1xthj7ZfJPxfgkox2OAxvs3u+tF9NRQ20syWIsissHZVLq1ZBtkIfjDeCN0I/Rk4IhQv+Z/IEMkk2H0B8a14Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMG+0x2X; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a1059dc4fso509024a12.0;
        Wed, 29 May 2024 06:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716989935; x=1717594735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ol6KhilEnQNQYC6nLVi3xWbUX0mrmnhrtYsnemUxP0k=;
        b=NMG+0x2Xz3OyFXmGjTiz4fqKDNazt1nIw71mZX3BsqQny5tP8cOQIPyIgKJpZNU7dl
         ZNhaLrHwRRbgc7zuas2utTmKOyurK3Y227fXEIIVw3w1NLKGEGMhTqMhIOVS1uKORL+s
         xZg62WQHVTWVZh5TN86aVDi1ZqYp6dTRLJI97D9qqLzyZXWPKqNX3reYDEZIq4/pZVMH
         wyj0tvQovdcamqvNPB+U83MuYGqA+3XvfjeJdK4+vVhv/gDhNLLd4nqNlKwzHWsPStJT
         kqgxadNIZXK3AxIDJuFbKvUJTJxZpzRvu9I67BRAcOkQx/S1uU0AUL4xOGoN9BD3B7Tp
         jyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716989935; x=1717594735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ol6KhilEnQNQYC6nLVi3xWbUX0mrmnhrtYsnemUxP0k=;
        b=HSx02JbWOSHdwe61mrQC7Lbmf9y+HgA0OASfwC70h0+P02I8eZT8WYrh264GeAhtSG
         T+lL/OOS9synzSG608BX4lNl6qbib1WlPxy8pHQ6Kvy7HsJ1sCMo+9ihCvmWQom3VeaV
         vSfTQRcVi40mHWSluF+DBPJ5TFgg9Vr1JyI2UE3gfiBQRBFafwpihA8TqNDMCmQ39H4z
         s7gfLrL77R44uNyc+Ge2VdlDaGtKbqLlf2ZGvtMLoCCu0lO/fJJf73ASDKwisrHa6lF3
         jWJO2LsiY2G47Z0+wQ6oumSNd3l/QMrU7zZMB7GdhSvCYmFXi5TcNiiPvCcXgT4FG2PI
         yj/g==
X-Forwarded-Encrypted: i=1; AJvYcCW6d3qYChELGtRnAIVkPawDFTYmTSN3JbZoVEtX7dOgcVG5KzJJhMugZjiylXkgaPBtMRMzXYCTtW3ylVMmNwhsjrK7SAA+o7nkBs6yebcHGEz97Hc8omS4eZ9UBSNHQAIqVM93j25WYsXPA0Q2TqTXQzJhQCzKapYFM8FdjCf4BZyfAg==
X-Gm-Message-State: AOJu0YxDWQZl6EDiQZucDtKrqIEKswgPxh0IxE32ddSdg/iIu6lel0Vf
	Q518N4Bx+flMwxBR1iReM2mcEXwf2NRYYJ6AFjnpzw4z/yU3gDX4
X-Google-Smtp-Source: AGHT+IEBZ+mrLk6M7uSV+VBJ3oMx1LiFjXuncOjXlE2sq6T1Ogk+r/u4girc+UD32T5H1HvBSUVL4w==
X-Received: by 2002:a50:f695:0:b0:578:68b6:dc48 with SMTP id 4fb4d7f45d1cf-57868b6de63mr8760700a12.22.1716989935227;
        Wed, 29 May 2024 06:38:55 -0700 (PDT)
Received: from [192.168.0.137] ([188.24.75.156])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a111f8b3fsm248075a12.85.2024.05.29.06.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 06:38:54 -0700 (PDT)
Message-ID: <a1c75105-6447-4b67-b7d2-326ad9b19b82@gmail.com>
Date: Wed, 29 May 2024 16:38:53 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: Conor Dooley <conor@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
 <20240527-ad4111-v3-1-7e9eddbbd3eb@analog.com>
 <20240527-arguably-said-361184ad848e@spud>
 <d87ae6ef-090d-4e47-bde4-4d08fd445ac1@gmail.com>
 <20240528-filtrate-cloning-b9152322a3da@spud>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <20240528-filtrate-cloning-b9152322a3da@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/05/2024 20:52, Conor Dooley wrote:
> On Tue, May 28, 2024 at 03:16:07PM +0300, Ceclan, Dumitru wrote:
>> On 27/05/2024 20:48, Conor Dooley wrote:
>>> On Mon, May 27, 2024 at 08:02:34PM +0300, Dumitru Ceclan via B4 Relay wrote:
>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>>>
>>>> Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.
>>>>
>>>> AD411x family ADCs support a VCOM pin, dedicated for single-ended usage.
>>>> AD4111/AD4112 support current channels, usage is implemented by
>>>>  specifying channel reg values bigger than 15.
>>>>
>>>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>>> ---
>>>>  .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 122 ++++++++++++++++++++-
>>>>  1 file changed, 120 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>>>> index ea6cfcd0aff4..5b1af382dad3 100644
>>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>>>> @@ -19,7 +19,18 @@ description: |
>>>>    primarily for measurement of signals close to DC but also delivers
>>>>    outstanding performance with input bandwidths out to ~10kHz.
>>>>  
>>>> +  Analog Devices AD411x ADC's:
>>>> +  The AD411X family encompasses a series of low power, low noise, 24-bit,
>>>> +  sigma-delta analog-to-digital converters that offer a versatile range of
>>>> +  specifications. They integrate an analog front end suitable for processing
>>>> +  fully differential/single-ended and bipolar voltage inputs.
>>>> +
>>>>    Datasheets for supported chips:
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4111.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4112.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4114.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4115.pdf
>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4116.pdf
>>>>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-2.pdf
>>>>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-4.pdf
>>>>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7173-8.pdf
>>>> @@ -31,6 +42,11 @@ description: |
>>>>  properties:
>>>>    compatible:
>>>>      enum:
>>>> +      - adi,ad4111
>>>> +      - adi,ad4112
>>>> +      - adi,ad4114
>>>> +      - adi,ad4115
>>>> +      - adi,ad4116
>>>>        - adi,ad7172-2
>>>>        - adi,ad7172-4
>>>>        - adi,ad7173-8
>>>> @@ -129,10 +145,36 @@ patternProperties:
>>>>          maximum: 15
>>>>  
>>>>        diff-channels:
>>>> +        description: |
>>>> +          For using current channels specify select the current inputs
>>>> +           and enable the adi,current-channel property.
>>>> +
>>>> +          Family AD411x supports a dedicated VINCOM voltage input.
>>>> +          To select it set the second channel to 16.
>>>> +            (VIN2, VINCOM) -> diff-channels = <2 16>
>>>> +
>>>> +          There are special values that can be selected besides the voltage
>>>> +          analog inputs:
>>>> +            21: REF+
>>>> +            22: REF−
>>>> +          Supported only by AD7172-2, AD7172-4, AD7175-2, AD7175-8, AD7177-2:
>>>> +            19: ((AVDD1 − AVSS)/5)+
>>>> +            20: ((AVDD1 − AVSS)/5)−
>>>> +
>>>>          items:
>>>>            minimum: 0
>>>>            maximum: 31
>>>>  
>>>> +      single-channel:
>>>> +        description: |
>>>> +          Models AD4111 and AD4112 support single-ended current channels.
>>>> +          To select the desired current input, specify the desired input pair:
>>>> +            (IIN2+, IIN2−) -> single-channel = <2>
>>>> +
>>>> +        items:
>>>> +          minimum: 1
>>>> +          maximum: 16
>>>> +
>>>>        adi,reference-select:
>>>>          description: |
>>>>            Select the reference source to use when converting on
>>>> @@ -154,9 +196,26 @@ patternProperties:
>>>>            - avdd
>>>>          default: refout-avss
>>>>  
>>>> +      adi,current-channel:
>>>> +        description: |
>>>> +          Signal that the selected inputs are current channels.
>>>> +          Only available on AD4111 and AD4112.
>>>> +        type: boolean
>>>> +
>>>> +      adi,channel-type:
>>>> +        description:
>>>> +          Used to differentiate between different channel types as the device
>>>> +           register configurations are the same for all usage types.
>>>> +          Both pseudo-differential and single-ended channels will use the
>>>> +           single-ended specifier.
>>>> +        $ref: /schemas/types.yaml#/definitions/string
>>>> +        enum:
>>>> +          - single-ended
>>>> +          - differential
>>>> +        default: differential
>>>
>>> I dunno if my brain just ain't workin' right today, or if this is not
>>> sufficiently explained, but why is this property needed? You've got
>>> diff-channels and single-channels already, why can you not infer the
>>> information you need from them? What should software do with this
>>> information?
>>> Additionally, "pseudo-differential" is not explained in this binding.
>>
>> In previous thread we arrived to the conclusion single-ended and
>> pseudo-differential channels should be marked with the flag
>> "differential=false" in the IIO channel struct. This cannot
>> really be inferred as any input pair could be used in that
>> manner and the only difference would be in external wiring.
>>
>> Single-channels cannot be used to define such a channel as
>> two voltage inputs need to be selected. Also, we are already
>> using single-channel to define the current channels.
> 
> If I understand correctly, the property could be simplified to a flag
> then, since it's only the pseudo differential mode that you cannot be
> sure of?
> You know when you're single-ended based on single-channel, so the
> additional info you need is only in the pseudo-differential case.
> 
Yes, it could just be a boolean flag. The only thing I have against
that is the awkwardness of having both diff-channels and
differential=false within a channel definition.

No, there is no uncertainty regarding pseudo-differential, it's
basically single-ended.

We cannot use single-channel for voltage channels, two voltage
inputs need to be specified. And again, single-channel will be
used here for the current channels. 

>> As for explaining the pseudo-differential, should it be explained?
>> A voltage channel within the context of these families is actually
>> differential(as there are always two inputs selected).
>> The single-ended and pseudo-diff use case is actually wiring up a
>> constant voltage to the selected negative input.
>>
>> I did not consider that this should be described, as there is no
>> need for an attribute to describe it.
> 
> I dunno, adding an explanation of it in the text for the channel type
> seems trivial to do. "Both pseudo-differential mode (where the
> one of differential inputs is connected to a constant voltage) and
> single-ended channels will..."
>
>>> Also, what does "the device register configurations are the same for
>>> all uses types" mean? The description here implies that you'd be reading
>>> the registers to determine the configuration, but as far as I understand
>>> it's the job of drivers to actually configure devices.
>>> The only way I could interpret this that makes sense to me is that you're
>>> trying to say that the device doesn't have registers that allow you to
>>> do runtime configuration detection - but that's the norm and I would not
>>> call it out here.
>>
>> No, I meant that the same register configuration will be set for
>> both fully differential and single-ended. 
>>
>> The user will set diff-channels = <0, 1>, bipolar(or not) and
>> then they can wire whatever to those pins: 
>> - a differential signal
>> - AVSS to 1 and a single-ended signal to 0
>> - AVSS+offset to 1 and a single-ended signal to 0
>> 	(which is called pseudo-differential in some datasheets)
>>
>> All these cases will look the same in terms of configuration
> 
> In that case, I'd just remove this sentence from the description then.
> How you configure the registers to use the device doesn't really have
> anything to do with describing the configuration of the hardware.
> Given it isn't related to configuration detection at runtime, what
> you've got written here just makes it seem like the property is
> redundant because the register settings do not change.
>
> Instead, use the description to talk about when the property should be
> used and what software should use it to determine, e.g. "Software can
> use vendor,channel-type to determine whether or not the measured voltage
> is absolute or relative". I pulled that outta my ass, it might not
> be what you're actually doing, but I figure you just want to know if
> you're measuring from the origin or either side of it.
>It's more to the "software can this property to correctly mark the channel
as differential or not". Hope this is acceptable. But got it, thanks.

> Cheers,
> Conor.


