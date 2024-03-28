Return-Path: <linux-iio+bounces-3853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B62488FFD0
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 14:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 890F41F25D19
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 13:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E030B7F48D;
	Thu, 28 Mar 2024 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGw6CYVk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976D35D8FD
	for <linux-iio@vger.kernel.org>; Thu, 28 Mar 2024 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711631138; cv=none; b=AUdSS9j6upznW3naNZUBcAZiqWzlpiNCJEE2nXnZ30/to8nr02Q+a7OL5JuRwg+B5zbdemPwi2QmtGtC/M1E+ZdnbJAB6uv3MFGMiYVIkH9WaoJBUKaaqrxl5j/UkNa48Knmg7cN2tXlD1fwegpqV2qBUuGo/SF0vhSYooOo+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711631138; c=relaxed/simple;
	bh=bDto0HL6R4MjUhJjY6GDmZuLjFq+pZq8VBOrNbBUMhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENWwdDTa77EuEs2dhWwSqp/qKFdsFnSMJ2lXTeWCOJRHZiYMxs930a13Yo4mi9Tqr/n8jZcoNnN4kIohZMcI4hWIOgoZTEx+8tM1eDUTTdgcGJk0dzkgieXb5ezd9dwKc5ho5QGCPmCpDfFvJJ+jJhLBWbedsK5ujrLES+dGBFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGw6CYVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D049CC433C7;
	Thu, 28 Mar 2024 13:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711631138;
	bh=bDto0HL6R4MjUhJjY6GDmZuLjFq+pZq8VBOrNbBUMhk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AGw6CYVkDsEGuotHDusu7yxj2KhQYA4Rbl77k7VZNu4FXCtUHWQJU18oeu3jfTr9T
	 XfLrOynIXAwYNrQ572Se6MgHZHcs7mT7AT87Mr38yplWpY4nePxo2EQZcDA2KrO3Hn
	 UZVpqBYTyDZ1gFg634Rij9o3UjtibSyjoDs/NGUubeXQ6W4xAWfLw1o71MNitsUOSz
	 1RKRdj/XeCFKfKw1GLA2BqA7BV2v9fGUXtSWAeUR7kmXq/XWqQoCM19M7/7KirpxiL
	 K1UoxK6z9fF78JUdiYyVgRqgSanrE3pzVwj4jG/KTtx+oLYNAa7mWhwjayinvhwyLE
	 pxrEiFrb6uzhQ==
Date: Thu, 28 Mar 2024 13:05:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Christian Oder <me@myself5.de>,
 Nikita Mikhailevich <ermyril@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [RFC 2/2] iio: accel: mxc4005: Reset chip on probe() and
 resume()
Message-ID: <20240328130524.342214f9@jic23-huawei>
In-Reply-To: <20240326113700.56725-3-hdegoede@redhat.com>
References: <20240326113700.56725-1-hdegoede@redhat.com>
	<20240326113700.56725-3-hdegoede@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 12:37:00 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> On some designs the chip is not properly reset when powered up at boot or
> after a suspend/resume cycle.
> 
> Use the sw-reset feature to ensure that the chip is in a clean state
> after probe() / resume() and in the case of resume() restore the settings
> (scale, trigger-enabled).
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218578
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied but with a change to the error handling in resume.
It has the result that a failure may result in later commands not running
but given we are probably dead anyway if we fail there, I'm not that
worried by that tweak.  Plus point is we get the most informative error
code possible.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan


> ---
>  drivers/iio/accel/mxc4005.c | 58 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index 111f4bcf24ad..9f38d3a08299 100644
> --- a/drivers/iio/accel/mxc4005.c
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2014, Intel Corporation.
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
> @@ -36,6 +37,7 @@
>  
>  #define MXC4005_REG_INT_CLR1		0x01
>  #define MXC4005_REG_INT_CLR1_BIT_DRDYC	0x01
> +#define MXC4005_REG_INT_CLR1_SW_RST	0x10
>  
>  #define MXC4005_REG_CONTROL		0x0D
>  #define MXC4005_REG_CONTROL_MASK_FSR	GENMASK(6, 5)
> @@ -43,6 +45,9 @@
>  
>  #define MXC4005_REG_DEVICE_ID		0x0E
>  
> +/* Datasheet does not specify a reset time, this is a conservative guess */
> +#define MXC4005_RESET_TIME_US		2000
> +
>  enum mxc4005_axis {
>  	AXIS_X,
>  	AXIS_Y,
> @@ -66,6 +71,8 @@ struct mxc4005_data {
>  		s64 timestamp __aligned(8);
>  	} scan;
>  	bool trigger_enabled;
> +	unsigned int control;
> +	unsigned int int_mask1;
>  };
>  
>  /*
> @@ -349,6 +356,7 @@ static int mxc4005_set_trigger_state(struct iio_trigger *trig,
>  		return ret;
>  	}
>  
> +	data->int_mask1 = val;
>  	data->trigger_enabled = state;
>  	mutex_unlock(&data->mutex);
>  
> @@ -384,6 +392,13 @@ static int mxc4005_chip_init(struct mxc4005_data *data)
>  
>  	dev_dbg(data->dev, "MXC4005 chip id %02x\n", reg);
>  
> +	ret = regmap_write(data->regmap, MXC4005_REG_INT_CLR1,
> +			   MXC4005_REG_INT_CLR1_SW_RST);
> +	if (ret < 0)
> +		return dev_err_probe(data->dev, ret, "resetting chip\n");
> +
> +	fsleep(MXC4005_RESET_TIME_US);
> +
>  	ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK0, 0);
>  	if (ret < 0)
>  		return dev_err_probe(data->dev, ret, "writing INT_MASK0\n");
> @@ -479,6 +494,48 @@ static int mxc4005_probe(struct i2c_client *client)
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
> +static int mxc4005_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct mxc4005_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	/* Save control to restore it on resume */
> +	ret = regmap_read(data->regmap, MXC4005_REG_CONTROL, &data->control);
> +	if (ret < 0)
> +		dev_err(data->dev, "failed to read reg_control\n");
> +
> +	return ret;
> +}
> +
> +static int mxc4005_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct mxc4005_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, MXC4005_REG_INT_CLR1,
> +			   MXC4005_REG_INT_CLR1_SW_RST);
> +	if (ret) {
> +		dev_err(data->dev, "failed to reset chip: %d\n", ret);
> +		return ret;
> +	}
> +
> +	fsleep(MXC4005_RESET_TIME_US);
> +
> +	ret = regmap_write(data->regmap, MXC4005_REG_CONTROL, data->control);
> +	ret |= regmap_write(data->regmap, MXC4005_REG_INT_MASK0, 0);
> +	ret |= regmap_write(data->regmap, MXC4005_REG_INT_MASK1, data->int_mask1);
> +	if (ret) {
I'm really not a fan of doing this for return handling because you are eating the
useful values (to avoid corrupting them).  Better to have separate error
checks for each one. 
Given that's trivial I can make that change whilst applying.

Change made is: 
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index 9f38d3a08299..63c3566a533b 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -524,11 +524,21 @@ static int mxc4005_resume(struct device *dev)
        fsleep(MXC4005_RESET_TIME_US);
 
        ret = regmap_write(data->regmap, MXC4005_REG_CONTROL, data->control);
-       ret |= regmap_write(data->regmap, MXC4005_REG_INT_MASK0, 0);
-       ret |= regmap_write(data->regmap, MXC4005_REG_INT_MASK1, data->int_mask1);
        if (ret) {
-               dev_err(data->dev, "failed to restore registers\n");
-               return -EIO;
+               dev_err(data->dev, "failed to restore control register\n");
+               return ret;
+       }
+
+       ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK0, 0);
+       if (ret) {
+               dev_err(data->dev, "failed to restore interrupt 0 mask\n");
+               return ret;
+       }
+
+       ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK1, data->int_mask1);
+       if (ret) {
+               dev_err(data->dev, "failed to restore interrupt 1 mask\n");
+               return ret;
        }
 
        return 0;



> +		dev_err(data->dev, "failed to restore registers\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(mxc4005_pm_ops, mxc4005_suspend, mxc4005_resume);
> +
>  static const struct acpi_device_id mxc4005_acpi_match[] = {
>  	{"MXC4005",	0},
>  	{"MXC6655",	0},
> @@ -506,6 +563,7 @@ static struct i2c_driver mxc4005_driver = {
>  		.name = MXC4005_DRV_NAME,
>  		.acpi_match_table = mxc4005_acpi_match,
>  		.of_match_table = mxc4005_of_match,
> +		.pm = pm_sleep_ptr(&mxc4005_pm_ops),
>  	},
>  	.probe		= mxc4005_probe,
>  	.id_table	= mxc4005_id,


