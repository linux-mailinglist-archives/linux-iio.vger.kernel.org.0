Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D346839EBC
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 13:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfFHLvc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 07:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbfFHLrn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 07:47:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D1621734;
        Sat,  8 Jun 2019 11:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994462;
        bh=PazpNXQVQvQoS8T9tmvTQ6FKU6xsjl0d/vMOYpkoXPo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FyiJejHZ4SD/ACId6tTCE8gkGXN+fuYMGqjmZK3e/WO16YDdZ1yZgK247UggPcrlB
         X5YnDGHwoA5NLL7RcJQSbsLsKHbferijnHq142Q0DfLWZMyjLR3h6bETJHGTCe8Dsh
         GV1y/ivjiA9nSTD4fD8w9J6XYPVZfKl2kh/TM1zk=
Date:   Sat, 8 Jun 2019 12:47:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Vitor.Soares@synopsys.com, boris.brezillon@collabora.com
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: get device name from
 st_lsm6dsx_sensor_settings
Message-ID: <20190608124738.6af7e4ee@archlinux>
In-Reply-To: <22ad57099bf50226027e7f5c537207a5b4a6f99b.1559941022.git.lorenzo@kernel.org>
References: <22ad57099bf50226027e7f5c537207a5b4a6f99b.1559941022.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  7 Jun 2019 23:00:20 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Introduce sensor name in st_lsm6dsx_sensor_settings table. This is
> a preliminary patch to add I3C support to st_lsm6dsx since i3c_device_id
> data structure does not contain a name field
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> changes since v1:
> - move sensor name in st_lsm6dsx_sensor_settings  
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  9 ++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 53 +++++++++++++++-----
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  3 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  3 +-
>  4 files changed, 48 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 004a8a1a0027..a736829d25cd 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -198,7 +198,7 @@ struct st_lsm6dsx_ext_dev_settings {
>   * struct st_lsm6dsx_settings - ST IMU sensor settings
>   * @wai: Sensor WhoAmI default value.
>   * @max_fifo_size: Sensor max fifo length in FIFO words.
> - * @id: List of hw id supported by the driver configuration.
> + * @id: List of hw id/device name supported by the driver configuration.
>   * @decimator: List of decimator register info (addr + mask).
>   * @batch: List of FIFO batching register info (addr + mask).
>   * @fifo_ops: Sensor hw FIFO parameters.
> @@ -208,7 +208,10 @@ struct st_lsm6dsx_ext_dev_settings {
>  struct st_lsm6dsx_settings {
>  	u8 wai;
>  	u16 max_fifo_size;
> -	enum st_lsm6dsx_hw_id id[ST_LSM6DSX_MAX_ID];
> +	struct {
> +		enum st_lsm6dsx_hw_id hw_id;
> +		const char name[32];

Given these are only ever set once, you can just use
const char *name;

That lets the compiler do things like merging different
instances.

> +	} id[ST_LSM6DSX_MAX_ID];
>  	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
>  	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
>  	struct st_lsm6dsx_fifo_ops fifo_ops;
> @@ -302,7 +305,7 @@ struct st_lsm6dsx_hw {
>  static const unsigned long st_lsm6dsx_available_scan_masks[] = {0x7, 0x0};
>  extern const struct dev_pm_ops st_lsm6dsx_pm_ops;
>  
> -int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
> +int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  		     struct regmap *regmap);
>  int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
>  				 bool enable);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index cf82c9049945..04233928d23e 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -125,7 +125,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		.wai = 0x69,
>  		.max_fifo_size = 1365,
>  		.id = {
> -			[0] = ST_LSM6DS3_ID,
> +			{
> +				.hw_id = ST_LSM6DS3_ID,
> +				.name = ST_LSM6DS3_DEV_NAME,
> +			},
>  		},
>  		.decimator = {
>  			[ST_LSM6DSX_ID_ACC] = {
> @@ -172,7 +175,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		.wai = 0x69,
>  		.max_fifo_size = 682,
>  		.id = {
> -			[0] = ST_LSM6DS3H_ID,
> +			{
> +				.hw_id = ST_LSM6DS3H_ID,
> +				.name = ST_LSM6DS3H_DEV_NAME,
> +			},
>  		},
>  		.decimator = {
>  			[ST_LSM6DSX_ID_ACC] = {
> @@ -219,9 +225,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		.wai = 0x6a,
>  		.max_fifo_size = 682,
>  		.id = {
> -			[0] = ST_LSM6DSL_ID,
> -			[1] = ST_LSM6DSM_ID,
> -			[2] = ST_ISM330DLC_ID,
> +			{
> +				.hw_id = ST_LSM6DSL_ID,
> +				.name = ST_LSM6DSL_DEV_NAME,
> +			}, {
> +				.hw_id = ST_LSM6DSM_ID,
> +				.name = ST_LSM6DSM_DEV_NAME,
> +			}, {
> +				.hw_id = ST_ISM330DLC_ID,
> +				.name = ST_ISM330DLC_DEV_NAME,
> +			},
>  		},
>  		.decimator = {
>  			[ST_LSM6DSX_ID_ACC] = {
> @@ -268,8 +281,13 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		.wai = 0x6c,
>  		.max_fifo_size = 512,
>  		.id = {
> -			[0] = ST_LSM6DSO_ID,
> -			[1] = ST_LSM6DSOX_ID,
> +			{
> +				.hw_id = ST_LSM6DSO_ID,
> +				.name = ST_LSM6DSO_DEV_NAME,
> +			}, {
> +				.hw_id = ST_LSM6DSOX_ID,
> +				.name = ST_LSM6DSOX_DEV_NAME,
> +			},
>  		},
>  		.batch = {
>  			[ST_LSM6DSX_ID_ACC] = {
> @@ -334,7 +352,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		.wai = 0x6b,
>  		.max_fifo_size = 512,
>  		.id = {
> -			[0] = ST_ASM330LHH_ID,
> +			{
> +				.hw_id = ST_ASM330LHH_ID,
> +				.name = ST_ASM330LHH_DEV_NAME,
> +			},
>  		},
>  		.batch = {
>  			[ST_LSM6DSX_ID_ACC] = {
> @@ -373,7 +394,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		.wai = 0x6b,
>  		.max_fifo_size = 512,
>  		.id = {
> -			[0] = ST_LSM6DSR_ID,
> +			{
> +				.hw_id = ST_LSM6DSR_ID,
> +				.name = ST_LSM6DSR_DEV_NAME,
> +			},
>  		},
>  		.batch = {
>  			[ST_LSM6DSX_ID_ACC] = {
> @@ -471,13 +495,14 @@ int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, bool enable)
>  	return err;
>  }
>  
> -static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id)
> +static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
> +				   const char **name)
>  {
>  	int err, i, j, data;
>  
>  	for (i = 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
>  		for (j = 0; j < ST_LSM6DSX_MAX_ID; j++) {
> -			if (id == st_lsm6dsx_sensor_settings[i].id[j])
> +			if (id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
>  				break;
>  		}
>  		if (j < ST_LSM6DSX_MAX_ID)
> @@ -500,6 +525,7 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id)
>  		return -ENODEV;
>  	}
>  
> +	*name = st_lsm6dsx_sensor_settings[i].id[j].name;
>  	hw->settings = &st_lsm6dsx_sensor_settings[i];
>  
>  	return 0;
> @@ -1041,11 +1067,12 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>  	return iio_dev;
>  }
>  
> -int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
> +int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  		     struct regmap *regmap)
>  {
>  	const struct st_lsm6dsx_shub_settings *hub_settings;
>  	struct st_lsm6dsx_hw *hw;
> +	const char *name = NULL;
>  	int i, err;
>  
>  	hw = devm_kzalloc(dev, sizeof(*hw), GFP_KERNEL);
> @@ -1066,7 +1093,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
>  	hw->irq = irq;
>  	hw->regmap = regmap;
>  
> -	err = st_lsm6dsx_check_whoami(hw, hw_id);
> +	err = st_lsm6dsx_check_whoami(hw, hw_id, &name);
>  	if (err < 0)
>  		return err;
>  
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> index f54370196098..47581a4e456e 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -36,8 +36,7 @@ static int st_lsm6dsx_i2c_probe(struct i2c_client *client,
>  		return PTR_ERR(regmap);
>  	}
>  
> -	return st_lsm6dsx_probe(&client->dev, client->irq,
> -				hw_id, id->name, regmap);
> +	return st_lsm6dsx_probe(&client->dev, client->irq, hw_id, regmap);
>  }
>  
>  static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> index 4a4abb2935da..facf66978a4b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -36,8 +36,7 @@ static int st_lsm6dsx_spi_probe(struct spi_device *spi)
>  		return PTR_ERR(regmap);
>  	}
>  
> -	return st_lsm6dsx_probe(&spi->dev, spi->irq,
> -				hw_id, id->name, regmap);
> +	return st_lsm6dsx_probe(&spi->dev, spi->irq, hw_id, regmap);
>  }
>  
>  static const struct of_device_id st_lsm6dsx_spi_of_match[] = {

