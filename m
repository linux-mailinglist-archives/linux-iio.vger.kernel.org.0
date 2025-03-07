Return-Path: <linux-iio+bounces-16524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB611A56967
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 14:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD9217567E
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 13:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EAD21ADC5;
	Fri,  7 Mar 2025 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4kO8eNT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00721ABA6;
	Fri,  7 Mar 2025 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355500; cv=none; b=JZxe0Q57i8dXvTt/TD7a3FXKoEoTlfPJkNOAu2zwPRFqFbKJ0+HocXMf8dbUGJJJKhj+z5A72m5BRzKPfJiixWHIHQUFfxpoyJsw4RqdHepLSv3PUXXER+0TvXalUnpnf0QPt+Vo47G7GGC7oKOEe1CVBzH5712V8inwYPNbXYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355500; c=relaxed/simple;
	bh=P92GJowE3+xop7nioIlnBSiVvcN8Lu72zS16CGODbKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ek7dBbc1VB1afpCNDBoUYjIjA9x9ERkIwhEi4h9tYNy7WoRtK34DnJc2weBkDeQp1aVjBOQ5tp3tujcT7yNdgVFkq9OLQ6XcF4h5xpLt3cyEKP9QTdM1RJdQl2MG+UYgTE/byxi35CfgvgpajJrhP79FciFe4fiU8yck8BxvoWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4kO8eNT; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so3400817a91.3;
        Fri, 07 Mar 2025 05:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741355498; x=1741960298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GsYXGuW9uswGocW86oiWeIN4F7hDphJu+gAUcgsVqKc=;
        b=e4kO8eNTyWKGQC4Gr3N944KHw3m4eazWQ9N5ZGJT6vnbsEVZhbl23KlYgdTNckzb67
         K3ZRLQ3piNmWT1fbdppoQ47WXqCip5Wb+JET6XMoPZP104A4Hsd3e7SXRUdoD4h3gJpu
         7W56f0cT9HxSWEW0FpuxHBEeV5eeLq/BncMTWP5cfuZ54XRq+TBkHTPt53hdfuy/rfaK
         dISY9jdQN76KYRGcyMVNUDUWeNw0XVqHDjEQZNjYkrkgqVr02nj36c3q0oKO4Ucx+rJT
         SRv3hM/2VgWuTvdmIVaWAyVrgmOsqaQ1LCXFaGolUwNvaqnOD/IIHrQTXUObW7CqYGzn
         KHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741355498; x=1741960298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsYXGuW9uswGocW86oiWeIN4F7hDphJu+gAUcgsVqKc=;
        b=Frs1RXPL3Ou+cM7jmB/rcb9G/opl7fzmyWJuQZTyEMkDHiMleiqQwtUkulMFC5TQqM
         E9ddZTZhpIhuHpDarJrb+uF7UsuIyK9PAWsYPtHPxykcU4JKSLMnHtFmpfj0eG8tk0Gf
         4pO5wX4ygCdQp7kHBbFvcDdQvIiEvdnxlBSrISvN7ZHZWsKYA2t3LRhai2gxM2H149qb
         7gwdxUC00qFc6UB6atGyOTNl1m0zOZP2iaevgW2SXleXk/DepPlV0uKiqk98UOQnI8TL
         OEpeCZZYyic8FxLxMGBlU/1TT0Ypq0D+EOEKz3XbNgx5wvol9xmCr0eOubsfixqfPzQH
         nbMg==
X-Forwarded-Encrypted: i=1; AJvYcCWG0o2QiLfUiGxk0cCeoS+NYeYpdiQr1Y7ozFG7u9alZPqh3EbLmLeH5dhRHBVb2L5MAV2rs/1vDQ4R@vger.kernel.org, AJvYcCX/EpofVely2XnqF3QnkOWzU1IVh1Qfi44NTyORolBszxB/qMYTxBmAcvNrHcYz+cpvgKrx53KcjAtmKw==@vger.kernel.org, AJvYcCXvFcqtaNniZoBbXU+vKB9blGylv9660sZxBxjKu1ZCvTLUXSyRoBY6Fo5w8zxzwGRffKFGjueCNsoR/AIh@vger.kernel.org
X-Gm-Message-State: AOJu0YwG4M//lPRMew+QY5VWj8bWjjnwnf7UzcWGh1+Ak8W2v9WtjHyt
	xoX/o1Up5A0gqX04W2RmJZhyF2e5eSisWZiGe/oAUjryLYQOTTB4
