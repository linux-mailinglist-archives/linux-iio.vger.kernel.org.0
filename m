Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C31E29F062
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 16:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgJ2PrY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 11:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbgJ2PrY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Oct 2020 11:47:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4247620759;
        Thu, 29 Oct 2020 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603986084;
        bh=NH3QL4UBUna3hBHsBKAlVHRlZtIKuYG5/lyMVyxAwLs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x6mAJBBKFfyV8rgvaJzNVB64oMV9PZDjki2vOWlra0tOQnFS3w71leg99fuXtmvUi
         mRIbfIA0QHW86A/hFArT/PVEvBWZU2C/bAY6dCqUV8ntN2wGq8sA7T2M8tY3nNxVtj
         HIKz2jScu08jy3kyfxhSPYc8G3RBHgC17WiZ8NJ0=
Date:   Thu, 29 Oct 2020 15:41:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 4/5] iio: adc: xilinx: use devres for irq handling
Message-ID: <20201029154118.12fd6c23@archlinux>
In-Reply-To: <20201026133609.24262-5-brgl@bgdev.pl>
References: <20201026133609.24262-1-brgl@bgdev.pl>
        <20201026133609.24262-5-brgl@bgdev.pl>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 26 Oct 2020 14:36:08 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Further simplify the remove() callback and error paths in probe() by
> using the managed variant of request_irq() as well as using a devm action
> for cancelling the delayed work at driver detach.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Again, this is potentially fine but I'd rather you cleaned up the ordering first
rather than doing things in this order.

The end result of the whole series looks like it will be correct, but that isn't
so obvious for the intermediate patches on their own.

Also, you end up with a lot of noise renaming gotos that then go away at the
end.

Jonathan


> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 35 ++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index e0da6258092c..4440b7a9bd36 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1192,6 +1192,13 @@ static void xadc_clk_disable_unprepare(void *data)
>  	clk_disable_unprepare(clk);
>  }
>  
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
> @@ -1289,14 +1296,19 @@ static int xadc_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	ret = request_irq(xadc->irq, xadc->ops->interrupt_handler, 0,
> -			  dev_name(dev), indio_dev);
> +	ret = devm_request_irq(dev, xadc->irq, xadc->ops->interrupt_handler, 0,
> +			       dev_name(dev), indio_dev);
> +	if (ret)
> +		goto err_free_samplerate_trigger;
> +
> +	ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
> +				       &xadc->zynq_unmask_work);
>  	if (ret)
>  		goto err_free_samplerate_trigger;
>  
>  	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
>  	if (ret)
> -		goto err_free_irq;
> +		goto err_free_samplerate_trigger;
>  
>  	for (i = 0; i < 16; i++)
>  		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i),
> @@ -1304,7 +1316,7 @@ static int xadc_probe(struct platform_device *pdev)
>  
>  	ret = xadc_write_adc_reg(xadc, XADC_REG_CONF0, conf0);
>  	if (ret)
> -		goto err_free_irq;
> +		goto err_free_samplerate_trigger;
>  
>  	bipolar_mask = 0;
>  	for (i = 0; i < indio_dev->num_channels; i++) {
> @@ -1314,17 +1326,17 @@ static int xadc_probe(struct platform_device *pdev)
>  
>  	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(0), bipolar_mask);
>  	if (ret)
> -		goto err_free_irq;
> +		goto err_free_samplerate_trigger;
>  	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(1),
>  		bipolar_mask >> 16);
>  	if (ret)
> -		goto err_free_irq;
> +		goto err_free_samplerate_trigger;
>  
>  	/* Disable all alarms */
>  	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_ALARM_MASK,
>  				  XADC_CONF1_ALARM_MASK);
>  	if (ret)
> -		goto err_free_irq;
> +		goto err_free_samplerate_trigger;
>  
>  	/* Set thresholds to min/max */
>  	for (i = 0; i < 16; i++) {
> @@ -1339,7 +1351,7 @@ static int xadc_probe(struct platform_device *pdev)
>  		ret = xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(i),
>  			xadc->threshold[i]);
>  		if (ret)
> -			goto err_free_irq;
> +			goto err_free_samplerate_trigger;
>  	}
>  
>  	/* Go to non-buffered mode */
> @@ -1347,15 +1359,12 @@ static int xadc_probe(struct platform_device *pdev)
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto err_free_irq;
> +		goto err_free_samplerate_trigger;
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	return 0;
>  
> -err_free_irq:
> -	free_irq(xadc->irq, indio_dev);
> -	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
>  err_free_samplerate_trigger:
>  	if (xadc->ops->flags & XADC_FLAGS_BUFFERED)
>  		iio_trigger_free(xadc->samplerate_trigger);
> @@ -1380,8 +1389,6 @@ static int xadc_remove(struct platform_device *pdev)
>  		iio_trigger_free(xadc->convst_trigger);
>  		iio_triggered_buffer_cleanup(indio_dev);
>  	}
> -	free_irq(xadc->irq, indio_dev);
> -	cancel_delayed_work_sync(&xadc->zynq_unmask_work);
>  
>  	return 0;
>  }

