Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C6D455648
	for <lists+linux-iio@lfdr.de>; Thu, 18 Nov 2021 09:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244228AbhKRIKr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Nov 2021 03:10:47 -0500
Received: from mail-mw2nam12on2088.outbound.protection.outlook.com ([40.107.244.88]:38240
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244227AbhKRIKi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 18 Nov 2021 03:10:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcYdkfGRbHdnlixPNRGFxPtSCZvQ+0cRqru3M1Rxng7ElXTtk0qJEGbz9uePr5qQaV5YAOnOZ7wVBrhunt4prNYQnV0bqrmtRR1+qXDmIUv+PK36L9/AHMQ5B+C6ekDdjZS9oshOch0GZM3KfswhOSQ6J9y1OU9F8XvYlcObWQXrXBdMY1hJqFMBk+IQLlu9m5Y+8lv9Ge1NK8j1Q63gKS/xEjIifoez4/wj6K/vOH6h3qB29W/J3aqiarAY/SfHrKj6f0MKPisyW6F8dwcLHVPTXxAhEgK5vc3X+HV1uRQmudqgKcJqXpy4lh0KvPDbPqeYJtj+BLGzI5tcMmXKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E44AKAtXXq8B9O8/sN684mVDCfRoypwYoXIzwai9tFk=;
 b=WsA8gV1fzBkvr1zacQl7oNTbuP162/nI9mTKOSKkjx1+2UXppXLHfrZ/iJbM8LDawELjlaLr2e0RE2kC98Sfup2hShAjj08YnrDaVBRA5ux0kWo/er5xmKA0UjtPTgkcMKAFRwLvMoTOvhmHvQ/hbYy7mJ+0zjofOIv5bS3QNSU9oEjHdMEHU6fpvvZ0xNO/FrySJMveQE9JSw3LiExF6Cw0GRGrggpA4zirL6v6Jwz85i6SLXOsWx+ZbLUvgyPa9fxc8O4Os+V3zNn8etKjP3o3UCaQWMvvhA5KpW9T5/LyQU3YPYXszTEB4V6c7nV/iJQv2WZ5PaTu87LrFweWkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E44AKAtXXq8B9O8/sN684mVDCfRoypwYoXIzwai9tFk=;
 b=r57FBewfE9KuMAaKeB2lq46CZpdU+C1B2bEcxLQyb00X+WfnXQUAVbrHH5U8TyXnNbAYJY8L+SRu/RARFu7xZvoJWAAQ+GHVakyeZKetumx+HzRRdf0MUs/di8OrzfqN1+Sspcy1Z00yTXckIilnWuaoERVK9uw8jOn5/QlGF9Q=
Received: from SN4PR0501CA0014.namprd05.prod.outlook.com
 (2603:10b6:803:40::27) by BL0PR02MB4930.namprd02.prod.outlook.com
 (2603:10b6:208:53::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 08:07:35 +0000
Received: from SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:40:cafe::ee) by SN4PR0501CA0014.outlook.office365.com
 (2603:10b6:803:40::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 08:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0041.mail.protection.outlook.com (10.97.5.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 08:07:35 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Nov 2021 00:07:34 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 18 Nov 2021 00:07:34 -0800
Envelope-to: git@xilinx.com,
 andriy.shevchenko@linux.intel.com,
 linux-kernel@vger.kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 linux-acpi@vger.kernel.org,
 heikki.krogerus@linux.intel.com
Received: from [10.254.241.49] (port=52950)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mncSD-0008fk-ON; Thu, 18 Nov 2021 00:07:33 -0800
Message-ID: <017031cf-6092-0c33-339b-5c6b6b5ac6c7@xilinx.com>
Date:   Thu, 18 Nov 2021 09:07:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v10 3/5] iio: adc: Add Xilinx AMS driver
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <heikki.krogerus@linux.intel.com>,
        "Manish Narani" <manish.narani@xilinx.com>
References: <20211117161028.11775-1-anand.ashok.dumbre@xilinx.com>
 <20211117161028.11775-4-anand.ashok.dumbre@xilinx.com>
 <YZVf+Y/KxASvT2MU@smile.fi.intel.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <YZVf+Y/KxASvT2MU@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fc7815b-0cae-47be-274e-08d9aa6a7ae9
X-MS-TrafficTypeDiagnostic: BL0PR02MB4930:
X-Microsoft-Antispam-PRVS: <BL0PR02MB49306DFD3A9B67DED5A21E73C69B9@BL0PR02MB4930.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1s+JgBwX+VjWuad+dmk8/LxAs2ZpRO8U90aI259o21Hc6vgHusotc76/HCuL9SfJGvEqebK9gSsAaCwhzzqUdxFqGIUMHMZ4EcyumYz1/gap9GFmtO6Q+OrTzaz3DWC64XWl3ONuy/YuPcVo7/XDnThqjokiCEGRioZ1H1tNJk8C4bSEAxl1TaAKBq3p11SHk3qf0Oil7VMqIBAhviaTD6SAUw1ljSuxc/O+m3I3CQgKoBbuSM0kUEbz7TQFJAq4doq16QLAYZYhFn4NmjmdG8X5+ttReZx7Wf4wPOyo1frFzT1+5yzNAvROhO6Vi3kv2XPg0Gqv0gSDlY+lR8OEBp1vfut9G2usRyLHoiIkkbuKcsTYzTj+Jvd8wFZZVPnc+I1rvTHl//16hiRHy65FGFLyh5pBJ60YDWLaR97nMk17loAhZDokqX03hTN/fFOGlN9nQR4pOkblX9HUUfA/28l2enj48tiPOVBk0aEoQKa9AAiTvr3uKUwtDK6nT+srN3hkolcR/nHurKNVWEO9j2qLF3/fV9cgEEPv80jQWa3GXQT7cdQ6Tdk5qhkQpaO4YBp4MQHBI8IjCyJLvHJLhb1simP3WkHvEWCn7lMmN8dcu51orIjU0zaA13SEYfJC0P8o9OekyGi8BQFrkpaCe8Dx4JPZEyzkaWo37vOBlSwfmZqbrge3HfB1O5iw67s4bCQE607kYwVu/kjUVQmd56ue0ClsMQlQ/m3c1oalGauqKbcIEjgRJFJJDxkotvLE
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(2616005)(6636002)(356005)(107886003)(508600001)(53546011)(9786002)(31696002)(54906003)(316002)(36906005)(70206006)(8936002)(82310400003)(83380400001)(186003)(110136005)(36756003)(2906002)(8676002)(5660300002)(44832011)(4326008)(426003)(31686004)(70586007)(47076005)(336012)(7636003)(26005)(36860700001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 08:07:35.4191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc7815b-0cae-47be-274e-08d9aa6a7ae9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4930
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 11/17/21 21:03, Andy Shevchenko wrote:
> On Wed, Nov 17, 2021 at 04:10:26PM +0000, Anand Ashok Dumbre wrote:
>> The AMS includes an ADC as well as on-chip sensors that can be used to
>> sample external voltages and monitor on-die operating conditions, such
>> as temperature and supply voltage levels. The AMS has two SYSMON blocks.
>> PL-SYSMON block is capable of monitoring off chip voltage and
>> temperature.
>>
>> PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring
>> from an external master. Out of these interfaces currently only DRP is
>> supported. Other block PS-SYSMON is memory mapped to PS.
>>
>> The AMS can use internal channels to monitor voltage and temperature as
>> well as one primary and up to 16 auxiliary channels for measuring
>> external voltages.
>>
>> The voltage and temperature monitoring channels also have event capability
>> which allows to generate an interrupt when their value falls below or
>> raises above a set threshold.
> 
> Thanks for an update, my comments below.
> 
> ...
> 
> Missed bitfields.h as kbuild bot noticed.
> 
>> +#include <linux/bits.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/overflow.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/property.h>
>> +#include <linux/slab.h>
> 
> ...
> 
>> +#define AMS_ALARM_THR_DIRECT_MASK	BIT(1)
> 
>> +#define AMS_ALARM_THR_MIN		~(BIT(16) - 1)
> 
> This is wrong. I already said it.
> 
>> +#define AMS_ALARM_THR_MAX		(BIT(16) - 1)
> 
> ...
> 
>> +enum ams_alarm_bit {
>> +	AMS_ALARM_BIT_TEMP,
>> +	AMS_ALARM_BIT_SUPPLY1,
>> +	AMS_ALARM_BIT_SUPPLY2,
>> +	AMS_ALARM_BIT_SUPPLY3,
>> +	AMS_ALARM_BIT_SUPPLY4,
>> +	AMS_ALARM_BIT_SUPPLY5,
>> +	AMS_ALARM_BIT_SUPPLY6,
>> +	AMS_ALARM_BIT_RESERVED,
>> +	AMS_ALARM_BIT_SUPPLY7,
>> +	AMS_ALARM_BIT_SUPPLY8,
>> +	AMS_ALARM_BIT_SUPPLY9,
>> +	AMS_ALARM_BIT_SUPPLY10,
>> +	AMS_ALARM_BIT_VCCAMS,
>> +	AMS_ALARM_BIT_TEMP_REMOTE
> 
> +Comma, same to the rest where the last item is not a terminator one.

And where you are touching this it will be good if you can initiate all 
values. That's recommendation we got from Greg some time ago.

Thanks,
Michal
