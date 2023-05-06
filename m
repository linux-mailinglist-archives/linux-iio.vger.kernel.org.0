Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFFD6F9309
	for <lists+linux-iio@lfdr.de>; Sat,  6 May 2023 18:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjEFQRm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 May 2023 12:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFQRl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 May 2023 12:17:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BAA6E94;
        Sat,  6 May 2023 09:17:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F155360CFB;
        Sat,  6 May 2023 16:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1D7C433D2;
        Sat,  6 May 2023 16:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683389858;
        bh=63XSCodsrURSCvC0kVPRkm12GyXKRYpAy5ATjGGo6/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O1sBNmCVSpMOchdL8sPQciM96fYEnRBgbi+dgGO8nyjgYEs/IuA2zoKCiHMC3lG4D
         B9ztmCZye1FJI72E/tWmIfmMEe+IVG6tF3oMHlMHy7XxilaZf3fUkV72mipyiBvdEK
         asUdAHz4hML8Tn/Qws0L8dKExi34gRF1v4GGgRada5biLvHlKRNOBXMvBOuddJfKxA
         8op5AtDRoxj9gsc9yh065eIS85iQ47QLL1uwJm73nbYCn1wpzL/FhCXarQw1szfdG7
         evlZnfBEzXHqEpT6UTWVM9otlGQ7SqR2qQUFO36FR3+DSIZX6DguwBb05/kKMKjjd1
         npPoFUbZm2MJA==
Date:   Sat, 6 May 2023 17:33:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio@vger.kernel.org, Crt Mori <cmo@melexis.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: mlx90614: Add MLX90615 support
Message-ID: <20230506173330.000d3826@jic23-huawei>
In-Reply-To: <20230504194750.4489-2-marex@denx.de>
References: <20230504194750.4489-1-marex@denx.de>
        <20230504194750.4489-2-marex@denx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  4 May 2023 21:47:50 +0200
Marek Vasut <marex@denx.de> wrote:

> Add support for MLX90615 Infra Red Thermometer, which seems to be
> the predecesor of MLX90614 . There are significant differences in
> the register layout compared to MLX90614, but the functionality
> of the device is virtually identical.
> 
> The following differences have been identified:
> - RAM/EEPROM/SLEEP access opcodes are different
> - RAM/EEPROM registers are at different offsets
> - EEPROM emissivity and configuration registers are at different offsets
> - EEPROM configuration register bits are shuffled around
> - EEPROM emissivity settings are 14 bit on MLX90615 , 16 bit on MLX90614
> - MLX90615 can only ever support one sensor, MLX90614 could support two
> - FIR filter is set to fixed settings on MLX90615
> - IIR filter coefficients are different
> 
> The approach taken here is to extract the differences between the two
> devices into chip info structure and then patch the code all over to
> cater for the differences.

Approach is a good one, but generally I'd prefer to see a noop refactor
done first then the bits for the new device added in a separate patch.
That keeps each patch focused on one thing.
1st one is just checking the changes are reasonable and make no
functional difference.
2nd one is a datasheet dive or similar to check values for new part are correct.

Clearly in this case the 2nd patch is pretty short, so I'm not that bothered
but wanted to state my general preferred approach for similar series.

A few comments inline, mostly on pushing the remaining part specific stuff
into data in chip_info rather than mixing and matching like this does.

Thanks,

Jonathan

> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> NOTE: The IIR coefficients need to be checked
> ---
> Cc: Crt Mori <cmo@melexis.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> ---
>  drivers/iio/temperature/mlx90614.c | 245 +++++++++++++++++++++--------
>  1 file changed, 176 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index 909fadb623491..9826680608e5e 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -1,12 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * mlx90614.c - Support for Melexis MLX90614 contactless IR temperature sensor
> + * mlx90614.c - Support for Melexis MLX90614/MLX90615 contactless IR temperature sensor
>   *
>   * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
>   * Copyright (c) 2015 Essensium NV
>   * Copyright (c) 2015 Melexis
>   *
> - * Driver for the Melexis MLX90614 I2C 16-bit IR thermopile sensor
> + * Driver for the Melexis MLX90614/MLX90615 I2C 16-bit IR thermopile sensor
> + *
> + * MLX90614 - 17-bit ADC + MLX90302 DSP
> + * MLX90615 - 16-bit ADC + MLX90325 DSP
>   *
>   * (7-bit I2C slave address 0x5a, 100KHz bus speed only!)
>   *
> @@ -22,9 +25,11 @@
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
> +#include <linux/bitfield.h>
>  #include <linux/delay.h>
>  #include <linux/jiffies.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/of_device.h>

