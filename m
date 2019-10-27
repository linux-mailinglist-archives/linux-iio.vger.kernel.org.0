Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A1AE6459
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2019 17:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfJ0Q44 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 12:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727237AbfJ0Q44 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Oct 2019 12:56:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 368592064A;
        Sun, 27 Oct 2019 16:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572195415;
        bh=gHohMleIoFYwg0z0pHAPsLAHFJMdlj1UdYdL+y5+OcM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EYmFXaVC00BvSUJ4Fj1jDi8uRsGQEEGj62V6NGeMLkZDBHymGY5n/e+8H1jRhMw5d
         aewHHfadBGFlzmNph+CSfHyulH5oriLcGkjFPnBhVdxWB7i5fupaPULvlvy2UVzHTD
         jPD0UK1cOa3JeqaKk7MdYbRxz/aKD0t1GH6iKZpw=
Date:   Sun, 27 Oct 2019 16:56:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jack Andersen <jackoalan@gmail.com>
Subject: Re: [PATCH] iio: dln2-adc: fix iio_triggered_buffer_postenable()
 position
Message-ID: <20191027165651.1da18263@archlinux>
In-Reply-To: <20191023082634.18195-1-alexandru.ardelean@analog.com>
References: <20191023082634.18195-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 23 Oct 2019 11:26:34 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The iio_triggered_buffer_postenable() hook should be called first to
> attach the poll function. The iio_triggered_buffer_predisable() hook is
> called last (as is it should).
> 
> This change moves iio_triggered_buffer_postenable() to be called first. It
> adds iio_triggered_buffer_predisable() on the error paths of the postenable
> hook.
> For the predisable hook, some code-paths have been changed to make sure
> that the iio_triggered_buffer_predisable() hook gets called in case there
> is an error before it.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
+CC Jack who wrote the driver.

Looks fine to me, but I always like these to sit for a while and ideally get
review from the authors / maintainers of the drivers.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/dln2-adc.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> index 5fa78c273a25..65c7c9329b1c 100644
> --- a/drivers/iio/adc/dln2-adc.c
> +++ b/drivers/iio/adc/dln2-adc.c
> @@ -524,6 +524,10 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
>  	u16 conflict;
>  	unsigned int trigger_chan;
>  
> +	ret = iio_triggered_buffer_postenable(indio_dev);
> +	if (ret)
> +		return ret;
> +
>  	mutex_lock(&dln2->mutex);
>  
>  	/* Enable ADC */
> @@ -537,6 +541,7 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
>  				(int)conflict);
>  			ret = -EBUSY;
>  		}
> +		iio_triggered_buffer_predisable(indio_dev);
>  		return ret;
>  	}
>  
> @@ -550,6 +555,7 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
>  		mutex_unlock(&dln2->mutex);
>  		if (ret < 0) {
>  			dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> +			iio_triggered_buffer_predisable(indio_dev);
>  			return ret;
>  		}
>  	} else {
> @@ -557,12 +563,12 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
>  		mutex_unlock(&dln2->mutex);
>  	}
>  
> -	return iio_triggered_buffer_postenable(indio_dev);
> +	return 0;
>  }
>  
>  static int dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
>  {
> -	int ret;
> +	int ret, ret2;
>  	struct dln2_adc *dln2 = iio_priv(indio_dev);
>  
>  	mutex_lock(&dln2->mutex);
> @@ -577,12 +583,14 @@ static int dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
>  	ret = dln2_adc_set_port_enabled(dln2, false, NULL);
>  
>  	mutex_unlock(&dln2->mutex);
> -	if (ret < 0) {
> +	if (ret < 0)
>  		dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> -		return ret;
> -	}
>  
> -	return iio_triggered_buffer_predisable(indio_dev);
> +	ret2 = iio_triggered_buffer_predisable(indio_dev);
> +	if (ret == 0)
> +		ret = ret2;
> +
> +	return ret;
>  }
>  
>  static const struct iio_buffer_setup_ops dln2_adc_buffer_setup_ops = {

