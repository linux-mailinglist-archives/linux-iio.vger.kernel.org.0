Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7FADF377
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 18:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfJUQpO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 12:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfJUQpO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Oct 2019 12:45:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB54820882;
        Mon, 21 Oct 2019 16:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571676313;
        bh=QpBb8tPVc2TG+6Byr+wrOln8lhBuf1DFpqNHng8GEy4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RNtWxjaqYST8aS+SWhAft9y+3l/7i4iUaWgI5bBDz2G8OynNjeKrFCKu7vRvydFTz
         UFJ/4Q1iCFNUkTsB60BhXYLF+v/0wrOXwDBI+L0Ei35Xx/v7aNKjKtWP5mfN9ym4c4
         SOQK/SrvQN0bCyNVrAc9Anu8VX0CtRSODfMzu4eg=
Date:   Mon, 21 Oct 2019 17:45:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 18/18] iio: cros_ec: Use Hertz as unit for sampling
 frequency
Message-ID: <20191021174507.72f2b777@archlinux>
In-Reply-To: <20191021055403.67849-19-gwendal@chromium.org>
References: <20191021055403.67849-1-gwendal@chromium.org>
        <20191021055403.67849-19-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 20 Oct 2019 22:54:03 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> To be compliant with other sensors, set and get sensor sampling
> frequency in Hz, not mHz.
> 
> Fixes: ae7b02ad2f32 ("iio: common: cros_ec_sensors: Expose
> cros_ec_sensors frequency range via iio sysfs")
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Do we need to look at back porting this?

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Not sure which path this set will take in, hence I've given
acks for various patches incase it's not via me.

Whole set is in general good to have, but I do worry a bit about
people noticing ABI breakage. *crosses fingers*

Jonathan

> ---
> No changes in v2.
> 
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 32 +++++++++++--------
>  .../linux/iio/common/cros_ec_sensors_core.h   |  6 ++--
>  2 files changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index f50e239f9a1e9..76dc8cad1b4b5 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -256,6 +256,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  	struct cros_ec_dev *ec = sensor_hub->ec;
>  	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
>  	u32 ver_mask;
> +	int frequencies[ARRAY_SIZE(state->frequencies) / 2] = { 0 };
>  	int ret, i;
>  
>  	platform_set_drvdata(pdev, indio_dev);
> @@ -304,20 +305,22 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			state->calib[i].scale = MOTION_SENSE_DEFAULT_SCALE;
>  
>  		/* 0 is a correct value used to stop the device */
> -		state->frequencies[0] = 0;
>  		if (state->msg->version < 3) {
>  			get_default_min_max_freq(state->resp->info.type,
> -						 &state->frequencies[1],
> -						 &state->frequencies[2],
> +						 &frequencies[1],
> +						 &frequencies[2],
>  						 &state->fifo_max_event_count);
>  		} else {
> -			state->frequencies[1] =
> -			    state->resp->info_3.min_frequency;
> -			state->frequencies[2] =
> -			    state->resp->info_3.max_frequency;
> +			frequencies[1] = state->resp->info_3.min_frequency;
> +			frequencies[2] = state->resp->info_3.max_frequency;
>  			state->fifo_max_event_count =
>  			    state->resp->info_3.fifo_max_event_count;
>  		}
> +		for (i = 0; i < ARRAY_SIZE(frequencies); i++) {
> +			state->frequencies[2 * i] = frequencies[i] / 1000;
> +			state->frequencies[2 * i + 1] =
> +				(frequencies[i] % 1000) * 1000;
> +		}
>  
>  		ret = devm_iio_triggered_buffer_setup(
>  				dev, indio_dev, NULL,
> @@ -707,7 +710,7 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
>  			  struct iio_chan_spec const *chan,
>  			  int *val, int *val2, long mask)
>  {
> -	int ret;
> +	int ret, frequency;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -719,8 +722,10 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
>  		if (ret)
>  			break;
>  
> -		*val = st->resp->sensor_odr.ret;
> -		ret = IIO_VAL_INT;
> +		frequency = st->resp->sensor_odr.ret;
> +		*val = frequency / 1000;
> +		*val2 = (frequency % 1000) * 1000;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -755,7 +760,7 @@ int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*length = ARRAY_SIZE(state->frequencies);
>  		*vals = (const int *)&state->frequencies;
> -		*type = IIO_VAL_INT;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
>  		return IIO_AVAIL_LIST;
>  	}
>  
> @@ -777,12 +782,13 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  			       struct iio_chan_spec const *chan,
>  			       int val, int val2, long mask)
>  {
> -	int ret;
> +	int ret, frequency;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> +		frequency = val * 1000 + val2 / 1000;
>  		st->param.cmd = MOTIONSENSE_CMD_SENSOR_ODR;
> -		st->param.sensor_odr.data = val;
> +		st->param.sensor_odr.data = frequency;
>  
>  		/* Always roundup, so caller gets at least what it asks for. */
>  		st->param.sensor_odr.roundup = 1;
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index 4df3abd151fbf..256447b136296 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -52,6 +52,8 @@ typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
>   *				is always 8-byte aligned.
>   * @read_ec_sensors_data:	function used for accessing sensors values
>   * @fifo_max_event_count:	Size of the EC sensor FIFO
> + * @frequencies:		Table of known available frequencies:
> + *				0, Min and Max in mHz.
>   */
>  struct cros_ec_sensors_core_state {
>  	struct cros_ec_device *ec;
> @@ -75,9 +77,7 @@ struct cros_ec_sensors_core_state {
>  				    unsigned long scan_mask, s16 *data);
>  
>  	u32 fifo_max_event_count;
> -
> -	/* Table of known available frequencies : 0, Min and Max in mHz */
> -	int frequencies[3];
> +	int frequencies[6];
>  };
>  
>  int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev, unsigned long scan_mask,

