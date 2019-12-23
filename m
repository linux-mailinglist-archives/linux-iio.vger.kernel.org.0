Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 162FD129958
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 18:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLWR20 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 12:28:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfLWR20 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 12:28:26 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42F09206CB;
        Mon, 23 Dec 2019 17:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577122105;
        bh=IldxQV/npKqtDIbhumgb8ZHtmddjBkkR/a6esCwXkC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dqo5Zg9m1hGKakrI4wV4dmNncHAXFbEJvhUME8qzGgLl0c7K0ZIjaVB73GJ5g9geo
         HRCnVOyjks8sB5T3ocfuR0Oh1WSB8MZLUmdk88Rr3QVnLYyFgz7fnCA13lzOXL7FI3
         BJPh/Jm1njFIBMHXZzqJP39E/GYtsbxducCIFwKQ=
Date:   Mon, 23 Dec 2019 17:28:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: accel: bma180: BMA254 support
Message-ID: <20191223172821.17f058ab@archlinux>
In-Reply-To: <20191211213819.14024-4-linus.walleij@linaro.org>
References: <20191211213819.14024-1-linus.walleij@linaro.org>
        <20191211213819.14024-4-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Dec 2019 22:38:19 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> This adds support for the BMA254 variant of this
> accelerometer. The only difference for the simple IIO
> driver is that values are 12 bit and the temperature
> offset differs by 1 degree.
> 
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I'm never keen on wildcards, and there is a bma253.

So please go back to using explicit part numbers.
If you feel a need to indicate a particular structure
applies to multiple devices, then use a comment to do so.

I thought about doing this myself, but you might disagree :)

Jonathan

