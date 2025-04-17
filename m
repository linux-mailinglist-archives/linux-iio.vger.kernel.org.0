Return-Path: <linux-iio+bounces-18216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F899A9236B
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 19:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC53188F8DB
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D91D254840;
	Thu, 17 Apr 2025 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gj2Y7Uk3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6EA17A30E
	for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909664; cv=none; b=K/q6dv/0Kfh4MtO49eOACK2fAA4xsRDuTOY6mKHJu0MrDZ19Ij96Vv9/6627vLnKfEymvyYokOmv/eVsYquV1q3JZokvwUYKavZLEH+Lmz26uJjsqHIAUm16CFDx3Glc8XZ9sD85SzjOjySYycgSVFCaDQsyBj6NXaQwpqoJHk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909664; c=relaxed/simple;
	bh=QTblW1Gq1v1BLqv3bQj+TbvXE9AnXYXO/4GsN9Rn0IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEBvMbjawH++LEiPwFdNnpbOlvSB5ADpj06by2gktdq2lKXHbFhbrzJgQ7h33lqkGK2fRjoNm9wr1by2q2C73P8UFxFfvDqBIyDif+dZIRC5iwm9CrUkaiS62qCNHT9BMLLFR4n72ZmI/0bXCAVbLDQ+4dSaASRmneGhIxFwWbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gj2Y7Uk3; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-603fd257386so240546eaf.1
        for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744909661; x=1745514461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJO4GXL7dOZjeP6V87YS4vJmfeGtcMABTZh3kn2uUsg=;
        b=gj2Y7Uk3x7EwWduQIwOzFt/vbkv10ZETT3diWxK7T+pg6s0cH1SuAi8Kp7ogVNv7yc
         BsRTTarBzuZTV/LptAzJFdiijtjFXpSCDzqcNo1GhAv4KxXpOefZ/f5y6Tu77eOvA/D8
         qrKxGHLHi1ASoy1QgFfO85dxNy0BlhF7UftWrI4SwNF1LealvCd/BY5Urzj5GiImhOtS
         v6/16RF0/auEVRUgQzpiff5I1Wux1o3kZcZbK1cASxkQXsuQSb5l7iBdVSfGQsERKaui
         0QOegz2jgzA/cdplbOewf2kG7dN5X/iweAZNmRPXnomR74HLBr3AZvTxc61OVBDE1BAr
         yXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744909661; x=1745514461;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJO4GXL7dOZjeP6V87YS4vJmfeGtcMABTZh3kn2uUsg=;
        b=mBAzQTIYbwoW7jkhHG2reLLbMobE3Or3XSmNZF3Rb3vQR7/h4O2mqaDSq1Qgd3J9kG
         /Rq+cEKEKiiOPwqn+xIZgEs87omyoatpbOYdQ6Uxl8x0DQ+prvXs/C+06vzk18Mwh1Rc
         X3aUDIhrG6K3uoEUMhayKjbCszYF9oLK5d+Pcvwj3W/VGI4kRhauQmUAb2+WeNb0yob3
         zSPIVYWlIW0FZiK40vncDCs16LBz/S2uKontjc1QxT9zEShfGzIPut2MOK+jo+avNvnw
         tKd1pXzuUeLLcximMR8/jZ7yb0299Hym3cLx1WNT6HIHEbpt3c1E1VFDyVHrv/8Qx9br
         fFvw==
X-Forwarded-Encrypted: i=1; AJvYcCWfnICBR1xjBsvlx1RHCHOP5UbkwDSW1g2BARBiBJzyQmz2/dK2BA/ntkwSWPYOu1P4SSFSyQDdCK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIF9k5JpMZXdIJXIC9pXQnOokEfjNNfKzxRmKE6jnwTOiHZCDh
	pjoXT/IOlZitekmmYmabu7qJJfcrOiyXOEfFcWXaULP5wxlV1SOVF91Z2kiyhyM=
X-Gm-Gg: ASbGncs7jlgqk+49FU4NMj4mppTQ36HWEvC+zUQGg3Uz8NzdanZ+pRvXj716l8a0Snk
	CwvGFsuKnfbMqDMXWO++a1/GocO5ubZsgUb35MBXgHNzYVNc2NdlIF3yGXd1Mzb/b+yR8FhAtUG
	33Vlo56oveTlGqKjTG4tD1jsRyPm9mCuRJFeA+AqWgIy2uA8C1u48DsdGCR++bckj6kB/fdmAP4
	Hadk4bUhXQUf1QG2FrYHY/V8kmvzWwIcnDgFDfnNuJ38bYYSv7IQodElY0726Kz1GwfTyb/k3Bz
	E/pd9jj+loo/GC6bgDQ9V0vcjC76wPYutldD/NEN9RQtGkEFjcQNKp84hsMi6xBxngJGHw9FtM+
	3cyOaE5YUuYKlkW+WCg==
X-Google-Smtp-Source: AGHT+IHbLABiWinLwjfZ0DTmEnAkfAixBYu8A7EcycIAgYoLkSVTlOq/Pw+F15KcRSPJ7k1qWk67rg==
X-Received: by 2002:a05:6820:180c:b0:603:fada:ac47 with SMTP id 006d021491bc7-604a91e814cmr3847196eaf.1.1744909661228;
        Thu, 17 Apr 2025 10:07:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee? ([2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-605ff5d8c40sm33099eaf.3.2025.04.17.10.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 10:07:39 -0700 (PDT)
Message-ID: <f4db1a95-106f-4fa4-9318-3ee172e29cdb@baylibre.com>
Date: Thu, 17 Apr 2025 12:07:37 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] iio: imu: adis16550: align buffers for timestamp
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Tomasz Duszynski <tduszyns@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Andreas Klinger <ak@it-klinger.de>, Petre Rodan
 <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
 <20250417-iio-more-timestamp-alignment-v1-6-eafac1e22318@baylibre.com>
 <aAEzeY_p6a8Pr-zn@smile.fi.intel.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <aAEzeY_p6a8Pr-zn@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 11:59 AM, Andy Shevchenko wrote:
> On Thu, Apr 17, 2025 at 11:52:38AM -0500, David Lechner wrote:
>> Align the buffers used with iio_push_to_buffers_with_timestamp() to
>> ensure the s64 timestamp is aligned to 8 bytes.
>>
>>  drivers/iio/accel/bmc150-accel.h | 2 +-
>>  drivers/iio/imu/adis16550.c      | 2 +-
> 
> Looks like a stray squash of the two independent commits.

Oops, sure enough.

> 
> ...
> 
>>  	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
>>  	struct mutex mutex;
>>  	u8 fifo_mode, watermark;
>> -	s16 buffer[8];
>> +	s16 buffer[8] __aligned(8);
> 
> As for the code, would it be possible to convert to actually use a sturcture
> rather than an array?

I do personally prefer the struct pattern, but there are very many other drivers
using this buffer pattern that I was not tempted to try to start converting them.

> 
> ...
> 
>>  	struct iio_poll_func *pf = p;
>> -	__be32 data[ADIS16550_MAX_SCAN_DATA];
>> +	__be32 data[ADIS16550_MAX_SCAN_DATA] __aligned(8);
>>  	struct iio_dev *indio_dev = pf->indio_dev;
>>  	struct adis16550 *st = iio_priv(indio_dev);
> 
> Ditto.
> 


