Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D809F23FE5C
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 15:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgHINL3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 09:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgHINL3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 09:11:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFA90206B2;
        Sun,  9 Aug 2020 13:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596978688;
        bh=aP0hY9bkhbgRPx2mfyyskgRknbTRhqk2sfjNWJgD8Es=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nqGWlrx0HWvaCMZjCoUt27D5lQeTJyRLBtcJxNOVRKsshq7bHcpmL+1uzYBk1+HdT
         9webwVzi/PWPIsCln8voZow9K1gW2XF5jkycXtPhdQad3Qh3G7kTiSvP9Scc4gi0/9
         cJSTsHMVzJbYdiMpxM/ftgJf3MFjIWCuePIpVSFM=
Date:   Sun, 9 Aug 2020 14:11:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] iio: accel: adxl372: Add support for FIFO peak
 mode
Message-ID: <20200809141124.2d2dba56@archlinux>
In-Reply-To: <20200803172219.33911-2-alexandru.tachici@analog.com>
References: <20200803172219.33911-1-alexandru.tachici@analog.com>
        <20200803172219.33911-2-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 3 Aug 2020 20:22:17 +0300
<alexandru.tachici@analog.com> wrote:

> From: Stefan Popa <stefan.popa@analog.com>
> 
> By default, if all three channels (x, y, z) are enabled, sample sets of
> concurrent 3-axis data is stored in the FIFO. This patch adds the option
> to configure the FIFO to store peak acceleration (x, y and z) of every
> over-threshold event. When pushing to iio buffer we push only enabled
> axis data.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Hi Stefan,

A few things inline I missed on previous reads.

Jonathan

> ---
>  drivers/iio/accel/adxl372.c | 72 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 67b8817995c0..cce25cde6252 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -133,6 +133,9 @@
>  
>  /* The ADXL372 includes a deep, 512 sample FIFO buffer */
>  #define ADXL372_FIFO_SIZE			512
> +#define ADXL372_X_AXIS_EN(x)			(((x) >> 0) & 0x1)
I hadn't noticed this before, but this is a slightly odd construct.
Would be more normal to check against the  mask directly, so
something like...

((x) & BIT(0))
((x) & BIT(1))

