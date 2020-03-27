Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A62681952F0
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 09:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgC0Ice (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 04:32:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45791 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgC0Ice (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 04:32:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id t7so10289324wrw.12;
        Fri, 27 Mar 2020 01:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=20+rjJHkP5zjHWEqe7dgbhTZkAm7I7OD3XXtBy0eyQE=;
        b=UYJUPUYqgsrfEyceVAKLFPAiyxCLAVHMMp+Mjg5e3aum4pFFKzoDTAC60Il6ycwyd5
         qAc3KQA0xxYqFqN5TslW7epKsguOJnJ93xT8LYYHLkdxuXVMiTOBnXXzoSIp8n8y1/IR
         QYFyloAHPo6HMw7yDwh+C7p2O37ZxAo6WjZV0rH6XagF824vIm0snNJLOohbEPtHIb/j
         aM9/98XEOrXD2kkC6EXvFeXvfc+jxH817jmxMD9bU3E/FMcthdhvnzuE2MIGExa4ih7F
         M2UpMVjRCR7523rvIOkd7K5QO2nts3JSXmJm9/5/zRxqhmGSXTEZPrIegkRtlpQEA6+z
         SrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=20+rjJHkP5zjHWEqe7dgbhTZkAm7I7OD3XXtBy0eyQE=;
        b=IBbmqzaeMlYyiEI6bLY9vggsIPSeXfo2cP1MSRQZx0DZqN7SyRlOF38fbDfpPrKru/
         LUVUkd8HYcn6OCxvdi6V0iZnaKuvmq6K+mXJ6aqp/4cSB3VFKmDCAFHAmEN0R1Dejn9s
         hN1lXJdlR/dGvj4OWuoPBel+ePqaHhDoozNWhERBxw5vA1pzri9ziIEtUq7urFBa3G+o
         pQDe9kONmxHkQxaXCBSRdZZrIai8OHML5775AD3hT9Fw5+y5x0KIqujKLM07T3cNirM0
         nZS3NWBiGOtYFtuN8u1h2Dr2xXgOpiugK096RVwUnEnuTf37QZtuhwWyfIGjCcTRVJK4
         Hk8g==
X-Gm-Message-State: ANhLgQ0VrGmpnEM4NXGdbHB45ahRy76Ih4jGMWA3rk1AqObIiMHXVxys
        Iv/+lCW+68+zoWrevYCNOfkgV+bg
X-Google-Smtp-Source: ADFU+vvSUA0fk8D8cSwfi5ZPgVWYwVYPYFXKvKLL8ZiroYVWsolSYZHcy0wqmtOA0ENjkgQkyIXyjQ==
X-Received: by 2002:adf:f88b:: with SMTP id u11mr2746580wrp.84.1585297951285;
        Fri, 27 Mar 2020 01:32:31 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F6E13.dip0.t-ipconnect.de. [91.63.110.19])
        by smtp.gmail.com with ESMTPSA id g2sm7634023wrs.42.2020.03.27.01.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 01:32:30 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] mfd: mp2629: Add support for mps battery charger
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200322224626.13160-1-sravanhome@gmail.com>
 <20200322224626.13160-3-sravanhome@gmail.com> <20200327075541.GF603801@dell>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <a6098b6a-2b2f-5279-f9fc-85201b9aabde@gmail.com>
Date:   Fri, 27 Mar 2020 09:32:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200327075541.GF603801@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,

