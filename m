Return-Path: <linux-iio+bounces-5387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A438D1AE6
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 14:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00931B28F6F
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 12:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B17516A39B;
	Tue, 28 May 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nksUEUMP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D1579F5;
	Tue, 28 May 2024 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898574; cv=none; b=jeE6joWyelsNRi23WButBlfWv0s4IAoQ7S9lePgPkT1rUES/jDaPsjMZ4/NG0Ii7vaSX0khNrVrCuydCPTQAbHTOPH4VuDZLDC2/FMw07yEVDDfNzzpeX2e7Yaigo3S4gXeuN4S7iZDCYvHgewvrALBO0RMfSkXUV7o9+Diz76I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898574; c=relaxed/simple;
	bh=xc7oB8+JNVYn2H/8b3L4JLm5sU+ZMJ8Os7l30OqOt9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Timgvi+B8Kzrl2IL7Fzf8iYOAQgI2OGO362GuPlNhKXYqpdaksK3jFpc7YxuLmg1N0sKOXUEsrdShAcTALs/09+LyMhwEhUpYOaFuNxj91ObryyGoBMl7b5QQk+i1fP54hr8NAjGi2fXSRFN4MXmZW74DhvJ8fEv3uF33rX2grg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nksUEUMP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4202cea9a2fso5074985e9.3;
        Tue, 28 May 2024 05:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716898570; x=1717503370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lzpx7qm7SQW9ian0oyolO7FxfSEu7trQ6emgQAOQl2A=;
        b=nksUEUMPQRJeKd9EIz6s6RTtWh37aZnzZXeHO9j1Sh0SIMiI6jGI7gsBtLNA9krkPE
         /A8a7Y0FgwwIsxBzkbWd9ARco4U82XjMnr5eJ35xVL5ofAHJe5SZmaHYKr13HRk732t2
         fOl7uCG7t+j2mO7kY93RkY1glHOlsFXGw5VIe/+MaVGFkjE35NGkuzRD4/9tDTkFFdKq
         AE/a6cxwqHLEmIc+zV67BpvTba9kAlLTd1XusDqO/XbxNlqabWrt/T0CYgCKfMHTnS5E
         Ce6CAMiJgzg1ftwh8Aj3+/yL4v+D4nxUcKOz/1rnYpMi4h9XO2s3h3hy5E7w9ifLLo1+
         YaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716898570; x=1717503370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzpx7qm7SQW9ian0oyolO7FxfSEu7trQ6emgQAOQl2A=;
        b=YXCIeaa4XkMzeFKdq7iD7CZybZKtsSNwTnN9hraEv94wKWqjKAutSk3O70s9FDNMqe
         uBjDqIVVqn7ho2i5594Q+1wPrYxHeOvce1x4f6yaa8TZ+C2Q3XQzIt3PXfg1XXyZ77sg
         8PuEAI+lQFmEZhGc877NyhaT3tDcRG5gvOyEazfk4/FgkuEWXmPdyiAafpJLeXBIJXPI
         Rbcob8oZqSW2Pric0FlU8m7hYb0hy6RIPmsUiWV3QIm3H/QePzXGcMLjOOZ79AJw/Gat
         nEZHUxz1SEs5Qr+bKPmrSrUMaCbJBjahTpmIhs/FkQAQPMkyatynp3Xia0iBBo7MzPI9
         qsaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYoeJki5HUgRs4fLLEP8VHupUzy9DKXtqvP6O+g2vgzFJLujJu8xeblF0k8uyblxGA389PMvKk1ldJ4zQXt4vwknsOXbeKNeY6baRn0Sf/PsC2CDUSDE2xbb+nTj5oWMlwSusqEQw3xB8L93OeiSY3t0IEGkQjwlFYqBJH1t+JWVZGbg==
X-Gm-Message-State: AOJu0YwLzJbLBNtvDUkT4ZZjczC4CqRJ0U37qB9XuLh8x+F7UHoZ9gy2
	hgMSP2oLlg6BFSsn1OZOWb0RWFKeN/QAJACt1MUv9rBPoZHj5/I5
