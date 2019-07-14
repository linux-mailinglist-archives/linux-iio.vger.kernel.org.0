Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C3068051
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 18:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfGNQ4R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 12:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbfGNQ4Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 12:56:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EA9E20820;
        Sun, 14 Jul 2019 16:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563123375;
        bh=RMTijD8j9u04o0QzWP550yYZV06xE3DmWn/pI7xYJjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h4CN5Ficqw0s9B95r2mqkdyY3Fs3BllXbpzSGaDJaANjdw6QxUvTXOEPM6dzIaFg3
         bQO5hUHH/JnuV3/Q2tZZuDiz5qsrQpii9uOXVXisMrZDNPtyCo1XB4TYGWJOc3nd1O
         51hGALe9NWvPlZzyR2uAlT0WU3oDXRCUwNynbqmA=
Date:   Sun, 14 Jul 2019 17:56:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        dianders@chromium.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: cros_ec_accel_legacy: Add support for
 veyron-minnie
Message-ID: <20190714175610.63db089e@archlinux>
In-Reply-To: <20190628191711.23584-5-gwendal@chromium.org>
References: <20190628191711.23584-1-gwendal@chromium.org>
        <20190628191711.23584-5-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 28 Jun 2019 12:17:11 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Veyron minnie embedded controller presents 2 accelerometers using an
> older interface. Add function to query the data in cros_ec_accel.
> 
> Verify accelerometers on veyron-minnie are presented and working.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan

> ---
>  drivers/iio/accel/cros_ec_accel_legacy.c | 40 ++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index 2399f0cbdf2b..2c6196446d90 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -5,7 +5,7 @@
>   * Copyright 2017 Google, Inc
>   *
>   * This driver uses the memory mapper cros-ec interface to communicate
> - * with the Chrome OS EC about accelerometer data.
> + * with the Chrome OS EC about accelerometer data or older commands.
>   * Accelerometer access is presented through iio sysfs.
>   */
>  
> @@ -33,6 +33,39 @@
>   */
>  #define ACCEL_LEGACY_NSCALE 9586168
>  
> +static int cros_ec_accel_legacy_read_cmd(struct iio_dev *indio_dev,
> +				  unsigned long scan_mask, s16 *data)
> +{
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> +	int ret;
> +	unsigned int i;
> +	u8 sensor_num;
> +
> +	/*
> +	 * Read all sensor data through a command.
> +	 * Save sensor_num, it is assumed to stay.
> +	 */
> +	sensor_num = st->param.info.sensor_num;
> +	st->param.cmd = MOTIONSENSE_CMD_DUMP;
> +	st->param.dump.max_sensor_count = CROS_EC_SENSOR_LEGACY_NUM;
> +	ret = cros_ec_motion_send_host_cmd(st,
> +			sizeof(st->resp->dump) + CROS_EC_SENSOR_LEGACY_NUM *
> +			sizeof(struct ec_response_motion_sensor_data));
> +	st->param.info.sensor_num = sensor_num;
> +	if (ret != 0) {
> +		dev_warn(&indio_dev->dev, "Unable to read sensor data\n");
> +		return ret;
> +	}
> +
> +	for_each_set_bit(i, &scan_mask, indio_dev->masklength) {
> +		*data = st->resp->dump.sensor[sensor_num].data[i] *
> +			st->sign[i];
> +		data++;
> +	}
> +
> +	return 0;
> +}
> +
>  static int cros_ec_accel_legacy_read(struct iio_dev *indio_dev,
>  				     struct iio_chan_spec const *chan,
>  				     int *val, int *val2, long mask)
> @@ -149,7 +182,10 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
>  	indio_dev->info = &cros_ec_accel_legacy_info;
>  	state = iio_priv(indio_dev);
>  
> -	state->read_ec_sensors_data = cros_ec_sensors_read_lpc;
> +	if (state->ec->cmd_readmem != NULL)
> +		state->read_ec_sensors_data = cros_ec_sensors_read_lpc;
> +	else
> +		state->read_ec_sensors_data = cros_ec_accel_legacy_read_cmd;
>  
>  	indio_dev->channels = cros_ec_accel_legacy_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(cros_ec_accel_legacy_channels);

