Return-Path: <linux-iio+bounces-9015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7317F968CCA
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 19:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A051C22768
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 17:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3241AB6E5;
	Mon,  2 Sep 2024 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRXZGzt/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAF7183CBB
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725297695; cv=none; b=puX5bxsEUwh/3eKaPanIjCFfzArxBeINfNlLK+jBypYnpNZMqgbXcm7+fxkhEz3Oi8RQ/FJuGFHbZzPDw4BPhFAls46RKuQHFFcO6WHVyhpQHR2SQJy6zRmf7yY1e7AYEnxqiruVfiIJ/D2D9HBW8kpJXnuOmPwd1ZOBFPXmny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725297695; c=relaxed/simple;
	bh=jBHIzT/yYnWtHMjHomVWDxhsrbzqCUQMlmjj4nWniJY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dyj3TqCxzM16Q7KBvV464sDjdkIJi6GUxNOLfnzXlVJpc2g5pMgUWPjI3wcH68CxNN1iVs8S6zF0UYbUc2hV22Li1Z/hlpjUiMZBixLOgIJq23qyD1xKbwYFL3ZPy5PAi1uI1PqaQcoJ7YuEhjMqzEhniExa7VDjtxKYPKPy0FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRXZGzt/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c26852af8fso719694a12.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Sep 2024 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725297692; x=1725902492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uacxtoSrM3TN7dGQO9tzLsuoZW4yui2rV8z2RYMqHkU=;
        b=KRXZGzt/e+x+0acJXryNaYaNi165DKcN0M34F34O8y0qH+7xEi/3enbzq0TPan3psY
         AVYTt3GngDocsNGcb/MXVUc4wYgni7pf3S8K+K1iLAct3aB8OT9ln9fwLMBj3N7kw+dk
         xq7Y66ebZW/2Q/ju+SWXGB5qtVdzH7qGgxY5nbBx9ezt8Ggy0uM4HoJJqYr3NGBq0whx
         uWkgzFUmYWAmB3e4cQVUMviT/P76WHqy2pWzF+WSS4aipEZkssgTPWBOvVecgAgXsu7Y
         nxdRPRdH22U2kZkiqNsgMmb1NV9hw+cqjMC9UV0n0+Elnn8HszW4PCwOglQH2y1mmeyx
         Z96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725297692; x=1725902492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uacxtoSrM3TN7dGQO9tzLsuoZW4yui2rV8z2RYMqHkU=;
        b=PHmSV1ExzKFl7S1d7eLENy3wjXXewGX34pYNJw0n05uMzd4bsrUfDPWsPkbAxyO3PR
         Udm5W8VTO7Z/mljFC8SU7aAxm1pVNSpv3+R/IX2GCsE3/sUzNrJdF91gCuEIfQTEjPv+
         4iX3d8E7Bg7PfjCs/swQT9ka+NJExHz3W025WWVW0iYvbX7EOehC/nD42VE1yE7p7kAX
         nq8srCVXUzlDs8iUfFSDEwhfzCYXMQByOTJX6wRAKdu/0o9y1lD70tjeJpDjzXMWLmFQ
         WOQLwj6zxhYn/Wi9bvIBfQqFWOLNgtOqli5z5AWIUgrXVPF/ArjK2uqswVLa7MtWSRDV
         BV7w==
X-Gm-Message-State: AOJu0YzsDs1kTnnFgVeRvzmGaS5n3Cyw6NKIk7WM7qH06qBKjO7GXGKy
	dfjtveQ9n1IiBqMjob87r/9vCu8FLkSs8s1TDyvYV/DRzWYYoMYI
X-Google-Smtp-Source: AGHT+IF7AmNVwIr9DTzrQV7mLMPdDmdNcvoUO3V3f4eqjbWrDi9UnweuxuZzzjUQ4Jz5MnkC+skmbw==
X-Received: by 2002:a05:6402:348f:b0:5be:ed8c:de7 with SMTP id 4fb4d7f45d1cf-5c21ed3e14bmr12262702a12.11.1725297691006;
        Mon, 02 Sep 2024 10:21:31 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:bc14:b544:1196:d1a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226cd18a3sm5414903a12.66.2024.09.02.10.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:21:30 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 2 Sep 2024 19:21:28 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Sean Nyekjaer <sean@geanix.com>, Marek Vasut <marex@denx.de>,
	Denis Ciocca <denis.ciocca@st.com>,
	Rui Miguel Silva <rui.silva@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 15/15] iio: pressure: bmp280: use irq_get_trigger_type()
Message-ID: <20240902172128.GA4669@vamoiridPC>
References: <20240901135950.797396-1-jic23@kernel.org>
 <20240901135950.797396-16-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901135950.797396-16-jic23@kernel.org>

On Sun, Sep 01, 2024 at 02:59:50PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Use irq_get_trigger_type() to replace getting the irq data then the
> type in two steps.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/pressure/bmp280-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index da379230c837..b156dd763cf3 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -2596,7 +2596,7 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
>  	unsigned long irq_trig;
>  	int ret;
>  
> -	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
> +	irq_trig = irq_get_trigger_type(irq);
>  	if (irq_trig != IRQF_TRIGGER_RISING) {
>  		dev_err(dev, "non-rising trigger given for EOC interrupt, trying to enforce it\n");
>  		irq_trig = IRQF_TRIGGER_RISING;
> -- 
> 2.46.0
> 

Hi Jonathan,

Tested-by: Vasileios Amoiridis <vassilisamir@gmail.com>

