Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAB519EAF1
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 13:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgDELtj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 07:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgDELtj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 07:49:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 323BD206C3;
        Sun,  5 Apr 2020 11:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586087377;
        bh=ckdmhA16PF7oGoOSxRdrLT8XT2UPJWTidOufYsCwNmQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kd8CieSTByKC4rQkteqxzBifm14Jhwc6RCo+4yvP2/Qe9gzg9vhiNMYwO53QZ1mGE
         kKTjpdH+X5U2fTB8xovg5gVYgZ88rc36UiJ1JqAiCMft0PQBwxrjcvy4Q8kqBQ/5GB
         Fssasp0eCfqhSOp5R3DD4KnIXtzw2ZJP0DOVqIsk=
Date:   Sun, 5 Apr 2020 12:49:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH] iio: vcnl4000: Add interrupts support for VCNL4010/20.
Message-ID: <20200405124933.7e94fb6d@archlinux>
In-Reply-To: <20200401123709.3326-1-m.othacehe@gmail.com>
References: <20200401123709.3326-1-m.othacehe@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  1 Apr 2020 14:37:09 +0200
Mathieu Othacehe <m.othacehe@gmail.com> wrote:

> Add interrupt support for VCNL4010 and VCNL4020. Those devices support an
> interruption pin that can be raised on threshold events or on data ready
> events. Use it to add support for threshold falling/rising events and for
> triggered buffer.
> 
> Add sampling frequency support for proximity and illuminance channels.
> 
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>

Hi Mathieu,

I would split this up into patches doing
1) Initial refactoring to make the rest easier
2) Event support
3) Buffered capture support.

For the buffered capture we have a missmatch between the data model of IIO
and what this sensor does due to the lack of alignment between ALS sampling
and proximity sampling.  They are effectively independent data streams.

I give some suggestions inline, but I would probably favour just not adding
support for ambient light capture for the buffered mode.  That way things
are simple and I'd be surprised if anyone cares about that as the sampling
frequency is low enough that the overhead of a sysfs poll is trivial.

Thanks,

Jonathan


> ---
> Hello,
> 
> Here's a patch adding interrupt support for VCNL4010 and VCNL4020.
> 
> Thanks,
> 
> Mathieu
>  drivers/iio/light/Kconfig    |   2 +
>  drivers/iio/light/vcnl4000.c | 888 +++++++++++++++++++++++++++++++++--
>  2 files changed, 841 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 9968f982fbc7..0c066b800743 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -485,6 +485,8 @@ config US5182D
>  
>  config VCNL4000
>  	tristate "VCNL4000/4010/4020/4200 combined ALS and proximity sensor"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	depends on I2C
>  	help
>  	  Say Y here if you want to build a driver for the Vishay VCNL4000,
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index e5b00a6611ac..f11b29a08a05 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -5,6 +5,7 @@
>   *
>   * Copyright 2012 Peter Meerwald <pmeerw@pmeerw.net>
>   * Copyright 2019 Pursim SPC
> + * Copyright 2020 Mathieu Othacehe <m.othacehe@gmail.com>
>   *
>   * IIO driver for:
>   *   VCNL4000/10/20 (7-bit I2C slave address 0x13)
> @@ -14,8 +15,7 @@
>   * TODO:
>   *   allow to adjust IR current
>   *   proximity threshold and event handling
> - *   periodic ALS/proximity measurement (VCNL4010/20)
> - *   interrupts (VCNL4010/20/40, VCNL4200)
> + *   interrupts (VCNL4040, VCNL4200)
>   */
>  
>  #include <linux/module.h>
> @@ -23,8 +23,13 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #define VCNL4000_DRV_NAME "vcnl4000"
>  #define VCNL4000_PROD_ID	0x01
> @@ -43,6 +48,15 @@
>  #define VCNL4000_PS_MEAS_FREQ	0x89 /* Proximity test signal frequency */
>  #define VCNL4000_PS_MOD_ADJ	0x8a /* Proximity modulator timing adjustment */
>  
> +#define VCNL4010_PROX_RATE      0x82 /* Proximity rate */
> +#define VCNL4010_ALS_PARAM      0x84 /* ALS rate */
> +#define VCNL4010_INT_CTRL	0x89 /* Interrupt control */
> +#define VCNL4010_LOW_THR_HI     0x8a /* Low threshold, MSB */
> +#define VCNL4010_LOW_THR_LO     0x8b /* Low threshold, LSB */
> +#define VCNL4010_HIGH_THR_HI    0x8c /* High threshold, MSB */
> +#define VCNL4010_HIGH_THR_LO    0x8d /* High threshold, LSB */
> +#define VCNL4010_ISR		0x8e /* Interrupt status */
> +
>  #define VCNL4200_AL_CONF	0x00 /* Ambient light configuration */
>  #define VCNL4200_PS_CONF1	0x03 /* Proximity configuration */
>  #define VCNL4200_PS_DATA	0x08 /* Proximity data */
> @@ -56,6 +70,37 @@
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
> +#define VCNL4010_ALS_SAMPLING_FREQUENCY_AVAILABLE \
> +	"1 2 3 4 5 6 8 10"
> +#define VCNL4010_PROXIMITY_SAMPLING_FREQUENCY_AVAILABLE  \
> +	"1.95 3.90 7.81 16.62 31.25 62.5 125 250"
> +
> +static const int vcnl4010_als_sampling_frequency[] = {
> +	1, 2, 3, 4, 5, 6, 8, 10};
> +static const int vcnl4010_prox_sampling_frequency[][2] = {
> +	{1, 950000}, {3, 906250}, {7, 812500}, {16, 625000},
> +	{31, 250000}, {62, 500000}, {125, 0}, {250, 0}
> +};

