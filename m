Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF33C1F07CF
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jun 2020 18:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgFFQFs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Jun 2020 12:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgFFQFs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jun 2020 12:05:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A6D720772;
        Sat,  6 Jun 2020 16:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591459546;
        bh=+jlhZLp3sLk8FgbNUlOCxtJtsDS/N8rlUVI+uYKDP94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ecFNiClf31r0tkFhupXgERs+622kgS8FYbvmq+if8kNT92Dgqzo970jnpzXUWRjOU
         GMEyvWKQt543RU+2OijYiVGWiOKrh6rxKM3CqET2qa837UR8GXSNqcWjOie4sx6kuw
         yhXlrRigeKikpCL54mAFygrR8kw+j6/YXroHup3Q=
Date:   Sat, 6 Jun 2020 17:05:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan@kernel.org>, <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 6/6] iio: remove left-over parent assignments
Message-ID: <20200606170542.41c9323c@archlinux>
In-Reply-To: <20200603114023.175102-7-alexandru.ardelean@analog.com>
References: <20200603114023.175102-1-alexandru.ardelean@analog.com>
        <20200603114023.175102-7-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 3 Jun 2020 14:40:23 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> These were found by doing some shell magic:
> ------------
> for file in $(git grep -w devm_iio_device_alloc | cut -d: -f1 | sort | uniq) ; do
> 	if grep 'parent =' $file | grep -v trig | grep -vq devm_; then
> 		echo "$file -> $(grep "parent =" $file)"
> 	fi
> done
> -----------
> 
> The output is bearable [after the semantic patch is applied].
> There is a mix of trigger assignments with some iio device parent
> assignments that are removed via this patch.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

I added a bunch more via a grep of simple parent\ = 
and eyeballing it.  Much easier to do after your patches as far
fewer entries.

