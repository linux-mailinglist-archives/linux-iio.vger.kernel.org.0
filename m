Return-Path: <linux-iio+bounces-7098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AD691DE1B
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 13:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7D21C226F8
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 11:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3EA147C60;
	Mon,  1 Jul 2024 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzaC3ius"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05E13F439;
	Mon,  1 Jul 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833581; cv=none; b=W+GAu12gTk7qgheeWSFx2xsf7ujKerDdfou9FNG73Luv+v88SdN/sngKLj4zYWuouvfVu7/IkwZJ8Q0Swb7UdnzjizazXJQzmLcLky9RRQN06ySvWwMw9V7Wb4DLDlBCA40Ci9j7g2tgUHQ1vRqTdd+5msdtnrpTyHt3MXNT7ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833581; c=relaxed/simple;
	bh=+Q1FOXO3hTsfJ/g99tUcpIIOX54l8r0ijKj8Lj15uFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCCNlyJl2cT24CkTnvTF0DqW4TPsMvpGZHkyqaUUiG3asTy8pmZC8ULpf8RAP6oIsk9+R7nKBscGqZ2EM4Lu5pMB8SNeXge61qok3r++DZlJqZPzjURkavdvj+P2+mlrFWCIvDCGrt3Rpd3GKPUaaoZrtbcsSzFwrvKm3CtpQVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzaC3ius; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52e7145c63cso3376080e87.0;
        Mon, 01 Jul 2024 04:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719833577; x=1720438377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1q7o4QZFWbpnE6v0v0RClVEwphM17CeKnmBdm0hvAY=;
        b=IzaC3iusGLj7+1oSQ9d2LyOFbhghtxmJw1wfO9JjYYnnUEWUox7B9IOEidOXTVU2k6
         KyNQBx20HfEl4pcpaBqd2FkhFOwvRMpulrYGLa3Las7UHhKRDcLHnjBjvL9SH7lrWiA1
         2H2z4OM0oIhynF7LaddCAm839qMep4/yhO7ytRoO91dI6Fxq7w5tu80B3NKOzWHwIqs7
         PpTwg/O4aiBo9Z5NSlxsYVa/Xplzwz9IKvMwWKPvZhMwlRp1JjSbr8mG1KpIZlAsojDg
         mOGNQ8JSI4neG9GQqoR9ILoT6drAGQnHjTTOMiwtil7R6RmH7aGHX1MX9K81xptWJx+t
         n1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719833577; x=1720438377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1q7o4QZFWbpnE6v0v0RClVEwphM17CeKnmBdm0hvAY=;
        b=hZde3iA5KG23ecrWKiq+HfIlwFdDAPOj6ybPfoTXyxRkXWg2touQPWjFbvnicBdsds
         ablSvej6MZh5Hw05TQj7dDnf+5E/9K2DlPpyKEyKv50MJdsIa7D4s2stP8YcbvzzG+ub
         qotS2qV0U7oPb1tBsFWZ/oW1BsQSTOKYk9RWoLIbTaiIUqYwcZSIEsBhf5839ZjkQt3h
         auG71AEJbniwQbjzxEiyp8lWK2avJi2vGecuK958QqkmziYLeHZnAn1NKCBu+5hrvf0K
         eqtPiHSTxm5P1vmHI4V9x5l8flZkyejaAETzbsKNBfiM79dbvkU3LZ7Vo6QyYIYJMBLz
         bc3w==
X-Forwarded-Encrypted: i=1; AJvYcCWjL9Qum0auQ3C0v6bnWsSq4+nAcGAvO8Iack1KZKqcBZdf59179PcU6YgWnKA8AK91KgfFkiqWudJun01E4u8pXpwKIdwr8Yd4e/noydJlBtFhF7c5ZZc6AloM1WeJshhN1orocg==
X-Gm-Message-State: AOJu0Yw9fOTVk71cW7dquBdxaU2J14JDPUdQMP07PDOsWBjNsBsnhtwY
	OHWdykT62dP1vyVwzy0CwQK7BUHGq18SVZ8LA8tbHjokY2AWiJOm
