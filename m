Return-Path: <linux-iio+bounces-21860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C94B0D556
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 11:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123393A4AC0
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 09:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ECC2D9787;
	Tue, 22 Jul 2025 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdkXyP9X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE84270EA5;
	Tue, 22 Jul 2025 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175429; cv=none; b=stBSHF/bNNkLud6AqNKzaeaQVhYKtvBexhHLihWOAbDUhrc+YLjpwuJkXDmnqBiz28W+kt6ZtduhfaerEaawuxOdiY9HNUiyTLrZnHb81UIRa6gdRk9z1qmDJj2SBGBm2GD/NWYMs1Kb+USp+F7fPgI4f0KcBbNZI/ScGv9MBjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175429; c=relaxed/simple;
	bh=+d3evjGw0d+DVZwR47JVejQOmqBqPDo3ZqdDJY5dYJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEnQ0+FAfdsmitWxs83krfaowVeah1K51LkZy/o/4mHpQ6D1aKDhm7XL9h+kBUBL0a1RMYl4Rwe6kU3VmrJotUw9tb1yzumv9/rEGJ+NGwFNTbFPeJSlq4xf1KID+p0Wo1BZMprgKR8i+Rv/JfrnuRdtCy0ksgGmQVIcRfkWbhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdkXyP9X; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d3f72391so53499895e9.3;
        Tue, 22 Jul 2025 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753175426; x=1753780226; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+XWwmum3R+GIflcR2H9ndlZEFY3jk1LUJA8NM9kbmm0=;
        b=OdkXyP9Xyu7ZyZB1QcVsCwZRkfuTqst9p4la3WFYo55BsVvP9AyBzZkI6xzWmgclpV
         jklv34w8jQi0nwWOC5gcYWO1xbg77Kb1UDycs3nt5K3dKgibl/JctF0djtiYpn82SLTz
         l+Vcv1xHcWXHlb49Cwm1QW567OwumEq9It6C87ocm/4U9hSwms6qLEFjbzI5dxABRf9h
         GfRfj5w/aE01jPK4eVR+B34n62mu7SgLVRgUSbdAaSdXvqsT6cCRvzZnDt0A2AKF2TfY
         nzzewuqeOCX7QaoFgkRiBxx1T1gY1OrOdNqw6RlJm2SsDVdMoGs9T7IORtNTkwrV3hdK
         QKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753175426; x=1753780226;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XWwmum3R+GIflcR2H9ndlZEFY3jk1LUJA8NM9kbmm0=;
        b=cVdz2F/AgFtFmVxzxnv7BoLudzjNEUfy60mC9tTjt5tpEZdKmnclUc/1zhOmbzqa5M
         CG/aRNjqPIteDVrnZFYnoZvaGdYxsuy3tV5L8Jb/k8Z+fWkd8kr4+aL84X6W1MMO8N3d
         sCFhiC7qbzNY4mFLSpB8VsQIlTFcMWaAsUaQb5a8gQN0llW82/AsJ29jyROTM6OtIgn4
         BLWBIIBJA0WLFgRmMOCMZVa0Q23YPLcVaeljJWMbFX4dFf6NlbcRRJ9or19DF3k4ixfh
         zW5MmNQoxdNoVHF3PyDmmrfAKZ6U1DJAL3fTSqHChsdx1zlGw6td9NkfbA/Kspp+QyjA
         YJWw==
X-Forwarded-Encrypted: i=1; AJvYcCW+peGfaYm1jU+Pyaog6AtpK+R5QFw2/D10PbYKkm2BDiDnn2M3SABej8RhpIXN2IaVC54DcmyXcQQ3zkWx@vger.kernel.org, AJvYcCWlIpyqvZQ/0MekS/Utd+t2XLxdzmMHnq58VF4VdNPsu9aafmqrAm0gy4h8mfQdi0BvMxMalQNlSPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNWqTFaq751ydmCp02qBS70KGxP9ea8YuxjcsNyq3el/xTti8E
	IUeJqhtAIfBd60yaobLyWk2xMMRA1RflKKur71vk5kDmgcABhgi7BMug
