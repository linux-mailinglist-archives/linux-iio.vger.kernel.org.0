Return-Path: <linux-iio+bounces-21911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEE8B0F67D
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 17:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F0D17188B
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 15:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2442FD5BF;
	Wed, 23 Jul 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rg5kZct2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A980303DF5
	for <linux-iio@vger.kernel.org>; Wed, 23 Jul 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282740; cv=none; b=YX8BO7VISFkU6GlGs6u7360mBKlMypsXVP7KyTePwbumFWSJBDQIWc8hpMVQ5mbFweI72LFSLDoLY1bgNuj/rMdrVCENoahxR7ZqITln1nJgGzsajTOtPdpBnh0KBBLqhYU4MQn0Fcmc2qx2cZxV6xPDR6IIpKjSTQmQTw+PlWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282740; c=relaxed/simple;
	bh=d+UQZjK5JPWU+nmjBIoeo+ZaTGTNrbCSc9T8Qxpg2Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uv2T62Ml4YERjDIBvIlSRoT9NemX83RWPHUObJRLIYM2otpqqXvULmewksFx3BKjW8XJzAK6KBJx6TIDEToiXBpjBe9uxtaeZ4oRWrdRakfZEv8kofMd6HyciNHRAAF1l/Xqr1kdOW+1Ylu4XCIUWeWd/XxDBqfbvj0ui1wr71k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rg5kZct2; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-306ab3a49d6so22027fac.0
        for <linux-iio@vger.kernel.org>; Wed, 23 Jul 2025 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753282682; x=1753887482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WVCdxymO/cmG+R3Cl+GAt8R7HfnzufTS+mvJs9mpxm4=;
        b=rg5kZct2ZJ4gB9FDA8iGN3hglKogQ8YdjHOAvoLpSQks8tCN29/BZ+UplTU/7Wt14W
         W+mM50sLsMHZ+zMbo8OD0kmfAbSwbeiOCZGJ0xNweYPNeziMz+eT5hG9sxf0D3nL14Rd
         wrpEGaFcFWrAmRHdkgRWdXoIA3oRPAS/phYKEYiYaKDMTEOx3IGE0hCJ1+F+VHU1SLr2
         7XhD/vF1+kcGPG7nME2UH4hZTkDzkTg0mbTJK9rfNvTnkql74+zBaa9AjlUSvv+y/1SG
         miw/YVWwX3MZPYuxckKv/p7zGauDUs4cyJ1foN0C9gw//jH2gKwoK4bnmEZtxS937mfF
         lNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282682; x=1753887482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVCdxymO/cmG+R3Cl+GAt8R7HfnzufTS+mvJs9mpxm4=;
        b=V6U2hJDE/FNBbHjrKU9fAQyZRQSjcVZJVG03npKc2Y4QSIcfyefwC8f58Qd/wMZRud
         8F5HQT4t150HlFa4jpfNN59jJnPoWueShfHFC9IrOQlC3bCIUkNb7tG7L4YM0z93aTIT
         UnMwEcOa7XrFDESfOOhrxNEvo6CcvMPcRYzIHKZ+ry2SLvZrjyeIYqkB1BQ0XM7SvNyO
         7WT42GGRBJf6705PQlIviMHMJDKSv1/KHb/Y+oXhjQaMpSYYxZKoTyof54LSUV9lZEtf
         yKpxCRXCS29PLk+KhX1vYzYN6hzxKjY8LTRg4GvXugfR4orQQIJZDNOu4RhDndv3L71i
         Tx3A==
X-Forwarded-Encrypted: i=1; AJvYcCV7ZZ8EobD/3fDKoWSNirlX0wtIYOMIAaPx5e1EgvFIv6KLncaPsHuwHoAfu4qU3ipa3XyMr/Mvkwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU1JHjrujRnEp6qF2q00393Z3Vb9CqP0UMhmwdDUEYWlkq9mIH
	vlJLOqioTzLqDsfd5Iv3KiotWh/h4yxgqPEk5hC160mFa2KOuiqvebBnoBbIko9aFBk=
