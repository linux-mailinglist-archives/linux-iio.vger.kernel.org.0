Return-Path: <linux-iio+bounces-5067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE7C8C79B9
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 17:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 641FCB21572
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 15:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206BA14E2D6;
	Thu, 16 May 2024 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvS/OLts"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAEC14D6EB;
	Thu, 16 May 2024 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874561; cv=none; b=ACzAi37GretSn0OOzBV2NTaL78M5FfnKCjIkUZZox6uxDtzeKgvLOLlZT0+1BBeIBG43VdDL1+FvAe/BcNLP1dhuSJr2c5Yg8uHBtA/nHSvozSN5LO2NUMQl42/w1HySu5W3jvuW6SsJ7WAJ3QB7KgqYoCPz5/DEA3T/rKHbhwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874561; c=relaxed/simple;
	bh=a6Q7efy0tNRxVScuvATNhJPi29qVXadBvh91W1L9Aqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSpGYsAxo2UUXyle1y4QnFQMw1bfCnLfOfZhw7QgSU/UtAMvQGw8tah12SDszWnPD5DbUSPhUJZMBTSS23zVkIMczrmnnNjPzg7MV2feNi2MGzDcAUaX3/aAtyrlcQDOzCtPb4JqpcWxbAp31FzF3dRC4a86R8gY0yoFJTLkDoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvS/OLts; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f0ed8bbfadso209851a34.0;
        Thu, 16 May 2024 08:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715874559; x=1716479359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lkNvYvenGmZEWbbWXIRqoToCsaAjPAmMTEnZsyiG6q4=;
        b=BvS/OLtspJ7dHxryJ9epWJdnv0agcifXQj1wEmuFvS0V8xI/H8lURHLKqIcosknvNG
         pHOaLLjuw+9JnBAuHu/PS2AxShovMA4MLz8R4sQsdLDott/WJLwJRlqlgY0BGlkCeTot
         ybiqt9pnUpW8wr6KT+9/exOAlmT0zqb86DlRZUGVzAHR10t3LjM5qBDjTAZQh2DD1D4p
         OyvGZYGvOsDbcmHUSAGnsg3oShQ4IzDX5vMcJQQgVaDHk2f+rYuEbKfGHUeq3jSiyL+O
         Mhj/uAnZggim1hc3szEIxbMAxWqyf7dsTgI25PiyCBNza3NvnldIhLIya99hUNRWwZPB
         zzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874559; x=1716479359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkNvYvenGmZEWbbWXIRqoToCsaAjPAmMTEnZsyiG6q4=;
        b=hJZzsOsTSBx3aNgChv3loAsD3p0KlTdgwyFBaz58VvI9y6scPmy5msKXsTr8uFj+Ix
         nf8zGW6Shn5WQiu9ygk4WlCFVIJuWPT30QxKSFNp53/D9zSUvPSQEBuSSN/wr4hpPSuN
         d5uGc2BZ8E090jYyJIhANNtjBTQnox0p/Ahrt1FrSm3uv7XY4uh/qpjghr6iQKUBv4en
         DUntoljnE+qBG6+MylqKvztui6Q8enQpLJISnlwj72eWYt4gZN0ZfBlnZVKN/r/tHyNx
         pIbP6tcIdL2zfrSJc/7pbpyvDK7pmrsPNVplbUUNTHENSPQWDJMXFtgiQnAeuY5HJFt6
         ALcw==
X-Forwarded-Encrypted: i=1; AJvYcCXYIUSTJ1JZyKJVfG24nSkpicVAjrHgq/Z3OiVr74HnbHnbXTjN5Iufyc1R4/FPMMWlsj/CTZakgVT+sc+2BetTZNCee2rduWXXPgrnfr7/g8vxn4WSb7ttUoPo11SNtUDxxsgtMEiQ7evllBzIv3MSa97w+FnX8Xk1n3HyyQxmEHMuwA==
X-Gm-Message-State: AOJu0YypuQcPRoTTmGdKRb3tiy+0mB/ZwXR1pWtjLcal8Dzq91cd6T9Q
	MmdfilwBi7w54rtMJ8uaKHljXyeufBZitWslj284MKjkEa4LaCOt
X-Google-Smtp-Source: AGHT+IFgGKx5e4efeKGbF9y/gmw7eHSn2S6YcizPvXzwYMia01/xg6l/w+h+3vVG3tjc4sjrxgWufw==
X-Received: by 2002:a05:6871:a00f:b0:240:eab9:1635 with SMTP id 586e51a60fabf-24172a904bcmr21313746fac.21.1715874556086;
        Thu, 16 May 2024 08:49:16 -0700 (PDT)
