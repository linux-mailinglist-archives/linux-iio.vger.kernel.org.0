Return-Path: <linux-iio+bounces-14023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA5BA06287
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 17:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF801882706
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 16:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AC01FF7B7;
	Wed,  8 Jan 2025 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d9ABVYhL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E4D1FECD0
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354905; cv=none; b=Nrpo2nBfiKAPaJW6jP0V7dpsbRHx7oQ4OjuKjeSeRaGQOS7gwuwnpTQrurm3Qz0pGW2SPAU/s2PjcGtA5gSQfAFxh1B0W3RTGQkbuYPke8ee26OGdatlYXtf/HIOI/epH0uld9QZcDs91V2PND0b83LbJfiwz8nE0oh633i2W44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354905; c=relaxed/simple;
	bh=XPKx6pwqHeZAfQbv4Dj1kdEFP8M1og0QDIj1AX/CnW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ao4K+6VMc9dF1ituAU8CWIY8ttjSJdFtRGHftO6mJglkNsczT++hUt5DRLKgRPfpdB2RD5yUXM6Npt0ONqB4QadLkNw/DZjoQmvPHFi7axnp2e/aaWgw6tDvrjUhmS6LjgPZXhA4OFZBK2EpKxVbzW5wgr/8AJpsWyjLjShG/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d9ABVYhL; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71e16519031so556105a34.1
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 08:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736354902; x=1736959702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I9d73tRObAGN5BNE9biuTjeLMSgHxGDZ3+RKn5a9A0M=;
        b=d9ABVYhLbbQtzNXIaPeZ5HYaNPOIotU+JFg69ENsbXAh13m3JHW8XNNW+iLuku4+qd
         aYfjterm+NYT9Qt9vGw8Eri8ClaXFp8xAhgdjA4evr0evhUTDnJdlEH/rtJ/R0dfrLQ2
         euw5l0uXEU6cyTP8ht2Y/T/evdqrp65kEyw9DYw5WCQDkcGb5pIoS7Kwhv3NOfDyzIme
         yquVYKjVkKa6Zau50dmE7fzU7KWIpjr8WFdksIJIqv8ueIwcvzcr1mAbo7R7STGC5ACu
         3BvfHZDqSwZrSaIrZCTJupAI5LBEm2CA65lK/J/1t2bAatKr3CpgRTuNGjl7IGKmqcaC
         OQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736354902; x=1736959702;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9d73tRObAGN5BNE9biuTjeLMSgHxGDZ3+RKn5a9A0M=;
        b=K5kkiVqJsTLSy2dthyL8mnezTncE1fJS9wnQYfsU3sqyRZb4dU/NTG7+qd1lDaCH48
         dGr6KdC9K+G3/7ZCIXVSSGHVB4KyPGISHW2ghKMooIoOSJl0OYeKx3uPazZoHwYZ+fHs
         vENPCVCrIK9sFny9dR/W1LqV4OWYKpEG0bJigHPL7mEES8lI19F+2Fz2wO+STP0zbe07
         CLBbepx50d0G3MPSHaQhqBDilpNK5drhEVnINSlkJQPRWsbW2TSK0tigkVxGAuNAZTt9
         5G57ijs7rvpcQPoW9YnH2pdWvnhHtHMYFT6f9HysLxUivwhNl0qRasl/n+QNMNYjF/Vu
         QJOw==
X-Forwarded-Encrypted: i=1; AJvYcCX10xzcOUpwz0Ibpz1bFi9+cWe7Sx7504pEiweonSnYipP58dzn5nfq8OSRUrVDN7isatPEhCf29lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgiDVRq3NEDQ2kE8vW71eKSYRNSyX/fLzy8StYeJcrRNSzDdrA
	zlqdGlpXyFZsbHQ5bKGwC0FHomuphDAQd3qJLOqOaVKHtQ335fgPDC0hlGZA2X79SXgnePx8fq9
	H
X-Gm-Gg: ASbGncvnkspMCHNuRcy61CNrm3jG0eHrAtrI5G/GQkDSAZdxSRhmnMYor0P3EVrWmQl
	TB8rFAq4T27RNk5KY9Fmt0nn1hwK+zsgPeLOfRWJE0gbFbZn8HJBZK41Mmm33SLNMbCnN57ZQeJ
	IQ3fWILgpv2mQB0g3272aFQRzFGWOOZIfkkSdJ6fTFtft88yoclhtFWV4dNv831XMbp7dRYqUch
	9PNn6TPBB7u9PtiGStQ4XOBRZc7IY4LxstmMepuHxRxSooa3ByNiOpmAcSY4MMPAx4YWcqItfW4
	9Quqg/tO7oxEuKwqcQ==
X-Google-Smtp-Source: AGHT+IHQCHpXwWe2WUYcdoU/HlAsqT58kq3vmmB7qJG8C07naoC9qJvmIA8o/WlVXQK90bBqeIVaow==
X-Received: by 2002:a05:6830:1b70:b0:71d:51a4:ed48 with SMTP id 46e09a7af769-721d569f12bmr3665511a34.8.1736354901977;
        Wed, 08 Jan 2025 08:48:21 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc99d0b90sm11309518a34.63.2025.01.08.08.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 08:48:20 -0800 (PST)
Message-ID: <e1e38f64-4cf4-4f12-bf9d-e7520d4e5721@baylibre.com>
Date: Wed, 8 Jan 2025 10:48:18 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 7/8] dt-bindings: iio: adc: add ad4851
To: Jonathan Cameron <jic23@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <20241220120134.42760-1-antoniu.miclaus@analog.com>
 <20241220120134.42760-7-antoniu.miclaus@analog.com>
 <20241223114008.71e00bee@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20241223114008.71e00bee@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/24 5:40 AM, Jonathan Cameron wrote:
> On Fri, 20 Dec 2024 14:01:33 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> 
>> Add devicetree bindings for ad485x family.
>>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Mixed single end and differential channel devices that have per channel
> child nodes need a more complex description to avoid reg have different
> and possibly clashing meanings for the two types of channel.
> 
> See inline.
> 

...

>> +patternProperties:
>> +  "^channel(@[0-7])?$":
>> +    $ref: adc.yaml
>> +    type: object
>> +    description: Represents the channels which are connected to the ADC.
>> +
>> +    properties:
>> +      reg:
>> +        description: The channel number in single-ended mode.
> 
> And what is it in differential mode?  (usually just an index).
> Which is a problem if you have a mix.  That's why we added
> single-channel.

This chip isn't a mix-and match like many chips with muxes that use this binding
so I think it should just be diff-channels = <0 0>; similar to adi,ad7606. The
pins on the chip are labeled IN0+ and IN0- so it makes sense that both the
positive and negative inputs to be 0.

So, this should be fine with or without a single-channel property since reg
should always have the same number as diff-channels and single-channel.

> 
> So for devices where reg isn't enough, you can use:
> reg: index of channel, not real meaning just makes them unique.
> single-channel: The channel number for single ended.
> diff-channels: The channel numbers for differential channels.
> 
>> +        minimum: 0
>> +        maximum: 7
>> +
>> +      diff-channels: true
> 
> Should be constraints / information on the values possible.
> I've no idea what the 8 is in your example for instance.
> 

