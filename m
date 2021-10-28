Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452A643E355
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 16:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhJ1OVm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 10:21:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhJ1OVl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 10:21:41 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81FF861073;
        Thu, 28 Oct 2021 14:19:13 +0000 (UTC)
Date:   Thu, 28 Oct 2021 15:23:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Anand Ashok Dumbre <anandash@xilinx.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: xilinx-xadc: Make IRQ optional
Message-ID: <20211028152340.5667663d@jic23-huawei>
In-Reply-To: <20211021125950.28707-1-lars@metafoo.de>
References: <20211021125950.28707-1-lars@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Oct 2021 14:59:50 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> In some setups the IRQ signal of the XADC might not be wired to the host
> system. The driver currently requires that an interrupt is specified. Make
> the interrupt optional so the driver can be used in such setups where the
> interrupt is not connected.
> 
> Since both the internal triggers as well as events depend on the interrupt
> being connected both are not available when the interrupt is not connected.
> 
> Buffered access is still supported even without an interrupt since an
> external trigger can be used.
> 
> The IRQ is only optional when using the AXI interface, since the PCAP
> interface needs the IRQ for reading and writing registers.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 62 +++++++++++++++++++-----------
>  1 file changed, 40 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 83bea5ef765d..2aa4278ecba7 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -107,6 +107,7 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
>  #define XADC_AXI_INT_ALARM_MASK		0x3c0f
>  
>  #define XADC_FLAGS_BUFFERED BIT(0)
> +#define XADC_FLAGS_IRQ_OPTIONAL BIT(1)
>  
>  /*
>   * The XADC hardware supports a samplerate of up to 1MSPS. Unfortunately it does
> @@ -562,7 +563,7 @@ static const struct xadc_ops xadc_7s_axi_ops = {
>  	.get_dclk_rate = xadc_axi_get_dclk,
>  	.update_alarm = xadc_axi_update_alarm,
>  	.interrupt_handler = xadc_axi_interrupt_handler,
> -	.flags = XADC_FLAGS_BUFFERED,
> +	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
>  	.type = XADC_TYPE_S7,
>  };
>  
> @@ -573,7 +574,7 @@ static const struct xadc_ops xadc_us_axi_ops = {
>  	.get_dclk_rate = xadc_axi_get_dclk,
>  	.update_alarm = xadc_axi_update_alarm,
>  	.interrupt_handler = xadc_axi_interrupt_handler,
> -	.flags = XADC_FLAGS_BUFFERED,
> +	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
>  	.type = XADC_TYPE_US,
>  };
>  
> @@ -1182,7 +1183,7 @@ static const struct of_device_id xadc_of_match_table[] = {
>  MODULE_DEVICE_TABLE(of, xadc_of_match_table);
>  
>  static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
> -	unsigned int *conf)
> +	unsigned int *conf, int irq)
>  {
>  	struct device *dev = indio_dev->dev.parent;
>  	struct xadc *xadc = iio_priv(indio_dev);
> @@ -1195,6 +1196,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  	u32 ext_mux_chan;
>  	u32 reg;
>  	int ret;
> +	int i;
>  
>  	*conf = 0;
>  
> @@ -1273,6 +1275,14 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
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
> @@ -1307,6 +1317,7 @@ static int xadc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	const struct of_device_id *id;
> +	const struct xadc_ops *ops;
>  	struct iio_dev *indio_dev;
>  	unsigned int bipolar_mask;
>  	unsigned int conf0;
> @@ -1322,9 +1333,12 @@ static int xadc_probe(struct platform_device *pdev)
>  	if (!id)
>  		return -EINVAL;
>  
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0)
> -		return -ENXIO;
> +	ops = id->data;
> +
> +	irq = platform_get_irq_optional(pdev, 0);
> +	if (irq < 0 &&
> +	    (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))
> +		return irq;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*xadc));
>  	if (!indio_dev)
> @@ -1345,7 +1359,7 @@ static int xadc_probe(struct platform_device *pdev)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &xadc_info;
>  
> -	ret = xadc_parse_dt(indio_dev, dev->of_node, &conf0);
> +	ret = xadc_parse_dt(indio_dev, dev->of_node, &conf0, irq);
>  	if (ret)
>  		return ret;
>  
> @@ -1357,14 +1371,16 @@ static int xadc_probe(struct platform_device *pdev)
>  		if (ret)
>  			return ret;
>  
> -		xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
> -		if (IS_ERR(xadc->convst_trigger))
> -			return PTR_ERR(xadc->convst_trigger);
> +		if (irq > 0) {
> +			xadc->convst_trigger = xadc_alloc_trigger(indio_dev, "convst");
> +			if (IS_ERR(xadc->convst_trigger))
> +				return PTR_ERR(xadc->convst_trigger);
>  
> -		xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev,
> -			"samplerate");
> -		if (IS_ERR(xadc->samplerate_trigger))
> -			return PTR_ERR(xadc->samplerate_trigger);
> +			xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev,
> +				"samplerate");
> +			if (IS_ERR(xadc->samplerate_trigger))
> +				return PTR_ERR(xadc->samplerate_trigger);
> +		}
>  	}
>  
>  	xadc->clk = devm_clk_get(dev, NULL);
> @@ -1396,15 +1412,17 @@ static int xadc_probe(struct platform_device *pdev)
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