X-Gm-Gg: ASbGncupIxJz8rluu0QzPM5b1C3reKQhUzAvYpUK5xb0SQF+q5onJsA1ksH6Rwi+xvA
	WkveOaK8fLQpqCH1qOR0ucD+VE5ckmLvaOsP1ac4MCFpFCJ8gA8QzmDi4WigmF4PegM27jrCZgP
	g0ogUQ2hlfYM/s6JPqmjhJcPTaNLKKuiIoBus7FWlZR4NDitvrOo172nS6F9uu6Jq5Guiq2m8it
	O2+589JrZNsK+PYMZ6GdH/9R7ryD2IyzUPwjOL+UvTwn4tnrcKjylFmsEvvF3nqGC5zqwAL92Dn
	pxo2OdAds9x/ofCzHxRma1liKT6IQoiDyPI9XMIT4KZ7RMfju5e/qw==
X-Google-Smtp-Source: AGHT+IG111djafDJeUEZJzxG4Q6hK3LuycWp707Rg+oLSJoKZFiWESbFt8TBFWsdR/+ya+3HFFV8Ow==
X-Received: by 2002:a17:90a:d2c6:b0:2ff:6608:78e2 with SMTP id 98e67ed59e1d1-2ff7cea99b3mr6342874a91.16.1741355498482;
        Fri, 07 Mar 2025 05:51:38 -0800 (PST)
Received: from localhost ([2804:30c:1f21:4300:1cf6:c485:6555:b1c5])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff693e73b9sm3033124a91.38.2025.03.07.05.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:51:37 -0800 (PST)
Date: Fri, 7 Mar 2025 10:52:31 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	lgirdwood@gmail.com, broonie@kernel.org, dlechner@baylibre.com,
	jonath4nns@gmail.com
Subject: Re: [PATCH v4 10/17] iio: adc: ad7768-1: Move buffer allocation to a
 separate function
Message-ID: <Z8r6H40mTKO_QF9Y@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
 <d078cdcf3a8bdd60ec3b9b6822e9705bf3f98bfa.1741268122.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d078cdcf3a8bdd60ec3b9b6822e9705bf3f98bfa.1741268122.git.Jonathan.Santos@analog.com>

On 03/06, Jonathan Santos wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> This change moves the buffer allocation in a separate function, making
> space for adding another type of iio buffer if needed.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
LGTM

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

> v4 Changes:
> * None.
> 
> v3 Changes:
> * Added missing SoB.
> 
> v2 Changes:
> * Interrupt and completion moved out from ad7768_triggered_buffer_alloc(). 
> ---
>  drivers/iio/adc/ad7768-1.c | 44 ++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 86f44d28c478..e88e9431bb7a 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -619,6 +619,31 @@ static int ad7768_set_channel_label(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> +static int ad7768_triggered_buffer_alloc(struct iio_dev *indio_dev)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	st->trig = devm_iio_trigger_alloc(indio_dev->dev.parent, "%s-dev%d",
> +					  indio_dev->name,
> +					  iio_device_id(indio_dev));
> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops = &ad7768_trigger_ops;
> +	iio_trigger_set_drvdata(st->trig, indio_dev);
> +	ret = devm_iio_trigger_register(indio_dev->dev.parent, st->trig);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
> +					       &iio_pollfunc_store_time,
> +					       &ad7768_trigger_handler,
> +					       &ad7768_buffer_ops);
> +}
> +
>  static int ad7768_probe(struct spi_device *spi)
>  {
>  	struct ad7768_state *st;
> @@ -689,20 +714,6 @@ static int ad7768_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> -	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> -					  indio_dev->name,
> -					  iio_device_id(indio_dev));
> -	if (!st->trig)
> -		return -ENOMEM;
> -
> -	st->trig->ops = &ad7768_trigger_ops;
> -	iio_trigger_set_drvdata(st->trig, indio_dev);
> -	ret = devm_iio_trigger_register(&spi->dev, st->trig);
> -	if (ret)
> -		return ret;
> -
> -	indio_dev->trig = iio_trigger_get(st->trig);
> -
>  	init_completion(&st->completion);
>  
>  	ret = ad7768_set_channel_label(indio_dev, ARRAY_SIZE(ad7768_channels));
> @@ -716,10 +727,7 @@ static int ad7768_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> -					      &iio_pollfunc_store_time,
> -					      &ad7768_trigger_handler,
> -					      &ad7768_buffer_ops);
> +	ret = ad7768_triggered_buffer_alloc(indio_dev);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.34.1
> 

