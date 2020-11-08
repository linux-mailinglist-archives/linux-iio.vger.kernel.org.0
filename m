Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD4D2AAC8A
	for <lists+linux-iio@lfdr.de>; Sun,  8 Nov 2020 18:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgKHRIT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Nov 2020 12:08:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgKHRIT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Nov 2020 12:08:19 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 268E0206D4;
        Sun,  8 Nov 2020 17:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604855298;
        bh=CV5fY2XCA6lUL0eGmB+LpxPsyXpHTfYe3ZY/5YzjGwM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E37Bhks5SSxC75OxjoGBuAbIHL1mca4zvcrL8VhadrJcCnoEjx9yJtORZIlS44t7E
         j0Eu7/m/0pmDvcMaYlsyAat9LtmkXVJXCMmX1K8uDMDw83TvRvN+4heH8zfL2Kbbex
         ivOCClvPUVQ4UxlhQaRGreTYRIAMUURApsAVeXcA=
Date:   Sun, 8 Nov 2020 17:08:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 4/4] iio: adc: xilinx: use more devres helpers and
 remove remove()
Message-ID: <20201108170813.3efab72a@archlinux>
In-Reply-To: <20201102142228.14949-5-brgl@bgdev.pl>
References: <20201102142228.14949-1-brgl@bgdev.pl>
        <20201102142228.14949-5-brgl@bgdev.pl>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  2 Nov 2020 15:22:28 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> In order to simplify resource management and error paths in probe() and
> entirely drop the remove() callback - use devres helpers wherever
> possible. Define devm actions for cancelling the delayed work and
> disabling the clock.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
One addition inline.