Clearly takes more space, but I'd rather see that as one value per line.

>  
>  enum vcnl4000_device_ids {
>  	VCNL4000,
> @@ -84,6 +129,10 @@ struct vcnl4000_data {
>  
>  struct vcnl4000_chip_spec {
>  	const char *prod;
> +	struct iio_chan_spec const *channels;
> +	const int no_channels;

Call it num_channels.  I briefly wondered why we had a flag to indicate
NO channels ;)

> +	const struct iio_info *info;
> +	bool irq_support;
>  	int (*init)(struct vcnl4000_data *data);
>  	int (*measure_light)(struct vcnl4000_data *data, int *val);
>  	int (*measure_proximity)(struct vcnl4000_data *data, int *val);
> @@ -189,11 +238,53 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  	return 0;
>  };
>  
> +static int vcnl4000_read_data(struct vcnl4000_data *data, u8 data_reg,
> +				 int *val)
> +{
> +	__be16 buf;
> +	int ret;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_read_i2c_block_data(data->client,
> +		data_reg, sizeof(buf), (u8 *) &buf);
> +	if (ret < 0)
> +		goto fail;
> +
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	*val = be16_to_cpu(buf);
> +fail:
> +	mutex_unlock(&data->vcnl4000_lock);

In the good path, that's a double unlock.

> +	return ret;
> +}
> +
> +static int vcnl4000_write_data(struct vcnl4000_data *data, u8 data_reg,
> +			       u16 val)
> +{
> +	int ret;
> +
> +	if (val > U16_MAX)
> +		return -ERANGE;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_write_byte_data(data->client, data_reg, val >> 8);
> +	if (ret < 0)
> +		goto end;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, data_reg + 1,
> +					val);

Looks like it will fit on one line to me.

> +end:
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	return ret;
> +}
> +
>  static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
> -				u8 rdy_mask, u8 data_reg, int *val)
> +			    u8 rdy_mask, u8 data_reg, int *val)

Check patch for white space changes like this. They just add noise in a patch
doing something useful so shouldn't be here.

>  {
>  	int tries = 20;
> -	__be16 buf;
>  	int ret;
>  
>  	mutex_lock(&data->vcnl4000_lock);
> @@ -220,14 +311,9 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
>  		goto fail;
>  	}
>  
> -	ret = i2c_smbus_read_i2c_block_data(data->client,
> -		data_reg, sizeof(buf), (u8 *) &buf);
> -	if (ret < 0)
> -		goto fail;
> -
>  	mutex_unlock(&data->vcnl4000_lock);
> -	*val = be16_to_cpu(buf);
>  
> +	ret = vcnl4000_read_data(data, data_reg, val);

Pull this refactoring out to a separate patch.

However, I don't like the drop the lock and take it again.  Do an unlocked version
of the read_data function.


