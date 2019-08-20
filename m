Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C2F963B1
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2019 17:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfHTPGj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Aug 2019 11:06:39 -0400
Received: from comms.puri.sm ([159.203.221.185]:53582 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbfHTPGi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Aug 2019 11:06:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 7A55CDF787;
        Tue, 20 Aug 2019 08:06:37 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bag8A-0b_dlU; Tue, 20 Aug 2019 08:06:36 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] iio: imu: st_lsm6dsx: add support for accel/gyro
 unit of lsm9sd1
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20190813073533.8007-1-martin.kepplinger@puri.sm>
 <20190813073533.8007-3-martin.kepplinger@puri.sm>
 <20190819094845.GB17835@localhost.localdomain>
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
Openpgp: preference=signencrypt
Autocrypt: addr=martin.kepplinger@puri.sm; keydata=
 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
 WG//KA68tPVBR2xhy7Fp+qAa
Message-ID: <6c739681-d46e-b4f7-9831-bdf1e9bcd540@puri.sm>
Date:   Tue, 20 Aug 2019 17:06:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <20190819094845.GB17835@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 19.08.19 11:48, Lorenzo Bianconi wrote:
>> The LSM9DS1's accelerometer / gyroscope unit and it's magnetometer (separately
>> supported in iio/magnetometer/st_magn*) are located on a separate i2c addresses
>> on the bus.
>>
>> For the datasheet, see https://www.st.com/resource/en/datasheet/lsm9ds1.pdf
>>
>> Treat it just like the LSM6* devices and, despite it's name, hook it up
>> to the st_lsm6dsx driver, using it's basic functionality.
>>
>> accelerometer and gyroscope are not independently clocked. It runs at the gyro
>> frequencies if both are enabled, see chapter 7.12 of the datasheet.
>> We could have handled this as a single IIO device but we have split
>> it up to be more consistent with the other more flexible devices.
>>
>> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> 
> Hi Martin,
> 
> most of comments are nitpicks (inline), the only issue I can see here is we can enable
> hw fifo for lsm6ds0/lsm9ds1 and read_fifo routine pointer is not currently
> initialized so we will end up with a NULL pointer dereference. Since we will
> need a different update FIFO routine for lsm6ds0/lsm9ds1 I am adding an
> update_fifo function pointer in fifo_ops in order to fix this issue.
> 
> Regards,
> Lorenzo
> 
>> ---
>>  drivers/iio/imu/st_lsm6dsx/Kconfig           |  2 +-
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 +
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 87 ++++++++++++++++++++
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  5 ++
>>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  5 ++
>>  5 files changed, 100 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
>> index 939058b27746..77aa0e77212d 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
>> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
>> @@ -12,7 +12,7 @@ config IIO_ST_LSM6DSX
>>  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
>>  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
>>  	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr, lsm6ds3tr-c,
>> -	  ism330dhcx
>> +	  ism330dhcx and the accelerometer/gyroscope of lsm9ds1.
>>  
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called st_lsm6dsx.
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> index c8f333902eb7..d03b5a2d8549 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> @@ -24,6 +24,7 @@
>>  #define ST_LSM6DSR_DEV_NAME	"lsm6dsr"
>>  #define ST_LSM6DS3TRC_DEV_NAME	"lsm6ds3tr-c"
>>  #define ST_ISM330DHCX_DEV_NAME	"ism330dhcx"
>> +#define ST_LSM9DS1_DEV_NAME	"lsm9ds1"
> 
> should be called 'lsm9ds1_imu' since lsm9ds1 is a 9-axis device? what do you
> think?
> 
>>  
>>  enum st_lsm6dsx_hw_id {
>>  	ST_LSM6DS3_ID,
>> @@ -37,6 +38,7 @@ enum st_lsm6dsx_hw_id {
>>  	ST_LSM6DSR_ID,
>>  	ST_LSM6DS3TRC_ID,
>>  	ST_ISM330DHCX_ID,
>> +	ST_LSM9DS1_ID,
> 
> same here..ST_LSM9DS1_IMU_ID

I wouldn't add "imu" to the actual part name, see below...

> 
>>  	ST_LSM6DSX_MAX_ID,
>>  };
>>  
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> index 56e1c5262a2c..f038bb06f635 100644
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
>> @@ -70,7 +79,85 @@ static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
>>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>>  };
>>  
>> +static const struct iio_chan_spec st_lsm9dsx_gyro_channels[] = {
>> +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x18, IIO_MOD_X, 0),
>> +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x1a, IIO_MOD_Y, 1),
>> +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x1c, IIO_MOD_Z, 2),
>> +	IIO_CHAN_SOFT_TIMESTAMP(3),
>> +};
>> +
> 
> why not st_lsm6ds0_gyro_channels?

