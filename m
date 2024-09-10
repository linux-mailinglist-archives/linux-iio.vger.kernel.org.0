Return-Path: <linux-iio+bounces-9434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDB797455F
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2024 00:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E091F26DE8
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 22:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D6B1AAE3F;
	Tue, 10 Sep 2024 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpQQk5gg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5E17BB3D;
	Tue, 10 Sep 2024 22:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006048; cv=none; b=OJKeOQumRr75DLpHOO1DLMFVGxs4pPJaT06MCOVR3KpJq35Ps/8radGBgHla9yeO6MiHjQ9oGHZGhRLIrZkEhpsMxewdy0iRtVfvyMv92Qw93tlGhVGKn0G4k+smVMDADpfok5d9EBLxuX9UjpZ+NFofvrckIVrUjvRpWp4nJLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006048; c=relaxed/simple;
	bh=kdB8NLO4ZMDypGj2iACl796DbiWwdzaFuMblyo/sNnw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXM1o9UhGmgwD9Cd1i/Aerd+jZ9lPQZPQtgtRw/HYEoHKJQIMoMLVdg/4MOB903wL2D0hW62XNUV14syYIUnZ0H1ksc+Z197RPoupxtCHtmx01ME6GmEeu7vqh2/n3jqxZL0EeLgHAu9GnHDjzi9J3cc2G29kVfGEgi8iALj+ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpQQk5gg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d13b83511so499647266b.2;
        Tue, 10 Sep 2024 15:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726006045; x=1726610845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zaBHXlFSVgtX2uoKTZ5NhrWWMPF3C7Nb9IELiMHEquY=;
        b=mpQQk5gg2oBVxWx6xZRbga1UDPhTKR68hLaXzw8djHskGq6we1Kj2wpoW/zTjOvczD
         PIifaPXqy183cH8n6yZ1twSKWE/mD7R129G0+g/paXYCNX23VV1Bb7Hf3OIUrnypYJgg
         4NygpEopl1HYWQmUP1+jam6j7hDFGFoLEIqAcbnfCm+X5Jyp6FZ8Z6L1b58XXuoYpM0X
         OmRVFGA2e2XmHt9qEOYKzG8ocjmFXpRr0K3aKlYWkLMR+/h+wqIvR6GCO3/ltusCVBWX
         7C2TuRu9ji/o8zQzGAdH8Dr//2tFXUrJ7DKXFgTtmdQRhhQk+mQbUYICWdp9OXOl1Olo
         nsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726006045; x=1726610845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaBHXlFSVgtX2uoKTZ5NhrWWMPF3C7Nb9IELiMHEquY=;
        b=v7YZQOBS5dLmf99x7UxK7awN1fVu9RrC9FCsAVHiDLZs2+3SQl6jXUgP0G3bQkR7oH
         BeVSuSv+Npor6TTjmbbpniYOf5AmpcJqQXyfaP/JEl1knywqwWnVHFfhZHwK1RcyrSp2
         /vowFpZacJWITvzRv4j2KcWz5F0bwV4P3Y10/vtR8uhnbx0IkDT7LxBR2c67EbBYwzkx
         IyPgQ890qmu5ULdqHNIuT/WmjuSBCl80RpPNO2sPbHK+Km6NdGqy6N89aJaWXs16th6n
         xJY3H7clOIhV72u4Uz6PKOQfs136rr3BTXqKyzh6azPLMg6E4GAzbssy8UevRQNooTKc
         snYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgRP8cohF1uwseXwJU0PrxH6E2JD+mNuHc4bDfuSFgal3dUk24Ud2oIgM8+QQT2c43VV4MVJGCbcc=@vger.kernel.org, AJvYcCWzFuvERUdLZKB14Yce6+l5cEyc8aCuotoJhjbjWdt+6Rs7e3ztRUxuGWOMdbLQJCkaZ7qVsX/Q3T+oNgUs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1fTJglQY8xsCMbz7aVbZUmhmAn4D78cVOawQR+wd15VlNiTxU
	m3lCDz4dzA5EEBRQBG6SFIhrtuGnMc10huif2PTuveLbgojpQQhP
X-Google-Smtp-Source: AGHT+IExOL0WVn3DXnZe0alPPu0E0ST8azrpTI/W2OLMwUhsHGqeFbXh1M7j4Uu3nGk2HUNTCkaP9Q==
X-Received: by 2002:a17:907:97d5:b0:a8a:8c4c:3e2a with SMTP id a640c23a62f3a-a8ffab29409mr173617366b.23.1726006045382;
        Tue, 10 Sep 2024 15:07:25 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:5d47:19e4:3e71:414c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d74e26sm533905066b.225.2024.09.10.15.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 15:07:24 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 11 Sep 2024 00:07:22 +0200
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: iio: pressure: bmp280: Use char instead of s32 for data buffer
Message-ID: <20240910220722.GD12725@vamoiridPC>
References: <20240823172017.9028-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823172017.9028-1-vassilisamir@gmail.com>

On Fri, Aug 23, 2024 at 07:20:17PM +0200, Vasileios Amoiridis wrote:
> As it was reported and discussed here [1], storing the sensor data in an
> endian aware s32 buffer is not optimal. Advertising the timestamp as an
> addition of 2 s32 variables which is also implied is again not the best
> practice. For that reason, change the s32 sensor_data buffer to a char
> buffer with an extra value for the timestamp (as it is common practice).
> 
> [1]: https://lore.kernel.org/linux-iio/73d13cc0-afb9-4306-b498-5d821728c3ba@stanley.mountain/
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/pressure/bmp280-core.c | 43 +++++++++++++++++-------------
>  drivers/iio/pressure/bmp280.h      |  5 +++-
>  2 files changed, 28 insertions(+), 20 deletions(-)
> 

Hi Jonathan,

I noticed that this patch didn't receive any comments nor applied.
Was this intentional because we wait for something from mainline to
be merged back?

Cheers,
Vasilis

