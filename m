Return-Path: <linux-iio+bounces-20795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 164D3AE1BEE
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jun 2025 15:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06650189B062
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jun 2025 13:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD21128BA91;
	Fri, 20 Jun 2025 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CI/g0L5a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211BF28C2D6
	for <linux-iio@vger.kernel.org>; Fri, 20 Jun 2025 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425557; cv=none; b=kvD1es8YsQw+7+7itowVFlOAMEM8dz8ne8bjbRUkkvgUlwGOnzAOKrRs7CddnkkAnmwoIUo2IF+v03X4G+3xzKIoXTLfAXvm96TcVZ3fGku7tLeihDbzIkL3I+s9g4fEXAwsxFypVA5QYgLfrXcLUBuHdFhnxPGbScSXH7iA84s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425557; c=relaxed/simple;
	bh=UYboRpcf2l6D1iqKjxqKWDn9qWV4TH/OyIbBTGBpKlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VrsrKkidb6qR9ybys41IOc7NvFfLVA0UcRIZLbd+KXwgk967aATTyPeGfldLMB2Oy0MZSfgd2r91PoreCc5Neq9AMIBxU07hVua2VubrZ+Fu+u+pWwEgxddJUNlBXGqAQ6OwxUf76BzbixVg+xykUIp9s6+wP6Sw+czbEUVyhFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CI/g0L5a; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-73a5c1d9d93so1802530a34.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Jun 2025 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750425553; x=1751030353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85nsbaEK6Tnb7LEAxhlSFVrthkkPjQvKgGVR+IA4SPA=;
        b=CI/g0L5a05qTpY6fIJspqv+KDcbRojKqTXEKvoEvLsMiXtDlNpX/PPkXCVxlYLQQ+k
         3uVTz6AMdzmOcgpsl4Ie5G86u8ieoqyKmz1rkcswhNtVPCmIrNwbsmUFy7OwGgu2+3PV
         fFlE0Agj2P7aZj2fEXticzdlGXrA4+dX96aZU1nsjfj0FRP+lY9t95nzTYkFcAbCwnd0
         PE6yqT/0LAozN20Awrg75/Q/Hg6wwNfqyb1NqAov9SPHDpq2vZ66JmMhnbfRctKSUqPn
         y9Cr3HyI3zy4b6vxjs/klDaHsxElJNlaZ4NY6dp0fZZawTZsAYEwkbljkoin5RIbNr3z
         ZTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750425553; x=1751030353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85nsbaEK6Tnb7LEAxhlSFVrthkkPjQvKgGVR+IA4SPA=;
        b=vUK9QDiKGW5FLKxugLEyqHwlXLAkGe5rFZSqCIT8qySKXe7NH9IH6XtB12EEwQyOgf
         SHjiwgUt31tZN8EgHW7Sj8Iek/y6XPFhIWX/l4r/cmk6euS+o9GXOcjicjULMyjRwSHf
         fthSkKe+wE45HLcn1HNwk2Og1ZWWx6jl+97VxrmKyYoqmeZFYfdSeNp/1Q7TZKKCJy5V
         c38WKupeaTSnYoqTSQYNzCZPSVIiYI6ptDKedl347TVQaDfR/2Vvyyz1VK+VocZ6hWc4
         vuRLdBk+3COFM4nlkz4jJXXlCYkf8ot/hm94m9MvFUCXx+cfWLmxZpFxvql8KJkhtrEh
         5+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWlYzZkESm6Pu7egP5yz8FXwOO8HR3uytwnsB5fsDstHWXm8ha03xMliOBedLrfL04m7ue3v69Ob0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbrU52umihEVMyj7RaFsWk2M2iV7cnWh24gWnRu0Ig0528Jf4/
	7+CxLiEnJ6B0hFeCJYa90LGioE288517QHhMx5U2ZtqkbGIwxwDRK6i+6+p5WIW3tHw=
