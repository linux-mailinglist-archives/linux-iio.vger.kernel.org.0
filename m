Return-Path: <linux-iio+bounces-15058-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6D3A29DA1
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 00:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7D61880A4B
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 23:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F542144A7;
	Wed,  5 Feb 2025 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g6kMqjph"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6B41519AC
	for <linux-iio@vger.kernel.org>; Wed,  5 Feb 2025 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738799010; cv=none; b=IZuLiS6Zjjqb580DbZ1Os1icJI+YmnqmqB3xudbV7LVko/gEqOGIx9l3r8KqN3nnKMytaBP76yZtdZHRczTXPps+Mmz6gwZIAYthnqRVnpzyVY9PxHu8a7T8j6tITaIf/6WGhZyd03pOXayxb2OYnSwSI1BPf2BxUmwMzwMG864=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738799010; c=relaxed/simple;
	bh=vp3lbtqZcqp1zSJExGkSG6HzS/YzFvUsp2hEIj/1ONk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBG0ucA4E/ga48ZUwzEipiDyx572s9jEEa57HPZ8YXa5D4DwDIosCKLN1RROKcsoU9Bqivyi0mC8uQM5bYaWBMYUv3eKQR8Lj2dIoFTbv2zE+nuHV9SvB9v7d4MAtUD49O+EtgyBdiR0soUZvKVADSNL/3VDYO7Kik4eKAWs/tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g6kMqjph; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5fc0b7a4e5dso161941eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2025 15:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738799006; x=1739403806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j71E61GLdY8oYFdx9LgxiwKYVsSdxfJXOVmiLeUcty8=;
        b=g6kMqjphqytyMW7GYxS2EQlpCET51zW1gR++QNR+QGC6CyZVVVToTrdqh4SxBDSjIU
         tu3lWZOc7tkdL2vCwBIDipmrxp6xG5CScwCuli5IqofsUwQaxsLP6UHDiZrdM1CluJqz
         T+c5bAP1TA2hs9PvmzlkWfWmnHaCmdnVeGXtsIb5MP2qujKwfBjF27C1NjR72XTM3O0E
         80OupdCz+wOuPPEdGaS+8oR3NEjrcsF138Y4WVqYBQHTeA0/5Kn9nKlpUl5So92WazI/
         wgFOVWHzleMycXmQJzDew8EAlrPOh7R9zD4Q4bWdB+iY9+TQRbKveBhfeC9Whxid9zOp
         QZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738799006; x=1739403806;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j71E61GLdY8oYFdx9LgxiwKYVsSdxfJXOVmiLeUcty8=;
        b=jTgDZVbjH0NmxEvsojMi8aMAhkTzVZXnRdf2Apit0HTYjCV7MK9lCUXNxHDtTxRVa8
         eVRBkAMMhlP5jSicgOaHC1nuDq5dU+Qq3DYJ4sFjNttyq4RRWSHkcoqTFOIhyIjmwMYc
         BFixBQTpuVNj+leQ59uBJAnh/ZOvk1DHGb7cdcWg/ovl6y8i5lfqcvkns/wGiFMwf11/
         QB1+0x55dGTE185O3MTRCnwvXtebdsuuzDSF8dNtZjip6NSnmdWTs7JGyei6ZTZ+1wIB
         da8Pe14tojOEs/tySGMDhI/kL8oKiLeSNR2Y2ynPuD2PCLftVh6IsgGIfXvsr+F3VqWX
         lrPw==
X-Forwarded-Encrypted: i=1; AJvYcCVSOtf9MetGmjlyBQHdmRsueiV5aerGEe4FiALacvxiin3hJoGfMvZupHjmjjrIb+A6eO6X1tZSFRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3xVbaU8+6cqsRE2i7CGjza0dB1Er+roj0QXGMY0BNkaDXX3l8
	i45bCRF29cX775SrtVpadiW/HLUw04NPHOrSHUmKGBZurcHv9PIJP7XjMA+6LYM=
