Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F07185FF6
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 22:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgCOVX4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 17:23:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46262 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbgCOVXz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Mar 2020 17:23:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id w16so2380512wrv.13;
        Sun, 15 Mar 2020 14:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=c5f8KSoSXv25XiBn6ExagRE09UnI67n27e/uQQAzS8c=;
        b=dyqN8429t2VTwcP/UOwzn19V2k2txUdz28TM6Mgs5M91bvYfuhkbzhsg9+mZd3AFoi
         xWil7/0JS3JNjTt1mJFPLPZ5/zpCITPC7fhZ0rnfszJxb3BAe4JTwW8MJ87/YQbfv5oL
         YWJcJJHZKJBzno/zG7R8OJKdPB28ittr7gaCdKCDHVWyUrC/AQd/uhFP8NCHCIOl1qIB
         ZmNtAxoPPU9x7RRWedFWtBXFr4Rt1lsLCC3V5fj+swZpAU6GZ6RmW63OXBCkVJ0ChJyD
         xHsPzdOjp6NRKO2LXRHuj6GS/bDOCR+gqXGhCUY62aShXaI2xCT/xONkGf0GStSMee35
         3iIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=c5f8KSoSXv25XiBn6ExagRE09UnI67n27e/uQQAzS8c=;
        b=G5B0vyQcq9WqpytCCecHXiU1198SmDWER1QnKbeUrrsa+MzIPq1aDmt9ksUTg6xqHT
         A2TwOvDp1EwSymclxxAQqQv9RuKhnL/RRsVbz5QoNKCRbR5vDaHwXnMkwAiC5tdqeXaF
         GdczN76lutfgtfE0NzD2UJowvvdoUblooeZhh3EbiU/dOohaKRl58ilNXwr8kbempUU4
         22R4sdtrGKUQeRbH+6RrT3+aspeW/rk6B2DyHi0tav4eIfDmRvMXe5JNMvjLaQnU3FqD
         ZFErojMJaWFdACVhfjJ4pZuTa69ZZSI3ykJvfp4MKld1fWeUAuGXImw37Zzjbc14/1u3
         brAg==
X-Gm-Message-State: ANhLgQ1tVJtxKHAhyyoUmdyK8Qdi4L4EO8J5GLKyxwv7G8T8ZtB74yVp
        sp2Q61FeD+i+Wzi3PmEyLDYKCAwFa9c=
X-Google-Smtp-Source: ADFU+vu2mu7hPJ88Ezq6MSqkmidOSGXN7RzzP/tYfkB1m5GcHCrFDqvVGni8C3c5DPOHYAZVww+QAg==
X-Received: by 2002:a5d:440a:: with SMTP id z10mr16414715wrq.177.1584307429784;
        Sun, 15 Mar 2020 14:23:49 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F62A0.dip0.t-ipconnect.de. [91.63.98.160])
        by smtp.gmail.com with ESMTPSA id g14sm17846567wme.32.2020.03.15.14.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2020 14:23:48 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] iio: adc: mp2629: Add support for mp2629 ADC
 driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200315000013.4440-1-sravanhome@gmail.com>
 <20200315000013.4440-4-sravanhome@gmail.com>
 <20200315103706.38177792@archlinux>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <be8f706a-d734-c1a8-347f-c8861e5d02ee@gmail.com>
