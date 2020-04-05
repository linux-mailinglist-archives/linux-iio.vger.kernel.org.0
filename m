Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC5C19EA79
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 12:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgDEKpC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 06:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgDEKpC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 06:45:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61E0B206B8;
        Sun,  5 Apr 2020 10:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586083500;
        bh=2YiSfHRCj6n+m505S4fBDULS8D3pgrS1XZhepy9Wors=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wRX2G33GAO9ElNAfhHfOHohTPP6hiIq/uvw6Ac04aoLgssqg+PUzOm5YYEI49ty5z
         g7xpU+IuAiMlTRJBRdFE2M/8MKwODXZcW1pWbKU2zlIGwY4GNZSbUdr5m8ohZLoe91
         aaZdIcFF6BEpCNLV8mJE/MuZ7TWoOMRQfnXKFCmg=
Date:   Sun, 5 Apr 2020 11:44:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH 2/3] iio: make use of iio_device_attach_kfifo_buffer()
 where straightforward
Message-ID: <20200405114456.78e52d31@archlinux>
In-Reply-To: <20200401125936.6398-2-alexandru.ardelean@analog.com>
References: <20200401125936.6398-1-alexandru.ardelean@analog.com>
        <20200401125936.6398-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 1 Apr 2020 15:59:35 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> All drivers that already call devm_iio_kfifo_allocate() &
> iio_device_attach_buffer() are simple to convert to
> iio_device_attach_kfifo_buffer() in a single go/patch/.
> 
> This change does that.
> 
> For drivers max30100 & max30102 this helper is called after indio_dev has
> been populated. This doesn't make any difference [at this point in time].
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Comments inline refer back to the question of whether this results in
any order changes that might matter.  Unfortunately it does. I think
we need to allow the new function to take the struct device *
that the driver author wants it to us and to have the naming make it
clear it's a managed function.

The alternative is to go tidy up the allocations so all of the managed
calls scopes are correct.  I.e. any that are associated with the iio_dev
(or iio_priv obviously) use the indio_dev->dev including irq requests
etc.  That might be a good exercise to do but it's not a small one
and the benefits aren't obvious.  We'd move from a simple linear unwind
to a nested one.

devm_iio_device_alloc
devm_iio_*_alloc
devm_request_threaded_irq etc
devm_kzalloc
devm_iio_device_register

devm_iio_device_alloc
	devm_iio*alloc
	devm_request_threaded_irq
	devm_kzalloc
	devm_iio_device_register

So the release of the parent in the second cause the unwind of the
device setup in devm_iio_device_alloc and take out all of the items below.

If we'd structure this right in the first place the second option might be
more elegant but we didn't so retrofitting it now will be messy.

Jonathan

