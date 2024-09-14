Return-Path: <linux-iio+bounces-9549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3917979103
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 15:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B57A1F22CA7
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 13:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2556C1CFEC3;
	Sat, 14 Sep 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UB91XjC2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B81CFEC0;
	Sat, 14 Sep 2024 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726320894; cv=none; b=O6TV3uS5zcuux68XfKVHGIQd7Eqm8Am0Lh06XIDXlapz9x/u1bj21L9HzM3LnkNE8sFiFc5nqt1Mgn/y0gDDEKFidWejlthFYeCUxqWdXMFgKeK1o84YpM5lzkohL/hqWYr0GhUw3Z5r2jGheK3ROABUiEVe5bYdFo6BTkEq5U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726320894; c=relaxed/simple;
	bh=UA+Ahx4H9tczSchnnxH6+0vhcc1dZN7jl6skWGzRNik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTS0odC9GngywAQUMexyymJELtOSjetDnxrwv9iKzQcw9SQCW8rqAe8PD5pPEaR6rs2R+ZFig2F84RdR/B2ru4Ggj2+5B1TwUX3f16Jg1u6uhC946wLBxMJfCtZX03XGDeF3Zv9b8OZsIN8H0Xk6eHv80VEAIqM4xhgs65CHxOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UB91XjC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23625C4CEC4;
	Sat, 14 Sep 2024 13:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726320894;
	bh=UA+Ahx4H9tczSchnnxH6+0vhcc1dZN7jl6skWGzRNik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UB91XjC218s25Sy2De+b4V2ibsDA9Q+Vyo6YcmImVVVbwvkpSHAZkf2PH2TTulRu8
	 UUka/7icjjCq3Lg4lbkIedFM2IexO4umoPBuS/QGB58BQy5KSd4PEfQ+yamU1viXWM
	 4+7sXqVjthK/xMY0me1kO+XpmwJ4S+NHWHzNMInE3Qbvs1ybFdM4DuxrjcIMoBF5uC
	 RwR6oKrSZwOKgjeuzdE1l9Ld29LawEGk3XeGKCG9OvCebGbGjB0wnqutz4l0lS4slW
	 idMJWXdJegu16/RaP65VUkgG36V1FIoG70h6c1fzefa1DsWw3KWbD9SaaPAifipD+w
	 be1VEsRUtvsWQ==
Date: Sat, 14 Sep 2024 14:34:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, songqiang1304521@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: proximity: vl53l0x-i2c: Added continuous
 mode support
Message-ID: <20240914143447.1c5d5623@jic23-huawei>
In-Reply-To: <20240909101508.263085-3-abhashkumarjha123@gmail.com>
References: <20240909101508.263085-1-abhashkumarjha123@gmail.com>
	<20240909101508.263085-3-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Sep 2024 15:45:07 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> The continuous mode of the sensor is enabled in the buffer_postenable.
> Replaced the original irq handler with a threaded irq handler to perform
> i2c reads during continuous mode.
> The continuous mode is disabled by disabling the buffer.
> Added a trigger for this device to be used for continuous mode.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
Hi Abhash,

Applied this with a couple of minor tweaks (see below) to the
testing branch of iio.git.  I'll be rebasing that tree on rc1 once
available and pushing out as togreg which gets picked up by linux-next.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/vl53l0x-i2c.c | 161 +++++++++++++++++++++++-----
>  1 file changed, 135 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index 3f416d3db..cbf030869 100644
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
> @@ -43,20 +49,70 @@
>  #define VL_REG_RESULT_RANGE_STATUS_COMPLETE		BIT(0)
>  
>  #define VL53L0X_MODEL_ID_VAL				0xEE
> +#define VL53L0X_CONTINUOUS_MODE				0x02
> +#define VL53L0X_SINGLE_MODE				0x01
>  
>  struct vl53l0x_data {
>  	struct i2c_client *client;
>  	struct completion completion;
>  	struct regulator *vdd_supply;
>  	struct gpio_desc *reset_gpio;
> +	struct iio_trigger *trig;
> +
> +	struct {
> +		u16 chan;
> +		s64 timestamp __aligned(8);
I tweak this whilst applying to use the new aligned_s64
(the patch crossed with yours)

> +	} scan;
>  };
>  
>
> @@ -153,7 +192,7 @@ static int vl53l0x_read_proximity(struct vl53l0x_data *data,
>  		return -EREMOTEIO;
>  
>  	/* Values should be between 30~1200 in millimeters. */
> -	*val = (buffer[10] << 8) + buffer[11];
> +	*val = get_unaligned_be16(&buffer[10]);

In theory this should have been a different patch, but meh it's tiny so
I'll just take it in here.

>  
>  	return 0;
>  }
> @@ -163,7 +202,14 @@ static const struct iio_chan_spec vl53l0x_channels[] = {
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
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
>  };
>  
>  static int vl53l0x_read_raw(struct iio_dev *indio_dev,
> @@ -193,8 +239,16 @@ static int vl53l0x_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int vl53l0x_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig)
> +{
> +	struct vl53l0x_data *data = iio_priv(indio_dev);
> +
> +	return data->trig == trig ? 0 : -EINVAL;
> +}
> +
>  static const struct iio_info vl53l0x_info = {
>  	.read_raw = vl53l0x_read_raw,
> +	.validate_trigger = vl53l0x_validate_trigger,
>  };
>  
>  static void vl53l0x_power_off(void *_data)
> @@ -221,6 +275,39 @@ static int vl53l0x_power_on(struct vl53l0x_data *data)
>  	return 0;
>  }
>  
> +static int vl53l0x_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct vl53l0x_data *data = iio_priv(indio_dev);
> +
> +	return i2c_smbus_write_byte_data(data->client, VL_REG_SYSRANGE_START,
> +						VL53L0X_CONTINUOUS_MODE);
> +}
> +
> +static int vl53l0x_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct vl53l0x_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, VL_REG_SYSRANGE_START,
> +						VL53L0X_SINGLE_MODE);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Let the ongoing reading finish */
> +	reinit_completion(&data->completion);
> +	wait_for_completion_timeout(&data->completion, HZ / 10);
Trivial but I'll add a blank line here to separate the completion related
bits from the clear irq as they are more or less unrelated.

> +	return vl53l0x_clear_irq(data);
> +}


