Return-Path: <linux-iio+bounces-8918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A9696719A
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 14:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2C41C21929
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 12:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF229180A76;
	Sat, 31 Aug 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDBy8k9B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49717F4EC;
	Sat, 31 Aug 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725108145; cv=none; b=YA73wHqrU0lzmTKxzrYGHeBI4psomY3vUeZVD2ITH8ehC7xAmfbwOJVAlvnrxnMcNMFmY7JSJ8pBgM+Op0sI6mW7EfmwhZYCwU/xMbMIbMksJka9ydQ605AOYBokd13fRFA6t+mEnrwaxf8wF78ksdSKl4wfuC5maDWNiR3Db+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725108145; c=relaxed/simple;
	bh=v6y69RjiduGonD4am7MQx1/6AhSkXwcxwN81z8A1Dg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vC+i/7PJ0lyu+N4jdreGoCmy75sx4nVtRjWsLYfJaSuLucXSnZ4zBKKYXMDR4/9KgfciwBo+Og3VvEb3DYT2bUGhrWrxF9SWHZkRk0LIAU9z+jxfqubKJZaFQSkVvBmAhaBapAe90iCgCe5xwUijHw2VmrESpE6Bt8U4VYY7j1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDBy8k9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4825DC4CEC0;
	Sat, 31 Aug 2024 12:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725108145;
	bh=v6y69RjiduGonD4am7MQx1/6AhSkXwcxwN81z8A1Dg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gDBy8k9BgtypnGAdUwvzoMs0D90LyLzKx9k8MZ+isDlo6tPWU9MEOHIkyiCu7Uu7X
	 oyppr+mFQOQ6ViuELqwU6ssvBvdEzmN0IwsEsUtpE//1Nem5lANqZcSWjTSCOj+5QU
	 CDbNqGPKqBwsboQ2GxasrAh47SPnyD+0CSJXlA6KrNet/Athtap5JZ+DmLyKXXnqgM
	 IZFHDrp2qEfgbLFKotgY7cyX97IYGP2G5w7ChCWT/D70ZEzM9n+jpk95qI3rIjhnCH
	 fRB5Nakkbm0/DZQPrGVzmtMCoY0BZQ0+aJO7Ut1/5yz99ZroV7waqcTE8fd4KkNiPp
	 WZ2txFpsqvTcA==
Date: Sat, 31 Aug 2024 13:42:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, songqiang1304521@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: proximity: vl53l0x-i2c: Added continuous mode
 support
Message-ID: <20240831134219.3d394c1a@jic23-huawei>
In-Reply-To: <20240830201627.298264-3-abhashkumarjha123@gmail.com>
References: <20240830201627.298264-1-abhashkumarjha123@gmail.com>
	<20240830201627.298264-3-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 31 Aug 2024 01:46:26 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> The continuous mode of the sensor is enabled in the buffer_postenable.
> Replaced the original irq handler with a threaded irq handler to perform
> i2c reads during continuous mode.
> The continuous mode is disabled by disabling the buffer.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>

Hi Abhash,

You've ended up with an implementation that is somewhere between
a triggered buffer approach (normal one an appropriate here) and that
used when we don't have triggers (typically because there is a fifo in the path).

Please take a look at how other drivers do this.  In particularly if you
are not pushing data to the buffer from the pollfunc (registered for the
triggered buffer) then you are doing it wrong.