X-Gm-Gg: ASbGncuKZM7KTPX3TqSbpLlpDP+tDcETy98ZPf2uDp8qhqmO2+7dOafxKaKookSZLHB
	G+E1HZZ/38tpRZaV7Oa8143yAdbQLrNsRCZmKtKBCUEgFkhtRl9/VIpkj/7ezRRoPd3KUaHT9Tb
	M5P1l85SGLq1r3v3ioPxDUoeVB8APbUyonLPeorpalnIJ28kC/iznG9ZayafEkWHfJosjiIXXHW
	mwkD3eVTIvTGVx/u0LbRo2gmXPNMXvkDGnxw6gpdpkyetkRl0EnWomDGV1MOhEHlYwmdr4nfU2P
	t9gxnwK8nvOlP73wSS+ImZ9U8NyLelB+0LSC3BC5Ya6dSEq7X0voemSMW749+KEszRzV/inES5E
	omY7GvoisZA/qZIoRNTZZAUknbN29+LG0IZzFflH4YZSbVFZNm97JHppjvF48LftmXef2o8qC
X-Google-Smtp-Source: AGHT+IG7Sbzk+8GL3JgHROlhT8umJ/hShPtTr3mIYZViugHomJxFaWDCU0Uv14TXX3SljkAxgtjCfg==
X-Received: by 2002:a05:6870:1582:b0:2e9:9118:9ed1 with SMTP id 586e51a60fabf-306c6f6e8e0mr2020953fac.3.1753282681800;
        Wed, 23 Jul 2025 07:58:01 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:11dd:c0f5:968d:e96? ([2600:8803:e7e4:1d00:11dd:c0f5:968d:e96])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-615bcab4e9esm2369733eaf.12.2025.07.23.07.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 07:58:00 -0700 (PDT)
Message-ID: <7ca7e0b9-a77d-4de8-92b1-fea3250e8155@baylibre.com>
Date: Wed, 23 Jul 2025 09:57:58 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: hx9023s: fix scan_type endianness
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Yasin Lee <yasin.lee.x@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250722-iio-proximity-hx9023c-fix-scan_type-endianness-v1-1-48f5dc156895@baylibre.com>
 <823a28d6-e612-4e32-976a-cb99945848ce@baylibre.com>
 <aIDuEcHhaGtz2klP@smile.fi.intel.com>
 <795dffe0-51cf-49a8-bbb1-1585edddf5ba@baylibre.com>
 <aIDzvNYIaJnSuzOa@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aIDzvNYIaJnSuzOa@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/25 9:37 AM, Andy Shevchenko wrote:
> On Wed, Jul 23, 2025 at 09:29:37AM -0500, David Lechner wrote:
>> On 7/23/25 9:13 AM, Andy Shevchenko wrote:
>>> On Tue, Jul 22, 2025 at 06:08:37PM -0500, David Lechner wrote:
>>>> On 7/22/25 6:07 PM, David Lechner wrote:
>>>>> Change the scan_type endianness from IIO_BE to IIO_LE. This matches
>>>>> the call to cpu_to_le16() in hx9023s_trigger_handler() that formats
>>>>> the data before pushing it to the IIO buffer.
>>>
>>>> It is odd to have data already in CPU-endian and convert it to LE
>>>> before pushing to buffers. So I'm a bit tempted to do this instead
>>>> since it probably isn't likely anyone is using this on a big-endian
>>>> system:
>>>
>>> I can say that first of all, we need to consult with the datasheet for the
>>> actual HW endianess. And second, I do not believe that CPU endianess may be
>>> used, 
>>
>> Why not? Lot's of IIO drivers use IIO_CPU in their scan buffers.
>>
>>> I can't imagine when this (discrete?) component can be integrated in such
>>> a way. That said, I think your second approach even worse.
>>
>> hx9023s_sample() is calling get_unaligned_le16() on all of the data
>> read over the bus, so in the driver, all data is stored CPU-endian
>> already rather than passing actual raw bus data to the buffer.
> 
> I see, now it makes a lot of sense. Thanks for clarifying this to me.
> 
>> So it seems a waste of CPU cycles to convert it back to little-endian
>> to push to the buffer only for consumers to have to convert it back
>> to CPU-endian again. But since most systems are little-endian already
>> this doesn't really matter since no actual conversion is done in this
>> case.
> 
> Right, but it's buggy on BE, isn't it?
> 

Right now, the driver is buggy everywhere. The scan info says that the
scan data is BE, but in reality, it is LE (no matter the CPU-endianness).

With the simple patch, it fixes the scan info to reflect reality that
the data is LE in the buffer. This works on BE systems. They just have
an extra conversion from BE to LE in the kernel when pushing to the
buffer and userspace would have to convert back to BE to do math on it.

With the alternate patch you didn't like, the forced conversion to LE
when pushing to buffers is dropped, so nothing would change on LE
systems but BE systems wouldn't have the extra order swapping.



