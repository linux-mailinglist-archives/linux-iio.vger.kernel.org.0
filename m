Return-Path: <linux-iio+bounces-7249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0EB9261E2
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 15:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 489D7B28C63
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 13:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDBC17A920;
	Wed,  3 Jul 2024 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JE0oyDp0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789DD179970
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013399; cv=none; b=SugPqwq9+Xbp2omTAyhCNRxuGg80YVWqYx4cWgpgKwMw5LSWMhXJpkciow+cwIiS3gWCitJawAx4+cXO1Ff9b+rhouYR9uHdWGTETRH8Eqny+EWGJDEP4H0xvTbi97l2yHB/hDGGnpHqXB28IOfJ1822+8yt8OZy4xDUkU/XZ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013399; c=relaxed/simple;
	bh=n8rNcgytzr18aqcfGjlWgLimsnfqxE4xExXiuU5ntOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKcXN1TbCZbNWNCpYDV8YOcD/OHX8MzW5qmbQZ3BQW0BqFvYo/YYjM84jP+jwWsdG414/Xkdj/XTB/w1gOFBxgurDv8lFjMFhBHWmhtMDJ+kuAgC9dodXvt+yL1qvhHiCIVUcOcT2uxf21tGIO6d2Q31GI3qhIuMyKnrkGNUKKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JE0oyDp0; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5c44ec4f2dbso1819340eaf.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Jul 2024 06:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720013396; x=1720618196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tkRMXmFtnswe4eBnsfdstcxfteOHZcne41UQHuOq2C8=;
        b=JE0oyDp0v1XKneFjNkeMUQz5RLmAyvd2W7fbYw9NgFZDSIhvQtU3fZmZ5GKfBwNb+V
         iXXhUUfW+5T0d0Cyd/utNhn9z/k7wWWPSzXeNs/8LMZyMZGJZwr5xToo3HICjKlqPAV2
         gsezImmIieklV9KSeffwq9OIN9jvwGWya37dwy5/vQ4IOHTQs1ccJx9xZhPbr8zVr1F/
         tIeI38vCd5FXw3abcqY5pTKIodCNj4SvwcZ4q7U4/CNs+Jr7sVv1tysJ8KyVI1lOcSVr
         /twaYNlJ5fsT93JbnO3kFaUaDluAL8Vx74TYI12t1/EWAu7OidgmqDc4qgo5/p6/oniu
         HwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720013396; x=1720618196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkRMXmFtnswe4eBnsfdstcxfteOHZcne41UQHuOq2C8=;
        b=gp0gTQfS4A4RyU38wRuIWz/p6bY3J97IDbr/ylZExZVYa1Ttlf90Wj1CG6IvRFxoMH
         VojVI+rhad0I8u0rG8CfIrhf/0PfdnDc6qvbBrA+D5jSo1GwVCz5aJP3ffyA3gHlUj63
         8OJiHcmzeFMObep92xQ4sDaHkp3iJf+JZdf3WdZfbTV/9l29URxvj9ni8mBkMTlyH6Uz
         JsJWa2BwsN6Qf3DZxGLuhWOBbaQPbwQBEF6uz9aZ/9/J+2YZVmX277iO0p1or+AFnpoS
         tJp4iwz1KvYuZa72UwC3AjtJA0k9aaHJZpJ/DT9YC4kRBk7YROnRDISjg0nKopoXz/uV
         tz4g==
X-Forwarded-Encrypted: i=1; AJvYcCVS2SUg7s2JF2SZ0sM5ZQB/1hXjK6GEiZmNjZll6hpZRnPaMxynXRhuPcdUP3qhAVC1DA9q3AUPKZScbCYT2+iKtEt7p1JPj4OE
X-Gm-Message-State: AOJu0YxmfK/5grwEhv2PDvYeQ3kTFoGDUk4zUXfCconZ8QgYsIwTuRcu
	KNMvoGirTdlc1Ql0IHQnNR9cHoxFl0TIxTgCDEGZC6EqRLj3L5nlvSfUVlYl4tQ=
X-Google-Smtp-Source: AGHT+IFanVXEA/1p7SjGFF8jh/JC/+imI8O4iXN7/80UChDVmSkOKSU/7pzcNDcgJUpdKpfCj/5s4w==
X-Received: by 2002:a4a:ad8e:0:b0:5ba:f20c:361b with SMTP id 006d021491bc7-5c439286278mr14014241eaf.8.1720013394630;
        Wed, 03 Jul 2024 06:29:54 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:5b79:ebe0:e3cb:2ba6])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c414939fdcsm1524335eaf.25.2024.07.03.06.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:29:54 -0700 (PDT)
Date: Wed, 3 Jul 2024 15:29:52 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Datta Shubhrajyoti <shubhrajyoti@ti.com>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] staging: iio: frequency: ad9834: Validate frequency
 parameter value
Message-ID: <b7cc378d-11a8-44b6-a86f-baee12b5b1fa@suswa.mountain>
References: <20240703104734.12034-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703104734.12034-1-amishin@t-argos.ru>

On Wed, Jul 03, 2024 at 01:47:34PM +0300, Aleksandr Mishin wrote:
> In ad9834_write_frequency() clk_get_rate() can return 0. In such case
> ad9834_calc_freqreg() call will lead to division by zero. Checking
> 'if (fout > (clk_freq / 2))' doesn't protect in case of 'fout' is 0.
> ad9834_write_frequency() is called from ad9834_write(), where fout is
> taken from text buffer, which can contain any value.
> 
> Modify parameters checking.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 12b9d5bf76bf ("Staging: IIO: DDS: AD9833 / AD9834 driver")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/staging/iio/frequency/ad9834.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index a7a5cdcc6590..9e42129f44f7 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -114,7 +114,7 @@ static int ad9834_write_frequency(struct ad9834_state *st,
>  
>  	clk_freq = clk_get_rate(st->mclk);
>  
> -	if (fout > (clk_freq / 2))
> +	if (!fout || fout > (clk_freq / 2))

So you don't want "clk_freq" to be zero so you check if "fout" can be
zero and do the algebra?  That's a lot of acrobatics.  Just check
if clk_freq == 0 directly.

regards,
dan carpenter

>  		return -EINVAL;
>  
>  	regval = ad9834_calc_freqreg(clk_freq, fout);
> -- 
> 2.30.2
> 