X-Google-Smtp-Source: AGHT+IGEfuYeKgtv0UI0nNTTXGx7f22daVjv42uCNCKLYHqPiUoPEeZtHWACm5Uo0Daxlu85nUgVYQ==
X-Received: by 2002:a19:9153:0:b0:52c:e1dd:fc22 with SMTP id 2adb3069b0e04-52e7b92f852mr2072164e87.32.1719833574342;
        Mon, 01 Jul 2024 04:32:54 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab1025esm1361410e87.88.2024.07.01.04.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 04:32:53 -0700 (PDT)
Message-ID: <98c87420-e88a-43ca-a8af-2fa751b85d4f@gmail.com>
Date: Mon, 1 Jul 2024 14:32:52 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] iio: light: ROHM BH1745 colour sensor
To: Mudit Sharma <muditsharma.info@gmail.com>, jic23@kernel.org,
 lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Ivan Orlov <ivan.orlov0322@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
References: <20240625220328.558809-1-muditsharma.info@gmail.com>
 <20240625220328.558809-2-muditsharma.info@gmail.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240625220328.558809-2-muditsharma.info@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/24 01:03, Mudit Sharma wrote:
> Add support for BH1745, which is an I2C colour sensor with red, green,
> blue and clear channels. It has a programmable active low interrupt
> pin. Interrupt occurs when the signal from the selected interrupt
> source channel crosses set interrupt threshold high or low level.
> 
> Interrupt source for the device can be configured by enabling the
> corresponding event. Interrupt latch is always enabled when setting
> up interrupt.
> 
> Add myself as the maintainer for this driver in MAINTAINERS.
> 
> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
> Reviewed-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> v5->v6:
> - Fix typo
> - Fix Indentation
> - Drop read in bh1745_set_trigger_state() as configuring all the value
> v4->v5:
> - Provide scale instead of HW gain
>    - Use GTS helpers
> - Code style fixes
> - Add check for part ID during probe
> - Always enable latch when enabling interrupt
> - Use devm_add_action_or_reset() and drop bh1745_remove() function
> - Drop custom DEVICE_ATTR and provide related read_avail and setup
>    interrupt source with event_config
> - Make buffer support independent of IRQ
> - Add power regulator handing with devm_regulator_get_enable()
> - Drop read and write wrappers and use regmap functions directly
> - Add MODULE_DEVICE_TABLE for of_device_id
> v3->v4:
> - Fix formatting:
>    - Remove redundant new line
>    - Use '0x' rather than '0X'
> v2->v3:
> - Squash commit for addition to MAINTAINERS
> - Fix code style for consistency:
>    - New line before last 'return'
>    - Use variable name 'value' instead of 'val' in
>      'bh1745_set_trigger_state()'
>    - Align function parameters to match parenthesis
>    - Avoid use of magic number
> - Use named enum instead of anonymous enum
> - Use 'guard(mutex)(&data->lock)' instead of 'mutex_lock()'
>    'mutex_unlock()'
> - Only initialize 'ret' and 'value' when necessary
> - Fix and optimize logic for `in_interrupt_latch_store()`
> - Fix error handling in irq , trigger handlers and dev attribute for
>    latch
> v1->v2:
> - No changes
> 
>   MAINTAINERS                |   6 +
>   drivers/iio/light/Kconfig  |  13 +
>   drivers/iio/light/Makefile |   1 +
>   drivers/iio/light/bh1745.c | 931 +++++++++++++++++++++++++++++++++++++
>   4 files changed, 951 insertions(+)
>   create mode 100644 drivers/iio/light/bh1745.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ca8f35dfe03..e9ff6f465e7f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19404,6 +19404,12 @@ S:	Supported
>   F:	drivers/power/supply/bd99954-charger.c
>   F:	drivers/power/supply/bd99954-charger.h
>   
> +ROHM BH1745 COLOUR SENSOR
> +M:	Mudit Sharma <muditsharma.info@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/light/bh1745.c
> +
>   ROHM BH1750 AMBIENT LIGHT SENSOR DRIVER
>   M:	Tomasz Duszynski <tduszyns@gmail.com>
>   S:	Maintained
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 9a587d403118..6cde702fa78d 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -114,6 +114,19 @@ config AS73211
>   	 This driver can also be built as a module.  If so, the module
>   	 will be called as73211.
>   
> +config BH1745
> +	tristate "ROHM BH1745 colour sensor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select IIO_GTS_HELPER
> +	help
> +	  Say Y here to build support for the ROHM bh1745 colour sensor.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called bh1745.
> +
>   config BH1750
>   	tristate "ROHM BH1750 ambient light sensor"
>   	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index a30f906e91ba..939a701a06ac 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_APDS9300)		+= apds9300.o
>   obj-$(CONFIG_APDS9306)		+= apds9306.o
>   obj-$(CONFIG_APDS9960)		+= apds9960.o
>   obj-$(CONFIG_AS73211)		+= as73211.o
> +obj-$(CONFIG_BH1745)		+= bh1745.o
>   obj-$(CONFIG_BH1750)		+= bh1750.o
>   obj-$(CONFIG_BH1780)		+= bh1780.o
>   obj-$(CONFIG_CM32181)		+= cm32181.o
> diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
> new file mode 100644
> index 000000000000..8412d5da3019
> --- /dev/null
> +++ b/drivers/iio/light/bh1745.c
> @@ -0,0 +1,931 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ROHM BH1745 digital colour sensor driver
> + *
> + * Copyright (C) Mudit Sharma <muditsharma.info@gmail.com>
> + *
> + * 7-bit I2C slave addresses:
> + *  0x38 (ADDR pin low)
> + *  0x39 (ADDR pin high)
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/util_macros.h>
> +#include <linux/iio/events.h>
> +#include <linux/regmap.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/iio-gts-helper.h>
> +
> +/* BH1745 config regs */
> +#define BH1745_SYS_CTRL 0x40
> +
> +#define BH1745_MODE_CTRL_1 0x41
> +#define BH1745_MODE_CTRL_2 0x42
> +#define BH1745_MODE_CTRL_3 0x44
> +
> +#define BH1745_INTR 0x60
> +#define BH1745_INTR_STATUS BIT(7)
> +
> +#define BH1745_PERSISTENCE 0x61
> +
> +#define BH1745_TH_LSB 0x62
> +#define BH1745_TH_MSB 0x63
> +
> +#define BH1745_TL_LSB 0x64
> +#define BH1745_TL_MSB 0x65
> +
> +#define BH1745_MANU_ID 0x92
> +
> +/* BH1745 output regs */
> +#define BH1745_RED_LSB 0x50
> +#define BH1745_RED_MSB 0x51
> +#define BH1745_GREEN_LSB 0x52
> +#define BH1745_GREEN_MSB 0x53
> +#define BH1745_BLUE_LSB 0x54
> +#define BH1745_BLUE_MSB 0x55
> +#define BH1745_CLEAR_LSB 0x56
> +#define BH1745_CLEAR_MSB 0x57
> +
> +#define BH1745_SW_RESET BIT(7)
> +#define BH1745_INT_RESET BIT(6)
> +
> +#define BH1745_MEASUREMENT_TIME_MASK GENMASK(2, 0)
> +
> +#define BH1745_RGBC_EN BIT(4)
> +
> +#define BH1745_ADC_GAIN_MASK GENMASK(1, 0)
> +
> +#define BH1745_INT_ENABLE BIT(0)
> +#define BH1745_INT_SIGNAL_ACTIVE BIT(7)
> +
> +#define BH1745_INT_SIGNAL_LATCHED BIT(4)
> +
> +#define BH1745_INT_SOURCE_MASK GENMASK(3, 2)
> +
> +#define BH1745_PART_ID 0x0B
> +#define BH1745_PART_ID_MASK GENMASK(5, 0)
> +
> +// From 16x max HW gain and 32x max integration time
> +#define BH1745_MAX_GAIN 512
> +
> +static const int bh1745_int_time[][2] = {
> +	{ 0, 160000 }, /* 160 ms */
> +	{ 0, 320000 }, /* 320 ms */
> +	{ 0, 640000 }, /* 640 ms */
> +	{ 1, 280000 }, /* 1280 ms */
> +	{ 2, 560000 }, /* 2560 ms */
> +	{ 5, 120000 }, /* 5120 ms */
> +};
> +
> +static const u8 bh1745_gain_factor[] = { 1, 2, 16 };
> +
> +static const int bh1745_int_time_us[] = { 160000,  320000,  640000,
> +					  1280000, 2560000, 5120000 };