X-Gm-Gg: ASbGnct/DVTwRs+YYrZzSTGMrUz/+mScwggTd+EWdXu/kUrCbsZhIzjbnQMEOlsaF4b
	gLdq7FmOMAs1E6/3avr0aaTYKVHfjq9M6YqTNgMacgjxF2xbtZLA/FwGzFkooWhcjhQc35cZqTC
	v21luR5gPTkkQtwmrPM+4iCJY6e+MNav5n77RMAO2xnk3BgUcaNYAhnW7d91XVXpmYyzx7Y+R2Z
	8RMHYg63JyWT6rloJt48yYbYGCFgpXiDZVx9wZiITvUdsa+DHx5jMgAMfRVsZVSYMKC2YFCmAnu
	84217hqEicQJJZb1+SRDXP1nxZjZdXKD3Jm6/j1xTfz/fDGqE3YS
X-Google-Smtp-Source: AGHT+IGhKH4F198jKswHkOTneMJLSjT4gkjZHcSvZQZ9tmW/LEHzImr/rgy9+TFOartEJKeJxxTuRA==
X-Received: by 2002:a4a:ee82:0:b0:5f6:2e4a:82e1 with SMTP id 006d021491bc7-5fc479cf102mr3683442eaf.6.1738799006387;
        Wed, 05 Feb 2025 15:43:26 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc1059ac27sm4102290eaf.26.2025.02.05.15.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 15:43:25 -0800 (PST)
Message-ID: <3bfec7ad-1795-41ea-b0fd-72acc1f519c6@baylibre.com>
Date: Wed, 5 Feb 2025 17:43:23 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] iio: improve handling of direct mode claim and
 release
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 ChiYuan Huang <cy_huang@richtek.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Guillaume Stols
 <gstols@baylibre.com>, Cosmin Tanislav <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>,
 Antoni Pokusinski <apokusinski01@gmail.com>,
 Tomasz Duszynski <tomasz.duszynski@octakon.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250204200250.636721-1-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250204200250.636721-1-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 2:02 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This is the first of perhaps 4 related series, broken up mostly to keep
> them bite sized enough for people to review.

10 patches would be more bite-sized for me. :-)

> Jonathan Cameron (27):
>   iio: core: Rework claim and release of direct mode to work with
>     sparse.
>   iio: chemical: scd30: Use guard(mutex) to allow early returns
>   iio: chemical: scd30: Switch to sparse friendly claim/release_direct()
>   iio: temperature: tmp006: Stop using iio_device_claim_direct_scoped()
>   iio: proximity: sx9310: Stop using iio_device_claim_direct_scoped()
>   iio: proximity: sx9324: Stop using iio_device_claim_direct_scoped()
>   iio: proximity: sx9360: Stop using iio_device_claim_direct_scoped()
>   iio: accel: adxl367: Stop using iio_device_claim_direct_scoped()
>   iio: adc: ad4000: Stop using iio_device_claim_direct_scoped()
>   iio: adc: ad4130: Stop using iio_device_claim_direct_scoped()
>   iio: adc: ad4695: Stop using iio_device_claim_direct_scoped()
>   iio: adc: ad7606: Stop using iio_device_claim_direct_scoped()
>   iio: adc: ad7625: Stop using iio_device_claim_direct_scoped()
>   iio: adc: ad7779: Stop using iio_device_claim_direct_scoped()
>   iio: adc: ad9467: Stop using iio_device_claim_direct_scoped()
>   iio: adc: max1363: Stop using iio_device_claim_direct_scoped()
>   iio: adc: rtq6056: Stop using iio_device_claim_direct_scoped()
>   iio: adc: ti-adc161s626: Stop using iio_device_claim_direct_scoped()
>   iio: adc: ti-ads1119: Stop using iio_device_claim_direct_scoped()
>   iio: addac: ad74413r: Stop using iio_device_claim_direct_scoped()
>   iio: chemical: ens160: Stop using iio_device_claim_direct_scoped()
>   iio: dac: ad3552r-hs: Stop using iio_device_claim_direct_scoped()
>   iio: dac: ad8460: Stop using iio_device_claim_direct_scoped()
>   iio: dummy: Stop using iio_device_claim_direct_scoped()
>   iio: imu: bmi323: Stop using iio_device_claim_direct_scoped()
>   iio: light: bh1745: Stop using iio_device_claim_direct_scoped()
>   iio: Drop iio_device_claim_direct_scoped() and related infrastructure
> 
There were a few small things I noted in a few patches, but otherwise

Reviewed-by: David Lechner <dlechner@baylibre.com>