Also, consider if other triggers could be used as if not you need to
both document why and add the validation callbacks to stop other triggers
being assigned (once you've added one that can be!)

Feel free to ask if you have more questions, but your first reference
should be other drivers (and I hope we don't have any that do it this way).

Jonathan

> ---
>  drivers/iio/proximity/vl53l0x-i2c.c | 125 ++++++++++++++++++++++------
>  1 file changed, 101 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index 2b3dd18be..b0c947586 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -22,6 +22,10 @@
>  #include <linux/module.h>
>  
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #define VL_REG_SYSRANGE_START				0x00
>  
> @@ -49,14 +53,58 @@ struct vl53l0x_data {
>  	struct completion completion;
>  	struct regulator *vdd_supply;
>  	struct gpio_desc *reset_gpio;
> +
> +	struct {
> +		u16 chan;
> +		s64 timestamp __aligned(8);
> +	} scan;
>  };
>  
> -static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
> +static void vl53l0x_clear_irq(struct vl53l0x_data *data)
> +{
> +	struct device *dev = &data->client->dev;
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					VL_REG_SYSTEM_INTERRUPT_CLEAR, 1);
> +	if (ret < 0)
> +		dev_err(dev, "failed to clear error irq: %d\n", ret);
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					VL_REG_SYSTEM_INTERRUPT_CLEAR, 0);
> +	if (ret < 0)
> +		dev_err(dev, "failed to clear range irq: %d\n", ret);

ouch, not a write 1 to clear register?  I can't find docs, but this is really
nasty bit of interface design if you have to toggle the bit.

> +
> +	ret = i2c_smbus_read_byte_data(data->client, VL_REG_RESULT_INT_STATUS);
> +	if (ret < 0 || ret & 0x07)
> +		dev_err(dev, "failed to clear irq: %d\n", ret);

return an error from this, and elect whether to do anything or not
with that at the caller.

> +}
> +
> +static irqreturn_t vl53l0x_threaded_irq(int irq, void *priv)
>  {
>  	struct iio_dev *indio_dev = priv;
>  	struct vl53l0x_data *data = iio_priv(indio_dev);
> +	u8 buffer[12];

See below for more comments, but this is not a triggered buffer
setup. It looks like what we do when draining fifos (where a trigger
concept doesn't apply) but that's not what you have here.  So take
a look at how the split trigger / triggered buffer approach works
in other drivers.

> +	int ret;
>  
> -	complete(&data->completion);
> +	if (iio_buffer_enabled(indio_dev)) {
> +		ret = i2c_smbus_read_i2c_block_data(data->client,
> +						VL_REG_RESULT_RANGE_STATUS,
> +						sizeof(buffer), buffer);
> +		if (ret < 0)
> +			return ret;
> +		else if (ret != 12)
> +			return -EREMOTEIO;
> +
> +		data->scan.chan = (buffer[10] << 8) + buffer[11];

get_unaligned_be16()


> +		iio_push_to_buffers_with_timestamp(indio_dev,
> +						&data->scan,
> +						iio_get_time_ns(indio_dev));

If you are using a trigger (and they are optional) then this interrupt should
only be call iio_trigger_poll_nested() not do the data reading.


> +
> +		iio_trigger_notify_done(indio_dev->trig);
> +		vl53l0x_clear_irq(data);
> +	} else
> +		complete(&data->completion);
>  
>  	return IRQ_HANDLED;
>  }

>  
> -static void vl53l0x_clear_irq(struct vl53l0x_data *data)
> -{
> -	struct device *dev = &data->client->dev;
> -	int ret;
> -
> -	ret = i2c_smbus_write_byte_data(data->client,
> -					VL_REG_SYSTEM_INTERRUPT_CLEAR, 1);
> -	if (ret < 0)
> -		dev_err(dev, "failed to clear error irq: %d\n", ret);
> -
> -	ret = i2c_smbus_write_byte_data(data->client,
> -					VL_REG_SYSTEM_INTERRUPT_CLEAR, 0);
> -	if (ret < 0)
> -		dev_err(dev, "failed to clear range irq: %d\n", ret);
> -
> -	ret = i2c_smbus_read_byte_data(data->client, VL_REG_RESULT_INT_STATUS);
> -	if (ret < 0 || ret & 0x07)
> -		dev_err(dev, "failed to clear irq: %d\n", ret);
> -}
> -

>  
>  static int vl53l0x_read_raw(struct iio_dev *indio_dev,
> @@ -221,6 +257,40 @@ static int vl53l0x_power_on(struct vl53l0x_data *data)
>  	return 0;
>  }
>  
> +static int vl53l0x_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct vl53l0x_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, VL_REG_SYSRANGE_START, 0x02);

return i2c_smbus_write_byte_data()

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int vl53l0x_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct vl53l0x_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, VL_REG_SYSRANGE_START, 0x01);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Let the ongoing reading finish */
> +	reinit_completion(&data->completion);
> +	wait_for_completion_timeout(&data->completion, HZ/10);
Spaces around /

> +	vl53l0x_clear_irq(data);
> +
> +	return 0;
> +}

>  static int vl53l0x_probe(struct i2c_client *client)
>  {
>  	struct vl53l0x_data *data;
> @@ -279,6 +349,13 @@ static int vl53l0x_probe(struct i2c_client *client)
>  		ret = vl53l0x_configure_irq(client, indio_dev);
>  		if (ret)
>  			return ret;
> +
> +		ret = devm_iio_triggered_buffer_setup(&client->dev,
> +					indio_dev,
> +					&iio_pollfunc_store_time,

This is odd.  You don't seem to have a function to be called to actually store
the data.  Note you also need to consider if other triggers might be used.

Ultimately this doesn't look like a triggered buffer to me.
It is fine for some devices to drive the buffer directly but in that
case register the kfifo buffer. 

I'm not sure what reason we have to do that here though as this is a very
conventional one interrupt per 'scan' of data device.

So you should be registering a trigger, and a buffer then letting the
trigger drive the buffer.



> +					NULL, &iio_triggered_buffer_setup_ops);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	return devm_iio_device_register(&client->dev, indio_dev);


