Return-Path: <linux-iio+bounces-9300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ED5970339
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 18:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96FB9B22819
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396CC15CD64;
	Sat,  7 Sep 2024 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbgABuco"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70DF1494B2;
	Sat,  7 Sep 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725727908; cv=none; b=BpcjnuwX2sWknVluYdis4pte/t+bbH4Kp820ogFAD2T0o6YmihjQy8vYV0MkMoohXBziGKeeUSLTkOKxRjQi9RAyu4dXNaB0BmIr9SCIeMcJM0jKMVH01OxjxOhHS4Ditsy/GJ4npROfcBiKuVd03MhXXPu1DK2GFl8vdDTTO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725727908; c=relaxed/simple;
	bh=kMlhQMg4JT6QIjMP8ke0kwOdAb0W77/KBCV79nq4QLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDAWmrD+H78A3D6xkagGVca4Mv0hza6EMYpnR8k/NMXBanWayjDukestcjjkg0/+ReBhoQO2sirwrbvK8wEjPbX8sre77qvDvF47uXOX+T3pGdOu+//79iz628kPJvv4t+uLfhJdyPqiGk8n2dZy0U4mbBoXY9uFHRj9+yE6Owo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbgABuco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FD8C4CEC2;
	Sat,  7 Sep 2024 16:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725727907;
	bh=kMlhQMg4JT6QIjMP8ke0kwOdAb0W77/KBCV79nq4QLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fbgABucotWYMGBEe3w5oWYfJuQGEaZddRe46N8xbMN/RTqKISMlF9lmX22Ut07+C9
	 iRAMSgPqqoeWOA828QZPl2BJTOakbv9BNOLuBY+7lctcQO4OvKKLgN/Y3Dy/EE7Hhb
	 6DVYSomzWwjcxWpx7fuogO982TEh/yiLP1w4EnTxbhmICXh+/6v+/Ws3gSujuEe/FD
	 0UZs3AoRZR2yLjAhz72AAXTJ4Op5BstEdiYsejU2wdxkUwcwhoyaxvVV/qMJY2EL55
	 cJsfqsbYlRSiOgHNgVCOps1NadpYFqrrUlFxBRusyeMpXJc/teq+V0U/1Ucy+83XZT
	 eVvt4nyxX6CRA==
Date: Sat, 7 Sep 2024 17:51:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, songqiang1304521@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: proximity: vl53l0x-i2c: Added continuous
 mode support
Message-ID: <20240907175123.0be3a531@jic23-huawei>
In-Reply-To: <20240903035636.9559-3-abhashkumarjha123@gmail.com>
References: <20240903035636.9559-1-abhashkumarjha123@gmail.com>
	<20240903035636.9559-3-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Sep 2024 09:26:36 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> The continuous mode of the sensor is enabled in the buffer_postenable.
> Replaced the original irq handler with a threaded irq handler to perform
> i2c reads during continuous mode.
> The continuous mode is disabled by disabling the buffer.
> Added a trigger for this device to be used for continuous mode.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>

Just to check, did you try this with other triggers?
Currently you have a check that the trigger is only used with the device
but not the validate_trigger that says the device may only use this
trigger.

A few minor comments inline. This is looking good in general.

Jonathan