> +#define ADXL372_Y_AXIS_EN(x)			(((x) >> 1) & 0x1)
> +#define ADXL372_Z_AXIS_EN(x)			(((x) >> 2) & 0x1)
>  
>  /*
>   * At +/- 200g with 12-bit resolution, scale is computed as:
> @@ -251,8 +254,10 @@ struct adxl372_state {
>  	struct device			*dev;
>  	struct regmap			*regmap;
>  	struct iio_trigger		*dready_trig;
> +	struct iio_trigger		*peak_datardy_trig;
>  	enum adxl372_fifo_mode		fifo_mode;
>  	enum adxl372_fifo_format	fifo_format;
> +	unsigned int			fifo_axis_mask;
>  	enum adxl372_op_mode		op_mode;
>  	enum adxl372_act_proc_mode	act_proc_mode;
>  	enum adxl372_odr		odr;
> @@ -264,6 +269,7 @@ struct adxl372_state {
>  	u8				int2_bitmask;
>  	u16				watermark;
>  	__be16				fifo_buf[ADXL372_FIFO_SIZE];
> +	bool				peak_fifo_mode_en;
>  };
>  
>  static const unsigned long adxl372_channel_masks[] = {
> @@ -522,6 +528,22 @@ static int adxl372_get_status(struct adxl372_state *st,
>  	return ret;
>  }
>  
> +static void adxl372_arrange_axis_data(struct adxl372_state *st, __be16 *sample)
> +{
> +	__be16	axis_sample[3];
> +	int i = 0;
> +
> +	memset(axis_sample, 0, 3 * sizeof(__be16));
> +	if (ADXL372_X_AXIS_EN(st->fifo_axis_mask))
> +		axis_sample[i++] = sample[0];
> +	if (ADXL372_Y_AXIS_EN(st->fifo_axis_mask))
> +		axis_sample[i++] = sample[1];
> +	if (ADXL372_Z_AXIS_EN(st->fifo_axis_mask))
> +		axis_sample[i++] = sample[2];
> +
> +	memcpy(sample, axis_sample, 3 * sizeof(__be16));
> +}
> +
>  static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -553,8 +575,12 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
>  			goto err;
>  
>  		/* Each sample is 2 bytes */
> -		for (i = 0; i < fifo_entries; i += st->fifo_set_size)
> +		for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
> +			/* filter peak detection data */
> +			if (st->peak_fifo_mode_en)
> +				adxl372_arrange_axis_data(st, &st->fifo_buf[i]);
>  			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
> +		}
>  	}
>  err:
>  	iio_trigger_notify_done(indio_dev->trig);
> @@ -815,13 +841,22 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
>  	}
>  
>  	st->fifo_format = adxl372_axis_lookup_table[i].fifo_format;
> +	st->fifo_axis_mask = adxl372_axis_lookup_table[i].bits;
>  	st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
>  					  indio_dev->masklength);
> +
> +	/* Configure the FIFO to store sets of impact event peak. */
> +	if (st->peak_fifo_mode_en) {
> +		st->fifo_set_size = 3;
> +		st->fifo_format = ADXL372_XYZ_PEAK_FIFO;
> +	}
> +
>  	/*
>  	 * The 512 FIFO samples can be allotted in several ways, such as:
>  	 * 170 sample sets of concurrent 3-axis data
>  	 * 256 sample sets of concurrent 2-axis data (user selectable)
>  	 * 512 sample sets of single-axis data
> +	 * 170 sets of impact event peak (x, y, z)
>  	 */
>  	if ((st->watermark * st->fifo_set_size) > ADXL372_FIFO_SIZE)
>  		st->watermark = (ADXL372_FIFO_SIZE  / st->fifo_set_size);
> @@ -876,7 +911,7 @@ static int adxl372_validate_trigger(struct iio_dev *indio_dev,
>  {
>  	struct adxl372_state *st = iio_priv(indio_dev);
>  
> -	if (st->dready_trig != trig)
> +	if (st->dready_trig != trig && st->peak_datardy_trig != trig)
>  		return -EINVAL;
>  
>  	return 0;
> @@ -887,6 +922,25 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
>  	.set_trigger_state = adxl372_dready_trig_set_state,
>  };
>  
> +static int adxl372_peak_dready_trig_set_state(struct iio_trigger *trig,
> +					      bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +
> +	if (state)
> +		st->int1_bitmask |= ADXL372_INT1_MAP_FIFO_FULL_MSK;

The original driver usage of int1_bitmask seems rather odd.
There is a state variable for it, but it's not ever used.

Here we seem to set this bit, but it is never cleared anywhere.

If we don't actually need to store it globally, perhaps drop the
variable in st?


> +
> +	st->peak_fifo_mode_en = state;
> +
> +	return adxl372_set_interrupts(st, st->int1_bitmask, 0);
> +}
> +
> +static const struct iio_trigger_ops adxl372_peak_data_trigger_ops = {
> +	.validate_device = &iio_trigger_validate_own_device,
> +	.set_trigger_state = adxl372_peak_dready_trig_set_state,
> +};
> +
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
>  static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
>  		       0444, adxl372_show_filter_freq_avail, NULL, 0);
> @@ -965,13 +1019,27 @@ int adxl372_probe(struct device *dev, struct regmap *regmap,
>  		if (st->dready_trig == NULL)
>  			return -ENOMEM;
>  
> +		st->peak_datardy_trig = devm_iio_trigger_alloc(dev,
> +							       "%s-dev%d-peak",
> +							       indio_dev->name,
> +							       indio_dev->id);
> +		if (!st->peak_datardy_trig)
> +			return -ENOMEM;
> +
>  		st->dready_trig->ops = &adxl372_trigger_ops;
> +		st->peak_datardy_trig->ops = &adxl372_peak_data_trigger_ops;
>  		st->dready_trig->dev.parent = dev;
> +		st->peak_datardy_trig->dev.parent = dev;
>  		iio_trigger_set_drvdata(st->dready_trig, indio_dev);
> +		iio_trigger_set_drvdata(st->peak_datardy_trig, indio_dev);
>  		ret = devm_iio_trigger_register(dev, st->dready_trig);
>  		if (ret < 0)
>  			return ret;
>  
> +		ret = devm_iio_trigger_register(dev, st->peak_datardy_trig);
> +		if (ret < 0)
> +			return ret;
> +
>  		indio_dev->trig = iio_trigger_get(st->dready_trig);
>  
>  		ret = devm_request_threaded_irq(dev, st->irq,