property.h 
See below for why

>  #include <linux/pm_runtime.h>
>  
>  #include <linux/iio/iio.h>
> @@ -34,16 +39,27 @@
>  #define MLX90614_OP_EEPROM	0x20
>  #define MLX90614_OP_SLEEP	0xff
>  
> +#define MLX90615_OP_EEPROM	0x10
> +#define MLX90615_OP_RAM		0x20
> +#define MLX90615_OP_SLEEP	0xc6
> +
>  /* RAM offsets with 16-bit data, MSB first */
> -#define MLX90614_RAW1	(MLX90614_OP_RAM | 0x04) /* raw data IR channel 1 */
> -#define MLX90614_RAW2	(MLX90614_OP_RAM | 0x05) /* raw data IR channel 2 */
> -#define MLX90614_TA	(MLX90614_OP_RAM | 0x06) /* ambient temperature */
> -#define MLX90614_TOBJ1	(MLX90614_OP_RAM | 0x07) /* object 1 temperature */
> -#define MLX90614_TOBJ2	(MLX90614_OP_RAM | 0x08) /* object 2 temperature */
> +/* ambient temperature */
> +#define MLX9061X_TA(info)	\
> +	((info)->op_ram_access | 0x06)
> +/* object 1 temperature */
> +#define MLX9061X_TOBJ1(info)	\
> +	((info)->op_ram_access | 0x07)
> +/* object 2 temperature (MLX90614 only) */
> +#define MLX90614_TOBJ2(info)	\
> +	((info)->op_ram_access | 0x08)

I wonder if this would be cleaner with defines just for the 0x06 etc and
then push the op_ram_access down to the accesses.  Building the commands at the call sight
seems simpler than hiding them under a macro like this, particularly now there is a lookup
in a structure burried in there rather than just the | of some constants.

>  
>  /* EEPROM offsets with 16-bit data, MSB first */
> -#define MLX90614_EMISSIVITY	(MLX90614_OP_EEPROM | 0x04) /* emissivity correction coefficient */
> -#define MLX90614_CONFIG		(MLX90614_OP_EEPROM | 0x05) /* configuration register */
> +/* emissivity correction coefficient */
> +#define MLX9061X_EMISSIVITY(info) \
> +	((info)->op_eeprom_access | (info)->eeprom_offset_emissivity)
> +#define MLX9061X_CONFIG(info) \
> +	((info)->op_eeprom_access | (info)->eeprom_offset_config1)
>  
>  /* Control bits in configuration register */
>  #define MLX90614_CONFIG_IIR_SHIFT 0 /* IIR coefficient */
> @@ -52,44 +68,51 @@
>  #define MLX90614_CONFIG_DUAL_MASK (1 << MLX90614_CONFIG_DUAL_SHIFT)
>  #define MLX90614_CONFIG_FIR_SHIFT 8 /* FIR coefficient */
>  #define MLX90614_CONFIG_FIR_MASK (0x7 << MLX90614_CONFIG_FIR_SHIFT)
> -#define MLX90614_CONFIG_GAIN_SHIFT 11 /* gain */
> -#define MLX90614_CONFIG_GAIN_MASK (0x7 << MLX90614_CONFIG_GAIN_SHIFT)
> +
> +#define MLX90615_CONFIG_IIR_SHIFT 12 /* IIR coefficient */
> +#define MLX90615_CONFIG_IIR_MASK (0x7 << MLX90615_CONFIG_IIR_SHIFT)
>  
>  /* Timings (in ms) */
>  #define MLX90614_TIMING_EEPROM 20 /* time for EEPROM write/erase to complete */
>  #define MLX90614_TIMING_WAKEUP 34 /* time to hold SDA low for wake-up */
>  #define MLX90614_TIMING_STARTUP 250 /* time before first data after wake-up */
>  
> +#define MLX90615_TIMING_WAKEUP 22 /* time to hold SCL low for wake-up */
> +
>  #define MLX90614_AUTOSLEEP_DELAY 5000 /* default autosleep delay */
>  
>  /* Magic constants */
> -#define MLX90614_CONST_OFFSET_DEC -13657 /* decimal part of the Kelvin offset */
> -#define MLX90614_CONST_OFFSET_REM 500000 /* remainder of offset (273.15*50) */
> -#define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */
> -#define MLX90614_CONST_RAW_EMISSIVITY_MAX 65535 /* max value for emissivity */
> -#define MLX90614_CONST_EMISSIVITY_RESOLUTION 15259 /* 1/65535 ~ 0.000015259 */
> +#define MLX9061X_CONST_OFFSET_DEC -13657 /* decimal part of the Kelvin offset */
> +#define MLX9061X_CONST_OFFSET_REM 500000 /* remainder of offset (273.15*50) */
> +#define MLX9061X_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */

Avoid wild cards. It's fine if some values apply to multiple sensors and others don't.
Wildcards have bitten us far too often.  What happens when the mlx90617 uses
a different value from these that are shared by the existing parts?  A mess of naming.
Better to just allow for some differing and others not.  

Partly that will be helped by moving all the part specific stuff away from defines
and having values directly in the chip_info instances.  Anything left up here is
generic.

>  #define MLX90614_CONST_FIR 0x7 /* Fixed value for FIR part of low pass filter */
>  
> +enum mlx_chip_model {
> +	MLX90614,
> +	MLX90615,
> +};
> +
> +struct mlx_chip_info {
> +	enum mlx_chip_model	model;

Generally the presence of such an enum value in here is a sign you aren't
abstracting things as much as you should.  Bring everything that differs
between the chips in here as data, or if necessary function pointers
and get rid of this model.

> +	u8			op_eeprom_access;
> +	u8			op_ram_access;
> +	u8			op_sleep;
> +	u8			eeprom_offset_emissivity;
> +	u8			eeprom_offset_config1;
> +	u16			emissivity_max;
> +	u16			emissivity_res;
> +	u16			iir_values[8];
> +	int			iir_freqs[8][2];
As below. This varies in length, so you also want a
	num_irq_freq variable to keep that information in same place as the entries.

> +};