X-Google-Smtp-Source: AGHT+IGCFhpIsDbHj3JBdSP6LwjptF6Kk35JPoYp9dYAhg8YPwtQ/pgxIX+pjNU6EeVkgsyESoU5hg==
X-Received: by 2002:a05:600c:4f0f:b0:41b:de8d:dcd7 with SMTP id 5b1f17b1804b1-421089ffc4emr84324085e9.20.1716898570126;
        Tue, 28 May 2024 05:16:10 -0700 (PDT)
Received: from [192.168.0.137] ([188.24.75.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420fd37c1d2sm189939445e9.1.2024.05.28.05.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 05:16:09 -0700 (PDT)
Message-ID: <d87ae6ef-090d-4e47-bde4-4d08fd445ac1@gmail.com>
Date: Tue, 28 May 2024 15:16:07 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: Conor Dooley <conor@kernel.org>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
 <20240527-ad4111-v3-1-7e9eddbbd3eb@analog.com>
 <20240527-arguably-said-361184ad848e@spud>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <20240527-arguably-said-361184ad848e@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/05/2024 20:48, Conor Dooley wrote:
> On Mon, May 27, 2024 at 08:02:34PM +0300, Dumitru Ceclan via B4 Relay wrote:
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
>>  .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 122 ++++++++++++++++++++-
>>  1 file changed, 120 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
>> index ea6cfcd0aff4..5b1af382dad3 100644
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
>> @@ -129,10 +145,36 @@ patternProperties:
>>          maximum: 15
>>  
>>        diff-channels:
>> +        description: |
>> +          For using current channels specify select the current inputs
>> +           and enable the adi,current-channel property.
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
>> +
>>          items:
>>            minimum: 0
>>            maximum: 31
>>  
>> +      single-channel:
>> +        description: |
>> +          Models AD4111 and AD4112 support single-ended current channels.
>> +          To select the desired current input, specify the desired input pair:
>> +            (IIN2+, IIN2−) -> single-channel = <2>
>> +
>> +        items:
>> +          minimum: 1
>> +          maximum: 16
>> +
>>        adi,reference-select:
>>          description: |
>>            Select the reference source to use when converting on
>> @@ -154,9 +196,26 @@ patternProperties:
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
>> +          Both pseudo-differential and single-ended channels will use the
>> +           single-ended specifier.
>> +        $ref: /schemas/types.yaml#/definitions/string
>> +        enum:
>> +          - single-ended
>> +          - differential
>> +        default: differential
> 
> I dunno if my brain just ain't workin' right today, or if this is not
> sufficiently explained, but why is this property needed? You've got
> diff-channels and single-channels already, why can you not infer the
> information you need from them? What should software do with this
> information?
> Additionally, "pseudo-differential" is not explained in this binding.
> In previous thread we arrived to the conclusion single-ended and
pseudo-differential channels should be marked with the flag
"differential=false" in the IIO channel struct. This cannot
really be inferred as any input pair could be used in that
manner and the only difference would be in external wiring. 

Single-channels cannot be used to define such a channel as
two voltage inputs need to be selected. Also, we are already
using single-channel to define the current channels.

As for explaining the pseudo-differential, should it be explained?
A voltage channel within the context of these families is actually
differential(as there are always two inputs selected).
The single-ended and pseudo-diff use case is actually wiring up a
constant voltage to the selected negative input.

I did not consider that this should be described, as there is no
need for an attribute to describe it.

> Also, what does "the device register configurations are the same for
> all uses types" mean? The description here implies that you'd be reading
> the registers to determine the configuration, but as far as I understand
> it's the job of drivers to actually configure devices.
> The only way I could interpret this that makes sense to me is that you're
> trying to say that the device doesn't have registers that allow you to
> do runtime configuration detection - but that's the norm and I would not
> call it out here.

No, I meant that the same register configuration will be set for
both fully differential and single-ended. 

The user will set diff-channels = <0, 1>, bipolar(or not) and
then they can wire whatever to those pins: 
- a differential signal
- AVSS to 1 and a single-ended signal to 0
- AVSS+offset to 1 and a single-ended signal to 0
	(which is called pseudo-differential in some datasheets)

All these cases will look the same in terms of configuration

> 
> Thanks,
> Conor.


