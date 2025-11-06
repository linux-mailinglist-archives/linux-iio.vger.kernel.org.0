Return-Path: <linux-iio+bounces-25971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF00C3C054
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 16:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74541564D9C
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 15:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5E62222C8;
	Thu,  6 Nov 2025 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zfjtctJI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F811AB6F1
	for <linux-iio@vger.kernel.org>; Thu,  6 Nov 2025 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442171; cv=none; b=C6mIZl7c2hpSZvimhA8nQ+PnVCRAJVTY1f2XFUr/DWNj/UASsq8ShKf/rM91/HNgSnjv5xu+GSDj2nDGnqhzQkkOIJp9O8ZtUgNv8V84OCcHbp6qlYvRlt0IS5uL9UNQgIlKNVeku1Q62pkSuqb92tJSwAdqko8zjecqO9dqnwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442171; c=relaxed/simple;
	bh=41zrFfEL2l2XQ63gU+qhrRtQA3Ib9OhNjrgYj07OAIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFOFz/3Mt7GE0GeGo6sktuQejsXx7XJ1IOdK5Hx15uhCenuJA9aVZ2f8mHzLbA30PBJFRmvlypiCYf5ab53dbXcU+8SscFQi1ZM/wrhsvJBUg/tyuUwnTIQDTupD9jcpCI2Qwhmx251U+zFzHXVIOYid+NGrnKSPc5LL9bjWjOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zfjtctJI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7291af7190so142568266b.3
        for <linux-iio@vger.kernel.org>; Thu, 06 Nov 2025 07:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762442168; x=1763046968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u14FmWvrKmKOUArfGYUhEF2EQY6v0Fb3SsmeCkhwUFM=;
        b=zfjtctJIwwNY5wZF9bcH90FsR/wdhHbdAIAETM1W6yZxKXSf0Ugqsh5mlgRRdt95Pq
         lVkM34/AWkPAstaf89flf17ltRQshX9HCwTF3evDDbtHU06x/d0IIgNZcKOlC0FYrWCP
         h3E0XKPSKi/yWRsVFjh3+L94FxR3367k0hsrauv70lT+0lEIriQMWR2nQEWUL8ks2mwE
         QsiFXUh+RKg4l9yH0CzemEHFEGCr1UgKXP60aHcvXrOE2MLgYNfKIoNM1v6qieW5LuyP
         6DMBtToEkmAbU26GToNIjviMcZr2xz2dcFaqB8zrSnFoFyf0BqfLY+CmEdc1DnsskPS7
         pnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762442168; x=1763046968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u14FmWvrKmKOUArfGYUhEF2EQY6v0Fb3SsmeCkhwUFM=;
        b=bdRvZWXb1GxcvRNGV2k67SSMF5p6DpO/sAwvJOTONEPBrJXJm418jKRQixOC7TPH/a
         8IlIImLniGhWhSKHIscA8v2W9PYVeOWpOr+bKtL/a9NHbCVHYvjh/K/Ce1956S/Cu1m+
         oehM0WeAd8PDSFAzjuv4nSKuI3rZPiSQEfaJ9kDj5WlHEtJIsUeqLVah8pgYX5P99khE
         j/zYlnH/IgDpw4sXl52fUySjBVLjTDE974OTI33Js+xd4vkdWvkiEjPe57M8l06/MDOy
         +sX/z4B22yT7RrxXKiPP7C8ONXX+4ueO0ULU1TvtgiNWD8mQnv7dme9nhCRF64BQ9vo3
         CepA==
X-Forwarded-Encrypted: i=1; AJvYcCX6CjRLngXvmgHSrknrK3FomkYrZMogwIy9k6LqBgWvDaZUf8EsO4kjq1cLWZzSASdZ9O85FXS8zHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6pYERNqcfMg1vOP1A92bLblcSfHjCvUDZLnJF7espyRM0dx8M
	/1QgAy6pT+kEem3I6I3ETSoFoVCrXy4fJB6zWDXpz88hcmEypmT/hh+jUb0fJ3ZPQAU=
X-Gm-Gg: ASbGncsZaTdTA7zgxSBJVkRlXVyO2vXyOBkdf8yyDIPjMkVX7xImo5xKbkhJ1ktvmf4
	/Yc8DGezsX0/21V96b5WzMFfHlGxQKeN0Gyf3RAUll9T4SERCXRyyiwoGo0pXGFHK+SQzaiJk/p
	kkYpTRufMPDyxbg7zZZoO0aH9dvH6l+gkX7p1lxsLCbw8Dfz5iXhjoKZuB7Up7xdtqqINAWmOWY
	Fzn1gqpWYtZKeputIOpQ956gQPpuwnVHi6Sjd1RjCwtErrU5wsDAHUmmh7rcS7TMdXcdP/GMxYO
	y8nkjZkQNe2oj5Nwsy3h3h4OQKgSFWTBJnxTY8+QL2d1Ggn7Fq8/zZBaJ1HnpeFAxH35l9TWIrQ
	+klC4lbIwI1b0pK9OkXg51EFn3cLgKE8J1xNLcvZDZNntK+Hs6ETHtnqXHblWwBEw4sf25s4PBV
	MwrXa1bQD80dLb
X-Google-Smtp-Source: AGHT+IEf7wBLuEfCRt4j+/RlzPZKjUAiSvKjoVNYNm2utzq6YqdxRCDzqeo4lC5zRpb3wTnkArDt4w==
X-Received: by 2002:a17:906:f59b:b0:b71:51b:bd4c with SMTP id a640c23a62f3a-b726554bb96mr724343966b.50.1762442168333;
        Thu, 06 Nov 2025 07:16:08 -0800 (PST)
Received: from localhost ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b728937cc60sm236069866b.16.2025.11.06.07.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:16:07 -0800 (PST)
Date: Thu, 6 Nov 2025 18:16:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, error27@gmail.com, andriy.shevchenko@intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: trigger: Fix error handling in viio_trigger_alloc
Message-ID: <74993472-4845-42d5-8b50-8fa8dc5b42fa@suswa.mountain>
References: <20251106082923.32688-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106082923.32688-1-make24@iscas.ac.cn>

On Thu, Nov 06, 2025 at 04:29:23PM +0800, Ma Ke wrote:
> ---
> Changes in v2:
> - modified the patch, thanks for developer's suggestions.
> ---
>  drivers/iio/industrialio-trigger.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 54416a384232..9f6d30a244d9 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -524,6 +524,7 @@ static void iio_trig_release(struct device *device)
>  			       CONFIG_IIO_CONSUMERS_PER_TRIGGER);
>  	}
>  	kfree(trig->name);
> +	mutex_destroy(&trig->pool_lock);
>  	kfree(trig);
>  }
>  
> @@ -596,8 +597,9 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
>  
>  free_descs:
>  	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> +	trig->subirq_base = 0;

This doesn't work.  Do it before the goto.

regards,
dan carpenter

>  free_trig:
> -	kfree(trig);
> +	put_device(&trig->dev);
>  	return NULL;
>  }
>  
> -- 
> 2.17.1