>  /*
>   * Erase an address and write word.
>   * The mutex must be locked before calling.
> @@ -129,21 +152,25 @@ static s32 mlx90614_write_word(const struct i2c_client *client, u8 command,
>  }
>  
>  /*
> - * Find the IIR value inside mlx90614_iir_values array and return its position
> + * Find the IIR value inside iir_values array and return its position
>   * which is equivalent to the bit value in sensor register
>   */
>  static inline s32 mlx90614_iir_search(const struct i2c_client *client,
>  				      int value)
>  {
> -	int i;
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct mlx90614_data *data = iio_priv(indio_dev);
> +	const struct mlx_chip_info *chip_info = data->chip_info;
> +	/* IIR value 0 is FORBIDDEN COMBINATION on MLX90615 */
> +	int i = chip_info->model == MLX90615 ? 1 : 0;

Ah. I wondered about that zero.  You'll want to also figure out how to map
this over.  That might be by making that array contain both the value
to match and the register value it corresponds to rather than relying on
the index.

>  	s32 ret;
>  
> -	for (i = 0; i < ARRAY_SIZE(mlx90614_iir_values); ++i) {
> -		if (value == mlx90614_iir_values[i])
> +	for (; i < ARRAY_SIZE(chip_info->iir_values); ++i) {
> +		if (value == chip_info->iir_values[i])
>  			break;
>  	}
>  
> -	if (i == ARRAY_SIZE(mlx90614_iir_values))
> +	if (i == ARRAY_SIZE(chip_info->iir_values))
>  		return -EINVAL;
>  
>  	/*
> @@ -151,17 +178,23 @@ static inline s32 mlx90614_iir_search(const struct i2c_client *client,
>  	 * we must read them before we actually write
>  	 * changes
>  	 */
> -	ret = i2c_smbus_read_word_data(client, MLX90614_CONFIG);
> +	ret = i2c_smbus_read_word_data(client, MLX9061X_CONFIG(chip_info));
>  	if (ret < 0)
>  		return ret;
>  
> -	ret &= ~MLX90614_CONFIG_FIR_MASK;
> -	ret |= MLX90614_CONST_FIR << MLX90614_CONFIG_FIR_SHIFT;
> -	ret &= ~MLX90614_CONFIG_IIR_MASK;
> -	ret |= i << MLX90614_CONFIG_IIR_SHIFT;
> +	if (chip_info->model == MLX90614) {

As below. Make this data or if appropriate use a function pointer in chip_info.

We don't want to scatter the chip specific stuff through the driver like this.

> +		ret &= ~MLX90614_CONFIG_FIR_MASK;
> +		ret |= MLX90614_CONST_FIR << MLX90614_CONFIG_FIR_SHIFT;
> +		ret &= ~MLX90614_CONFIG_IIR_MASK;
> +		ret |= i << MLX90614_CONFIG_IIR_SHIFT;
> +	} else {
> +		/* MLX90615 has fixed FIR = 65536 */
> +		ret &= ~MLX90615_CONFIG_IIR_MASK;
> +		ret |= i << MLX90615_CONFIG_IIR_SHIFT;
> +	}
>  
>  	/* Write changed values */
> -	ret = mlx90614_write_word(client, MLX90614_CONFIG, ret);
> +	ret = mlx90614_write_word(client, MLX9061X_CONFIG(chip_info), ret);
>  	return ret;
>  }

...

> @@ -377,11 +421,18 @@ static int mlx90614_read_avail(struct iio_dev *indio_dev,
>  			       const int **vals, int *type, int *length,
>  			       long mask)
>  {
> +	struct mlx90614_data *data = iio_priv(indio_dev);
> +	const struct mlx_chip_info *chip_info = data->chip_info;
> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> -		*vals = (int *)mlx90614_freqs;
> +		*vals = (int *)chip_info->iir_freqs;
>  		*type = IIO_VAL_INT_PLUS_MICRO;
> -		*length = 2 * ARRAY_SIZE(mlx90614_freqs);
> +		/* IIR value 0 is FORBIDDEN COMBINATION on MLX90615 */
> +		if (chip_info->model == MLX90615)

Add a parameter in chip_info for this as well.  I don't want to see
any conditionals on model in the code.

Particularly here where the array this length applies to is already in there.
Just add a num_* element to say how big it is.  Then it's easy to see if the
number is correct as it's right next to the data.


> +			*length = 2 * 7;
> +		else
> +			*length = 2 * 8;
>  		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
> @@ -456,6 +507,8 @@ static int mlx90614_sleep(struct mlx90614_data *data)
>  
>  static int mlx90614_wakeup(struct mlx90614_data *data)
>  {
> +	const struct mlx_chip_info *chip_info = data->chip_info;
> +
>  	if (!data->wakeup_gpio) {
>  		dev_dbg(&data->client->dev, "Wake-up disabled");
>  		return -ENOSYS;
> @@ -465,7 +518,8 @@ static int mlx90614_wakeup(struct mlx90614_data *data)
>  
>  	i2c_lock_bus(data->client->adapter, I2C_LOCK_ROOT_ADAPTER);
>  	gpiod_direction_output(data->wakeup_gpio, 0);
> -	msleep(MLX90614_TIMING_WAKEUP);
> +	msleep(data->chip_info == MLX90614 ?
> +	       MLX90614_TIMING_WAKEUP : MLX90615_TIMING_WAKEUP);

chip_info is a pointer
Also, just put the timing in the chip_info structure itself rather than
having any matching on part numbers in the code.

>  	gpiod_direction_input(data->wakeup_gpio);
>  	i2c_unlock_bus(data->client->adapter, I2C_LOCK_ROOT_ADAPTER);
>  
> @@ -478,7 +532,7 @@ static int mlx90614_wakeup(struct mlx90614_data *data)
>  	 * If the read fails, the controller will probably be reset so that
>  	 * further reads will work.
>  	 */
> -	i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
> +	i2c_smbus_read_word_data(data->client, MLX9061X_CONFIG(chip_info));

I'm not really a fan of wild cards. They break far too often when a yet another
part comes along and the macro isn't appropriate. It is fine to stick to
naming after first supported part.

>  
>  	return 0;
>  }
> @@ -527,9 +581,16 @@ static inline struct gpio_desc *mlx90614_probe_wakeup(struct i2c_client *client)
>  /* Return 0 for single sensor, 1 for dual sensor, <0 on error. */
>  static int mlx90614_probe_num_ir_sensors(struct i2c_client *client)
>  {
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct mlx90614_data *data = iio_priv(indio_dev);
> +	const struct mlx_chip_info *chip_info = data->chip_info;
>  	s32 ret;
>  
> -	ret = i2c_smbus_read_word_data(client, MLX90614_CONFIG);
> +	/* MLX90615 is single-sensor only */
> +	if (chip_info->model == MLX90615)
> +		return 0;
> +
> +	ret = i2c_smbus_read_word_data(client, MLX9061X_CONFIG(chip_info));
>  
>  	if (ret < 0)
>  		return ret;
> @@ -556,6 +617,7 @@ static int mlx90614_probe(struct i2c_client *client)
>  	data->client = client;
>  	mutex_init(&data->lock);
>  	data->wakeup_gpio = mlx90614_probe_wakeup(client);
> +	data->chip_info = of_device_get_match_data(&client->dev);

device_get_match_data() That way this works for other firmware types such
as ACPI via PRP0001 entries.  

>  
>  	mlx90614_wakeup(data);
>  
> @@ -605,14 +667,59 @@ static void mlx90614_remove(struct i2c_client *client)
>  	}
>  }
>  
> +static const struct mlx_chip_info mlx90614_chip_info = {
> +	.model				= MLX90614,
> +	.op_eeprom_access		= MLX90614_OP_EEPROM,
> +	.op_ram_access			= MLX90614_OP_RAM,
> +	.op_sleep			= MLX90614_OP_SLEEP,
> +	.eeprom_offset_emissivity	= 0x04,
> +	.eeprom_offset_config1		= 0x05,
> +	.emissivity_max			= 65535,
> +	.emissivity_res			= 1000000000 / 65535,
> +	.iir_values			= { 77, 31, 20, 15, 723, 153, 110, 86 },
> +	.iir_freqs			= {
> +		{ 0, 150000 },	/* 13% ~= 0.15 Hz */
> +		{ 0, 200000 },	/* 17% ~= 0.20 Hz */
> +		{ 0, 310000 },	/* 25% ~= 0.31 Hz */
> +		{ 0, 770000 },	/* 50% ~= 0.77 Hz */
> +		{ 0, 860000 },	/* 57% ~= 0.86 Hz */
> +		{ 1, 100000 },	/* 67% ~= 1.10 Hz */
> +		{ 1, 530000 },	/* 80% ~= 1.53 Hz */
> +		{ 7, 230000 }	/* 100% ~= 7.23 Hz */
> +	},
> +};
> +
> +static const struct mlx_chip_info mlx90615_chip_info = {
> +	.model				= MLX90615,
> +	.op_eeprom_access		= MLX90615_OP_EEPROM,

Is it useful to keep the defines for this constants as they are only
used here?  The fact they are assigned to a field that basically says what they
are suggests to me that you should just put the values in here and get rid
of the defines.  Same of the MLX90614 values.

> +	.op_ram_access			= MLX90615_OP_RAM,
> +	.op_sleep			= MLX90615_OP_SLEEP,
> +	.eeprom_offset_emissivity	= 0x03,
> +	.eeprom_offset_config1		= 0x02,
> +	.emissivity_max			= 16383,
> +	.emissivity_res			= 1000000000 / 16383,
> +	.iir_values			= { 0, 723, 77, 42, 31, 28, 20, 18 },
> +	.iir_freqs			= {
> +		{ 0, 180000 },	/* 14% ~= 0.18 Hz */
> +		{ 0, 200000 },	/* 17% ~= 0.20 Hz */
> +		{ 0, 280000 },	/* 20% ~= 0.28 Hz */
> +		{ 0, 310000 },	/* 25% ~= 0.31 Hz */
> +		{ 0, 420000 },	/* 33% ~= 0.42 Hz */
> +		{ 0, 770000 },	/* 50% ~= 0.77 Hz */
> +		{ 7, 230000 },	/* 100% ~= 7.23 Hz */
> +	},
> +};

