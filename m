Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756D61A6AB4
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 18:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbgDMQ6S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 12:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732238AbgDMQ6R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Apr 2020 12:58:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D8820739;
        Mon, 13 Apr 2020 16:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586797096;
        bh=YqZ5wVla+WWpQKBP5kfizBtWI8bMEeFycRYBZ3wpUAQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=taVVjTIo9Hfx/n2w7Tsv5p5Zex3H/KQ+VzQtd1OqD3P1znUncwu8OgPmgAhtKrwoh
         E5rGC2VMeVNpJWiYD09KCyqJnVwnaZvMrv5Ro5fXUt0KZpqZHB+1pMLFBmdYswKT+Q
         U2QRY6uCWo5b9lRbM0mIQ9ciBYXJ4hGATNnhUqi0=
Date:   Mon, 13 Apr 2020 17:58:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     mani@kernel.org
Cc:     robh+dt@kernel.org, narcisaanamaria12@gmail.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: chemical: Add support for external Reset and
 Wakeup in CCS811
Message-ID: <20200413175812.6392c887@archlinux>
In-Reply-To: <20200412183658.6755-3-mani@kernel.org>
References: <20200412183658.6755-1-mani@kernel.org>
        <20200412183658.6755-3-mani@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Apr 2020 00:06:57 +0530
mani@kernel.org wrote:

> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> CCS811 VOC sensor exposes nRESET and nWAKE pins which can be connected
> to GPIO pins of the host controller. These pins can be used to externally
> release the device from reset and also to wake it up before any I2C
> transaction. The initial driver support assumed that the nRESET pin is not
> connected and the nWAKE pin is tied to ground.
> 
> This commit improves it by adding support for controlling those two pins
> externally using a host controller. For the case of reset, if the hardware
> reset is not available, the mechanism to do software reset is also added.
> 
> As a side effect of doing this, the IIO device allocation needs to be
> slightly moved to top of probe to make use of priv data early.
> 
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>

One trivial thing inline to allow things to work if we have deferred probing
and the gpio provider isn't ready yet.  Currently you eat the error code
rather than passing it on.

Otherwise looks good to me.

Thanks,

Jonathan
> ---
>  drivers/iio/chemical/ccs811.c | 88 +++++++++++++++++++++++++++++++----
>  1 file changed, 80 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> index 2ebdfc35bcda..6cd92c49c348 100644
> --- a/drivers/iio/chemical/ccs811.c
> +++ b/drivers/iio/chemical/ccs811.c
> @@ -16,6 +16,7 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -36,6 +37,7 @@
>  #define CCS811_ERR		0xE0
>  /* Used to transition from boot to application mode */
>  #define CCS811_APP_START	0xF4
> +#define CCS811_SW_RESET		0xFF
>  
>  /* Status register flags */
>  #define CCS811_STATUS_ERROR		BIT(0)
> @@ -74,6 +76,7 @@ struct ccs811_data {
>  	struct mutex lock; /* Protect readings */
>  	struct ccs811_reading buffer;
>  	struct iio_trigger *drdy_trig;
> +	struct gpio_desc *wakeup_gpio;
>  	bool drdy_trig_on;
>  };
>  
> @@ -166,10 +169,25 @@ static int ccs811_setup(struct i2c_client *client)
>  					 CCS811_MODE_IAQ_1SEC);
>  }
>  
> +static void ccs811_set_wakeup(struct ccs811_data *data, bool enable)
> +{
> +	if (!data->wakeup_gpio)
> +		return;
> +
> +	gpiod_set_value(data->wakeup_gpio, enable);
> +
> +	if (enable)
> +		usleep_range(50, 60);
> +	else
> +		usleep_range(20, 30);
> +}
> +
>  static int ccs811_get_measurement(struct ccs811_data *data)
>  {
>  	int ret, tries = 11;
>  
> +	ccs811_set_wakeup(data, true);
> +
>  	/* Maximum waiting time: 1s, as measurements are made every second */
>  	while (tries-- > 0) {
>  		ret = i2c_smbus_read_byte_data(data->client, CCS811_STATUS);
> @@ -183,9 +201,12 @@ static int ccs811_get_measurement(struct ccs811_data *data)
>  	if (!(ret & CCS811_STATUS_DATA_READY))
>  		return -EIO;
>  
> -	return i2c_smbus_read_i2c_block_data(data->client,
> +	ret = i2c_smbus_read_i2c_block_data(data->client,
>  					    CCS811_ALG_RESULT_DATA, 8,
>  					    (char *)&data->buffer);
> +	ccs811_set_wakeup(data, false);
> +
> +	return ret;
>  }
>  
>  static int ccs811_read_raw(struct iio_dev *indio_dev,
> @@ -336,6 +357,42 @@ static irqreturn_t ccs811_data_rdy_trigger_poll(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> +static int ccs811_reset(struct i2c_client *client)
> +{
> +	struct gpio_desc *reset_gpio;
> +	int ret;
> +
> +	reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
> +					     GPIOD_OUT_LOW);
> +	if (IS_ERR(reset_gpio)) {
> +		dev_err(&client->dev, "Failed to acquire reset gpio\n");
> +		return -EINVAL;

return PTR_ERR as it may well be a deferred signal to say try again later
after the gpio provide device has been initialized.

> +	}
> +
> +	/* Try to reset using nRESET pin if available else do SW reset */
> +	if (reset_gpio) {
> +		gpiod_set_value(reset_gpio, 1);
> +		usleep_range(20, 30);
> +		gpiod_set_value(reset_gpio, 0);
> +	} else {
> +		static const u8 reset_seq[] = {
> +			0xFF, 0x11, 0xE5, 0x72, 0x8A,
> +		};
> +
> +		ret = i2c_smbus_write_i2c_block_data(client, CCS811_SW_RESET,
> +					     sizeof(reset_seq), reset_seq);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "Failed to reset sensor\n");
> +			return ret;
> +		}
> +	}
> +
> +	/* tSTART delay required after reset */
> +	usleep_range(1000, 2000);
> +
> +	return 0;
> +}
> +
>  static int ccs811_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> @@ -348,6 +405,27 @@ static int ccs811_probe(struct i2c_client *client,
>  				     | I2C_FUNC_SMBUS_READ_I2C_BLOCK))
>  		return -EOPNOTSUPP;
>  
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	data->wakeup_gpio = devm_gpiod_get_optional(&client->dev, "wakeup",
> +						    GPIOD_OUT_HIGH);
> +	if (IS_ERR(data->wakeup_gpio)) {
> +		dev_err(&client->dev, "Failed to acquire wakeup gpio\n");
> +		return -EINVAL;
> +	}
> +
> +	ccs811_set_wakeup(data, true);
> +
> +	ret = ccs811_reset(client);
> +	if (ret)
> +		return ret;
> +
>  	/* Check hardware id (should be 0x81 for this family of devices) */
>  	ret = i2c_smbus_read_byte_data(client, CCS811_HW_ID);
>  	if (ret < 0)
> @@ -367,17 +445,11 @@ static int ccs811_probe(struct i2c_client *client,
>  		return -ENODEV;
>  	}
>  
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> -	if (!indio_dev)
> -		return -ENOMEM;
> -
>  	ret = ccs811_setup(client);
>  	if (ret < 0)
>  		return ret;
>  
> -	data = iio_priv(indio_dev);
> -	i2c_set_clientdata(client, indio_dev);
> -	data->client = client;
> +	ccs811_set_wakeup(data, false);
>  
>  	mutex_init(&data->lock);
>  