On 27/03/20 8:55 am, Lee Jones wrote:
> On Sun, 22 Mar 2020, Saravanan Sekar wrote:
>
>> mp2629 is a highly-integrated switching-mode battery charge management
>> device for single-cell Li-ion or Li-polymer battery.
>>
>> Add MFD core enables chip access for ADC driver for battery readings,
>> and a power supply battery-charger driver
>>
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> ---
>>   drivers/mfd/Kconfig        |   9 +++
>>   drivers/mfd/Makefile       |   2 +
>>   drivers/mfd/mp2629.c       | 116 +++++++++++++++++++++++++++++++++++++
>>   include/linux/mfd/mp2629.h |  22 +++++++
>>   4 files changed, 149 insertions(+)
>>   create mode 100644 drivers/mfd/mp2629.c
>>   create mode 100644 include/linux/mfd/mp2629.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 3c547ed575e6..6614e5cff881 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -434,6 +434,15 @@ config MFD_MC13XXX_I2C
>>   	help
>>   	  Select this if your MC13xxx is connected via an I2C bus.
>>   
>> +config MFD_MP2629
>> +	bool "Monolithic power system MP2629 ADC and Battery charger"
>> +	depends on I2C
>> +	select REGMAP_I2C
>> +	help
>> +	  Select this option to enable support for monolithic power system
>> +	  battery charger. This provides ADC, thermal, battery charger power
>> +	  management functions on the systems.
>> +
>>   config MFD_MXS_LRADC
>>   	tristate "Freescale i.MX23/i.MX28 LRADC"
>>   	depends on ARCH_MXS || COMPILE_TEST
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index f935d10cbf0f..d6c210f96d02 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -170,6 +170,8 @@ obj-$(CONFIG_MFD_MAX8925)	+= max8925.o
>>   obj-$(CONFIG_MFD_MAX8997)	+= max8997.o max8997-irq.o
>>   obj-$(CONFIG_MFD_MAX8998)	+= max8998.o max8998-irq.o
>>   
>> +obj-$(CONFIG_MFD_MP2629)	+= mp2629.o
>> +
>>   pcf50633-objs			:= pcf50633-core.o pcf50633-irq.o
>>   obj-$(CONFIG_MFD_PCF50633)	+= pcf50633.o
>>   obj-$(CONFIG_PCF50633_ADC)	+= pcf50633-adc.o
>> diff --git a/drivers/mfd/mp2629.c b/drivers/mfd/mp2629.c
>> new file mode 100644
>> index 000000000000..41a4082387ce
>> --- /dev/null
>> +++ b/drivers/mfd/mp2629.c
>> @@ -0,0 +1,116 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * MP2629 MFD Driver for ADC and battery charger
> s/MFD Driver/parent driver/
>
>> + * Copyright 2020 Monolithic Power Systems, Inc
>> + *
>> + * Author: Saravanan Sekar <sravanhome@gmail.com>
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/i2c.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/irq.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/mfd/mp2629.h>
> Alphabetical please.
>
>> +enum {
>> +	MP2629_MFD_ADC,
>> +	MP2629_MFD_CHARGER,
>> +	MP2629_MFD_MAX
>> +};
>> +
>> +static struct resource mp2629_irq_rsrc[] = {
>> +	{
>> +		.flags = IORESOURCE_IRQ,
>> +	},
>> +};
>> +
>> +static struct mfd_cell mp2629mfd[] = {
>> +	[MP2629_MFD_ADC] = {
>> +		.name = "mp2629_adc",
>> +		.of_compatible = "mps,mp2629_adc",
>> +	},
>> +	[MP2629_MFD_CHARGER] = {
>> +		.name = "mp2629_charger",
>> +		.of_compatible = "mps,mp2629_charger",
>> +		.resources = mp2629_irq_rsrc,
>> +		.num_resources = ARRAY_SIZE(mp2629_irq_rsrc),
>> +	}
>> +};
>> +
>> +static const struct regmap_config mp2629_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +	.max_register = 0x17,
>> +};
>> +
>> +static int mp2629_probe(struct i2c_client *client)
>> +{
>> +	struct mp2629_info *info;
> All this ddata instead of info.
Not sure the reason, I will do.
>
>> +	struct resource	*resources;
>> +	int ret;
>> +	int i;
>> +
>> +	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
>> +	if (!info)
>> +		return -ENOMEM;
>> +
>> +	info->dev = &client->dev;
>> +	i2c_set_clientdata(client, info);
>> +
>> +	info->regmap = devm_regmap_init_i2c(client, &mp2629_regmap_config);
>> +	if (IS_ERR(info->regmap)) {
>> +		dev_err(info->dev, "Failed to allocate regmap!\n");
>> +		return PTR_ERR(info->regmap);
>> +	}
>> +
>> +	for (i = 0; i < MP2629_MFD_MAX; i++) {
>> +		mp2629mfd[i].platform_data = &info->regmap;
>> +		mp2629mfd[i].pdata_size = sizeof(info->regmap);
> You don't need to store this in platform data as well.
>
> You already have it in device data (ddata [currently 'info']).

"The IIO parts seems fine (minor comments inline) but I'm not keep on
directly accessing the internals of the mfd device info structure.
To my mind that should be opaque to the child drivers so as to provide
clear structure to any such accesses.

This mess in layering with the children directly using the parents
regmap is a little concerning. It means that the 3 drivers
really aren't very well separated and can't really be reviewed
independently (not a good thing)."

This is the review comments form Jonathan on V2, not to access parent 
data structure directly.
Am I misunderstood his review comments? please suggest the better option 
to follow as like in V2
or V2 + some improvements or V4 + improvements?

>> +		resources = (struct resource *)mp2629mfd[i].resources;
>> +		if (resources) {
>> +			resources[0].start = client->irq;
>> +			resources[0].end = client->irq;
>> +		}
> You don't need to store this separately either.
>
> Just fetch it from the parent in the child device driver.
>
> It will look something like (untested, off the top of my head):
>
>    platform_get_irq(to_platform_device(pdev->dev.parent), 0);
I have tested child got irq number correctly. Ok I will change it
>
>> +	}
>> +
>> +	ret = devm_mfd_add_devices(info->dev, PLATFORM_DEVID_NONE, mp2629mfd,
>> +				ARRAY_SIZE(mp2629mfd), NULL,
>> +				0, NULL);
>> +	if (ret)
>> +		dev_err(info->dev, "Failed to add mfd %d\n", ret);
> "Failed to register sub-devices"
>
>> +	return ret;
>> +}
>> +
>> +static const struct of_device_id mp2629_of_match[] = {
>> +	{ .compatible = "mps,mp2629"},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, mp2629_of_match);
>> +
>> +static const struct i2c_device_id mp2629_id[] = {
>> +	{ "mp2629", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, mp2629_id);
> You're already using .probe_new - this can be removed.
>
>> +static struct i2c_driver mp2629_driver = {
>> +	.driver = {
>> +		.name = "mp2629",
>> +		.of_match_table = mp2629_of_match,
>> +	},
>> +	.probe_new	= mp2629_probe,
>> +	.id_table	= mp2629_id,
>> +};
>> +module_i2c_driver(mp2629_driver);
>> +
>> +MODULE_AUTHOR("Saravanan Sekar <sravanhome@gmail.com>");
>> +MODULE_DESCRIPTION("MP2629 Battery charger mfd driver");
> "parent driver"
>
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/mfd/mp2629.h b/include/linux/mfd/mp2629.h
>> new file mode 100644
>> index 000000000000..371e44330ba8
>> --- /dev/null
>> +++ b/include/linux/mfd/mp2629.h
>> @@ -0,0 +1,22 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * mp2629.h  - register definitions for mp2629 charger
> Remove the filename.
>
> s/mp2629/MP2629/
>
>> + * Copyright 2020 Monolithic Power Systems, Inc
>> + *
> Superfluous '\n'.
>
>> + */
>> +
>> +#ifndef __MP2629_H__
>> +#define __MP2629_H__
>> +
>> +#include <linux/types.h>
>> +
>> +struct device;
>> +struct regmap;
> Why not just add the includes?
Some more shared enum added in ADC driver
>> +struct mp2629_info {
>> +	struct device *dev;
>> +	struct regmap *regmap;
>> +};
>> +
>> +#endif
Thanks,
Saravanan
