Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421333BA9A2
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 19:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhGCRFW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 13:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhGCRFW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jul 2021 13:05:22 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 927386162E;
        Sat,  3 Jul 2021 17:02:46 +0000 (UTC)
Date:   Sat, 3 Jul 2021 18:05:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 1/2] iio: proximity: rfd77402: use i2c_client for
 rfd77402_{init,powerdown}()
Message-ID: <20210703180509.1683ed4d@jic23-huawei>
In-Reply-To: <20210630131636.1563148-1-aardelean@deviqon.com>
References: <20210630131636.1563148-1-aardelean@deviqon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 30 Jun 2021 16:16:35 +0300
Alexandru Ardelean <aardelean@deviqon.com> wrote:

> These 2 functions only do I2C reads/writes and don't require any of the
> private data of the driver.
> 
> They're also used in the PM suspend/resume part of the driver.
> 
> Converting them to take an i2c_client object as parameter simplifies things
> a bit (especially in the suspend/resume) as the driver mostly needs the
> reference for i2c_client, so no need to jump through hoops to get it from
> the private data (as was done in many places).
> 
> The rfd77402_measure() function has also been converted to take an
> i2c_client object, since it also does only I2C ops.
Not sure I'd have bothered with this function, but it doesn't hurt
and is perhaps more consistent than leaving it alone..
> 
> Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
+CC Peter

