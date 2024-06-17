Return-Path: <linux-iio+bounces-6411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E89C90BA22
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 20:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE5E283006
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 18:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB1B198A2F;
	Mon, 17 Jun 2024 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7JQ83Cd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5057B17E900;
	Mon, 17 Jun 2024 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650380; cv=none; b=Q5yLoAzzkEsusKV16gE/cZ0Yl4l9OnMjX14iaQa7aKGoamSm7/R5yuffy+TS0oXrbxnA6ADWMTWwgJfgVLWtJ+GdtV5DOjXVfNie43xp+TtM5o9HRsV68MZGRH1/Bw73PpVay9HkJagPtwCsU8i1UxihezXOFriWNpM0sqz5LFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650380; c=relaxed/simple;
	bh=BF7uZaD7lnxQyh3lTTyTsD3+XLVYTQ9pmJnwOpGPQ8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EO+hppNHo861hG5UNg2jb1BK85PemIL+vp4oc96mcr3UD8vnc+51z8KoRy2npHAERin6NtwzRDS8qTQXSXoQXfOnFRBKgDjFE2OjXXZHmKcLHk1j9kiyEqbmXN09RdWCkXWZ/4XMEHaoXoPaz1qYBtONbYYCNUTQTDyQHd0ilCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7JQ83Cd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4210aa00c94so39137275e9.1;
        Mon, 17 Jun 2024 11:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718650378; x=1719255178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fWjJjq4VyTBxkY0C45AnzzK9M0qUU4Vb28GUzKrZrOA=;
        b=d7JQ83Cd6V7hafzuV2kuB7Qx6tZN/rM96Vv7M0LlczqKYSusiyx82AUzp0n1F+81Kz
         yUzxyjBWcWCFVy9/xIRRgHg99n3D8xwU3X/rD9uwQHb8k3gIfE+FX5+ULkeYq3Nwu7pj
         Ut7UK2ZJbq1EIBg0t1h8Gizn63owp1zIwHK57L21ODCUJ6zaZMLg2DpCkluGYtroChrR
         rReUwGN2grRAD0vpt7uE/aGmdwwzQ4G4GPkR+Dnxqvos0R8X5gia9Rnz8JDsqD29aLbO
         WLJSwM6RTiBIH4nRCvzwCT35YBsNeNysk2ZTaExasSdXbaMwUOQ+UVDd0XT9d6J8jMiE
         0DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718650378; x=1719255178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWjJjq4VyTBxkY0C45AnzzK9M0qUU4Vb28GUzKrZrOA=;
        b=p+ZzP1Up4s1a5euAnjKwPrejjy6iaQ3A2/h4BW4CC8sWiuzP9WddcRXGmcXIbdXEiH
         vqzCD9jh+NnTEEwsrBnxOotJn1CrixRC1vRqHghBEA+9EQzxFc27NzI+aJQQQ3JnhL0j
         kk7WmJF04fRdwuhLmrUW3vDB/HlqiIQZMcCbXZk93zxTXLUeBO8baq8DQkEGBUbvWbh0
         tC38zF7jiXlPQMxP3mpRNMhMteRnnykKQxZ8m47nrUfFJd0qiwbBRJ3g4nUSSomRe3hF
         G8jEXp5PhCKUm05S9GtO9dM3qHSiQomkET2GGsmCpISHlKjxShAKP+ii494htDcZTBjY
         gmhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVTk6zjL0Jo+WjWDL8xlwcrDzhKsfNniSftnW+ivYlEycZNfEtYcnywLdNzBLOSqtAxo5Jmlzfkp1dggx1jrQR3iTwtC0823KEuDwf9dfZ5NITKt/hPhjL9mNWmWr8GTyIVcyR/tC8itk+x0yHZuZm7JBixmaMuCiXv5C8kfd3wT+L7w==
