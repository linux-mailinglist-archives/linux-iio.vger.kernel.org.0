Return-Path: <linux-iio+bounces-5767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3987D8FB65D
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 16:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F07286386
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 14:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E15813D27C;
	Tue,  4 Jun 2024 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1j72Tpd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA956131BDF;
	Tue,  4 Jun 2024 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513087; cv=none; b=TpwGVs5sfiY1SJk19uKiIExRrSI9Tpeebr9aoSO+UA5bFDbogwx4C2zVzLKU7imlMX3OqM16hVfZ28D5m2rVlwK/t4MeEzoD0cmFKKIXC1/47kdYbUHIEUElnRjP5Dr0t/haeOp5EnjM3LQnSHVBBHX0PoTejDL2w8QUigFE/sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513087; c=relaxed/simple;
	bh=T43lrNapWOLooExytun/Gy25CB4L+nh1m5pMJhH+qho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdCIC3BQxLm3QYtKFhti5ST6gmInC9uA6UIjizCPda+KbHR76DtiNHoiDLAnqcJyqLRhyVNU2sobK7hqkGLrFKTkyB3o6FcHoATZPGIJwh4OSIH4ZIgbkKcd51jOLGOfyN+YybpZH/RTIoDC6fGum9L6ZbZQQ50KJzEKo15T9Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1j72Tpd; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63947so5163179a12.1;
        Tue, 04 Jun 2024 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717513084; x=1718117884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DLpjHJ3RU/g4rNd8s6q450nQr0WrZqzWOMku/dTJ6DE=;
        b=A1j72TpdRwiMv0v8gGlEgCW4dxEsbbsFnC75aA3b3NHVdM0ZRWVQoluVzqY63UJxkv
         bMEvGhFA+TGZyH+Ip7E+fFmM5lEzcgF6CAT3LvnEGLTxpUr4XltEXLH9e4HhgbtGeQZs
         TO+I/FI05sAGPEtC7qnMhxnFh7i3ByxHHf9J6LgIfaiwYT3BWL3A7vNLU54db3plP+JH
         iK8ddkkY5c2cDsy7fPFWwNGf8rvsq871V6N7cbiaHIS8m7sNkrqbExsfRVhc3JdXLbtB
         e204eKeDcFcj4f8f3U7dBkLjkSLdKu6fdP5gmYeZ7Yk8ToKvcRlReoZVlRw5c3aRNzwB
         ASIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717513084; x=1718117884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLpjHJ3RU/g4rNd8s6q450nQr0WrZqzWOMku/dTJ6DE=;
        b=RH6EUcTVBMRfOjZPCXKC5WoNI/KS+cetRQRQ92+JKNIKr60rL/0px9UU8KL3SwjNWI
         FYjtFOM8xBERSEuUGD/NRKDoIsckbggcAPVu3OSfvBdWVsGvzy6ttYcFhSAbl+1lpIUy
         Koduaks+JAmlTNKvFYmZQUmLuKRVymNuXVNGTjRbTnyah1qeXrU6VpxnaJlRiYCSgrEQ
         7YmBLCSlozkNbS0t1w1ra1EhVN3Karh7UwfCnJvO6xfEUT6OEZBrTiBWQEP42kTPFF9d
         McSc5CjRCazkarXro98lTWLvJdz0SK5vRsZ9eoURbob8qvPJYDgsVxJxKyJy13AZ5JWE
         JMsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzIqY7BNhoM9BDuvK1a8EfYbDA3nwRsvzBgjdBcoffFtsk81os/dgnF9ay2hIXrsQNSTc82e1WaJRz7ceZCL+A1RUKAuSyKwkdzcAVqv2FKlg9O32lRz1oYnqw4Mdq67OvrXQGHQ==
X-Gm-Message-State: AOJu0YxhPEZWMmpLaTtaGfeWfGdHdw04DDMUiiCpC/4f15q/1LsONkl5
	5smrkXaS7tgJUF9Sd1oNtD1NqDs11QVfShs3shjHK/R5MIGkKwGo
X-Google-Smtp-Source: AGHT+IFK1XZXfQ8hTQX6Z6GPHvE2aAl5JPwa1niHNSnk0qXQV2f2tcR+rJ+hBhXdB1G3pckdQZufqg==
X-Received: by 2002:a50:9f6a:0:b0:574:ec8a:5267 with SMTP id 4fb4d7f45d1cf-57a3653bb47mr8726674a12.31.1717513083751;
        Tue, 04 Jun 2024 07:58:03 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b991a6sm7474027a12.7.2024.06.04.07.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 07:58:03 -0700 (PDT)
