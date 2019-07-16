Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C10B16A222
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 08:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfGPGKe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Jul 2019 02:10:34 -0400
Received: from comms.puri.sm ([159.203.221.185]:39998 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfGPGKd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Jul 2019 02:10:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id E1050DFFDB;
        Mon, 15 Jul 2019 23:10:30 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m51qG9iD3rqM; Mon, 15 Jul 2019 23:10:29 -0700 (PDT)
Subject: Re: [PATCH 2/3] iio: imu: st_lsm6dsx: add support for accel/gyro unit
 of lsm9sd1
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190715131919.31938-1-martin.kepplinger@puri.sm>
 <20190715131919.31938-2-martin.kepplinger@puri.sm>
 <20190715214920.GB23126@localhost.localdomain>
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
Openpgp: preference=signencrypt
Autocrypt: addr=martin.kepplinger@puri.sm; keydata=
 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
 WG//KA68tPVBR2xhy7Fp+qAa
Message-ID: <27b18ff1-6970-e473-d118-fd7878eda7a6@puri.sm>
Date:   Tue, 16 Jul 2019 08:10:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20190715214920.GB23126@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 15.07.19 23:49, Lorenzo Bianconi wrote:
>> The LSM9DS1's accelerometer / gyroscope unit and it's magnetometer (separately
>> supported in iio/magnetometer/st_magn*) are located on a separate i2c addresses
>> on the bus.
>>
>> For the datasheet, see https://www.st.com/resource/en/datasheet/lsm9ds1.pdf
>>
>> Treat it just like the LSM6* devices and, despite it's name, hook it up
>> to the st_lsm6dsx driver, using it's basic functionality.
>>
>> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
>> ---
>>
>> What do you think about an addition like this? How confusing is it to support
>> an LSM9 module by the lsm6 driver, despite it's name? It requires almost no
>> code, so why not think about it, right?
> 
> I am fine with (it was on my ToDo list, so thanks for working on this).
> I have just posted the following series that will help you adding support for
> LSM9DS1
> https://patchwork.kernel.org/cover/11045061/
> I think you just need to take care of gyro channels allocating iio devices (you
> probably need to pass hw_id to st_lsm6dsx_alloc_iiodev())

yes. I'll look over allocation once more.

> 
>>
>> Oh, I'm not 100% convinced by my new "if" in probe(), but even that is
>> not too confusing I guess.
>>
>> thanks,
>>
>>                            martin
>>
>> p.s.: todos:
>> * hook up the fifo / buffer / trigger functionality,
>> * (off-topic a bit) move the (currently strange) gyro-only support
>>   for lsm9ds0 to this driver as well.
> 
> Regarding FIFO I guess it is enough to set decimator factor to 1 for both accel
> and gyro.
> 
> Regards,
> Lorenzo
> 
>>
>>
>>
>>  drivers/iio/imu/st_lsm6dsx/Kconfig           |   3 +-
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   4 +
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 105 ++++++++++++++++++-
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |   5 +
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |   5 +
>>  5 files changed, 117 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
>> index 002a423eae52..0b5a568e4c16 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
>> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
>> @@ -10,7 +10,8 @@ config IIO_ST_LSM6DSX
>>  	help
>>  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
>>  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
>> -	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr
>> +	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr and the
>> +	  accelerometer/gyroscope of lsm9ds1.
>>  
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called st_lsm6dsx.
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> index f072ac14f213..8af9641260fa 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> @@ -22,6 +22,7 @@
>>  #define ST_ASM330LHH_DEV_NAME	"asm330lhh"
>>  #define ST_LSM6DSOX_DEV_NAME	"lsm6dsox"
>>  #define ST_LSM6DSR_DEV_NAME	"lsm6dsr"
>> +#define ST_LSM9DS1_DEV_NAME	"lsm9ds1"
>>  
>>  enum st_lsm6dsx_hw_id {
>>  	ST_LSM6DS3_ID,
>> @@ -33,6 +34,7 @@ enum st_lsm6dsx_hw_id {
>>  	ST_ASM330LHH_ID,
>>  	ST_LSM6DSOX_ID,
>>  	ST_LSM6DSR_ID,
>> +	ST_LSM9DS1_ID,
>>  	ST_LSM6DSX_MAX_ID,
>>  };
>>  
>> @@ -230,6 +232,8 @@ enum st_lsm6dsx_sensor_id {
>>  	ST_LSM6DSX_ID_EXT0,
>>  	ST_LSM6DSX_ID_EXT1,
>>  	ST_LSM6DSX_ID_EXT2,
>> +	ST_LSM9DSX_ID_GYRO,
>> +	ST_LSM9DSX_ID_ACC,
>>  	ST_LSM6DSX_ID_MAX,
>>  };
>>  
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> index 7a4fe70a8f20..6acfe63073de 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> @@ -10,6 +10,8 @@
>>   * +-125/+-245/+-500/+-1000/+-2000 dps
>>   * LSM6DSx series has an integrated First-In-First-Out (FIFO) buffer
>>   * allowing dynamic batching of sensor data.
>> + * LSM9DSx series is similar but includes an additional magnetometer, handled
>> + * by a different driver.
>>   *
>>   * Supported sensors:
>>   * - LSM6DS3:
>> @@ -30,6 +32,13 @@
>>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
>>   *   - FIFO size: 3KB
>>   *
>> + * - LSM9DS1:
>> + *   - Accelerometer supported ODR [Hz]: 10, 50, 119, 238, 476, 952
>> + *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
>> + *   - Gyroscope supported ODR [Hz]: 15, 60, 119, 238, 476, 952
>> + *   - Gyroscope supported full-scale [dps]: +-245/+-500/+-2000
>> + *   - FIFO size: 32
>> + *
>>   * Copyright 2016 STMicroelectronics Inc.
>>   *
>>   * Lorenzo Bianconi <lorenzo.bianconi@st.com>
>> @@ -64,6 +73,10 @@
>>  #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
>>  #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
>>  
>> +#define ST_LSM9DSX_REG_GYRO_OUT_X_L_ADDR	0x18
>> +#define ST_LSM9DSX_REG_GYRO_OUT_Y_L_ADDR	0x1a
>> +#define ST_LSM9DSX_REG_GYRO_OUT_Z_L_ADDR	0x1c
>> +
>>  static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] = {
>>  	[ST_LSM6DSX_ID_ACC] = {
>>  		.reg = {
>> @@ -88,6 +101,30 @@ static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] = {
>>  		.odr_avl[3] = { 104, 0x04 },
>>  		.odr_avl[4] = { 208, 0x05 },
>>  		.odr_avl[5] = { 416, 0x06 },
>> +	},
>> +	[ST_LSM9DSX_ID_ACC] = {
>> +		.reg = {
>> +			.addr = 0x20,
>> +			.mask = GENMASK(7, 5),
>> +		},
>> +		.odr_avl[0] = {  10, 0x01 },
>> +		.odr_avl[1] = {  50, 0x02 },
>> +		.odr_avl[2] = { 119, 0x03 },
>> +		.odr_avl[3] = { 238, 0x04 },
>> +		.odr_avl[4] = { 476, 0x05 },
>> +		.odr_avl[5] = { 952, 0x06 },
>> +	},
>> +	[ST_LSM9DSX_ID_GYRO] = {
>> +		.reg = {
>> +			.addr = 0x10,
>> +			.mask = GENMASK(7, 5),
>> +		},
>> +		.odr_avl[0] = {  15, 0x01 },
>> +		.odr_avl[1] = {  60, 0x02 },
>> +		.odr_avl[2] = { 119, 0x03 },
>> +		.odr_avl[3] = { 238, 0x04 },
>> +		.odr_avl[4] = { 476, 0x05 },
>> +		.odr_avl[5] = { 952, 0x06 },
>>  	}
>>  };
>>  
>> @@ -111,10 +148,43 @@ static const struct st_lsm6dsx_fs_table_entry st_lsm6dsx_fs_table[] = {
>>  		.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
>>  		.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
>>  		.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
>> +	},
>> +	[ST_LSM9DSX_ID_ACC] = {
>> +		.reg = {
>> +			.addr = 0x20,
>> +			.mask = GENMASK(4, 3),
>> +		},
>> +		.fs_avl[0] = {  599, 0x0 },
>> +		.fs_avl[1] = { 1197, 0x2 },
>> +		.fs_avl[2] = { 2394, 0x3 },
>> +		.fs_avl[3] = { 4788, 0x1 },
>> +	},
>> +	[ST_LSM9DSX_ID_GYRO] = {
>> +		.reg = {
>> +			.addr = 0x10,
>> +			.mask = GENMASK(4, 3),
>> +		},
>> +		.fs_avl[0] = { IIO_DEGREE_TO_RAD(245), 0x0 },
>> +		.fs_avl[1] = { IIO_DEGREE_TO_RAD(500), 0x1 },
>> +		.fs_avl[2] = { IIO_DEGREE_TO_RAD(0), 0x2 },
>> +		.fs_avl[3] = { IIO_DEGREE_TO_RAD(2000), 0x3 },
>>  	}
>>  };
>>  
>>  static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>> +	{
>> +		.wai = 0x68,
>> +		.reg_int1_addr = 0x0c,
>> +		.reg_int2_addr = 0x0d,
>> +		.reg_reset_addr = 0x22,
>> +		.max_fifo_size = 32,
>> +		.id = {
>> +			{
>> +				.hw_id = ST_LSM9DS1_ID,
>> +				.name = ST_LSM9DS1_DEV_NAME,
>> +			},
>> +		},
>> +	},
>>  	{
>>  		.wai = 0x69,
>>  		.reg_int1_addr = 0x0d,
>> @@ -492,6 +562,16 @@ static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
>>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>>  };
>>  
>> +static const struct iio_chan_spec st_lsm9dsx_gyro_channels[] = {
>> +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, ST_LSM9DSX_REG_GYRO_OUT_X_L_ADDR,
>> +			   IIO_MOD_X, 0),
>> +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, ST_LSM9DSX_REG_GYRO_OUT_Y_L_ADDR,
>> +			   IIO_MOD_Y, 1),
>> +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, ST_LSM9DSX_REG_GYRO_OUT_Z_L_ADDR,
>> +			   IIO_MOD_Z, 2),
>> +	IIO_CHAN_SOFT_TIMESTAMP(3),
>> +};
>> +
>>  int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, bool enable)
>>  {
>>  	const struct st_lsm6dsx_shub_settings *hub_settings;
>> @@ -1056,6 +1136,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>>  
>>  	switch (id) {
>>  	case ST_LSM6DSX_ID_ACC:
>> +	case ST_LSM9DSX_ID_ACC:
>>  		iio_dev->channels = st_lsm6dsx_acc_channels;
>>  		iio_dev->num_channels = ARRAY_SIZE(st_lsm6dsx_acc_channels);
>>  		iio_dev->info = &st_lsm6dsx_acc_info;
>> @@ -1068,6 +1149,14 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>>  		iio_dev->num_channels = ARRAY_SIZE(st_lsm6dsx_gyro_channels);
>>  		iio_dev->info = &st_lsm6dsx_gyro_info;
>>  
>> +		scnprintf(sensor->name, sizeof(sensor->name), "%s_gyro",
>> +			  name);
>> +		break;
>> +	case ST_LSM9DSX_ID_GYRO:
>> +		iio_dev->channels = st_lsm9dsx_gyro_channels;
>> +		iio_dev->num_channels = ARRAY_SIZE(st_lsm9dsx_gyro_channels);
>> +		iio_dev->info = &st_lsm6dsx_gyro_info;
>> +
>>  		scnprintf(sensor->name, sizeof(sensor->name), "%s_gyro",
>>  			  name);
>>  		break;
>> @@ -1109,10 +1198,18 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>>  	if (err < 0)
>>  		return err;
>>  
>> -	for (i = 0; i < ST_LSM6DSX_ID_EXT0; i++) {
>> -		hw->iio_devs[i] = st_lsm6dsx_alloc_iiodev(hw, i, name);
>> -		if (!hw->iio_devs[i])
>> -			return -ENOMEM;
>> +	if (hw_id == ST_LSM9DS1_ID) {
>> +		for (i = ST_LSM9DSX_ID_GYRO; i <= ST_LSM9DSX_ID_ACC; i++) {
>> +			hw->iio_devs[i] = st_lsm6dsx_alloc_iiodev(hw, i, name);
>> +			if (!hw->iio_devs[i])
>> +				return -ENOMEM;
>> +		}
>> +	} else {
>> +		for (i = 0; i < ST_LSM6DSX_ID_EXT0; i++) {
>> +			hw->iio_devs[i] = st_lsm6dsx_alloc_iiodev(hw, i, name);
>> +			if (!hw->iio_devs[i])
>> +				return -ENOMEM;
>> +		}
>>  	}
>>  
>>  	err = st_lsm6dsx_init_device(hw);
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
>> index b3211e0ac07b..a684e7db1299 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
>> @@ -75,6 +75,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
>>  		.compatible = "st,lsm6dsr",
>>  		.data = (void *)ST_LSM6DSR_ID,
>>  	},
>> +	{
>> +		.compatible = "st,lsm9ds1",
>> +		.data = (void *)ST_LSM9DS1_ID,
>> +	},
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
>> @@ -89,6 +93,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
>>  	{ ST_ASM330LHH_DEV_NAME, ST_ASM330LHH_ID },
>>  	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
>>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
>> +	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
>> index c9d3c4711018..709769177e91 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
>> @@ -75,6 +75,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
>>  		.compatible = "st,lsm6dsr",
>>  		.data = (void *)ST_LSM6DSR_ID,
>>  	},
>> +	{
>> +		.compatible = "st,lsm9ds1",
>> +		.data = (void *)ST_LSM9DS1_ID,
>> +	},
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
>> @@ -89,6 +93,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
>>  	{ ST_ASM330LHH_DEV_NAME, ST_ASM330LHH_ID },
>>  	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
>>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
>> +	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
>> -- 
>> 2.20.1
>>