thanks,

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 129 +++++++++++++----------------
>  1 file changed, 56 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 7792aa4cf9cb..6ce1745b4995 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -709,11 +709,12 @@ static const struct iio_trigger_ops xadc_trigger_ops = {
>  static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev,
>  	const char *name)
>  {
> +	struct device *dev = indio_dev->dev.parent;
>  	struct iio_trigger *trig;
>  	int ret;
>  
> -	trig = iio_trigger_alloc("%s%d-%s", indio_dev->name,
> -				indio_dev->id, name);
> +	trig = devm_iio_trigger_alloc(dev, "%s%d-%s", indio_dev->name,
> +				      indio_dev->id, name);
>  	if (trig == NULL)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -721,15 +722,11 @@ static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev,
>  	trig->ops = &xadc_trigger_ops;
>  	iio_trigger_set_drvdata(trig, iio_priv(indio_dev));
>  
> -	ret = iio_trigger_register(trig);
> +	ret = devm_iio_trigger_register(dev, trig);
>  	if (ret)
> -		goto error_free_trig;
> +		return ERR_PTR(ret);
>  
>  	return trig;
> -
> -error_free_trig:
> -	iio_trigger_free(trig);
> -	return ERR_PTR(ret);
>  }
>  
>  static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
> @@ -1188,6 +1185,20 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  	return 0;
>  }
>  
> +static void xadc_clk_disable_unprepare(void *data)
> +{
> +	struct clk *clk = data;
> +
> +	clk_disable_unprepare(clk);
> +}
> +
> +static void xadc_cancel_delayed_work(void *data)
> +{
> +	struct delayed_work *work = data;
> +
> +	cancel_delayed_work_sync(work);
> +}
> +
>  static int xadc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1236,34 +1247,35 @@ static int xadc_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
> -		ret = iio_triggered_buffer_setup(indio_dev,
> -			&iio_pollfunc_store_time, &xadc_trigger_handler,
> -			&xadc_buffer_ops);
> +		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +						      &iio_pollfunc_store_time,
> +						      &xadc_trigger_handler,
> +						      &xadc_buffer_ops);
>  		if (ret)
>  			return ret;
>  
>  		xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
> -		if (IS_ERR(xadc->convst_trigger)) {
> -			ret = PTR_ERR(xadc->convst_trigger);
> -			goto err_triggered_buffer_cleanup;
> -		}
> +		if (IS_ERR(xadc->convst_trigger))
> +			return PTR_ERR(xadc->convst_trigger);
> +
>  		xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev,
>  			"samplerate");
> -		if (IS_ERR(xadc->samplerate_trigger)) {
> -			ret = PTR_ERR(xadc->samplerate_trigger);
> -			goto err_free_convst_trigger;
> -		}
> +		if (IS_ERR(xadc->samplerate_trigger))
> +			return PTR_ERR(xadc->samplerate_trigger);
>  	}
>  
>  	xadc->clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(xadc->clk)) {
> -		ret = PTR_ERR(xadc->clk);
> -		goto err_free_samplerate_trigger;
> -	}
> +	if (IS_ERR(xadc->clk))
> +		return PTR_ERR(xadc->clk);
>  
>  	ret = clk_prepare_enable(xadc->clk);
>  	if (ret)
> -		goto err_free_samplerate_trigger;
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev,
> +				       xadc_clk_disable_unprepare, xadc->clk);
> +	if (ret)
> +		return ret;
>  
>  	/*
>  	 * Make sure not to exceed the maximum samplerate since otherwise the
> @@ -1272,22 +1284,28 @@ static int xadc_probe(struct platform_device *pdev)
>  	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
>  		ret = xadc_read_samplerate(xadc);
>  		if (ret < 0)
> -			goto err_free_samplerate_trigger;
> +			return ret;
> +
>  		if (ret > XADC_MAX_SAMPLERATE) {
>  			ret = xadc_write_samplerate(xadc, XADC_MAX_SAMPLERATE);
>  			if (ret < 0)
> -				goto err_free_samplerate_trigger;
> +				return ret;
>  		}
>  	}
>  
> -	ret = request_irq(xadc->irq, xadc->ops->interrupt_handler, 0,
> -			  dev_name(dev), indio_dev);
> +	ret = devm_request_irq(dev, xadc->irq, xadc->ops->interrupt_handler, 0,
> +			       dev_name(dev), indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
> +				       &xadc->zynq_unmask_work);
>  	if (ret)
> -		goto err_clk_disable_unprepare;
> +		return ret;
>  
>  	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
>  	if (ret)
> -		goto err_free_irq;
> +		return ret;
>  
>  	for (i = 0; i < 16; i++)
>  		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i),
> @@ -1295,7 +1313,7 @@ static int xadc_probe(struct platform_device *pdev)
>  
>  	ret = xadc_write_adc_reg(xadc, XADC_REG_CONF0, conf0);
>  	if (ret)
> -		goto err_free_irq;
> +		return ret;
>  
>  	bipolar_mask = 0;
>  	for (i = 0; i < indio_dev->num_channels; i++) {
> @@ -1305,17 +1323,18 @@ static int xadc_probe(struct platform_device *pdev)
>  
>  	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(0), bipolar_mask);
>  	if (ret)
> -		goto err_free_irq;
> +		return ret;
> +
>  	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(1),
>  		bipolar_mask >> 16);
>  	if (ret)
> -		goto err_free_irq;
> +		return ret;
>  
>  	/* Disable all alarms */
>  	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
>  				  XADC_CONF1_ALARM_MASK);
>  	if (ret)
> -		goto err_free_irq;
> +		return ret;
>  
>  	/* Set thresholds to min/max */
>  	for (i = 0; i < 16; i++) {
> @@ -1330,59 +1349,23 @@ static int xadc_probe(struct platform_device *pdev)
>  		ret = xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
>  			xadc->threshold[i]);
>  		if (ret)
> -			goto err_free_irq;
> +			return ret;
>  	}
>  
>  	/* Go to non-buffered mode */
>  	xadc_postdisable(indio_dev);
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret)
> -		goto err_free_irq;
> +		return ret;
>  
>  	platform_set_drvdata(pdev, indio_dev);

I haven't checked carefully, but it looks like you don't need
this any more as there are no remaining calls to
platform_get_drvdata().


I can clean that up whilst applying as long as you confirm
I'm right!

Thanks,

Jonathan

>  
> -	return 0;
> -
> -err_free_irq:
> -	free_irq(xadc->irq, indio_dev);
> -	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
> -err_clk_disable_unprepare:
> -	clk_disable_unprepare(xadc->clk);
> -err_free_samplerate_trigger:
> -	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
> -		iio_trigger_free(xadc->samplerate_trigger);
> -err_free_convst_trigger:
> -	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
> -		iio_trigger_free(xadc->convst_trigger);
> -err_triggered_buffer_cleanup:
> -	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
> -		iio_triggered_buffer_cleanup(indio_dev);
> -
> -	return ret;
> -}
> -
> -static int xadc_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -	struct xadc *xadc = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
> -		iio_trigger_free(xadc->samplerate_trigger);
> -		iio_trigger_free(xadc->convst_trigger);
> -		iio_triggered_buffer_cleanup(indio_dev);
> -	}
> -	free_irq(xadc->irq, indio_dev);
> -	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
> -	clk_disable_unprepare(xadc->clk);
> -
>  	return 0;
>  }
>  
>  static struct platform_driver xadc_driver = {
>  	.probe = xadc_probe,
> -	.remove = xadc_remove,
>  	.driver = {
>  		.name = "xadc",
>  		.of_match_table = xadc_of_match_table,

