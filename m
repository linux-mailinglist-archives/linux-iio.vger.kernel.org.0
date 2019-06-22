Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8EEB4F492
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 11:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFVJDP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 05:03:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfFVJDP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 05:03:15 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C8802089C;
        Sat, 22 Jun 2019 09:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561194192;
        bh=99JdPyKH7o53sk6hjrrnzCRmlo9qzdZd2VMKIFIv+Kk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=y3NNdZSsJBBLQNEAibdJpbJyAuwoyB0IgAgI+MYJ1t2NTaGwPiuPIlsYubfdXwhce
         NUd+8fU6ID6GSfWSCIITUv+UBXYgfTT3B96pA6MAch8h79eLOD/celuo9Wdh8Z6fGU
         JfCdgeYmTS35YHOL377LGlSgtuDOQXzXXfpRVUNE=
Date:   Sat, 22 Jun 2019 10:03:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: cros_ec : Extend legacy support to ARM
 device
Message-ID: <20190622100308.7d29c324@archlinux>
In-Reply-To: <20190621024106.158589-3-gwendal@chromium.org>
References: <20190621024106.158589-1-gwendal@chromium.org>
        <20190621024106.158589-3-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 20 Jun 2019 19:41:06 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add support to ARM based devices, that lack LPC access code.
> Allow cros-ec-accel-legacy to use cros-ec-sensors-core, add specific
> command to capture sensor data.
> 
> On veyron minnie, check chrome detect tablet mode and rotate
> screen in tablet mode.
> Check only a subset of the attributes are presented.

Superficially this looks like 2 changes to me.  One moves
over to using the shared code. The other sounds like it's introducing
the new device support?  2 patches perhaps?

However, looking at the code, am I interpreting the description
correctly?  Looks to me like we are really just reducing duplicated
code by using the cros_ec_sensors_core code to replace
existing code in the cros-ec-accel-legacy driver?  If that's
the main focus, then make that clear in the patch title.

One passing comment inline.

Thanks,

Jonathan


> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/accel/Kconfig                |   4 +-
>  drivers/iio/accel/cros_ec_accel_legacy.c | 350 +++++------------------
>  2 files changed, 79 insertions(+), 275 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 62a970a20219..7d0848f9ea45 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -201,9 +201,7 @@ config HID_SENSOR_ACCEL_3D
>  
>  config IIO_CROS_EC_ACCEL_LEGACY
>  	tristate "ChromeOS EC Legacy Accelerometer Sensor"
> -	select IIO_BUFFER
> -	select IIO_TRIGGERED_BUFFER
> -	select CROS_EC_LPC_REGISTER_DEVICE
> +	depends on IIO_CROS_EC_SENSORS_CORE
>  	help
>  	  Say yes here to get support for accelerometers on Chromebook using
>  	  legacy EC firmware.
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index 46bb2e421bb9..575d7e4c685c 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -5,13 +5,14 @@
>   * Copyright 2017 Google, Inc
>   *
>   * This driver uses the memory mapper cros-ec interface to communicate
> - * with the Chrome OS EC about accelerometer data.
> + * with the Chrome OS EC about accelerometer data or older commands.
>   * Accelerometer access is presented through iio sysfs.
>   */
>  
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/common/cros_ec_sensors_core.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/trigger_consumer.h>
> @@ -25,160 +26,41 @@
>  
>  #define DRV_NAME	"cros-ec-accel-legacy"
>  
> +#define CROS_EC_SENSOR_LEGACY_NUM 2
>  /*
>   * Sensor scale hard coded at 10 bits per g, computed as:
>   * g / (2^10 - 1) = 0.009586168; with g = 9.80665 m.s^-2
>   */
>  #define ACCEL_LEGACY_NSCALE 9586168
>  
> -/* Indices for EC sensor values. */
> -enum {
> -	X,
> -	Y,
> -	Z,
> -	MAX_AXIS,
> -};
> -
> -/* State data for cros_ec_accel_legacy iio driver. */
> -struct cros_ec_accel_legacy_state {
> -	struct cros_ec_device *ec;
> -
> -	/*
> -	 * Array holding data from a single capture. 2 bytes per channel
> -	 * for the 3 channels plus the timestamp which is always last and
> -	 * 8-bytes aligned.
> -	 */
> -	s16 capture_data[8];
> -	s8 sign[MAX_AXIS];
> -	u8 sensor_num;
> -};
> -
> -static int ec_cmd_read_u8(struct cros_ec_device *ec, unsigned int offset,
> -			  u8 *dest)
> -{
> -	return ec->cmd_readmem(ec, offset, 1, dest);
> -}
> -
> -static int ec_cmd_read_u16(struct cros_ec_device *ec, unsigned int offset,
> -			   u16 *dest)
> -{
> -	__le16 tmp;
> -	int ret = ec->cmd_readmem(ec, offset, 2, &tmp);
> -
> -	*dest = le16_to_cpu(tmp);
> -
> -	return ret;
> -}
> -
> -/**
> - * read_ec_until_not_busy() - Read from EC status byte until it reads not busy.
> - * @st: Pointer to state information for device.
> - *
> - * This function reads EC status until its busy bit gets cleared. It does not
> - * wait indefinitely and returns -EIO if the EC status is still busy after a
> - * few hundreds milliseconds.
> - *
> - * Return: 8-bit status if ok, -EIO on error
> - */
> -static int read_ec_until_not_busy(struct cros_ec_accel_legacy_state *st)
> -{
> -	struct cros_ec_device *ec = st->ec;
> -	u8 status;
> -	int attempts = 0;
> -
> -	ec_cmd_read_u8(ec, EC_MEMMAP_ACC_STATUS, &status);
> -	while (status & EC_MEMMAP_ACC_STATUS_BUSY_BIT) {
> -		/* Give up after enough attempts, return error. */
> -		if (attempts++ >= 50)
> -			return -EIO;
> -
> -		/* Small delay every so often. */
> -		if (attempts % 5 == 0)
> -			msleep(25);
> -
> -		ec_cmd_read_u8(ec, EC_MEMMAP_ACC_STATUS, &status);
> -	}
> -
> -	return status;
> -}
> -
> -/**
> - * read_ec_accel_data_unsafe() - Read acceleration data from EC shared memory.
> - * @st:        Pointer to state information for device.
> - * @scan_mask: Bitmap of the sensor indices to scan.
> - * @data:      Location to store data.
> - *
> - * This is the unsafe function for reading the EC data. It does not guarantee
> - * that the EC will not modify the data as it is being read in.
> - */
> -static void read_ec_accel_data_unsafe(struct cros_ec_accel_legacy_state *st,
> -				      unsigned long scan_mask, s16 *data)
> -{
> -	int i = 0;
> -	int num_enabled = bitmap_weight(&scan_mask, MAX_AXIS);
> -
> -	/* Read all sensors enabled in scan_mask. Each value is 2 bytes. */
> -	while (num_enabled--) {
> -		i = find_next_bit(&scan_mask, MAX_AXIS, i);
> -		ec_cmd_read_u16(st->ec,
> -				EC_MEMMAP_ACC_DATA +
> -				sizeof(s16) *
> -				(1 + i + st->sensor_num * MAX_AXIS),
> -				data);
> -		*data *= st->sign[i];
> -		i++;
> -		data++;
> -	}
> -}
> -
> -/**
> - * read_ec_accel_data() - Read acceleration data from EC shared memory.
> - * @st:        Pointer to state information for device.
> - * @scan_mask: Bitmap of the sensor indices to scan.
> - * @data:      Location to store data.
> - *
> - * This is the safe function for reading the EC data. It guarantees that
> - * the data sampled was not modified by the EC while being read.
> - *
> - * Return: 0 if ok, -ve on error
> - */
> -static int read_ec_accel_data(struct cros_ec_accel_legacy_state *st,
> -			      unsigned long scan_mask, s16 *data)
> +int cros_ec_accel_legacy_read_cmd(struct iio_dev *indio_dev,
> +				  unsigned long scan_mask, s16 *data)
>  {
> -	u8 samp_id = 0xff;
> -	u8 status = 0;
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
>  	int ret;
> -	int attempts = 0;
> +	unsigned int i;
> +	u8 sensor_num;
>  
>  	/*
> -	 * Continually read all data from EC until the status byte after
> -	 * all reads reflects that the EC is not busy and the sample id
> -	 * matches the sample id from before all reads. This guarantees
> -	 * that data read in was not modified by the EC while reading.
> +	 * Read all sensor data through a command.
> +	 * Save sensor_num, it is assumed to stay.
>  	 */
> -	while ((status & (EC_MEMMAP_ACC_STATUS_BUSY_BIT |
> -			  EC_MEMMAP_ACC_STATUS_SAMPLE_ID_MASK)) != samp_id) {
> -		/* If we have tried to read too many times, return error. */
> -		if (attempts++ >= 5)
> -			return -EIO;
> -
> -		/* Read status byte until EC is not busy. */
> -		ret = read_ec_until_not_busy(st);
> -		if (ret < 0)
> -			return ret;
> -		status = ret;
> -
> -		/*
> -		 * Store the current sample id so that we can compare to the
> -		 * sample id after reading the data.
> -		 */
> -		samp_id = status & EC_MEMMAP_ACC_STATUS_SAMPLE_ID_MASK;
> -
> -		/* Read all EC data, format it, and store it into data. */
> -		read_ec_accel_data_unsafe(st, scan_mask, data);
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
>  
> -		/* Read status byte. */
> -		ec_cmd_read_u8(st->ec, EC_MEMMAP_ACC_STATUS, &status);
> +	for_each_set_bit(i, &scan_mask, indio_dev->masklength) {
> +		*data = st->resp->dump.sensor[sensor_num].data[i] *
> +			st->sign[i];
> +		data++;
>  	}
>  
>  	return 0;
> @@ -188,28 +70,39 @@ static int cros_ec_accel_legacy_read(struct iio_dev *indio_dev,
>  				     struct iio_chan_spec const *chan,
>  				     int *val, int *val2, long mask)
>  {
> -	struct cros_ec_accel_legacy_state *st = iio_priv(indio_dev);
> +	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
>  	s16 data = 0;
> -	int ret = IIO_VAL_INT;
> +	int ret;
> +	int idx = chan->scan_index;
> +
> +	mutex_lock(&st->cmd_lock);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = read_ec_accel_data(st, (1 << chan->scan_index), &data);
> -		if (ret)
> -			return ret;
> +		ret = st->read_ec_sensors_data(indio_dev, 1 << idx, &data);
> +		if (ret < 0)
> +			break;
> +		ret = IIO_VAL_INT;
>  		*val = data;
> -		return IIO_VAL_INT;
> +		break;
>  	case IIO_CHAN_INFO_SCALE:
> +		WARN_ON(st->type != MOTIONSENSE_TYPE_ACCEL);
>  		*val = 0;
>  		*val2 = ACCEL_LEGACY_NSCALE;
> -		return IIO_VAL_INT_PLUS_NANO;
> +		ret = IIO_VAL_INT_PLUS_NANO;
> +		break;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		/* Calibration not supported. */
>  		*val = 0;
>  		return IIO_VAL_INT;
>  	default:
> -		return -EINVAL;
> +		ret = cros_ec_sensors_core_read(st, chan, val, val2,
> +				mask);
> +		break;
>  	}
> +	mutex_unlock(&st->cmd_lock);
> +
> +	return ret;
>  }
>  
>  static int cros_ec_accel_legacy_write(struct iio_dev *indio_dev,
> @@ -231,86 +124,14 @@ static const struct iio_info cros_ec_accel_legacy_info = {
>  	.write_raw = &cros_ec_accel_legacy_write,
>  };
>  
> -/**
> - * cros_ec_accel_legacy_capture() - The trigger handler function
> - * @irq: The interrupt number.
> - * @p:   Private data - always a pointer to the poll func.
> - *
> - * On a trigger event occurring, if the pollfunc is attached then this
> - * handler is called as a threaded interrupt (and hence may sleep). It
> - * is responsible for grabbing data from the device and pushing it into
> - * the associated buffer.
> - *
> - * Return: IRQ_HANDLED
> +/*
> + * Present the channel using HTML5 standard:
> + * need to invert X and Y and invert some lid axis.
>   */
> -static irqreturn_t cros_ec_accel_legacy_capture(int irq, void *p)
> -{
> -	struct iio_poll_func *pf = p;
> -	struct iio_dev *indio_dev = pf->indio_dev;
> -	struct cros_ec_accel_legacy_state *st = iio_priv(indio_dev);
> -
> -	/* Clear capture data. */
> -	memset(st->capture_data, 0, sizeof(st->capture_data));
> -
> -	/*
> -	 * Read data based on which channels are enabled in scan mask. Note
> -	 * that on a capture we are always reading the calibrated data.
> -	 */
> -	read_ec_accel_data(st, *indio_dev->active_scan_mask, st->capture_data);
> -
> -	iio_push_to_buffers_with_timestamp(indio_dev, (void *)st->capture_data,
> -					   iio_get_time_ns(indio_dev));
> -
> -	/*
> -	 * Tell the core we are done with this trigger and ready for the
> -	 * next one.
> -	 */
> -	iio_trigger_notify_done(indio_dev->trig);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static char *cros_ec_accel_legacy_loc_strings[] = {
> -	[MOTIONSENSE_LOC_BASE] = "base",
> -	[MOTIONSENSE_LOC_LID] = "lid",
> -	[MOTIONSENSE_LOC_MAX] = "unknown",
> -};
> -
> -static ssize_t cros_ec_accel_legacy_loc(struct iio_dev *indio_dev,
> -					uintptr_t private,
> -					const struct iio_chan_spec *chan,
> -					char *buf)
> -{
> -	struct cros_ec_accel_legacy_state *st = iio_priv(indio_dev);
> -
> -	return sprintf(buf, "%s\n",
> -		       cros_ec_accel_legacy_loc_strings[st->sensor_num +
> -							MOTIONSENSE_LOC_BASE]);
> -}
> -
> -static ssize_t cros_ec_accel_legacy_id(struct iio_dev *indio_dev,
> -				       uintptr_t private,
> -				       const struct iio_chan_spec *chan,
> -				       char *buf)
> -{
> -	struct cros_ec_accel_legacy_state *st = iio_priv(indio_dev);
> -
> -	return sprintf(buf, "%d\n", st->sensor_num);
> -}
> -
> -static const struct iio_chan_spec_ext_info cros_ec_accel_legacy_ext_info[] = {
> -	{
> -		.name = "id",
> -		.shared = IIO_SHARED_BY_ALL,
> -		.read = cros_ec_accel_legacy_id,
> -	},
> -	{
> -		.name = "location",
> -		.shared = IIO_SHARED_BY_ALL,
> -		.read = cros_ec_accel_legacy_loc,
> -	},
> -	{ }
> -};
> +#define CROS_EC_ACCEL_ROTATE_AXIS(_axis)				\
> +	((_axis) == CROS_EC_SENSOR_Z ? CROS_EC_SENSOR_Z :		\
> +	 ((_axis) == CROS_EC_SENSOR_X ? CROS_EC_SENSOR_Y :		\
> +	  CROS_EC_SENSOR_X))
>  
>  #define CROS_EC_ACCEL_LEGACY_CHAN(_axis)				\
>  	{								\
> @@ -319,31 +140,30 @@ static const struct iio_chan_spec_ext_info cros_ec_accel_legacy_ext_info[] = {
>  		.modified = 1,					        \
>  		.info_mask_separate =					\
>  			BIT(IIO_CHAN_INFO_RAW) |			\
> -			BIT(IIO_CHAN_INFO_SCALE) |			\

My first thought was you were changing the ABI, but looking closer this
was broken anyway as we shouldn't have had both separate and shared by all
for the same thing on the same channel.  Still presumably an ABI change
but one fixing a broken interface so fingers crossed no one notices.

>  			BIT(IIO_CHAN_INFO_CALIBBIAS),			\
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
> -		.ext_info = cros_ec_accel_legacy_ext_info,		\
> +		.ext_info = cros_ec_sensors_ext_info,			\
>  		.scan_type = {						\
>  			.sign = 's',					\
> -			.realbits = 16,					\
> -			.storagebits = 16,				\
> +			.realbits = CROS_EC_SENSOR_BITS,		\
> +			.storagebits = CROS_EC_SENSOR_BITS,		\
>  		},							\
> +		.scan_index = CROS_EC_ACCEL_ROTATE_AXIS(_axis),		\
>  	}								\
>  
> -static struct iio_chan_spec ec_accel_channels[] = {
> -	CROS_EC_ACCEL_LEGACY_CHAN(X),
> -	CROS_EC_ACCEL_LEGACY_CHAN(Y),
> -	CROS_EC_ACCEL_LEGACY_CHAN(Z),
> -	IIO_CHAN_SOFT_TIMESTAMP(MAX_AXIS)
> +static const struct iio_chan_spec cros_ec_accel_legacy_channels[] = {
> +		CROS_EC_ACCEL_LEGACY_CHAN(CROS_EC_SENSOR_X),
> +		CROS_EC_ACCEL_LEGACY_CHAN(CROS_EC_SENSOR_Y),
> +		CROS_EC_ACCEL_LEGACY_CHAN(CROS_EC_SENSOR_Z),
> +		IIO_CHAN_SOFT_TIMESTAMP(CROS_EC_SENSOR_MAX_AXIS)
>  };
>  
>  static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct cros_ec_dev *ec = dev_get_drvdata(dev->parent);
> -	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
>  	struct iio_dev *indio_dev;
> -	struct cros_ec_accel_legacy_state *state;
> +	struct cros_ec_sensors_core_state *state;
>  	int ret;
>  
>  	if (!ec || !ec->ec_dev) {
> @@ -351,46 +171,32 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	if (!ec->ec_dev->cmd_readmem) {
> -		dev_warn(&pdev->dev, "EC does not support direct reads.\n");
> -		return -EINVAL;
> -	}
> -
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*state));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	platform_set_drvdata(pdev, indio_dev);
> -	state = iio_priv(indio_dev);
> -	state->ec = ec->ec_dev;
> -	state->sensor_num = sensor_platform->sensor_num;
> -
> -	indio_dev->dev.parent = dev;
> -	indio_dev->name = pdev->name;
> -	indio_dev->channels = ec_accel_channels;
> -	/*
> -	 * Present the channel using HTML5 standard:
> -	 * need to invert X and Y and invert some lid axis.
> -	 */
> -	ec_accel_channels[X].scan_index = Y;
> -	ec_accel_channels[Y].scan_index = X;
> -	ec_accel_channels[Z].scan_index = Z;
> +	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
> +	if (ret)
> +		return ret;
>  
> -	state->sign[Y] = 1;
> +	indio_dev->info = &cros_ec_accel_legacy_info;
> +	state = iio_priv(indio_dev);
>  
> -	if (state->sensor_num == MOTIONSENSE_LOC_LID)
> -		state->sign[X] = state->sign[Z] = -1;
> +	if (state->ec->cmd_readmem != NULL)
> +		state->read_ec_sensors_data = cros_ec_sensors_read_lpc;
>  	else
> -		state->sign[X] = state->sign[Z] = 1;
> -
> -	indio_dev->num_channels = ARRAY_SIZE(ec_accel_channels);
> -	indio_dev->dev.parent = &pdev->dev;
> -	indio_dev->info = &cros_ec_accel_legacy_info;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> +		state->read_ec_sensors_data = cros_ec_accel_legacy_read_cmd;
> +
> +	indio_dev->channels = cros_ec_accel_legacy_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(cros_ec_accel_legacy_channels);
> +	/* The lid sensor needs to be presented inverted. */
> +	if (state->loc == MOTIONSENSE_LOC_LID) {
> +		state->sign[CROS_EC_SENSOR_X] = -1;
> +		state->sign[CROS_EC_SENSOR_Z] = -1;
> +	}
>  
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> -					      cros_ec_accel_legacy_capture,
> -					      NULL);
> +			cros_ec_sensors_capture, NULL);
>  	if (ret)
>  		return ret;
>  