Would be ok with me. I'll remember this if I do a new iteration.

> 
>>  static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>> +	{
>> +		.wai = 0x68,
>> +		.int1_addr = 0x0c,
>> +		.int2_addr = 0x0d,
>> +		.reset_addr = 0x22,
>> +		.max_fifo_size = 32,
>> +		.id = {
>> +			{
>> +				.hw_id = ST_LSM9DS1_ID,
>> +				.name = ST_LSM9DS1_DEV_NAME,
>> +			},
>> +		},
>> +		.channels = {
>> +			[ST_LSM6DSX_ID_ACC] = {
>> +				.chan = st_lsm6dsx_acc_channels,
>> +				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
>> +			},
>> +			[ST_LSM6DSX_ID_GYRO] = {
>> +				.chan = st_lsm9dsx_gyro_channels,
>> +				.len = ARRAY_SIZE(st_lsm9dsx_gyro_channels),
>> +			},
>> +		},
>> +		.odr_table = {
>> +			[ST_LSM6DSX_ID_ACC] = {
>> +				.reg = {
>> +					.addr = 0x20,
>> +					.mask = GENMASK(7, 5),
>> +				},
>> +				.odr_avl[0] = {  10, 0x01 },
>> +				.odr_avl[1] = {  50, 0x02 },
>> +				.odr_avl[2] = { 119, 0x03 },
>> +				.odr_avl[3] = { 238, 0x04 },
>> +				.odr_avl[4] = { 476, 0x05 },
>> +				.odr_avl[5] = { 952, 0x06 },
>> +			},
>> +			[ST_LSM6DSX_ID_GYRO] = {
>> +				.reg = {
>> +					.addr = 0x10,
>> +					.mask = GENMASK(7, 5),
>> +				},
>> +				.odr_avl[0] = {  15, 0x01 },
>> +				.odr_avl[1] = {  60, 0x02 },
>> +				.odr_avl[2] = { 119, 0x03 },
>> +				.odr_avl[3] = { 238, 0x04 },
>> +				.odr_avl[4] = { 476, 0x05 },
>> +				.odr_avl[5] = { 952, 0x06 },
>> +			},
>> +		},
>> +		.fs_table = {
>> +			[ST_LSM6DSX_ID_ACC] = {
>> +				.reg = {
>> +					.addr = 0x20,
>> +					.mask = GENMASK(4, 3),
>> +				},
>> +				.fs_avl[0] = {  599, 0x0 },
>> +				.fs_avl[1] = { 1197, 0x2 },
>> +				.fs_avl[2] = { 2394, 0x3 },
>> +				.fs_avl[3] = { 4788, 0x1 },
>> +			},
>> +			[ST_LSM6DSX_ID_GYRO] = {
>> +				.reg = {
>> +					.addr = 0x10,
>> +					.mask = GENMASK(4, 3),
>> +				},
>> +				.fs_avl[0] = { IIO_DEGREE_TO_RAD(245), 0x0 },
>> +				.fs_avl[1] = { IIO_DEGREE_TO_RAD(500), 0x1 },
>> +				.fs_avl[2] = { IIO_DEGREE_TO_RAD(0), 0x2 },
>> +				.fs_avl[3] = { IIO_DEGREE_TO_RAD(2000), 0x3 },
>> +			},
>> +		},
>> +	},
>>  	{
>>  		.wai = 0x69,
>>  		.int1_addr = 0x0d,
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
>> index 15c6aa5b6caa..2f1b30ff083b 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
>> @@ -83,6 +83,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
>>  		.compatible = "st,ism330dhcx",
>>  		.data = (void *)ST_ISM330DHCX_ID,
>>  	},
>> +	{
>> +		.compatible = "st,lsm9ds1",
> 
> same here, what is the right compatible string? "st,lsm9ds1 or
> "st,lsm9ds1_imu"?

well, I'm open for this change, but "imu" doesn't really mean much
technically, so I would stick with the device name. "imu" is not part of
the "part" name...

> 
>> +		.data = (void *)ST_LSM9DS1_ID,
>> +	},
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
>> @@ -99,6 +103,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
>>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
>>  	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
>>  	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
>> +	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
>> index a8430ee11310..421ce704f346 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
>> @@ -83,6 +83,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
>>  		.compatible = "st,ism330dhcx",
>>  		.data = (void *)ST_ISM330DHCX_ID,
>>  	},
>> +	{
>> +		.compatible = "st,lsm9ds1",
>> +		.data = (void *)ST_LSM9DS1_ID,
>> +	},
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
>> @@ -99,6 +103,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
>>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
>>  	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
>>  	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
>> +	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
>> -- 
>> 2.20.1
>>

