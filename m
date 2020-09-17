Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E720C26E399
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 20:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgIQSag (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 14:30:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgIQSae (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Sep 2020 14:30:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FC5A206CA;
        Thu, 17 Sep 2020 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600366905;
        bh=gbdNmATD62JKEgdPH9EYda7PDR8pNtopYK0XtZQs40o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Go+bUc8QGS/mTuTaJQYcJe27iYvMXQ1NEhVerbFM5RgKv7yrtf9S9sHbXHUaw9BpA
         jgV2mUW9V/67uoudSiL4O0O1/2T0vNQw6do1ayz85mKHx+vkQa+nFVw7p+aB9up+hm
         P71XaDYCQ9Reb43FC5giZLeEL4fCoVxLTlL2viIA=
Date:   Thu, 17 Sep 2020 19:21:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
Cc:     linux-iio@vger.kernel.org, songqiang1304521@gmail.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH v2 2/2] iio: proximity: vl53l0x: Add IRQ support
Message-ID: <20200917192140.249cd923@archlinux>
In-Reply-To: <20200916074458.873359-2-drobyshevskyi@gmail.com>
References: <20200913113357.47e0c0a1@archlinux>
        <20200916074458.873359-1-drobyshevskyi@gmail.com>
        <20200916074458.873359-2-drobyshevskyi@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Sep 2020 10:44:58 +0300
Ivan Drobyshevskyi <drobyshevskyi@gmail.com> wrote:

> VL53L0X can be configured to use interrupt pin (GPIO1)
> to notify host about readiness of new measurement.
> 
> If interrupt pin is not specified, driver still uses polling.
> 
> Signed-off-by: Ivan Drobyshevskyi <drobyshevskyi@gmail.com>

For future reference, I'd prefer a new version as not threaded with
the previous one.  When we get to many versions it makes things
completely unreadable.

Patches look good to me and the dt change is trivial enough I'll
pick it up without wasting DT reviewers time.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it and see if we missed anything.

Thanks,

Jonathan

> ---
> changes since v1:
>  - remove explicit DT parsing for IRQ number, reuse i2c_client's irq
>  - add checking of i2c_smbus_write_byte_data return value
>  - fix checking of i2c_smbus_read_byte_data return value
>  - other styling/cosmetic changes as suggested by Jonathan
> 
>  drivers/iio/proximity/vl53l0x-i2c.c | 104 +++++++++++++++++++++++++---
>  1 file changed, 93 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index b48216cc1..e92a0bf79 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -4,18 +4,19 @@
>   *
>   * Copyright (C) 2016 STMicroelectronics Imaging Division.
>   * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> + * Copyright (C) 2020 Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
>   *
>   * Datasheet available at
>   * <https://www.st.com/resource/en/datasheet/vl53l0x.pdf>
>   *
>   * Default 7-bit i2c slave address 0x29.
>   *
> - * TODO: FIFO buffer, continuous mode, interrupts, range selection,
> - * sensor ID check.
> + * TODO: FIFO buffer, continuous mode, range selection, sensor ID check.
>   */
>  
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
>  
>  #include <linux/iio/iio.h>
> @@ -29,14 +30,72 @@
>  #define VL_REG_SYSRANGE_MODE_TIMED			BIT(2)
>  #define VL_REG_SYSRANGE_MODE_HISTOGRAM			BIT(3)
>  
> +#define VL_REG_SYSTEM_INTERRUPT_CONFIG_GPIO		0x0A
> +#define VL_REG_SYSTEM_INTERRUPT_GPIO_NEW_SAMPLE_READY	BIT(2)
> +
> +#define VL_REG_SYSTEM_INTERRUPT_CLEAR			0x0B
> +
>  #define VL_REG_RESULT_INT_STATUS			0x13
>  #define VL_REG_RESULT_RANGE_STATUS			0x14
>  #define VL_REG_RESULT_RANGE_STATUS_COMPLETE		BIT(0)
>  
>  struct vl53l0x_data {
>  	struct i2c_client *client;
> +	struct completion completion;
>  };
>  
> +static irqreturn_t vl53l0x_handle_irq(int irq, void *priv)
> +{
> +	struct iio_dev *indio_dev = priv;
> +	struct vl53l0x_data *data = iio_priv(indio_dev);
> +
> +	complete(&data->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int vl53l0x_configure_irq(struct i2c_client *client,
> +				 struct iio_dev *indio_dev)
> +{
> +	struct vl53l0x_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = devm_request_irq(&client->dev, client->irq, vl53l0x_handle_irq,
> +			IRQF_TRIGGER_FALLING, indio_dev->name, indio_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "devm_request_irq error: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +			VL_REG_SYSTEM_INTERRUPT_CONFIG_GPIO,
> +			VL_REG_SYSTEM_INTERRUPT_GPIO_NEW_SAMPLE_READY);
> +	if (ret < 0)
> +		dev_err(&client->dev, "failed to configure IRQ: %d\n", ret);
> +
> +	return ret;
> +}
> +
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
> +
> +	ret = i2c_smbus_read_byte_data(data->client, VL_REG_RESULT_INT_STATUS);
> +	if (ret < 0 || ret & 0x07)
> +		dev_err(dev, "failed to clear irq: %d\n", ret);
> +}
> +
>  static int vl53l0x_read_proximity(struct vl53l0x_data *data,
>  				  const struct iio_chan_spec *chan,
>  				  int *val)
> @@ -50,19 +109,31 @@ static int vl53l0x_read_proximity(struct vl53l0x_data *data,
>  	if (ret < 0)
>  		return ret;
>  
> -	do {
> -		ret = i2c_smbus_read_byte_data(client,
> -					       VL_REG_RESULT_RANGE_STATUS);
> +	if (data->client->irq) {
> +		reinit_completion(&data->completion);
> +
> +		ret = wait_for_completion_timeout(&data->completion, HZ/10);
>  		if (ret < 0)
>  			return ret;
> +		else if (ret == 0)
> +			return -ETIMEDOUT;
>  
> -		if (ret & VL_REG_RESULT_RANGE_STATUS_COMPLETE)
> -			break;
> +		vl53l0x_clear_irq(data);
> +	} else {
> +		do {
> +			ret = i2c_smbus_read_byte_data(client,
> +					       VL_REG_RESULT_RANGE_STATUS);
> +			if (ret < 0)
> +				return ret;
>  
> -		usleep_range(1000, 5000);
> -	} while (--tries);
> -	if (!tries)
> -		return -ETIMEDOUT;
> +			if (ret & VL_REG_RESULT_RANGE_STATUS_COMPLETE)
> +				break;
> +
> +			usleep_range(1000, 5000);
> +		} while (--tries);
> +		if (!tries)
> +			return -ETIMEDOUT;
> +	}
>  
>  	ret = i2c_smbus_read_i2c_block_data(client, VL_REG_RESULT_RANGE_STATUS,
>  					    12, buffer);
> @@ -141,6 +212,17 @@ static int vl53l0x_probe(struct i2c_client *client)
>  	indio_dev->num_channels = ARRAY_SIZE(vl53l0x_channels);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	/* usage of interrupt is optional */
> +	if (client->irq) {
> +		int ret;
> +
> +		init_completion(&data->completion);
> +
> +		ret = vl53l0x_configure_irq(client, indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  

