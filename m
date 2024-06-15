Return-Path: <linux-iio+bounces-6305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 723E19098E2
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 17:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB99CB21875
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 15:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E24B49650;
	Sat, 15 Jun 2024 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B0Kps+OA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA003482EB
	for <linux-iio@vger.kernel.org>; Sat, 15 Jun 2024 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718465017; cv=none; b=PCBIijDcUoklgGAXPxBgmNFcmeTCVnUKMCvAz3GjTanB25XTIm+Tj1c6LcjSnNxnAmfEGj8qFJp0tA7xd4dHMgnMSPvw3uZPJUZSwMkB6864wXX7xvFDfKlx/ichQE2yrKF7sd9TBqIUuo3GPOBi+0WyjaoFcHnxjbHJgndT9q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718465017; c=relaxed/simple;
	bh=Zi1DG4/ToLpRr7sD8ntJhw8rvmFS29+RyXeCAK4BCxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhBYlqz7tl8U4ZBQyof9zgwwu/H78kf0g/NoQXhvCE1fDtUgRa1MpAdSOM74It3zIApoR/6Cf/rItg5mab76UMzg0TT/+nJYOyxyYnlsP0UyJgMnDhEuwYc9M2jjvybjmWrTJ+MfQb88ilAlTWFRuwsq0LwElksUl3GjaikfAtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B0Kps+OA; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6fa11ac8695so1722212a34.3
        for <linux-iio@vger.kernel.org>; Sat, 15 Jun 2024 08:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718465013; x=1719069813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZsBU5Xj8M4QV9IJdKvhDoz3IvGILgPk2VkuCu/9X5xc=;
        b=B0Kps+OAe2ZNG5UWLJxvX6FhLnLNoKczrnqsJ2FM8/O6h3ZTa5Iwr8Z0xiY/vw1QJP
         7kpjRYZC9mQMVOmcgJc/ffR5HfdwjW9i+u9HpLA2QpkLfd//i3tWAms79q9MrUc/xr1k
         4XkAUTs4SItGwSeJe7FocLFsmIfyorKRxsP1qYLLEaEPiwDf8cL5k7QRwPuvFihkEVu6
         lNGhkueSOF8OqX/NiD7JOh/0Py6gQG+zQV2F0Gh3gjoF35xlQnnZ9hX46tcfdoPqa93/
         ggoacpXA5/C+ibYeLupwul5ytGwSaCC4sqLf4EOH5xN61bC3ynJ0aT3paYi3Jn7VQ4hv
         ye8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718465013; x=1719069813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsBU5Xj8M4QV9IJdKvhDoz3IvGILgPk2VkuCu/9X5xc=;
        b=N6sj2JhGjzxOoaxP78FBvIOjew+lOUMRQ4rJUlmwS+ueUe+uudQ5Kg14Q949Ki75aw
         exY2aHCHSg18r9mCMjCbycw0+xtucjok22+SGbfZBZKJ633LiGAHzPdnVPJ/v6poiNrm
         6Q9sacOuAhmUFqsu6QadVQX4/IP+iM0HbEPUCUnYvLPawxH528MNkK9xadDSi8E8pBbz
         X3q5SdTZuX4TijNijovZHTMTbhWoAzaQNbIhGOK26lRSBilv92M6/2/5Vh99A0Az3bjH
         WHIhGsXfnI/vHvlFk4by9WCuZWNl4ba/yNPxrzPiQ6o/hHef7hdupZa6GwHaoPPqrt4v
         9djw==
X-Forwarded-Encrypted: i=1; AJvYcCUNj9Mnka5o7bUkl55sQX8otSKo+LjGbEEk0sTRTnpv4uOx60WVEe6Xjz2m1LBLZOWrHbITrc0jsUiKhx2tuFueDOu712/i+Hdh
X-Gm-Message-State: AOJu0Yy8KMsvylxfwyGOuLcf1DFYqh1T+plZN1eDgfQV6FhW6pSxFeV+
	bLN65ojkaPba/9CF4R0xxvMeBjDkOEf3b7Tcl0D48sWren7HlE1w6sCikeHkBW8=
X-Google-Smtp-Source: AGHT+IFOzQRVl1DUGBTfZM7ghSRRJsI7JpxmxAUM+zQNjPRb5PgTpOYBtuSfwJltE2YwPuuPMXZD5Q==
X-Received: by 2002:a05:6870:b14a:b0:254:d05e:4cd5 with SMTP id 586e51a60fabf-25842b73c65mr5811615fac.38.1718465013582;
        Sat, 15 Jun 2024 08:23:33 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a9a7fd9sm1583505fac.15.2024.06.15.08.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jun 2024 08:23:33 -0700 (PDT)
Message-ID: <2d9a1405-4b8d-401b-99c4-434ac4b57f6e@baylibre.com>
Date: Sat, 15 Jun 2024 10:23:31 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add AD4695 and similar ADCs
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240612-iio-adc-ad4695-v1-0-6a4ed251fc86@baylibre.com>
 <20240612-iio-adc-ad4695-v1-1-6a4ed251fc86@baylibre.com>
 <20240615134106.40e55e16@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240615134106.40e55e16@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/15/24 7:41 AM, Jonathan Cameron wrote:
> On Wed, 12 Jun 2024 14:20:40 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Add device tree bindings for AD4695 and similar ADCs.
>>

...

>> +
>> +  avdd-supply:
>> +    description: A 2.7 V to 5.5 V supply that powers the analog circuitry.
> 
> I'm a cynic.  Do we care about the supported voltages in this binding doc?
> Feels just somewhere we might make a mistake.

Not especially useful, I suppose. I'll clean these up a bit.

> 
>> +
>> +  ldo-in-supply:
>> +    description: A 2.4 V to 5.5 V supply connected to the internal LDO input.
>> +
>> +  vdd-supply:
>> +    description: A 1.8V supply that powers the core circuitry.
>> +
>> +  vio-supply:
>> +    description: A 1.2V to 1.8V supply for the digital inputs and outputs.
>> +
>> +  ref-supply:
>> +    description: A 2.4 V to 5.1 V supply for the external reference voltage.
>> +
>> +  refin-supply:
>> +    description: A 2.4 V to 5.1 V supply for the internal reference buffer input.
>> +
>> +  com-supply:
>> +    description: Common voltage supply for pseudo-differential analog inputs.
> 
> These last few have more info in them so definitely good to have the descriptions
> 

...

>> +
>> +patternProperties:
>> +  "^channel@[0-9a-f]$":
>> +    type: object
>> +    $ref: adc.yaml
>> +    unevaluatedProperties: false
>> +    description:
>> +      Describes each individual channel. In addition the properties defined
>> +      below, bipolar from adc.yaml is also supported.
>> +
>> +    properties:
>> +      reg:
>> +        maximum: 15
>> +        description: Input pin number (INx).
> 
> I'd drop this description as the pin pairing makes it messy.
> If you switch to diff-channels etc, just leave it as a index value not
> connected to the pin numbers.
> 
>> +
>> +      adi,pin-pairing:
>> +        description: |
>> +          The input pin pairing for the negative input. This can be:
>> +          - REFGND, normally 0V (single-ended)
>> +          - COM, normally V_REF/2, see com-supply (pseudo-differential)
>> +          - For even numbered pins, the next odd numbered pin (differential)
>> +        $ref: /schemas/types.yaml#/definitions/string
>> +        enum: [refgnd, com, next]
> 
> Next is full on differential, just provide both channels via
> diff-channels. You can constrain the particular combinations in the binding.
> 
> Refcnd is normal single ended.  Probably want to use the new single-channel
> property for that as we are mixing differential and single ended channels
> so reg is pretty much just an index.
> 
> Hmm. For comm we haven't had done a recent binding for a chip with the option
> of pseudo differential that is per channel, they've been whole device only.
> That feels like it will be common enough we need to support it cleanly
> with a 'general' scheme.

I think we have. :-)

https://lore.kernel.org/linux-iio/adc6cba9-2e79-475f-9c24-039fe9d3345d@baylibre.com/T/#mcbc1ce3a2541db502bf7870b7ea8574626a46312

> 
> Problem is I know someone will have a chip with 2 vincom pins and selecting
> between them, so we can't just have pseudo-differential as a boolean and adc.yaml
> 
> There are horrible solutions like a magic channel number that changes the
> meaning of diff-channels but that's ugly.
> Maybe pseudo-differential for now and we have to later we add
> pseudo-differential-comm  = <0> etc?
> 

I was trying to keep things simple with 1 property instead of 3, but we
can drop adi,pin-pairing and use the standard diff-channels, single-channel
and common-mode-channel properties.


> 
>> +        default: refgnd
>> +
>> +      adi,no-high-z:
>> +        $ref: /schemas/types.yaml#/definitions/flag
>> +        description: |
> 
> Do we need the | given not really formatted?

No. Was probably copy/paste.

> 
>> +          Enable this flag if the input pin requires the Analog Input High-Z
>> +          Mode to be disabled for proper operation.
>> +

...

>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    spi {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        adc@0 {
>> +            compatible = "adi,ad4695";
>> +            reg = <0>;
>> +            spi-cpol;
>> +            spi-cpha;
>> +            spi-max-frequency = <80000000>;
>> +            avdd-supply = <&supply_2_5V>;
>> +            vdd-supply = <&supply_1_8V>;
>> +            vio-supply = <&supply_1_2V>;
>> +            ref-supply = <&supply_5V>;
>> +            reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
>> +
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +

Using the standard adc.yaml properties, these would now be:

>> +            /* Differential channel between IN0 and IN1. */
>> +            channel@0 {
>> +                reg = <0>;

                    diff-channels = <0>, <1>;

>> +                bipolar;
>> +            };
>> +
>> +            /* Single-ended channel between IN2 and REFGND. */
>> +            channel@2 {
>> +                reg = <2>;

                    single-channel = <2>;
		    common-mode-channel = <0>;

>> +            };
>> +
>> +            /* Pseudo-differential channel between IN3 and COM. */
>> +            channel@f {
>> +                reg = <3>;

                    single-channel = <3>;
                    common-mode-channel = <1>;

>> +                bipolar;
>> +            };
>> +        };
>> +    };
> 

And I will add a header file with macros for the common mode
channel values.


