Return-Path: <linux-iio+bounces-14679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D408A20DC5
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 16:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605A43A67F7
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4091D89F1;
	Tue, 28 Jan 2025 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YGqO+qe7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A0D1D63EF
	for <linux-iio@vger.kernel.org>; Tue, 28 Jan 2025 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079805; cv=none; b=gSviZHQCg2A6i3VOTB936Bu3p6Sb8KefNopylAEOfK1aGRgFhsv6H1wBsedqHeg54JkydtY/4sWRSlHZCEEmOIOrmBztzmfDOmC51FKHKvc5HMPJlpLbHes5Z83pUcicFrMAQlxnWfMHoySbGa7+8iewocUqQmZ/FFag0z4KptM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079805; c=relaxed/simple;
	bh=U1CRXAgspDWLAL9BhnasVoFw3dIoFPyaUQBg3kwcafc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2YYTTf1n67bKIvvyJxfvkFdLVbp0zR1rF/IAhd3xXu31mYoBEYZVUs6M4FyYsigzDHYyCUYNv0z/78dusnXOori99JL28VJwOHIv646W55x7NFW4TTpQQL9rtR3bjy5MLgRm4HD/eQIAgw/5aWffp8a0bk8lM7mPim4td7UW+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YGqO+qe7; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f1c94936c5so3052220b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Jan 2025 07:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738079801; x=1738684601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I2Qw44d6HeXewj2arD8dL/6DqT4U1JV+B9kC0ec4R8I=;
        b=YGqO+qe7NxqU8msv1DCe7UijfIGza7KAudeUSePl3kCzof2NU5vfKtotqLgW/FeL5z
         8oOh6fWygQLVzWr4Hjwl6I4QrBM9oD91XKGFjDP7j3suKW38H3agWCaIdMvN9SnWUax8
         chaBCwdnn4JhnGSm/FNn99S+7uo7uqsNygviwyvDrYBC+KQF3nt1fQctNJrrjWk3t2nf
         xeT2eeCyv8mMH7dEZXPhY0zTx/gtEa6N6YmQLChlsvDEJm7ADn+AcHFgCoLv/lOi5LqA
         5quEw0WjnYiCu2NTXTdrU4Z3g7BeBvoab9u76IOMyxyb+qPG9Q8K4PBYz/NlZFsF5pna
         dybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738079801; x=1738684601;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2Qw44d6HeXewj2arD8dL/6DqT4U1JV+B9kC0ec4R8I=;
        b=xTOAq1dmyT4/wyNXLjBGmnqUV7r2ptPNNXMB3/bnhN6xKC8sohG4ZJP7GvMl4lzkYv
         jJkyFdPStrDtgpyHb9DGpTgGZXuv+fmqt5bgyaF9g5cTyXCQHIzeQjgEoLDqeQHWhp4y
         3K57BClHM4HVHCJmWEikGQ5feI4OV0o3E++trb/AfzC+n3oSDPdP5krVTVdO02aSmtSP
         0mGegXD1ulloA0aZl3xXwm+zjUhW4bU9B0R5hJQhMa/uZ2AqfgPlTJ3eEqXNklpP6VRE
         +WRd63f7J4OKvoFvwnk49eyUY+t6fV5Mf7z3vKBb8QP2GMEDLWCMBefASu0L8gD5Kc+D
         iKWg==
X-Forwarded-Encrypted: i=1; AJvYcCUlfTwiduO++G07PNUr7T8EaaIFiMWXioQrDvzdiKah3fPAv8Pp2v9zNw/I4AHZ2qv8VasLvRVU/04=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo+nagkzPmGPXm0Ge8xLXFyzGdlx0x6EbZw1HFprK0f3fxTJaI
	ofcN1wL4kDFu1SDeNVuFQiFtCxw9P/+ux91Uqxbp4mBqTJb3I8aOdQC+SL4yelk=
