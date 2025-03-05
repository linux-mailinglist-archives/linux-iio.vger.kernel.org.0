Return-Path: <linux-iio+bounces-16398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625DCA4F609
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 05:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F99B16F2A8
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 04:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9731B4231;
	Wed,  5 Mar 2025 04:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faH+v/k0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95119258E;
	Wed,  5 Mar 2025 04:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741148726; cv=none; b=q+WyIaoo/x1t/3xFJbdRHIFlyppXOERxLnEFK0iTkvxxt2r995Zw62aaZz3Lzrgrrht/y/xfM2QeidtRdl6eJauRPUyESVIkUxRr4cGHRyfeP0MwyOSvLxBZBwzqOgUCTLewcpseZKh1Cuf2YQzoNF8fznsJthOhh9ItZYT2Bdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741148726; c=relaxed/simple;
	bh=xVXj5uNuDprrX9NgzeSzCIaye5vTwhTZ/RbbjSMwxv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8w0z3CJQakcaY+NLaMOPKA6hw2TlLPJ02j0GVa0je1KAbmBA3The0fw/jsGV7r26E4zXKDkH15dxhmIszGKYTPmRjY8vnxNNs5CMkAF1iJkx5kM8uxY9qiJs/PhNgfeQrifMm8vqpw/ID21BZKILQIoR452Z+hPq8k9TB3c2Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faH+v/k0; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8e6dee861so4738226d6.1;
        Tue, 04 Mar 2025 20:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741148723; x=1741753523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+h56XZ364MGW+3FBcMIihUk2DOAx7HjP417UZqMWYwo=;
        b=faH+v/k0c6gT7vu2CexVFI0yEpf86TzC/8s06zQm8Qd6yW3aN5XizvDjXaflYTKwn2
         ajGKqfmEI2N/jOe3P83hsfqzvLUP8WvL80rWB/FqaHNODYkdwp6BiykvSxGA4xejMXuH
         yohQAPWcnPsur2rum43mOLH1X5EgyyiNr3RmyhEoIzuje/BkoVJmimuByXrUb6IsoLfF
         Yye6ILDRA2nQiLE/jJDfXPsT635dPhqW2xTHtIBixzWUDWfu2sIU1ASeaeycPhlYGX7S
         o+DvIyE9vrJJgmgoyY0pFsL374nw2PziOR85UsKswF5u3lFCOQW2MR+iVBztoWBfgJUk
         VjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741148723; x=1741753523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+h56XZ364MGW+3FBcMIihUk2DOAx7HjP417UZqMWYwo=;
        b=RiE0DUV97axgVpmosX/prkiyxcjtMgmTanGDslXfrH9hxPiuGxF8dQA2UFqZifUmb6
         LuW2JaEpncF/IzGCOrjXbQQ0BGtJ/DYwCKsiNMg1wbNgXki7nJEgbtf9Y8GxsAJW7WIW
         Z9NazcIlrX7N49MX3xoZ0uWEAcPDF4xwF7d12OXpwbC+/H6XIjIw8U/io1fwnefmipw8
         CZ7pyoHr7DXd0L8a1ud9PGZkDSGMT0MkuDV087caYareuTS0k2A1ourSZxhFD2SFAg1P
         +cH57m7uVLlbg/g1KwBJh99boCBwmuCfJYqhdPCR3ucSS29PWeIdUurvelW+BGfJmEyS
         vYVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq+poLsbfhmCcMPZ6O5FL1pdXFqu79zB3Gb995J1URSK0CjfQcJ6bz4ayMkgt3KC7YyonxFaWzYIY=@vger.kernel.org, AJvYcCXAiR1/zeMtDbFt4NTyjQa2W69oR3tCf5JddWHnfqTqUvt6RXPHm3X8R50SFRekLpASunllwJHOhOPX2JTP@vger.kernel.org
X-Gm-Message-State: AOJu0YxbdUSgcyzn/QjdLeR/TzmabgKu6UsGqstp30LQCISpRpXmX2pM
	K68MX8VLJp2Yu1aBSVM+MfBKchRFCOGsqj5sVRq2SHGSO4IAfXFcoCvAvA==
