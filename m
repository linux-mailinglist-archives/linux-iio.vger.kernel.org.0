Return-Path: <linux-iio+bounces-23654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B298B408F3
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 17:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111CE1B257F4
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 15:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EB92E0917;
	Tue,  2 Sep 2025 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Qo5pXRib"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C302D6E57
	for <linux-iio@vger.kernel.org>; Tue,  2 Sep 2025 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827054; cv=none; b=s3nlwD0WEKqXVFW+l3XTOCL9M8Za0rC8gG31h2gr5hj5IVv/lDZoFS0CmBnWARUeVlrKT0fdLe6lV8X3kEQRvBn0iWC9pKwBH+uxRgmpHV/UFqC4IDCgOfjRKTdFmCtSB7CI/DNSsj0lOw+SGiJQBDXOu1ic+ojz/sPfqJKelIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827054; c=relaxed/simple;
	bh=H5D1mB92sVGC6p9xvxd1ycfmo/pkWqLUN1RRpbx9IGk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kCkjTXlTklpNeI4392661Q0nFHfhHH0BMgl+ixtODS+Waazvc7s/ljIzmtb1KnhdVLiRwt726OsEEACeXJWajUOUfluS4WIiO6KK/yqRRKmpi+YplQPzj9iyB+eodN2t/Q9/0SKS8h0MSMeZ9dhOnMsZ5tnGGQYAy5TixGKhBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Qo5pXRib; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-30ccebab736so4807637fac.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Sep 2025 08:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756827051; x=1757431851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cqQ4WPvFOC/zDvh2F7EYF1aCNsNr1wJdA0MPmR/NX3o=;
        b=Qo5pXRibrGRLi9tNUDaGyfy5b4tRNvPTawufsk3Ukd+ISmJjI8jRB1QyNkV0T+R6ry
         tVdg1OgGD7eCC6IdP5+ueDaPTeYRpzfDSEBRajKjKYo0LDOdp6GQWD+Z/md+rkAqYy1J
         +39OUts3NO7mkZ18HYEtuMsVnHAbMOxCp9utsQ42ZuvDJQXgqx6aY42mePUPs6zaWMc2
         OkryK9gvpfQwfejEiOPIYq29GO3+r3+RIuw0xJGTJnndsNXpmXl7a8VC2hPzNod2x6YN
         KCP1dkKjMv7wrFMu2887Ut7VtEzyu6dz692WaqTZIwpNSOgLTWww9tqVC0drY8pv35mM
         Na8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756827051; x=1757431851;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqQ4WPvFOC/zDvh2F7EYF1aCNsNr1wJdA0MPmR/NX3o=;
        b=f3kAnsE4DEgFxB9J8hxxjT9ImE/9MyLuuYm8xFolLAiKt0oW+9PRpUcRWlZ49e10CD
         3RKpPrzyM40t/IuxdVFY/ZrDl6oQku57Sx/S0qrM+BZJpc0sDcflLlZJz8+9IhdN9fua
         fK55CC+mTFF6cswLbFdcMLKFdifLpo9GrlOslaVLFRcdiqNONVsEw348jxYkSdVIiW8C
         sdzfbdrutJjLZY7RBuzwV03t4h4S4LsPAXcCG9z5yjqycSTDjEvMk7xhxOni6oFQgn5l
         qlFB4Em02joNgOvS1PsMSYVvWRzX1dSMZETIiD/aDHcwUKfieLhjjO7KxsqQhZjqA2ho
         6n6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbjlD75KSY3bGfqNMpGpNMX3MY2mDV4ZzjpwbrlSeyf45SZ8t/uBgGIRl7u298y2/DdhUfjFK5Fu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQwTIUuILD8CC1+EhWOMsVxvVdEWIhLtR8i4u1FReQNnDUrDjA
	hDqUhNoJ/mTQ/56Xr7JvCCfvE6fimlbd+uSHzQK/IZgNPTs1QKgl+5Dhy+vUj27Sv+Y=