>  	return 0;
>  
>  fail:
> @@ -286,43 +372,69 @@ static int vcnl4200_measure_proximity(struct vcnl4000_data *data, int *val)
>  	return vcnl4200_measure(data, &data->vcnl4200_ps, val);
>  }
>  
> -static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
> -	[VCNL4000] = {
> -		.prod = "VCNL4000",
> -		.init = vcnl4000_init,
> -		.measure_light = vcnl4000_measure_light,
> -		.measure_proximity = vcnl4000_measure_proximity,
> -	},
> -	[VCNL4010] = {
> -		.prod = "VCNL4010/4020",
> -		.init = vcnl4000_init,
> -		.measure_light = vcnl4000_measure_light,
> -		.measure_proximity = vcnl4000_measure_proximity,
> -	},
> -	[VCNL4040] = {
> -		.prod = "VCNL4040",
> -		.init = vcnl4200_init,
> -		.measure_light = vcnl4200_measure_light,
> -		.measure_proximity = vcnl4200_measure_proximity,
> -	},
> -	[VCNL4200] = {
> -		.prod = "VCNL4200",
> -		.init = vcnl4200_init,
> -		.measure_light = vcnl4200_measure_light,
> -		.measure_proximity = vcnl4200_measure_proximity,
> -	},
> -};
> +static int vcnl4010_read_proxy_samp_freq(struct vcnl4000_data *data, int *val,
> +					 int *val2)
> +{
> +	int ret;
>  
> -static const struct iio_chan_spec vcnl4000_channels[] = {
> -	{
> -		.type = IIO_LIGHT,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_SCALE),
> -	}, {
> -		.type = IIO_PROXIMITY,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -	}
> -};
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_PROX_RATE);
> +	if (ret < 0)
> +		goto end;
> +
> +	if (ret >= ARRAY_SIZE(vcnl4010_prox_sampling_frequency))
> +		return -EINVAL;
> +
> +	*val = vcnl4010_prox_sampling_frequency[ret][0];
> +	*val2 = vcnl4010_prox_sampling_frequency[ret][1];
> +end:
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	return ret;
> +}
> +
> +static int vcnl4010_read_als_samp_freq(struct vcnl4000_data *data, int *val)
> +{
> +	int ret;
> +	int index, mask = 0x70;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ALS_PARAM);
> +	if (ret < 0)
> +		goto end;
> +
> +	index = (ret & mask) >> 4;
> +	if (index < 0 || index >= ARRAY_SIZE(vcnl4010_als_sampling_frequency))
> +		return -EINVAL;
> +
> +	*val = vcnl4010_als_sampling_frequency[index];
> +end:
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	return ret;
> +}
> +
> +static int vcnl4010_periodic_mode(struct vcnl4000_data *data)

Not clear from naming that this is 'checking' if we are in periodic
code rather than setting it.

> +{
> +	int ret;
> +	int command;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_COMMAND);
> +	if (ret < 0)
> +		goto end;
> +
> +	command = ret;
> +	ret = command & VCNL4000_SELF_TIMED_EN;

Why bother with comamnd?

> +
> +end:
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	return ret;
> +}
>  
>  static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  				struct iio_chan_spec const *chan,
> @@ -359,10 +471,660 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int vcnl4010_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	int ret;
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +
> +	if (vcnl4010_periodic_mode(data)) {

I 'think' this means you are in buffered mode. In which case use the core
function iio_device_claim_direct_mode to do this safely as it protects
against a race here in which we enter periodic mode part way through this
function.

It is a bit unusual to have to protect the frequency 'reads' though.

Ah. Thinking more are you also protecting against event capture here?
If so you need to do both, claim direct to prevent a state transition and
check your periodic mode to avoid the case where events are enabled but
the buffer isn't.  Avoiding races around event enabling gets tricky
though.

 
> +		ret = -EBUSY;
> +		goto end;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			ret = vcnl4010_read_proxy_samp_freq(data, val, val2);
> +			if (ret < 0)
> +				return ret;
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +			goto end;
> +		case IIO_LIGHT:
> +			ret = vcnl4010_read_als_samp_freq(data, val);
> +			if (ret < 0)
> +				return ret;
> +			ret = IIO_VAL_INT;
> +			goto end;
> +		default:
> +			ret = -EINVAL;
> +			goto end;
> +		}
> +	default:

Make this explicit rather than default.  Default should be the error cases ideally.

> +		ret = vcnl4000_read_raw(indio_dev, chan, val, val2, mask);
> +	}
> +
> +end:
> +	return ret;
> +}
> +
> +static int vcnl4010_write_proxy_samp_freq(struct vcnl4000_data *data, int val,
> +					  int val2)
> +{
> +	int ret;
> +	int i;
> +	int len = ARRAY_SIZE(vcnl4010_prox_sampling_frequency);
> +
> +	for (i = 0; i < len; i++) {
> +		if (val <= vcnl4010_prox_sampling_frequency[i][0])
> +			break;
> +	}
> +
> +	if (i == len)
> +		i--;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_PROX_RATE, i);
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	return ret;
> +}
> +
> +static int vcnl4010_write_als_samp_freq(struct vcnl4000_data *data, int val)
> +{
> +	int ret;
> +	int i;
> +	int param;
> +	int mask = 0x70;
> +	int len = ARRAY_SIZE(vcnl4010_als_sampling_frequency);
> +
> +	for (i = 0; i < len; i++) {
> +		if (val <= vcnl4010_als_sampling_frequency[i])
> +			break;
> +	}
> +
> +	if (i == len)

I would reject it as invalid.  We are asking for a higher frequency than
the device supports.

> +		i--;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ALS_PARAM);
> +	if (ret < 0)
> +		goto end;
> +
> +	param = (ret & ~mask) | (i << 4);
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_ALS_PARAM,
> +					param);
> +end:
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	return ret;
> +}
> +
> +static int vcnl4010_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	int ret;
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +
> +	if (vcnl4010_periodic_mode(data)) {

As above *_claim_direct_mode

> +		ret = -EBUSY;
> +		goto end;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		switch (chan->type) {
> +		case IIO_PROXIMITY:
> +			ret = vcnl4010_write_proxy_samp_freq(data, val, val2);
> +			if (ret < 0)
> +				return ret;
> +			goto end;
> +		case IIO_LIGHT:
> +			ret = vcnl4010_write_als_samp_freq(data, val);
> +			if (ret < 0)
> +				return ret;
> +			goto end;
> +		default:
> +			ret = -EINVAL;
> +			goto end;
> +		}
> +	default:
> +		ret = -EINVAL;
> +		goto end;
> +	}
> +
> +end:
> +	return ret;
> +}
> +
> +static int vcnl4010_read_event(struct iio_dev *indio_dev,

I would add event support in a separate patch to buffered capture.
Makes for a more 'bite sized' patch and hence easier to review.

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
> +static int vcnl4010_thr_enabled(struct vcnl4000_data *data)
> +{
> +	int ret;
> +	int icr;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_INT_CTRL);
> +	if (ret < 0)
> +		goto end;
> +
> +	icr = ret;
> +	ret = icr & VCNL4010_INT_THR_EN;

Skip the intermediate icr, it doesn't add anything to readability.

> +
> +end:
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	return ret;
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
> +		return vcnl4010_thr_enabled(data);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int vcnl4010_prox_threshold(struct iio_dev *indio_dev, int state)
> +{
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +	int ret;
> +	int icr;
> +	int command;
> +
> +	if (state) {
> +		if (vcnl4010_periodic_mode(data))
> +			return -EBUSY;
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
> +		if (!vcnl4010_thr_enabled(data))
> +			return 0;
> +
> +		command = 0;
> +		icr = 0;
> +	}
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND,
> +					command);
> +	if (ret < 0)
> +		goto end;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, icr);
> +
> +end:
> +	mutex_unlock(&data->vcnl4000_lock);
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
> +		return vcnl4010_prox_threshold(indio_dev, state);
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
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
> +	}
> +};
> +
> +#define VCNL4010_ALS_SCAN_INDEX 0
> +#define VCNL4010_PROXIMITY_SCAN_INDEX 1
> +#define VCNL4010_TIMESTAMP_SCAN_INDEX 2

These are just 'values' rather than magic numbers. I'd just put
the value inline and drop the defines.

> +
> +static const struct iio_chan_spec vcnl4010_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.scan_index = VCNL4010_ALS_SCAN_INDEX,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_CPU,

