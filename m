Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5D636A7F3
	for <lists+linux-iio@lfdr.de>; Sun, 25 Apr 2021 17:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhDYPZ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Apr 2021 11:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230194AbhDYPZ6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Apr 2021 11:25:58 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 171D561027;
        Sun, 25 Apr 2021 15:25:16 +0000 (UTC)
Date:   Sun, 25 Apr 2021 16:25:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Anand Ashok Dumbre <anandash@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: xilinx-xadc: Make IRQ optional
Message-ID: <20210425162559.11371323@jic23-huawei>
In-Reply-To: <20210425102638.9511-2-lars@metafoo.de>
References: <20210425102638.9511-1-lars@metafoo.de>
        <20210425102638.9511-2-lars@metafoo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 25 Apr 2021 12:26:38 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> In some setups the IRQ signal of the XADC might not be wired to the host
> system. The driver currently requires that an interrupt is specified. Make
> the interrupt optional so the driver can be used in such setups where the
> interrupt is not connected.
> 
> Since both buffered capture as well as events depend on the interrupt being
> connected both are not available when the interrupt is not connected.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Code looks fine to me but raises a question.  As there is no validate_trigger
callback in this driver, nothing stops it being associated with for example
an hrtimer trigger.  I don't think that will work so perhaps we should add the
callback?  If it does work, then the presence or not of an irq should not
change whether we register the buffer.

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 39 +++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index dd1c92b2811f..ffefb01a3893 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1182,7 +1182,7 @@ static const struct of_device_id xadc_of_match_table[] = {
>  MODULE_DEVICE_TABLE(of, xadc_of_match_table);
>  
>  static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
> -	unsigned int *conf)
> +	unsigned int *conf, int irq)
>  {
>  	struct device *dev = indio_dev->dev.parent;
>  	struct xadc *xadc = iio_priv(indio_dev);
> @@ -1195,6 +1195,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  	u32 ext_mux_chan;
>  	u32 reg;
>  	int ret;
> +	int i;
>  
>  	*conf = 0;
>  
> @@ -1273,6 +1274,14 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  	}
>  	of_node_put(chan_node);
>  
> +	/* No IRQ => no events */
> +	if (irq <= 0) {
> +		for (i = 0; i < num_channels; i++) {
> +			channels[i].event_spec = NULL;
> +			channels[i].num_event_specs = 0;
> +		}
> +	}
> +
>  	indio_dev->num_channels = num_channels;
>  	indio_dev->channels = devm_krealloc(dev, channels,
>  					    sizeof(*channels) * num_channels,
> @@ -1322,9 +1331,9 @@ static int xadc_probe(struct platform_device *pdev)
>  	if (!id)
>  		return -EINVAL;
>  
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0)
> -		return -ENXIO;
> +	irq = platform_get_irq_optional(pdev, 0);
> +	if (irq < 0 && irq != -ENXIO)
> +		return irq;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*xadc));
>  	if (!indio_dev)
> @@ -1345,11 +1354,11 @@ static int xadc_probe(struct platform_device *pdev)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &xadc_info;
>  
> -	ret = xadc_parse_dt(indio_dev, dev->of_node, &conf0);
> +	ret = xadc_parse_dt(indio_dev, dev->of_node, &conf0, irq);
>  	if (ret)
>  		return ret;
>  
> -	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
> +	if (irq > 0 && (xadc->ops->flags & XADC_FLAGS_BUFFERED)) {
>  		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  						      &iio_pollfunc_store_time,
>  						      &xadc_trigger_handler,
> @@ -1396,15 +1405,17 @@ static int xadc_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler, 0,
> -			       dev_name(dev), indio_dev);
> -	if (ret)
> -		return ret;
> +	if (irq > 0) {
> +		ret = devm_request_irq(dev, irq, xadc->ops->interrupt_handler,
> +				       0, dev_name(dev), indio_dev);
> +		if (ret)
> +			return ret;
>  
> -	ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
> -				       &xadc->zynq_unmask_work);
> -	if (ret)
> -		return ret;
> +		ret = devm_add_action_or_reset(dev, xadc_cancel_delayed_work,
> +					       &xadc->zynq_unmask_work);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	ret = xadc->ops->setup(pdev, indio_dev, irq);
>  	if (ret)

