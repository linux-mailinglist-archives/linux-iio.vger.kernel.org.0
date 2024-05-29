Return-Path: <linux-iio+bounces-5473-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C338D410D
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 00:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E50C2B2401D
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 22:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2401C8FB0;
	Wed, 29 May 2024 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UkFqZWLJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3915B56D
	for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 22:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717020266; cv=none; b=euvy4w7f/++GM0eGq5AdBRC8mxUNHf7Q7qsrjRVHFBTn5hGS1Lkt9YobXZYxyXGAa6nL1SR2fSzmnCapQSzL7c2CQm6+35RKpN/LlBMYhGX/MP1El+BTnIjs/+1gepgAaMiXUyOR4uswbXUaUyj1ySTdNT54uWzQugeL0FCRQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717020266; c=relaxed/simple;
	bh=VInmetRHk0eKKc12xNtVfGvs6AOei6C88yzbAhsbMvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNqrYp7Kt1733vOjkTNwD7ebwrnWiVGM1uhtlZbA5OvTlL3pIx6LQKLZKBK0ZL69OazC/WJto3m5KKg92yUlkP75ubiXc5P0JGbAxE1vkz2VthGKNeFYhTKz2gM/pshufe0s9n8/97yMpRkdrBtqS9OmRaGT/W/nYTwwQTz4sW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UkFqZWLJ; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f8ffe1b65dso103418a34.0
        for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 15:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717020262; x=1717625062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svQ2kP8rlyYfBUzeKnxKowNmF0xNHylxbIzTzO1lnZg=;
        b=UkFqZWLJSp5Dye4oE8DEZ1WCfHrhWw1tveFbehuiAl5ZsqQw4tdZT1Zpnht40d0O4Y
         FcZzO0TCwzDJ+Ympw7SyghQ958Bf1INH+j8KdzQFozv/9vR3ZoA9pgZp7ges8oQmbvJ1
         gr6r/ZIreTj1EqGiFsr1qB0GfHsO5VJmanonC7muMJ0IYwuQvxHhWd6y0J1n9LCHDV4R
         NL+VnYmNaZ7ojtbBGf87TZJf52nOyLsMSzZ3QENjXVZz+Kt5Ez6JZ2/Og228S2pUUwEV
         L6hSKzV2wy7PpiVbr3EREbxiLe0M66brmvZzDdM/ChZAeCLUfOzLK36LxXR9b9bBi6fz
         44CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717020262; x=1717625062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=svQ2kP8rlyYfBUzeKnxKowNmF0xNHylxbIzTzO1lnZg=;
        b=nOjFUrNBb3N3Mcktx+wlxZTvPtjP+4aWZyILU1mybbhULsAHkyplbsEmQrOyeoXzmT
         BTfePqMxqcm3Wn9ZGzyNLWT/Ux2lUjfbnJ4nx72OI6baajvRIYlEBufPIXro0+P0X7Le
         4zkXaKYFc7chUyazP9cQOkMfsfUSJZOk8OIx3z7yKAByT0xH8sCAzEH/BXwjjT9ZIm+W
         RtsmO5JkWgGAQp/O4Bjx46+0iB/Mf36nCjsXea+1vjra1CxeFMWQ7BK7FjMVYqEfnyZy
         GBJAPeZd+rX2bchjaTh9YfP1pSLwAoF/SyUeyCiVhTbostwtOpXxhB1cgDrcub34Jbnw
         mGqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkPIxz+04YFCNf/eHDReI3NKURtXm4VkI1+nRFmykvyg4MQfzMNbz/VnoExfGF2DJtrfNYLykbme5gNKFeMfOwFZtgaGdAuXsn
X-Gm-Message-State: AOJu0YzEhQo3nh5Df5qdfVqkn4EHsimqOSF7SsZuYtBwJsZ3DJqN4MOn
	jd3m2MuE4fcxK28a7pd/oxXTFWoy6DqIJAXP1fX/1lCj8Y139uUUL6aiZJyJd+l1BIz8+iVbpJN
	I8h4=
X-Google-Smtp-Source: AGHT+IEzkj2SHc8IKvklHfEGggXym14YvXH1eSM9LCSmiFlGo2rIMPkdV9gy8qFjRKk3G8tbRRmkSg==
X-Received: by 2002:a9d:6c49:0:b0:6f1:222c:2302 with SMTP id 46e09a7af769-6f90b8fcf71mr54831a34.2.1717020261883;
        Wed, 29 May 2024 15:04:21 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8d0e6143asm2467044a34.57.2024.05.29.15.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 15:04:21 -0700 (PDT)