X-Gm-Gg: ASbGncu9vnBKEAF/Qp7TXihMFRrxDsZCG9DkuDB8L57T3VmPrXbyO368GrX50FoDu5X
	2v0IbrYcJpA4vfoYazqFRLmxvf9rVtz1wFPqAlaK04XtGnymXjg9mbOKnZA5ax4VyH+KUCG0VTK
	X2b0/ZHIZ38vR2gpsipscJtVArFJvBvRoVHQqvbIipQw7AJrtRi6IQBnwhUdEX43QpUeojhYkOB
	Zm6aXcP9tqz140zX9j528t7EX/aI0c6yzV/5B4k/i6KmrqKqgTLWsx4oRV3Zf3I042ca+Oo4iS6
	dn3fhIa8W9VzdkoADjaLPprSv4gIoxGySzjIdbtRs9Hc/XMTwQMXXITb3EFxLpZmXX01+k6CsQj
	DTSWoT9urFDu9pFUbwWbhmXuaK4Ubov/zdEweOlfS2nv4786Y7SzoTE5+T1W44I7TYhZ5e6xS
X-Google-Smtp-Source: AGHT+IHT8XwRiHCN75IMWkHExPEmJnsitMmA0YzWNkodLNJRcwmanY0UNlPygOc7Bc7GtosZ+wqf2w==
X-Received: by 2002:a05:6870:e0d4:b0:315:7456:1ec2 with SMTP id 586e51a60fabf-3196337628emr4327586fac.24.1756827049391;
        Tue, 02 Sep 2025 08:30:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d95:114e:b6f:bf5b? ([2600:8803:e7e4:1d00:8d95:114e:b6f:bf5b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-745742a6716sm1644969a34.14.2025.09.02.08.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 08:30:48 -0700 (PDT)
Message-ID: <7176887b-d406-46e4-b43a-7924c36ddb78@baylibre.com>
Date: Tue, 2 Sep 2025 10:30:47 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/2] dt-bindings: iio: adc: add max14001
From: David Lechner <dlechner@baylibre.com>
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Kim Seer Paller <kimseer.paller@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>
References: <cover.1756816682.git.marilene.agarcia@gmail.com>
 <34b7cc7226e789acdc884d35927269aa5a0d5e14.1756816682.git.marilene.agarcia@gmail.com>
 <89265de7-eeff-4eea-838b-6a810c069a20@baylibre.com>
Content-Language: en-US
In-Reply-To: <89265de7-eeff-4eea-838b-6a810c069a20@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 9:29 AM, David Lechner wrote:
> On 9/2/25 8:15 AM, Marilene Andrade Garcia wrote:
>> Add device-tree documentation for MAX14001/MAX14002 ADCs.
>> The MAX14001/MAX14002 are isolated, single-channel analog-to-digital
>> converters with programmable voltage comparators and inrush current
>> control optimized for configurable binary input applications.
> 
> When there are multiple devices, DT maintainers like to know
> what is the difference between the devices.
> 
>>
>> Co-developed-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
>> Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
>> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> 
> Sine the patch is From: M.A.G., according to [1], this should be:
> 
> Co-developed-by: K.S.P.
> Signed-off-by: K.S.P.
> Signed-off-by: M.A.G.
> 
> (hopefully obvious, but don't use the abbreviations - I just did
> that for brevity)
> 
> [1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
> 
>> ---
>>  .../bindings/iio/adc/adi,max14001.yaml        | 79 +++++++++++++++++++
>>  MAINTAINERS                                   |  8 ++
>>  2 files changed, 87 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
>> new file mode 100644
>> index 000000000000..ff9a41f04300
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
>> @@ -0,0 +1,79 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +# Copyright 2023-2025 Analog Devices Inc.
>> +# Copyright 2023 Kim Seer Paller
>> +# Copyright 2025 Marilene Andrade Garcia
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/adi,max14001.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Analog Devices MAX14001-MAX14002 ADC
>> +
>> +maintainers:
>> +  - Kim Seer Paller <kimseer.paller@analog.com>
>> +  - Marilene Andrade Garcia <marilene.agarcia@gmail.com>
>> +
>> +description: |
>> +    Single channel 10 bit ADC with SPI interface.
>> +    Datasheet can be found here
>> +      https://www.analog.com/media/en/technical-documentation/data-sheets/MAX14001-MAX14002.pdf
>> +
>> +$ref: /schemas/spi/spi-peripheral-props.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - adi,max14001
>> +      - adi,max14002

It looks like we could have a fallback here since it looks like
the only difference between the chips is:

	The inrush trigger threshold, current magnitude, and
	current duration are all programmable in the MAX14001
	but are fixed in the MAX14002.

Which would look like this:

    compatible:
      oneOf:
        - const: adi,max14002
        - items:
            - const: adi,max14001
            - const: adi,max14002

And

	compatible = "adi,max14001", "adi,max14002";

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  spi-max-frequency:
>> +    maximum: 5000000

After reading the driver, I see that we should also have:

	spi-lsb-first: true

as a required property.


