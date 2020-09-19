Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEA3270EE1
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 17:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgISPTp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 11:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgISPTp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 11:19:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D51C92098B;
        Sat, 19 Sep 2020 15:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600528784;
        bh=2jK1ssTfxonKsXGsA+rUttXem8uaqAD3aZO3hv6lPoU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HzWh81QkND0fpvLhLaPhfuWwiRnWb1REwy+KTyzP4BIq3JX2EcBo1vTRcTvcybibD
         est5eE1jQrc62/r1CW0zeLNywMOYLaYjohOFZjJf6lTCyigck0MqcS233xf0Z2wNHH
         SqWry9cB+Ecx5n3nZ22muk9rYkfCpBKhV87WOnV4=
Date:   Sat, 19 Sep 2020 16:19:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kgene@kernel.org>,
        <krzk@kernel.org>, Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH v2] iio: adc: exynos_adc: Replace indio_dev->mlock with
 own device lock
Message-ID: <20200919161939.374bac95@archlinux>
In-Reply-To: <20200916093123.78954-1-alexandru.ardelean@analog.com>
References: <20200826132203.236748-1-alexandru.ardelean@analog.com>
        <20200916093123.78954-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Sep 2020 12:31:23 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock, to protect potential concurrent access to the
> completion callback during a conversion.
> 
> This is part of a bigger cleanup.
> Link: https://lore.kernel.org/linux-iio/CA+U=Dsoo6YABe5ODLp+eFNPGFDjk5ZeQEceGkqjxXcVEhLWubw@mail.gmail.com/
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/exynos_adc.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index 20477b249f2a..99f4404e9fd1 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -138,6 +138,16 @@ struct exynos_adc {
>  	bool			read_ts;
>  	u32			ts_x;
>  	u32			ts_y;
> +
> +	/*
> +	 * Lock to protect from potential concurrent access to the
> +	 * completion callback during a manual conversion. For this driver
> +	 * a wait-callback is used to wait for the conversion result,
> +	 * so in the meantime no other read request (or conversion start)
> +	 * must be performed, otherwise it would interfere with the
> +	 * current conversion result.
> +	 */
> +	struct mutex		lock;
>  };
>  
>  struct exynos_adc_data {
> @@ -542,7 +552,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
>  		return -EINVAL;
>  	}
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&info->lock);
>  	reinit_completion(&info->completion);
>  
>  	/* Select the channel to be used and Trigger conversion */
> @@ -562,7 +572,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
>  		ret = IIO_VAL_INT;
>  	}
>  
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&info->lock);
>  
>  	return ret;
>  }
> @@ -573,7 +583,7 @@ static int exynos_read_s3c64xx_ts(struct iio_dev *indio_dev, int *x, int *y)
>  	unsigned long timeout;
>  	int ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&info->lock);
>  	info->read_ts = true;
>  
>  	reinit_completion(&info->completion);
> @@ -598,7 +608,7 @@ static int exynos_read_s3c64xx_ts(struct iio_dev *indio_dev, int *x, int *y)
>  	}
>  
>  	info->read_ts = false;
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&info->lock);
>  
>  	return ret;
>  }
> @@ -868,6 +878,8 @@ static int exynos_adc_probe(struct platform_device *pdev)
>  	indio_dev->channels = exynos_adc_iio_channels;
>  	indio_dev->num_channels = info->data->num_channels;
>  
> +	mutex_init(&info->lock);
> +
>  	ret = request_irq(info->irq, exynos_adc_isr,
>  					0, dev_name(&pdev->dev), info);
>  	if (ret < 0) {