vcnl3020 (new)
ms5611 (hidden via an extra call)
st_sensors_spi (hidden via an extra call)
st_sensors_i2c (hidden via an extra call)
cros_ec_sensors_core (hidden via an extra call)
> ---
>  drivers/iio/accel/kxcjk-1013.c                    | 1 -
>  drivers/iio/accel/mma8452.c                       | 1 -
>  drivers/iio/accel/mma9553.c                       | 1 -
>  drivers/iio/adc/ad7192.c                          | 1 -
>  drivers/iio/adc/hx711.c                           | 1 -
>  drivers/iio/adc/max1363.c                         | 2 --
>  drivers/iio/adc/mcp3911.c                         | 1 -
>  drivers/iio/adc/qcom-spmi-iadc.c                  | 1 -
>  drivers/iio/amplifiers/ad8366.c                   | 1 -
>  drivers/iio/chemical/vz89x.c                      | 1 -
>  drivers/iio/dac/ad5770r.c                         | 1 -
>  drivers/iio/health/afe4403.c                      | 1 -
>  drivers/iio/health/afe4404.c                      | 1 -
>  drivers/iio/humidity/dht11.c                      | 1 -
>  drivers/iio/humidity/hts221_core.c                | 1 -
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c        | 1 -
>  drivers/iio/light/cm3605.c                        | 1 -
>  drivers/iio/light/ltr501.c                        | 1 -
>  drivers/iio/magnetometer/ak8975.c                 | 1 -
>  drivers/iio/orientation/hid-sensor-rotation.c     | 1 -
>  drivers/iio/potentiostat/lmp91000.c               | 1 -
>  drivers/iio/proximity/ping.c                      | 1 -
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 1 -
>  drivers/iio/proximity/srf04.c                     | 1 -
>  drivers/iio/proximity/srf08.c                     | 1 -
>  drivers/iio/temperature/tsys01.c                  | 1 -
>  drivers/staging/iio/addac/adt7316.c               | 1 -
>  27 files changed, 28 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index c9924a65c32a..6b93521c0e17 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1311,7 +1311,6 @@ static int kxcjk1013_probe(struct i2c_client *client,
>  
>  	mutex_init(&data->mutex);
>  
> -	indio_dev->dev.parent = &client->dev;
>  	indio_dev->channels = kxcjk1013_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(kxcjk1013_channels);
>  	indio_dev->available_scan_masks = kxcjk1013_scan_masks;
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 00e100fc845a..ef3df402fc3c 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1592,7 +1592,6 @@ static int mma8452_probe(struct i2c_client *client,
>  	i2c_set_clientdata(client, indio_dev);
>  	indio_dev->info = &mma8452_info;
>  	indio_dev->name = id->name;
> -	indio_dev->dev.parent = &client->dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = data->chip_info->channels;
>  	indio_dev->num_channels = data->chip_info->num_channels;
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 312070dcf035..c15908faa381 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -1103,7 +1103,6 @@ static int mma9553_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> -	indio_dev->dev.parent = &client->dev;
>  	indio_dev->channels = mma9553_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(mma9553_channels);
>  	indio_dev->name = name;
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 08ba1a8f05eb..a0837d7e9176 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -970,7 +970,6 @@ static int ad7192_probe(struct spi_device *spi)
>  
>  	spi_set_drvdata(spi, indio_dev);
>  	st->chip_info = of_device_get_match_data(&spi->dev);
> -	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->name = st->chip_info->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index c8686558429b..6a173531d355 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -551,7 +551,6 @@ static int hx711_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	indio_dev->name = "hx711";
> -	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->info = &hx711_iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = hx711_chan_spec;
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 9d92017c79b2..cc1ba7bfc8e6 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1652,8 +1652,6 @@ static int max1363_probe(struct i2c_client *client,
>  	if (ret)
>  		goto error_disable_reg;
>  
> -	/* Establish that the iio_dev is a child of the i2c device */
> -	indio_dev->dev.parent = &client->dev;
>  	indio_dev->dev.of_node = client->dev.of_node;
>  	indio_dev->name = id->name;
>  	indio_dev->channels = st->chip_info->channels;
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index dd52f08ec82e..818b92518c66 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -293,7 +293,6 @@ static int mcp3911_probe(struct spi_device *spi)
>  	if (ret)
>  		goto clk_disable;
>  
> -	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->dev.of_node = spi->dev.of_node;
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
> index 46858eddf1c3..1c90ad33a881 100644
> --- a/drivers/iio/adc/qcom-spmi-iadc.c
> +++ b/drivers/iio/adc/qcom-spmi-iadc.c
> @@ -553,7 +553,6 @@ static int iadc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	indio_dev->dev.parent = dev;
>  	indio_dev->dev.of_node = node;
>  	indio_dev->name = pdev->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index 62167b87caea..2595e9cb0b2d 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -274,7 +274,6 @@ static int ad8366_probe(struct spi_device *spi)
>  	}
>  
>  	st->info = &ad8366_infos[st->type];
> -	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->info = &ad8366_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
> index 415b39339d4e..5586eb8e12cd 100644
> --- a/drivers/iio/chemical/vz89x.c
> +++ b/drivers/iio/chemical/vz89x.c
> @@ -382,7 +382,6 @@ static int vz89x_probe(struct i2c_client *client,
>  	data->last_update = jiffies - HZ;
>  	mutex_init(&data->lock);
>  
> -	indio_dev->dev.parent = &client->dev;
>  	indio_dev->info = &vz89x_info;
>  	indio_dev->name = dev_name(&client->dev);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
> index 2d7623b9b2c0..84dcf149261f 100644
> --- a/drivers/iio/dac/ad5770r.c
> +++ b/drivers/iio/dac/ad5770r.c
> @@ -651,7 +651,6 @@ static int ad5770r_probe(struct spi_device *spi)
>  		}
>  	}
>  
> -	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->info = &ad5770r_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
> index e9f87e42ff4f..ed230f12b2f8 100644
> --- a/drivers/iio/health/afe4403.c
> +++ b/drivers/iio/health/afe4403.c
> @@ -509,7 +509,6 @@ static int afe4403_probe(struct spi_device *spi)
>  	}
>  
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->dev.parent = afe->dev;
>  	indio_dev->channels = afe4403_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(afe4403_channels);
>  	indio_dev->name = AFE4403_DRIVER_NAME;
> diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
> index e728bbb21ca8..3a3efae4695a 100644
> --- a/drivers/iio/health/afe4404.c
> +++ b/drivers/iio/health/afe4404.c
> @@ -517,7 +517,6 @@ static int afe4404_probe(struct i2c_client *client,
>  	}
>  
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->dev.parent = afe->dev;
>  	indio_dev->channels = afe4404_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(afe4404_channels);
>  	indio_dev->name = AFE4404_DRIVER_NAME;
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index d05c6fdb758b..9a7819817488 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -321,7 +321,6 @@ static int dht11_probe(struct platform_device *pdev)
>  	init_completion(&dht11->completion);
>  	mutex_init(&dht11->lock);
>  	iio->name = pdev->name;
> -	iio->dev.parent = &pdev->dev;
>  	iio->info = &dht11_iio_info;
>  	iio->modes = INDIO_DIRECT_MODE;
>  	iio->channels = dht11_chan_spec;
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index 7ce1bd1defa0..16657789dc45 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -572,7 +572,6 @@ int hts221_probe(struct device *dev, int irq, const char *name,
>  		return err;
>  
>  	iio_dev->modes = INDIO_DIRECT_MODE;
> -	iio_dev->dev.parent = hw->dev;
>  	iio_dev->available_scan_masks = hts221_scan_masks;
>  	iio_dev->channels = hts221_channels;
>  	iio_dev->num_channels = ARRAY_SIZE(hts221_channels);
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 4d604fe842e5..153f855db8d6 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1530,7 +1530,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  	}
>  
>  	dev_set_drvdata(dev, indio_dev);
> -	indio_dev->dev.parent = dev;
>  	/* name will be NULL when enumerated via ACPI */
>  	if (name)
>  		indio_dev->name = name;
> diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
> index 964ede49f662..4c83953672be 100644
> --- a/drivers/iio/light/cm3605.c
> +++ b/drivers/iio/light/cm3605.c
> @@ -239,7 +239,6 @@ static int cm3605_probe(struct platform_device *pdev)
>  	led_trigger_register_simple("cm3605", &cm3605->led);
>  	led_trigger_event(cm3605->led, LED_FULL);
>  
> -	indio_dev->dev.parent = dev;
>  	indio_dev->info = &cm3605_info;
>  	indio_dev->name = "cm3605";
>  	indio_dev->channels = cm3605_channels;
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 5a3fcb127cd2..4bac0646398d 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -1480,7 +1480,6 @@ static int ltr501_probe(struct i2c_client *client,
>  	if ((partid >> 4) != data->chip_info->partid)
>  		return -ENODEV;
>  
> -	indio_dev->dev.parent = &client->dev;
>  	indio_dev->info = data->chip_info->info;
>  	indio_dev->channels = data->chip_info->channels;
>  	indio_dev->num_channels = data->chip_info->no_channels;
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index a23422aad97d..03d71f796177 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -940,7 +940,6 @@ static int ak8975_probe(struct i2c_client *client,
>  	}
>  
>  	mutex_init(&data->lock);
> -	indio_dev->dev.parent = &client->dev;
>  	indio_dev->channels = ak8975_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
>  	indio_dev->info = &ak8975_info;
> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
> index b99f41240e3e..23bc61a7f018 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -281,7 +281,6 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
>  	}
>  
>  	indio_dev->num_channels = ARRAY_SIZE(dev_rot_channels);
> -	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->info = &dev_rot_info;
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index 2cb11da18e0f..2d601889c8c0 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -321,7 +321,6 @@ static int lmp91000_probe(struct i2c_client *client,
>  	indio_dev->channels = lmp91000_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(lmp91000_channels);
>  	indio_dev->name = LMP91000_DRV_NAME;
> -	indio_dev->dev.parent = &client->dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	i2c_set_clientdata(client, indio_dev);
>  
> diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
> index 2e99eeb27f2e..1283ac1c2e03 100644
> --- a/drivers/iio/proximity/ping.c
> +++ b/drivers/iio/proximity/ping.c
> @@ -309,7 +309,6 @@ static int ping_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	indio_dev->name = "ping";
> -	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->info = &ping_iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = ping_chan_spec;
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 5b369645ef49..a8e716dbd24e 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -270,7 +270,6 @@ static int lidar_probe(struct i2c_client *client,
>  	indio_dev->name = LIDAR_DRV_NAME;
>  	indio_dev->channels = lidar_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(lidar_channels);
> -	indio_dev->dev.parent = &client->dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	i2c_set_clientdata(client, indio_dev);
> diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
> index 568b76e06385..2a3acff431d7 100644
> --- a/drivers/iio/proximity/srf04.c
> +++ b/drivers/iio/proximity/srf04.c
> @@ -317,7 +317,6 @@ static int srf04_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	indio_dev->name = "srf04";
> -	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->info = &srf04_iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = srf04_chan_spec;
> diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> index b23ce446b7be..6677221d5818 100644
> --- a/drivers/iio/proximity/srf08.c
> +++ b/drivers/iio/proximity/srf08.c
> @@ -483,7 +483,6 @@ static int srf08_probe(struct i2c_client *client,
>  	}
>  
>  	indio_dev->name = id->name;
> -	indio_dev->dev.parent = &client->dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = srf08_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(srf08_channels);
> diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
> index d41f050c2fea..2c631a1ca33b 100644
> --- a/drivers/iio/temperature/tsys01.c
> +++ b/drivers/iio/temperature/tsys01.c
> @@ -160,7 +160,6 @@ static int tsys01_probe(struct iio_dev *indio_dev, struct device *dev)
>  
>  	indio_dev->info = &tsys01_info;
>  	indio_dev->name = dev->driver->name;
> -	indio_dev->dev.parent = dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = tsys01_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(tsys01_channels);
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 9cb3d0e42c38..ccbafcaaf27e 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -2171,7 +2171,6 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
>  	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
>  		chip->int_mask |= ADT7516_AIN_INT_MASK;
>  
> -	indio_dev->dev.parent = dev;
>  	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
>  		indio_dev->info = &adt7516_info;
>  	else

