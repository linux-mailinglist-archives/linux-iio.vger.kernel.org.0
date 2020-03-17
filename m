Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C14E8188683
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 14:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgCQN4O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 09:56:14 -0400
Received: from mail-vi1eur05on2047.outbound.protection.outlook.com ([40.107.21.47]:64225
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbgCQN4O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Mar 2020 09:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJy1eidbQkWWr5THqUtoHshC/AyY3XpeggkaUcw5QvQ=;
 b=MR6rEya9U8+gkF+iRfO0Tbyi2OcYNltCS3VszpQux9wJkvUIUhj3vYoVm9bGfgNNzaJNi0VA9kVh1kfD7/O89ECwmWo4WoeHEiRwTQ0SaeBs+Sq8eHk5oNh6cc12OLK6iw8JxDUxFPsor3LQm6UeUFnaF/lS0g4iLxRWhbJ3l1s=
Received: from DB6PR0801CA0051.eurprd08.prod.outlook.com (2603:10a6:4:2b::19)
 by AM0PR04MB4529.eurprd04.prod.outlook.com (2603:10a6:208:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Tue, 17 Mar
 2020 13:55:57 +0000
Received: from DB5EUR01FT010.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:2b:cafe::82) by DB6PR0801CA0051.outlook.office365.com
 (2603:10a6:4:2b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19 via Frontend
 Transport; Tue, 17 Mar 2020 13:55:57 +0000
Authentication-Results: spf=pass (sender IP is 13.81.10.179)
 smtp.mailfrom=topicproducts.com; pmeerw.net; dkim=fail (signature did not
 verify) header.d=topicbv.onmicrosoft.com;pmeerw.net; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.81.10.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.81.10.179; helo=westeu13-emailsignatures-cloud.codetwo.com;
Received: from westeu13-emailsignatures-cloud.codetwo.com (13.81.10.179) by
 DB5EUR01FT010.mail.protection.outlook.com (10.152.4.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Tue, 17 Mar 2020 13:55:56 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.53) by westeu13-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 17 Mar 2020 13:55:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJDUIUAxPcwD29jCgLXLammhO3HzFv1qcUC1R66+d7bKzXiTSQM+L+n+drX3IqLNnAVCLz+iSSr9jnuiFmG3gujz3J3xtv9cv/9D9mmgxLj26n2oK4MTrBrrKfpylDPmwvCQh3wEoi7sWcTHgOJ2ZUwz2/7yK48U5TZDVqMI3cKlCvXLLbSjf/wbv8fdhqyMgY8ROCQX8shW7huh2u0m6ai60X74ZcLoUA0MYe3qxPZNJU36AaQL6qpv3i9l7WF6H5EXNLnLm5+w3l4l06MiuwMUXvNyrYdISV5ig3WzlNYqNi8kZHaU62RNaxE6NOlgO3ANm+u2bfGcTAV2pDTltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJy1eidbQkWWr5THqUtoHshC/AyY3XpeggkaUcw5QvQ=;
 b=JCowj02opaf2rWhsNJXsxn7UysAIj7invQZplSMJZKjLc7zelmaO3kry/jGeC/71EPZ3KSPQCJq0qSEnk2/RWYOWFlcW+zzmi0K0aTfHqvCUdka3BAh4zb5DmmXRywmBou9mkbGoODruwyq+m3gUDtOjWU6EP9H5TsMXWED4r/5OpgMEVQ11zsGZJFaCBvmCUwC0AkHXjPhRI9XC7kScJXeFDMUTah8RMMU7yZA/RciV6HNr0EJU643Rn11sywPZJLSE9heQOa4O7tn1V+iFTP8UJjZxB1nxbdGpBQGykdJu8JPcbvRA+XhmpFfry5nczOs9zYnIFz/qpSyIf4Pwog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJy1eidbQkWWr5THqUtoHshC/AyY3XpeggkaUcw5QvQ=;
 b=RsXiJ1SL4iPDMPaW3qp0RsF6Okhkm57tCJQkO87BE7t+g2W/5tD1oUg3rWuHPRCVZi0RC0JlQ/2sGcLtHLp6zO/a06hHCGNoHNXed0t/9++RO+SvtcVxNOP3WIhTGTyGMpiq5lLE5QWnip0F94RhBKvTxlGMmBn7rf5TFWQPW3U=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) by
 DB3PR0402MB3785.eurprd04.prod.outlook.com (52.134.71.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Tue, 17 Mar 2020 13:55:52 +0000
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71]) by DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71%6]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 13:55:52 +0000
Subject: Re: [PATCH] iio: accel: Add support for the Bosch-Sensortec BMI088
To:     Jonathan Cameron <jic23@kernel.org>
CC:     linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
References: <20200313140415.20266-1-mike.looijmans@topic.nl>
 <20200315120238.18c10af0@archlinux>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <b0b05944-78c7-1318-6c46-3570a23e235d@topic.nl>