Hmm. It's only in CPU endianness because you process it in the driver.
I'd prefer it to go through in big endian, but as the device is fairly
slow I suppose to doesn't do much harm to leave it as you have it.

> +		},
> +	}, {
> +		.type = IIO_PROXIMITY,
> +		.scan_index = VCNL4010_PROXIMITY_SCAN_INDEX,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.event_spec = vcnl4000_event_spec,
> +		.num_event_specs = ARRAY_SIZE(vcnl4000_event_spec),
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(VCNL4010_TIMESTAMP_SCAN_INDEX),
> +};
> +
> +static IIO_CONST_ATTR(in_illuminance_sampling_frequency_available,
> +		      VCNL4010_ALS_SAMPLING_FREQUENCY_AVAILABLE);
> +static IIO_CONST_ATTR(in_proximity_sampling_frequency_available,
> +		      VCNL4010_PROXIMITY_SAMPLING_FREQUENCY_AVAILABLE);
> +
> +static struct attribute *vcnl4010_attributes[] = {
> +	&iio_const_attr_in_illuminance_sampling_frequency_available.dev_attr.attr,
> +	&iio_const_attr_in_proximity_sampling_frequency_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group vcnl4010_attribute_group = {
> +	.attrs = vcnl4010_attributes
> +};
> +
>  static const struct iio_info vcnl4000_info = {
>  	.read_raw = vcnl4000_read_raw,
>  };
>  
> +static const struct iio_info vcnl4010_info = {
> +	.read_raw = vcnl4010_read_raw,
> +	.write_raw = vcnl4010_write_raw,
> +	.read_event_value = vcnl4010_read_event,
> +	.write_event_value = vcnl4010_write_event,
> +	.read_event_config = vcnl4010_read_event_config,
> +	.write_event_config = vcnl4010_write_event_config,
> +	.attrs    = &vcnl4010_attribute_group,
> +};
> +
> +static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
> +	[VCNL4000] = {
> +		.prod = "VCNL4000",
> +		.init = vcnl4000_init,
> +		.measure_light = vcnl4000_measure_light,
> +		.measure_proximity = vcnl4000_measure_proximity,
> +		.channels = vcnl4000_channels,
> +		.no_channels = ARRAY_SIZE(vcnl4000_channels),
> +		.info = &vcnl4000_info,
> +		.irq_support = false,
> +	},
> +	[VCNL4010] = {
> +		.prod = "VCNL4010/4020",
> +		.init = vcnl4000_init,
> +		.measure_light = vcnl4000_measure_light,
> +		.measure_proximity = vcnl4000_measure_proximity,
> +		.channels = vcnl4010_channels,
> +		.no_channels = ARRAY_SIZE(vcnl4010_channels),
> +		.info = &vcnl4010_info,
> +		.irq_support = true,
> +	},
> +	[VCNL4040] = {
> +		.prod = "VCNL4040",
> +		.init = vcnl4200_init,
> +		.measure_light = vcnl4200_measure_light,
> +		.measure_proximity = vcnl4200_measure_proximity,
> +		.channels = vcnl4000_channels,
> +		.no_channels = ARRAY_SIZE(vcnl4000_channels),
> +		.info = &vcnl4000_info,
> +		.irq_support = false,
> +	},
> +	[VCNL4200] = {
> +		.prod = "VCNL4200",
> +		.init = vcnl4200_init,
> +		.measure_light = vcnl4200_measure_light,
> +		.measure_proximity = vcnl4200_measure_proximity,
> +		.channels = vcnl4000_channels,
> +		.no_channels = ARRAY_SIZE(vcnl4000_channels),
> +		.info = &vcnl4000_info,
> +		.irq_support = false,
> +	},
> +};
> +
> +static int vcnl4010_read_isr(struct vcnl4000_data *data, unsigned long *isr)

Why unsigned long or isr?  I'd just return the value in ret.
Further there is nothing particularly special about this read_isr and write_isr
below. I'd just put the lock and i2c calls inline.