Received: from [192.168.0.137] ([188.24.105.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f195018sm77414436d6.74.2024.05.16.08.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 08:49:15 -0700 (PDT)
Message-ID: <151d6893-3e9e-4331-8dde-5293e75f10ef@gmail.com>
Date: Thu, 16 May 2024 18:49:12 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: adc: ad7173: add support for ad411x
To: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
 <20240514-ad4111-v2-1-29be6a55efb5@analog.com>
 <CAMknhBGNPvxegL+YbnLGoKjA=P3Vx=x+39aXuMgq+cv2KgdeLw@mail.gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBGNPvxegL+YbnLGoKjA=P3Vx=x+39aXuMgq+cv2KgdeLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/05/2024 01:37, David Lechner wrote:
> On Tue, May 14, 2024 at 2:23 AM Dumitru Ceclan via B4 Relay
> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>>
>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>
>> Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.
>>
>> AD411x family ADCs support a VCOM pin, dedicated for single-ended usage.
>> AD4111/AD4112 support current channels, usage is implemented by
>>  specifying channel reg values bigger than 15.
>>
>> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
>> ---
>>  .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 118 ++++++++++++++++++++-
>>  1 file changed, 117 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>> index ea6cfcd0aff4..6cc3514f5ed8 100644
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
>> @@ -129,6 +145,31 @@ patternProperties:
>>          maximum: 15
>>
>>        diff-channels:
>> +        description: |
>> +          For using current channels specify select the current inputs
>> +           and enable the adi,current-channel property.
>> +
>> +          Family AD411x supports a dedicated VCOM voltage input.
> 
> Did you mean VINCOM? Searching the datasheets for "VCOM" comes up empty.
> 
Yep
>> +          To select it set the second channel to 16.
>> +            (VIN2, VCOM) -> diff-channels = <2 16>
> 
> Jonathan mentioned this in v1 with regard to the current inputs, but
> it applies here too. There is a new proposed single-channel property
> [1] that would be preferred when an input is used as a single-ended or
> pseudo-differential input (i.e. with VINCOM or ADCIN15).
> 
> [1]: https://lore.kernel.org/linux-iio/20240514120222.56488-5-alisa.roman@analog.com/
> 
Yet here I thought that it was clear from previous conversations that
we are not really dealing with a single-ended/pseudo-differential input,
just a differential ADC that can be used in that manner.

We do not have here such a clear cut case as with AD7194, where an input
is dedicated for single-ended/pseudo usage. Here, the inputs are mix and
match and single-ended/pseudo is obtainable with other pins than VINCOM/
ADCIN15.

When configuring channels we are *always* specifying two voltage inputs.
I strongly disagree using single-channel for voltage channels in these
families of ADC's.

>> +
>> +          There are special values that can be selected besides the voltage
>> +          analog inputs:
>> +            21: REF+
>> +            22: REF−
>> +          Supported only by AD7172-2, AD7172-4, AD7175-2, AD7175-8, AD7177-2:
>> +            19: ((AVDD1 − AVSS)/5)+
>> +            20: ((AVDD1 − AVSS)/5)−
>> +          Supported only by AD4111, AD4112:
>> +            12: IIN3+
>> +            11: IIN3−
>> +            13: IIN2+
>> +            10: IIN2−
>> +            14: IIN1+
>> +             9: IIN1−
>> +            15: IIN0+
>> +             8: IIN0−
> 
> I just made a late reply on v1 where Jonathan suggested that the
> current inputs are differential with a similar comment to this:
> 
> It doesn't seem to me like current inputs are differential if they are
> only measuring one current. They take 2 pins because you need a way
> for current to come in and go back out, but the datasheet calls them
> single-ended inputs.
> 
It seemed to me that the conclusion that we arrived to was to expose the
precise pins that are used in the conversion and document the selection.

Yes, it is a single-ended channel. So revert to the way it was in V1 using
single-channel?

>> +
>>          items:
>>            minimum: 0
>>            maximum: 31
>> @@ -154,6 +195,23 @@ patternProperties:
>>            - avdd
>>          default: refout-avss
>>
>> +      adi,current-channel:
>> +        description: |
>> +          Signal that the selected inputs are current channels.
>> +          Only available on AD4111 and AD4112.
>> +        type: boolean
>> +
>> +      adi,channel-type:
>> +        description:
>> +          Used to differentiate between different channel types as the device
>> +           register configurations are the same for all usage types.
>> +        $ref: /schemas/types.yaml#/definitions/string
>> +        enum:
>> +          - single-ended
>> +          - pseudo-differential
>> +          - differential
>> +        default: differential
>> +
> 
> As suggested above, we should soon have diff-channels and
> single-channel to differentiate between (fully) differential and
> single-ended. Do we actually need to differentiate between
> single-ended and pseudo-differential though?
> 
Not really, so just a bool differential flag? (this seems weird as we have diff-channels) 

> I think the AD4116 datasheet is the only one that uses both of those
> terms. It gives the examples that for "single-ended" ADCIN15 would be
> connected to AVSS and for "pseudo-differential" ADCIN15 would be
> connected to REFOUT (AVSS + 2.5 V). So the only difference seems to be
> if the voltage on ADCIN15 is == 0V or != 0V.
> 
In the ad411x yes, over to ad717x it's mixed:
https://lore.kernel.org/all/0fef36f8-a7db-40cc-86bd-9449cb4ab46e@gmail.com/

> To make this like other pseudo-differential chips we have done
> recently, it seems to me like we should have an adcin15-supply
> property to describe the ADCIN15 input. Then we could use that
> property to determine single-ended vs. pseudo-differential (if there
> actually is a need for that) and we wouldn't need the adi,channel-type
> property.
> 

I agree that we do not need to differentiate between those two.
But the approach with the supply is too specific, the adi,channel-type
property is not only for AD4116-ADCIN15, but for all models compatible. 

>>      required:
>>        - reg
>>        - diff-channels
>> @@ -166,7 +224,6 @@ allOf:
>>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>
>>    # Only ad7172-4, ad7173-8 and ad7175-8 support vref2
>> -  # Other models have [0-3] channel registers
>>    - if:
>>        properties:
>>          compatible:
>> @@ -187,6 +244,37 @@ allOf:
>>                  - vref
>>                  - refout-avss
>>                  - avdd
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - adi,ad4114
>> +              - adi,ad4115
>> +              - adi,ad4116
>> +              - adi,ad7173-8
>> +              - adi,ad7175-8
>> +    then:
>> +      patternProperties:
>> +        "^channel@[0-9a-f]$":
>> +          properties:
>> +            reg:
>> +              maximum: 15
> 
> As discussed recently in the the very similar ad719x bindings [2], we
> may have been misunderstanding this limit so far. 15 is a bit
> artificially low since input pins can be used more than once in
> different "channels". But that is really an issues with the existing
> bindings, not just this patch.
> 
> [2]: https://lore.kernel.org/linux-iio/20240511122955.2372f56e@jic23-huawei/
> 
> 
In this case there is a 1-1 correspondence between this reg limit and the number
of channel configuration registers available to the device. Maybe another property
then reg? Sure...but this limitation fits the current situation.

In addition, the device does not work the same as ad719x. If I understood correctly
that documentation, the configuration register needs to be rewritten for every different
input combination. This means that the driver is implemented to overwrite the reg for
every read. This device, it seems to me, is more in the liking's of write all the channel
configs at once, then keep using those.

For AD719x yes, it is artificial. Over here we have a clear reason.

>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - adi,ad7172-2
>> +              - adi,ad7175-2
>> +              - adi,ad7176-2
>> +              - adi,ad7177-2
>> +    then:
>> +      patternProperties:
>> +        "^channel@[0-9a-f]$":
>> +          properties:
>>              reg:
>>                maximum: 3
>>
>> @@ -210,6 +298,34 @@ allOf:
>>            required:
>>              - adi,reference-select
>>
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - adi,ad4111
>> +              - adi,ad4112
>> +              - adi,ad4114
>> +              - adi,ad4115
>> +              - adi,ad4116
>> +    then:
>> +      properties:
>> +        avdd2-supply: false
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          not:
>> +            contains:
>> +              enum:
>> +                - adi,ad4111
>> +                - adi,ad4112
>> +    then:
>> +      patternProperties:
>> +        "^channel@[0-9a-f]$":
>> +          properties:
>> +            adi,current-channel: false
>> +
>>    - if:
>>        anyOf:
>>          - required: [clock-names]
>>
>> --
>> 2.43.0
>>
>>


