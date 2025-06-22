Return-Path: <linux-iio+bounces-20881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BC4AE30B3
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 18:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8050518902CA
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 16:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4779A1E3DCD;
	Sun, 22 Jun 2025 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EU25PpQn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5161422AB;
	Sun, 22 Jun 2025 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750608509; cv=none; b=G7X/PklNWHWEnNW+F8aARktpjYlD5+g7sRjmit4RA56JOumwqc9Abk7lZnXcJZ1a4DncVdDHsM5ym/F3GTwM2cEdkoIIu7U70LYzxss8COsAoxga7kDQ8bMH8Jb4DCxEITrIWE6Wo+57jzYoLPhHHPGgIJRzgftaTg67tIanAvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750608509; c=relaxed/simple;
	bh=IjQDM8KJO5zntPyvvoU9JxdonjeZP+yhZOYoz9EZzGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBfJNJscytSLlE+1QEPCg41/bLm845ZKyIXhbdCDdz5Cy7yTsV7n/O2ixp4+HNOA0lRnpW0JY9agKku9h/ZEkxCAkoirkTOkG1aPKJcshmqI5P8bfzIJoj9irdxvjE16lfYGBPSKetjI1ALRKeshNS3VNK8Xs6/TjTAfQ6jSMWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EU25PpQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83E6C4CEE3;
	Sun, 22 Jun 2025 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750608508;
	bh=IjQDM8KJO5zntPyvvoU9JxdonjeZP+yhZOYoz9EZzGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EU25PpQnisa4pznmpEVRzk1/qhTpQsvWSahaYd7To+qzvn4VtQ+bN/zU+JDVrMdx7
	 SbQCuWhRBEVPjQ45B6m2eptGtWTs5QrHA4xGXyX5Hz5KxBC+a7PY1QoNdJnpsAgaPJ
	 9nu7gyZ0062cayNyaCbsFdtAxWszs/RqLDVKn5J0Myi0VfE29WfLc8I4lJzfVCM/ZR
	 bap76JjmtO1wZKyfI7sBvRAaDC+3HizefR1v0dWUrL7Hior9IMprhFsZ58Xg12XQYT
	 M+xPJ7RLjg/kKK0ELlr8Yjltrbw0IMfTNbvauVoQye48Mvx4lVGJjZCT7qr+AWxKTI
	 fM39C6WOnM3lA==
Date: Sun, 22 Jun 2025 17:08:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <liquancin.mereenamathai@in.bosch.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <vassilisamir@gmail.com>, <marcelo.schmitt1@gmail.com>,
 <javier.carrasco.cruz@gmail.com>, <Xu.Zhang@cn.bosch.com>,
 <Maoting.Bian@cn.bosch.com>
Subject: Re: [PATCH v1 1/2] Add the iio driver for bosch pressure sensor
 bmp390. The bmp390 is a pressure sensor module. It will support SPI and I2C
 protocol based on configuration.
Message-ID: <20250622170822.57723b6e@jic23-huawei>
In-Reply-To: <20250620045456.1151-2-liquancin.mereenamathai@in.bosch.com>
References: <20250620045456.1151-1-liquancin.mereenamathai@in.bosch.com>
	<20250620045456.1151-2-liquancin.mereenamathai@in.bosch.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 10:24:54 +0530
<liquancin.mereenamathai@in.bosch.com> wrote:

> From: Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>
> 
> Implemented features:
> * raw data access for pressure and temp through sysfs
> * iio buffer tool support for continuous sampling
> 
> Signed-off-by: Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>

Note I review backwards as code often makes more sense that way around...

Anyhow, enough comments for now.  The key thing summed up in another review
was: "Make it look like other drivers".  That will save you and reviewers a lot
of time.

