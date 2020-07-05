Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD87214C53
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jul 2020 14:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgGEMEv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Jul 2020 08:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGEMEv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Jul 2020 08:04:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 909A720720;
        Sun,  5 Jul 2020 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593950690;
        bh=BUvEgg07BsbzXg3xUAGWCHDXPCqYfHqTl28IwFSl+pg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lsfmCtH7zy+Zt7Vkxh2KOFSCuDm+h5ifkCUujzbsV4sZfHXOVSQPM5K+QvJ2k9uPr
         m7Ru62sfhBqXt1WQ0+6D+5GuCWzqee8Y8ud76VJTRGoJIdltxm4MrKUY6V+2YTOccY
         +/WAGjBxwv8W8ujZedNRhsK4xZtv2SGv2oF79hBQ=
Date:   Sun, 5 Jul 2020 13:04:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rachna@ti.com>, <mugunthanvnm@ti.com>, <vigneshr@ti.com>,
        <afd@ti.com>
Subject: Re: [PATCH 2/3] iio: adc: ti_am335x_adc: alloc kfifo & IRQ via
 devm_ functions
Message-ID: <20200705130446.2261f08c@archlinux>
In-Reply-To: <20200428111430.71723-2-alexandru.ardelean@analog.com>
References: <20200428111430.71723-1-alexandru.ardelean@analog.com>
        <20200428111430.71723-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Apr 2020 14:14:29 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change attaches the life-cycle of the kfifo buffer & IRQ to the
> parent-device. This in turn cleans up the exit & error paths, since we
> don't need to explicitly cleanup these resources.
> 
> The main intent here is to remove the explicit cleanup of the
> 'indio_dev->buffer' via 'iio_kfifo_free(indio_dev->buffer);'.
> 
> As we want to add support for multiple buffers per IIO device, having it
> exposed like this makes it tricky to consider a safe backwards compatible
> approach for it.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

> ---
>  drivers/iio/adc/ti_am335x_adc.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index d932fe383a24..03b2ab649cc3 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -377,7 +377,8 @@ static const struct iio_buffer_setup_ops tiadc_buffer_setup_ops = {
>  	.postdisable = &tiadc_buffer_postdisable,
>  };
>  
> -static int tiadc_iio_buffered_hardware_setup(struct iio_dev *indio_dev,
> +static int tiadc_iio_buffered_hardware_setup(struct device *dev,
> +	struct iio_dev *indio_dev,
>  	irqreturn_t (*pollfunc_bh)(int irq, void *p),
>  	irqreturn_t (*pollfunc_th)(int irq, void *p),
>  	int irq,
> @@ -387,13 +388,13 @@ static int tiadc_iio_buffered_hardware_setup(struct iio_dev *indio_dev,
>  	struct iio_buffer *buffer;
>  	int ret;
>  
> -	buffer = iio_kfifo_allocate();
> +	buffer = devm_iio_kfifo_allocate(dev);
>  	if (!buffer)
>  		return -ENOMEM;
>  
>  	iio_device_attach_buffer(indio_dev, buffer);
>  
> -	ret = request_threaded_irq(irq,	pollfunc_th, pollfunc_bh,
> +	ret = devm_request_threaded_irq(dev, irq, pollfunc_th, pollfunc_bh,
>  				flags, indio_dev->name, indio_dev);
>  	if (ret)
>  		goto error_kfifo_free;
> @@ -408,15 +409,6 @@ static int tiadc_iio_buffered_hardware_setup(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -static void tiadc_iio_buffered_hardware_remove(struct iio_dev *indio_dev)
> -{
> -	struct tiadc_device *adc_dev = iio_priv(indio_dev);
> -
> -	free_irq(adc_dev->mfd_tscadc->irq, indio_dev);
> -	iio_kfifo_free(indio_dev->buffer);
> -}
> -
> -
>  static const char * const chan_name_ain[] = {
>  	"AIN0",
>  	"AIN1",
> @@ -636,7 +628,7 @@ static int tiadc_probe(struct platform_device *pdev)
>  	if (err < 0)
>  		return err;
>  
> -	err = tiadc_iio_buffered_hardware_setup(indio_dev,
> +	err = tiadc_iio_buffered_hardware_setup(&pdev->dev, indio_dev,
>  		&tiadc_worker_h,
>  		&tiadc_irq_h,
>  		adc_dev->mfd_tscadc->irq,
> @@ -661,7 +653,6 @@ static int tiadc_probe(struct platform_device *pdev)
>  err_dma:
>  	iio_device_unregister(indio_dev);
>  err_buffer_unregister:
> -	tiadc_iio_buffered_hardware_remove(indio_dev);
>  err_free_channels:
>  	return err;
>  }
> @@ -679,7 +670,6 @@ static int tiadc_remove(struct platform_device *pdev)
>  		dma_release_channel(dma->chan);
>  	}
>  	iio_device_unregister(indio_dev);
> -	tiadc_iio_buffered_hardware_remove(indio_dev);
>  
>  	step_en = get_adc_step_mask(adc_dev);
>  	am335x_tsc_se_clr(adc_dev->mfd_tscadc, step_en);

