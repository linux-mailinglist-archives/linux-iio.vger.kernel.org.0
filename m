Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D6B279A8B
	for <lists+linux-iio@lfdr.de>; Sat, 26 Sep 2020 17:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbgIZPzz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Sep 2020 11:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729570AbgIZPzz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 26 Sep 2020 11:55:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D5D6207D8;
        Sat, 26 Sep 2020 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601135754;
        bh=LeOuaawcgaWdaoGVCQeecPE0zOwmA8UVkFZ/3GJAbjU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gYfxmpkShgaW0niKHFRUuccauDW3BKWVWuvDeWLwU2mYWU4sV27mSCWVU7joJK+u2
         N2PAutRzoYLcbjRSo+I2GxThxApQ6PIywFf+benV/N0GMeT4uihquDH56uFDANjslI
         naSQkbSz4cA1GRcMapiprPlTprCefZbBvwgLtvBE=
Date:   Sat, 26 Sep 2020 16:55:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <eugen.hristev@microchip.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: merge buffer & trigger init
 into a function
Message-ID: <20200926165549.23dc420b@archlinux>
In-Reply-To: <20200924102902.136169-1-alexandru.ardelean@analog.com>
References: <20200924102902.136169-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Sep 2020 13:29:02 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change is mostly cosmetic, but it's also a pre-cursor to the
> the change for 'iio_buffer_set_attrs()', where the helper gets updated to
> better support multiple IIO buffers for 1 IIO device.
> 
> The only functional change is that the error message for the trigger alloc
> failure is bound to the parent device vs the IIO device object.
> 
> Also, the new at91_adc_buffer_and_trigger_init() function was moved after
> the definition of the 'at91_adc_fifo_attributes'.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Looks fine to me, but will let this sit on the list for a while
so others have time to comment.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 78 ++++++++++++++----------------
>  1 file changed, 36 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index ad7d9819f83c..b9c3cc6d5913 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1014,21 +1014,6 @@ static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *indio,
>  
>  	return trig;
>  }
> -
> -static int at91_adc_trigger_init(struct iio_dev *indio)
> -{
> -	struct at91_adc_state *st = iio_priv(indio);
> -
> -	st->trig = at91_adc_allocate_trigger(indio, st->selected_trig->name);
> -	if (IS_ERR(st->trig)) {
> -		dev_err(&indio->dev,
> -			"could not allocate trigger\n");
> -		return PTR_ERR(st->trig);
> -	}
> -
> -	return 0;
> -}
> -
>  static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
>  					   struct iio_poll_func *pf)
>  {
> @@ -1156,13 +1141,6 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> -static int at91_adc_buffer_init(struct iio_dev *indio)
> -{
> -	return devm_iio_triggered_buffer_setup(&indio->dev, indio,
> -		&iio_pollfunc_store_time,
> -		&at91_adc_trigger_handler, &at91_buffer_setup_ops);
> -}
> -
>  static unsigned at91_adc_startup_time(unsigned startup_time_min,
>  				      unsigned adc_clk_khz)
>  {
> @@ -1683,6 +1661,40 @@ static const struct iio_info at91_adc_info = {
>  	.hwfifo_set_watermark = &at91_adc_set_watermark,
>  };
>  
> +static int at91_adc_buffer_and_trigger_init(struct device *dev,
> +					    struct iio_dev *indio)
> +{
> +	struct at91_adc_state *st = iio_priv(indio);
> +	int ret;
> +
> +	ret = devm_iio_triggered_buffer_setup(&indio->dev, indio,
> +		&iio_pollfunc_store_time,
> +		&at91_adc_trigger_handler, &at91_buffer_setup_ops);
> +	if (ret < 0) {
> +		dev_err(dev, "couldn't initialize the buffer.\n");
> +		return ret;
> +	}
> +
> +	if (!st->selected_trig->hw_trig)
> +		return 0;
> +
> +	iio_buffer_set_attrs(indio->buffer, at91_adc_fifo_attributes);
> +
> +	st->trig = at91_adc_allocate_trigger(indio, st->selected_trig->name);
> +	if (IS_ERR(st->trig)) {
> +		dev_err(dev, "could not allocate trigger\n");
> +		return PTR_ERR(st->trig);
> +	}
> +
> +	/*
> +	 * Initially the iio buffer has a length of 2 and
> +	 * a watermark of 1
> +	 */
> +	st->dma_st.watermark = 1;
> +
> +	return 0;
> +}
> +
>  static int at91_adc_probe(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev;
> @@ -1818,27 +1830,9 @@ static int at91_adc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> -	ret = at91_adc_buffer_init(indio_dev);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "couldn't initialize the buffer.\n");
> +	ret = at91_adc_buffer_and_trigger_init(&pdev->dev, indio_dev);
> +	if (ret < 0)
>  		goto per_clk_disable_unprepare;
> -	}
> -
> -	if (st->selected_trig->hw_trig) {
> -		ret = at91_adc_trigger_init(indio_dev);
> -		if (ret < 0) {
> -			dev_err(&pdev->dev, "couldn't setup the triggers.\n");
> -			goto per_clk_disable_unprepare;
> -		}
> -		/*
> -		 * Initially the iio buffer has a length of 2 and
> -		 * a watermark of 1
> -		 */
> -		st->dma_st.watermark = 1;
> -
> -		iio_buffer_set_attrs(indio_dev->buffer,
> -				     at91_adc_fifo_attributes);
> -	}
>  
>  	if (dma_coerce_mask_and_coherent(&indio_dev->dev, DMA_BIT_MASK(32)))
>  		dev_info(&pdev->dev, "cannot set DMA mask to 32-bit\n");

