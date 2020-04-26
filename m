Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247411B8E26
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 11:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgDZJRi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 05:17:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726113AbgDZJRi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Apr 2020 05:17:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFD412071C;
        Sun, 26 Apr 2020 09:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587892655;
        bh=Q2mYKlK1Si9g6R1GuzA8ARi9SHUmwvu7FHP+SGE6W0w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SyvEiV3UgMKCtLVf9VUu4RWf+aOtdLAsJFlR2h27EIIj+hzK+YgbrfS4QV3lrsgic
         cJhJ32gmdeuUQz6M/dGz0p5P6ByFNJLnubcSIxHIRTYffr4nLLjKkj3Hqeo+S7OBCM
         FTlo8wCo/BNQyb7NBIn6MkAHlLe8Q+JEhg5B0QzQ=
Date:   Sun, 26 Apr 2020 10:17:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] iio: vcnl4000: Add event support for
 VCNL4010/20.
Message-ID: <20200426101731.2e4eb2b3@archlinux>
In-Reply-To: <20200422130856.1722-3-m.othacehe@gmail.com>
References: <20200422130856.1722-1-m.othacehe@gmail.com>
        <20200422130856.1722-3-m.othacehe@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Apr 2020 15:08:54 +0200
Mathieu Othacehe <m.othacehe@gmail.com> wrote:

> The VCNL4010 and VCNL4020 chips are able to raise interrupts on proximity
> threshold events. Add support for threshold rising and falling events for
> those two chips.
> 
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
One nitpick inline and an observation but looks fine in general.

Please move the scan index stuff to patch 4.