> +{
> +	int ret;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
> +	if (ret < 0)
> +		goto end;
> +
> +	*isr = ret;
> +end:
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	return ret;
> +}
> +
> +static int vcnl4010_write_isr(struct vcnl4000_data *data, unsigned long isr)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_ISR, isr);
> +
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +	unsigned long isr;
> +	int ret;
> +
> +	ret = vcnl4010_read_isr(data, &isr);
> +	if (ret < 0)
> +		goto end;
> +
> +	if (isr & VCNL4010_INT_THR) {
> +		if (test_bit(VCNL4010_INT_THR_LOW, &isr)) {
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(
> +					       IIO_PROXIMITY,
> +					       VCNL4010_PROXIMITY_SCAN_INDEX,
> +					       IIO_EV_TYPE_THRESH,
> +					       IIO_EV_DIR_FALLING),
> +				       iio_get_time_ns(indio_dev));
> +		}
> +
> +		if (test_bit(VCNL4010_INT_THR_HIGH, &isr)) {
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(
> +					       IIO_PROXIMITY,
> +					       VCNL4010_PROXIMITY_SCAN_INDEX,
> +					       IIO_EV_TYPE_THRESH,
> +					       IIO_EV_DIR_RISING),
> +				       iio_get_time_ns(indio_dev));
> +		}
> +
> +		ret = vcnl4010_write_isr(data, isr & VCNL4010_INT_THR);
> +		if (ret < 0)
> +			goto end;
> +	}
> +
> +	if (isr & VCNL4010_INT_DRDY && iio_buffer_enabled(indio_dev))
> +		iio_trigger_poll_chained(indio_dev->trig);
> +
> +end:
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t vcnl4010_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +	const unsigned long *active_scan_mask = indio_dev->active_scan_mask;
> +	u16 buffer[8] = {0}; /* 2x16-bit + ts */
> +	int i = 0;
> +	unsigned long isr;
> +	int val = 0;
> +	int ret;
> +
> +	ret = vcnl4010_read_isr(data, &isr);
> +	if (ret < 0)
> +		goto end;
> +
> +	if (test_bit(VCNL4010_ALS_SCAN_INDEX, active_scan_mask)) {
> +		if (test_bit(VCNL4010_INT_ALS, &isr)) {
> +			ret = vcnl4000_read_data(data,
> +						 VCNL4000_AL_RESULT_HI,
> +						 &val);
> +			if (ret < 0)
> +				goto end;
> +
> +			buffer[i++] = val;
> +		} else {
> +			/* ALS data is not ready. */

Hmm.  I hate devices that sample sensors at entirely different rates.
They don't really fit in the IIO framework at all as it assumes a given device
samples all channels in a 'scan'.

Marking them as 0 isn't really standard either if they aren't present (as 0 light
is presumably possible).

So there are various options but not all can be retrofit onto a device driver
1) Register multiple IIO devices so we can have a separate buffer with separate
   sampling frequency.
2) Think hard about usecases. I 'doubt' people actually care about buffered sampling of
   the ambient light sensor on here. It's extremely slow for starters... They want
   to do fast sampling of the character device.  Hence I'd think about just supporting
   that.   If we do that, the whole interface becomes much more useable and predictable.
3) Wait for the multiple buffer support that is currently under discussion (perhaps
   having done 2 in the meantime!)

> +			buffer[i++] = 0;
> +		}
> +
> +	}
> +
> +	if (test_bit(VCNL4010_PROXIMITY_SCAN_INDEX, active_scan_mask)) {
> +		if (test_bit(VCNL4010_INT_PROXIMITY, &isr)) {
> +			ret = vcnl4000_read_data(data,
> +						 VCNL4000_PS_RESULT_HI,
> +						 &val);
> +			if (ret < 0)
> +				goto end;
> +
> +			buffer[i++] = val;
> +		} else {
> +			/* Proximity data is not ready. */
> +			buffer[i++] = 0;
> +		}
> +
> +	}
> +
> +	ret = vcnl4010_write_isr(data, isr & VCNL4010_INT_DRDY);
> +	if (ret < 0)
> +		goto end;
> +
> +	/* No available data. */
> +	if (!val)
> +		goto end;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> +					   iio_get_time_ns(indio_dev));
> +
> +end:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static int vcnl4010_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +	const unsigned long *active_scan_mask = indio_dev->active_scan_mask;
> +	int ret;
> +	int int_ctrl = 0;
> +	int command = VCNL4000_SELF_TIMED_EN;
> +
> +	if (test_bit(VCNL4010_ALS_SCAN_INDEX, active_scan_mask)) {
> +		int_ctrl |= VCNL4010_INT_ALS_EN;
> +		command |= VCNL4000_ALS_EN;
> +	}
> +
> +	if (test_bit(VCNL4010_PROXIMITY_SCAN_INDEX, active_scan_mask)) {
> +		int_ctrl |= VCNL4010_INT_PROX_EN;
> +		command |= VCNL4000_PROX_EN;
> +	}
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL,
> +					int_ctrl);
> +	if (ret < 0)
> +		goto end;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND,
> +					command);
> +	if (ret < 0)
> +		goto end;
> +
> +end:
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	ret = iio_triggered_buffer_postenable(indio_dev);

