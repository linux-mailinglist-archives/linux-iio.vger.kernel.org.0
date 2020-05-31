Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDE71E9828
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 16:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgEaOjP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 10:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgEaOjP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 10:39:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D94012074A;
        Sun, 31 May 2020 14:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590935952;
        bh=um8LOykYHKiX9+Fa4xk5hMgG0XY1r+FkOGMkxd2H0g4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YRqmXnuk9IluuPFhpvUsbgqEFpR2ZK7uoCQxt3RQCjPPeOLhj43nkXCQH48rYZ0Yh
         kyhWf4yau5Lla9VSUdMl5r1+8pF8z33vT57VnYzL5mk1TbaJAUiXKSZXzikS/7wnv4
         +mtSZdq62rzfYmT3I6VnkXE2Q1DjhfOR2h7OqCuk=
Date:   Sun, 31 May 2020 15:39:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>,
        <eugen.hristev@microchip.com>
Subject: Re: [PATCH] iio: at91-sama5d2_adc: remove usage of
 iio_priv_to_dev() helper
Message-ID: <20200531153908.47ccbc37@archlinux>
In-Reply-To: <20200525105341.137945-1-alexandru.ardelean@analog.com>
References: <20200525105341.137945-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 May 2020 13:53:41 +0300
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
> pass the iio device and using iio_priv() to access the private information,
> and also keeping a reference to the iio device for some quirky paths.
> 
> One [quirky] path is the at91_adc_workq_handler() which requires the IIO
> device & the state struct to push to buffers.
> Since this requires the back-ref to the IIO device, the
> at91_adc_touch_pos() also uses it. This simplifies the patch a bit. The
> information required in this function is mostly for debugging purposes.
> Replacing it with a reference to the IIO device would have been a slightly
> bigger change, which may not be worth it (for just the debugging purpose
> and given that we need the back-ref to the IIO device anyway).

That workq is indeed quirky.  This looks fine to me in general. I'll
want an appropriate ack from the at91 side of things if possible so
let's leave this on the list for a while longer.

Poke me if no action in a few weeks.

Thanks,

Jonathan

> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 9abbbdcc7420..7bce18444430 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -402,6 +402,7 @@ struct at91_adc_state {
>  	wait_queue_head_t		wq_data_available;
>  	struct at91_adc_dma		dma_st;
>  	struct at91_adc_touch		touch_st;
> +	struct iio_dev			*indio_dev;
>  	u16				buffer[AT91_BUFFER_MAX_HWORDS];
>  	/*
>  	 * lock to prevent concurrent 'single conversion' requests through
> @@ -642,13 +643,13 @@ static u16 at91_adc_touch_pos(struct at91_adc_state *st, int reg)
>  	/* first half of register is the x or y, second half is the scale */
>  	val = at91_adc_readl(st, reg);
>  	if (!val)
> -		dev_dbg(&iio_priv_to_dev(st)->dev, "pos is 0\n");
> +		dev_dbg(&st->indio_dev->dev, "pos is 0\n");
>  
>  	pos = val & AT91_SAMA5D2_XYZ_MASK;
>  	result = (pos << AT91_SAMA5D2_MAX_POS_BITS) - pos;
>  	scale = (val >> 16) & AT91_SAMA5D2_XYZ_MASK;
>  	if (scale == 0) {
> -		dev_err(&iio_priv_to_dev(st)->dev, "scale is 0\n");
> +		dev_err(&st->indio_dev->dev, "scale is 0\n");
>  		return 0;
>  	}
>  	result /= scale;
> @@ -1204,9 +1205,9 @@ static unsigned at91_adc_startup_time(unsigned startup_time_min,
>  	return i;
>  }
>  
> -static void at91_adc_setup_samp_freq(struct at91_adc_state *st, unsigned freq)
> +static void at91_adc_setup_samp_freq(struct iio_dev *indio_dev, unsigned freq)
>  {
> -	struct iio_dev *indio_dev = iio_priv_to_dev(st);
> +	struct at91_adc_state *st = iio_priv(indio_dev);
>  	unsigned f_per, prescal, startup, mr;
>  
>  	f_per = clk_get_rate(st->per_clk);
> @@ -1275,9 +1276,9 @@ static void at91_adc_pen_detect_interrupt(struct at91_adc_state *st)
>  	st->touch_st.touching = true;
>  }
>  
> -static void at91_adc_no_pen_detect_interrupt(struct at91_adc_state *st)
> +static void at91_adc_no_pen_detect_interrupt(struct iio_dev *indio_dev)
>  {
> -	struct iio_dev *indio_dev = iio_priv_to_dev(st);
> +	struct at91_adc_state *st = iio_priv(indio_dev);
>  
>  	at91_adc_writel(st, AT91_SAMA5D2_TRGR,
>  			AT91_SAMA5D2_TRGR_TRGMOD_NO_TRIGGER);
> @@ -1297,7 +1298,7 @@ static void at91_adc_workq_handler(struct work_struct *workq)
>  					struct at91_adc_touch, workq);
>  	struct at91_adc_state *st = container_of(touch_st,
>  					struct at91_adc_state, touch_st);
> -	struct iio_dev *indio_dev = iio_priv_to_dev(st);
> +	struct iio_dev *indio_dev = st->indio_dev;
>  
>  	iio_push_to_buffers(indio_dev, st->buffer);
>  }
> @@ -1318,7 +1319,7 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
>  		at91_adc_pen_detect_interrupt(st);
>  	} else if ((status & AT91_SAMA5D2_IER_NOPEN)) {
>  		/* nopen detected IRQ */
> -		at91_adc_no_pen_detect_interrupt(st);
> +		at91_adc_no_pen_detect_interrupt(indio);
>  	} else if ((status & AT91_SAMA5D2_ISR_PENS) &&
>  		   ((status & rdy_mask) == rdy_mask)) {
>  		/* periodic trigger IRQ - during pen sense */
> @@ -1486,7 +1487,7 @@ static int at91_adc_write_raw(struct iio_dev *indio_dev,
>  		    val > st->soc_info.max_sample_rate)
>  			return -EINVAL;
>  
> -		at91_adc_setup_samp_freq(st, val);
> +		at91_adc_setup_samp_freq(indio_dev, val);
>  		return 0;
>  	default:
>  		return -EINVAL;
> @@ -1624,8 +1625,10 @@ static int at91_adc_update_scan_mode(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> -static void at91_adc_hw_init(struct at91_adc_state *st)
> +static void at91_adc_hw_init(struct iio_dev *indio_dev)
>  {
> +	struct at91_adc_state *st = iio_priv(indio_dev);
> +
>  	at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_SWRST);
>  	at91_adc_writel(st, AT91_SAMA5D2_IDR, 0xffffffff);
>  	/*
> @@ -1635,7 +1638,7 @@ static void at91_adc_hw_init(struct at91_adc_state *st)
>  	at91_adc_writel(st, AT91_SAMA5D2_MR,
>  			AT91_SAMA5D2_MR_TRANSFER(2) | AT91_SAMA5D2_MR_ANACH);
>  
> -	at91_adc_setup_samp_freq(st, st->soc_info.min_sample_rate);
> +	at91_adc_setup_samp_freq(indio_dev, st->soc_info.min_sample_rate);
>  
>  	/* configure extended mode register */
>  	at91_adc_config_emr(st);
> @@ -1718,6 +1721,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	indio_dev->num_channels = ARRAY_SIZE(at91_adc_channels);
>  
>  	st = iio_priv(indio_dev);
> +	st->indio_dev = indio_dev;
>  
>  	bitmap_set(&st->touch_st.channels_bitmask,
>  		   AT91_SAMA5D2_TOUCH_X_CHAN_IDX, 1);
> @@ -1829,7 +1833,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  		goto vref_disable;
>  	}
>  
> -	at91_adc_hw_init(st);
> +	at91_adc_hw_init(indio_dev);
>  
>  	ret = clk_prepare_enable(st->per_clk);
>  	if (ret)
> @@ -1945,7 +1949,7 @@ static __maybe_unused int at91_adc_resume(struct device *dev)
>  	if (ret)
>  		goto vref_disable_resume;
>  
> -	at91_adc_hw_init(st);
> +	at91_adc_hw_init(indio_dev);
>  
>  	/* reconfiguring trigger hardware state */
>  	if (!iio_buffer_enabled(indio_dev))

