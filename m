Return-Path: <linux-iio+bounces-14043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF1AA0672E
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 22:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050E4188956E
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 21:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EA12040AD;
	Wed,  8 Jan 2025 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERF5SMt+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5085943AB7;
	Wed,  8 Jan 2025 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736371787; cv=none; b=kScrZJGXwtKC63uh9PSw/IwiBrgiVSb8nqGPm8dgJwQLjOCOKH/8tg5ZL772gWCymjYhaRwRtfu1nki6f6JsJUeqL5+qNd9lA4LYvs6p5UnNFn4yDEczCxTd3/+4Bt/kq754LLZ4mCYyKDj3Yx9wMZlCzbkMe76vEQRMjX8R3f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736371787; c=relaxed/simple;
	bh=svr9PaRLHzce3FAXAckgjmrSMtXt8xjOdW7PieSAOe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5msd/BgaTCTKT3vRsv/06Ma3H2ANNWk3iQGk61xhj2XzIQrcO7F/+GOyBAngigvhcxVLk8T3QeA7PsEMCyk+iuHzGlL+WzSmoJus1L6wo+P5ZypJFOOmIU3BvBz1PFLC+30tPdzazi94Q+iJZAkUz4ixV3AcAHbLIUrskwgNSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERF5SMt+; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so261406a12.3;
        Wed, 08 Jan 2025 13:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736371785; x=1736976585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AwGcYEqzfVnBOjJ7GGurOS5qcydEmm31aGstr0+y9EE=;
        b=ERF5SMt+jewKhBWXQyY2xzfKKLFnsoLkvkBK4B5jUnWkJb+KYGpAQPC1YUK4HMyPPW
         fbDbSFKNO59Z+8mvjpDKBO7CRvLmNN/f85DVC0VWL5L8dXuDPDDnmT8mmjh3PiFhfdkY
         HwYUGwpM6zdGD+URDcGPeBk2R7Gt9JC4bK0qGh2oxCB6sVQhZ98UAQkYCgVfd4l+rbjo
         EAecZNkfmRLuHxk6pbZQzpSCgVGrrWjPavlz7ufNyAd4ZmkQxWrrxoP+Uuq7OJ/A3X27
         zGO8VzGCwFJo1T0wYwQTrBCCcIfVewco4A/atjoDxv4jiirO/GaIzeEQlsodjUKmBYho
         dNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736371785; x=1736976585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwGcYEqzfVnBOjJ7GGurOS5qcydEmm31aGstr0+y9EE=;
        b=kKdCs0nBe+vMM0Bq6p8aqJbitHs1yFT8/jIxSlYerO+W4j/KuFxiTkkci/YZ2GZXX7
         PwhrNzscWQm24TcXBfpT59mQjZg2LLuFBzQGtWKj0TYb6L0y5yKPlaJrEWaxadBlF7A7
         hjV6eJaNN8KKvzrAx3HUGrVDq67Z+P/h5BLRLP3bjKGGMtufsvyeNnFmUjIDV6rc7qqA
         0PiypBls6OzbWUPUUIudmF5nK/ez8ZDv08uD5RxwJll8vhE4/pFyRSwBrtE0zOsCk4Tw
         C6AyT3XSk0BYZ18N+yKUdu6t5Qf0/JG1ITbzM/tAH3Nao8GlG/5qFK7HmXNSwe+tjFov
         GR2A==
X-Forwarded-Encrypted: i=1; AJvYcCW50x92VE34xwVJpormYTFN3IlZNrdzlNXBFpp/qvIQLahePblu5g++4sA1fXHPBtyDI6ejS8p2bCg3GAOx@vger.kernel.org, AJvYcCW6AVE91mCTR9n2J70l8Tfsd4hEQrTG9pslrzoE5efB9QJhTsQRtOiwkp7QAYRcdiqiV5JrbVPoUpyt@vger.kernel.org, AJvYcCWjm9a8jqkPLkyJTpcgVYr1mUtEP2n29MYSDkjjDlRk1UL0/6UiUQxEmnLJUYCWzIJ6gCgGCsYGf9J+obSRsjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP/68cBubyWi8fYpEl92trcLN65tInAN/vR56vfgIdbcfaQ4qa
	kORQIShDPDydPplQFCPuNy2shP74t+AGNwjqLaI53qYse0mYUNiB
X-Gm-Gg: ASbGncsmguzd5FibVHLsWOwP9ss0DXRweVUZyQF8m8jehXM9CxSwX7YuAEmxhwpH7+4
	1E17X9mU9nsZ1KaW9mQLh3rx1fIy5qebzI4d7HMXXnBrF096adIiA5WqHnto+252mNjLYhMgBg7
	eHueOdfdXrL/v2hTRHTZowC1aiTutd0BIWdNk6OGtFPV+yqK0tb/4l5iffgdZxmDMKgnQiCqllo
	BOCXmhnHHoktDhjr1s3WTp4QYhU7MTVePbLbLs2yfo6e7up+CfWej2UXMbzffNhr7U=
X-Google-Smtp-Source: AGHT+IFqoo4e/XLtkJ1ZX4cvGaFZFXJ/tykG3+D78zkvAYtwrdhogZ3DpzDQZqUc8C8PcvYqeT7rpQ==
X-Received: by 2002:a05:6402:3483:b0:5d4:34a5:e2f4 with SMTP id 4fb4d7f45d1cf-5d972e6d2dcmr3699276a12.31.1736371784318;
        Wed, 08 Jan 2025 13:29:44 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:eff6:83c8:3a70:b78b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679f19fsm25429834a12.45.2025.01.08.13.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 13:29:42 -0800 (PST)
Date: Wed, 8 Jan 2025 22:29:40 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: bme680: Fix uninitialized variable in
 __bme680_read_raw()
Message-ID: <Z37uRAl18atKgVz0@vamoirid-laptop>
References: <4addb68c-853a-49fc-8d40-739e78db5fa1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4addb68c-853a-49fc-8d40-739e78db5fa1@stanley.mountain>

On Wed, Jan 08, 2025 at 12:37:22PM +0300, Dan Carpenter wrote:
> The bme680_read_temp() function takes a pointer to s16 but we're passing
> an int pointer to it.  This will not work on big endian systems and it
> also means that the other 16 bits are uninitialized.
> 
> Pass an s16 type variable.
> 
> Fixes: f51171ce2236 ("iio: chemical: bme680: Add SCALE and RAW channels")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/iio/chemical/bme680_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 26eb0fa77a43..9d73fd2cf52c 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -879,11 +879,11 @@ static int __bme680_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_RAW:
>  		switch (chan->type) {
>  		case IIO_TEMP:
> -			ret = bme680_read_temp(data, (s16 *)&chan_val);
> +			ret = bme680_read_temp(data, &temp_chan_val);
>  			if (ret)
>  				return ret;
>  
> -			*val = chan_val;
> +			*val = temp_chan_val;
>  			return IIO_VAL_INT;
>  		case IIO_PRESSURE:
>  			ret = bme680_read_press(data, &chan_val);
> -- 
> 2.45.2
>

Acked-by: Vasileios Amoiridis <vassilisamir@gmail.com>

Hi Dan,

I had already applied this for IIO_CHAN_INFO_PROCESSED but not for the
IIO_CHAN_INFO_RAW channel... Very good that you spotted it!

Cheers,
Vasilis