Date:   Tue, 17 Mar 2020 14:55:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200315120238.18c10af0@archlinux>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR0102CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::27) To DB3PR0402MB3947.eurprd04.prod.outlook.com
 (2603:10a6:8:7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM0PR0102CA0014.eurprd01.prod.exchangelabs.com (2603:10a6:208:14::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16 via Frontend Transport; Tue, 17 Mar 2020 13:55:52 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ca1ca45-4dcf-459a-7823-08d7ca7aea7a
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3785:|AM0PR04MB4529:
X-Microsoft-Antispam-PRVS: <AM0PR04MB45291033B78CA6BE55D2DAD696F60@AM0PR04MB4529.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;OLM:6108;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(346002)(39840400004)(376002)(366004)(396003)(136003)(199004)(6486002)(31686004)(36916002)(16576012)(5660300002)(26005)(36756003)(186003)(53546011)(316002)(16526019)(8676002)(8936002)(52116002)(81156014)(44832011)(81166006)(66946007)(508600001)(6916009)(2906002)(2616005)(4326008)(30864003)(31696002)(42882007)(956004)(66556008)(66476007)(66574012);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3785;H:DB3PR0402MB3947.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /qqpEwgmCwMSZdualwUy1wQE96SInRcztbu/CoLxlMcXr+/dVTBtas+898DMNHwzGHv9oPx7Y1vshx9wIRgj9MklJn1+kjmfjwQkRYiIkNRQRz4IEft16j/3S2nUsf5SFsXfiLwXWIVQmAoQsmtQoeAjLopfyX8UWQy3Dv56YByrlgN13I5uokBWIpN+4wfrEpn/0//lsy3B+Rb6a1DUxrgrQzRaLE+dD2RmPuZEiaxTuk6Yht7ZfbbT3o+DxN+rE2pN+X/UYAhBksmzNDxMVr8/xqGyquUzpe/2WkyEVl+hFf0anxk2ByXC98Je9IbhwW28g2zMA6BAlsuWUPn4AOq0/Tdu6585Y6NgfABPCUjwS0C3b4pxMIJ+one9WFa8HT5OaEMGXi4VnmG3/p3r4fvN4O7rolPiLolK+2hMpYKnr1FY3tWep+eXYHoS1n70
X-MS-Exchange-AntiSpam-MessageData: aKyDHHkDjmkXw/ghnjyknfzubY6KriySmQURxsg5xVeoCiZhVWKwzDoI1turcZwu2ZqM+XDDaBE0jIIJZ7fH9LciQx+RlrFMBSt/PiWSj3V+vJk7ANPikPePLQEE1Uh8uFP+SxRU8tmLnNkNVKCnNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3785
X-CodeTwo-MessageID: 03325e8a-8b89-40ca-bb65-0c66e62bf6ec.20200317135554@westeu13-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT010.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:13.81.10.179;IPV:;CTRY:NL;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39840400004)(396003)(199004)(46966005)(47076004)(6486002)(26005)(508600001)(31696002)(82310400001)(2906002)(356004)(7636002)(30864003)(36916002)(53546011)(4326008)(7596002)(66574012)(42882007)(36756003)(336012)(31686004)(70206006)(6916009)(246002)(2616005)(956004)(186003)(8676002)(44832011)(16526019)(8936002)(5660300002)(316002)(16576012)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4529;H:westeu13-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:westeu13-emailsignatures-cloud.codetwo.com;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6c31279d-1efb-46dc-fcf5-08d7ca7ae7e7
X-Forefront-PRVS: 0345CFD558
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yyHWj9TWsD6pZmbL1WbgVgwgasLtHj9/ufI8G3fQVVrSX9Y4dP1rluuI035Tm/FFXsr5dgJqDeTa87ntZGwBcOJdOYrm/8T0CXxI35RDBVezVW1Bk0PKSjQ6ERvppFsIQLz3Pkk06dA22114iu0IaySIfKM7/bkZsOTErLe0veFeYgKS20I+v1y6p0etysuqGXJSAaVGnD9Na3g/OMSrKe+fxY0BmSY4fokYN9a6oB7PtBCk+LOPm+FBGId1MpqpQwy5/XzZUTLICpdTk2rXhjq5WyC8SPktqQMnlYc+aCw4k+SNeeZXnNqygdWGDq6we38X/bI7cZF8EOfarfz1YF4FJIhQgSi2qtBv+6hxHB1u97B78Jt/kpfZnyXAdQeZcMKrC8IJC9rTJY4TrW2SuHACtEAez8wSGPlmC+yhU6GE+PDWZnpnv4HDmEB3I9zTFTTWbzMhhXnHrvNYzoE+a5j6rkoRF/OU0gOsT0sMC+NGZzu+pCICk+tKI5Vm9SlwVzBqeZRT/1ccbX20JWYIxQ==
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 13:55:56.3850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca1ca45-4dcf-459a-7823-08d7ca7aea7a
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.81.10.179];Helo=[westeu13-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4529
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

See my inline comments. I've implemented most of the changes already, 
but some weird virus is attacking mortals and I don't have access to the 
board just now.

The default answer is  "Done, will submit v3" to all suggestions

On 15-03-2020 13:02, Jonathan Cameron wrote:
> On Fri, 13 Mar 2020 15:04:15 +0100
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
> 
>> The BMI088 is a combined module with both accelerometer and gyroscope.
>> This adds the accelerometer driver support for the SPI interface.
>> The gyroscope part is already supported by the BMG160 driver.
> 
> There doesn't seem to be a specific compatible entry in the bmg160 driver.
> Perhaps we should look to add one?

Patch is in your mailbox.

>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> For a modern driver I'd normally expect to also see DT bindings.
> How are you probing this?

DT patch submitted.

> 
> There is a lot of half implemented code for features that I assume will follow
> in later patches.  Please rip all that out for now.  A simple initial driver
> is great but must only include the stuff it actually uses.
> 

I stripped out more of the stuff.



> 
>> ---
>>   drivers/iio/accel/Kconfig             |  17 +
>>   drivers/iio/accel/Makefile            |   2 +
>>   drivers/iio/accel/bmi088-accel-core.c | 681 ++++++++++++++++++++++++++
>>   drivers/iio/accel/bmi088-accel-spi.c  | 100 ++++
>>   drivers/iio/accel/bmi088-accel.h      |  11 +
>>   5 files changed, 811 insertions(+)
>>   create mode 100644 drivers/iio/accel/bmi088-accel-core.c
>>   create mode 100644 drivers/iio/accel/bmi088-accel-spi.c
>>   create mode 100644 drivers/iio/accel/bmi088-accel.h
>>
>> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
>> index 5d91a6dda894..7ed9c82b731b 100644
>> --- a/drivers/iio/accel/Kconfig
>> +++ b/drivers/iio/accel/Kconfig
>> @@ -151,6 +151,23 @@ config BMC150_ACCEL_SPI
>>   	tristate
>>   	select REGMAP_SPI
>>   
>> +config BMI088_ACCEL
>> +	tristate "Bosch BMI088 Accelerometer Driver"
>> +	select IIO_BUFFER
>> +	select IIO_TRIGGERED_BUFFER
>> +	select REGMAP
>> +	select BMI088_ACCEL_SPI
>> +	help
>> +	  Say yes here to build support for the Bosch BMI088 accelerometer.
>> +
>> +	  This is a combo module with both accelerometer and gyroscope.
>> +	  This driver is only implementing accelerometer part, which has
>> +	  its own address and register map.
>> +
>> +config BMI088_ACCEL_SPI
>> +	tristate
>> +	select REGMAP_SPI
>> +
>>   config DA280
>>   	tristate "MiraMEMS DA280 3-axis 14-bit digital accelerometer driver"
>>   	depends on I2C
>> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
>> index 3a051cf37f40..f44613103ae5 100644
>> --- a/drivers/iio/accel/Makefile
>> +++ b/drivers/iio/accel/Makefile
>> @@ -19,6 +19,8 @@ obj-$(CONFIG_BMA400_I2C) += bma400_i2c.o
>>   obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
>>   obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
>>   obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
>> +obj-$(CONFIG_BMI088_ACCEL) += bmi088-accel-core.o
>> +obj-$(CONFIG_BMI088_ACCEL_SPI) += bmi088-accel-spi.o
>>   obj-$(CONFIG_DA280)	+= da280.o
>>   obj-$(CONFIG_DA311)	+= da311.o
>>   obj-$(CONFIG_DMARD06)	+= dmard06.o
>> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
>> new file mode 100644
>> index 000000000000..d0c7f278ac2b
>> --- /dev/null
>> +++ b/drivers/iio/accel/bmi088-accel-core.c
>> @@ -0,0 +1,681 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
>> + *  - BMI088
>> + *
>> + * Copyright (c) 2018, Topic Embedded Products
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/delay.h>
>> +#include <linux/slab.h>
>> +#include <linux/acpi.h>
>> +#include <linux/pm.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/events.h>
>> +#include <linux/iio/trigger.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +#include <linux/regmap.h>
>> +
>> +#include "bmi088-accel.h"
>> +
>> +#define BMI088_ACCEL_DRV_NAME	"bmi088_accel"
>> +#define BMI088_ACCEL_IRQ_NAME	"bmi088_accel_event"
>> +
>> +#define BMI088_ACCEL_REG_CHIP_ID			0x00
>> +
>> +#define BMI088_ACCEL_REG_INT_STATUS			0x1D
>> +#define BMI088_ACCEL_INT_STATUS_BIT_DRDY		BIT(7)
>> +
>> +#define BMI088_ACCEL_REG_RESET				0x7E
>> +#define BMI088_ACCEL_RESET_VAL				0xB6
>> +
>> +#define BMI088_ACCEL_REG_PWR_CTRL			0x7D
>> +#define BMI088_ACCEL_REG_PWR_CONF			0x7C
>> +
>> +#define BMI088_ACCEL_REG_INT_MAP_DATA			0x58
>> +#define BMI088_ACCEL_INT_MAP_DATA_BIT_INT1_DRDY		BIT(2)
>> +#define BMI088_ACCEL_INT_MAP_DATA_BIT_INT2_FWM		BIT(5)
>> +
>> +#define BMI088_ACCEL_REG_INT1_IO_CONF			0x53
>> +#define BMI088_ACCEL_INT1_IO_CONF_BIT_ENABLE_OUT	BIT(3)
>> +#define BMI088_ACCEL_INT1_IO_CONF_BIT_LVL		BIT(1)
>> +
>> +#define BMI088_ACCEL_REG_INT2_IO_CONF			0x54
>> +#define BMI088_ACCEL_INT2_IO_CONF_BIT_ENABLE_OUT	BIT(3)
>> +#define BMI088_ACCEL_INT2_IO_CONF_BIT_LVL		BIT(1)
>> +
>> +#define BMI088_ACCEL_REG_ACC_CONF			0x40
>> +#define BMI088_ACCEL_REG_ACC_RANGE			0x41
>> +#define BMI088_ACCEL_RANGE_3G				0x00
>> +#define BMI088_ACCEL_RANGE_6G				0x01
>> +#define BMI088_ACCEL_RANGE_12G				0x02
>> +#define BMI088_ACCEL_RANGE_24G				0x03
>> +
>> +#define BMI088_ACCEL_REG_TEMP				0x22
>> +#define BMI088_ACCEL_TEMP_CENTER_VAL			23
>> +#define BMI088_ACCEL_TEMP_UNIT				125
>> +
>> +#define BMI088_ACCEL_REG_XOUT_L				0x12
>> +#define BMI088_ACCEL_AXIS_TO_REG(axis) \
>> +	(BMI088_ACCEL_REG_XOUT_L + (axis * 2))
>> +
>> +#define BMI088_ACCEL_MAX_STARTUP_TIME_MS		1
>> +
>> +#define BMI088_ACCEL_REG_FIFO_STATUS			0x0E
>> +#define BMI088_ACCEL_REG_FIFO_CONFIG0			0x48
>> +#define BMI088_ACCEL_REG_FIFO_CONFIG1			0x49
>> +#define BMI088_ACCEL_REG_FIFO_DATA			0x3F
>> +#define BMI088_ACCEL_FIFO_LENGTH			100
>> +
>> +#define BMI088_ACCEL_FIFO_MODE_FIFO			0x40
>> +#define BMI088_ACCEL_FIFO_MODE_STREAM			0x80
>> +
>> +enum bmi088_accel_axis {
>> +	AXIS_X,
>> +	AXIS_Y,
>> +	AXIS_Z,
>> +	AXIS_MAX,
>> +};
>> +
>> +enum bmi088_power_modes {
>> +	BMI088_ACCEL_MODE_ACTIVE,
>> +	BMI088_ACCEL_MODE_SUSPEND,
>> +};
>> +
>> +/* Available OSR (over sampling rate) */
>> +enum bmi088_osr_modes {
>> +	BMI088_ACCEL_MODE_OSR_NORMAL = 0xA,
>> +	BMI088_ACCEL_MODE_OSR_2 = 0x9,
>> +	BMI088_ACCEL_MODE_OSR_4 = 0x8,
>> +};
>> +
>> +/* Available ODR (output data rates) in Hz */
>> +enum bmi088_odr_modes {
>> +	BMI088_ACCEL_MODE_ODR_12_5 = 0x5,
>> +	BMI088_ACCEL_MODE_ODR_25 = 0x6,
>> +	BMI088_ACCEL_MODE_ODR_50 = 0x7,
>> +	BMI088_ACCEL_MODE_ODR_100 = 0x8,
>> +	BMI088_ACCEL_MODE_ODR_200 = 0x9,
>> +	BMI088_ACCEL_MODE_ODR_400 = 0xa,
>> +	BMI088_ACCEL_MODE_ODR_800 = 0xb,
>> +	BMI088_ACCEL_MODE_ODR_1600 = 0xc,
>> +};
>> +
>> +struct bmi088_scale_info {
>> +	int scale;
>> +	u8 reg_range;
>> +};
>> +
>> +struct bmi088_accel_chip_info {
>> +	const char *name;
>> +	u8 chip_id;
>> +	const struct iio_chan_spec *channels;
>> +	int num_channels;
>> +	const struct bmi088_scale_info scale_table[4];
>> +};
>> +
>> +struct bmi088_accel_interrupt {
>> +	const struct bmi088_accel_interrupt_info *info;
>> +	atomic_t users;
>> +};
>> +
>> +
>> +enum bmi088_accel_interrupt_id {
>> +	BMI088_ACCEL_INT_DATA_READY,
>> +	BMI088_ACCEL_INT_FIFO_WATERMARK,
>> +	BMI088_ACCEL_INTERRUPTS,
>> +};
>> +
>> +struct bmi088_accel_data {
>> +	struct regmap *regmap;
>> +	int irq;
>> +	struct bmi088_accel_interrupt interrupts[BMI088_ACCEL_INTERRUPTS];
>> +	struct iio_trigger *dready_trig;
>> +	struct mutex mutex;
>> +	u8 fifo_mode, watermark;
>> +	s16 buffer[8];
> 
> Not used.  Please clear out all the parts you aren't currently using and bring
> them in when they can be reviewed alongside the code adding the feature that
> needs them.
> 
>> +	u8 bw_bits;
>> +	int ev_enable_state;
>> +	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
>> +	const struct bmi088_accel_chip_info *chip_info;
>> +};
>> +
>> +const struct regmap_config bmi088_regmap_conf = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +	.max_register = 0x7E,
>> +};
>> +EXPORT_SYMBOL_GPL(bmi088_regmap_conf);
>> +
>> +
>> +static int bmi088_accel_enable(struct bmi088_accel_data *data,
>> +				bool on_off)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	int ret;
>> +
>> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_PWR_CTRL,
>> +				on_off ? 0x4 : 0x0);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Error writing ACC_PWR_CTRL reg\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int bmi088_accel_set_mode(struct bmi088_accel_data *data,
>> +				enum bmi088_power_modes mode)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	int ret;
>> +
>> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_PWR_CONF,
>> +			   mode == BMI088_ACCEL_MODE_SUSPEND ? 0x3 : 0x0);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Error writing ACCEL_PWR_CONF reg\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int bmi088_accel_set_bw(struct bmi088_accel_data *data,
>> +				enum bmi088_odr_modes odr_mode,
>> +				enum bmi088_osr_modes osr_mode)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	int ret;
>> +	u8 value = (osr_mode << 4) | (odr_mode & 0xF);
>> +
>> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_ACC_CONF, value);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Error writing ACCEL_PWR_CONF reg\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int bmi088_accel_get_bw(struct bmi088_accel_data *data, int *val,
>> +			       int *val2)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	int ret;
>> +	unsigned int value;
>> +
>> +	ret = regmap_read(data->regmap, BMI088_ACCEL_REG_ACC_CONF,
>> +			  &value);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Error reading ACC_CONF reg\n");
>> +		mutex_unlock(&data->mutex);
>> +		return ret;
>> +	}
>> +
>> +	*val = (value & 0xF); /* ODR */
>> +	*val2 = (value >> 4); /* OSR */
> 
> Superficially it seems unlikely that will map directly to the IIO defined
> ABI. See docs ref below.