> ---
>  drivers/iio/accel/sca3000.c                    | 18 ++----------------
>  drivers/iio/accel/ssp_accel_sensor.c           | 13 ++++---------
>  drivers/iio/adc/ina2xx-adc.c                   | 13 +++++--------
>  drivers/iio/gyro/ssp_gyro_sensor.c             | 13 ++++---------
>  drivers/iio/health/max30100.c                  | 15 ++++++---------
>  drivers/iio/health/max30102.c                  | 15 ++++++---------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 17 +++++++----------
>  drivers/iio/light/acpi-als.c                   | 11 +++++------
>  drivers/iio/light/apds9960.c                   | 15 ++++++---------
>  9 files changed, 45 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 66d768d971e1..a0db76082ba6 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -1272,20 +1272,6 @@ static int sca3000_write_event_config(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -static int sca3000_configure_ring(struct iio_dev *indio_dev)
> -{
> -	struct iio_buffer *buffer;
> -
> -	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
> -	if (!buffer)
> -		return -ENOMEM;
> -
> -	iio_device_attach_buffer(indio_dev, buffer);
> -	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
> -
> -	return 0;
> -}
> -
>  static inline
>  int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
>  {
> @@ -1480,7 +1466,8 @@ static int sca3000_probe(struct spi_device *spi)
>  	}
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = sca3000_configure_ring(indio_dev);
> +	ret = iio_device_attach_kfifo_buffer(indio_dev, INDIO_BUFFER_SOFTWARE,
> +					     &sca3000_ring_setup_ops);

This one is fine (for a moment I thought we had a bug in the current code)
as this call is the next thing that needs unwinding after the devm_iio_device_alloc
anyway.  It would however have been more consistent if original code had
used the parent dev.

>  	if (ret)
>  		return ret;
>  
> @@ -1494,7 +1481,6 @@ static int sca3000_probe(struct spi_device *spi)
>  		if (ret)
>  			return ret;
>  	}
> -	indio_dev->setup_ops = &sca3000_ring_setup_ops;
>  	ret = sca3000_clean_setup(st);
>  	if (ret)
>  		goto error_free_irq;
> diff --git a/drivers/iio/accel/ssp_accel_sensor.c b/drivers/iio/accel/ssp_accel_sensor.c
> index c32647abce20..1d9971db949d 100644
> --- a/drivers/iio/accel/ssp_accel_sensor.c
> +++ b/drivers/iio/accel/ssp_accel_sensor.c
> @@ -96,7 +96,6 @@ static int ssp_accel_probe(struct platform_device *pdev)
>  	int ret;
>  	struct iio_dev *indio_dev;
>  	struct ssp_sensor_data *spd;
> -	struct iio_buffer *buffer;
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*spd));
>  	if (!indio_dev)
> @@ -111,18 +110,14 @@ static int ssp_accel_probe(struct platform_device *pdev)
>  	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->dev.of_node = pdev->dev.of_node;
>  	indio_dev->info = &ssp_accel_iio_info;
> -	indio_dev->modes = INDIO_BUFFER_SOFTWARE;
>  	indio_dev->channels = ssp_acc_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ssp_acc_channels);
>  	indio_dev->available_scan_masks = ssp_accel_scan_mask;
>  
> -	buffer = devm_iio_kfifo_allocate(&pdev->dev);
> -	if (!buffer)
> -		return -ENOMEM;
> -
> -	iio_device_attach_buffer(indio_dev, buffer);
> -
> -	indio_dev->setup_ops = &ssp_accel_buffer_ops;
> +	ret = iio_device_attach_kfifo_buffer(indio_dev, INDIO_BUFFER_SOFTWARE,
> +					     &ssp_accel_buffer_ops);
> +	if (ret)
> +		return ret;
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index bdd7cba6f6b0..2070809e1acc 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -950,7 +950,6 @@ static int ina2xx_probe(struct i2c_client *client,
>  {
>  	struct ina2xx_chip_info *chip;
>  	struct iio_dev *indio_dev;
> -	struct iio_buffer *buffer;
>  	unsigned int val;
>  	enum ina2xx_ids type;
>  	int ret;
> @@ -1014,7 +1013,7 @@ static int ina2xx_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> -	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->dev.of_node = client->dev.of_node;
>  	if (id->driver_data == ina226) {
> @@ -1027,13 +1026,11 @@ static int ina2xx_probe(struct i2c_client *client,
>  		indio_dev->info = &ina219_info;
>  	}
>  	indio_dev->name = id->name;
> -	indio_dev->setup_ops = &ina2xx_setup_ops;
>  
> -	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
> -	if (!buffer)
> -		return -ENOMEM;
> -
> -	iio_device_attach_buffer(indio_dev, buffer);
> +	ret = iio_device_attach_kfifo_buffer(indio_dev, INDIO_BUFFER_SOFTWARE,
> +					     &ina2xx_setup_ops);
> +	if (ret)
> +		return ret;

This changes the unwind order.  Not good from an obviously correct point of
view.

>  
>  	return iio_device_register(indio_dev);
>  }
> diff --git a/drivers/iio/gyro/ssp_gyro_sensor.c b/drivers/iio/gyro/ssp_gyro_sensor.c
> index 4e4ee4167544..c12d3db5a951 100644
> --- a/drivers/iio/gyro/ssp_gyro_sensor.c
> +++ b/drivers/iio/gyro/ssp_gyro_sensor.c
> @@ -96,7 +96,6 @@ static int ssp_gyro_probe(struct platform_device *pdev)
>  	int ret;
>  	struct iio_dev *indio_dev;
>  	struct ssp_sensor_data *spd;
> -	struct iio_buffer *buffer;
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*spd));
>  	if (!indio_dev)
> @@ -110,18 +109,14 @@ static int ssp_gyro_probe(struct platform_device *pdev)
>  	indio_dev->name = ssp_gyro_name;
>  	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->info = &ssp_gyro_iio_info;
> -	indio_dev->modes = INDIO_BUFFER_SOFTWARE;
>  	indio_dev->channels = ssp_gyro_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ssp_gyro_channels);
>  	indio_dev->available_scan_masks = ssp_gyro_scan_mask;
>  
> -	buffer = devm_iio_kfifo_allocate(&pdev->dev);
> -	if (!buffer)
> -		return -ENOMEM;
> -
> -	iio_device_attach_buffer(indio_dev, buffer);
> -
> -	indio_dev->setup_ops = &ssp_gyro_buffer_ops;
> +	ret = iio_device_attach_kfifo_buffer(indio_dev, INDIO_BUFFER_SOFTWARE,
> +					     &ssp_gyro_buffer_ops);
> +	if (ret)
> +		return ret;
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
> index 546fc37ad75d..f4e9866f4c3d 100644
> --- a/drivers/iio/health/max30100.c
> +++ b/drivers/iio/health/max30100.c
> @@ -418,7 +418,6 @@ static int max30100_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
>  	struct max30100_data *data;
> -	struct iio_buffer *buffer;
>  	struct iio_dev *indio_dev;
>  	int ret;
>  
> @@ -426,21 +425,19 @@ static int max30100_probe(struct i2c_client *client,
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	buffer = devm_iio_kfifo_allocate(&client->dev);
> -	if (!buffer)
> -		return -ENOMEM;
> -
> -	iio_device_attach_buffer(indio_dev, buffer);
> -
>  	indio_dev->name = MAX30100_DRV_NAME;
>  	indio_dev->channels = max30100_channels;
>  	indio_dev->info = &max30100_info;
>  	indio_dev->num_channels = ARRAY_SIZE(max30100_channels);
>  	indio_dev->available_scan_masks = max30100_scan_masks;
> -	indio_dev->modes = (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
> -	indio_dev->setup_ops = &max30100_buffer_setup_ops;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->dev.parent = &client->dev;
>  
> +	ret = iio_device_attach_kfifo_buffer(indio_dev, INDIO_BUFFER_SOFTWARE,
> +					     &max30100_buffer_setup_ops);
> +	if (ret)
> +		return ret;
> +
>  	data = iio_priv(indio_dev);
>  	data->indio_dev = indio_dev;
>  	data->client = client;
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> index 74fc260b957e..e15126d23dfb 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -507,7 +507,6 @@ static int max30102_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
>  	struct max30102_data *data;
> -	struct iio_buffer *buffer;
>  	struct iio_dev *indio_dev;
>  	int ret;
>  	unsigned int reg;
> @@ -516,16 +515,9 @@ static int max30102_probe(struct i2c_client *client,
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	buffer = devm_iio_kfifo_allocate(&client->dev);
> -	if (!buffer)
> -		return -ENOMEM;
> -
> -	iio_device_attach_buffer(indio_dev, buffer);
> -
>  	indio_dev->name = MAX30102_DRV_NAME;
>  	indio_dev->info = &max30102_info;
> -	indio_dev->modes = (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
> -	indio_dev->setup_ops = &max30102_buffer_setup_ops;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->dev.parent = &client->dev;
>  
>  	data = iio_priv(indio_dev);
> @@ -551,6 +543,11 @@ static int max30102_probe(struct i2c_client *client,
>  		return -ENODEV;
>  	}
>  
> +	ret = iio_device_attach_kfifo_buffer(indio_dev, INDIO_BUFFER_SOFTWARE,
> +					     &max30102_buffer_setup_ops);
> +	if (ret)
> +		return ret;
> +
>  	data->regmap = devm_regmap_init_i2c(client, &max30102_regmap_config);
>  	if (IS_ERR(data->regmap)) {
>  		dev_err(&client->dev, "regmap initialization failed\n");
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index bb899345f2bb..4ba3d5551570 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c

I'm not going to layout the details, but this one isn't unwinding in the same
order after this change.  There are devm_kzalloc calls between the devm_iio_device_alloc and
the new call.

> @@ -30,8 +30,8 @@
>   * Denis Ciocca <denis.ciocca@st.com>
>   */
>  #include <linux/module.h>
> -#include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/regmap.h>
>  #include <linux/bitfield.h>
> @@ -713,20 +713,17 @@ static const struct iio_buffer_setup_ops st_lsm6dsx_buffer_ops = {
>  
>  int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
>  {
> -	struct iio_buffer *buffer;
> -	int i;
> +	int i, ret;
>  
>  	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>  		if (!hw->iio_devs[i])
>  			continue;
>  
> -		buffer = devm_iio_kfifo_allocate(hw->dev);
> -		if (!buffer)
> -			return -ENOMEM;
> -
> -		iio_device_attach_buffer(hw->iio_devs[i], buffer);
> -		hw->iio_devs[i]->modes |= INDIO_BUFFER_SOFTWARE;
> -		hw->iio_devs[i]->setup_ops = &st_lsm6dsx_buffer_ops;
> +		ret = iio_device_attach_kfifo_buffer(hw->iio_devs[i],
> +						     INDIO_BUFFER_SOFTWARE,
> +						     &st_lsm6dsx_buffer_ops);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	return 0;
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index 1eafd0b24e18..ea99705c3387 100644
> --- a/drivers/iio/light/acpi-als.c
> +++ b/drivers/iio/light/acpi-als.c
> @@ -166,6 +166,7 @@ static int acpi_als_add(struct acpi_device *device)
>  	struct acpi_als *als;
>  	struct iio_dev *indio_dev;
>  	struct iio_buffer *buffer;
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
>  	if (!indio_dev)
> @@ -180,15 +181,13 @@ static int acpi_als_add(struct acpi_device *device)
>  	indio_dev->name = ACPI_ALS_DEVICE_NAME;
>  	indio_dev->dev.parent = &device->dev;
>  	indio_dev->info = &acpi_als_info;
> -	indio_dev->modes = INDIO_BUFFER_SOFTWARE;
>  	indio_dev->channels = acpi_als_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
>  
> -	buffer = devm_iio_kfifo_allocate(&device->dev);
> -	if (!buffer)
> -		return -ENOMEM;
> -
> -	iio_device_attach_buffer(indio_dev, buffer);
> +	ret = iio_device_attach_kfifo_buffer(indio_dev, INDIO_BUFFER_SOFTWARE,
> +					     NULL);
> +	if (ret)
> +		return ret;

This one is fine as next to the devm_iio_device_alloc anyway.

>  
>  	return devm_iio_device_register(&device->dev, indio_dev);
>  }
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index 52f86bc777dd..8acc319445b6 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -987,7 +987,6 @@ static int apds9960_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
>  	struct apds9960_data *data;
> -	struct iio_buffer *buffer;
>  	struct iio_dev *indio_dev;
>  	int ret;
>  
> @@ -995,20 +994,18 @@ static int apds9960_probe(struct i2c_client *client,
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	buffer = devm_iio_kfifo_allocate(&client->dev);
> -	if (!buffer)
> -		return -ENOMEM;
> -
> -	iio_device_attach_buffer(indio_dev, buffer);
> -
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->info = &apds9960_info;
>  	indio_dev->name = APDS9960_DRV_NAME;
>  	indio_dev->channels = apds9960_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(apds9960_channels);
>  	indio_dev->available_scan_masks = apds9960_scan_masks;
> -	indio_dev->modes = (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
> -	indio_dev->setup_ops = &apds9960_buffer_setup_ops;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = iio_device_attach_kfifo_buffer(indio_dev, INDIO_BUFFER_SOFTWARE,
> +					     &apds9960_buffer_setup_ops);
> +	if (ret)
> +		return ret;

In this case we do have a managed call after this, but as there is nothing between
the devm_iio_device_alloc and iio_device_attach_kfifo_buffer I think we are fine.

>  
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);