> ---
>  drivers/iio/proximity/vl53l0x-i2c.c | 164 +++++++++++++++++++++++-----
>  1 file changed, 139 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index 31d6aeb95..f91a9495a 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -22,6 +22,12 @@
>  #include <linux/module.h>
>  
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#include <asm/unaligned.h>
>  
>  #define VL_REG_SYSRANGE_START				0x00
>  
> @@ -49,14 +55,75 @@ struct vl53l0x_data {
>  	struct completion completion;
>  	struct regulator *vdd_supply;
>  	struct gpio_desc *reset_gpio;
> +	struct iio_trigger *trig;
> +
> +	struct {
> +		u16 chan;
> +		s64 timestamp __aligned(8);
> +	} scan;
>  };
>  
> -static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
> +static int vl53l0x_clear_irq(struct vl53l0x_data *data)
> +{
> +	struct device *dev = &data->client->dev;
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					VL_REG_SYSTEM_INTERRUPT_CLEAR, 1);
> +	if (ret < 0)
> +		dev_err(dev, "failed to clear error irq: %d\n", ret);
It's unusual to carry on after a failed write. Add a comment on why that
makes sense here.
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					VL_REG_SYSTEM_INTERRUPT_CLEAR, 0);
> +	if (ret < 0)
> +		dev_err(dev, "failed to clear range irq: %d\n", ret);
> +
> +	ret = i2c_smbus_read_byte_data(data->client, VL_REG_RESULT_INT_STATUS);
> +	if (ret < 0 || ret & 0x07) {
> +		dev_err(dev, "failed to clear irq: %d\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t vl53l0x_trigger_handler(int irq, void *priv)
> +{
> +	struct iio_poll_func *pf = priv;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct vl53l0x_data *data = iio_priv(indio_dev);
> +	u8 buffer[12];
> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(data->client,
> +					VL_REG_RESULT_RANGE_STATUS,
> +					sizeof(buffer), buffer);
> +	if (ret < 0)
> +		return ret;
> +	else if (ret != 12)
> +		return -EREMOTEIO;
> +
> +	data->scan.chan = get_unaligned_be16(&buffer[10]);
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> +					iio_get_time_ns(indio_dev));
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +	ret = vl53l0x_clear_irq(data);
> +	if (ret < 0)
> +		return ret;

you can't return normal error values from an interrupt handler.
Print a message and return IRQ_HANDLED is probably the right thing to do.

> +
> +	return IRQ_HANDLED;
> +}



>  static int vl53l0x_read_proximity(struct vl53l0x_data *data,
>  				  const struct iio_chan_spec *chan,
>  				  int *val)
> @@ -128,7 +176,9 @@ static int vl53l0x_read_proximity(struct vl53l0x_data *data,
>  		if (time_left == 0)
>  			return -ETIMEDOUT;
>  
> -		vl53l0x_clear_irq(data);
> +		ret = vl53l0x_clear_irq(data);
> +		if (ret < 0)
> +			return ret;
>  	} else {
>  		do {
>  			ret = i2c_smbus_read_byte_data(client,
> @@ -163,7 +213,14 @@ static const struct iio_chan_spec vl53l0x_channels[] = {
>  		.type = IIO_DISTANCE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 12,
> +			.storagebits = 16,
> +		},
>  	},
> +	IIO_CHAN_SOFT_TIMESTAMP(32),
32
That's a big channel index to set.  Technically you can do that as they
are monotonic only, but more normal to have it right after the previous channel.

>  };
>  
>  static int vl53l0x_read_raw(struct iio_dev *indio_dev,
> @@ -221,6 +278,41 @@ static int vl53l0x_power_on(struct vl53l0x_data *data)
>  	return 0;
>  }
>  
> +static int vl53l0x_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct vl53l0x_data *data = iio_priv(indio_dev);
> +
> +	return i2c_smbus_write_byte_data(data->client, VL_REG_SYSRANGE_START, 0x02);
> +}
> +
> +static int vl53l0x_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct vl53l0x_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, VL_REG_SYSRANGE_START, 0x01);

Can we name that 0x01 and the 0x02 above with names that give
us a hint what they are doing?

> +	if (ret < 0)
> +		return ret;
> +
> +	/* Let the ongoing reading finish */
> +	reinit_completion(&data->completion);
> +	wait_for_completion_timeout(&data->completion, HZ/10);

Space around the / to comply with kernel style.

> +	vl53l0x_clear_irq(data);
> +	if (ret < 0)

ret not set by anyone.

If it's form vl53l0x_clear_irq() and that can't do positive returns then
return vl53l0x_clear_irq(data);
should work.

> +		return ret;
> +
> +	return 0;
> +}
> +static const struct iio_trigger_ops vl53l0x_trigger_ops = {
> +	.validate_device = iio_trigger_validate_own_device,
> +};

