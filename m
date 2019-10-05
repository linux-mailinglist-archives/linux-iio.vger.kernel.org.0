Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA272CCB4D
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 18:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfJEQjM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 12:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfJEQjL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 12:39:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BC7A22475;
        Sat,  5 Oct 2019 16:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570293550;
        bh=muOoyHgFkIzawvNdGZkDnH+wc8CSIFaMgkHMDwpdSX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yrib5Ypk20BnayszcdNS5keh+ouauJNLKUBC1KHetj3IALiK+XiKc9MIXFVc2jNXA
         qes3fUTL+Q5LmahJqdx1VjY93N8QkHXB3WyXZlGNxNM172oEUq+yMnj7z5s5GlAsbb
         YrzReCIoGqzdgvzribuS1Om9c1HdZ+yTw0LtmEk4=
Date:   Sat, 5 Oct 2019 17:39:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 13/13] iio: cros_ec: Use Hertz as unit for sampling
 frequency
Message-ID: <20191005173903.18de9cdc@archlinux>
In-Reply-To: <20190922175021.53449-14-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
        <20190922175021.53449-14-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Sep 2019 10:50:21 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> To be compliant with other sensors, set and get sensor sampling
> frequency in Hz, not mHz.
> 
> Fixes: ae7b02ad2f32 ("iio: common: cros_ec_sensors: Expose
> cros_ec_sensors frequency range via iio sysfs")
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Good catch.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 32 +++++++++++--------
>  .../linux/iio/common/cros_ec_sensors_core.h   |  6 ++--
>  2 files changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index a32260c9bc09..f7e6827bd4cb 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -227,6 +227,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
>  	struct iio_buffer *buffer;
>  	u32 ver_mask;
> +	int frequencies[ARRAY_SIZE(state->frequencies) / 2] = { 0 };
>  	int ret, i;
>  
>  	platform_set_drvdata(pdev, indio_dev);
> @@ -275,20 +276,22 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
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
>  		if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
>  			buffer = devm_iio_kfifo_allocate(dev);
> @@ -653,7 +656,7 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
>  			  struct iio_chan_spec const *chan,
>  			  int *val, int *val2, long mask)
>  {
> -	int ret;
> +	int ret, frequency;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -665,8 +668,10 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
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
> @@ -690,7 +695,7 @@ int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*length = ARRAY_SIZE(state->frequencies);
>  		*vals = (const int *)&state->frequencies;
> -		*type = IIO_VAL_INT;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
>  		return IIO_AVAIL_LIST;
>  	}
>  
> @@ -702,12 +707,13 @@ int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
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
> index 2c6acbde0d02..46d5110b2fe4 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -56,6 +56,8 @@ typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
>   * @read_ec_sensors_data:	function used for accessing sensors values
>   * @curr_sampl_freq:		current sampling period
>   * @fifo_max_event_count:	Size of the EC sensor FIFO
> + * @frequencies:		Table of known available frequencies:
> + *				0, Min and Max in mHz.
>   */
>  struct cros_ec_sensors_core_state {
>  	struct cros_ec_device *ec;
> @@ -80,9 +82,7 @@ struct cros_ec_sensors_core_state {
>  
>  	int curr_sampl_freq;
>  	u32 fifo_max_event_count;
> -
> -	/* Table of known available frequencies : 0, Min and Max in mHz */
> -	int frequencies[3];
> +	int frequencies[6];
>  };
>  
>  /**