Why are you carrying on after a failure?  Also note that Alexandru has been
spending a lot of time dragging all these functions into a common form
so as to drop explicit calling of iio_triggered_buffer_postenable and I'm fairly
sure this breaks from the standard form.


> +
> +	return ret;
> +}
> +
> +static int vcnl4010_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = iio_triggered_buffer_predisable(indio_dev);
> +	if (ret < 0)
> +		goto end;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, 0);
> +	if (ret < 0)
> +		goto end;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
> +
> +end:
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops vcnl4010_buffer_ops = {
> +	.postenable = &vcnl4010_buffer_postenable,
> +	.predisable = &vcnl4010_buffer_predisable,
> +};
> +
> +static const struct iio_trigger_ops vcnl4010_trigger_ops = {
> +	.validate_device = iio_trigger_validate_own_device,
> +};
> +
> +static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
> +{
> +	struct vcnl4000_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	struct iio_trigger *trigger;
> +	int ret;
> +
> +	trigger = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
> +					 indio_dev->name, indio_dev->id);
> +	if (!trigger)
> +		return -ENOMEM;
> +
> +	trigger->dev.parent = &client->dev;
> +	trigger->ops = &vcnl4010_trigger_ops;
> +	iio_trigger_set_drvdata(trigger, indio_dev);
> +
> +	ret = devm_iio_trigger_register(&client->dev, trigger);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig = trigger;

We normally leave this to userspace...  If you 'really' want to do it
then should be

indio_dev->trig = iio_trigger_get(data->trig);  Otherwise there is a path
by which you can get a double free (I think its' manually detach the
trigger then remove them module but can't quite remember).


> +
> +	return 0;
> +}
> +
>  static int vcnl4000_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> @@ -388,12 +1150,39 @@ static int vcnl4000_probe(struct i2c_client *client,
>  		data->chip_spec->prod, data->rev);
>  
>  	indio_dev->dev.parent = &client->dev;
> -	indio_dev->info = &vcnl4000_info;
> -	indio_dev->channels = vcnl4000_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(vcnl4000_channels);
> +	indio_dev->info = data->chip_spec->info;
> +	indio_dev->channels = data->chip_spec->channels;
> +	indio_dev->num_channels = data->chip_spec->no_channels;
>  	indio_dev->name = VCNL4000_DRV_NAME;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	if (client->irq && data->chip_spec->irq_support) {
> +		ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
> +						      iio_pollfunc_store_time,

Given you use a chained call for the trigger the top half will never get called anyway.

> +						      vcnl4010_trigger_handler,
> +						      &vcnl4010_buffer_ops);
> +		if (ret < 0) {
> +			dev_err(&client->dev,
> +				"unable to setup iio triggered buffer\n");
> +			return ret;
> +		}
> +
> +		ret = devm_request_threaded_irq(&client->dev, client->irq,
> +						NULL, vcnl4010_irq_thread,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						"vncl4010_irq",
> +						indio_dev);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "irq request failed\n");
> +			return ret;
> +		}
> +
> +		ret = vcnl4010_probe_trigger(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
> @@ -434,5 +1223,6 @@ static struct i2c_driver vcnl4000_driver = {
>  module_i2c_driver(vcnl4000_driver);
>  
>  MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
> +MODULE_AUTHOR("Mathieu Othacehe <m.othacehe@gmail.com>");
>  MODULE_DESCRIPTION("Vishay VCNL4000 proximity/ambient light sensor driver");
>  MODULE_LICENSE("GPL");

