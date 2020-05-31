Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49281E982F
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 16:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgEaOmV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 10:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgEaOmV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 10:42:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C5212074A;
        Sun, 31 May 2020 14:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590936140;
        bh=GAx+82x99RdNgWYjm/WCxDyQXCQkvjhfbgexOhhOB3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dZNHdeWnx0Wc0K67qxYEMFURXe7FKEgRg2IEbIggix6JT8xKPauw8n8SPDdwryocn
         ohj88wf9R8gKp/O9t7k4H1JxxrXwn6W2rDVDFgdHMoeQLeAal095OtJUWCef1KDqv5
         sA6FRITJfMR+bGpS/1nYcL6ZUpRpZZUz3/T8ORHw=
Date:   Sun, 31 May 2020 15:42:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] iio: at91_adc: remove usage of iio_priv_to_dev() helper
Message-ID: <20200531154216.361285c6@archlinux>
In-Reply-To: <20200525102513.130664-1-alexandru.ardelean@analog.com>
References: <20200525102513.130664-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 May 2020 13:25:13 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> We may want to get rid of the iio_priv_to_dev() helper. The reason is that
> we will hide some of the members of the iio_dev structure (to prevent
> drivers from accessing them directly), and that will also mean hiding the
> implementation of the iio_priv_to_dev() helper inside the IIO core.
> 
> Hiding the implementation of iio_priv_to_dev() implies that some fast-paths
> may not be fast anymore, so a general idea is to try to get rid of the
> iio_priv_to_dev() altogether.
> The iio_priv() helper won't be affected by the rework, as the iio_dev
> struct will keep a reference to the private information.
> 
> For this driver, not using iio_priv_to_dev(), means reworking some paths to
> pass the iio device and using iio_priv() to access the private information.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Looks good to me.  Will leave it a bit longer though to potentially
get some people more familiar with the driver to sanity check it.

Poke me after the usual couple of weeks if I seem to have lost it
down the back of the sofa.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91_adc.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 0368b6dc6d60..896af58e88bc 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -287,13 +287,13 @@ static void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
>  	}
>  }
>  
> -static int at91_ts_sample(struct at91_adc_state *st)
> +static int at91_ts_sample(struct iio_dev *idev)
>  {
> +	struct at91_adc_state *st = iio_priv(idev);
>  	unsigned int xscale, yscale, reg, z1, z2;
>  	unsigned int x, y, pres, xpos, ypos;
>  	unsigned int rxp = 1;
>  	unsigned int factor = 1000;
> -	struct iio_dev *idev = iio_priv_to_dev(st);
>  
>  	unsigned int xyz_mask_bits = st->res;
>  	unsigned int xyz_mask = (1 << xyz_mask_bits) - 1;
> @@ -449,7 +449,7 @@ static irqreturn_t at91_adc_9x5_interrupt(int irq, void *private)
>  
>  		if (status & AT91_ADC_ISR_PENS) {
>  			/* validate data by pen contact */
> -			at91_ts_sample(st);
> +			at91_ts_sample(idev);
>  		} else {
>  			/* triggered by event that is no pen contact, just read
>  			 * them to clean the interrupt and discard all.
> @@ -737,10 +737,10 @@ static int at91_adc_read_raw(struct iio_dev *idev,
>  	return -EINVAL;
>  }
>  
> -static int at91_adc_of_get_resolution(struct at91_adc_state *st,
> +static int at91_adc_of_get_resolution(struct iio_dev *idev,
>  				      struct platform_device *pdev)
>  {
> -	struct iio_dev *idev = iio_priv_to_dev(st);
> +	struct at91_adc_state *st = iio_priv(idev);
>  	struct device_node *np = pdev->dev.of_node;
>  	int count, i, ret = 0;
>  	char *res_name, *s;
> @@ -866,10 +866,10 @@ static int at91_adc_probe_dt_ts(struct device_node *node,
>  	}
>  }
>  
> -static int at91_adc_probe_dt(struct at91_adc_state *st,
> +static int at91_adc_probe_dt(struct iio_dev *idev,
>  			     struct platform_device *pdev)
>  {
> -	struct iio_dev *idev = iio_priv_to_dev(st);
> +	struct at91_adc_state *st = iio_priv(idev);
>  	struct device_node *node = pdev->dev.of_node;
>  	struct device_node *trig_node;
>  	int i = 0, ret;
> @@ -910,7 +910,7 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
>  	}
>  	st->vref_mv = prop;
>  
> -	ret = at91_adc_of_get_resolution(st, pdev);
> +	ret = at91_adc_of_get_resolution(idev, pdev);
>  	if (ret)
>  		goto error_ret;
>  
> @@ -1010,9 +1010,9 @@ static void atmel_ts_close(struct input_dev *dev)
>  		at91_adc_writel(st, AT91_ADC_IDR, AT91RL_ADC_IER_PEN);
>  }
>  
> -static int at91_ts_hw_init(struct at91_adc_state *st, u32 adc_clk_khz)
> +static int at91_ts_hw_init(struct iio_dev *idev, u32 adc_clk_khz)
>  {
> -	struct iio_dev *idev = iio_priv_to_dev(st);
> +	struct at91_adc_state *st = iio_priv(idev);
>  	u32 reg = 0;
>  	u32 tssctim = 0;
>  	int i = 0;
> @@ -1085,11 +1085,11 @@ static int at91_ts_hw_init(struct at91_adc_state *st, u32 adc_clk_khz)
>  	return 0;
>  }
>  
> -static int at91_ts_register(struct at91_adc_state *st,
> +static int at91_ts_register(struct iio_dev *idev,
>  		struct platform_device *pdev)
>  {
> +	struct at91_adc_state *st = iio_priv(idev);
>  	struct input_dev *input;
> -	struct iio_dev *idev = iio_priv_to_dev(st);
>  	int ret;
>  
>  	input = input_allocate_device();
> @@ -1161,7 +1161,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	st = iio_priv(idev);
>  
>  	if (pdev->dev.of_node)
> -		ret = at91_adc_probe_dt(st, pdev);
> +		ret = at91_adc_probe_dt(idev, pdev);
>  	else
>  		ret = at91_adc_probe_pdata(st, pdev);
>  
> @@ -1301,11 +1301,11 @@ static int at91_adc_probe(struct platform_device *pdev)
>  			goto error_disable_adc_clk;
>  		}
>  	} else {
> -		ret = at91_ts_register(st, pdev);
> +		ret = at91_ts_register(idev, pdev);
>  		if (ret)
>  			goto error_disable_adc_clk;
>  
> -		at91_ts_hw_init(st, adc_clk_khz);
> +		at91_ts_hw_init(idev, adc_clk_khz);
>  	}
>  
>  	ret = iio_device_register(idev);

