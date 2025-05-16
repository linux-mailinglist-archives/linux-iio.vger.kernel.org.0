Return-Path: <linux-iio+bounces-19601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E22ABA09C
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 18:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00BDA06AF3
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 16:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DD71D5145;
	Fri, 16 May 2025 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EF4cJVo0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAED149E17
	for <linux-iio@vger.kernel.org>; Fri, 16 May 2025 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747411596; cv=none; b=N9Kd1Cdc1gC67/J4u3XZdo2k8gFRO862aQeNEkaPGodtjK7/KmBzEQOXEvqX/wF1vZPNtr54/ioASbQ/RuwfumvWdU6L2cUQ+S3FoQsXV5OCEZgxLgbCVK0uGI8bdvYIrjF9wWY9x7Yp/ctnKeHyJCogUwQE3JCoZ4mO3Zb9ong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747411596; c=relaxed/simple;
	bh=NJsJt22Ou4Vloxah4jNEyYB3MHXbHXXcLQ1AgkDAB98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4PRQ10Zv/6turXX02WkBPDCjLd4B+0xc1528P3qOz4/yHtKsDsNUR5av6YpHP4XANaes9Rp//KYWrXOxRytfsyeFATyJn2FXVk7pQ5n7gt2FQ1JeZ1h9Rz1ZzSisVaH1LSqv/7gyy9l5OPMctzZzkIQPSVLVek8tZ3+f1oL4sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EF4cJVo0; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2cc36b39545so236090fac.1
        for <linux-iio@vger.kernel.org>; Fri, 16 May 2025 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747411592; x=1748016392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HWlBYMs+G2O1hnBcI+2U3m/ebczROAhhuj3hfKR/QyA=;
        b=EF4cJVo0H/JFr9b+SQdVGcjYYfTOPFkrNXKK5MOGL0LttdT2oiLYf1m2J5tdPhLkYb
         8H/uadfrU6FA8xVsBytw93k2SX8n+fKJL0OK/Snp6Zh52t0Ek+XJj9YsgK9rCbVH/6ja
         lYCa8MCl6nTNId2ZzsubC8P+S/YXdogQBlpbNKk8ryJXbJRxEehf2+iefvvnyQsTOLCs
         SrqrPFZrzitdJtf04K+q+GgvmrnlB0mDZgMPd3swb84DPI4qI6sLTc7bEyWVM/k7ct1q
         G/3My10FY/eMdofO2VxDol0Sa04vrXzL9GB8POYOW/xbJCPEa+mhUbktg8Tjdr3m4Lvf
         N4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747411592; x=1748016392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWlBYMs+G2O1hnBcI+2U3m/ebczROAhhuj3hfKR/QyA=;
        b=W0XvfLF0SqshozoQYQctUUmBnKTxTUGB4kG1yfFHAahwSS0z69w6ezzICIFQNu2oRI
         Ps+fC4DvkQbK/4vit/PDZ7bUcqDleJ6I7nLJemSuIrRD6vr2whyK2h8Qa5hL0eguFma7
         gUjrPb3H3Fa6TZhBrbE8VTn6eUXhdgzXSXZRZZec+osDQhXYzxqM8b+fyx91GC7dhw2V
         2Mu7IKkJepPl5ZmZ0IzJA5Wd+9BQ8EJ0DUKUYiUjfMa2BQqGc1RWHaOPmeURyq09VAr/
         Qi7MAt2B+NZwrhoNnN7Ci2hBnHPQ2R78WsYWHWukDuwL22zYdoqJgjK2PEo4xcWBgvsF
         Dj6A==
X-Forwarded-Encrypted: i=1; AJvYcCW7wdGmax4ZyUHV9EKAYf0bQFMrItSS5ncyA+ke7rBrohje5oAtHl025+JaX2h6ynr5heOY8/l71wE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBnbnfuw0Ue/mIWwXX374mRGIsXkFn/hODhGBO8Qdk4UPDWB1K
	uR0RxnRqY6zV0ouhm8bJs8P5GIajttrlETEssKqJIJqS6d6oTu6QkneiAqwEXwo8cH8=