> ---
>  .../devicetree/bindings/iio/accel/bma180.txt  |   7 +-
>  drivers/iio/accel/Kconfig                     |   4 +-
>  drivers/iio/accel/bma180.c                    | 108 +++++++++++++++---
>  3 files changed, 100 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/bma180.txt b/Documentation/devicetree/bindings/iio/accel/bma180.txt
> index 3b25b4c4d446..f53237270b32 100644
> --- a/Documentation/devicetree/bindings/iio/accel/bma180.txt
> +++ b/Documentation/devicetree/bindings/iio/accel/bma180.txt
> @@ -1,11 +1,14 @@
> -* Bosch BMA180 / BMA250 triaxial acceleration sensor
> +* Bosch BMA180 / BMA25x triaxial acceleration sensor
>  
>  http://omapworld.com/BMA180_111_1002839.pdf
>  http://ae-bst.resource.bosch.com/media/products/dokumente/bma250/bst-bma250-ds002-05.pdf
>  
>  Required properties:
>  
> -  - compatible : should be "bosch,bma180" or "bosch,bma250"
> +  - compatible : should be one of:
> +    "bosch,bma180"
> +    "bosch,bma250"
> +    "bosch,bma254"
>    - reg : the I2C address of the sensor
>  
>  Optional properties:
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index d4ef35aeb579..2f10fd7954fc 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -89,13 +89,13 @@ config ADXL372_I2C
>  	  module will be called adxl372_i2c.
>  
>  config BMA180
> -	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
> +	tristate "Bosch BMA180/BMA25x 3-Axis Accelerometer Driver"
>  	depends on I2C
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say Y here if you want to build a driver for the Bosch BMA180 or
> -	  BMA250 triaxial acceleration sensor.
> +	  BMA25x triaxial acceleration sensor.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bma180.
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index f583f10ccbb9..952b2918525b 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -9,6 +9,7 @@
>   * SPI is not supported by driver
>   * BMA180: 7-bit I2C slave address 0x40 or 0x41
>   * BMA250: 7-bit I2C slave address 0x18 or 0x19
> + * BMA254: 7-bit I2C slave address 0x18 or 0x19
>   */
>  
>  #include <linux/module.h>
> @@ -34,17 +35,20 @@
>  enum chip_ids {
>  	BMA180,
>  	BMA250,
> +	BMA254,
>  };
>  
>  struct bma180_data;
>  
>  struct bma180_part_info {
> +	u8 chip_id;
>  	const struct iio_chan_spec *channels;
>  	unsigned int num_channels;
>  	const int *scale_table;
>  	unsigned int num_scales;
>  	const int *bw_table;
>  	unsigned int num_bw;
> +	int center_temp;
>  
>  	u8 int_reset_reg, int_reset_mask;
>  	u8 sleep_reg, sleep_mask;
> @@ -52,6 +56,7 @@ struct bma180_part_info {
>  	u8 scale_reg, scale_mask;
>  	u8 power_reg, power_mask, lowpower_val;
>  	u8 int_enable_reg, int_enable_mask;
> +	u8 int_map_reg, int_enable_dataready_int1_mask;
>  	u8 softreset_reg;
>  
>  	int (*chip_config)(struct bma180_data *data);
> @@ -90,6 +95,8 @@ struct bma180_part_info {
>  #define BMA180_RESET_VAL	0xb6
>  
>  #define BMA180_ID_REG_VAL	0x03
> +#define BMA250_ID_REG_VAL	0x03
> +#define BMA254_ID_REG_VAL	0xfa /* 250 decimal */
>  
>  /* Chip power modes */
>  #define BMA180_LOW_POWER	0x03
> @@ -110,6 +117,23 @@ struct bma180_part_info {
>  #define BMA250_INT1_DATA_MASK	BIT(0)
>  #define BMA250_INT_RESET_MASK	BIT(7) /* Reset pending interrupts */
>  
> +#define BMA254_RANGE_REG	0x0f
> +#define BMA254_BW_REG		0x10
> +#define BMA254_POWER_REG	0x11
> +#define BMA254_RESET_REG	0x14
> +#define BMA254_INT_ENABLE_REG	0x17
> +#define BMA254_INT_MAP_REG	0x1a
> +#define BMA254_INT_RESET_REG	0x21
> +
> +#define BMA254_RANGE_MASK	GENMASK(3, 0) /* Range of accel values */
> +#define BMA254_BW_MASK		GENMASK(4, 0) /* Accel bandwidth */
> +#define BMA254_SUSPEND_MASK	BIT(7) /* chip will sleep */
> +#define BMA254_LOWPOWER_MASK	BIT(6)
> +#define BMA254_DATA_INTEN_MASK	BIT(4)
> +#define BMA254_INT2_DATA_MASK	BIT(7)
> +#define BMA254_INT1_DATA_MASK	BIT(0)
> +#define BMA254_INT_RESET_MASK	BIT(7) /* Reset pending interrupts */
> +
>  struct bma180_data {
>  	struct regulator *vdd_supply;
>  	struct regulator *vddio_supply;
> @@ -135,8 +159,8 @@ enum bma180_chan {
>  static int bma180_bw_table[] = { 10, 20, 40, 75, 150, 300 }; /* Hz */
>  static int bma180_scale_table[] = { 1275, 1863, 2452, 3727, 4903, 9709, 19417 };
>  
> -static int bma250_bw_table[] = { 8, 16, 31, 63, 125, 250 }; /* Hz */
> -static int bma250_scale_table[] = { 0, 0, 0, 38344, 0, 76590, 0, 0, 153180, 0,
> +static int bma25x_bw_table[] = { 8, 16, 31, 63, 125, 250 }; /* Hz */
> +static int bma25x_scale_table[] = { 0, 0, 0, 38344, 0, 76590, 0, 0, 153180, 0,
>  	0, 0, 306458 };
>  
>  static int bma180_get_data_reg(struct bma180_data *data, enum bma180_chan chan)
> @@ -310,8 +334,11 @@ static int bma180_chip_init(struct bma180_data *data)
>  
>  	if (ret < 0)
>  		return ret;
> -	if (ret != BMA180_ID_REG_VAL)
> +	if (ret != data->part_info->chip_id) {
> +		dev_err(&data->client->dev, "wrong chip ID %d expected %d\n",
> +			ret, data->part_info->chip_id);
>  		return -ENODEV;
> +	}
>  
>  	ret = bma180_soft_reset(data);
>  	if (ret)
> @@ -358,7 +385,7 @@ static int bma180_chip_config(struct bma180_data *data)
>  	return ret;
>  }
>  
> -static int bma250_chip_config(struct bma180_data *data)
> +static int bma25x_chip_config(struct bma180_data *data)
>  {
>  	int ret = bma180_chip_init(data);
>  
> @@ -370,8 +397,12 @@ static int bma250_chip_config(struct bma180_data *data)
>  	ret = bma180_set_scale(data, 38344); /* 2 G */
>  	if (ret)
>  		goto err;
> -	ret = bma180_set_bits(data, BMA250_INT_MAP_REG,
> -		BMA250_INT1_DATA_MASK, 1);
> +	/*
> +	 * This enables dataready interrupt on the INT1 pin
> +	 * FIXME: support using the INT2 pin
> +	 */
> +	ret = bma180_set_bits(data, data->part_info->int_map_reg,
> +		data->part_info->int_enable_dataready_int1_mask, 1);
>  	if (ret)
>  		goto err;
>  
> @@ -397,7 +428,7 @@ static void bma180_chip_disable(struct bma180_data *data)
>  	dev_err(&data->client->dev, "failed to disable the chip\n");
>  }
>  
> -static void bma250_chip_disable(struct bma180_data *data)
> +static void bma25x_chip_disable(struct bma180_data *data)
>  {
>  	if (bma180_set_new_data_intr_state(data, false))
>  		goto err;
> @@ -500,7 +531,7 @@ static int bma180_read_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  	case IIO_CHAN_INFO_OFFSET:
> -		*val = 48; /* 0 LSB @ 24 degree C */
> +		*val = data->part_info->center_temp;
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
> @@ -630,14 +661,24 @@ static const struct iio_chan_spec bma250_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(4),
>  };
>  
> +static const struct iio_chan_spec bma254_channels[] = {
> +	BMA180_ACC_CHANNEL(X, 12),
> +	BMA180_ACC_CHANNEL(Y, 12),
> +	BMA180_ACC_CHANNEL(Z, 12),
> +	BMA180_TEMP_CHANNEL,
> +	IIO_CHAN_SOFT_TIMESTAMP(4),
> +};
> +
>  static const struct bma180_part_info bma180_part_info[] = {
>  	[BMA180] = {
> +		.chip_id = BMA180_ID_REG_VAL,
>  		.channels = bma180_channels,
>  		.num_channels = ARRAY_SIZE(bma180_channels),
>  		.scale_table = bma180_scale_table,
>  		.num_scales = ARRAY_SIZE(bma180_scale_table),
>  		.bw_table = bma180_bw_table,
>  		.num_bw = ARRAY_SIZE(bma180_bw_table),
> +		.center_temp = 48, /* 0 LSB @ 24 degree C */
>  		.int_reset_reg = BMA180_CTRL_REG0,
>  		.int_reset_mask = BMA180_RESET_INT,
>  		.sleep_reg = BMA180_CTRL_REG0,
> @@ -656,12 +697,14 @@ static const struct bma180_part_info bma180_part_info[] = {
>  		.chip_disable = bma180_chip_disable,
>  	},
>  	[BMA250] = {
> +		.chip_id = BMA250_ID_REG_VAL,
>  		.channels = bma250_channels,
>  		.num_channels = ARRAY_SIZE(bma250_channels),
> -		.scale_table = bma250_scale_table,
> -		.num_scales = ARRAY_SIZE(bma250_scale_table),
> -		.bw_table = bma250_bw_table,
> -		.num_bw = ARRAY_SIZE(bma250_bw_table),
> +		.scale_table = bma25x_scale_table,
> +		.num_scales = ARRAY_SIZE(bma25x_scale_table),
> +		.bw_table = bma25x_bw_table,
> +		.num_bw = ARRAY_SIZE(bma25x_bw_table),
> +		.center_temp = 48, /* 0 LSB @ 24 degree C */
>  		.int_reset_reg = BMA250_INT_RESET_REG,
>  		.int_reset_mask = BMA250_INT_RESET_MASK,
>  		.sleep_reg = BMA250_POWER_REG,
> @@ -675,9 +718,39 @@ static const struct bma180_part_info bma180_part_info[] = {
>  		.lowpower_val = 1,
>  		.int_enable_reg = BMA250_INT_ENABLE_REG,
>  		.int_enable_mask = BMA250_DATA_INTEN_MASK,
> +		.int_map_reg = BMA250_INT_MAP_REG,
> +		.int_enable_dataready_int1_mask = BMA250_INT1_DATA_MASK,
>  		.softreset_reg = BMA250_RESET_REG,
> -		.chip_config = bma250_chip_config,
> -		.chip_disable = bma250_chip_disable,
> +		.chip_config = bma25x_chip_config,
> +		.chip_disable = bma25x_chip_disable,
> +	},
> +	[BMA254] = {
> +		.chip_id = BMA254_ID_REG_VAL,
> +		.channels = bma254_channels,
> +		.num_channels = ARRAY_SIZE(bma254_channels),
> +		.scale_table = bma25x_scale_table,
> +		.num_scales = ARRAY_SIZE(bma25x_scale_table),
> +		.bw_table = bma25x_bw_table,
> +		.num_bw = ARRAY_SIZE(bma25x_bw_table),
> +		.center_temp = 46, /* 0 LSB @ 23 degree C */
> +		.int_reset_reg = BMA254_INT_RESET_REG,
> +		.int_reset_mask = BMA254_INT_RESET_MASK,
> +		.sleep_reg = BMA254_POWER_REG,
> +		.sleep_mask = BMA254_SUSPEND_MASK,
> +		.bw_reg = BMA254_BW_REG,
> +		.bw_mask = BMA254_BW_MASK,
> +		.scale_reg = BMA254_RANGE_REG,
> +		.scale_mask = BMA254_RANGE_MASK,
> +		.power_reg = BMA254_POWER_REG,
> +		.power_mask = BMA254_LOWPOWER_MASK,
> +		.lowpower_val = 1,
> +		.int_enable_reg = BMA254_INT_ENABLE_REG,
> +		.int_enable_mask = BMA254_DATA_INTEN_MASK,
> +		.int_map_reg = BMA254_INT_MAP_REG,
> +		.int_enable_dataready_int1_mask = BMA254_INT1_DATA_MASK,
> +		.softreset_reg = BMA254_RESET_REG,
> +		.chip_config = bma25x_chip_config,
> +		.chip_disable = bma25x_chip_disable,
>  	},
>  };
>  
> @@ -918,6 +991,7 @@ static SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume);
>  static const struct i2c_device_id bma180_ids[] = {
>  	{ "bma180", BMA180 },
>  	{ "bma250", BMA250 },
> +	{ "bma254", BMA254 },
>  	{ }
>  };
>  
> @@ -932,6 +1006,10 @@ static const struct of_device_id bma180_of_match[] = {
>  		.compatible = "bosch,bma250",
>  		.data = (void *)BMA250
>  	},
> +	{
> +		.compatible = "bosch,bma254",
> +		.data = (void *)BMA254
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, bma180_of_match);
> @@ -951,5 +1029,5 @@ module_i2c_driver(bma180_driver);
>  
>  MODULE_AUTHOR("Kravchenko Oleksandr <x0199363@ti.com>");
>  MODULE_AUTHOR("Texas Instruments, Inc.");
> -MODULE_DESCRIPTION("Bosch BMA180/BMA250 triaxial acceleration sensor");
> +MODULE_DESCRIPTION("Bosch BMA180/BMA25x triaxial acceleration sensor");
>  MODULE_LICENSE("GPL");