X-Gm-Gg: ASbGncuw1phSuN1toGJug2h0hKaThM6z20+WDdkE1mgu3szD2j+ZF7bU53T6xnliHkU
	vwkYogA8DEnmwNhl0O6cXbyxAO2hnk6G0unSr2lpTX5l58qMD31ON68g5q1SBVFjnLV9hfIWk5f
	NXXlzG3EOiUxF2YvsZ+mJixD6WBFUyaUeiQCCjtOGcNfahg3RdVecGeHU6tVEqyuI0O5hObao2L
	DCAoVe0hxtsS1qM+9fiW4XDAfQAfa42lqc/4WBfdfj86nWwmzI65G5+J4BaJzLGPKpjkqxZJKLk
	QuKP/oTM1FhjOBjNw/NjsZkNiKIxdtniiYw2sLGXGWZPF52ZVX/kvapdeIhE0gRjA1UoW2U6qVL
	ZBop8qrnzwO54Z8ZGSBULX7u0OXBBDyv0KOTazQg=
X-Google-Smtp-Source: AGHT+IFB1egOnI3wTOzC6Gt7TYLJB8opelbR9lz+HHIeqFUUdilNUH0J122GTltzseWPkp6skmjj0A==
X-Received: by 2002:a05:6870:2b12:b0:2df:b3b9:5dfe with SMTP id 586e51a60fabf-2eeee5e5ef9mr2209324fac.29.1750425553093;
        Fri, 20 Jun 2025 06:19:13 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5504:5211:6fc4:c093? ([2600:8803:e7e4:1d00:5504:5211:6fc4:c093])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ee8a8e3710sm380533fac.27.2025.06.20.06.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 06:19:11 -0700 (PDT)
Message-ID: <2efc99c5-d1ce-43ee-8747-df0e6b0e73c5@baylibre.com>
Date: Fri, 20 Jun 2025 08:19:09 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Add the iio driver for bosch pressure sensor
 bmp390. The bmp390 is a pressure sensor module. It will support SPI and I2C
 protocol based on configuration.
To: liquancin.mereenamathai@in.bosch.com, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, vassilisamir@gmail.com, marcelo.schmitt1@gmail.com,
 javier.carrasco.cruz@gmail.com, Xu.Zhang@cn.bosch.com,
 Maoting.Bian@cn.bosch.com
References: <20250620045456.1151-1-liquancin.mereenamathai@in.bosch.com>
 <20250620045456.1151-2-liquancin.mereenamathai@in.bosch.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250620045456.1151-2-liquancin.mereenamathai@in.bosch.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/25 11:54 PM, liquancin.mereenamathai@in.bosch.com wrote:
> From: Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>
> 
> Implemented features:
> * raw data access for pressure and temp through sysfs
> * iio buffer tool support for continuous sampling

A driver only doing these two things should be 100s of lines, not
thousands. Clearly, there is a lot more going on than this.

So in addition to Krzysztof's advice, please split out the driver into
separate patches for different features. Ideally a whole series is 1000
or maybe 1500 lines max and individual patches 500 lines max. This will
make it much easier to review and it will give you a chance to explain
things in more detail in each commit message.

> 
> Signed-off-by: Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>
> ---
>  MAINTAINERS                                   |    7 +
>  drivers/iio/pressure/Kconfig                  |   26 +
>  drivers/iio/pressure/Makefile                 |    1 +
>  drivers/iio/pressure/bmp390/Kconfig           |   29 +
>  drivers/iio/pressure/bmp390/Makefile          |   32 +
>  drivers/iio/pressure/bmp390/bmp3.c            | 2781 +++++++++++++++++
>  drivers/iio/pressure/bmp390/bmp3.h            |  537 ++++
>  drivers/iio/pressure/bmp390/bmp390_driver.c   | 1604 ++++++++++
>  drivers/iio/pressure/bmp390/bmp390_driver.h   |  232 ++
>  drivers/iio/pressure/bmp390/bmp390_i2c.c      |  328 ++
>  .../iio/pressure/bmp390/bmp390_iio_buffer.c   |  220 ++
>  drivers/iio/pressure/bmp390/bmp390_spi.c      |  286 ++
>  drivers/iio/pressure/bmp390/bmp3_defs.h       |  871 ++++++
>  drivers/iio/pressure/bmp390/bmp3_selftest.c   |  184 ++
>  drivers/iio/pressure/bmp390/bmp3_selftest.h   |   93 +
>  15 files changed, 7231 insertions(+)