X-Gm-Message-State: AOJu0YwT9/T5DS9xfH9FBGX2vbqdKhfSEJ3pVUN/LnXp8NncK9uZoCVI
	8agH2HEuHBmrLGSHSbnpSoQt3yebWmeIZgxyn2Ez7RpkuBYWz38/yMMSxdXyUrs=
X-Google-Smtp-Source: AGHT+IEBX8FFSyOXx4+xGG3tRDdpRsim+ngLzm0BcsFL0VXYQ8+dulSMhJRQsFQ8jsYTKklolvx5vA==
X-Received: by 2002:a05:600c:5492:b0:421:d8d4:75e3 with SMTP id 5b1f17b1804b1-4230485bac2mr69041565e9.40.1718650377596;
        Mon, 17 Jun 2024 11:52:57 -0700 (PDT)
Received: from ?IPV6:2a10:d582:37c5:0:ed15:7e1f:11e6:9a9a? ([2a10:d582:37c5:0:ed15:7e1f:11e6:9a9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093d58sm12439436f8f.4.2024.06.17.11.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 11:52:57 -0700 (PDT)
Message-ID: <67dca4c3-bb86-4cd4-b80b-733ba93547b9@gmail.com>
Date: Mon, 17 Jun 2024 19:52:55 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: light: ROHM BH1745 colour sensor
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, ivan.orlov0322@gmail.com, javier.carrasco.cruz@gmail.com,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240606162948.83903-1-muditsharma.info@gmail.com>
 <20240606162948.83903-2-muditsharma.info@gmail.com>
 <20240608172227.17996c75@jic23-huawei>
 <CANhJrGM9czj0RL3OLCgRHEKc2QOjG9P0AZTrZxvYUk65TCpHRg@mail.gmail.com>
Content-Language: en-US
From: Mudit Sharma <muditsharma.info@gmail.com>
In-Reply-To: <CANhJrGM9czj0RL3OLCgRHEKc2QOjG9P0AZTrZxvYUk65TCpHRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/06/2024 06:58, Matti Vaittinen wrote:
> la 8. kesäk. 2024 klo 19.22 Jonathan Cameron (jic23@kernel.org) kirjoitti:
>>
>> On Thu,  6 Jun 2024 17:29:42 +0100
>> Mudit Sharma <muditsharma.info@gmail.com> wrote:
>>
>>> Add support for BH1745, which is an I2C colour sensor with red, green,
>>> blue and clear channels. It has a programmable active low interrupt
>>> pin. Interrupt occurs when the signal from the selected interrupt
>>> source channel crosses set interrupt threshold high or low level.
>>>
>>> This driver includes device attributes to configure the following:
>>> - Interrupt pin latch: The interrupt pin can be configured to
>>>    be latched (until interrupt register (0x60) is read or initialized)
>>>    or update after each measurement.
>>> - Interrupt source: The colour channel that will cause the interrupt
>>>    when channel will cross the set threshold high or low level.
>>>
>>> This driver also includes device attributes to present valid
>>> configuration options/values for:
>>> - Integration time
>>> - Interrupt colour source
>>> - Hardware gain
>>>
> 
>>> +
>>> +#define BH1745_CHANNEL(_colour, _si, _addr)                                   \
>>> +     {                                                                     \
>>> +             .type = IIO_INTENSITY, .modified = 1,                         \
>>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                 \
>>> +             .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN) | \
>>
>> Provide _SCALE instead of HARDWAREGAIN
>> As it's an intensity channel (and units are tricky for color sensors given
>> frequency dependence etc) all you need to do is ensure that if you halve
>> the _scale and measure the same light source, the computed
>> _RAW * _SCALE value remains constant.
> 
> ...Which is likely to cause also the integration time setting to
> impact the SCALE.
> 
> You may or may not want to see the GTS-helpers
> (drivers/iio/industrialio-gts-helper.c) - which have their own tricky
> corners. I think Jonathan once suggested to me to keep the

Hi Matti,

Thank you for the recommendation here.

Looking into GTS-helper for v5.

Best regards,
Mudit Sharma

