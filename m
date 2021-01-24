Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658DE301D21
	for <lists+linux-iio@lfdr.de>; Sun, 24 Jan 2021 16:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbhAXPXB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Jan 2021 10:23:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbhAXPXA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jan 2021 10:23:00 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E953B22DFA;
        Sun, 24 Jan 2021 15:22:16 +0000 (UTC)
Date:   Sun, 24 Jan 2021 15:22:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        kernel@pengutronix.de, Holger Assmann <has@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: stm32-adc: enable timestamping for non-DMA
 usage
Message-ID: <20210124152212.5bc39e57@archlinux>
In-Reply-To: <20210122113355.32384-1-a.fatoum@pengutronix.de>
References: <20210122113355.32384-1-a.fatoum@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Jan 2021 12:33:55 +0100
Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> For non-DMA usage, we have an easy way to associate a timestamp with a
> sample: iio_pollfunc_store_time stores a timestamp in the primary
> trigger IRQ handler and stm32_adc_trigger_handler runs in the IRQ thread
> to push out the buffer along with the timestamp.
> 
> For this to work, the driver needs to register an IIO_TIMESTAMP channel.
> Do this.
> 
> For DMA, it's not as easy, because we don't push the buffers out of
> stm32_adc_trigger, but out of stm32_adc_dma_buffer_done, which runs in
> a tasklet scheduled after a DMA completion.
> 
> Preferably, the DMA controller would copy us the timestamp into that buffer
> as well. Until this is implemented, restrict timestamping support to
> only PIO. For low-frequency sampling, PIO is probably good enough.
> 
> Cc: Holger Assmann <has@pengutronix.de>
> Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

This patch itself is fine, but it will expose a potential bug.

The buffer passed to iio_push_to_buffers_with_timestamp needs to be suitably
aligned to take an 8 byte timestamp and large enough to do so.
 Currently, in this driver it isn't.
	u16			buffer[STM32_ADC_MAX_SQ];
Appears to be the same length as the channel count, and isn't 8 byte
aligned. (add __aligned(8) to fix that)

Could you add that fix to this patch as well?

Thanks,

Jonathan


> ---
> v1 -> v2:
>   - Added comment about timestamping being PIO only (Fabrice)
>   - Added missing DMA resource clean up in error path (Fabrice)
>   - Added Fabrice's Acked-by
> ---
>  drivers/iio/adc/stm32-adc.c | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index c067c994dae2..885bb514503c 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1718,7 +1718,7 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
> +static int stm32_adc_chan_of_init(struct iio_dev *indio_dev, bool timestamping)
>  {
>  	struct device_node *node = indio_dev->dev.of_node;
>  	struct stm32_adc *adc = iio_priv(indio_dev);
> @@ -1766,6 +1766,9 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
>  		return -EINVAL;
>  	}
>  
> +	if (timestamping)
> +		num_channels++;
> +
>  	channels = devm_kcalloc(&indio_dev->dev, num_channels,
>  				sizeof(struct iio_chan_spec), GFP_KERNEL);
>  	if (!channels)
> @@ -1816,6 +1819,19 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
>  		stm32_adc_smpr_init(adc, channels[i].channel, smp);
>  	}
>  
> +	if (timestamping) {
> +		struct iio_chan_spec *timestamp = &channels[scan_index];
> +
> +		timestamp->type = IIO_TIMESTAMP;
> +		timestamp->channel = -1;
> +		timestamp->scan_index = scan_index;
> +		timestamp->scan_type.sign = 's';
> +		timestamp->scan_type.realbits = 64;
> +		timestamp->scan_type.storagebits = 64;
> +
> +		scan_index++;
> +	}
> +
>  	indio_dev->num_channels = scan_index;
>  	indio_dev->channels = channels;
>  
> @@ -1875,6 +1891,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	irqreturn_t (*handler)(int irq, void *p) = NULL;
>  	struct stm32_adc *adc;
> +	bool timestamping = false;
>  	int ret;
>  
>  	if (!pdev->dev.of_node)
> @@ -1931,16 +1948,22 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = stm32_adc_chan_of_init(indio_dev);
> -	if (ret < 0)
> -		return ret;
> -
>  	ret = stm32_adc_dma_request(dev, indio_dev);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (!adc->dma_chan)
> +	if (!adc->dma_chan) {
> +		/* For PIO mode only, iio_pollfunc_store_time stores a timestamp
> +		 * in the primary trigger IRQ handler and stm32_adc_trigger_handler
> +		 * runs in the IRQ thread to push out buffer along with timestamp.
> +		 */
>  		handler = &stm32_adc_trigger_handler;
> +		timestamping = true;
> +	}
> +
> +	ret = stm32_adc_chan_of_init(indio_dev, timestamping);
> +	if (ret < 0)
> +		goto err_dma_disable;
>  
>  	ret = iio_triggered_buffer_setup(indio_dev,
>  					 &iio_pollfunc_store_time, handler,

