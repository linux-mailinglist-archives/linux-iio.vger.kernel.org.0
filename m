Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABA117CE0D
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 13:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgCGMPQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 07:15:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:53416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgCGMPP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 07:15:15 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E390206D5;
        Sat,  7 Mar 2020 12:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583583315;
        bh=swjbPZsjwyYGkWKjMPGgDWT6H3gVa79oH1QNna5nIeg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nj8SOrgy83YvxzIuzf9bGlm4QJ29ZdTP6slxRV/8dpTrFb6LNhIY4507njJj11Rha
         WRY3DMHKcpvTUEtDz2CG/twz9ZOUKJradAduEp3Ty3mokU9oOUOzUN2cUV48JLkgT6
         8zyOa4E+XWclBBGEXQGNNoyf+VL+BheB3gmoSQFg=
Date:   Sat, 7 Mar 2020 12:15:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] iio: accel: adxl372: add sysfs for time
 registers
Message-ID: <20200307121510.01ebdd93@archlinux>
In-Reply-To: <20200225120909.12629-3-alexandru.tachici@analog.com>
References: <20200225120909.12629-1-alexandru.tachici@analog.com>
        <20200225120909.12629-3-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Feb 2020 14:09:05 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> Currently the driver configures adxl372 to work in loop mode.
> The inactivity and activity timings  decide how fast the chip
> will loop through the awake and waiting states.
> 
> This patch adds standard events sysfs entries for the inactivity
> and activity timings: thresh_falling_period/thresh_rising_period.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
I think this is a rare occasion where combining a couple of patches would
have made it easier to see the whole scope of the 'event' side of things.

Reality is that we need to configure enable / threshold  and period for
this to make any sense, so I'd put them all in one patch.

(noting that enable doesn't seem to exist currently..)

For the enable, we will definitely want to be able to turn these off.
Not all users are going to open the even interface as they may not care
what state we are in, just about the data that they get from the fifo.

Jonathan

> ---
>  drivers/iio/accel/adxl372.c | 68 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index ed93534f8dba..5da3c924c62d 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -222,6 +222,18 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
>  	{ BIT(0) | BIT(1) | BIT(2), ADXL372_XYZ_FIFO },
>  };
>  
> +static const struct iio_event_spec adxl372_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
> +	},
> +};
> +
>  #define ADXL372_ACCEL_CHANNEL(index, reg, axis) {			\
>  	.type = IIO_ACCEL,						\
>  	.address = reg,							\
> @@ -238,6 +250,8 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
>  		.storagebits = 16,					\
>  		.shift = 4,						\
>  	},								\
> +	.event_spec = adxl372_events,					\
> +	.num_event_specs = 2						\
>  }
>  
>  static const struct iio_chan_spec adxl372_channels[] = {
> @@ -723,6 +737,58 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +int adxl372_read_event_value(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan,
> +			     enum iio_event_type type,
> +			     enum iio_event_direction dir,
> +			     enum iio_event_info info, int *val, int *val2)
> +{
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_EV_INFO_PERIOD:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			*val = st->act_time_ms;
> +			*val2 = 1000;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_EV_DIR_FALLING:
> +			*val = st->inact_time_ms;
> +			*val2 = 1000;
> +			return IIO_VAL_FRACTIONAL;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +int adxl372_write_event_value(struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan,
> +			      enum iio_event_type type,
> +			      enum iio_event_direction dir,
> +			      enum iio_event_info info, int val, int val2)
> +{
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +	unsigned int val_ms;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_PERIOD:
> +		val_ms = val * 1000 + DIV_ROUND_UP(val2, 1000);
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			return adxl372_set_activity_time_ms(st, val_ms);
> +		case IIO_EV_DIR_FALLING:
> +			return adxl372_set_inactivity_time_ms(st, val_ms);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static ssize_t adxl372_peak_fifo_en_get(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
> @@ -952,6 +1018,8 @@ static const struct iio_info adxl372_info = {
>  	.attrs = &adxl372_attrs_group,
>  	.read_raw = adxl372_read_raw,
>  	.write_raw = adxl372_write_raw,
> +	.read_event_value = adxl372_read_event_value,
> +	.write_event_value = adxl372_write_event_value,
>  	.debugfs_reg_access = &adxl372_reg_access,
>  	.hwfifo_set_watermark = adxl372_set_watermark,
>  };

