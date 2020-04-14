Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B261A8519
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 18:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391770AbgDNQe7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 12:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391776AbgDNQe5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 12:34:57 -0400
Received: from ns.pmeerw.net (ns.pmeerw.net [IPv6:2001:1b60:2:23:1033:103:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45547C061A0C
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2020 09:34:57 -0700 (PDT)
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id 8E15BE0451; Tue, 14 Apr 2020 18:34:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1586882094; bh=xD1PvYswPoHQsRuxaYL/vkzzK+Q6tOx+WR9hMuw+5zc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=F0wZ5SFphLTUqBpsWDHHc8cVEGA9WFYczV6U3qlEVyUrLO2VKooYDyD7UZ/cdjRPX
         TPyxYniJ/ZCUDyyUgpUXuzzXScnRcoBUNb6PUudTlZ93aaja4jYXmvU+Nl+ImYJe4o
         PC4zNzOpUa3S8u1Of3besjE4wQ8Q+i1Rw++RKxeo=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id 78C55E0176;
        Tue, 14 Apr 2020 18:34:54 +0200 (CEST)
Date:   Tue, 14 Apr 2020 18:34:54 +0200 (CEST)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Manivannan Sadhasivam <mani@kernel.org>
cc:     jic23@kernel.org, narcisaanamaria12@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: chemical: Add support for external Reset
 and Wakeup in CCS811
In-Reply-To: <20200414153415.957-3-mani@kernel.org>
Message-ID: <alpine.DEB.2.21.2004141829280.30119@vps.pmeerw.net>
References: <20200414153415.957-1-mani@kernel.org> <20200414153415.957-3-mani@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Apr 2020, mani@kernel.org wrote:

> From: Manivannan Sadhasivam <mani@kernel.org>

comments below
 
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
> ---
>  drivers/iio/chemical/ccs811.c | 88 +++++++++++++++++++++++++++++++----
>  1 file changed, 80 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> index 2ebdfc35bcda..951358710f64 100644
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

shouldn't the ccs811_set_wakeup(data, false) call be added to all 
potential paths leaving the function?
in particular when there is a timeout or reading the status fails?

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
> +		return PTR_ERR(reset_gpio);
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
> +		return PTR_ERR(data->wakeup_gpio);
> +	}
> +
> +	ccs811_set_wakeup(data, true);
> +
> +	ret = ccs811_reset(client);
> +	if (ret)

ccs811_set_wakeup(data, false) missing here? and in other error paths?

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
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
