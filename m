Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B87FE4AAE6
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 21:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfFRTOf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 15:14:35 -0400
Received: from first.geanix.com ([116.203.34.67]:40772 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfFRTOe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Jun 2019 15:14:34 -0400
Received: from [192.168.100.94] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id EA341340;
        Tue, 18 Jun 2019 19:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1560885263; bh=x0+/tAuIFOib89CM+8hB8kr9WzP9cNf2049G9gubgP4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GgT7XNNbZVe5OmLeL6W9czY4its2uxxekbXxwvhi19pld6r626UpaksEDMON8zUuP
         dVJ/fk5CwOLMNvCbe723HuFNHwzqpbmyLaLy3klM8iBbrSvbcaODzN3xyxl/PIgxjf
         UTjOrjMZT9Kkbpb+mD4XlTR0OGPbGZuKU411cxYQXgztmry56RuG1j/vVg5+rrWo3U
         wAyFI2uIbZhb+Zbw5BiJGnvmYC0AelxDeLjwbwNr98ognxMJt0Lyv568YzhjZDD//p
         L8FQTUQO1bjTyotUypPIuerivXPwTfUfjfJHVi9nPd4pQnFeSxCVi1EwMhrx0wBpMu
         k5IyYnaZYllCg==
Subject: Re: [PATCH 2/5] iio: imu: st_lsm6dsx: add motion events
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com
References: <20190618125939.105903-1-sean@geanix.com>
 <20190618125939.105903-3-sean@geanix.com>
 <20190618154928.GB20044@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <e41ada28-a8b5-2911-7dd0-d8833debdcee@geanix.com>
Date:   Tue, 18 Jun 2019 21:14:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618154928.GB20044@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 884f5ce5917a
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 18/06/2019 17.49, Lorenzo Bianconi wrote:
>> Add event channels that controls the creation of motion events.
>>
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>> ---
>>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +
>>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 148 ++++++++++++++++++-
>>   2 files changed, 144 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> index a5e373680e9c..966cc6e91c7f 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
>> @@ -155,6 +155,8 @@ struct st_lsm6dsx_hw {
>>   	u8 enable_mask;
>>   	u8 ts_sip;
>>   	u8 sip;
>> +	u8 event_threshold;
>> +	bool enable_event;
>>   
>>   	u8 *buff;
>>   
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> index b5d3fa354de7..351c46f01662 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> @@ -78,6 +78,17 @@
>>   #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
>>   #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
>>   
>> +#define ST_LSM6DSX_REG_TAP_CFG_ADDR		0x58
>> +#define ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK	BIT(7)
>> +#define ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK	GENMASK(6, 5)
>> +
>> +#define ST_LSM6DSX_DEFAULT_WAKE_THRESH		0
>> +#define ST_LSM6DSX_REG_WAKE_UP_THS_ADDR		0x5B
>> +#define ST_LSM6DSX_REG_WAKE_UP_THS_THRES_MASK	GENMASK(5, 0)
> 
> Could you please verify this registermap is used for all supported devices?
> (e.g. LSM6DS3 or LSM6DS3H)

They have the same registers and the bits meaning the same.
But I can't test on those devices...

> 
>> +
>> +#define ST_LSM6DSX_REG_MD1_CFG_ADDR		0x5E
>> +#define ST_LSM6DSX_REG_MD1_CFG_INT1_WU_MASK	BIT(5)
>> +
>>   #define ST_LSM6DSX_ACC_FS_2G_GAIN		IIO_G_TO_M_S_2(61)
>>   #define ST_LSM6DSX_ACC_FS_4G_GAIN		IIO_G_TO_M_S_2(122)
>>   #define ST_LSM6DSX_ACC_FS_8G_GAIN		IIO_G_TO_M_S_2(244)
>> @@ -303,6 +314,13 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>>   	},
>>   };
>>   
>> +static const struct iio_event_spec st_lsm6dsx_event = {
>> +	.type = IIO_EV_TYPE_THRESH,
>> +	.dir = IIO_EV_DIR_EITHER,
>> +	.mask_separate = BIT(IIO_EV_INFO_VALUE) |
>> +			 BIT(IIO_EV_INFO_ENABLE)
>> +};
>> +
>>   #define ST_LSM6DSX_CHANNEL(chan_type, addr, mod, scan_idx)		\
>>   {									\
>>   	.type = chan_type,						\
>> @@ -319,6 +337,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>>   		.storagebits = 16,					\
>>   		.endianness = IIO_LE,					\
>>   	},								\
>> +	.event_spec = &st_lsm6dsx_event,				\
>> +	.num_event_specs = 1,						\
>>   }
> 
> ST_LSM6DSX_CHANNEL is used even for sensor-hub so I do not think you can use in
> this way

I see, will need to come up with a solution to avoid the event channels 
on the gyro.

> 
>>   
>>   static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
>> @@ -435,6 +455,20 @@ static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
>>   				  ST_LSM6DSX_SHIFT_VAL(val, reg->mask));
>>   }
>>   
>> +static int st_lsm6dsx_set_event_threshold(struct st_lsm6dsx_hw *hw, u8 threshold)
>> +{
>> +	int err = 0;
>> +
>> +	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_WAKE_UP_THS_ADDR,
>> +				 ST_LSM6DSX_REG_WAKE_UP_THS_THRES_MASK,
>> +				 threshold);
>> +
>> +	if (!err)
>> +		hw->event_threshold = threshold;
>> +
>> +	return err;
> 
> I think we can just move this configuration in st_lsm6dsx_write_event()

We could, should I then call st_lsm6dsx_write_event() from the probe 
function?

