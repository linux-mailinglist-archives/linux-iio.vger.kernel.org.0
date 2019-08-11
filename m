Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D636890A9
	for <lists+linux-iio@lfdr.de>; Sun, 11 Aug 2019 10:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfHKI1A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Aug 2019 04:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfHKI07 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Aug 2019 04:26:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C94A2173C;
        Sun, 11 Aug 2019 08:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565512018;
        bh=+MpiYi/yxwTSBlExUe4w38x3Gom60KtnPeD1HprlGBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qld8CfyzO/UkhVRSF/vJYMkTKS5pxDNEprEjeDbJgvC1EpFAZi4Lf67IaCr85Jk+n
         Ch8VcrkDODiU3OzccXBP7LznW2P75PxAtgFqNdAYIWE7E10fF6WgjMp6z4IfqqF7XA
         OIsuQz43NPkQEjmieKIUBs2AimNClcM/obybJp2A=
Date:   Sun, 11 Aug 2019 09:26:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis Ciocca <denis.ciocca@st.com>
Cc:     <linux-iio@vger.kernel.org>, <alexandru.Ardelean@analog.com>
Subject: Re: [PATCH] iio:st_sensors: remove buffer allocation at each buffer
 enable
Message-ID: <20190811092654.785fce7a@archlinux>
In-Reply-To: <20190805185711.2890-1-denis.ciocca@st.com>
References: <20190805185711.2890-1-denis.ciocca@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 5 Aug 2019 11:57:11 -0700
Denis Ciocca <denis.ciocca@st.com> wrote:

> This patch is removing the buffer allocation at each buffer enable.
> We just allocate enough memory in the main structure during probe
> to cover maximum size needed (that anyway is pretty small) [16bytes].
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

This came out very nicely.  Thanks,

Jonathan