X-Gm-Gg: ASbGncvY/aelv+L9q1twgp7PDsTJzYpHt5B3FOLqPxid0v4wzFgUhmW0eMcoJqKU4a5
	fXT8eo7T68Fx4euma9Dd+Y5d36bTAFRUivWre7+fDSwEaZxY9I9up2vD6xXVY/LM+3JZOCUd0OQ
	QPX3onDNEjPsMctacI+2w8PHkyZJyIXwuNG1F22UOg/PKvZYPLU7s0ecz5j+J7OkSq+7BDpBnAS
	fy9xV8sHbd0RnepXK/WHppufSdPpInJIHPMoUMnns6VbnoaSteNLr3VnqJiQY16mLtudbALIT2v
	vZH4OS/XVlEeCPWOhl9cnnxshDUBG49Z9hF3/7XB1GuFn2MsxpWL
X-Google-Smtp-Source: AGHT+IFtfyDR9boDmmfEF591oA/p0B2VQoOq0QZKo6ZB7tolgqw9/zygWP3UxD/QMyhPqXrDRH8u2Q==
X-Received: by 2002:a05:6808:14cc:b0:3eb:64a8:837c with SMTP id 5614622812f47-3f313c8e04amr2330880b6e.6.1738079800976;
        Tue, 28 Jan 2025 07:56:40 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f1f088b0ddsm3134959b6e.20.2025.01.28.07.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 07:56:39 -0800 (PST)
Message-ID: <a6e57474-6eff-4f7b-8204-8137f95a33e7@baylibre.com>
Date: Tue, 28 Jan 2025 09:56:37 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
To: 0044dd4b-01ce-4ca0-9855-8c239b9bfb6f@baylibre.com
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <f3972e6aa4ff3869ded1f0dbeb58c43b824b3932.1737985435.git.Jonathan.Santos@analog.com>
 <0044dd4b-01ce-4ca0-9855-8c239b9bfb6f@baylibre.com>
 <Z5jx9mJdi3Zh7Mx6@JSANTO12-L01.ad.analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <Z5jx9mJdi3Zh7Mx6@JSANTO12-L01.ad.analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/28/25 9:04 AM, Jonathan Santos wrote:
> On 01/27, David Lechner wrote:
>> On 1/27/25 9:11 AM, Jonathan Santos wrote:
>>> Add a new trigger-sources property to enable synchronization across
>>> multiple devices. This property references the main device (or
>>> trigger provider) responsible for generating the pulse to drive the
>>> SYNC_IN of all devices in the setup.
>>>
>>> In addition to GPIO synchronization, The AD7768-1 also supports
>>> synchronization over SPI, which use is recommended when the GPIO
>>> cannot provide a pulse synchronous with the base MCLK signal. It
>>> consists of looping back the SYNC_OUT to the SYNC_IN pin and send
>>> a command via SPI to trigger the synchronization.
>>>
>>> SPI-based synchronization is enabled in the absence of adi,sync-in-gpios
>>> property. Since adi,sync-in-gpios is not long the only method, remove it
>>> from required properties.
>>>
>>> While at it, add description to the interrupt property.
>>>
>>> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
>>> ---
>>> v2 Changes:
>>> * Patch added as replacement for adi,sync-in-spi patch.
>>> * addressed the request for a description to interrupts property.
>>> ---
>>>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 22 +++++++++++++++++--
>>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
>>> index 3ce59d4d065f..3e119cf1754b 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
>>> @@ -26,7 +26,17 @@ properties:
>>>    clock-names:
>>>      const: mclk
>>>  
>>> +  trigger-sources:
>>> +    description:
>>> +      References the main device responsible for synchronization. In a single
>>> +      device setup, reference the own node.
>>> +    maxItems: 1
>>
>> We probably actually need 2 here. One for /SYNC_IN and one for a GPIO3 pin
>> acting as the /START signal.
>>
>>> +
>>>    interrupts:
>>> +    description:
>>> +      Specifies the interrupt line associated with the ADC. This refers
>>> +      to the DRDY (Data Ready) pin, which signals when conversion results are
>>> +      available.
>>>      maxItems: 1
>>>  
>>>    '#address-cells':
>>> @@ -46,6 +56,8 @@ properties:
>>>        sampling. A pulse is always required if the configuration is changed
>>>        in any way, for example if the filter decimation rate changes.
>>>        As the line is active low, it should be marked GPIO_ACTIVE_LOW.
>>> +      In the absence of this property, Synchronization over SPI will be
>>> +      enabled.
>>
>> Isn't /SYNC_OUT connected to /SYNC_IN required for synchronization over SPI?
>>
>> If yes, instead of adding this text, I would make the binding have:
>>
> 
> Yes, but the synchronization over SPI is enabled in the absence of the GPIO.
> The trigger-sources property would indicate if the sync provider is the
> own device or not. As i said below, maybe i misunderstood.
> 
>> oneOf:
>>   - required:
>>       - trigger-sources
>>   - required:
>>        - adi,sync-in-gpios
>>
> 
> Wouldn't be simpler to consider the absence of sync-in-gpio? this way we
> have less changes in the ABI.