Yeah, that's a bug. I implemented bmi088_accel_{g|s}et_sample_freq() 
instead.

The OSR setting is actually the filter bandwidth setting, it's not 
supported by the driver for now.


> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int bmi088_accel_get_temp(struct bmi088_accel_data *data, int *val)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	int ret;
>> +	u8 value[2];
>> +	unsigned int temp;
>> +
>> +	mutex_lock(&data->mutex);
>> +
>> +	/* Read temp reg MSB */
> 
> Seems likely it's reading the whole thing..
> 
>> +	ret = regmap_bulk_read(data->regmap, BMI088_ACCEL_REG_TEMP,
>> +			       &value, sizeof(value));
> 
> Buffers to regmap_bulk_read need to be DMA safe.  No buffer on the stack
> is.  Look at how we do it in other drivers with __cacheline_aligned within
> the structure behind iio_priv.
> 

I'll allocate a single buffer in the struct for all bulk reads and 
protect it with the mutex already there.


>> +	if (ret < 0) {
>> +		dev_err(dev, "Error reading BMI088_ACCEL_REG_TEMP\n");
>> +		mutex_unlock(&data->mutex);
>> +		return ret;
>> +	}
>> +	temp = (unsigned int)value[0] << 3;
>> +	temp |= (value[1] >> 5);
> this looks like an endian conversion with a shift after?  Please do
> it as that, rather than explicitly.  On some hosts the endian conversion
> will be a noop.

