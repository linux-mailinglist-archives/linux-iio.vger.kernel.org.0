Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EC7267F3E
	for <lists+linux-iio@lfdr.de>; Sun, 13 Sep 2020 12:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgIMKeF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Sep 2020 06:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgIMKeC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 06:34:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2463D20732;
        Sun, 13 Sep 2020 10:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599993242;
        bh=Y7qgnRrAIIMV4sXvwFbD9toBzdPDonepMn0U3tRLAZ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ptbgnuy+QDTOZPKvFkZyQvJJdQ2tE0idvh3Sv7NTR28VeRSh8nAgthMedMzJg1VW0
         AWHQPef0j+KpBh7vuuh/0+x8owK4WqJzI03CecIBjY87Rti5hkJFdI0RuQi9/IOxB+
         3Uid+8sc4Kys7V/Ac1udpxBflzAeFbwHaGNG2Hv0=
Date:   Sun, 13 Sep 2020 11:33:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
Cc:     linux-iio@vger.kernel.org, songqiang1304521@gmail.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH 2/2] iio: proximity: vl53l0x: Add IRQ support
Message-ID: <20200913113357.47e0c0a1@archlinux>
In-Reply-To: <20200910084817.209131-2-drobyshevskyi@gmail.com>
References: <20200910084817.209131-1-drobyshevskyi@gmail.com>
        <20200910084817.209131-2-drobyshevskyi@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Sep 2020 11:48:17 +0300
Ivan Drobyshevskyi <drobyshevskyi@gmail.com> wrote:

> VL53L0X can be configured to use interrupt pin (GPIO1)
> to notify host about readiness of new measurement.
> 
> If interrupt pin is not specified in DT, driver still uses polling.

If interrupt pin is not specified, driver still uses polling.
(see below for why I suggest that change!)

Otherwise, a few minor things inline to tidy up.

Thanks,

Jonathan


> 
> Signed-off-by: Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
> ---
>  drivers/iio/proximity/vl53l0x-i2c.c | 104 ++++++++++++++++++++++++----
>  1 file changed, 92 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index b48216cc1..b676e3702 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -4,19 +4,21 @@
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
> +#include <linux/of_irq.h>
As below, you shouldn't need this.
>  
>  #include <linux/iio/iio.h>
>  
> @@ -29,14 +31,67 @@
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
> -	struct i2c_client *client;

Given existing style is perfectly readable, I would follow it and not
add the 'pretty alignment' change you have here to the existing element
or the new ones.  It often goes wrong and generates very noisy patches
anyway!

> +	struct i2c_client	*client;
> +	struct completion	completion;
> +	int			irq;
>  };
>  
> +static irqreturn_t vl53l0x_handle_irq(int irq, void *dev_id)

dev_id is an odd name for that parameter.  In what way is it
an identification?  Stick to private or similar to avoid
implications you don't intend.

> +{
> +	struct iio_dev *indio_dev = dev_id;
> +	struct vl53l0x_data *data = iio_priv(indio_dev);
> +
> +	complete(&data->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int vl53l0x_configure_irq(struct device *dev, struct iio_dev *indio_dev)
> +{
> +	struct vl53l0x_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = devm_request_irq(dev, data->irq, vl53l0x_handle_irq,
> +			IRQF_TRIGGER_FALLING, indio_dev->name, indio_dev);
> +	if (ret) {
> +		dev_err(dev, "devm_request_irq error: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +			VL_REG_SYSTEM_INTERRUPT_CONFIG_GPIO,
> +			VL_REG_SYSTEM_INTERRUPT_GPIO_NEW_SAMPLE_READY);
> +	if (ret)
> +		dev_err(dev, "failed to configure IRQ: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void vl53l0x_clear_irq(struct vl53l0x_data *data)
> +{
> +	u8 status;
> +
> +	i2c_smbus_write_byte_data(data->client,
> +					VL_REG_SYSTEM_INTERRUPT_CLEAR, 1);

Even though we can't report the error via return value, it is useful to
check it and print an error if we get one.

> +	i2c_smbus_write_byte_data(data->client,
> +					VL_REG_SYSTEM_INTERRUPT_CLEAR, 0);
> +
> +	status = i2c_smbus_read_byte_data(data->client,
> +						VL_REG_RESULT_INT_STATUS);
> +	if (status & 0x07)

If we get an error (which IIRC is signified by < 0) then this will be
doing something very strange.  As such, we should check that first before
using status.

> +		dev_err(&data->client->dev, "failed to clear irq\n");
> +}
> +
>  static int vl53l0x_read_proximity(struct vl53l0x_data *data,
>  				  const struct iio_chan_spec *chan,
>  				  int *val)
> @@ -50,19 +105,31 @@ static int vl53l0x_read_proximity(struct vl53l0x_data *data,
>  	if (ret < 0)
>  		return ret;
>  
> -	do {
> -		ret = i2c_smbus_read_byte_data(client,
> -					       VL_REG_RESULT_RANGE_STATUS);
> +	if (data->irq) {
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
> +
> +			if (ret & VL_REG_RESULT_RANGE_STATUS_COMPLETE)
> +				break;
>  
> -		usleep_range(1000, 5000);
> -	} while (--tries);
> -	if (!tries)
> -		return -ETIMEDOUT;
> +			usleep_range(1000, 5000);
> +		} while (--tries);
> +		if (!tries)
> +			return -ETIMEDOUT;
> +	}
>  
>  	ret = i2c_smbus_read_i2c_block_data(client, VL_REG_RESULT_RANGE_STATUS,
>  					    12, buffer);
> @@ -120,6 +187,7 @@ static int vl53l0x_probe(struct i2c_client *client)
>  {
>  	struct vl53l0x_data *data;
>  	struct iio_dev *indio_dev;
> +	struct device *dev = &client->dev;

That's a valid change to make, but if you want to do this it should be
as a precursor patch tidying up all the places client->dev is used
in the probe function.

>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -141,6 +209,18 @@ static int vl53l0x_probe(struct i2c_client *client)
>  	indio_dev->num_channels = ARRAY_SIZE(vl53l0x_channels);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	data->irq = irq_of_parse_and_map(dev->of_node, 0);

I would rather we didn't introduce any of specific code into this driver even
if that is the mostly likely route by which it will be instantiated.

Currently the driver can be instantiated from ACPI with PRP0001 based bindings
adding this breaks that (I think).

As it's an i2c device, the i2c core should already have set
client->irq to the appropriate value so use that.

> +	/* usage of interrupt is optional */
> +	if (data->irq) {
> +		int ret;
> +
> +		init_completion(&data->completion);
> +
> +		ret = vl53l0x_configure_irq(dev, indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  