X-Gm-Gg: ASbGncu+blCIpVXtWbkExyKlf5jlT+b9fSBDlGwA8cjy9Izhfh3AJQtZwyHTZncUuaA
	+/essqOaioOWRUsWmOFLCCn+5uRYM2Yzg3P1vhg+NGawEApBlA9Cg9WfC//DEr40jVaCQbnQP3K
	c0zyRR1dKa0lHtmpFGAbusjdsHZ4vCC95202FQfM3x3bbWNbCISswkTMLtMaiHbk91BwzbPg5yE
	Skpj4WprW692dhToUGrKGGDq8D2F47oxYaCpeVZYZJtfX2HsPqrRsdB7oI17jCW9Q3ZRr70juW0
	bL1QDUpF6mNjL7WIy1GBItQ8tmKd6NcdmTpTDfI2RvWVgs4/DD9sv/fVuhdEjtuv11OGv58AQN6
	BLwq+q8iG3Tn3YyZTgTEbmsaRgQ==
X-Google-Smtp-Source: AGHT+IFoJs3fuisk7mzI66aYlQ9JiNRvN0cxCbKHzCUMWSGPfMIPRK8lo74bJ6bAidLAwv2PG4JcGg==
X-Received: by 2002:a05:6871:400b:b0:29d:c6dd:cc6c with SMTP id 586e51a60fabf-2e3c2a9edf4mr2338495fac.15.1747411592412;
        Fri, 16 May 2025 09:06:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d2f:9b08:7c22:3090? ([2600:8803:e7e4:1d00:d2f:9b08:7c22:3090])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-734f6b5e60esm390866a34.59.2025.05.16.09.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 09:06:31 -0700 (PDT)
Message-ID: <bfd606f0-e253-4685-9025-5bdc7aafacbe@baylibre.com>
Date: Fri, 16 May 2025 11:06:30 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] dt-bindings: iio: adc: Add AD4170
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linus.walleij@linaro.org, brgl@bgdev.pl
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
 <5fa867cff437c0c6d3f0122af823e1677a12d189.1747083143.git.marcelo.schmitt@analog.com>
 <2ab9a6e2-a331-4995-8d42-00290bc825e7@baylibre.com>
 <aCddgYRWrLPlGeuR@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aCddgYRWrLPlGeuR@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/16/25 10:45 AM, Marcelo Schmitt wrote:
> ...
>>> +
>>> +    properties:
>>> +      adi,reference-select:
>>> +        description: |
>>> +          Selects the reference source to use when converting on the specific
>>> +          channel. Valid values are:
>>> +          0: Differential reference voltage REFIN+ - REFIN−.
>>> +          1: Differential reference voltage REFIN2+ - REFIN2−.
>>> +          2: Internal 2.5V referece (REFOUT) relative to AVSS.
>>> +          3: Analog supply voltage (AVDD) relative AVSS.
>>> +        $ref: /schemas/types.yaml#/definitions/uint8
>>> +        enum: [0, 1, 2, 3]
>> Using strings instead of int for this and most of the other custom enums here
>> would make them self-documenting and easier to use.
> 
> The numbers match the values that are documented in the datasheet for each
> option of voltage reference available to use with a channel. So we would be
> using numbers mostly to define values of some unit and pin numbers (e.g. 100 for
> the microamp property)? Not really excited about doing this change because I
> think it will make the dtb a bit larger and the driver code a bit more lengthy,
> but can do that for v4.

I don't think it is too bad since we have match_string() to convert the strings
to an enum value. So it would just be a matter of adding the string tables.

But I don't feel terribly strongly about it anyway.

> ...
>>> +
>>> +      adi,power-down-switch-pin:
>>> +        description:
>>> +          Number of the GPIO used as power-down switch for the bridge circuit.
>>> +        $ref: /schemas/types.yaml#/definitions/uint8
>>> +        enum: [0, 1]
>> This isn't required, so what is the default if omitted?
> 
> We don't care about it when the property is omitted.
> Do we need a default even when the property is not required and we don't care
> when it's not set?

Ah, in that case, maybe add a bit to the description to say that this
is omitted when there isn't a bridge circuit wired up.