> ---
>  drivers/iio/light/vcnl4000.c | 456 ++++++++++++++++++++++++++++++-----
>  1 file changed, 394 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 695a81e95d8d..4041608910d0 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -13,7 +13,6 @@
>   *
>   * TODO:
>   *   allow to adjust IR current
> - *   proximity threshold and event handling
>   *   periodic ALS/proximity measurement (VCNL4010/20)
>   *   interrupts (VCNL4010/20/40, VCNL4200)
>   */
> @@ -23,7 +22,9 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/interrupt.h>
>  
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> @@ -35,14 +36,22 @@
>  
>  #define VCNL4000_COMMAND	0x80 /* Command register */
>  #define VCNL4000_PROD_REV	0x81 /* Product ID and Revision ID */
> +#define VCNL4010_PROX_RATE      0x82 /* Proximity rate */
>  #define VCNL4000_LED_CURRENT	0x83 /* IR LED current for proximity mode */
>  #define VCNL4000_AL_PARAM	0x84 /* Ambient light parameter register */
> +#define VCNL4010_ALS_PARAM      0x84 /* ALS rate */
>  #define VCNL4000_AL_RESULT_HI	0x85 /* Ambient light result register, MSB */
>  #define VCNL4000_AL_RESULT_LO	0x86 /* Ambient light result register, LSB */
>  #define VCNL4000_PS_RESULT_HI	0x87 /* Proximity result register, MSB */
>  #define VCNL4000_PS_RESULT_LO	0x88 /* Proximity result register, LSB */
>  #define VCNL4000_PS_MEAS_FREQ	0x89 /* Proximity test signal frequency */
> +#define VCNL4010_INT_CTRL	0x89 /* Interrupt control */
>  #define VCNL4000_PS_MOD_ADJ	0x8a /* Proximity modulator timing adjustment */
> +#define VCNL4010_LOW_THR_HI     0x8a /* Low threshold, MSB */
> +#define VCNL4010_LOW_THR_LO     0x8b /* Low threshold, LSB */
> +#define VCNL4010_HIGH_THR_HI    0x8c /* High threshold, MSB */
> +#define VCNL4010_HIGH_THR_LO    0x8d /* High threshold, LSB */
> +#define VCNL4010_ISR		0x8e /* Interrupt status */
>  
>  #define VCNL4200_AL_CONF	0x00 /* Ambient light configuration */
>  #define VCNL4200_PS_CONF1	0x03 /* Proximity configuration */
> @@ -57,6 +66,26 @@
>  #define VCNL4000_PS_RDY		BIT(5) /* proximity data ready? */
>  #define VCNL4000_AL_OD		BIT(4) /* start on-demand ALS measurement */
>  #define VCNL4000_PS_OD		BIT(3) /* start on-demand proximity measurement */
> +#define VCNL4000_ALS_EN		BIT(2) /* start ALS measurement */
> +#define VCNL4000_PROX_EN	BIT(1) /* start proximity measurement */
> +#define VCNL4000_SELF_TIMED_EN	BIT(0) /* start self-timed measurement */
> +
> +/* Bit masks for interrupt registers. */
> +#define VCNL4010_INT_THR_SEL	BIT(0) /* Select threshold interrupt source */
> +#define VCNL4010_INT_THR_EN	BIT(1) /* Threshold interrupt type */
> +#define VCNL4010_INT_ALS_EN	BIT(2) /* Enable on ALS data ready */
> +#define VCNL4010_INT_PROX_EN	BIT(3) /* Enable on proximity data ready */
> +
> +#define VCNL4010_INT_THR_HIGH	0 /* High threshold exceeded */
> +#define VCNL4010_INT_THR_LOW	1 /* Low threshold exceeded */
> +#define VCNL4010_INT_ALS	2 /* ALS data ready */
> +#define VCNL4010_INT_PROXIMITY	3 /* Proximity data ready */
> +
> +#define VCNL4010_INT_THR \
> +	(BIT(VCNL4010_INT_THR_LOW) | BIT(VCNL4010_INT_THR_HIGH))
> +#define VCNL4010_INT_DRDY \
> +	(BIT(VCNL4010_INT_PROXIMITY) | BIT(VCNL4010_INT_ALS))
> +
>  
>  #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
>  
> @@ -88,6 +117,10 @@ struct vcnl4000_data {
>  
>  struct vcnl4000_chip_spec {
>  	const char *prod;
> +	struct iio_chan_spec const *channels;
> +	const int num_channels;
> +	const struct iio_info *info;
> +	bool irq_support;
>  	int (*init)(struct vcnl4000_data *data);
>  	int (*measure_light)(struct vcnl4000_data *data, int *val);
>  	int (*measure_proximity)(struct vcnl4000_data *data, int *val);
> @@ -333,67 +366,16 @@ static int vcnl4200_measure_proximity(struct vcnl4000_data *data, int *val)
>  	return vcnl4200_measure(data, &data->vcnl4200_ps, val);
>  }
>  
> -static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
> -	[VCNL4000] = {
> -		.prod = "VCNL4000",
> -		.init = vcnl4000_init,
> -		.measure_light = vcnl4000_measure_light,
> -		.measure_proximity = vcnl4000_measure_proximity,
> -		.set_power_state = vcnl4000_set_power_state,
> -	},
> -	[VCNL4010] = {
> -		.prod = "VCNL4010/4020",
> -		.init = vcnl4000_init,
> -		.measure_light = vcnl4000_measure_light,
> -		.measure_proximity = vcnl4000_measure_proximity,
> -		.set_power_state = vcnl4000_set_power_state,
> -	},
> -	[VCNL4040] = {
> -		.prod = "VCNL4040",
> -		.init = vcnl4200_init,
> -		.measure_light = vcnl4200_measure_light,
> -		.measure_proximity = vcnl4200_measure_proximity,
> -		.set_power_state = vcnl4200_set_power_state,
> -	},
> -	[VCNL4200] = {
> -		.prod = "VCNL4200",
> -		.init = vcnl4200_init,
> -		.measure_light = vcnl4200_measure_light,
> -		.measure_proximity = vcnl4200_measure_proximity,
> -		.set_power_state = vcnl4200_set_power_state,
> -	},
> -};
> -
> -static ssize_t vcnl4000_read_near_level(struct iio_dev *indio_dev,
> -					uintptr_t priv,
> -					const struct iio_chan_spec *chan,
> -					char *buf)
> +static bool vcnl4010_is_in_periodic_mode(struct vcnl4000_data *data)
>  {
> -	struct vcnl4000_data *data = iio_priv(indio_dev);
> -
> -	return sprintf(buf, "%u\n", data->near_level);
> -}
> +	int ret;
>  
> -static const struct iio_chan_spec_ext_info vcnl4000_ext_info[] = {
> -	{
> -		.name = "nearlevel",
> -		.shared = IIO_SEPARATE,
> -		.read = vcnl4000_read_near_level,
> -	},
> -	{ /* sentinel */ }
> -};
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_COMMAND);
> +	if (ret < 0)
> +		return false;
>  
> -static const struct iio_chan_spec vcnl4000_channels[] = {
> -	{
> -		.type = IIO_LIGHT,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_SCALE),
> -	}, {
> -		.type = IIO_PROXIMITY,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -		.ext_info = vcnl4000_ext_info,
> -	}
> -};
> +	return !!(ret & VCNL4000_SELF_TIMED_EN);
> +}
>  
>  static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
>  {
> @@ -453,10 +435,347 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int vcnl4010_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	int ret;
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		/* Protect against event capture. */
> +		if (vcnl4010_is_in_periodic_mode(data)) {
> +			ret = -EBUSY;
> +		} else {
> +			ret = vcnl4000_read_raw(indio_dev, chan, val, val2,
> +						mask);
> +		}
> +
> +		iio_device_release_direct_mode(indio_dev);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int vcnl4010_read_event(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info,
> +			       int *val, int *val2)
> +{
> +	int ret;
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = vcnl4000_read_data(data, VCNL4010_HIGH_THR_HI,
> +						 val);
> +			if (ret < 0)
> +				return ret;
> +			return IIO_VAL_INT;
> +		case IIO_EV_DIR_FALLING:
> +			ret = vcnl4000_read_data(data, VCNL4010_LOW_THR_HI,
> +						 val);
> +			if (ret < 0)
> +				return ret;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int vcnl4010_write_event(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int val, int val2)
> +{
> +	int ret;
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = vcnl4000_write_data(data, VCNL4010_HIGH_THR_HI,
> +						  val);
> +			if (ret < 0)
> +				return ret;
> +			return IIO_VAL_INT;
> +		case IIO_EV_DIR_FALLING:
> +			ret = vcnl4000_write_data(data, VCNL4010_LOW_THR_HI,
> +						  val);
> +			if (ret < 0)
> +				return ret;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static bool vcnl4010_is_thr_enabled(struct vcnl4000_data *data)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_INT_CTRL);
> +	if (ret < 0)
> +		return false;
> +
> +	return !!(ret & VCNL4010_INT_THR_EN);
> +}
> +
> +static int vcnl4010_read_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir)
> +{
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +
> +	switch (chan->type) {
> +	case IIO_PROXIMITY:
> +		return vcnl4010_is_thr_enabled(data);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int vcnl4010_config_threshold(struct iio_dev *indio_dev, bool state)
> +{
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +	int ret;
> +	int icr;
> +	int command;
> +
> +	if (state) {
> +		ret = iio_device_claim_direct_mode(indio_dev);

Personally I'd probably have taken the simpler approach of taking the
lock in both paths, but this works I think, so fair enough.

> +		if (ret)
> +			return ret;
> +
> +		/* Enable periodic measurement of proximity data. */
> +		command = VCNL4000_SELF_TIMED_EN | VCNL4000_PROX_EN;
> +
> +		/*
> +		 * Enable interrupts on threshold, for proximity data by
> +		 * default.
> +		 */
> +		icr = VCNL4010_INT_THR_EN;
> +	} else {
> +		if (!vcnl4010_is_thr_enabled(data))
> +			return 0;
> +
> +		command = 0;
> +		icr = 0;
> +	}
> +
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND,
> +					command);
> +	if (ret < 0)
> +		goto end;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, icr);
> +
> +end:
> +	if (state)
> +		iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int vcnl4010_write_event_config(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir,
> +				       int state)
> +{
> +	switch (chan->type) {
> +	case IIO_PROXIMITY:
> +		return vcnl4010_config_threshold(indio_dev, state);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t vcnl4000_read_near_level(struct iio_dev *indio_dev,
> +					uintptr_t priv,
> +					const struct iio_chan_spec *chan,
> +					char *buf)
> +{
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%u\n", data->near_level);
> +}
> +
> +static const struct iio_chan_spec_ext_info vcnl4000_ext_info[] = {
> +	{
> +		.name = "nearlevel",
> +		.shared = IIO_SEPARATE,
> +		.read = vcnl4000_read_near_level,
> +	},
> +	{ /* sentinel */ }
> +};
> +
> +static const struct iio_event_spec vcnl4000_event_spec[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	}
> +};
> +
> +static const struct iio_chan_spec vcnl4000_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +	}, {
> +		.type = IIO_PROXIMITY,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.ext_info = vcnl4000_ext_info,
> +	}
> +};
> +
> +static const struct iio_chan_spec vcnl4010_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.scan_index = -1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +	}, {
> +		.type = IIO_PROXIMITY,
> +		.scan_index = 0,

I managed to review v4 failing to notice you'd sent v5.
scan_index should only be introduced in the patch adding buffered
support.

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.event_spec = vcnl4000_event_spec,
> +		.num_event_specs = ARRAY_SIZE(vcnl4000_event_spec),
> +		.ext_info = vcnl4000_ext_info,
> +	},
> +};
> +
>  static const struct iio_info vcnl4000_info = {
>  	.read_raw = vcnl4000_read_raw,
>  };
>  
> +static const struct iio_info vcnl4010_info = {
> +	.read_raw = vcnl4010_read_raw,
> +	.read_event_value = vcnl4010_read_event,
> +	.write_event_value = vcnl4010_write_event,
> +	.read_event_config = vcnl4010_read_event_config,
> +	.write_event_config = vcnl4010_write_event_config,
> +};
> +
> +static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
> +	[VCNL4000] = {
> +		.prod = "VCNL4000",
> +		.init = vcnl4000_init,
> +		.measure_light = vcnl4000_measure_light,
> +		.measure_proximity = vcnl4000_measure_proximity,
> +		.set_power_state = vcnl4000_set_power_state,
> +		.channels = vcnl4000_channels,
> +		.num_channels = ARRAY_SIZE(vcnl4000_channels),
> +		.info = &vcnl4000_info,
> +		.irq_support = false,
> +	},
> +	[VCNL4010] = {
> +		.prod = "VCNL4010/4020",
> +		.init = vcnl4000_init,
> +		.measure_light = vcnl4000_measure_light,
> +		.measure_proximity = vcnl4000_measure_proximity,
> +		.set_power_state = vcnl4000_set_power_state,
> +		.channels = vcnl4010_channels,
> +		.num_channels = ARRAY_SIZE(vcnl4010_channels),
> +		.info = &vcnl4010_info,
> +		.irq_support = true,
> +	},
> +	[VCNL4040] = {
> +		.prod = "VCNL4040",
> +		.init = vcnl4200_init,
> +		.measure_light = vcnl4200_measure_light,
> +		.measure_proximity = vcnl4200_measure_proximity,
> +		.set_power_state = vcnl4200_set_power_state,
> +		.channels = vcnl4000_channels,
> +		.num_channels = ARRAY_SIZE(vcnl4000_channels),
> +		.info = &vcnl4000_info,
> +		.irq_support = false,
> +	},
> +	[VCNL4200] = {
> +		.prod = "VCNL4200",
> +		.init = vcnl4200_init,
> +		.measure_light = vcnl4200_measure_light,
> +		.measure_proximity = vcnl4200_measure_proximity,
> +		.set_power_state = vcnl4200_set_power_state,
> +		.channels = vcnl4000_channels,
> +		.num_channels = ARRAY_SIZE(vcnl4000_channels),
> +		.info = &vcnl4000_info,
> +		.irq_support = false,
> +	},
> +};
> +
> +static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +	unsigned long isr;
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
> +	if (ret < 0)
> +		goto end;
> +
> +	isr = ret;
> +
> +	if (isr & VCNL4010_INT_THR) {
> +		if (test_bit(VCNL4010_INT_THR_LOW, &isr)) {
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(
> +					       IIO_PROXIMITY,
> +					       1,
> +					       IIO_EV_TYPE_THRESH,
> +					       IIO_EV_DIR_FALLING),
> +				       iio_get_time_ns(indio_dev));
> +		}
> +
> +		if (test_bit(VCNL4010_INT_THR_HIGH, &isr)) {
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(
> +					       IIO_PROXIMITY,
> +					       1,
> +					       IIO_EV_TYPE_THRESH,
> +					       IIO_EV_DIR_RISING),
> +				       iio_get_time_ns(indio_dev));
> +		}
> +
> +		i2c_smbus_write_byte_data(data->client, VCNL4010_ISR,
> +					  isr & VCNL4010_INT_THR);
> +	}
> +
> +end:
> +	return IRQ_HANDLED;
> +}
> +
>  static int vcnl4000_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> @@ -486,12 +805,25 @@ static int vcnl4000_probe(struct i2c_client *client,
>  		data->near_level = 0;
>  
>  	indio_dev->dev.parent = &client->dev;
> -	indio_dev->info = &vcnl4000_info;
> -	indio_dev->channels = vcnl4000_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(vcnl4000_channels);
> +	indio_dev->info = data->chip_spec->info;
> +	indio_dev->channels = data->chip_spec->channels;
> +	indio_dev->num_channels = data->chip_spec->num_channels;
>  	indio_dev->name = VCNL4000_DRV_NAME;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	if (client->irq && data->chip_spec->irq_support) {
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						NULL, vcnl4010_irq_thread,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						"vcnl4010_irq",
> +						indio_dev);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "irq request failed\n");
> +			return ret;
> +		}
> +	}
> +
>  	ret = pm_runtime_set_active(&client->dev);
>  	if (ret < 0)
>  		goto fail_poweroff;