I am not sure why you need these tables above? Can't the iio_gts do all 
the conversions from register-value to int time/gain and int-time/gain 
to register value, as well as the checks for supported values? Ideally, 
you would not need anything else but the bh1745_itimes and the 
bh1745_gain tables below - they should contain all the same information.

> +
> +enum bh1745_int_source {
> +	BH1745_INT_SOURCE_RED,
> +	BH1745_INT_SOURCE_GREEN,
> +	BH1745_INT_SOURCE_BLUE,
> +	BH1745_INT_SOURCE_CLEAR,
> +};
> +
> +enum bh1745_gain {
> +	BH1745_ADC_GAIN_1X,
> +	BH1745_ADC_GAIN_2X,
> +	BH1745_ADC_GAIN_16X,
> +};
> +
> +enum bh1745_measurement_time {
> +	BH1745_MEASUREMENT_TIME_160MS,
> +	BH1745_MEASUREMENT_TIME_320MS,
> +	BH1745_MEASUREMENT_TIME_640MS,
> +	BH1745_MEASUREMENT_TIME_1280MS,
> +	BH1745_MEASUREMENT_TIME_2560MS,
> +	BH1745_MEASUREMENT_TIME_5120MS,
> +};
> +
> +enum bh1745_presistence_value {
> +	BH1745_PRESISTENCE_UPDATE_TOGGLE,
> +	BH1745_PRESISTENCE_UPDATE_EACH_MEASUREMENT,
> +	BH1745_PRESISTENCE_UPDATE_FOUR_MEASUREMENT,
> +	BH1745_PRESISTENCE_UPDATE_EIGHT_MEASUREMENT,
> +};
> +
> +static const struct iio_gain_sel_pair bh1745_gain[] = {
> +	GAIN_SCALE_GAIN(1, BH1745_ADC_GAIN_1X),
> +	GAIN_SCALE_GAIN(2, BH1745_ADC_GAIN_2X),
> +	GAIN_SCALE_GAIN(16, BH1745_ADC_GAIN_16X),
> +};
> +
> +static const struct iio_itime_sel_mul bh1745_itimes[] = {
> +	GAIN_SCALE_ITIME_US(5120000, BH1745_MEASUREMENT_TIME_5120MS, 32),
> +	GAIN_SCALE_ITIME_US(2560000, BH1745_MEASUREMENT_TIME_2560MS, 16),
> +	GAIN_SCALE_ITIME_US(1280000, BH1745_MEASUREMENT_TIME_1280MS, 8),
> +	GAIN_SCALE_ITIME_US(640000, BH1745_MEASUREMENT_TIME_640MS, 4),
> +	GAIN_SCALE_ITIME_US(320000, BH1745_MEASUREMENT_TIME_320MS, 2),
> +	GAIN_SCALE_ITIME_US(160000, BH1745_MEASUREMENT_TIME_160MS, 1),
> +};
> +
> +struct bh1745_data {
> +	/*
> +	 * Lock to prevent device setting update or read before related
> +	 * calculations or event push are completed
> +	 */
> +	struct mutex lock;
> +	struct regmap *regmap;
> +	struct i2c_client *client;
> +	struct iio_trigger *trig;
> +	struct iio_gts gts;
> +	u8 int_src;
> +};
> +
> +static const struct regmap_range bh1745_volatile_ranges[] = {
> +	regmap_reg_range(BH1745_MODE_CTRL_2, BH1745_MODE_CTRL_2), /* VALID */
> +	regmap_reg_range(BH1745_RED_LSB, BH1745_CLEAR_MSB), /* Data */
> +	regmap_reg_range(BH1745_INTR, BH1745_INTR), /* Interrupt */
> +};
> +
> +static const struct regmap_access_table bh1745_volatile_regs = {
> +	.yes_ranges = bh1745_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(bh1745_volatile_ranges),
> +};
> +
> +static const struct regmap_range bh1745_read_ranges[] = {
> +	regmap_reg_range(BH1745_SYS_CTRL, BH1745_MODE_CTRL_2),
> +	regmap_reg_range(BH1745_RED_LSB, BH1745_CLEAR_MSB),
> +	regmap_reg_range(BH1745_INTR, BH1745_INTR),
> +	regmap_reg_range(BH1745_PERSISTENCE, BH1745_TL_MSB),
> +	regmap_reg_range(BH1745_MANU_ID, BH1745_MANU_ID),
> +};
> +
> +static const struct regmap_access_table bh1745_ro_regs = {
> +	.yes_ranges = bh1745_read_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(bh1745_read_ranges),
> +};
> +
> +static const struct regmap_range bh1745_writable_ranges[] = {
> +	regmap_reg_range(BH1745_SYS_CTRL, BH1745_MODE_CTRL_2),
> +	regmap_reg_range(BH1745_INTR, BH1745_INTR),
> +	regmap_reg_range(BH1745_PERSISTENCE, BH1745_TL_MSB),
> +};
> +
> +static const struct regmap_access_table bh1745_wr_regs = {
> +	.yes_ranges = bh1745_writable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(bh1745_writable_ranges),
> +};
> +
> +static const struct regmap_config bh1745_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = BH1745_MANU_ID,
> +	.cache_type = REGCACHE_RBTREE,
> +	.volatile_table = &bh1745_volatile_regs,
> +	.wr_table = &bh1745_wr_regs,
> +	.rd_table = &bh1745_ro_regs,