Message-ID: <362e006f-7856-46e3-90fa-b1610784ee9d@baylibre.com>
Date: Wed, 29 May 2024 17:04:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>,
 Conor Dooley <conor@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
 <20240527-ad4111-v3-1-7e9eddbbd3eb@analog.com>
 <20240527-arguably-said-361184ad848e@spud>
 <d87ae6ef-090d-4e47-bde4-4d08fd445ac1@gmail.com>
 <20240528-filtrate-cloning-b9152322a3da@spud>
 <a1c75105-6447-4b67-b7d2-326ad9b19b82@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a1c75105-6447-4b67-b7d2-326ad9b19b82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/29/24 8:38 AM, Ceclan, Dumitru wrote:
> On 28/05/2024 20:52, Conor Dooley wrote:
>> On Tue, May 28, 2024 at 03:16:07PM +0300, Ceclan, Dumitru wrote:
>>> On 27/05/2024 20:48, Conor Dooley wrote:
>>>> On Mon, May 27, 2024 at 08:02:34PM +0300, Dumitru Ceclan via B4 Relay wrote:
>>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>>>>
>>>>> Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.
>>>>>
>>>>> AD411x family ADCs support a VCOM pin, dedicated for single-ended usage.
>>>>> AD4111/AD4112 support current channels, usage is implemented by
>>>>>  specifying channel reg values bigger than 15.
>>>>>
>>>>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>>>> ---
>>>>>  .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 122 ++++++++++++++++++++-
>>>>>  1 file changed, 120 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>>>>> index ea6cfcd0aff4..5b1af382dad3 100644
>>>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>>>>> @@ -19,7 +19,18 @@ description: |
>>>>>    primarily for measurement of signals close to DC but also delivers
>>>>>    outstanding performance with input bandwidths out to ~10kHz.
>>>>>  
>>>>> +  Analog Devices AD411x ADC's:
>>>>> +  The AD411X family encompasses a series of low power, low noise, 24-bit,
>>>>> +  sigma-delta analog-to-digital converters that offer a versatile range of
>>>>> +  specifications. They integrate an analog front end suitable for processing
>>>>> +  fully differential/single-ended and bipolar voltage inputs.
>>>>> +
>>>>>    Datasheets for supported chips:
>>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4111.pdf
>>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4112.pdf
>>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4114.pdf
>>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4115.pdf
>>>>> +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4116.pdf
>>>>>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-2.pdf
>>>>>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-4.pdf
>>>>>      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7173-8.pdf
>>>>> @@ -31,6 +42,11 @@ description: |
>>>>>  properties:
>>>>>    compatible:
>>>>>      enum:
>>>>> +      - adi,ad4111
>>>>> +      - adi,ad4112
>>>>> +      - adi,ad4114
>>>>> +      - adi,ad4115
>>>>> +      - adi,ad4116
>>>>>        - adi,ad7172-2
>>>>>        - adi,ad7172-4
>>>>>        - adi,ad7173-8
>>>>> @@ -129,10 +145,36 @@ patternProperties:
>>>>>          maximum: 15
>>>>>  
>>>>>        diff-channels:
>>>>> +        description: |
>>>>> +          For using current channels specify select the current inputs
>>>>> +           and enable the adi,current-channel property.
>>>>> +
>>>>> +          Family AD411x supports a dedicated VINCOM voltage input.
>>>>> +          To select it set the second channel to 16.
>>>>> +            (VIN2, VINCOM) -> diff-channels = <2 16>
>>>>> +
>>>>> +          There are special values that can be selected besides the voltage
>>>>> +          analog inputs:
>>>>> +            21: REF+
>>>>> +            22: REF−
>>>>> +          Supported only by AD7172-2, AD7172-4, AD7175-2, AD7175-8, AD7177-2:
>>>>> +            19: ((AVDD1 − AVSS)/5)+
>>>>> +            20: ((AVDD1 − AVSS)/5)−
>>>>> +
>>>>>          items:
>>>>>            minimum: 0
>>>>>            maximum: 31
>>>>>  
>>>>> +      single-channel:
>>>>> +        description: |
>>>>> +          Models AD4111 and AD4112 support single-ended current channels.
>>>>> +          To select the desired current input, specify the desired input pair:
>>>>> +            (IIN2+, IIN2−) -> single-channel = <2>
>>>>> +
>>>>> +        items:
>>>>> +          minimum: 1
>>>>> +          maximum: 16
>>>>> +
>>>>>        adi,reference-select:
>>>>>          description: |
>>>>>            Select the reference source to use when converting on
>>>>> @@ -154,9 +196,26 @@ patternProperties:
>>>>>            - avdd
>>>>>          default: refout-avss
>>>>>  
>>>>> +      adi,current-channel:
>>>>> +        description: |
>>>>> +          Signal that the selected inputs are current channels.
>>>>> +          Only available on AD4111 and AD4112.
>>>>> +        type: boolean
>>>>> +
>>>>> +      adi,channel-type:
>>>>> +        description:
>>>>> +          Used to differentiate between different channel types as the device
>>>>> +           register configurations are the same for all usage types.
>>>>> +          Both pseudo-differential and single-ended channels will use the
>>>>> +           single-ended specifier.
>>>>> +        $ref: /schemas/types.yaml#/definitions/string
>>>>> +        enum:
>>>>> +          - single-ended
>>>>> +          - differential
>>>>> +        default: differential
>>>>
>>>> I dunno if my brain just ain't workin' right today, or if this is not
>>>> sufficiently explained, but why is this property needed? You've got
>>>> diff-channels and single-channels already, why can you not infer the
>>>> information you need from them? What should software do with this
>>>> information?
>>>> Additionally, "pseudo-differential" is not explained in this binding.
>>>
>>> In previous thread we arrived to the conclusion single-ended and
>>> pseudo-differential channels should be marked with the flag
>>> "differential=false" in the IIO channel struct. This cannot
>>> really be inferred as any input pair could be used in that
>>> manner and the only difference would be in external wiring.
>>>
>>> Single-channels cannot be used to define such a channel as
>>> two voltage inputs need to be selected. Also, we are already
>>> using single-channel to define the current channels.
>>
>> If I understand correctly, the property could be simplified to a flag
>> then, since it's only the pseudo differential mode that you cannot be
>> sure of?
>> You know when you're single-ended based on single-channel, so the
>> additional info you need is only in the pseudo-differential case.
>>
> Yes, it could just be a boolean flag. The only thing I have against
> that is the awkwardness of having both diff-channels and
> differential=false within a channel definition.
> 
> No, there is no uncertainty regarding pseudo-differential, it's
> basically single-ended.
> 
> We cannot use single-channel for voltage channels, two voltage
> inputs need to be specified. And again, single-channel will be
> used here for the current channels. 

