Return-Path: <linux-iio+bounces-18819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F28AA05E1
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 10:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8891B619CC
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 08:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF5729615B;
	Tue, 29 Apr 2025 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jPPFzB0N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A8327C150
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745915733; cv=none; b=iVOYiB4gBEA4y0Dy1or9nYUI/b4pkmxP6P90tFvezC65D14DsZ4HMDwTcqA27a7Ctq9AUjDxCzz8xzbM7DEHC2hOARun0+i7Y6d+3Yuqq34tP08lpzUD8cgFvRKDcWgvCv7DSW7j/VN13JGKKCcLpzWIT82ypAHCSy7A5+glDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745915733; c=relaxed/simple;
	bh=ZaO56ejThSxRzS1nBO1hWUV9qmuFiNNZzzBGRbfNtPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0gAyfBOv/Ey4hfindS9wtiSA3ZApAKqYiFXk4mMJc4IfpZwFrGpxacF1aUBTP6oDl1fYwP/ag7l6AliWBFOhSLKe6J/sDZHhkUZNrHMQTTVs3LJP7XFsE74NGTNgCvhWL2JwMltw1uwAU2e8UJr+tI7jvxCMG1VRCVv+xjTxM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jPPFzB0N; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-391342fc0b5so4197637f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 01:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745915727; x=1746520527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hyI+vkzvATQ+oPRkGM6xS0Ik29eThJkeSR9qIvKwiD4=;
        b=jPPFzB0NH5NI/kMCO7W/4UoWXwo87888+JuHw6RINARoMGZOLdQWwidTpuww86xo9P
         Yqr/EknhyW2azq+2QfyUFORDA6o8NhMYplWJ6NCYSp6LM7DziAL0Ft7tTDLbPkbbj2Hx
         BA9Okf6G6H9DAIH1PlJhGbunQbrWc9bO5kbjykh+A7MwaFxiqKTLXKQhnHYGMtM7TvNn
         4sZdLJqgqIxqzCjlDQa9on6zpvE/IM6WX89TD4QvHYNyfAw1mGLgc8zRPn0q8SvEEgPS
         rLjj/NExwt8C7JGndnzvvB+0HJkIxf9dN2Fuk8axLyWUSgoh6gkDACVUZtIKV6TQINhf
         6k9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745915727; x=1746520527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyI+vkzvATQ+oPRkGM6xS0Ik29eThJkeSR9qIvKwiD4=;
        b=sbS3PSdMKDggU0yrSw6tuw2aQg0Aqp/NssXeBa6nKIxvuCH/BaclvTH2d8I7FbdLRB
         45ckR6G2gi5kb81Uav98vFmNykRjWBDFquHPyhuRJ+Il4X6IF8tpN5ALNIxuLsK30yIm
         N0HAlSlKXibSMZETEpMzeoFFs9zWguOEPzViwB8McGb1eFj4B2pXlTpCje6Zx5B/XLz7
         ftvRMeT020QOHWliRyFUI36gxTQ5uTPUn+0XqO06jejXCbwYbkvFtfI3BIsF1uY/Ayw6
         NP7IVyVF9q6PF7myHnG+7YCLm97Uvr7ua2dYS6tlfBr0hTUV1u/usyZ9KZGM51w7PrVb
         Bgzw==
X-Forwarded-Encrypted: i=1; AJvYcCXxxs2N5h/dW+VD/9OXvBWcBzbDZufimJGt7ePpRou5CRhuwnk/ZNCaVqsU7VPZJvNlxEFuhF5EOKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzswec5NBMZpFlKOpZkuxnxytrQstdpiDXyv6LPxJHtMADQY18
	HNC+1OwKbgLtoEbiUj9fZijAzVij0+IZWRVqXUhadGugfgkz70lqcxaTdmAqy/o=
X-Gm-Gg: ASbGncsuQh4rzfowDcxq4te8gQ25Hl0jP5Fxjl/uPJ67pAiIMKxZG5Gc7DoQ+WysIYE
	DAocHlG9AQfDayL5nM8oKQZe/my9BYy6uBAzAcHgh4NelA3tnSRiMy4jAb+0GF+FnhGlMnplOJo
	qxQk7PV7gt6qnqP7iO3fOKRQOzFF054FeRM+7Skwhk8QWMLbD14oV6fnVbLGD0bsCSJwmqg08rC
	4sXXeH3rLsP26CuGpsZ0/35wPMjf2q/h47liNpG4VYrY0R2X91UP39gDoVJRHsraenvQeGZvyJt
	MgqoocBzSH90FDBuu25rPx2cuiIGz7xr+FpykOml+NgJuxhzmQ9kDmiTXJcLh5obsdM4SK57n2C
	lnHQWRsI=
X-Google-Smtp-Source: AGHT+IFZhCkQOIyJ9oPlNzZA28oEmoeLDHWRYZCNcJUG9KfhtjcqugnktaaeS4AF/qgx1AjGsb+yrw==
X-Received: by 2002:a05:6000:188c:b0:3a0:82de:f228 with SMTP id ffacd0b85a97d-3a082def248mr6959999f8f.45.1745915727089;
        Tue, 29 Apr 2025 01:35:27 -0700 (PDT)
Received: from archlinux (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e461bfsm13422566f8f.79.2025.04.29.01.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 01:35:26 -0700 (PDT)
Date: Tue, 29 Apr 2025 10:34:14 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Beniamin Bia <beniamin.bia@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7606_spi: fix reg write value mask
Message-ID: <upz2umlx6qjnfiw5wvheukvfvolvea4anq7hky2vz5yi2w5wea@ormxyycioexv>
References: <20250428-iio-adc-ad7606_spi-fix-write-value-mask-v1-1-a2d5e85a809f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-iio-adc-ad7606_spi-fix-write-value-mask-v1-1-a2d5e85a809f@baylibre.com>

On 28.04.2025 20:55, David Lechner wrote:
> Fix incorrect value mask for register write. Register values are 8-bit,
> not 9. If this function was called with a value > 0xFF and an even addr,
> it would cause writing to the next register.
> 
> Fixes: f2a22e1e172f ("iio: adc: ad7606: Add support for software mode for ad7616")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ad7606_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index bd05357a542cf7234d5bb6b718829d6b720262cd..6c1228c7b1b11058cb5186513f032f7c8c8aa8f4 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -127,7 +127,7 @@ static int ad7606_spi_reg_write(struct ad7606_state *st,
>  	struct spi_device *spi = to_spi_device(st->dev);
>  
>  	st->d16[0] = cpu_to_be16((st->bops->rd_wr_cmd(addr, 1) << 8) |
> -				  (val & 0x1FF));
> +				  (val & 0xFF));
>  
>  	return spi_write(spi, &st->d16[0], sizeof(st->d16[0]));
>  }
> 
> ---
> base-commit: aa1bd0b0ad048855d9efbee4ee8b9a6eee536256
> change-id: 20250428-iio-adc-ad7606_spi-fix-write-value-mask-7acdcca46227

Reviewed-by: Angelo Dureghello <adureghello@baylibre.com>

> 
> Best regards,
> -- 
> David Lechner <dlechner@baylibre.com>
> 

