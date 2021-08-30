Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC313FB79F
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 16:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbhH3OOQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 10:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236803AbhH3OOQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 10:14:16 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 293EA60462;
        Mon, 30 Aug 2021 14:13:17 +0000 (UTC)
Date:   Mon, 30 Aug 2021 15:16:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 31/40] iio: adc: ti_am335x_adc: Fix style
Message-ID: <20210830151631.051af320@jic23-huawei>
In-Reply-To: <20210825152518.379386-32-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-32-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:25:09 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> These warnings are reported by checkpatch.pl essentially.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
A few trivial comments inline, but otherwise lgtm

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/adc/ti_am335x_adc.c | 104 ++++++++++++++++----------------
>  1 file changed, 52 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index a5da1fedbc5c..dd2200d2f214 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -57,7 +57,7 @@ static unsigned int tiadc_readl(struct tiadc_device *adc, unsigned int reg)
>  }
>  
>  static void tiadc_writel(struct tiadc_device *adc, unsigned int reg,
> -					unsigned int val)
> +			 unsigned int val)
>  {
>  	writel(val, adc->mfd_tscadc->tscadc_base + reg);
>  }
> @@ -72,7 +72,7 @@ static u32 get_adc_step_mask(struct tiadc_device *adc_dev)
>  }
>  
>  static u32 get_adc_chan_step_mask(struct tiadc_device *adc_dev,
> -		struct iio_chan_spec const *chan)
> +				  struct iio_chan_spec const *chan)
>  {
>  	int i;
>  
> @@ -110,8 +110,6 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
>  	 * Channel would represent which analog input
>  	 * needs to be given to ADC to digitalize data.
>  	 */
> -
> -
>  	for (i = 0; i < adc_dev->channels; i++) {
>  		int chan;
>  
> @@ -124,9 +122,8 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
>  		}
>  
>  		if (adc_dev->step_avg[i])
> -			stepconfig =
> -			STEPCONFIG_AVG(ffs(adc_dev->step_avg[i]) - 1) |
> -			STEPCONFIG_FIFO1;
> +			stepconfig = STEPCONFIG_AVG(ffs(adc_dev->step_avg[i]) - 1) |
> +				     STEPCONFIG_FIFO1;
>  		else
>  			stepconfig = STEPCONFIG_FIFO1;
>  
> @@ -134,10 +131,9 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
>  			stepconfig |= STEPCONFIG_MODE_SWCNT;
>  
>  		tiadc_writel(adc_dev, REG_STEPCONFIG(steps),
> -				stepconfig | STEPCONFIG_INP(chan) |
> -				STEPCONFIG_INM_ADCREFM |
> -				STEPCONFIG_RFP_VREFP |
> -				STEPCONFIG_RFM_VREFN);
> +			     stepconfig | STEPCONFIG_INP(chan) |
> +			     STEPCONFIG_INM_ADCREFM | STEPCONFIG_RFP_VREFP |
> +			     STEPCONFIG_RFM_VREFN);
>  
>  		if (adc_dev->open_delay[i] > STEPDELAY_OPEN_MASK) {
>  			dev_warn(dev, "chan %d open delay truncating to 0x3FFFF\n",
> @@ -152,8 +148,8 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
>  		}
>  
>  		tiadc_writel(adc_dev, REG_STEPDELAY(steps),
> -				STEPDELAY_OPEN(adc_dev->open_delay[i]) |
> -				STEPDELAY_SAMPLE(adc_dev->sample_delay[i]));
> +			     STEPDELAY_OPEN(adc_dev->open_delay[i]) |
> +			     STEPDELAY_SAMPLE(adc_dev->sample_delay[i]));
>  
>  		adc_dev->channel_step[i] = steps;
>  		steps++;
> @@ -178,10 +174,12 @@ static irqreturn_t tiadc_irq_h(int irq, void *private)
>  		config = tiadc_readl(adc_dev, REG_CTRL);
>  		config &= ~(CNTRLREG_SSENB);
>  		tiadc_writel(adc_dev, REG_CTRL, config);
> -		tiadc_writel(adc_dev, REG_IRQSTATUS, IRQENB_FIFO1OVRRUN
> -				| IRQENB_FIFO1UNDRFLW | IRQENB_FIFO1THRES);
> +		tiadc_writel(adc_dev, REG_IRQSTATUS,
> +			     IRQENB_FIFO1OVRRUN | IRQENB_FIFO1UNDRFLW |
> +			     IRQENB_FIFO1THRES);
>  
> -		/* wait for idle state.
> +		/*
> +		 * Wait for the idle state.
>  		 * ADC needs to finish the current conversion
>  		 * before disabling the module
>  		 */
> @@ -209,11 +207,11 @@ static irqreturn_t tiadc_worker_h(int irq, void *private)
>  
>  	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
>  	for (k = 0; k < fifo1count; k = k + i) {
> -		for (i = 0; i < (indio_dev->scan_bytes)/2; i++) {
> +		for (i = 0; i < (indio_dev->scan_bytes / 2); i++) {

Do we need those internal brackets at all?

>  			read = tiadc_readl(adc_dev, REG_FIFO1);
>  			data[i] = read & FIFOREAD_DATA_MASK;
>  		}
> -		iio_push_to_buffers(indio_dev, (u8 *) data);
> +		iio_push_to_buffers(indio_dev, (u8 *)data);
>  	}
>  
>  	tiadc_writel(adc_dev, REG_IRQSTATUS, IRQENB_FIFO1THRES);
> @@ -246,6 +244,7 @@ static int tiadc_start_dma(struct iio_dev *indio_dev)
>  	struct dma_async_tx_descriptor *desc;
>  
>  	dma->current_period = 0; /* We start to fill period 0 */
> +
>  	/*
>  	 * Make the fifo thresh as the multiple of total number of
>  	 * channels enabled, so make sure that cyclic DMA period
> @@ -255,9 +254,10 @@ static int tiadc_start_dma(struct iio_dev *indio_dev)
>  	 */
>  	dma->fifo_thresh = rounddown(FIFO1_THRESHOLD + 1,
>  				     adc_dev->total_ch_enabled) - 1;
> +
>  	/* Make sure that period length is multiple of fifo thresh level */
>  	dma->period_size = rounddown(DMA_BUFFER_SIZE / 2,
> -				    (dma->fifo_thresh + 1) * sizeof(u16));
> +				     (dma->fifo_thresh + 1) * sizeof(u16));
>  
>  	dma->conf.src_maxburst = dma->fifo_thresh + 1;
>  	dmaengine_slave_config(dma->chan, &dma->conf);
> @@ -288,9 +288,9 @@ static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
>  	int i, fifo1count;
>  
> -	tiadc_writel(adc_dev, REG_IRQCLR, (IRQENB_FIFO1THRES |
> -				IRQENB_FIFO1OVRRUN |
> -				IRQENB_FIFO1UNDRFLW));
> +	tiadc_writel(adc_dev, REG_IRQCLR,
> +		     IRQENB_FIFO1THRES | IRQENB_FIFO1OVRRUN |
> +		     IRQENB_FIFO1UNDRFLW);
>  
>  	/* Flush FIFO. Needed in corner cases in simultaneous tsc/adc use */
>  	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
> @@ -320,8 +320,9 @@ static int tiadc_buffer_postenable(struct iio_dev *indio_dev)
>  
>  	am335x_tsc_se_set_cache(adc_dev->mfd_tscadc, enb);
>  
> -	tiadc_writel(adc_dev,  REG_IRQSTATUS, IRQENB_FIFO1THRES
> -				| IRQENB_FIFO1OVRRUN | IRQENB_FIFO1UNDRFLW);
> +	tiadc_writel(adc_dev, REG_IRQSTATUS,
> +		     IRQENB_FIFO1THRES | IRQENB_FIFO1OVRRUN |
> +		     IRQENB_FIFO1UNDRFLW);
>  
>  	irq_enable = IRQENB_FIFO1OVRRUN;
>  	if (!dma->chan)
> @@ -337,8 +338,9 @@ static int tiadc_buffer_predisable(struct iio_dev *indio_dev)
>  	struct tiadc_dma *dma = &adc_dev->dma;
>  	int fifo1count, i;
>  
> -	tiadc_writel(adc_dev, REG_IRQCLR, (IRQENB_FIFO1THRES |
> -				IRQENB_FIFO1OVRRUN | IRQENB_FIFO1UNDRFLW));
> +	tiadc_writel(adc_dev, REG_IRQCLR,
> +		     IRQENB_FIFO1THRES | IRQENB_FIFO1OVRRUN |
> +		     IRQENB_FIFO1UNDRFLW);
>  	am335x_tsc_se_clr(adc_dev->mfd_tscadc, adc_dev->buffer_en_ch_steps);
>  	adc_dev->buffer_en_ch_steps = 0;
>  	adc_dev->total_ch_enabled = 0;
> @@ -370,12 +372,11 @@ static const struct iio_buffer_setup_ops tiadc_buffer_setup_ops = {
>  };
>  
>  static int tiadc_iio_buffered_hardware_setup(struct device *dev,
> -	struct iio_dev *indio_dev,
> -	irqreturn_t (*pollfunc_bh)(int irq, void *p),
> -	irqreturn_t (*pollfunc_th)(int irq, void *p),
> -	int irq,
> -	unsigned long flags,
> -	const struct iio_buffer_setup_ops *setup_ops)
> +					     struct iio_dev *indio_dev,