> ---
>  drivers/iio/accel/st_accel_buffer.c       | 12 +-----------
>  drivers/iio/gyro/st_gyro_buffer.c         | 12 +-----------
>  drivers/iio/magnetometer/st_magn_buffer.c | 12 +-----------
>  drivers/iio/pressure/st_pressure_buffer.c | 12 +-----------
>  include/linux/iio/common/st_sensors.h     | 14 +++++++++-----
>  5 files changed, 13 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
> index 59dcef02ec19..9f2b40474b8e 100644
> --- a/drivers/iio/accel/st_accel_buffer.c
> +++ b/drivers/iio/accel/st_accel_buffer.c
> @@ -31,17 +31,11 @@ int st_accel_trig_set_state(struct iio_trigger *trig, bool state)
>  
>  static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
>  {
> -	struct st_sensor_data *adata = iio_priv(indio_dev);
>  	int err;
>  
> -	adata->buffer_data = kmalloc(indio_dev->scan_bytes,
> -				     GFP_DMA | GFP_KERNEL);
> -	if (!adata->buffer_data)
> -		return -ENOMEM;
> -
>  	err = iio_triggered_buffer_postenable(indio_dev);
>  	if (err < 0)
> -		goto st_accel_free_buffer;
> +		return err;
>  
>  	err = st_sensors_set_axis_enable(indio_dev,
>  					 (u8)indio_dev->active_scan_mask[0]);
> @@ -58,14 +52,11 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
>  	st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
>  st_accel_buffer_predisable:
>  	iio_triggered_buffer_predisable(indio_dev);
> -st_accel_free_buffer:
> -	kfree(adata->buffer_data);
>  	return err;
>  }
>  
>  static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
>  {
> -	struct st_sensor_data *adata = iio_priv(indio_dev);
>  	int err, err2;
>  
>  	err = st_sensors_set_enable(indio_dev, false);
> @@ -79,7 +70,6 @@ static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
>  	if (!err)
>  		err = err2;
>  
> -	kfree(adata->buffer_data);
>  	return err;
>  }
>  
> diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
> index c6ddfecc1fc3..7465ad62391c 100644
> --- a/drivers/iio/gyro/st_gyro_buffer.c
> +++ b/drivers/iio/gyro/st_gyro_buffer.c
> @@ -31,17 +31,11 @@ int st_gyro_trig_set_state(struct iio_trigger *trig, bool state)
>  
>  static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
>  {
> -	struct st_sensor_data *gdata = iio_priv(indio_dev);
>  	int err;
>  
> -	gdata->buffer_data = kmalloc(indio_dev->scan_bytes,
> -				     GFP_DMA | GFP_KERNEL);
> -	if (!gdata->buffer_data)
> -		return -ENOMEM;
> -
>  	err = iio_triggered_buffer_postenable(indio_dev);
>  	if (err < 0)
> -		goto st_gyro_free_buffer;
> +		return err;
>  
>  	err = st_sensors_set_axis_enable(indio_dev,
>  					 (u8)indio_dev->active_scan_mask[0]);
> @@ -58,15 +52,12 @@ static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
>  	st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
>  st_gyro_buffer_predisable:
>  	iio_triggered_buffer_predisable(indio_dev);
> -st_gyro_free_buffer:
> -	kfree(gdata->buffer_data);
>  	return err;
>  }
>  
>  static int st_gyro_buffer_predisable(struct iio_dev *indio_dev)
>  {
>  	int err, err2;
> -	struct st_sensor_data *gdata = iio_priv(indio_dev);
>  
>  	err = st_sensors_set_enable(indio_dev, false);
>  	if (err < 0)
> @@ -79,7 +70,6 @@ static int st_gyro_buffer_predisable(struct iio_dev *indio_dev)
>  	if (!err)
>  		err = err2;
>  
> -	kfree(gdata->buffer_data);
>  	return err;
>  }
>  
> diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
> index 658d627dad8e..bb425c167a96 100644
> --- a/drivers/iio/magnetometer/st_magn_buffer.c
> +++ b/drivers/iio/magnetometer/st_magn_buffer.c
> @@ -31,17 +31,11 @@ int st_magn_trig_set_state(struct iio_trigger *trig, bool state)
>  
>  static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
>  {
> -	struct st_sensor_data *mdata = iio_priv(indio_dev);
>  	int err;
>  
> -	mdata->buffer_data = kmalloc(indio_dev->scan_bytes,
> -				     GFP_DMA | GFP_KERNEL);
> -	if (!mdata->buffer_data)
> -		return -ENOMEM;
> -
>  	err = iio_triggered_buffer_postenable(indio_dev);
>  	if (err < 0)
> -		goto st_magn_free_buffer;
> +		return err;
>  
>  	err = st_sensors_set_enable(indio_dev, true);
>  	if (err < 0)
> @@ -51,14 +45,11 @@ static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
>  
>  st_magn_buffer_predisable:
>  	iio_triggered_buffer_predisable(indio_dev);
> -st_magn_free_buffer:
> -	kfree(mdata->buffer_data);
>  	return err;
>  }
>  
>  static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
>  {
> -	struct st_sensor_data *mdata = iio_priv(indio_dev);
>  	int err, err2;
>  
>  	err = st_sensors_set_enable(indio_dev, false);
> @@ -67,7 +58,6 @@ static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
>  	if (!err)
>  		err = err2;
>  
> -	kfree(mdata->buffer_data);
>  	return err;
>  }
>  
> diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
> index 77cb2d862f19..418dbf9e6e1e 100644
> --- a/drivers/iio/pressure/st_pressure_buffer.c
> +++ b/drivers/iio/pressure/st_pressure_buffer.c
> @@ -31,17 +31,11 @@ int st_press_trig_set_state(struct iio_trigger *trig, bool state)
>  
>  static int st_press_buffer_postenable(struct iio_dev *indio_dev)
>  {
> -	struct st_sensor_data *press_data = iio_priv(indio_dev);
>  	int err;
>  
> -	press_data->buffer_data = kmalloc(indio_dev->scan_bytes,
> -					  GFP_DMA | GFP_KERNEL);
> -	if (!press_data->buffer_data)
> -		return -ENOMEM;
> -
>  	err = iio_triggered_buffer_postenable(indio_dev);
>  	if (err < 0)
> -		goto st_press_free_buffer;
> +		return err;
>  
>  	err = st_sensors_set_enable(indio_dev, true);
>  	if (err < 0)
> @@ -51,14 +45,11 @@ static int st_press_buffer_postenable(struct iio_dev *indio_dev)
>  
>  st_press_buffer_predisable:
>  	iio_triggered_buffer_predisable(indio_dev);
> -st_press_free_buffer:
> -	kfree(press_data->buffer_data);
>  	return err;
>  }
>  
>  static int st_press_buffer_predisable(struct iio_dev *indio_dev)
>  {
> -	struct st_sensor_data *press_data = iio_priv(indio_dev);
>  	int err, err2;
>  
>  	err = st_sensors_set_enable(indio_dev, false);
> @@ -67,7 +58,6 @@ static int st_press_buffer_predisable(struct iio_dev *indio_dev)
>  	if (!err)
>  		err = err2;
>  
> -	kfree(press_data->buffer_data);
>  	return err;
>  }
>  
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index 4d0889bf1c6c..686be532f4cb 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -20,8 +20,12 @@
>  
>  #include <linux/platform_data/st_sensors_pdata.h>
>  
> -#define ST_SENSORS_TX_MAX_LENGTH		2
> -#define ST_SENSORS_RX_MAX_LENGTH		6
> +/*
> + * Buffer size max case: 2bytes per channel, 3 channels in total +
> + *			 8bytes timestamp channel (s64)
> + */
> +#define ST_SENSORS_MAX_BUFFER_SIZE		(ALIGN(2 * 3, sizeof(s64)) + \
> +						 sizeof(s64))
>  
>  #define ST_SENSORS_ODR_LIST_MAX			10
>  #define ST_SENSORS_FULLSCALE_AVL_MAX		10
> @@ -215,7 +219,6 @@ struct st_sensor_settings {
>   * @vdd_io: Pointer to sensor's Vdd-IO power supply
>   * @regmap: Pointer to specific sensor regmap configuration.
>   * @enabled: Status of the sensor (false->off, true->on).
> - * @buffer_data: Data used by buffer part.
>   * @odr: Output data rate of the sensor [Hz].
>   * num_data_channels: Number of data channels used in buffer.
>   * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
> @@ -224,6 +227,7 @@ struct st_sensor_settings {
>   * @edge_irq: the IRQ triggers on edges and need special handling.
>   * @hw_irq_trigger: if we're using the hardware interrupt on the sensor.
>   * @hw_timestamp: Latest timestamp from the interrupt handler, when in use.
> + * @buffer_data: Data used by buffer part.
>   */
>  struct st_sensor_data {
>  	struct device *dev;
> @@ -237,8 +241,6 @@ struct st_sensor_data {
>  
>  	bool enabled;
>  
> -	char *buffer_data;
> -
>  	unsigned int odr;
>  	unsigned int num_data_channels;
>  
> @@ -249,6 +251,8 @@ struct st_sensor_data {
>  	bool edge_irq;
>  	bool hw_irq_trigger;
>  	s64 hw_timestamp;
> +
> +	char buffer_data[ST_SENSORS_MAX_BUFFER_SIZE] ____cacheline_aligned;
>  };
>  
>  #ifdef CONFIG_IIO_BUFFER