I am not 100% sure what this does. (Let's say it is just my ignorance 
:)). Does the 'ro' in 'bh1745_ro_regs' stand for read-only?

If so, shouldn't the read-inly registers be marked as "not writable", 
which would be adding them in .wr_table in 'no_ranges'? Also, what is 
the idea of the 'wr_regs'?

> +};
> +
> +static const struct iio_event_spec bh1745_event_spec[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_shared_by_type = BIT(IIO_EV_INFO_PERIOD),
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +#define BH1745_CHANNEL(_colour, _si, _addr)                             \
> +	{                                                               \
> +		.type = IIO_INTENSITY, .modified = 1,                   \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE) |   \
> +					   BIT(IIO_CHAN_INFO_INT_TIME), \
> +		.info_mask_shared_by_all_available =                    \
> +			BIT(IIO_CHAN_INFO_SCALE) |                      \
> +			BIT(IIO_CHAN_INFO_INT_TIME),                    \
> +		.event_spec = bh1745_event_spec,                        \
> +		.num_event_specs = ARRAY_SIZE(bh1745_event_spec),       \
> +		.channel2 = IIO_MOD_LIGHT_##_colour, .address = _addr,  \
> +		.scan_index = _si,                                      \
> +		.scan_type = {                                          \
> +			.sign = 'u',                                    \
> +			.realbits = 16,                                 \
> +			.storagebits = 16,                              \
> +			.endianness = IIO_CPU,                          \
> +		},                                                      \
> +	}
> +
> +static const struct iio_chan_spec bh1745_channels[] = {
> +	BH1745_CHANNEL(RED, 0, BH1745_RED_LSB),
> +	BH1745_CHANNEL(GREEN, 1, BH1745_GREEN_LSB),
> +	BH1745_CHANNEL(BLUE, 2, BH1745_BLUE_LSB),
> +	BH1745_CHANNEL(CLEAR, 3, BH1745_CLEAR_LSB),
> +	IIO_CHAN_SOFT_TIMESTAMP(4),
> +};
> +
> +static int bh1745_reset(struct bh1745_data *data)
> +{
> +	int ret;
> +	int value;
> +
> +	ret = regmap_read(data->regmap, BH1745_SYS_CTRL, &value);
> +	if (ret)
> +		return ret;
> +
> +	value |= (BH1745_SW_RESET | BH1745_INT_RESET);
> +
> +	return regmap_write(data->regmap, BH1745_SYS_CTRL, value);

Would it work if you used regmap_write_bits() instead?

... Sorry, my reviewing time is out :/ I may continue later but no need 
to wait for my comments if I am not responding. I've too much stuff 
piling on :(


Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