X-Gm-Gg: ASbGncugD7d9Dpx13tpxYhxksTQzYtWUnFnF1K1Pd/oJvsI8U6KkBf4l0n/UfATCO4a
	QujrUewkrNO23OJo9qnWCrYY0seiN4Yn4Th0GrdTk3mWz8U895dlilavTvSBMiIHouMKi+pChrL
	pEGyIFAgpc3+pgObZ45E1ox1lyx0XUzgW2uC88fSzD5H9/YXbvqUaTfnEbxnkpsu34Yx4t4O+nY
	ulDNe1VB26M4h/qgwfT/rKTViFZi+/sA96Us16vKyMMRhGZ/Skm7c83YfDY4Cecgyh8Brt8e51q
	BaKMOyslUDqiJ35cdxT3oJ0Y7vBpHSgY+fsJFDGdVE/EfFU+1js+jrcGGKVNpEs+fr5UcKvX21+
	g5M+vCUI4FA==
X-Google-Smtp-Source: AGHT+IEw445q7Jig1Z3knFleS+D9QBcTWSPKi2eD2VUGkre8uGpLbl76HLgDvGpdeDylmgXPiiViyg==
X-Received: by 2002:a05:600c:a305:b0:453:8bc7:5e53 with SMTP id 5b1f17b1804b1-4562e853505mr194573555e9.0.1753175425381;
        Tue, 22 Jul 2025 02:10:25 -0700 (PDT)
Received: from nsa ([89.40.212.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e80731bsm182948865e9.15.2025.07.22.02.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 02:10:25 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:10:38 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Andreas Klinger <ak@it-klinger.de>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: srf08: use stack allocated scan buffer
Message-ID: <xnacdjv6bmp2ghh2wcloetec5okl7vbwbihpzsf2b3u4vqyc3z@dobmhdkiruib>
References: <20250721-iio-use-more-iio_declare_buffer_with_ts-6-v2-1-8b66e5b4e75a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250721-iio-use-more-iio_declare_buffer_with_ts-6-v2-1-8b66e5b4e75a@baylibre.com>

On Mon, Jul 21, 2025 at 05:21:08PM -0500, David Lechner wrote:
> Use a stack allocated scan struct in srf08_trigger_handler(). Since the
> scan buffer isn't used outside of this function and doesn't need to be
> DMA-safe, it doesn't need to be in struct srf08_data. We can also
> eliminate an extra local variable for the return value of
> srf08_read_ranging() by using scan.chan directly.
> 
> Reviewed-by: Andreas Klinger <ak@it-klinger.de>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v2:
> - Zero-init the scan struct to avoid leaking uninitialized stack to userspace.
> - Link to v1: https://lore.kernel.org/r/20250711-iio-use-more-iio_declare_buffer_with_ts-6-v1-1-25c70b990d6c@baylibre.com
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/proximity/srf08.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> index 6e32fdfd161b93a5624f757d5b7de579415b1055..d7e4cc48cfbf700c7828235de99a66324767316a 100644
> --- a/drivers/iio/proximity/srf08.c
> +++ b/drivers/iio/proximity/srf08.c
> @@ -63,12 +63,6 @@ struct srf08_data {
>  	int			range_mm;
>  	struct mutex		lock;
>  
> -	/* Ensure timestamp is naturally aligned */
> -	struct {
> -		s16 chan;
> -		aligned_s64 timestamp;
> -	} scan;
> -
>  	/* Sensor-Type */
>  	enum srf08_sensor_type	sensor_type;
>  
> @@ -182,16 +176,18 @@ static irqreturn_t srf08_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct srf08_data *data = iio_priv(indio_dev);
> -	s16 sensor_data;
> +	struct {
> +		s16 chan;
> +		aligned_s64 timestamp;
> +	} scan = { };
>  
> -	sensor_data = srf08_read_ranging(data);
> -	if (sensor_data < 0)
> +	scan.chan = srf08_read_ranging(data);
> +	if (scan.chan < 0)
>  		goto err;
>  
>  	mutex_lock(&data->lock);
>  
> -	data->scan.chan = sensor_data;
> -	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
>  				    pf->timestamp);
>  
>  	mutex_unlock(&data->lock);
> 
> ---
> base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
> change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-6-6ffc8e99552d
> 
> Best regards,
> -- 
> David Lechner <dlechner@baylibre.com>
> 

