Return-Path: <linux-iio+bounces-6813-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CA291500D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 16:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3E11F20F93
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F9119AD5D;
	Mon, 24 Jun 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D4Qg4kWO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1037319AA7F
	for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239808; cv=none; b=KRli1xaNyNYWICe6iF0X5p32KVEdC9nIGDu1fphqZABX7WX8s/zuah46srdA0P8rlb9tGQhmD48JwzcLjyu3CSTtAKLY4kwp0oo9pQESkSB4h5oyrhOsyHKefyINpC6LE8H+88sl85bfXzahg9AzvD5i1/W0feiLO16QKF9Omjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239808; c=relaxed/simple;
	bh=wggDE/bgRHa1L4mODGwspiGnIRUUi8LE6HqPBbnBW1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwetPA111SK3RahFnVZOOSd7XcfQ40nouq/VG2KZFl7smK9Bf+881z/W7lmVElmq719krUm6PQ2iuIvqZHP91M3ve/8a1wgBx5g/rA8D+faWI7LxKDcCkACGRtQhFi9mMh/8+XyofApIge/1EiJO3okCMYi6VJtX/rsry+l61H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D4Qg4kWO; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-25c9ef2701fso2522785fac.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719239805; x=1719844605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bv7pX3A7e0aATefTLSH8Hc9sIVLTEzJJ10hAyVPLd4s=;
        b=D4Qg4kWOMTyXlMutlJzC7nJPcQ8Xchp+bLyQAo7/b4CoIgTwRh6xctArKTEpTMpFAd
         So3i7k/sLXj7KMHdwCdkxmFZlEtL6gwpqsmh2dEVYX37Pr1H+TJcmLD/mfBDVpLzZ4qC
         cRNZSkfnXrlKesXqYyuslEBwByN/gQFYxkty6aU1C0FBjdv06Re4kLda4tI6RWhgP7fT
         3VqmzvZqBH4Wqrci+HYSNXA/a7dkxemWZKpUCwVnp9MFbnSmVkA2ORTj5MuwGLjMoINz
         AAE1G1COvnoe25qhhMpMyO5nSTGUr7stPU6ip7DbHFAMaeM3HWtxvdmp8PNlJ8nXy7vT
         ItOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719239805; x=1719844605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bv7pX3A7e0aATefTLSH8Hc9sIVLTEzJJ10hAyVPLd4s=;
        b=vddK7hBzTywysmKkSiAAEQ2i2MpKlCyUw5bPzZZRbp/RHOOhAED3ezWbq3/FbhFORw
         sKFK8EC0N+TEGziNPpRQiPy+7RIedF/N1d72W6nM3dA+EPYbZEjQWS3IkpbsVJ/OGdR5
         KsUdCbC+YiuKCtTxuNQ4BwAy1Or8vVvzAUniwU04cK1sKZZSoKKGyN7SJbE9nP2RrNZM
         BqCQPwfWq2Ugb1Z+sJ83L6xA+fhsN9bbPC1DBX6Z5SjbuQhXMjdos7R9JEVXIg9yK/Ap
         UvB2mRx4RMmsgyeIhAoqzNhGYii9mYTdXEKR/nnC1fpdyAKFxoxILSXSICJ8+M064pTq
         fQ3w==
X-Forwarded-Encrypted: i=1; AJvYcCX8IZl7y6DG8JPF+wyeeK0xRnmFdiBoE+KVVUCTLre2QA0cKUdms55kTgTDY4ze2oH0SkHES4d22LSLTkoYTJsHknJ5YtumXYAN
X-Gm-Message-State: AOJu0Ywuk05QamtDHc5ppjhV+I+ZYsNbFPI3xZc8q6M4nHWxv23E5jbY
	rPUQOCs64L4vYOZZF8icucaNPpN+SDEwfpikirTGq2nUnkWJDKfuzqMmgLqvIaE=
X-Google-Smtp-Source: AGHT+IHwuPQplsBX8FrXFbl4eyzFRD7RhUchQKz0/ngb6Hz3DMqC+czTWLIPmE8rnu0aE5J8JeEIEw==
X-Received: by 2002:a05:6870:b4a4:b0:254:b6f0:21b6 with SMTP id 586e51a60fabf-25d06bb45d2mr4708448fac.10.1719239804925;
        Mon, 24 Jun 2024 07:36:44 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25cd4941a11sm1895787fac.9.2024.06.24.07.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 07:36:44 -0700 (PDT)
Message-ID: <204e6729-d5b0-4d44-85d5-e8de7541b689@baylibre.com>
Date: Mon, 24 Jun 2024 09:36:43 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: adc: add AD4695 and similar ADCs
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240617-iio-adc-ad4695-v2-0-63ef6583f25d@baylibre.com>
 <20240617-iio-adc-ad4695-v2-2-63ef6583f25d@baylibre.com>
 <187da75c-9af3-42a9-b31e-be731aaf63d2@baylibre.com>
 <20240623173911.7ea5d518@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240623173911.7ea5d518@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/24 11:39 AM, Jonathan Cameron wrote:
> On Tue, 18 Jun 2024 14:29:10 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 6/17/24 2:53 PM, David Lechner wrote:
>>> Add device tree bindings for AD4695 and similar ADCs.
>>>
>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>> ---
>>>   
>> ...
>>
>>> +
>>> +  interrupts:
>>> +    minItems: 1
>>> +    items:
>>> +      - description:
>>> +          Signal coming from the BSY_ALT_GP0 or GP3 pin that indicates a busy
>>> +          condition.
>>> +      - description:
>>> +          Signal coming from the BSY_ALT_GP0 or GP2 pin that indicates an alert
>>> +          condition.
>>> +
>>> +  interrupt-names:
>>> +    minItems: 1
>>> +    items:
>>> +      - const: busy
>>> +      - const: alert
>>> +  
>>
>> Since the interrupt can come from two different pins, it seems like we would
>> need an extra property to specify this. Is there a standard way to do this?
>>
>> Otherwise I will add something like:
>>
>> adi,busy-on-gp3:
>>   $ref: /schemas/types.yaml#/definitions/flag
>>   description:
>>     When present, the busy interrupt is coming from the GP3 pin, otherwise
>>     the interrupt is coming from the BSY_ALT_GP0 pin.
>>    
>> adi,alert-on-gp2:
>>   $ref: /schemas/types.yaml#/definitions/flag
>>   description:
>>     When present, the alert interrupt is coming from the GP2 pin, otherwise
>>     the interrupt is coming from the BSY_ALT_GP0 pin.
> Cut and paste?  Or it ends up on the same pin as the bsy? In which case that's
> a single interrupt and it's up to software to decide how to use. I'll guess
> it comes on GP1?

This is not a typo. The BSY_ALT_GP0 is a multi-purpose pin. The actual function
of the pin isn't selected explicitly, but rather there is an order of priority
(Table 25 in the datasheet).

Also, there are two packages the chip can come in, LFCSP and WLCSP. The former
only has GP0 and not GP1/2/3.

My thinking was that if both interrupts are provided in the DT and neither
adi,busy-on-gp3 or adi,alert-on-gp2 is given, then the driver would use
a shared interrupt and only allow enabling one function alert or busy
at a time.

>>
> 
> More interrupt names.  We shouldn't restrict someone wiring all 4 if they want
> to - we'll just use 2 that we choose in the driver.
> 
> interrupt-names
>   minItems: 1
>   items:
>     - const: busy-gp0
>     - const: busy-gp1
>     - const: alert-gp2
>     - cosnt: alert-gp1

This would actually need to be:

interrupt-names
  minItems: 1
  items:
    - const: busy-gp0
    - const: busy-gp3
    - const: alert-gp0
    - cosnt: alert-gp2

Or would it need to be this since there are two possible signals on the
same pin rather than trying to mess with a shared interrupt?
(Note: if both alert and busy are enabled at the same time on GP0, we
will only get the alert signal and busy signal is masked).

interrupt-names
  minItems: 1
  items:
    - const: alert-busy-gp0
    - const: busy-gp3
    - cosnt: alert-gp2

> 
> T   
>>
>>> +
>>> +patternProperties:
>>> +  "^channel@[0-9a-f]$":
>>> +    type: object
>>> +    $ref: adc.yaml
>>> +    unevaluatedProperties: false
>>> +    description:
>>> +      Describes each individual channel. In addition the properties defined
>>> +      below, bipolar from adc.yaml is also supported.
>>> +
>>> +    properties:
>>> +      reg:
>>> +        maximum: 15
>>> +
>>> +      diff-channels:
>>> +        description:
>>> +          Describes inputs used for differential channels. The first value must
>>> +          be an even numbered input and the second value must be the next
>>> +          consecutive odd numbered input.
>>> +        items:
>>> +          - minimum: 0
>>> +            maximum: 14
>>> +            multipleOf: 2
>>> +          - minimum: 1
>>> +            maximum: 15
>>> +            not:
>>> +              multipleOf: 2  
>>
>> After some more testing, it turns out that I misunderstood the datasheet and
>> this isn't actually fully differential, but rather pseudo-differential.
>>
>> So when pairing with the next pin, it is similar to pairing with the COM pin
>> where the negative input pin is connected to a constant voltage source.
> 
> Ok. I'm curious, how does it actually differ from a differential channel?
> What was that test?  It doesn't cope with an actual differential pair and needs
> a stable value on the negative?

In my initial testing, since I was only doing a direct read, I was using
constant voltages. But when I started working on buffered reads, then I
saw noisy data when using a fully differential (antiphase) signal.

This chip uses a multiplexer for channel so when an odd number pin is used
as the positive input (paired with REFGND or COM), it goes through one
multiplexer, but when an odd number pin is used as the negative input
it goes through the other multiplexer - the same one as REFGND and COM.

And burred in the middle of a paragraph on page 34 of 110 of the datasheet
is the only place in the entire datasheet where it actually says this is
a pseudo differential chip.

> 
>>
>>> +
>>> +      single-channel:
>>> +        minimum: 0
>>> +        maximum: 15
>>> +
>>> +      common-mode-channel:
>>> +        description:
>>> +          Describes the common mode channel for single channels. 0 is REFGND
>>> +          and 1 is COM. Macros are available for these values in
>>> +          dt-bindings/iio/adi,ad4695.h.
>>> +        minimum: 0
>>> +        maximum: 1
>>> +        default: 0  
>>
>> So I'm thinking the right thing to do here go back to using reg and the INx
>> number and only have common-mode-channel (no diff-channels or single-channel).
>>
>> common-mode-channel will need to be changed to allow INx numbers in addition
>> to COM and REFGND.
>>
>> This means that [PATCH v2 1/4] "dt-bindings: iio: adc: add common-mode-channel
>> dependency" would be wrong since we would be using common-mode-channel without
>> single-channel.
>>
>> It also means we will need an optional in1-supply: true for all odd numbered
>> inputs.
> Ok. I'm not totally sure I see how this comes together but will wait for v3 rather
> than trying to figure it out now.
> 
> Jonathan
> 
> 

It should end up like other pseudo differential chips we have done recently.
I've got it worked out, so you'll be seeing it soon enough anyway.