X-Gm-Gg: ASbGncuDRQ+JhG+gM9Xfd8PBgbK7MngnPw477kbhAXw0k+OwzWxNQnlAkhsUfLIwzFv
	x1pvqn42cKGbJsienUNxfBVXeHmVwe3BMMRcRRpiRRTg2fAVC31cfx3lRguk4x9FIO2tha4fuVI
	oFYP5xlpIMvYgsRwzG6GwLPRZYcugXnhkbgZf7335fOPrfhgtxx50nEHyYKHrgd1olczOr2tnpl
	/ZUvVXQhnExKEHBXj4ZrvsE5NUDa2fb+TbEpaJ9VF0DiteZTooSoLTWeHHAeH/cXKI8HqlxgB0I
	rjeSJUrvnvvFHfRGU+kaLV8ve0CWvImFiJTaPliHOHgOlFFvr5nogspbNR3Up0JDK0CcZ5Y=
X-Google-Smtp-Source: AGHT+IGAPdtnN/1ww52BZxy2q3tJ/zxTSHjHpKdJIPhjRDZ9WGwwJYaXC02FCoZF9ORBkR5++0QBkQ==
X-Received: by 2002:a05:6214:da5:b0:6e6:646d:7550 with SMTP id 6a1803df08f44-6e8e6f8fdd9mr31367416d6.19.1741148723432;
        Tue, 04 Mar 2025 20:25:23 -0800 (PST)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8c0b4a49fsm42033556d6.67.2025.03.04.20.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 20:25:22 -0800 (PST)
Date: Tue, 4 Mar 2025 23:25:20 -0500
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi270: fix initial sampling frequency
 configuration
Message-ID: <xvk32vz66mjl46rmrowfb3zxcbuw7e57pn2eh3kvqv5vk3jmuh@45p5qzyl5ljr>
References: <20250304-bmi270-odr-fix-v1-1-384dbcd699fb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-bmi270-odr-fix-v1-1-384dbcd699fb@gmail.com>

On Tue, Mar 04, 2025 at 03:01:02PM -0300, Gustavo Silva wrote:
> In the bmi270_configure_imu() function, the accelerometer and gyroscope
> configuration registers are incorrectly written with the mask
> BMI270_PWR_CONF_ADV_PWR_SAVE_MSK, which is unrelated to these registers.
> 
> As a result, the accelerometer's sampling frequency is set to 200 Hz
> instead of the intended 100 Hz.
> 
> Remove the mask to ensure the correct bits are set in the configuration
> registers.
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
> ---
>  drivers/iio/imu/bmi270/bmi270_core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index a86be5af5ccb1f010f2282ee31c47f284c1bcc86..2e4469f30d538ca3e9eb9ef8bbc6eaa8b6a144b8 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -918,8 +918,7 @@ static int bmi270_configure_imu(struct bmi270_data *data)
>  			      FIELD_PREP(BMI270_ACC_CONF_ODR_MSK,
>  					 BMI270_ACC_CONF_ODR_100HZ) |
>  			      FIELD_PREP(BMI270_ACC_CONF_BWP_MSK,
> -					 BMI270_ACC_CONF_BWP_NORMAL_MODE) |
> -			      BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
> +					 BMI270_ACC_CONF_BWP_NORMAL_MODE));
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to configure accelerometer");
>  
> @@ -927,8 +926,7 @@ static int bmi270_configure_imu(struct bmi270_data *data)
>  			      FIELD_PREP(BMI270_GYR_CONF_ODR_MSK,
>  					 BMI270_GYR_CONF_ODR_200HZ) |
>  			      FIELD_PREP(BMI270_GYR_CONF_BWP_MSK,
> -					 BMI270_GYR_CONF_BWP_NORMAL_MODE) |
> -			      BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
> +					 BMI270_GYR_CONF_BWP_NORMAL_MODE));
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to configure gyroscope");
>  
> 
> ---
> base-commit: 8cca9edca867350e5f8dc65b71e7a6ef4157981e
> change-id: 20250304-bmi270-odr-fix-620e7f8daa7a
> 

Good catch!

Reviewed-by: Alex Lanzano <lanzano.alex@gmail.com>