> 
> ...
>>> +      diff-channels:
>>> +        description: |
>>> +          This property is used for defining the inputs of a differential
>>> +          voltage channel. The first value is the positive input and the second
>>> +          value is the negative input of the channel.
>>> +
>>> +          Besides the analog input pins AIN0 to AIN8, there are special inputs
>>> +          that can be selected with the following values:
>>> +          17: Internal temperature sensor
>>> +          18: (AVDD-AVSS)/5
>>> +          19: (IOVDD-DGND)/5
>>> +          20: DAC output
>>> +          21: ALDO
>>> +          22: DLDO
>>> +          23: AVSS
>>> +          24: DGND
>>> +          25: REFIN+
>>> +          26: REFIN-
>>> +          27: REFIN2+
>>> +          28: REFIN2-
>>> +          29: REFOUT
>>> +          For the internal temperature sensor, use the input number for both
>>> +          inputs (i.e. diff-channels = <17 17>).
>>> +        items:
>>> +          enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 17, 18, 19, 20, 21, 22, 23, 24, 25,
>>> +                 26, 27, 28, 29]
>>
>> A Header file with macros for these would be nice since it seems like we
>> have to use the higher-numbered ones a lot with the common-mode-channel
>> properties in the examples.
> 
> The RFC set had a header with macros for those numbers, but making dt properties
> "look nice" was said to no be a reason to have binding headers. 
> 
> https://lore.kernel.org/linux-iio/ikq55kcfu2lmxzeeobu4zwf67xypyikadnpycw2m4d7o6gvmi2@tkepvcvzqzoh/
> 

Hmm, OK I never got that complaint before. Although the headers I have made before
were defining arbitrary numbers for phandle cells, and not something from the
datasheet like this.

> Also, no other binding would use those values. So, we would have a header
> specific for adi,ad4170?

Yes.

> 
>>
>>> +
>>> +      single-channel: true
>>> +
>>> +      common-mode-channel: true
>>> +
>>> +      bipolar: true
>>> +
>>> +      adi,buffered-positive:
>>> +        description: |
>>> +          Enable precharge buffer, full buffer, or skip reference buffering of
>>> +          the positive voltage reference. Because the output impedance of the
>>> +          source driving the voltage reference inputs may be dynamic, RC
>>> +          combinations of those inputs can cause DC gain errors if the reference
>>> +          inputs go unbuffered into the ADC. Enable reference buffering if the
>>> +          provided reference source has dynamic high impedance output. Note the
>>> +          absolute voltage allowed on positive reference inputs (REFIN+,
>>> +          REFIN2+) is from AVSS − 50 mV to AVDD + 50 mV when the reference
>>> +          buffers are disabled but narrows to AVSS to AVDD when reference
>>> +          buffering is enabled or in precharge mode.
>>> +          0: Reference precharge buffer.
>>> +          1: Full Buffer.
>>> +          2: Bypass reference buffers (buffering disabled).
>>> +        $ref: /schemas/types.yaml#/definitions/uint8
>>> +        enum: [0, 1, 2]
>>> +        default: 1
>>> +
>>> +      adi,buffered-negative:
>>> +        description: |
>>> +          Enable precharge buffer, full buffer, or skip reference buffering of
>>> +          the negative voltage reference. Because the output impedance of the
>>> +          source driving the voltage reference inputs may be dynamic, RC
>>> +          combinations of those inputs can cause DC gain errors if the reference
>>> +          inputs go unbuffered into the ADC. Enable reference buffering if the
>>> +          provided reference source has dynamic high impedance output. Note the
>>> +          absolute voltage allowed on negative reference inputs (REFIN-,
>>> +          REFIN2-) is from AVSS − 50 mV to AVDD + 50 mV when the reference
>>> +          buffers are disabled but narrows to AVSS to AVDD when reference
>>> +          buffering is enabled or in precharge mode.
>>> +          0: Reference precharge buffer.
>>> +          1: Full Buffer.
>>> +          2: Bypass reference buffers (buffering disabled).
>>> +        $ref: /schemas/types.yaml#/definitions/uint8
>>> +        enum: [0, 1, 2]
>>> +        default: 1
>> Could make a $def for these too to reduce duplication.
> 
> I think so, but how? They are only documented here. I can merge them into a
> single adi,buffered property. That will also reduce duplication.

You already have $defs:, so just add precharge-buffer: there with
the description:, etc., then here, just:

	adi,buffered-positive:
	  $ref: '#/$defs/precharge-buffer'
	adi,buffered-negative:
	  $ref: '#/$defs/precharge-buffer'