Instead of using diff-channels for single-ended/pseudo-differential
plus a property that says "actually not differential" could we just
add a second common-mode-channel property to specify the second
input pin that is connected to the common mode voltage source?

Just to make sure I'm understanding, single-ended means common mode
voltage is 0V (or AVSS for this chip, I guess) and pseudo-differential
means the common mode voltage is something else other than that.
In other words, single-ended is just a special case of pseudo-differential.
So effectively, no difference that we need to describe?

So something like this could work?


        /* a fully differential voltage input channel */
        channel@0 {
          reg = <0>;
          bipolar;
          diff-channels = <0 1>; /* VIN0 is +, VIN1 is - */
          adi,reference-select = "vref";
        };

        /* a single-ended voltage input channel */
        channel@1 {
          reg = <1>;
          /* no bipolar since common mode is 0V */
          single-channel = <2>; /* VIN2 is input */
          common-mode-channel = <3>; /* VIN3 connected to 0V */
        };

        /* a pseudo-differential voltage input channel */
        channel@2 {
          reg = <2>;
          bipolar; /* since common mode is not 0V */
          single-channel = <4>; /* VIN4 is input */
          common-mode-channel = <5>; /* VIN5 connected to Vref / 2 */
          adi,reference-select = "vref";
        };

	/* a current input channel */
        channel@3 {
          reg = <3>;
          bipolar;
          /* 0 is not the same pin as channel@0 because of
           * the adi,current-channel flag */
          single-channel = <0>; /* using IIN0+ and IIN0- pins */
          adi,current-channel;
        };


If we really wanted to go all the way, we could also think about
adding a common-mode-supply property in each channel node to with
a common-mode-channel property to describe the voltage source that
the pin is connected to.