I would consider this particular form fine to keep line lengths down.
It's not very important now we have some more slack up to 100 chars though.

> +					     irqreturn_t (*pollfunc_bh)(int irq, void *p),
> +					     irqreturn_t (*pollfunc_th)(int irq, void *p),
> +					     int irq, unsigned long flags,
> +					     const struct iio_buffer_setup_ops *setup_ops)
>  {
>  	int ret;
>  
> @@ -386,7 +387,7 @@ static int tiadc_iio_buffered_hardware_setup(struct device *dev,
>  		return ret;
>  
>  	return devm_request_threaded_irq(dev, irq, pollfunc_th, pollfunc_bh,
> -				flags, indio_dev->name, indio_dev);
> +					 flags, indio_dev->name, indio_dev);
>  }
>  
>  static const char * const chan_name_ain[] = {
> @@ -411,12 +412,11 @@ static int tiadc_channel_init(struct device *dev, struct iio_dev *indio_dev,
>  	indio_dev->num_channels = channels;
>  	chan_array = devm_kcalloc(dev, channels, sizeof(*chan_array),
>  				  GFP_KERNEL);
> -	if (chan_array == NULL)
> +	if (!chan_array)
>  		return -ENOMEM;
>  
>  	chan = chan_array;
>  	for (i = 0; i < channels; i++, chan++) {
> -
>  		chan->type = IIO_VOLTAGE;
>  		chan->indexed = 1;
>  		chan->channel = adc_dev->channel_line[i];
> @@ -434,8 +434,8 @@ static int tiadc_channel_init(struct device *dev, struct iio_dev *indio_dev,
>  }
>  
>  static int tiadc_read_raw(struct iio_dev *indio_dev,
> -		struct iio_chan_spec const *chan,
> -		int *val, int *val2, long mask)
> +			  struct iio_chan_spec const *chan, int *val, int *val2,
> +			  long mask)
>  {
>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
>  	int ret = IIO_VAL_INT;
> @@ -459,9 +459,8 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  
>  	am335x_tsc_se_set_once(adc_dev->mfd_tscadc, step_en);
>  
> -	timeout = jiffies + msecs_to_jiffies
> -				(IDLE_TIMEOUT * adc_dev->channels);
>  	/* Wait for Fifo threshold interrupt */
> +	timeout = jiffies + msecs_to_jiffies(IDLE_TIMEOUT * adc_dev->channels);
>  	while (1) {
>  		fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
>  		if (fifo1count)
> @@ -473,6 +472,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  			goto err_unlock;
>  		}
>  	}
> +
>  	map_val = adc_dev->channel_step[chan->scan_index];
>  
>  	/*
> @@ -490,13 +490,14 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  		if (stepid == map_val) {
>  			read = read & FIFOREAD_DATA_MASK;
>  			found = true;
> -			*val = (u16) read;
> +			*val = (u16)read;
>  		}
>  	}
> +
>  	am335x_tsc_se_adc_done(adc_dev->mfd_tscadc);
>  
>  	if (!found)
> -		ret =  -EBUSY;
> +		ret = -EBUSY;
>  
>  err_unlock:
>  	mutex_unlock(&adc_dev->fifo1_lock);
> @@ -537,6 +538,7 @@ static int tiadc_request_dma(struct platform_device *pdev,
>  		goto err;
>  
>  	return 0;
> +
>  err:
>  	dma_release_channel(dma->chan);
>  	return -ENOMEM;
> @@ -586,7 +588,7 @@ static int tiadc_probe(struct platform_device *pdev)
>  	}
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc_dev));
> -	if (indio_dev == NULL) {
> +	if (!indio_dev) {
>  		dev_err(&pdev->dev, "failed to allocate iio device\n");
>  		return -ENOMEM;
>  	}
> @@ -608,12 +610,11 @@ static int tiadc_probe(struct platform_device *pdev)
>  		return err;
>  
>  	err = tiadc_iio_buffered_hardware_setup(&pdev->dev, indio_dev,
> -		&tiadc_worker_h,
> -		&tiadc_irq_h,
> -		adc_dev->mfd_tscadc->irq,
> -		IRQF_SHARED,
> -		&tiadc_buffer_setup_ops);
> -
> +						&tiadc_worker_h,
> +						&tiadc_irq_h,
> +						adc_dev->mfd_tscadc->irq,
> +						IRQF_SHARED,
> +						&tiadc_buffer_setup_ops);
>  	if (err)
>  		goto err_free_channels;
>  
> @@ -664,8 +665,7 @@ static int __maybe_unused tiadc_suspend(struct device *dev)
>  
>  	idle = tiadc_readl(adc_dev, REG_CTRL);
>  	idle &= ~(CNTRLREG_SSENB);
> -	tiadc_writel(adc_dev, REG_CTRL, (idle |
> -			CNTRLREG_POWERDOWN));
> +	tiadc_writel(adc_dev, REG_CTRL, idle | CNTRLREG_POWERDOWN);
>  
>  	return 0;
>  }
> @@ -678,12 +678,12 @@ static int __maybe_unused tiadc_resume(struct device *dev)
>  
>  	/* Make sure ADC is powered up */
>  	restore = tiadc_readl(adc_dev, REG_CTRL);
> -	restore &= ~(CNTRLREG_POWERDOWN);
> +	restore &= ~CNTRLREG_POWERDOWN;
>  	tiadc_writel(adc_dev, REG_CTRL, restore);
>  
>  	tiadc_step_config(indio_dev);
>  	am335x_tsc_se_set_cache(adc_dev->mfd_tscadc,
> -			adc_dev->buffer_en_ch_steps);
> +				adc_dev->buffer_en_ch_steps);
>  	return 0;
>  }
>  

