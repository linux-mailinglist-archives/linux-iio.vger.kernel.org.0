Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D574B479C93
	for <lists+linux-iio@lfdr.de>; Sat, 18 Dec 2021 21:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhLRUb0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Dec 2021 15:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhLRUb0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Dec 2021 15:31:26 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D2CC061574
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 12:31:26 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id m6so5663729qvh.10
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 12:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sqBkUvqCpl3JI3bfKaboQ0TmP+jdtXJN06+mOtzd+kI=;
        b=Spa+qk5zg4nwQ6opDDYuMnlb4NJ2/yvxGynNFDnn30Eoz+mk5uLcuaTimciYmhucrG
         EBkm7io/Kc7GwF1HDkhULNUI5jxbWD8PgBrzRj9esYmTeWVnJUViti4m6TUQK5la4gKI
         xm7WiO+8H8iJzB1I96w9Q6lbIFG5ZDVZA8iYWLum9coYEHMOtp4yAGwQcMJjNIAjEO4F
         PrMLgmU4q3LTRLYeonNrm4fSEDxdcXi8iIZoJ/w2rKa0ieUSpoqig6O+FlybkBSKAL4w
         G500TpBNANeeFYZjc9fgZcOt0EItoLvJUiJEjZ0dbu7+s25DStRP5GuHCHJe7qqnmR8B
         7KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sqBkUvqCpl3JI3bfKaboQ0TmP+jdtXJN06+mOtzd+kI=;
        b=KltQ8KwkfH3VO2O0f7wys/t5uzsO+OFgwNpoYdM1AzZ+SIggdls8PH5XBhYUeUHvOR
         qFjMro22NyarSckb0eMoodFsS1i5y9lqmfTOQ/z/2HVJtD7CLAMEwBSrhPS3oKbiY9n9
         nX1pkEXClSyg9V7diRtrYhvJY+IUZlwm3NYRj79poFammglhG5LK9dSUFiKnEEWpeinN
         ruV2sGFlykypmfHqsIBQ5HPpXtPE9EAnUJjBYN7w5P4uztieIri0+m2zvD7qeyHcqcmS
         MdNANrVUZftyxqO5c2M4O482EDQ771HbJRrYRaMEu3dGHKd4efT06xvrw6zKszLl/LxM
         fJvg==
X-Gm-Message-State: AOAM532HkOsn5NQbt41eTxkIot7unNFf8obYGzywBm45xaXrzhBgd+m4
        gZvGj+hUNLPS3Y/1RdpSBoTsCXTfMlc=
X-Google-Smtp-Source: ABdhPJxMa4DU+5UfV8Mytj2oAsUniTRe5kdBOEIUTggwEyOAgXV7cy7evmUGt8uMGCeCr8xT4Q69CQ==
X-Received: by 2002:a05:6214:e4c:: with SMTP id o12mr7592914qvc.60.1639859485572;
        Sat, 18 Dec 2021 12:31:25 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b14:b100:c080:51c0:2de2:c68a])
        by smtp.gmail.com with ESMTPSA id i11sm7365124qko.116.2021.12.18.12.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 12:31:25 -0800 (PST)
Date:   Sat, 18 Dec 2021 17:31:17 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 13/17] staging:iio:adc:ad7280a: Use a local dev
 pointer to avoid &spi->dev
Message-ID: <Yb5FFVAxrW8VD8Ya@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
 <20211205202710.2847005-14-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205202710.2847005-14-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/05, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> We use this a few times already and it is about to get worse, so
> introduce a local variable to simplify things.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> ---
>  drivers/staging/iio/adc/ad7280a.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index b4ba6da07af9..acaae1b33986 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -940,11 +940,12 @@ static const struct ad7280_platform_data ad7793_default_pdata = {
>  static int ad7280_probe(struct spi_device *spi)
>  {
>  	const struct ad7280_platform_data *pdata = dev_get_platdata(&spi->dev);
> +	struct device *dev = &spi->dev;
>  	struct ad7280_state *st;
>  	int ret;
>  	struct iio_dev *indio_dev;
>  
> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> @@ -976,7 +977,7 @@ static int ad7280_probe(struct spi_device *spi)
>  	st->aux_threshhigh = 0xFF;
>  	st->acquisition_time = pdata->acquisition_time;
>  
> -	ret = devm_add_action_or_reset(&spi->dev, ad7280_sw_power_down, st);
> +	ret = devm_add_action_or_reset(dev, ad7280_sw_power_down, st);
>  	if (ret)
>  		return ret;
>  
> @@ -1005,7 +1006,7 @@ static int ad7280_probe(struct spi_device *spi)
>  		if (ret)
>  			return ret;
>  
> -		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
> +		ret = devm_request_threaded_irq(dev, spi->irq,
>  						NULL,
>  						ad7280_event_handler,
>  						IRQF_TRIGGER_FALLING |
> @@ -1020,7 +1021,7 @@ static int ad7280_probe(struct spi_device *spi)
>  		indio_dev->info = &ad7280_info_no_irq;
>  	}
>  
> -	return devm_iio_device_register(&spi->dev, indio_dev);
> +	return devm_iio_device_register(dev, indio_dev);
>  }
>  
>  static const struct spi_device_id ad7280_id[] = {
> -- 
> 2.34.1
> 