Date:   Sun, 15 Mar 2020 22:23:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200315103706.38177792@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 15/03/20 11:37 am, Jonathan Cameron wrote:
> On Sun, 15 Mar 2020 01:00:11 +0100
> Saravanan Sekar <sravanhome@gmail.com> wrote:
>
>> Add support for 8-bit resolution ADC readings for input power
>> supply and battery charging measurement. Provides voltage, current
>> readings to mp2629 power supply driver.
>>
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> The IIO parts seems fine (minor comments inline) but I'm not keep on
> directly accessing the internals of the mfd device info structure.
>
> To my mind that should be opaque to the child drivers so as to provide
> clear structure to any such accesses.
>
> Jonathan
>
>
>> ---
>>   drivers/iio/adc/Kconfig      |  10 ++
>>   drivers/iio/adc/Makefile     |   1 +
>>   drivers/iio/adc/mp2629_adc.c | 209 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 220 insertions(+)
>>   create mode 100644 drivers/iio/adc/mp2629_adc.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 82e33082958c..ef0c0cd31855 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -680,6 +680,16 @@ config MESON_SARADC
>>   	  To compile this driver as a module, choose M here: the
>>   	  module will be called meson_saradc.
>>   
>> +config MP2629_ADC
>> +	tristate "Monolithic MP2629 ADC driver"
>> +	depends on MFD_MP2629
>> +	help
>> +	  Say yes to have support for battery charger IC MP2629 ADC device
>> +	  accessed over I2C.
>> +
>> +	  This driver provides ADC conversion of system, input power supply
>> +	  and battery voltage & current information.
>> +
>>   config NAU7802
>>   	tristate "Nuvoton NAU7802 ADC driver"
>>   	depends on I2C
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index 919228900df9..f14416c245a6 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -64,6 +64,7 @@ obj-$(CONFIG_MCP3911) += mcp3911.o
>>   obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
>>   obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
>>   obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
>> +obj-$(CONFIG_MP2629_ADC) += mp2629_adc.o
>>   obj-$(CONFIG_MXS_LRADC_ADC) += mxs-lradc-adc.o
>>   obj-$(CONFIG_NAU7802) += nau7802.o
>>   obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
>> diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
>> new file mode 100644
>> index 000000000000..1a99196624ed
>> --- /dev/null
>> +++ b/drivers/iio/adc/mp2629_adc.c
>> @@ -0,0 +1,209 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * MP2629 Driver for ADC
>> + *
>> + * Copyright 2020 Monolithic Power Systems, Inc
>> + *
>> + * Author: Saravanan Sekar <sravanhome@gmail.com>
>> + */
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/of_device.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/machine.h>
>> +#include <linux/iio/driver.h>
>> +#include <linux/mfd/mp2629.h>
>> +
>> +#define	MP2629_REG_ADC_CTRL		0x03
>> +#define	MP2629_REG_BATT_VOLT		0x0e
>> +#define	MP2629_REG_SYSTEM_VOLT		0x0f
>> +#define	MP2629_REG_INPUT_VOLT		0x11
>> +#define	MP2629_REG_BATT_CURRENT		0x12
>> +#define	MP2629_REG_INPUT_CURRENT	0x13
>> +
>> +#define	MP2629_ADC_START		BIT(7)
>> +#define MP2629_ADC_CONTINUOUS		BIT(6)
> Odd alignment.
>
>> +
>> +#define MP2629_MAP(_mp, _mpc) IIO_MAP(#_mp, "mp2629_charger", "mp2629-"_mpc)
>> +
>> +#define MP2629_ADC_CHAN(_ch, _type) {				\
>> +	.type = _type,						\
>> +	.indexed = 1,						\
>> +	.datasheet_name = #_ch,					\
>> +	.channel = MP2629_ ## _ch,				\
>> +	.address = MP2629_REG_ ## _ch,				\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>> +}
>> +
>> +static struct iio_chan_spec mp2629_channels[] = {
>> +	MP2629_ADC_CHAN(BATT_VOLT, IIO_VOLTAGE),
>> +	MP2629_ADC_CHAN(SYSTEM_VOLT, IIO_VOLTAGE),
>> +	MP2629_ADC_CHAN(INPUT_VOLT, IIO_VOLTAGE),
>> +	MP2629_ADC_CHAN(BATT_CURRENT, IIO_CURRENT),
>> +	MP2629_ADC_CHAN(INPUT_CURRENT, IIO_CURRENT)
>> +};
>> +
>> +struct mp2629_adc {
>> +	struct mp2629_info *info;
>> +	struct device *dev;
>> +};
>> +
>> +static struct iio_map mp2629_adc_maps[] = {
>> +	MP2629_MAP(BATT_VOLT, "batt-volt"),
>> +	MP2629_MAP(SYSTEM_VOLT, "system-volt"),
>> +	MP2629_MAP(INPUT_VOLT, "input-volt"),
>> +	MP2629_MAP(BATT_CURRENT, "batt-current"),
>> +	MP2629_MAP(INPUT_CURRENT, "input-current")
>> +};
>> +
>> +static int mp2629_read_raw(struct iio_dev *indio_dev,
>> +			struct iio_chan_spec const *chan,
>> +			int *val, int *val2, long mask)
>> +{
>> +	struct mp2629_adc *adc_info = iio_priv(indio_dev);
>> +	struct mp2629_info *info = adc_info->info;
>> +	unsigned int rval;
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = regmap_read(info->regmap, chan->address, &rval);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		if (chan->address == MP2629_INPUT_VOLT)
>> +			rval &= 0x7f;
>> +		*val = rval;
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>> +		switch (chan->channel) {
>> +		case MP2629_BATT_VOLT:
>> +		case MP2629_SYSTEM_VOLT:
>> +			*val = 20;
>> +			return IIO_VAL_INT;
>> +
>> +		case MP2629_INPUT_VOLT:
>> +			*val = 60;
>> +			return IIO_VAL_INT;
>> +
>> +		case MP2629_BATT_CURRENT:
>> +			*val = 175;
>> +			*val2 = 10;
>> +			return IIO_VAL_FRACTIONAL;
>> +
>> +		case MP2629_INPUT_CURRENT:
>> +			*val = 133;
>> +			*val2 = 10;
>> +			return IIO_VAL_FRACTIONAL;
>> +
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct iio_info mp2629_adc_info = {
>> +	.read_raw = &mp2629_read_raw,
>> +};
>> +
>> +static int mp2629_adc_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct mp2629_info *info = dev_get_drvdata(dev->parent);
>> +	struct mp2629_adc *adc_info;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc_info));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	adc_info = iio_priv(indio_dev);
>> +	platform_set_drvdata(pdev, indio_dev);
>> +	adc_info->info = info;
>> +	adc_info->dev = dev;
>> +
>> +	ret = iio_map_array_register(indio_dev, mp2629_adc_maps);
>> +	if (ret) {
>> +		dev_err(dev, "IIO maps register fail: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	indio_dev->name = dev_name(dev);
>> +	indio_dev->dev.parent = dev;
>> +	indio_dev->dev.of_node = pdev->dev.of_node;
>> +	indio_dev->channels = mp2629_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(mp2629_channels);
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->info = &mp2629_adc_info;
>> +
>> +	ret = regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
>> +				MP2629_ADC_START | MP2629_ADC_CONTINUOUS,
>> +				MP2629_ADC_START | MP2629_ADC_CONTINUOUS);
>> +	if (ret) {
>> +		dev_err(dev, "adc enable fail: %d\n", ret);
>> +		goto fail_unmap;
>> +	}
>> +
>> +	ret = devm_iio_device_register(dev, indio_dev);
>> +	if (ret) {
>> +		dev_err(dev, "IIO device register fail: %d\n", ret);
>> +		goto fail_unmap;
> Should we not be turning the device off like we do in remove?
>
>> +	}
>> +
>> +	return 0;
>> +
>> +fail_unmap:
>> +	iio_map_array_unregister(indio_dev);
>> +	return ret;
>> +}
>> +
>> +static int mp2629_adc_remove(struct platform_device *pdev)
>> +{
>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> +	struct mp2629_adc *adc_info = iio_priv(indio_dev);
>> +	struct mp2629_info *info = adc_info->info;
> This mess in layering with the children directly using the parents
> regmap is a little concerning.  It means that the 3 drivers
> really aren't very well separated and can't really be reviewed
> independently (not a good thing).
>
> It might just be a question of providing a wrapper in the mfd driver
> code so we at least have some visibility that this is going on.

I had expored a wrapper in mfd driver in previous revision of patch, I 
was asked

to remove it. If wrapper is agreed then I will remove mfd mp2629_info 
struct.

>
>> +
>> +	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
>> +					 MP2629_ADC_CONTINUOUS, 0);
>> +	regmap_update_bits(info->regmap, MP2629_REG_ADC_CTRL,
>> +					 MP2629_ADC_START, 0);
>> +
>> +	iio_map_array_unregister(indio_dev);
>> +	iio_device_unregister(indio_dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id mp2629_adc_of_match[] = {
>> +	{ .compatible = "mps,mp2629_adc"},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, mp2629_adc_of_match);
>> +
>> +static struct platform_driver mp2629_adc_driver = {
>> +	.driver = {
>> +		.name = "mp2629_adc",
>> +		.of_match_table = mp2629_adc_of_match,
>> +	},
>> +	.probe		= mp2629_adc_probe,
>> +	.remove		= mp2629_adc_remove,
>> +};
>> +module_platform_driver(mp2629_adc_driver);
>> +
>> +MODULE_AUTHOR("Saravanan Sekar <sravanhome@gmail.com>");
>> +MODULE_DESCRIPTION("MP2629 ADC driver");
>> +MODULE_LICENSE("GPL");
