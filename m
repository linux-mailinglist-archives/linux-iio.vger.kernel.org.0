Return-Path: <linux-iio+bounces-4560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 786E08B4628
	for <lists+linux-iio@lfdr.de>; Sat, 27 Apr 2024 13:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E032289A48
	for <lists+linux-iio@lfdr.de>; Sat, 27 Apr 2024 11:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969FE4C3CD;
	Sat, 27 Apr 2024 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6dSXBrf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC154CB23
	for <linux-iio@vger.kernel.org>; Sat, 27 Apr 2024 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714217668; cv=none; b=i+6nS9rb1HFVCBSAeVhE6UOnDmYGxT0b54SNuKzzHDCUWUqCBt+qQKmlCSEjjW27hDRPHxK8NTdNzuX4ItWgr/XUP39fpNi+0bPdFAA+SZ+7W8/7iTIcmAbPHdoLt0qC39z21BjkaeLKycn7TtHhCQnsOez7AVhLOpI8DqB1ahE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714217668; c=relaxed/simple;
	bh=nVt4LZ18xuuBfcv1L11RF1axvXpUoeDtIw2LcNncef4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgWNoYjfEURblUCaOr1atB/+0iJDi7PCJCe4PNA8Ld5QEmxASnyaqV3AZbQpc/JBV1sC/4ajK/u87ycVoYdWlJERpEH7FhCnPx7E3clcR9Nqs9+mhJqSmGxwtGzLds4QU8Z/L2M4ScN1FqIcITXzhRwdejHMza1ka2gSWuGLRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6dSXBrf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso2151571b3a.1
        for <linux-iio@vger.kernel.org>; Sat, 27 Apr 2024 04:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714217666; x=1714822466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NCgm6whC0zZKuOCSNpau2rfV0njTlPTaGHctAufCGdU=;
        b=c6dSXBrf2wWuKkJW9mUceQ9yxBe6HAqAPxje/881o8lZ182LT1nQBV/UKlvpsXksrt
         H2iEhOO2QbFsGAn3GKevf9IrZa2fNsF3DvtLixBYaAjMTdp5QP8K2hSKvpo1Vc4XXKQZ
         7iL1U4HKDnKlVYGcXX2uqYnmSDcHoQzi/WIV7MwcBc/LvKJg2dn/TZhE0+afGqCpCZwg
         mojfmTazNymDqQkNm6fJIRlROGxRY8sXvromnjevJKKSL5jDHJrcRsLuNxEDVFR+Ls2H
         nyaxbmlyda6uRtzeSoR/CpQ4ZI+FJDMzi47qJjoCcQAri2GE8EqamViSKR8ZUkImrXCX
         MKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714217666; x=1714822466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCgm6whC0zZKuOCSNpau2rfV0njTlPTaGHctAufCGdU=;
        b=TJOqlMsKeliLV3GHG4TK0/eGTRLLrMVLauOwamHF5V1rXIrRdzjRh9By9QWIUrP6r5
         0i8aoLaXxS0gph2dNm8dLZ9MjMUxZVrYbVsgRnkvmktmSjJCUZN8fkXNEDRHD7nkvDfY
         8OFpvftTNRs8BU1APPAzVJnwtybYLE/Lk2u7Gs+Hn4s/sUvp7buwzbIduq6dmriSvVa0
         Bsnc55WbK0BnknlZfJnCgnU4rTmmtAafoNkw3wt6cJuBZGXW5a4qPWRDVVppUHXSFlie
         Y/Q8KbZJCe5JAL4QWdLTf0Zgjr9YUABgkHj7gwkEKkdoRcYo3/E7+WVpe0Paqe5WYGrp
         AI3A==
X-Forwarded-Encrypted: i=1; AJvYcCUP+HCmDrEyOEN3M4JY0ZejW5X7dTCXmYLQB9hp2c0RvpGV+QVAlW4x4PmQs0+f819P0PaaCzyZCszZhIzgTuQtiEa1T50y0+xQ
X-Gm-Message-State: AOJu0YytyhsJYu9n+u/Z9UlYz6YbOdTcv0s3xzFJms9pQW0V9p5+2njm
	aifM10gLKH9dCND31XWRlm014+JwN5xTsrZHF7byf3pYhxXKyzn56/ndnaIx
X-Google-Smtp-Source: AGHT+IEphfLLf68ZLnGC0XfZv8BNxtMXtcdLTznrH6u6hdcSxVFJ0RSGd4LzewVH19NxZovsa2cSdg==
X-Received: by 2002:a05:6a00:2e20:b0:6ed:de2c:77b9 with SMTP id fc32-20020a056a002e2000b006edde2c77b9mr3255485pfb.14.1714217666384;
        Sat, 27 Apr 2024 04:34:26 -0700 (PDT)
Received: from localhost ([2804:30c:1f6c:5400:ea32:e7c8:5bc0:103])
        by smtp.gmail.com with ESMTPSA id gx9-20020a056a001e0900b006eb3c2bde43sm16150564pfb.205.2024.04.27.04.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 04:34:25 -0700 (PDT)
Date: Sat, 27 Apr 2024 08:35:15 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Gabriel Schwartz <gschwartz@usp.br>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: rtq6056: Use automated cleanup for mode
 handling in write_raw
Message-ID: <Zizi89AJVo2MhWbc@debian-BULLSEYE-live-builder-AMD64>
References: <20240426200118.20900-1-gschwartz@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426200118.20900-1-gschwartz@usp.br>

Hi Gabriel,

Nice patch!

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

On 04/26, Gabriel Schwartz wrote:
> Using iio_device_claim_direct_scoped() to automate mode claim and release
> simplifies code flow and allows for straight-forward error handling with
> direct returns on errors.
> 
> Signed-off-by: Gabriel Schwartz <gschwartz@usp.br>
> ---
>  drivers/iio/adc/rtq6056.c | 34 +++++++++++-----------------------
>  1 file changed, 11 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
> index a5464737e..bcb129840 100644
> --- a/drivers/iio/adc/rtq6056.c
> +++ b/drivers/iio/adc/rtq6056.c
> @@ -520,32 +520,20 @@ static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
>  {
>  	struct rtq6056_priv *priv = iio_priv(indio_dev);
>  	const struct richtek_dev_data *devdata = priv->devdata;
> -	int ret;
>  
> -	ret = iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	switch (mask) {
> -	case IIO_CHAN_INFO_SAMP_FREQ:
> -		if (devdata->fixed_samp_freq) {
> -			ret = -EINVAL;
> -			break;
> +	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +		switch (mask) {
> +		case IIO_CHAN_INFO_SAMP_FREQ:
> +			if (devdata->fixed_samp_freq)
> +				return -EINVAL;
> +			return rtq6056_adc_set_samp_freq(priv, chan, val);
> +		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +			return devdata->set_average(priv, val);
> +		default:
> +			return -EINVAL;
>  		}
> -
> -		ret = rtq6056_adc_set_samp_freq(priv, chan, val);
> -		break;
> -	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		ret = devdata->set_average(priv, val);
> -		break;
> -	default:
> -		ret = -EINVAL;
> -		break;
>  	}
> -
> -	iio_device_release_direct_mode(indio_dev);
> -
> -	return ret;
> +	unreachable();
>  }
>  
>  static const char *rtq6056_channel_labels[RTQ6056_MAX_CHANNEL] = {
> -- 
> 2.44.0
> 
> 