> 
>> +}
>> +
>>   int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor)
>>   {
>>   	int err;
>> @@ -472,18 +506,21 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
>>   	int err, delay;
>>   	__le16 data;
>>   
>> -	err = st_lsm6dsx_sensor_enable(sensor);
>> -	if (err < 0)
>> -		return err;
>> +	if (!hw->enable_event) {
>> +		err = st_lsm6dsx_sensor_enable(sensor);
>> +		if (err < 0)
>> +			return err;
>>   
>> -	delay = 1000000 / sensor->odr;
>> -	usleep_range(delay, 2 * delay);
>> +		delay = 1000000 / sensor->odr;
>> +		usleep_range(delay, 2 * delay);
>> +	}
>>   
>>   	err = regmap_bulk_read(hw->regmap, addr, &data, sizeof(data));
>>   	if (err < 0)
>>   		return err;
>>   
>> -	st_lsm6dsx_sensor_disable(sensor);
>> +	if (!hw->enable_event)
>> +		st_lsm6dsx_sensor_disable(sensor);
>>   
>>   	*val = (s16)le16_to_cpu(data);
>>   
>> @@ -556,6 +593,75 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
>>   	return err;
>>   }
>>   
>> +static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
>> +				   const struct iio_chan_spec *chan,
>> +				   enum iio_event_type type,
>> +				   enum iio_event_direction dir,
>> +				   enum iio_event_info info,
>> +				   int *val, int *val2)
>> +{
>> +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>> +
>> +	*val2 = 0;
>> +	*val = sensor->hw->event_threshold;
>> +
>> +	return IIO_VAL_INT;
>> +}
>> +
>> +static int st_lsm6dsx_write_event(struct iio_dev *iio_dev,
>> +				    const struct iio_chan_spec *chan,
>> +				    enum iio_event_type type,
>> +				    enum iio_event_direction dir,
>> +				    enum iio_event_info info,
>> +				    int val, int val2)
>> +{
>> +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>> +	struct st_lsm6dsx_hw *hw = sensor->hw;
>> +
>> +	if (!hw->enable_event)
>> +		return -EBUSY;
>> +
>> +	if ((val < 0) || (val > 31))
> 
> unnecessary brackets

Will remove them :-)

> 
>> +		return -EINVAL;
>> +
>> +	if (st_lsm6dsx_set_event_threshold(sensor->hw, val))
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static int st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
>> +					  const struct iio_chan_spec *chan,
>> +					  enum iio_event_type type,
>> +					  enum iio_event_direction dir)
>> +{
>> +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>> +	struct st_lsm6dsx_hw *hw = sensor->hw;
>> +
>> +	return hw->enable_event;
>> +}
>> +
>> +static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
>> +					   const struct iio_chan_spec *chan,
>> +					   enum iio_event_type type,
>> +					   enum iio_event_direction dir,
>> +					   int state)
>> +{
>> +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>> +	struct st_lsm6dsx_hw *hw = sensor->hw;
>> +
>> +	if (state && hw->enable_event)
>> +		return 0;
>> +
>> +	hw->enable_event = state;
>> +	if (state)
>> +		st_lsm6dsx_sensor_enable(sensor);
> 
> please correct me if I am wrong but in this way we break normal operation (e.g.
> if we are reading acc data from the FIFO). You need to check enabled_mask.

Will change to the enabled_mask

> Moreover we should check event type

Do we, we only have one type?

> 
>> +	else
>> +		st_lsm6dsx_sensor_disable(sensor);
>> +
>> +	return 0;
>> +}
>> +
>>   static int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val)
>>   {
>>   	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
>> @@ -632,6 +738,10 @@ static const struct iio_info st_lsm6dsx_acc_info = {
>>   	.attrs = &st_lsm6dsx_acc_attribute_group,
>>   	.read_raw = st_lsm6dsx_read_raw,
>>   	.write_raw = st_lsm6dsx_write_raw,
>> +	.read_event_value = st_lsm6dsx_read_event,
>> +	.write_event_value = st_lsm6dsx_write_event,
>> +	.read_event_config = st_lsm6dsx_read_event_config,
>> +	.write_event_config = st_lsm6dsx_write_event_config,
>>   	.hwfifo_set_watermark = st_lsm6dsx_set_watermark,
>>   };
>>   
>> @@ -761,6 +871,8 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>>   	if (err < 0)
>>   		return err;
>>   
>> +	st_lsm6dsx_set_event_threshold(hw, ST_LSM6DSX_DEFAULT_WAKE_THRESH);
> 
> we do not need this since default value is already 0

I actually think we do need it, if we come up from a reboot we don't 
know the value stored in the register.

> 
>> +
>>   	return st_lsm6dsx_init_hw_timer(hw);
>>   }
>>   
>> @@ -811,6 +923,27 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>>   	return iio_dev;
>>   }
>>   
>> +int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw)
>> +{
>> +	int err;
>> +
>> +	/* Enable inactivity function - low power ACC, GYRO powered-down */
>> +	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_TAP_CFG_ADDR,
>> +				 ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK |
>> +				 ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK,
>> +				 ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK |
>> +				 ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	/* Enable wakeup interrupt */
>> +	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_MD1_CFG_ADDR,
>> +				 ST_LSM6DSX_REG_MD1_CFG_INT1_WU_MASK,
>> +				 ST_LSM6DSX_REG_MD1_CFG_INT1_WU_MASK);
>> +
>> +	return err;
>> +}
>> +
>>   static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
>>   {
>>   	struct st_lsm6dsx_hw *hw = private;
>> @@ -932,6 +1065,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
>>   		err = st_lsm6dsx_fifo_setup(hw);
>>   		if (err < 0)
>>   			return err;
>> +		err = st_lsm6dsx_event_setup(hw);
>> +		if (err < 0)
>> +			return err;
>>   	}
>>   
>>   	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>> -- 
>> 2.22.0
>>