> +/**
> + * bmp390_read_raw - Read raw data from the BMP390 sensor
> + * @indio_dev: The IIO device structure
> + * @ch: The IIO channel specification
> + * @val: Pointer to store the raw value
> + * @val2: Pointer to store the second raw value (unused)
> + * @mask: The mask specifying the type of data to read
> + *
> + * This function reads raw data from the BMP390 sensor based on the specified
> + * channel type and mask. It supports reading temperature and pressure data.
> + *
> + * Return: IIO_VAL_INT on success, negative error code on failure.
> + */
> +static int bmp390_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *ch, int *val,
> +			   int *val2, long mask)
> +{
> +	int ret, result;
> +	s32 tval = 0;
> +	struct bmp3_client_data *client_data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case 0:
> +	{
> +		result = 0;
> +		ret = IIO_VAL_INT;
> +		mutex_lock(&client_data->lock);
> +		switch (ch->type) {
> +		case IIO_TEMP:
> +			result = bmp390_read_axis_data(indio_dev,
> +						       ch->address, &tval);
> +			*val = tval;
> +			break;
> +		case IIO_PRESSURE:
> +			result = bmp390_read_axis_data(indio_dev,
> +						       ch->address, &tval);
> +			*val = tval;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +	mutex_unlock(&client_data->lock);
Broken indent.

Look at cleanup.h and guard() / scoped_guard() as appropriate.
Thy simplify code like this a lot.

> +	if (result < 0)
> +		return result;
> +	return ret;
> +	}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +


> +/**
> + * This file defines various IIO device attributes for the BMP390 sensor driver.
> + * Each attribute is associated with specific permissions and corresponding
> + * show and store functions for reading and writing the attribute values.
> + *
> + * Attributes:
> + * - chip_id: Read-only attribute to show the chip ID.
We know that - we matched on it for a particular device already so why provide
it to userspace.  If we do allow matching on unknown IDs then a dev_info
message in the log is the normal solution.

> + * - reg_val: Read-write attribute to show and store register values.
> + * - reg_sel: Read-write attribute to show and store register selection.
Not in sysfs. We have debugfs interfaces for this.

> + * - config_function: Read-write attribute to show and store
> + * configuration functions.

That sounds very dangerous and vague.

> + * - sensor_data: Read-only attribute to show sensor data.
No.  Allow that to be read though standard interfaces only.

> + * - soft_reset: Write-only attribute to call soft reset.

Do that on driver probe only.  They are far to disruptive to expose
on other flows.

> + * - sensor_conf: Read-write attribute to show and store sensor configuration.
Use standard attributes.
> + * - driver_version: Read-only attribute to show the driver version.
We don't support non backwards compatible changes, so driver version have long
been considered pointless for upstream drivers.  If you want to know if a feature
is enable, look for the feature not a driver version.

> + * - avail_sensor: Read-only attribute to show available sensors.
Standard ABI for that - if I read a channel then the sensor is there.

> + * - op_mode: Read-write attribute to show and store operation mode.
I guess this is about power saving.  That stuff is pain to use from userspace
so we hide it and make the decisions based on what the driver is being asked
to do. Look at runtime_pm etc.

> + * - odr: Read-write attribute to show and store output data rate.
Standard ABI exists for that.

> + * - fifo_data: Read-only attribute to show FIFO data.
We have buffered mode data capture for this. Don't invent another way.
> + * - fifo_config: Read-write attribute to show and store FIFO configuration.
Standard ABI for this as well.
> + * - self_test: Write-only attribute to store self-test values.
> + * - iio_generic_buffer: Write-only attribute to store generic buffer values.
I have no idea what this is doing from that description.

> +/**
> + * bmp3_attributes - Array of pointers to device attributes
> + *
> + * This array contains pointers to various device attributes for the BMP390
> + * sensor driver. Each attribute represents a specific configuration or data
> + * point that can be accessed or modified. The attributes include:
> + *
> + * - chip_id: Identifier for the chip
> + * - reg_val: Value of a specific register
> + * - reg_sel: Selected register
> + * - config_function: Configuration function for the sensor
> + * - sensor_data: Data read from the sensor
> + * - soft_reset: Soft reset control
> + * - sensor_conf: Sensor configuration
> + * - driver_version: Version of the driver
> + * - avail_sensor: Available sensors
> + * - op_mode: Operating mode of the sensor
> + * - odr: Output data rate
> + * - fifo_data: Data from the FIFO buffer
> + * - fifo_config: Configuration of the FIFO buffer
> + * - self_test: Self-test control
> + * - iio_generic_buffer: Generic buffer for IIO
> + *
> + * The array is terminated with a NULL pointer.
> + */
> +static struct attribute *bmp3_attributes[] = {
> +	&iio_dev_attr_chip_id.dev_attr.attr,
> +	&iio_dev_attr_reg_val.dev_attr.attr,
> +	&iio_dev_attr_reg_sel.dev_attr.attr,
> +	&iio_dev_attr_config_function.dev_attr.attr,
> +	&iio_dev_attr_sensor_data.dev_attr.attr,
> +	&iio_dev_attr_soft_reset.dev_attr.attr,
> +	&iio_dev_attr_sensor_conf.dev_attr.attr,
> +	&iio_dev_attr_driver_version.dev_attr.attr,
> +	&iio_dev_attr_avail_sensor.dev_attr.attr,
> +	&iio_dev_attr_op_mode.dev_attr.attr,
> +	&iio_dev_attr_odr.dev_attr.attr,
> +	&iio_dev_attr_fifo_data.dev_attr.attr,
> +	&iio_dev_attr_fifo_config.dev_attr.attr,
> +	&iio_dev_attr_self_test.dev_attr.attr,
> +	&iio_dev_attr_iio_generic_buffer.dev_attr.attr,
> +	NULL
> +};
Custom ABI has three key facts
1. Needs documentation in Documentation/ABI/testing/sysfs-bus-iio-xxxxx
2. It is almost never used by any userspace software because code is written
   for a range of sensors not 1.
3. I'll resist hard accepting it for reason 2.  It's basically dead code
   we have to maintain.  

So my advice is remove it all for now.  If you really thing it adds something
significant then propose it in a separate series after the main driver is merged
with full documentation and extra description to explain the use case.

Mostly when we do take 'custom ABI' it's because it is a gap in our main ABI
and we add it there instead so that everyone benefits. 

> +#if defined(BMP3_ENABLE_INT1) || defined(BMP3_ENABLE_INT2)
> +
> +/**
> + * bmp3_irq_work_func - Work function to handle BMP3 interrupts
> + * @work: Pointer to the work_struct associated with the interrupt
> + *
> + * This function is triggered by an interrupt and handles different types of
> + * interrupts from the BMP3 sensor. It checks the interrupt status and performs
> + * the appropriate actions based on the type of interrupt:
> + * - FIFO Watermark Interrupt: Logs the occurrence and processes FIFO data.
> + * - FIFO Full Interrupt: Logs the occurrence and processes FIFO data.
> + * - Data Ready Interrupt: Logs the occurrence, disables
> + * the data ready interrupt, and updates the sensor settings.
> + *
> + * The function uses the bmp3_get_status function to
> + * retrieve the interrupt status
> + * and the check_error function to handle any
> + * errors that occur during processing.
> + */
> +static void bmp3_irq_work_func(struct work_struct *work)

I've stopped looking that closely at the structure given everything
that needs tidying up, but this should probably be in a threaded interrupt.

> +{
> +	/*lint -e26 -e10 -e124 -e40 -e831 -e64 -e119 -e413 -e534*/
> +	struct bmp3_client_data *client_data = container_of(work,
> +		struct bmp3_client_data, irq_work);
> +	/*lint +e26  +e10 +e124 +e40 +e831 +e64 +e119 +e413 +e534*/
> +	int ret = 0;
> +	struct bmp3_status status = { { 0 } };
> +
> +	ret = bmp3_get_status(&status, &client_data->device);
> +	check_error("get int status", ret);
> +
> +	if (ret == BMP3_OK) {
> +		if (status.intr.fifo_wm == BMP3_ENABLE &&
> +		    client_data->fifo_wm_en == BMP3_ENABLE) {
> +			pr_info("FIFO Watermark Interrupt occurred\n");

This is very noisy and these are not error conditions.  We shouldn't see them.

> +			ret = fifo_data_frame_print(client_data);
> +			check_error("fifo_data_frame_print", ret);
> +		} else if ((status.intr.fifo_full == BMP3_ENABLE) &&
> +				(client_data->fifo_full_en == BMP3_ENABLE)) {
> +			pr_info("FIFO Full Interrupt occurred\n");
> +			ret = fifo_data_frame_print(client_data);
> +			check_error("fifo_data_frame_print", ret);
> +		} else if ((status.intr.drdy == BMP3_ENABLE) &&
> +			(client_data->data_ready_en == BMP3_ENABLE)) {
> +			pr_info("Data ready Interrupt occurred\n");
> +			client_data->settings.int_settings.drdy_en = BMP3_DISABLE;
> +			client_data->settings_sel = BMP3_SEL_DRDY_EN;
> +			client_data->data_ready_en = BMP3_DISABLE;
> +			ret = bmp3_set_sensor_settings(client_data->settings_sel,
> +						       &client_data->settings,
> +						       &client_data->device);
> +			check_error("bmp3_set_sensor_settings", ret);
> +		}
> +	}
> +}

> +/**
> + * bmp3_remove - Remove the BMP390 IIO device
> + * @bmp390_iio_private: Pointer to the IIO device structure
> + *
> + * This function performs the necessary cleanup when removing the BMP390
> + * IIO device. It retrieves the client data, introduces a delay, unconfigures
> + * the buffer, unregisters the device, and frees the IRQ.
> + *
> + * Return: Always returns 0.
> + */
> +void bmp3_remove(struct iio_dev *bmp390_iio_private)
> +{
> +	struct bmp3_client_data *client_data;
> +
> +	client_data = iio_priv(bmp390_iio_private);
> +	if (client_data) {

Always available - no need to check.

> +		bmp3_delay_us(MS_TO_US(300),
> +			      &client_data->device.intf_ptr);
> +		bmp390_iio_unconfigure_buffer(bmp390_iio_private);
> +		if (bmp390_iio_private)

If this isn't set then you shouldn't be able to get here. Don't defend
against potential bugs in higher levels of the driver - fix them there.
You would have crashed by here anyway if it were NULL.


> +			iio_device_unregister(bmp390_iio_private);

General rule, register the iio_device last and release it first - this
exposes the userspace interfaces and you don't want those avaialble when other
stuff isn't enabled.

> +		(void)free_irq(client_data->IRQ, client_data);
I don't know what these void casts are about but we don't do this in kernel code.
> +	}
> +}
> +EXPORT_SYMBOL(bmp3_remove);

Namespace exports that are just between different modules in the same driver.

> diff --git a/drivers/iio/pressure/bmp390/bmp390_driver.h b/drivers/iio/pressure/bmp390/bmp390_driver.h
> new file mode 100644
> index 000000000000..6d71ff3b5068
> --- /dev/null
> +++ b/drivers/iio/pressure/bmp390/bmp390_driver.h

> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/input.h>
> +#include <linux/workqueue.h>
> +#include <generated/autoconf.h>
> +#include <linux/slab.h>
> +#include <linux/firmware.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/irq.h>
> +#include <linux/mutex.h>
> +#include <linux/sysfs.h>
> +#include <linux/string.h>
> +#include <linux/iio/sw_device.h>
> +#include <linux/export.h>
> +#include <linux/bitmap.h>
> +#include <linux/hrtimer.h>
> +#include <linux/ktime.h>
> +#include <linux/fs.h>
> +#include <linux/mount.h>
> +#include <linux/syscalls.h>
> +#include <linux/iio/sw_trigger.h>
> +#include <linux/err.h>
> +#include <linux/container_of.h>

Include only what is used in this file.  The c files then include the extra
stuff they need. 


> diff --git a/drivers/iio/pressure/bmp390/bmp390_i2c.c b/drivers/iio/pressure/bmp390/bmp390_i2c.c
> new file mode 100644
> index 000000000000..9d0aea7aa1cc
> --- /dev/null
> +++ b/drivers/iio/pressure/bmp390/bmp390_i2c.c
> @@ -0,0 +1,328 @@

> +/**
> + * bmp390_i2c_write - The I2C write function.
> + *
> + * @client : Instance of the I2C client
> + * @reg_addr : The register address to start writing the data.
> + * @sdata : The pointer to buffer holding data to be written.
> + * @len : The number of bytes to write.
> + *
> + * Return : Status of the function.
> + * * 0 - OK
> + * * negative value - Error.
> + */
> +static s8 bmp390_i2c_write(struct i2c_client *client,
> +			   u8 reg_addr, const u8 *sdata, u16 len)
> +{
> +	s32 retry;
> +
> +	struct i2c_msg msg = {
> +		.addr = client->addr,
> +		.flags = 0,
> +		.len = len + 1,
> +		.buf = NULL,
> +	};
> +	msg.buf = kmalloc(len + 1, GFP_KERNEL);
> +	if (!msg.buf) {
> +		pr_err("Allocate memory failed\n");
> +		return -ENOMEM;
> +	}
> +	msg.buf[0] = reg_addr;
> +	memcpy(&msg.buf[1], sdata, len);
> +	for (retry = 0; retry < BMP3_MAX_RETRY_I2C_XFER; retry++) {

Why the retries? If there isn't a specific reason don't include them.
Papering over bad circuits isn't normally something we do in the kernel.
Get the board designer to ensure a reliable connection instead + harden
callers against potential failure where possible.

> +		if (i2c_transfer(client->adapter, &msg, 1) > 0)
> +			break;
> +		usleep_range(BMP3_I2C_WRITE_DELAY_TIME * 1000,
> +			     BMP3_I2C_WRITE_DELAY_TIME * 1000);
> +	}
> +	kfree(msg.buf);
> +	if (retry >= BMP3_MAX_RETRY_I2C_XFER) {
> +		pr_err("I2C xfer error\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}


> diff --git a/drivers/iio/pressure/bmp390/bmp390_iio_buffer.c b/drivers/iio/pressure/bmp390/bmp390_iio_buffer.c
> new file mode 100644
> index 000000000000..6d7e325fbe06
> --- /dev/null
> +++ b/drivers/iio/pressure/bmp390/bmp390_iio_buffer.c
> @@ -0,0 +1,220 @@

> +
> +/**
> + * bmp390_iio_allocate_trigger() - register trigger resources
> + * @indo_dev: device instance state
> + */
> +int bmp390_iio_allocate_trigger(struct iio_dev *indio_dev)
> +{
> +	struct bmp3_client_data *sdata = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	if (!sdata->trig_info) {

If you get here and this is already set you have a bug that needs fixing.
We don't design kernel code with defenses against things that are clear
bugs in how the functions are used. It adds complexity for now advantage.

> +		sdata->trig_info = kzalloc(sizeof(*sdata->trig_info), GFP_KERNEL);

As below - look at driver using devm_ calls to greatly simplify this stuff.

> +		if (!sdata->trig_info)
> +			return -ENOMEM;
> +
> +		sdata->trig_info->swt.trigger =
> +		iio_trigger_alloc(indio_dev->dev.parent,
> +				  "%s-dev%d",
> +				  indio_dev->name,
> +				  iio_device_id(indio_dev));
> +		if (!sdata->trig_info->swt.trigger) {
> +			ret = -ENOMEM;
> +			goto err_free_trig_info;
> +		}
> +		iio_trigger_set_drvdata(sdata->trig_info->swt.trigger,
> +					sdata->trig_info);
> +		sdata->trig_info->swt.trigger->ops = &iio_hrtimer_trigger_ops;
> +		hrtimer_setup(&sdata->trig_info->timer, iio_hrtimer_trig_handler,
> +			      CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
> +		sdata->trig_info->sampling_frequency =
> +								HRTIMER_DEFAULT_SAMPLING_FREQUENCY;

Odd indentation.

> +		sdata->trig_info->period = ns_to_ktime(10000000);
> +		ret = iio_trigger_register(sdata->trig_info->swt.trigger);
> +		if (ret)
> +			goto err_free_trigger;
> +	}
> +	return ret;
> +err_free_trigger:
> +	iio_trigger_free(sdata->trig_info->swt.trigger);
> +err_free_trig_info:
> +	kfree(sdata->trig_info);
> +	return ret;
> +}
> +
> +/**
> + * bmp390_iio_deallocate_trigger() - release trigger resources
> + * @indo_dev: device instance state
> + */
> +void bmp390_iio_deallocate_trigger(struct iio_dev *indio_dev)
> +{
> +	struct bmp3_client_data *sdata = iio_priv(indio_dev);
> +
> +	if (sdata->trig_info) {
How did you get here if this is NULL? Sounds like a bug.

Look at how other drivers do cleanup with devm which only gets called
for things that succeed.
 
You may need an additional handler or two.

> +		iio_trigger_unregister(sdata->trig_info->swt.trigger);
> +		/* cancel the timer after unreg to make sure no one rearms it */
> +		/*lint -e534*/
> +		hrtimer_cancel(&sdata->trig_info->timer);

That's not a good sign.  A specific IIO driver rarely needs it's own timer related
to the trigger.  If you can't use a dataready signal or similar then just use
the standard hrtimer trigger instead.


> +		/*lint +e534*/
> +		iio_trigger_free(sdata->trig_info->swt.trigger);
> +		kfree(sdata->trig_info);
> +		sdata->trig_info = NULL;
> +	}
> +}
> +
> diff --git a/drivers/iio/pressure/bmp390/bmp390_spi.c b/drivers/iio/pressure/bmp390/bmp390_spi.c
> new file mode 100644
> index 000000000000..9c171df4cb5f
> --- /dev/null
> +++ b/drivers/iio/pressure/bmp390/bmp390_spi.c
> @@ -0,0 +1,286 @@

> +/*********************************************************************/
> +/* own header files */
> +/*********************************************************************/

We can see that from the name. Drop the comment.

> +#include "bmp390_driver.h"
Given this is a driver, the _driver bit probably doesn't add much so rename it.

> +
> +/*********************************************************************/
> +/* Local macro definitions */
> +/*********************************************************************/
> +#define BMP3_MAX_BUFFER_SIZE		32
> +
> +/*********************************************************************/
> +/* global variables */
> +/*********************************************************************/

As below. I'm not going to take any drivers with global variables in them.
It is easy to avoid this - look at all the other drivers for how to do it.

> +static struct spi_device *bmp3_spi_client;
> +struct iio_dev *iio_spi_dev;
> +
> +/*!
> + * @brief define spi block write function
> + *
> + * @param[in] reg_addr register address
> + * @param[in] sdata the pointer of data buffer
> + * @param[in] len block size need to write
> + *
> + * @return zero success, non-zero failed
> + * @retval zero success
> + * @retval non-zero failed
> + */
> +static s8 bmp3_spi_write_block(u8 reg_addr, const u8 *sdata, u8 len)
> +{
> +	struct spi_device *client = bmp3_spi_client;
> +	u8 buffer[BMP3_MAX_BUFFER_SIZE + 1];

That's not DMA safe.  Look at how other drivers do it or use
spi_write_then_read() that performs necessary bounce buffering to allow
any buffer to be used.

> +	struct spi_transfer xfer = {
> +		.tx_buf = buffer,
> +		.len = len + 1,
> +	};
> +	struct spi_message msg;
> +
> +	if (len > BMP3_MAX_BUFFER_SIZE)
> +		return -EINVAL;
> +
> +	buffer[0] = reg_addr & 0x7F;/* write: MSB = 0 */
> +	memcpy(&buffer[1], sdata, len);
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);
> +	return spi_sync(client, &msg);

spi_write()

> +}
> +
> +/*!
> + * @brief define spi block read function
> + *
> + * @param[in] reg_addr register address
> + * @param[out] sdata the pointer of data buffer
> + * @param[in] len block size need to read
> + *
> + * @return zero success, non-zero failed
> + * @retval zero success
> + * @retval non-zero failed
> + */
> +static s8 bmp3_spi_read_block(u8 reg_addr, u8 *sdata, uint16_t len)
> +{
> +	struct spi_device *client = bmp3_spi_client;
> +	u8 reg = reg_addr | 0x80;/* read: MSB = 1 */
> +	struct spi_transfer xfer[2] = {
> +		[0] = {
> +			.tx_buf = &reg,
> +			.len = 1,
> +		},
> +		[1] = {
> +			.rx_buf = sdata,
> +			.len = len,
> +		}
> +	};

spi_write_then_read()
Which also avoids potential DMA buffer safety issues (I've
not gotten far enough to see if that is a problem here)

Look at regmap.  If you can apply that then most likely it
will greatly simplify your driver.  That whole infrastructure
was added to simplify drivers for devices that support multiple busses.

> +	struct spi_message msg;
> +
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer[0], &msg);
> +	spi_message_add_tail(&xfer[1], &msg);
> +	return spi_sync(client, &msg);
> +}
> +
> +/**
> + * bmp3_spi_write_wrapper - The SPI write function pointer used by BMP3 API.
> + *
> + * @reg_addr : The register address to start writing the data.
> + * @sdata : The pointer to buffer which holds the data to be written.
> + * @len : The number of bytes to be written.
> + * @intf_ptr  : Void pointer that can enable the linking of descriptors
> + *			for interface related call backs.
> + *
> + * Return : Status of the function.
> + * * 0 - OK
> + * * negative value - Error.
> + */
> +static s8 bmp3_spi_write_wrapper(u8 reg_addr, const u8 *sdata,
> +				 u32 len, void *intf_ptr)
> +{
> +	s8 err;
> +
> +	err = bmp3_spi_write_block(reg_addr, sdata, len);

This wrapper doesn't seem to be adding much.
If you need that extra parameter, make the bmp3_spi_write_block() take
that and ignore it there.


> +	return err;
> +}
> +
> +/**
> + * bmp3_spi_read_wrapper - The SPI read function pointer used by BMP3 API.
> + *
> + * @reg_addr : The register address to read the data.
> + * @sdata : The pointer to buffer to return data.
> + * @len : The number of bytes to be read
> + *
> + * Return : Status of the function.
> + * * 0 - OK
> + * * negative value - Error.
> + */
> +static s8 bmp3_spi_read_wrapper(u8 reg_addr,
> +				u8 *sdata, u32 len, void *intf_ptr)
> +{
> +	s8 err;
> +
> +	err = bmp3_spi_read_block(reg_addr, sdata, len);
> +	return err;
> +}
> +
> +/*!
> + * @brief sensor probe function via spi bus
> + *
> + * @param[in] client the pointer of spi client
> + *
> + * @return zero success, non-zero failed
> + * @retval zero success
> + * @retval non-zero failed
> + */
> +static int bmp3_spi_probe(struct spi_device *client)
> +{
> +	int status;
> +	int err = 0;
> +	u8 dev_id;
> +	struct bmp3_client_data *client_data = NULL;
> +
> +	if (!bmp3_spi_client) {
> +		bmp3_spi_client = client;
> +	} else {
> +		pr_err("This driver does not support multiple clients!\n");

Fix that. Multiple device instances is absolute requirement for an upstream driver.
There are many many drivers that don't have this restriction. Look at what they do.


> +		return -EBUSY;
> +	}
> +	client->bits_per_word = 8;
> +	status = spi_setup(client);
> +	if (status < 0) {
> +		pr_err("spi_setup failed!\n");
> +		return status;
> +	}
> +	client_data = kzalloc(sizeof(*client_data), GFP_KERNEL);

Why?  Use iio_priv() to get to the version you allocate in that dev_iio_device_alloc()
call just below this.  That is there to ensure lifetimes match.

> +	if (!client_data) {
> +		err = -ENOMEM;
> +		goto exit_err_clean;
> +	}
> +	iio_spi_dev = devm_iio_device_alloc(&client->dev, sizeof(*client_data));
> +	if (!iio_spi_dev)
> +		return -ENOMEM;

Blank line her and in similar places will greatly simplify things.

> +	client_data = iio_priv(iio_spi_dev);
> +	client_data->dev = &client->dev;
> +	dev_id = BMP3_SPI_INTF;
> +	client_data->device.intf_ptr = &dev_id;
> +	client_data->device.intf = BMP3_SPI_INTF;

As mentioned below. If you need a flag for interface type, then your abstraction
needs improving.

> +	client_data->IRQ = client->irq;

No capitals in field names.

> +	client_data->device.read = bmp3_spi_read_wrapper;
> +	client_data->device.write = bmp3_spi_write_wrapper;
> +	iio_spi_dev->dev.parent = &client->dev;

Check if you need to set that... (you don't)

> +	iio_spi_dev->name = "bmp390";
> +	iio_spi_dev->modes = INDIO_DIRECT_MODE;
> +	dev_set_drvdata(&client->dev, iio_spi_dev);
> +
> +	return bmp3_probe(iio_spi_dev);
> +
> +exit_err_clean:
> +	if (err)

If you got here with not error code, why did you get here?

> +		bmp3_spi_client = NULL;
> +	if (iio_spi_dev)
> +		iio_device_free(iio_spi_dev);
Look at what devm does and consider if you need this.
As below global variables all ned to go away.

> +	return err;
> +}
> +
> +/*!
> + * @brief remove bmi spi client
> + *
> + * @param[in] client the pointer of spi client
> + *
> + * @return zero
> + * @retval zero
> + */
> +static void bmp3_spi_remove(struct spi_device *client)
> +{
> +	bmp3_remove(iio_spi_dev);
> +	bmp3_spi_client = NULL;
There should be no globals as you may have multiple instances of
the bmp3 device on one system and unbinding one should have no impact
on the others.

> +}
> +
> +/*!
> + * @brief register spi device id
> + */
> +static const struct spi_device_id bmp3_id[] = {
> +	{ SENSOR_NAME, 0 },

SENSOR_NAME type defines rarely make sense because they give the impression
that there is one value and that there is a reason it needs to match in multiple
places.  Just put the string here and we can see what it is where we need it.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, bmp3_id);

> +/*!
> + * @brief initialize bmi spi module
> + *
> + * @return zero success, non-zero failed
> + * @retval zero success
> + * @retval non-zero failed
> + */
> +static int __init bmp3_spi_init(void)
> +{
> +	return spi_register_driver(&bmp3_spi_driver);

Look at pretty much any modern SPI driver and you'll find we have macros
that mean we don't need these functions to be explicitly provided.

> +}
> +
> +/*!
> + * @brief remove bmi spi module
> + *
> + * @return no return value
> + */
> +static void __exit bmp3_spi_exit(void)
> +{
> +	spi_unregister_driver(&bmp3_spi_driver);
> +}
> +
> +MODULE_AUTHOR("Contact <contact@bosch-sensortec.com>");
> +MODULE_DESCRIPTION("BMP390 SENSOR SPI DRIVER");
> +MODULE_LICENSE("GPL");
> +/*lint -e19 -e546 -e611*/
> +module_init(bmp3_spi_init);
> +module_exit(bmp3_spi_exit);
> +/*lint +e19 +e546 +e611*/

This stuff is fine in your own code repo (perhaps) but it never belongs in upstream code.

> +
> diff --git a/drivers/iio/pressure/bmp390/bmp3_defs.h b/drivers/iio/pressure/bmp390/bmp3_defs.h
> new file mode 100644
> index 000000000000..e3c69887cf36
> --- /dev/null
> +++ b/drivers/iio/pressure/bmp390/bmp3_defs.h
> @@ -0,0 +1,871 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
> +/**
> + * @section LICENSE
> + * Copyright (c) 2024 Bosch Sensortec GmbH All Rights Reserved.
> + *
> + * This software program is licensed subject to the GNU General
> + * Public License (GPL).Version 2,June 1991,
> + * available at http://www.fsf.org/copyleft/gpl.html
> + *
> + * @brief	   Sensor driver for BMP3 sensor
> + * @file       bmp3_defs.h
> + * @date       2022-07-18
> + * @version    v2.0.7
> + *
> + */
> +#ifndef BMP3_DEFS_H_
> +#define BMP3_DEFS_H_
> +
> +/*! CPP guard */
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/********************************************************/
> +/* header includes */
> +#ifdef __KERNEL__
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/math64.h>
> +#else
> +#include <stdint.h>
> +#include <stddef.h>
> +#endif
> +#include <linux/types.h>
> +/*************************** Common macros   *****************************/

Clean all these out.  We don't deal with this stuff in the upstream kernel.

Just use the types directly.


> +
> +#if !defined(UINT8_C) && !defined(INT8_C)
> +#define INT8_C(x)    S8_C(x)
> +#define UINT8_C(x)   U8_C(x)
> +#endif

> +/********************************************************/
> +/**\name Compiler switch macros */
> +
> +#ifndef BMP3_64BIT_COMPENSATION /*< Check if 64bit (using BMP3_64BIT_COMPENSATION) is enabled */
> +#ifndef BMP3_FLOAT_COMPENSATION
> +/*< If 64 bit integer data type is not enabled then enable BMP3_FLOAT_COMPENSATION  */

Always available. Don't do this.

> +/*#define BMP3_FLOAT_COMPENSATION*/
> +#endif
> +#endif
> +
> +/********************************************************/
> +/**\name Macro definitions */

Definitely remove all docs like this that are code layout comments -
they add nothing. We can clearly see they are macro definitions!

> +
> +/**
> + * BMP3_INTF_RET_TYPE is the read/write interface return
> + * type which can be overwritten by the build system.
> + */
> +#ifndef BMP3_INTF_RET_TYPE
> +#define BMP3_INTF_RET_TYPE                      s8
> +#endif
> +
> +/**
> + * The last error code from read/write interface is stored in the device structure as intf_rslt.
> + */
> +#ifndef BMP3_INTF_RET_SUCCESS
> +#define BMP3_INTF_RET_SUCCESS                   INT8_C(0)
> +#endif
> +
> +/**\name I2C addresses */
> +#define BMP3_ADDR_I2C_PRIM                      UINT8_C(0x76)
> +#define BMP3_ADDR_I2C_SEC                       UINT8_C(0x77)
> +
> +/**\name BMP3 chip identifier */
> +#define BMP3_CHIP_ID                            UINT8_C(0x50)
> +#define BMP390_CHIP_ID                          UINT8_C(0x60)
> +
> +/**\name BMP3 pressure settling time (micro secs)*/
> +#define BMP3_SETTLE_TIME_PRESS                  UINT16_C(392)
> +
> +/**\name BMP3 temperature settling time (micro secs) */
> +#define BMP3_SETTLE_TIME_TEMP                   UINT16_C(313)
> +
> +/**\name BMP3 adc conversion time (micro secs) */
> +#define BMP3_ADC_CONV_TIME                      UINT16_C(2000)
> +
> +/**\name Register Address */
> +#define BMP3_REG_CHIP_ID                        UINT8_C(0x00)
> +#define BMP3_REG_ERR                            UINT8_C(0x02)
> +#define BMP3_REG_SENS_STATUS                    UINT8_C(0x03)
> +#define BMP3_REG_DATA                           UINT8_C(0x04)
> +#define BMP3_REG_EVENT                          UINT8_C(0x10)
> +#define BMP3_REG_INT_STATUS                     UINT8_C(0x11)
> +#define BMP3_REG_FIFO_LENGTH                    UINT8_C(0x12)
> +#define BMP3_REG_FIFO_DATA                      UINT8_C(0x14)
> +#define BMP3_REG_FIFO_WM                        UINT8_C(0x15)
> +#define BMP3_REG_FIFO_CONFIG_1                  UINT8_C(0x17)
> +#define BMP3_REG_FIFO_CONFIG_2                  UINT8_C(0x18)
> +#define BMP3_REG_INT_CTRL                       UINT8_C(0x19)
> +#define BMP3_REG_IF_CONF                        UINT8_C(0x1A)
> +#define BMP3_REG_PWR_CTRL                       UINT8_C(0x1B)
> +#define BMP3_REG_OSR                            UINT8_C(0X1C)
> +#define BMP3_REG_ODR                            UINT8_C(0x1D)
> +#define BMP3_REG_CONFIG                         UINT8_C(0x1F)
> +#define BMP3_REG_CALIB_DATA                     UINT8_C(0x31)
> +#define BMP3_REG_CMD                            UINT8_C(0x7E)
> +
> +/**\name Error status macros */
> +#define BMP3_ERR_FATAL                          UINT8_C(0x01)
If these go in a particular register (I'm guessing the BMP3_REG_ERR)
then a nice trick is to put them inline with the register definition
and use white space to differentiate register address, field and value

#define BMP3_ERR_REG		0x02
#define   BMP_ERR_FATAL			BIT(0)
#define   BMP_ERR_CMD			BIT(1)

Use BIT() and GENMASK() ato define fields.

> +#define BMP3_ERR_CMD                            UINT8_C(0x02)
> +#define BMP3_ERR_CONF                           UINT8_C(0x04)
> +
> +/**\name Status macros */
> +#define BMP3_CMD_RDY                            UINT8_C(0x10)
> +#define BMP3_DRDY_PRESS                         UINT8_C(0x20)
> +#define BMP3_DRDY_TEMP                          UINT8_C(0x40)
> +
> +/**\name Power mode macros */
> +#define BMP3_MODE_SLEEP                         UINT8_C(0x00)
> +#define BMP3_MODE_FORCED                        UINT8_C(0x01)
> +#define BMP3_MODE_NORMAL                        UINT8_C(0x03)
Looks like a 2 bit field. Define that with GENMASK then the values within it
as 0, 1, 3

> +
> +/**\name FIFO related macros */
> +/**\name FIFO enable  */
> +#define BMP3_ENABLE                             UINT8_C(0x01)
> +#define BMP3_DISABLE                            UINT8_C(0x00)

For these flag type bit define the field not the value.  Then the obvious
1 == enable 0 == disable becomes intuitive int he code.

> +
> +/**\name Interrupt pin configuration macros */
> +/**\name Open drain */
> +#define BMP3_INT_PIN_OPEN_DRAIN                 UINT8_C(0x01)
> +#define BMP3_INT_PIN_PUSH_PULL                  UINT8_C(0x00)


> +/**\name API error codes */

If these aren't coming from hardware never use your own error codes.
Pick appropriate kernel error codes that already exist.

> +#define BMP3_E_NULL_PTR                         INT8_C(-1)
> +#define BMP3_E_COMM_FAIL                        INT8_C(-2)
> +#define BMP3_E_INVALID_ODR_OSR_SETTINGS         INT8_C(-3)
> +#define BMP3_E_CMD_EXEC_FAILED                  INT8_C(-4)
> +#define BMP3_E_CONFIGURATION_ERR                INT8_C(-5)
> +#define BMP3_E_INVALID_LEN                      INT8_C(-6)
> +#define BMP3_E_DEV_NOT_FOUND                    INT8_C(-7)
> +#define BMP3_E_FIFO_WATERMARK_NOT_REACHED       INT8_C(-8)
> +
> +/**\name API warning codes */
> +#define BMP3_W_SENSOR_NOT_ENABLED               INT8_C(1)
> +#define BMP3_W_INVALID_FIFO_REQ_FRAME_CNT       INT8_C(2)
> +#define BMP3_W_MIN_TEMP                         INT8_C(3)
> +#define BMP3_W_MAX_TEMP                         INT8_C(4)
> +#define BMP3_W_MIN_PRES                         INT8_C(5)
> +#define BMP3_W_MAX_PRES                         INT8_C(6)
> +
> +/**\name Macros to select the which sensor settings are to be set by the user.
> + * These values are internal for API implementation. Don't relate this to
> + * data sheet.
> + */
> +#define BMP3_SEL_PRESS_EN                       UINT16_C(1 << 1)
BIT(1) etc

> +#define BMP3_SEL_TEMP_EN                        UINT16_C(1 << 2)
> +#define BMP3_SEL_DRDY_EN                        UINT16_C(1 << 3)

> +
> +/**\name Macro to combine two 8 bit data's to form a 16 bit data */
> +#define BMP3_CONCAT_BYTES(msb, lsb)             ((((u16)msb) << 8) | ((u16)lsb))

get_unaligned_be16() probably covers many of these cases. If you do need to do it
long hand then just put the shifts etc inline. Don't invent a macro for it.

> +
> +#define BMP3_SET_BITS(reg_data, bitname, data) (((reg_data) & ~(unsigned int)(bitname##_MSK)) | \
> +							(((data) << bitname##_POS) & bitname##_MSK))
> +
> +/* Macro variant to handle the bitname position if it is zero */
> +#define BMP3_SET_BITS_POS_0(reg_data, bitname, data) \
> +						(((reg_data) & ~(unsigned int)(bitname##_MSK)) | \
> +						((data) & bitname##_MSK))

FIELD_PREP() plus appropriate masking.

or if you can use regmap that has a rich set of similar functionality.

> +
> +#define BMP3_GET_BITS(reg_data, bitname)        (((reg_data) & (bitname##_MSK)) >> (bitname##_POS))

FIELD_GET()


> +
> +/* Macro variant to handle the bitname position if it is zero */
> +#define BMP3_GET_BITS_POS_0(reg_data, bitname)  ((reg_data) & (bitname##_MSK))
> +
> +#define BMP3_GET_LSB(var)                       ((u8)((var) & (BMP3_SET_LOW_BYTE)))
> +#define BMP3_GET_MSB(var)                       ((u8)(((var) & ((BMP3_SET_HIGH_BYTE) >> 8))))
Probably replace with appropriate calls to put_unaligned_be16() or similar

Basic rule of thumb - if you've had to define a new macro to do something simple like
that you are not doing it how we do things in the kernel. Either there is a standard
macro or there is a reason one has never been added (normally there is a more general
solution to the problem).

>
> +/********************************************************/
> +/*!
> + * @brief Interface selection Enums
> + */
> +enum bmp3_intf {
> +	/*! SPI interface */
> +	BMP3_SPI_INTF = 0,
> +	/*! I2C interface */
> +	BMP3_I2C_INTF
Trailing comma should be there as no explicit reason there will never be more interfaces.
However I'd be surprised if an explicit interface enum actually makes sense once you've
cleaned this code up.  Normally we either have an appropriate regmap, or some callbacks
if it doesn't map well to regmap.

> +};
> +
> +/********************************************************/
> +/*!
> + * @brief Type definitions
> + */
> +
> +/*!
> + * @brief Bus communication function pointer which should be mapped to
> + * the platform specific read functions of the user
> + *
> + * @param[in]     reg_addr : 8bit register address of the sensor
> + * @param[out]    reg_data : Data from the specified address
> + * @param[in]     length   : Length of the reg_data array
> + * @param[in,out] intf_ptr : Void pointer that can enable the linking of descriptors
> + *                           for interface related callbacks
> + * @retval 0 for Success
> + * @retval Non-zero for Failure
> + */
> +typedef s8 (*bmp3_read_fptr_t)(u8 reg_addr, u8 *, u32 len, void *intf_ptr);

Name all parameters.

> +/*!
> + * @brief Bus communication function pointer which should be mapped to
> + * the platform specific write functions of the user
> + *
> + * @param[in]     reg_addr : 8bit register address of the sensor
> + * @param[out]    reg_data : Data to the specified address
> + * @param[in]     length   : Length of the reg_data array
> + * @param[in,out] intf_ptr : Void pointer that can enable the linking of descriptors
> + *                           for interface related callbacks
> + * @retval 0 for Success
> + * @retval Non-zero for Failure
> + */
>
> +#ifdef __cplusplus
> +}
> +#endif /* End of CPP guard */
> +
> +#endif /* BMP3_DEFS_H_ */
> +
> diff --git a/drivers/iio/pressure/bmp390/bmp3_selftest.c b/drivers/iio/pressure/bmp390/bmp3_selftest.c
> new file mode 100644
> index 000000000000..5fcf15205d48
> --- /dev/null
> +++ b/drivers/iio/pressure/bmp390/bmp3_selftest.c
> @@ -0,0 +1,184 @@

Note that I won't generally repeat similar comments (well not more than a few times) -
apply anything commented on to the whole driver.

> +s8 bmp3_selftest_check(struct bmp3_settings *settings, struct bmp3_dev *dev)
> +{
> +	s8 rslt;
> +	/* Variable used to select the sensor component */
Don't add comments if they name of the variable is sufficient (which it mostly
should be).  Save them for where there is useful data to convey.
> +	u8 sensor_comp;
> +	/* Variable used to store the compensated data */
> +	struct bmp3_data data = { 0 };

= { }; preferred in forcing the whole structure to 0.


> +	/* Used to select the settings user needs to change */
> +	u16 settings_sel;
> +
> +	/* Reset the sensor */
> +	rslt = bmp3_soft_reset(dev);
> +	if (rslt == BMP3_SENSOR_OK) {

	if (rslt != BMP3_SENSOR_OK)
		return rslt;

Basically if you hit an error, return - don't carry on.  That reduces the indent of
the following code making it much easier to read.

> +		rslt = bmp3_init(dev);
> +		if (rslt == BMP3_E_COMM_FAIL || rslt == BMP3_E_DEV_NOT_FOUND)
> +			rslt = BMP3_COMMUNICATION_ERROR_OR_WRONG_DEVICE;

How is that useful over just returning the original error code?

> +
> +		if (rslt == BMP3_SENSOR_OK)

As before, if rslt is an eror don't carry on - just return.

> +			rslt = validate_trimming_param(dev);
> +
> +		if (rslt == BMP3_SENSOR_OK) {
> +			/* Select the pressure and temperature sensor to be enabled */
> +			settings->press_en = BMP3_ENABLE;
> +			settings->temp_en = BMP3_ENABLE;
> +			/*
> +			 * Select the output data rate and over sampling settings
> +			 * for pressure and temperature
> +			 */
> +			settings->odr_filter.press_os = BMP3_NO_OVERSAMPLING;
> +			settings->odr_filter.temp_os = BMP3_NO_OVERSAMPLING;
> +			settings->odr_filter.odr = BMP3_ODR_25_HZ;
> +
> +			/* Assign the settings which needs to be set in the sensor */
> +			settings_sel = BMP3_SEL_PRESS_EN | BMP3_SEL_TEMP_EN |
> +			BMP3_SEL_PRESS_OS | BMP3_SEL_TEMP_OS | BMP3_SEL_ODR;
> +			rslt = bmp3_set_sensor_settings(settings_sel, settings, dev);
> +			if (rslt == BMP3_SENSOR_OK) {
> +				settings->op_mode = BMP3_MODE_NORMAL;
> +				rslt = bmp3_set_op_mode(settings, dev);
> +				if (rslt == BMP3_SENSOR_OK) {
> +					dev->delay_us(40000, dev->intf_ptr);
> +					/* Sensor component selection */
> +					sensor_comp = BMP3_PRESS_TEMP;
> +					/*
> +					 * Temperature and Pressure data are read and
> +					 * stored in the bmp3_data instance
> +					 */
> +
> +					rslt = bmp3_get_sensor_data(sensor_comp, &data, dev);
> +				}
> +			}
> +		}
> +		if (rslt == BMP3_SENSOR_OK) {
> +			rslt = analyze_sensor_data(&data);
> +			/* Set the power mode to sleep mode */
> +			if (rslt == BMP3_SENSOR_OK) {
> +				settings->op_mode = BMP3_MODE_SLEEP;
> +				rslt = bmp3_set_op_mode(settings, dev);
> +			}
> +		}
> +	}
> +	return rslt;
> +}

> +/*
> + * @brief Function to calculate CRC for the trimming parameters
> + */
> +static s8 cal_crc(u8 seed, u8 data)

If you can't use standard kernel crc routines, then add a comment to that affect
here.

> +{
> +	s8 poly = 0x1D;
> +	s8 var2;
> +	u8 i;
> +
> +	for (i = 0; i < 8; i++) {
> +		if ((seed & 0x80) ^ (data & 0x80))
> +			var2 = 1;
> +		else
> +			var2 = 0;
> +		seed = (seed & 0x7F) << 1;
> +		data = (data & 0x7F) << 1;
> +		seed = seed ^ (u8)(poly * var2);
> +	}
> +	return (s8)seed;
> +}
> +
> diff --git a/drivers/iio/pressure/bmp390/bmp3_selftest.h b/drivers/iio/pressure/bmp390/bmp3_selftest.h
> new file mode 100644
> index 000000000000..ab6c4a992011
> --- /dev/null
> +++ b/drivers/iio/pressure/bmp390/bmp3_selftest.h
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
> +/**
> + * @section LICENSE
> + * Copyright (c) 2024 Bosch Sensortec GmbH All Rights Reserved.
> + *
> + * This software program is licensed subject to the GNU General
> + * Public License (GPL).Version 2,June 1991,
> + * available at http://www.fsf.org/copyleft/gpl.html

Generally in modern code the SPDX header + copyright line is considered
enough.  So unless lawyers are telling you differently (in which case
please add a comment on that to the cover letter and patch description)
then cut this down to just

/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */

/*
 * Copyright (c) 2024 Bosch Sensortec GmbH All Rights Reserved.
 */

> + *
> + * @file		bmp3_selftest.h
> + * @date		2024-12-04
> + * @version		v2.1.0
We don't version driver code in the kernel as it continuously evolves.

> + *
> + */
> +
> +#ifndef BMP38X_SELFTEST_H_
> +#define BMP38X_SELFTEST_H_
> +
> +/*! CPP guard */

As already noted, C only in kernel. Drop all these guards.

> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#include "bmp3.h"
> +
> +#ifndef BMP3_FLOAT_COMPENSATION
This seems unlikely to be an option that gets used in kernel so get rid of all this.

> +
> +/* 0 degree celsius */
> +#define BMP3_MIN_TEMPERATURE                                INT16_C(0)

It's just 0. Get rid of that INT16_C wrapper as it should never matter.

> +
> +/* 40 degree celsius */
> +#define BMP3_MAX_TEMPERATURE                                INT16_C(4000)
> +
> +/* 900 hecto Pascals */
> +#define BMP3_MIN_PRESSURE                                   UINT32_C(90000)
> +
> +/* 1100 hecto Pascals */
> +#define BMP3_MAX_PRESSURE                                   UINT32_C(110000)
> +
> +#else
> +
> +/* 0 degree celsius */
> +#define BMP3_MIN_TEMPERATURE                                (0.0f)
> +
> +/* 40 degree celsius */
> +#define BMP3_MAX_TEMPERATURE                                (40.0f)

Floating point number in kernel unlikely to be much use.

> +
> +/* 900 hecto Pascals */
> +#define BMP3_MIN_PRESSURE                                   (900.0f)
> +
> +/* 1100 hecto Pascals */
> +#define BMP3_MAX_PRESSURE                                   (1100.0f)
> +#endif
> +
> +/* Error codes for self test  */
> +#define BMP3_SENSOR_OK                                      UINT8_C(0)
> +#define BMP3_COMMUNICATION_ERROR_OR_WRONG_DEVICE            UINT8_C(10)
> +#define BMP3_TRIMMING_DATA_OUT_OF_BOUND                     UINT8_C(20)
> +#define BMP3_TEMPERATURE_BOUND_WIRE_FAILURE_OR_MEMS_DEFECT  UINT8_C(30)
> +#define BMP3_PRESSURE_BOUND_WIRE_FAILURE_OR_MEMS_DEFECT     UINT8_C(31)
> +#define BMP3_IMPLAUSIBLE_TEMPERATURE                        UINT8_C(40)
> +#define BMP3_IMPLAUSIBLE_PRESSURE                           UINT8_C(41)
> +
> +/**
> + * \ingroup bmp3

As already commented on if you do docs, kernel-doc or standard comments
are the only options accepted in kernel (for c code anyway)


> + * \defgroup bmp3ApiSelftest Self test
> + * @brief Perform self test of sensor
> + */
> +
> +/*!
> + * \ingroup bmp3ApiSelftest
> + * \page bmp3_api_bmp3_selftest_check bmp3_selftest_check
> + * \code
> + * int8_t bmp3_selftest_check(const struct bmp3_dev *dev);
> + * \endcode
> + * @details Self-test API for the BMP38X
> + *
> + * @param[in] settings : Structure instance of bmp3_settings
> + * @param[in]   dev    : Structure instance of bmp3_dev
> + *
> + * @return Result of API execution status
> + * @retval 0  -> Success
> + * @retval <0 -> Error
> + */
> +int8_t bmp3_selftest_check(struct bmp3_settings *settings, struct bmp3_dev *dev);
> +
> +/*! CPP guard */
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* BMP38X_SELFTEST_H_ */
> +