Maybe it is me that missed something, but if I'm reading the datasheet
correctly, then sync over SPI only works if /SYNC_IN is wired to /SYNC_OUT.
And the chip isn't going to work correctly without some sort of sync. So we
need something wired to /SYNC_IN no matter what.

In any case, the DT bindings should just say how the chip is wired up and not
dictate how the driver should behave. So what I was going for with this is to
have the bindings say that something has to be wired to /SYNC_IN and we can
leave it up to the driver to decide what to do with this information.

> 
>>>  
>>>    reset-gpios:
>>>      maxItems: 1
>>> @@ -57,6 +69,9 @@ properties:
>>>    "#io-channel-cells":
>>>      const: 1
>>>  
>>> +  "#trigger-source-cells":
>>> +    const: 0
>>> +
>>>  required:
>>>    - compatible
>>>    - reg
>>> @@ -65,7 +80,8 @@ required:
>>>    - vref-supply
>>>    - spi-cpol
>>>    - spi-cpha
>>> -  - adi,sync-in-gpios
>>> +  - trigger-sources
>>> +  - #trigger-source-cells
>>>  
>>>  patternProperties:
>>>    "^channel@([0-9]|1[0-5])$":
>>> @@ -99,7 +115,7 @@ examples:
>>>          #address-cells = <1>;
>>>          #size-cells = <0>;
>>>  
>>> -        adc@0 {
>>> +        adc0: adc@0 {
>>>              compatible = "adi,ad7768-1";
>>>              reg = <0>;
>>>              spi-max-frequency = <2000000>;
>>> @@ -109,6 +125,8 @@ examples:
>>>              interrupts = <25 IRQ_TYPE_EDGE_RISING>;
>>>              interrupt-parent = <&gpio>;
>>>              adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
>>
>> Don't we need to drop adi,sync-in-gpios here? I don't think we would have two
>> things connected to /SYNC_IN at the same time.
>>
> 
> I guess i misunderstood the use of trigger-sources. I thought it would
> indicate the trigger provider or main device. Like if it points to other
> device we should use it to drive the SYNC_IN of all devices.
> 
> Then what happens if the trigger-sources points to other node? we would't be
> able to driver the SYNC_IN in case of any configuration change?

I think you understand the trigger-source bindings correctly. 

The driver doesn't have to support everything that the DT bindings allow. This
series is big enough already, so we can defer figuring out how to implement
triggers other than the loopback case later. :-) We just want to make the DT
bindings as complete as we can now.

> 
>>> +            trigger-sources = <&adc0>;
>>> +            #trigger-source-cells = <0>;
>>>              reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
>>>              clocks = <&ad7768_mclk>;
>>>              clock-names = "mclk";
>>