I'm fine with this change, but it should sit on the list a little longer
(not to mention I'm not taking anything today anyway as mid merge window!)

Jonathan


> ---
>  drivers/iio/proximity/rfd77402.c | 60 ++++++++++++++------------------
>  1 file changed, 27 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
> index 7a0472323f17..f349526421f3 100644
> --- a/drivers/iio/proximity/rfd77402.c
> +++ b/drivers/iio/proximity/rfd77402.c
> @@ -90,18 +90,18 @@ static const struct iio_chan_spec rfd77402_channels[] = {
>  	},
>  };
>  
> -static int rfd77402_set_state(struct rfd77402_data *data, u8 state, u16 check)
> +static int rfd77402_set_state(struct i2c_client *client, u8 state, u16 check)
>  {
>  	int ret;
>  
> -	ret = i2c_smbus_write_byte_data(data->client, RFD77402_CMD_R,
> +	ret = i2c_smbus_write_byte_data(client, RFD77402_CMD_R,
>  					state | RFD77402_CMD_VALID);
>  	if (ret < 0)
>  		return ret;
>  
>  	usleep_range(10000, 20000);
>  
> -	ret = i2c_smbus_read_word_data(data->client, RFD77402_STATUS_R);
> +	ret = i2c_smbus_read_word_data(client, RFD77402_STATUS_R);
>  	if (ret < 0)
>  		return ret;
>  	if ((ret & RFD77402_STATUS_PM_MASK) != check)
> @@ -110,24 +110,24 @@ static int rfd77402_set_state(struct rfd77402_data *data, u8 state, u16 check)
>  	return 0;
>  }
>  
> -static int rfd77402_measure(struct rfd77402_data *data)
> +static int rfd77402_measure(struct i2c_client *client)
>  {
>  	int ret;
>  	int tries = 10;
>  
> -	ret = rfd77402_set_state(data, RFD77402_CMD_MCPU_ON,
> +	ret = rfd77402_set_state(client, RFD77402_CMD_MCPU_ON,
>  				 RFD77402_STATUS_MCPU_ON);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = i2c_smbus_write_byte_data(data->client, RFD77402_CMD_R,
> +	ret = i2c_smbus_write_byte_data(client, RFD77402_CMD_R,
>  					RFD77402_CMD_SINGLE |
>  					RFD77402_CMD_VALID);
>  	if (ret < 0)
>  		goto err;
>  
>  	while (tries-- > 0) {
> -		ret = i2c_smbus_read_byte_data(data->client, RFD77402_ICSR);
> +		ret = i2c_smbus_read_byte_data(client, RFD77402_ICSR);
>  		if (ret < 0)
>  			goto err;
>  		if (ret & RFD77402_ICSR_RESULT)
> @@ -140,7 +140,7 @@ static int rfd77402_measure(struct rfd77402_data *data)
>  		goto err;
>  	}
>  
> -	ret = i2c_smbus_read_word_data(data->client, RFD77402_RESULT_R);
> +	ret = i2c_smbus_read_word_data(client, RFD77402_RESULT_R);
>  	if (ret < 0)
>  		goto err;
>  
> @@ -153,7 +153,7 @@ static int rfd77402_measure(struct rfd77402_data *data)
>  	return (ret & RFD77402_RESULT_DIST_MASK) >> 2;
>  
>  err:
> -	rfd77402_set_state(data, RFD77402_CMD_MCPU_OFF,
> +	rfd77402_set_state(client, RFD77402_CMD_MCPU_OFF,
>  			   RFD77402_STATUS_MCPU_OFF);
>  	return ret;
>  }
> @@ -168,7 +168,7 @@ static int rfd77402_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		mutex_lock(&data->lock);
> -		ret = rfd77402_measure(data);
> +		ret = rfd77402_measure(data->client);
>  		mutex_unlock(&data->lock);
>  		if (ret < 0)
>  			return ret;
> @@ -188,23 +188,23 @@ static const struct iio_info rfd77402_info = {
>  	.read_raw = rfd77402_read_raw,
>  };
>  
> -static int rfd77402_init(struct rfd77402_data *data)
> +static int rfd77402_init(struct i2c_client *client)
>  {
>  	int ret, i;
>  
> -	ret = rfd77402_set_state(data, RFD77402_CMD_STANDBY,
> +	ret = rfd77402_set_state(client, RFD77402_CMD_STANDBY,
>  				 RFD77402_STATUS_STANDBY);
>  	if (ret < 0)
>  		return ret;
>  
>  	/* configure INT pad as push-pull, active low */
> -	ret = i2c_smbus_write_byte_data(data->client, RFD77402_ICSR,
> +	ret = i2c_smbus_write_byte_data(client, RFD77402_ICSR,
>  					RFD77402_ICSR_INT_MODE);
>  	if (ret < 0)
>  		return ret;
>  
>  	/* I2C configuration */
> -	ret = i2c_smbus_write_word_data(data->client, RFD77402_I2C_INIT_CFG,
> +	ret = i2c_smbus_write_word_data(client, RFD77402_I2C_INIT_CFG,
>  					RFD77402_I2C_ADDR_INCR |
>  					RFD77402_I2C_DATA_INCR |
>  					RFD77402_I2C_HOST_DEBUG	|
> @@ -213,42 +213,42 @@ static int rfd77402_init(struct rfd77402_data *data)
>  		return ret;
>  
>  	/* set initialization */
> -	ret = i2c_smbus_write_word_data(data->client, RFD77402_PMU_CFG, 0x0500);
> +	ret = i2c_smbus_write_word_data(client, RFD77402_PMU_CFG, 0x0500);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = rfd77402_set_state(data, RFD77402_CMD_MCPU_OFF,
> +	ret = rfd77402_set_state(client, RFD77402_CMD_MCPU_OFF,
>  				 RFD77402_STATUS_MCPU_OFF);
>  	if (ret < 0)
>  		return ret;
>  
>  	/* set initialization */
> -	ret = i2c_smbus_write_word_data(data->client, RFD77402_PMU_CFG, 0x0600);
> +	ret = i2c_smbus_write_word_data(client, RFD77402_PMU_CFG, 0x0600);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = rfd77402_set_state(data, RFD77402_CMD_MCPU_ON,
> +	ret = rfd77402_set_state(client, RFD77402_CMD_MCPU_ON,
>  				 RFD77402_STATUS_MCPU_ON);
>  	if (ret < 0)
>  		return ret;
>  
>  	for (i = 0; i < ARRAY_SIZE(rf77402_tof_config); i++) {
> -		ret = i2c_smbus_write_word_data(data->client,
> +		ret = i2c_smbus_write_word_data(client,
>  						rf77402_tof_config[i].reg,
>  						rf77402_tof_config[i].val);
>  		if (ret < 0)
>  			return ret;
>  	}
>  
> -	ret = rfd77402_set_state(data, RFD77402_CMD_STANDBY,
> +	ret = rfd77402_set_state(client, RFD77402_CMD_STANDBY,
>  				 RFD77402_STATUS_STANDBY);
>  
>  	return ret;
>  }
>  
> -static int rfd77402_powerdown(struct rfd77402_data *data)
> +static int rfd77402_powerdown(struct i2c_client *client)
>  {
> -	return rfd77402_set_state(data, RFD77402_CMD_STANDBY,
> +	return rfd77402_set_state(client, RFD77402_CMD_STANDBY,
>  				  RFD77402_STATUS_STANDBY);
>  }
>  
> @@ -280,7 +280,7 @@ static int rfd77402_probe(struct i2c_client *client,
>  	indio_dev->name = RFD77402_DRV_NAME;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = rfd77402_init(data);
> +	ret = rfd77402_init(client);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -291,7 +291,7 @@ static int rfd77402_probe(struct i2c_client *client,
>  	return 0;
>  
>  err_powerdown:
> -	rfd77402_powerdown(data);
> +	rfd77402_powerdown(client);
>  	return ret;
>  }
>  
> @@ -300,7 +300,7 @@ static int rfd77402_remove(struct i2c_client *client)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  
>  	iio_device_unregister(indio_dev);
> -	rfd77402_powerdown(iio_priv(indio_dev));
> +	rfd77402_powerdown(client);
>  
>  	return 0;
>  }
> @@ -308,18 +308,12 @@ static int rfd77402_remove(struct i2c_client *client)
>  #ifdef CONFIG_PM_SLEEP
>  static int rfd77402_suspend(struct device *dev)
>  {
> -	struct rfd77402_data *data = iio_priv(i2c_get_clientdata(
> -				     to_i2c_client(dev)));
> -
> -	return rfd77402_powerdown(data);
> +	return rfd77402_powerdown(to_i2c_client(dev));
>  }
>  
>  static int rfd77402_resume(struct device *dev)
>  {
> -	struct rfd77402_data *data = iio_priv(i2c_get_clientdata(
> -				     to_i2c_client(dev)));
> -
> -	return rfd77402_init(data);
> +	return rfd77402_init(to_i2c_client(dev));
>  }
>  #endif
>  

