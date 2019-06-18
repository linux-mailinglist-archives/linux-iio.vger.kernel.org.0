Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8874AB05
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 21:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbfFRTbj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 15:31:39 -0400
Received: from first.geanix.com ([116.203.34.67]:41300 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730189AbfFRTbj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Jun 2019 15:31:39 -0400
Received: from [192.168.100.94] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id AA7A335E;
        Tue, 18 Jun 2019 19:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1560886288; bh=4PWcdhPAFZROBKU3NkKGdb/gK8xQTN5oEkim1DpqkGA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TIqdIHQxkajNA5PqY/Y5CeufqeiTYcUQqSrwFRZkv9HZEh3eaRVc5RPWifOOeQdjB
         uL+TppMDllLUAaAcbMzeCMJ57rSNAHVDBx/EmosHhdkvddgYjwu37ek99nsqONqOGK
         XLgne3JFfYzTsx1JyMtj52B2/mll0abegerGKS55cpmQa2zZ+F4c0OBEGIRmD5/obL
         +Xnlxpp/HJum5B5bdW+bP5ZdejP3mS64C1AvTq0SO6Q47Xx43zRgKzMMgppt02qFXD
         u2jDdqqeeuBneEELgRrl6TQfptENB4WRUu91vh5xvHF76ITzezw1Oc/p2qh6ot4A0g
         y20MCKQ7EyjpA==
Subject: Re: [PATCH 4/5] iio: imu: st_lsm6dsx: always enter interrupt thread
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com
References: <20190618125939.105903-1-sean@geanix.com>
 <20190618125939.105903-5-sean@geanix.com>
 <20190618155527.GD20044@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <3c1f1f3c-7de8-160a-a5bf-b9abfca78d50@geanix.com>
Date:   Tue, 18 Jun 2019 21:31:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618155527.GD20044@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 884f5ce5917a
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 18/06/2019 17.55, Lorenzo Bianconi wrote:
>> The interrupt source can come from multiple sources, fifo and wake interrupts.
>> Enter interrupt thread to check which interrupt that has fired.
>>
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>> ---
>>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 +++++++++++++++-----
>>   1 file changed, 23 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> index 59a34894e495..76aec5024d83 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> @@ -78,6 +78,12 @@
>>   #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
>>   #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
>>   
>> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR		0x1B
>> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_Z_WU_MASK	BIT(0)
>> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_Y_WU_MASK	BIT(1)
>> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_X_WU_MASK	BIT(2)
>> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_WU_MASK	BIT(4)
>> +
>>   #define ST_LSM6DSX_REG_TAP_CFG_ADDR		0x58
>>   #define ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK	BIT(7)
>>   #define ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK	GENMASK(6, 5)
>> @@ -946,19 +952,29 @@ int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw)
>>   
>>   static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
>>   {
>> -	struct st_lsm6dsx_hw *hw = private;
>> -
>> -	return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
>> +	return IRQ_WAKE_THREAD;
> 
> I guess this will break shared interrupt, isn't it?

When you write shared interrupt you mean: the drdy-int-pin stuff?
I need to add so we can use all this functionality with the INT2 as well...

> 
>>   }
>>   
>>   static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>>   {
>>   	struct st_lsm6dsx_hw *hw = private;
>> -	int count;
>> +	int count = 0;
>> +	int data, err;
>> +
>> +	if (hw->enable_event) {
>> +		err = regmap_read(hw->regmap,
>> +				  ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR, &data);
>> +		if (err < 0)
>> +			goto try_fifo;
> 
> You can simplify this just doing something like:
> 
> 		if (err < 0 && !hw->sip)
> 			return IRQ_NONE;
>
Will apply :-)

Thanks for the review Lorenzo...

-- 
Best regards,
Sean Nyekjær
Embedded Linux Consultant

+45 42427326
sean@geanix.com

Geanix ApS
https://geanix.com
DK39600706