Message-ID: <5c4800f4-3345-415b-b4e0-0099f1d22770@gmail.com>
Date: Tue, 4 Jun 2024 16:58:01 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iio: light: ROHM BH1745 colour sensor
To: Mudit Sharma <muditsharma.info@gmail.com>, ivan.orlov0322@gmail.com,
 jic23@kernel.org, lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240603162122.165943-1-muditsharma.info@gmail.com>
 <20240603162122.165943-2-muditsharma.info@gmail.com>
 <39710806-3151-4b57-9af4-c0b4a4d21c28@gmail.com>
 <c0732554-0742-444b-910d-55052e2c0f92@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <c0732554-0742-444b-910d-55052e2c0f92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/06/2024 16:24, Mudit Sharma wrote:
> On 04/06/2024 00:10, Javier Carrasco wrote:
>> On 03/06/2024 18:21, Mudit Sharma wrote:
>>> Add support for BH1745, which is an I2C colour sensor with red, green,
>>> blue and clear channels. It has a programmable active low interrupt pin.
>>> Interrupt occurs when the signal from the selected interrupt source
>>> channel crosses set interrupt threshold high or low level.
>>>
>>> This driver includes device attributes to configure the following:
>>> - Interrupt pin latch: The interrupt pin can be configured to
>>>    be latched (until interrupt register (0x60) is read or initialized)
>>>    or update after each measurement.
>>> - Interrupt source: The colour channel that will cause the interrupt
>>>    when channel will cross the set threshold high or low level.
>>>
>>> This driver also includes device attributes to present valid
>>> configuration options/values for:
>>> - Integration time
>>> - Interrupt colour source
>>> - Hardware gain
>>>
>>> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
>>
>> Hi Mudit,
>>
>> a few minor comments inline.
>>
>>> ---
>>> v1->v2:
>>> - No changes
>>>
>>>   drivers/iio/light/Kconfig  |  12 +
>>>   drivers/iio/light/Makefile |   1 +
>>>   drivers/iio/light/bh1745.c | 879 +++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 892 insertions(+)
>>>   create mode 100644 drivers/iio/light/bh1745.c
>>>
>>> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
>>> index 9a587d403118..6e0bd2addf9e 100644
>>> --- a/drivers/iio/light/Kconfig
>>> +++ b/drivers/iio/light/Kconfig
>>> @@ -114,6 +114,18 @@ config AS73211
>>>        This driver can also be built as a module.  If so, the module
>>>        will be called as73211.
>>>   +config BH1745
>>> +    tristate "ROHM BH1745 colour sensor"
>>> +    depends on I2C
>>> +    select REGMAP_I2C
>>> +    select IIO_BUFFER
>>> +    select IIO_TRIGGERED_BUFFER
>>> +    help
>>> +      Say Y here to build support for the ROHM bh1745 colour sensor.
>>> +
>>> +      To compile this driver as a module, choose M here: the module
>>> will
>>> +      be called bh1745.
>>> +
>>>   config BH1750
>>>       tristate "ROHM BH1750 ambient light sensor"
>>>       depends on I2C
>>> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
>>> index a30f906e91ba..939a701a06ac 100644
>>> --- a/drivers/iio/light/Makefile
>>> +++ b/drivers/iio/light/Makefile
>>> @@ -13,6 +13,7 @@ obj-$(CONFIG_APDS9300)        += apds9300.o
>>>   obj-$(CONFIG_APDS9306)        += apds9306.o
>>>   obj-$(CONFIG_APDS9960)        += apds9960.o
>>>   obj-$(CONFIG_AS73211)        += as73211.o
>>> +obj-$(CONFIG_BH1745)        += bh1745.o
>>>   obj-$(CONFIG_BH1750)        += bh1750.o
>>>   obj-$(CONFIG_BH1780)        += bh1780.o
>>>   obj-$(CONFIG_CM32181)        += cm32181.o
>>> diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
>>> new file mode 100644
>>> index 000000000000..a7b660a1bdc8
>>> --- /dev/null
>>> +++ b/drivers/iio/light/bh1745.c
>>> @@ -0,0 +1,879 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * ROHM BH1745 digital colour sensor driver
>>> + *
>>> + * Copyright (C) Mudit Sharma <muditsharma.info@gmail.com>
>>> + *
>>> + * 7-bit I2C slave addresses:
>>> + *  0x38 (ADDR pin low)
>>> + *  0x39 (ADDR pin high)
>>> + *
>>> + */
>>> +
>>> +#include <linux/i2c.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/util_macros.h>
>>> +#include <linux/iio/events.h>
>>> +#include <linux/regmap.h>
>>> +
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/sysfs.h>
>>> +#include <linux/iio/trigger.h>
>>> +#include <linux/iio/trigger_consumer.h>
>>> +#include <linux/iio/triggered_buffer.h>
>>> +
>>> +#define BH1745_MOD_NAME "bh1745"
>>
>> Given that this define is only used in one place, using the string
>> directly is common practice in iio.
>>
>>> +
>>> +/* BH1745 config regs */
>>> +#define BH1745_SYS_CTRL 0x40
>>> +
>>> +#define BH1745_MODE_CTRL_1 0x41
>>> +#define BH1745_MODE_CTRL_2 0x42
>>> +#define BH1745_MODE_CTRL_3 0x44
>>> +
>>> +#define BH1745_INTR 0x60
>>> +#define BH1745_INTR_STATUS BIT(7)
>>> +
>>> +#define BH1745_PERSISTENCE 0x61
>>> +
>>> +#define BH1745_TH_LSB 0X62
>>> +#define BH1745_TH_MSB 0X63
>>> +
>>> +#define BH1745_TL_LSB 0X64
>>> +#define BH1745_TL_MSB 0X65
>>> +
>>> +#define BH1745_THRESHOLD_MAX 0xFFFF
>>> +#define BH1745_THRESHOLD_MIN 0x0
>>> +
>>> +#define BH1745_MANU_ID 0X92
>>> +
>>> +/* BH1745 output regs */
>>> +#define BH1745_R_LSB 0x50
>>> +#define BH1745_R_MSB 0x51
>>> +#define BH1745_G_LSB 0x52
>>> +#define BH1745_G_MSB 0x53
>>> +#define BH1745_B_LSB 0x54
>>> +#define BH1745_B_MSB 0x55
>>> +#define BH1745_CLR_LSB 0x56
>>> +#define BH1745_CLR_MSB 0x57
>>> +
>>> +#define BH1745_SW_RESET BIT(7)
>>> +#define BH1745_INT_RESET BIT(6)
>>> +
>>> +#define BH1745_MEASUREMENT_TIME_MASK GENMASK(2, 0)
>>> +
>>> +#define BH1745_RGBC_EN BIT(4)
>>> +
>>> +#define BH1745_ADC_GAIN_MASK GENMASK(1, 0)
>>> +
>>> +#define BH1745_INT_ENABLE BIT(0)
>>> +#define BH1745_INT_SIGNAL_ACTIVE BIT(7)
>>> +
>>> +#define BH1745_INT_SIGNAL_LATCHED BIT(4)
>>> +#define BH1745_INT_SIGNAL_LATCH_OFFSET 4
>>> +
>>> +#define BH1745_INT_SOURCE_MASK GENMASK(3, 2)
>>> +#define BH1745_INT_SOURCE_OFFSET 2
>>> +
>>> +#define BH1745_INT_TIME_AVAILABLE "0.16 0.32 0.64 1.28 2.56 5.12"
>>> +#define BH1745_HARDWAREGAIN_AVAILABLE "1 2 16"
>>> +#define BH1745_INT_COLOUR_CHANNEL_AVAILABLE \
>>> +    "0 (Red Channel) 1 (Green Channel) 2 (Blue channel) 3 (Clear
>>> channel)"
>>> +
>>> +static const int bh1745_int_time[][2] = {
>>> +    { 0, 160000 }, /* 160 ms */
>>> +    { 0, 320000 }, /* 320 ms */
>>> +    { 0, 640000 }, /* 640 ms */
>>> +    { 1, 280000 }, /* 1280 ms */
>>> +    { 2, 560000 }, /* 2560 ms */
>>> +    { 5, 120000 }, /* 5120 ms */
>>> +};
>>> +
>>> +static const u8 bh1745_gain_factor[] = { 1, 2, 16 };
>>> +
>>> +enum {
>>> +    BH1745_INT_SOURCE_RED,
>>> +    BH1745_INT_SOURCE_GREEN,
>>> +    BH1745_INT_SOURCE_BLUE,
>>> +    BH1745_INT_SOURCE_CLEAR,
>>> +} bh1745_int_source;
>>> +
>>> +enum {
>>> +    BH1745_ADC_GAIN_1X,
>>> +    BH1745_ADC_GAIN_2X,
>>> +    BH1745_ADC_GAIN_16X,
>>> +} bh1745_gain;
>>> +
>>> +enum {
>>> +    BH1745_MEASUREMENT_TIME_160MS,
>>> +    BH1745_MEASUREMENT_TIME_320MS,
>>> +    BH1745_MEASUREMENT_TIME_640MS,
>>> +    BH1745_MEASUREMENT_TIME_1280MS,
>>> +    BH1745_MEASUREMENT_TIME_2560MS,
>>> +    BH1745_MEASUREMENT_TIME_5120MS,
>>> +} bh1745_measurement_time;
>>> +
>>> +enum {
>>> +    BH1745_PRESISTENCE_UPDATE_TOGGLE,
>>> +    BH1745_PRESISTENCE_UPDATE_EACH_MEASUREMENT,
>>> +    BH1745_PRESISTENCE_UPDATE_FOUR_MEASUREMENT,
>>> +    BH1745_PRESISTENCE_UPDATE_EIGHT_MEASUREMENT,
>>> +} bh1745_presistence_value;
>>> +
>>> +struct bh1745_data {
>>> +    struct mutex lock;
>>> +    struct regmap *regmap;
>>> +    struct i2c_client *client;
>>> +    struct iio_trigger *trig;
>>> +    u8 mode_ctrl1;
>>> +    u8 mode_ctrl2;
>>> +    u8 int_src;
>>> +    u8 int_latch;
>>> +    u8 interrupt;
>>> +};
>>> +
>>> +static const struct regmap_range bh1745_volatile_ranges[] = {
>>> +    regmap_reg_range(BH1745_MODE_CTRL_2, BH1745_MODE_CTRL_2), /*
>>> VALID */
>>> +    regmap_reg_range(BH1745_R_LSB, BH1745_CLR_MSB), /* Data */
>>> +    regmap_reg_range(BH1745_INTR, BH1745_INTR), /* Interrupt */
>>> +};
>>> +
>>> +static const struct regmap_access_table bh1745_volatile_regs = {
>>> +    .yes_ranges = bh1745_volatile_ranges,
>>> +    .n_yes_ranges = ARRAY_SIZE(bh1745_volatile_ranges),
>>> +};
>>> +
>>> +static const struct regmap_range bh1745_read_ranges[] = {
>>> +    regmap_reg_range(BH1745_SYS_CTRL, BH1745_MODE_CTRL_2),
>>> +    regmap_reg_range(BH1745_R_LSB, BH1745_CLR_MSB),
>>> +    regmap_reg_range(BH1745_INTR, BH1745_INTR),
>>> +    regmap_reg_range(BH1745_PERSISTENCE, BH1745_TL_MSB),
>>> +    regmap_reg_range(BH1745_MANU_ID, BH1745_MANU_ID),
>>> +};
>>> +
>>> +static const struct regmap_access_table bh1745_ro_regs = {
>>> +    .yes_ranges = bh1745_read_ranges,
>>> +    .n_yes_ranges = ARRAY_SIZE(bh1745_read_ranges),
>>> +};
>>> +
>>> +static const struct regmap_range bh1745_writable_ranges[] = {
>>> +    regmap_reg_range(BH1745_SYS_CTRL, BH1745_MODE_CTRL_2),
>>> +    regmap_reg_range(BH1745_PERSISTENCE, BH1745_TL_MSB),
>>> +};
>>> +
>>> +static const struct regmap_access_table bh1745_wr_regs = {
>>> +    .yes_ranges = bh1745_writable_ranges,
>>> +    .n_yes_ranges = ARRAY_SIZE(bh1745_writable_ranges),
>>> +};
>>> +
>>> +static const struct regmap_config bh1745_regmap = {
>>> +    .reg_bits = 8,
>>> +    .val_bits = 8,
>>> +    .max_register = BH1745_MANU_ID,
>>> +    .cache_type = REGCACHE_RBTREE,
>>> +    .volatile_table = &bh1745_volatile_regs,
>>> +    .wr_table = &bh1745_wr_regs,
>>> +    .rd_table = &bh1745_ro_regs,
>>> +};
>>> +
>>> +static const struct iio_event_spec bh1745_event_spec[] = {
>>> +    {
>>> +        .type = IIO_EV_TYPE_THRESH,
>>> +        .dir = IIO_EV_DIR_RISING,
>>> +        .mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
>>> +    },
>>> +    {
>>> +        .type = IIO_EV_TYPE_THRESH,
>>> +        .dir = IIO_EV_DIR_FALLING,
>>> +        .mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
>>> +    },
>>> +    {
>>> +        .type = IIO_EV_TYPE_THRESH,
>>> +        .dir = IIO_EV_DIR_EITHER,
>>> +        .mask_shared_by_type = BIT(IIO_EV_INFO_PERIOD),
>>> +    },
>>> +};
>>> +
>>> +#define BH1745_CHANNEL(_colour, _si,
>>> _addr)                                   \
>>> +   
>>> {                                                                     \
>>> +        .type = IIO_INTENSITY, .modified = 1,                         \
>>> +        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                 \
>>> +        .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN) | \
>>> +                        BIT(IIO_CHAN_INFO_INT_TIME),      \
>>> +        .event_spec = bh1745_event_spec,                              \
>>> +        .num_event_specs = ARRAY_SIZE(bh1745_event_spec),             \
>>> +        .channel2 = IIO_MOD_LIGHT_##_colour, .address = _addr,        \
>>> +        .scan_index = _si,                                            \
>>> +        .scan_type = {                                                \
>>> +            .sign = 'u',                                          \
>>> +            .realbits = 16,                                       \
>>> +            .storagebits = 16,                                    \
>>> +            .endianness = IIO_CPU,                                \
>>> +        },                                                            \
>>> +    }
>>> +
>>> +static const struct iio_chan_spec bh1745_channels[] = {
>>> +    BH1745_CHANNEL(RED, 0, BH1745_R_LSB),
>>> +    BH1745_CHANNEL(GREEN, 1, BH1745_G_LSB),
>>> +    BH1745_CHANNEL(BLUE, 2, BH1745_B_LSB),
>>> +    BH1745_CHANNEL(CLEAR, 3, BH1745_CLR_LSB),
>>> +    IIO_CHAN_SOFT_TIMESTAMP(4),
>>> +};
>>> +
>>> +static int bh1745_write_value(struct bh1745_data *data, u8 reg, void
>>> *value,
>>> +                  size_t len)
>>> +{
>>
>> The initial assignment is unnecessary, as a new assignment is made
>> immediately. This applies to several declarations of ret in this driver,
>> but not always (e.g. bh1745_setup_trigger()).
>>
>>> +    int ret = 0;
>>> +
>>> +    ret = regmap_bulk_write(data->regmap, reg, value, len);
>>> +    if (ret < 0) {
>>> +        dev_err(&data->client->dev,
>>> +            "Failed to write to sensor. Reg: 0x%x\n", reg);
>>> +        return ret;
>>> +    }
>>
>> Nit: black line before return (it applies to several functions in this
>> driver, but again, not in all of them).
> 
> Hi Javier,
> 
> Thank you for the review on this.
> 
> Can you please point me to resource/section of code style guide for
> reference which talks about new line before 'return'.
> 
> Best regards,
> Mudit Sharma
> 
> 
> 

AFAIK that is not written in stone, but many common practices are not
documented anywhere (e.g. names of error/ret variables). They just copy
what the majority of the code in that subsystem does. There is indeed a
tendency to add a blank line before the last (unconditional, not
labeled) return, but I am sure that some code does not follow that.

Having said that, I don't have a strong opinion (it was a nitpick) on
that, but what I would definitely recommend you is following **some**
pattern. There are some functions where you added a blank line, and some
others (the majority, I think), where you didn't. Given that this is new
code, uniformity would be appreciated.

Unless an IIO maintainer (I am NOT one) says otherwise, I would find
both approaches (blank/no line) reasonable, even though I like the blank
line in that particular case :)

Best regards,
Javier Carrasco