Yeah, it's just a 11-bit integer. The datasheet had this obscure code, 
the implementation is just:

	*val = sign_extend32(get_unaligned_be16(buffer), 11);

> 
>> +
>> +	if (temp > 1023)
>> +		*val = temp - 2028;
>> +	else
>> +		*val = temp;
>> +
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return IIO_VAL_INT;
>> +}
>> +
>> +static int bmi088_accel_get_axis(struct bmi088_accel_data *data,
>> +				 struct iio_chan_spec const *chan,
>> +				 int *val)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	int ret;
>> +	int axis = chan->scan_index;
>> +	__le16 raw_val;
>> +
>> +	mutex_lock(&data->mutex);
>> +
>> +	ret = regmap_bulk_read(data->regmap, BMI088_ACCEL_AXIS_TO_REG(axis),
>> +			       &raw_val, sizeof(raw_val));
>> +	if (ret < 0) {
>> +		dev_err(dev, "Error reading axis %d\n", axis);
>> +		mutex_unlock(&data->mutex);
>> +		return ret;
>> +	}
>> +	*val = sign_extend32(le16_to_cpu(raw_val) >> chan->scan_type.shift,
>> +			     chan->scan_type.realbits - 1);
>> +
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return IIO_VAL_INT;
>> +}
>> +
>> +static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
>> +				 struct iio_chan_spec const *chan,
>> +				 int *val, int *val2, long mask)
>> +{
>> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +	unsigned int range;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		switch (chan->type) {
>> +		case IIO_TEMP:
>> +			return bmi088_accel_get_temp(data, val);
>> +		case IIO_ACCEL:
>> +			if (iio_buffer_enabled(indio_dev))
> 
> We have iio_device_claim_direct_mode and friends
> to safely protect against a transition in mode during a sysfs read.
> 
>> +				return -EBUSY;
>> +
>> +			ret = regmap_read(data->regmap,
>> +				BMI088_ACCEL_REG_ACC_RANGE, &range);
>> +			if (ret < 0)
>> +				return ret;
>> +
>> +			ret = bmi088_accel_get_axis(data, chan, val);
>> +			if (ret < 0)
>> +				return ret;
>> +
>> +			*val = (*val * 3 * 980 * (0x01 << range)) >> 15;
> 
> Rather feels like you are applying some scaling here that should be left
> to userspace.  When you add buffered support you won't want to do this
> and hence you'll end up with an inconsistent interface if you do it
> the sysfs path.

Moved this to IIO_CHAN_INFO_SCALE and return the raw value directly.

> 
>> +
>> +			return IIO_VAL_INT;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		switch (chan->type) {
>> +		case IIO_TEMP:
>> +			*val = BMI088_ACCEL_TEMP_CENTER_VAL;
>> +			return IIO_VAL_INT;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*val = 0;
>> +		switch (chan->type) {
>> +		case IIO_TEMP:
>> +			*val = BMI088_ACCEL_TEMP_UNIT;
>> +			return IIO_VAL_INT;
>> +		case IIO_ACCEL:
>> +		{
>> +			ret = regmap_read(data->regmap,
>> +					BMI088_ACCEL_REG_ACC_RANGE, val);
> 
> Feels unlikely that that is is returning an appropriate value for scale.
> See the ABI docs
> 
> Documentation/ABI/testing/sysfs-bus-iio*


Yeah, this is broken. Merge with the scaling function.

> 
> 
>> +			if (ret < 0) {
>> +				dev_err(&indio_dev->dev,
>> +					"%s(): Read from device failed(%d)\n",
>> +					__func__, ret);
>> +				return -EINVAL;
>> +			}
>> +
>> +			return IIO_VAL_INT;
>> +		}
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		mutex_lock(&data->mutex);
>> +		ret = bmi088_accel_get_bw(data, val, val2);
>> +		mutex_unlock(&data->mutex);
>> +		return ret;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
>> +				  struct iio_chan_spec const *chan,
>> +				  int val, int val2, long mask)
>> +{
>> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		mutex_lock(&data->mutex);
>> +		ret = bmi088_accel_set_bw(data, val, val2);
>> +		mutex_unlock(&data->mutex);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("12.5 25 50 100 200 400 800 1600");
>> +
>> +static struct attribute *bmi088_accel_attributes[] = {
>> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group bmi088_accel_attrs_group = {
>> +	.attrs = bmi088_accel_attributes,
>> +};
>> +
>> +#define BMI088_ACCEL_CHANNEL(_axis, bits) {				\
>> +	.type = IIO_ACCEL,						\
>> +	.modified = 1,							\
>> +	.channel2 = IIO_MOD_##_axis,					\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
>> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
>> +	.scan_index = AXIS_##_axis,					\
>> +	.scan_type = {							\
> 
> bring this in only when you add buffered support.
> 
>> +		.sign = 's',						\
>> +		.realbits = (bits),					\
>> +		.storagebits = 16,					\
>> +		.shift = 16 - (bits),					\
>> +		.endianness = IIO_LE,					\
>> +	},								\
>> +}
>> +
>> +#define BMI088_ACCEL_CHANNELS(bits) {					\
>> +	{								\
>> +		.type = IIO_TEMP,					\
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
>> +				      BIT(IIO_CHAN_INFO_SCALE) |	\
>> +				      BIT(IIO_CHAN_INFO_OFFSET),	\
>> +		.scan_index = -1,					\
>> +	},								\
>> +	BMI088_ACCEL_CHANNEL(X, bits),					\
>> +	BMI088_ACCEL_CHANNEL(Y, bits),					\
>> +	BMI088_ACCEL_CHANNEL(Z, bits),					\
>> +	IIO_CHAN_SOFT_TIMESTAMP(3),					\
>> +}
>> +
>> +static const struct iio_chan_spec bmi088_accel_channels[] =
>> +	BMI088_ACCEL_CHANNELS(16);
>> +
>> +static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
>> +	[0] = {
>> +		.name = "BMI088A",
> 
> lower case for names in the sysfs interface (not sure that's actually documented
> anywhere though... :(
> 
>> +		.chip_id = 0x1E,
>> +		.channels = bmi088_accel_channels,
>> +		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
>> +		.scale_table = { {9610, BMI088_ACCEL_RANGE_3G},
>> +				 {19122, BMI088_ACCEL_RANGE_6G},
>> +				 {38344, BMI088_ACCEL_RANGE_12G},
>> +				 {76590, BMI088_ACCEL_RANGE_24G} },
> 
> bring the scale table in when you support using it.
> 
>> +		},
>> +};
>> +
>> +static const struct iio_info bmi088_accel_info = {
>> +	.attrs			= &bmi088_accel_attrs_group,
>> +	.read_raw		= bmi088_accel_read_raw,
>> +	.write_raw		= bmi088_accel_write_raw,
>> +};
>> +
>> +static const unsigned long bmi088_accel_scan_masks[] = {
>> +					BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
>> +					0};
>> +
>> +
>> +
>> +#ifdef CONFIG_PM
>> +static int bmi088_accel_set_power_state(struct bmi088_accel_data *data,
>> +	bool on)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	int ret;
>> +
>> +	if (on) {
>> +		ret = pm_runtime_get_sync(dev);
> 
>> +	} else {
>> +		pm_runtime_mark_last_busy(dev);
>> +		ret = pm_runtime_put_autosuspend(dev);
> 
> Seems you are using autosuspend which is good. However, I'm not
> seeing the setup of times etc that I'd expect to see in probe.

Yep, there's a bunch missing in probe.

> 
>> +	}
>> +
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed: %s(%d)\n", __func__, on);
>> +		if (on)
>> +			pm_runtime_put_noidle(dev);
>> +
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +#else
>> +static int bmi088_accel_set_power_state(struct bmi088_accel_data *data,
>> +	bool on)
>> +{
> 
> Hmm. It's a bit irritating that not all the of the runtime_pm calls are safe
> when it's not built.  I guess a few might have unexpected results as
> 'do nothing' isn't always the right option.
> 
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static int bmi088_accel_chip_init(struct bmi088_accel_data *data)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	int ret, i;
>> +	unsigned int val;
>> +
>> +	/* Do a dummy read (of chip ID), to enable SPI interface */
>> +	regmap_read(data->regmap, BMI088_ACCEL_REG_CHIP_ID, &val);
> 
> Given this is in the generic code, not the SPI code, should probably
> put something about "if SPI in use, does no harm otherwise".
> 
>> +
>> +	/*
>> +	 * Reset chip to get it in a known good state. A delay of 1ms after
>> +	 * reset is required according to the data sheet
>> +	 */
>> +	regmap_write(data->regmap, BMI088_ACCEL_REG_RESET,
>> +		     BMI088_ACCEL_RESET_VAL);
>> +	usleep_range(1000, 2000);
>> +
>> +	/* Do a dummy read (of chip ID), to enable SPI interface after reset */
>> +	regmap_read(data->regmap, BMI088_ACCEL_REG_CHIP_ID, &val);
>> +
>> +	/* Read chip ID */
>> +	ret = regmap_read(data->regmap, BMI088_ACCEL_REG_CHIP_ID, &val);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Error: Reading chip id\n");
>> +		return ret;
>> +	}
>> +
>> +	/* Validate chip ID */
>> +	dev_dbg(dev, "Chip Id %x\n", val);
>> +	for (i = 0; i < ARRAY_SIZE(bmi088_accel_chip_info_tbl); i++) {
>> +		if (bmi088_accel_chip_info_tbl[i].chip_id == val) {
>> +			data->chip_info = &bmi088_accel_chip_info_tbl[i];
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!data->chip_info) {
>> +		dev_err(dev, "Invalid chip %x\n", val);
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* Set Active mode (and wait for 5ms) */
>> +	ret = bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_ACTIVE);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	usleep_range(5000, 10000);
>> +
>> +	/* Enable accelerometer */
>> +	ret = bmi088_accel_enable(data, true);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Set Bandwidth */
>> +	ret = bmi088_accel_set_bw(data, BMI088_ACCEL_MODE_ODR_100,
>> +		BMI088_ACCEL_MODE_OSR_NORMAL);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Set Default Range */
>> +	ret = regmap_write(data->regmap, BMI088_ACCEL_REG_ACC_RANGE,
>> +			   BMI088_ACCEL_RANGE_6G);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Error writing ACC_RANGE\n");
> 
> In consistent.  Either have dev_err for all such cases, or none.  I'm perfectly
> happy with either, but not a mixture :)
> 
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
>> +	int irq, const char *name, bool block_supported)
>> +{
>> +	struct bmi088_accel_data *data;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(indio_dev);
>> +	dev_set_drvdata(dev, indio_dev);
>> +	data->irq = irq;
>> +
>> +	data->regmap = regmap;
>> +
>> +	ret = bmi088_accel_chip_init(data);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	mutex_init(&data->mutex);
>> +
>> +	indio_dev->dev.parent = dev;
>> +	indio_dev->channels = data->chip_info->channels;
>> +	indio_dev->num_channels = data->chip_info->num_channels;
>> +	indio_dev->name = name ? name : data->chip_info->name;
> 
> Should probably always be the chip_info->name.  If not, please add
> a comment saying why not.

This bit was just copied blindly from other drivers (e.g. the bmc150). 
I'll happily replace it and get rid of the "name" parameter. I have no 
idea whatsoever what the rationale behind it was.


> 
>> +	indio_dev->available_scan_masks = bmi088_accel_scan_masks;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->info = &bmi088_accel_info;
>> +
>> +	if (ret < 0) {
> 
> Seems like you are currently missing the buffered setup.
> 
>> +		dev_err(dev, "Failed: iio triggered buffer setup\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = iio_device_register(indio_dev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Unable to register iio device\n");
>> +		iio_trigger_unregister(data->dready_trig);
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(bmi088_accel_core_probe);
>> +
>> +int bmi088_accel_core_remove(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
>> +
>> +	iio_device_unregister(indio_dev);
>> +
>> +	pm_runtime_disable(dev);
>> +	pm_runtime_set_suspended(dev);
>> +	pm_runtime_put_noidle(dev);
> 
> This runtime PM stuff doesn't clearly match with undoing stuff
> set up in probe.
> 
>> +
>> +	mutex_lock(&data->mutex);
>> +	bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_SUSPEND);
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(bmi088_accel_core_remove);
>> +
>> +#ifdef CONFIG_PM_SLEEP
> 
> Change to marking these __maybe_unused.  The dance with CONFIG_PM*
> goes wrong too often so these days it's preferred to just let
> the compiler / linker deal with these functions not being used
> if they are never called.
> 
>> +static int bmi088_accel_suspend(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
>> +
>> +	mutex_lock(&data->mutex);
>> +	bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_SUSPEND);
> 
> Is it worth going further for suspend / resume and looking at whether
> some of the power supplies can be disabled?
> 
> Note that you'd need regulator support to do that.
> 
> The first patch we get to almost every driver is when someone finds
> they need to add regulator enable / disable for their board.   Easier to
> add it from the start if you are happy to do so.


I think it's unlikely for this chip. It's designed for battery use, so 
in standby it's already really efficient.

Tuning off its power supply would also require remembering config 
settings across power downs. Don't think it's worth the effort here.


> 
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return 0;
>> +}
>> +
>> +static int bmi088_accel_resume(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
>> +
>> +	mutex_lock(&data->mutex);
>> +	bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_ACTIVE);
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>> +#ifdef CONFIG_PM
>> +static int bmi088_accel_runtime_suspend(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	dev_dbg(dev,  __func__);
> 
> Drop these as no useful information that can't be obtained via numerous
> other methods (ftrace etc)
> 
>> +	ret = bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_SUSPEND);
>> +	if (ret < 0)
>> +		return -EAGAIN;
> 
> I'd like a comment for this to explain why we might want to back off and
> try again.

Blindly copied from another driver. Also does not makes sense to me. 
Just a "return ret" is much more logical.

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int bmi088_accel_runtime_resume(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	dev_dbg(dev,  __func__);
>> +
>> +	ret = bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_ACTIVE);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	usleep_range(BMI088_ACCEL_MAX_STARTUP_TIME_MS * 1000,
>> +		BMI088_ACCEL_MAX_STARTUP_TIME_MS * 1000 * 2);
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>> +const struct dev_pm_ops bmi088_accel_pm_ops = {
>> +	SET_SYSTEM_SLEEP_PM_OPS(bmi088_accel_suspend, bmi088_accel_resume)
>> +	SET_RUNTIME_PM_OPS(bmi088_accel_runtime_suspend,
>> +			   bmi088_accel_runtime_resume, NULL)
>> +};
>> +EXPORT_SYMBOL_GPL(bmi088_accel_pm_ops);
>> +
>> +MODULE_AUTHOR("Niek van Agt <niek.van.agt@topicproducts.com>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("BMI088 accelerometer driver (core)");
>> diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
>> new file mode 100644
>> index 000000000000..920e146f07d3
>> --- /dev/null
>> +++ b/drivers/iio/accel/bmi088-accel-spi.c
>> @@ -0,0 +1,100 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * 3-axis accelerometer driver supporting following Bosch-Sensortec chips:
>> + *  - BMI088
>> + *
>> + * Copyright (c) 2018, Topic Embedded Products
> 
> Probably change that to 2018-2020 given at least some changes are going
> to come out of this review :)

Yeah. Wouldn't want legal to come down on me...

> 
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/acpi.h>
> 
> Why acpi header?
> 
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
> 
> I don't think either of iio headers is used in this file.
> 
>> +#include <linux/spi/spi.h>
>> +#include <linux/regmap.h>
>> +
>> +#include "bmi088-accel.h"
>> +
>> +int bmi088_regmap_spi_write(void *context, const void *data, size_t count)
>> +{
>> +	struct spi_device *spi = context;
>> +	u8 buf[count];
>> +
>> +	memcpy(buf, data, count);
>> +
>> +	dev_dbg(&spi->dev, "Write val: %x to reg: %x\n", buf[1], buf[0]);
>> +
>> +	/*
>> +	 * The SPI register address (= full register address without bit 7)
>> +	 * and the write command (bit7 = RW = '0')
>> +	 */
>> +	buf[0] &= ~0x80;
>> +
>> +	return spi_write(spi, buf, count);
>> +}
>> +
>> +int bmi088_regmap_spi_read(void *context, const void *reg,
>> +				size_t reg_size, void *val, size_t val_size)
>> +{
>> +	struct spi_device *spi = context;
>> +	u8 addr[reg_size + 1];
>> +
>> +	addr[0] = *(u8 *)reg;
>> +
>> +	dev_dbg(&spi->dev, "Read reg: %x\n", addr[0]);
>> +
>> +	addr[0] |= 0x80; /* bit7 = RW = '1' */
>> +
>> +	/* Do a write of 2 to mimic the dummy byte (see datasheet) */
> 
> So I'm guessing reg_size is always 1.  Hence the 2.  I'd make that explicit
> in this code, perhaps with a sanity check on reg_size.  That will make
> the comment more obviously reflect what is happening.

Yeah, the size must be 1. Making that explicit also gets rid of the 
dynamic buffer size.


> 
>> +	return spi_write_then_read(spi, addr, sizeof(addr), val, val_size);
>> +}
>> +
>> +static struct regmap_bus bmi088_regmap_bus = {
>> +	.write = bmi088_regmap_spi_write,
>> +	.read = bmi088_regmap_spi_read,
>> +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
>> +	.val_format_endian_default = REGMAP_ENDIAN_BIG,
>> +};
>> +
>> +static int bmi088_accel_probe(struct spi_device *spi)
>> +{
>> +	struct regmap *regmap;
>> +	const struct spi_device_id *id = spi_get_device_id(spi);
>> +
>> +	regmap = devm_regmap_init(&spi->dev, &bmi088_regmap_bus,
>> +			spi, &bmi088_regmap_conf);
>> +
>> +	if (IS_ERR(regmap)) {
>> +		dev_err(&spi->dev, "Failed to initialize spi regmap\n");
>> +		return PTR_ERR(regmap);
>> +	}
>> +
>> +	return bmi088_accel_core_probe(&spi->dev, regmap, spi->irq, id->name,
>> +				       true);
>> +}
>> +
>> +static int bmi088_accel_remove(struct spi_device *spi)
>> +{
>> +	return bmi088_accel_core_remove(&spi->dev);
>> +}
>> +
>> +static const struct spi_device_id bmi088_accel_id[] = {
>> +	{"bmi088_accel", 0},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(spi, bmi088_accel_id);
>> +
>> +static struct spi_driver bmi088_accel_driver = {
>> +	.driver = {
>> +		.name	= "bmi088_accel_spi",
>> +	},
>> +	.probe		= bmi088_accel_probe,
>> +	.remove		= bmi088_accel_remove,
>> +	.id_table	= bmi088_accel_id,
>> +};
>> +module_spi_driver(bmi088_accel_driver);
>> +
>> +MODULE_AUTHOR("Niek van Agt <niek.van.agt@topicproducts.com>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("BMI088 accelerometer driver (SPI)");
>> diff --git a/drivers/iio/accel/bmi088-accel.h b/drivers/iio/accel/bmi088-accel.h
>> new file mode 100644
>> index 000000000000..540993647c75
>> --- /dev/null
>> +++ b/drivers/iio/accel/bmi088-accel.h
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef BMI088_ACCEL_H
>> +#define BMI088_ACCEL_H
>> +
>> +extern const struct regmap_config bmi088_regmap_conf;
>> +
>> +int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>> +			    const char *name, bool block_supported);
>> +int bmi088_accel_core_remove(struct device *dev);
>> +
>> +#endif /* BMI088_ACCEL_H */
> 


-- 
Mike Looijmans
