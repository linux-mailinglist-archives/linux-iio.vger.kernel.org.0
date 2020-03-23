Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D4018F678
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 14:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgCWN6w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 09:58:52 -0400
Received: from mail-am6eur05on2063.outbound.protection.outlook.com ([40.107.22.63]:6561
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728548AbgCWN6v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 09:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUz1W5XgDFmfYGfbsn4jn9YDesdu/f6qhDTPCclr2aw=;
 b=aw6fkybrW0SlD8rPjlZn+HIyqwWNj3aTA89wCUfRb2CXNcORGQK39nIyprxuUmIwumli3MMXxK3a0ac1NTumK0V6LG7Yt/7znWyj2ehPBkScuIs/65vDB/rijVho9o2V7KG52TaQMtHTvlZz7GqCYPYVgyaJxYRUk98kywBVnRE=
Received: from AM6PR05CA0003.eurprd05.prod.outlook.com (2603:10a6:20b:2e::16)
 by DB6PR0401MB2424.eurprd04.prod.outlook.com (2603:10a6:4:4b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Mon, 23 Mar
 2020 13:58:45 +0000
Received: from VE1EUR01FT032.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:2e:cafe::7) by AM6PR05CA0003.outlook.office365.com
 (2603:10a6:20b:2e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Mon, 23 Mar 2020 13:58:45 +0000
Authentication-Results: spf=pass (sender IP is 13.81.10.179)
 smtp.mailfrom=topicproducts.com; pmeerw.net; dkim=fail (signature did not
 verify) header.d=topicbv.onmicrosoft.com;pmeerw.net; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.81.10.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.81.10.179; helo=westeu13-emailsignatures-cloud.codetwo.com;
Received: from westeu13-emailsignatures-cloud.codetwo.com (13.81.10.179) by
 VE1EUR01FT032.mail.protection.outlook.com (10.152.2.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 23 Mar 2020 13:58:45 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (104.47.8.54) by westeu13-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 23 Mar 2020 13:58:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZzJ1QxoYhkc2gn0Wco8U20I+L06S+/+stbpyBXxFid+ZX422T1txbuFaRPi1C0+QKwcOqoTRORYBnDxWwsMnkjTVs1lTw8ri8duMj3DHc81EmkAJoQe6CxahdWztbFYyY+JB5GWNZJPNlG3CSRAtrar+DpECPOVqNIkBBSVD6fvNm8qaEUVHUzjVeH4kUAz7Tx8+TG/z6IcAZAg6qUm6OiJx+CcnGB/vWdTX4y6EvAHe9bDPdnFLCokG3hdi9VQ42x8md3L9pv+WOiudg2Fnro6C3xq54X+9ibYCd7YB6N/hIqfG5A4ralwl7VH5UcAY00bcmEy1xlw//sHhpI2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUz1W5XgDFmfYGfbsn4jn9YDesdu/f6qhDTPCclr2aw=;
 b=kUiCAIHTh6s+swusove4Da7xWJOApWaiqyYO/57k63s0rl++GQAd9ov6lgYhuxBUDHK7r/iVuzCoKDMrrPq36kSOLI4XA0dOavlaDslHpsW9ec2wm632qR7gfIkWUxsmtGSvkr5/Sm6dslJmPRrESbZm4sqoT+pDqG757OhUOCODhyYWP6p5bWwaSBgNPhUNuTZEPdvDldYL1R0mSMcz+kZVbQfewlef/3tdyPcqiiznxYtNTROeuNeA6XDeV558owKlnq3z6/1oiRpsgwr00jFPvwsRi5evlSYd955ht+zmMiVaylJ4F6h2HNSnwEA1PXJPBtz0xYwH32V/2Y+bUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUz1W5XgDFmfYGfbsn4jn9YDesdu/f6qhDTPCclr2aw=;
 b=kjVZB/ZCCGf0pXh6yH8BC0xE2v3Qmdi+kne/i1EqKZOme5mv1uXlBFrizb8HSSWjGYHvCvkoo9jvxN0AZOrvq2ScHSezxJ1JNRkQ8Xqx6vs/i9tQxO2IZeWzhIliuRod70ZTMVCWUAyrKPBOHK+Q+AGwITtKL4aNgVhzeEsLQZs=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) by
 DB3PR0402MB3913.eurprd04.prod.outlook.com (52.134.65.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Mon, 23 Mar 2020 13:58:41 +0000
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71]) by DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 13:58:41 +0000
Subject: Re: [PATCH v4] iio: accel: Add support for the Bosch-Sensortec BMI088
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
CC:     jic23@kernel.org, linux-iio@vger.kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
References: <20200323092830.29708-1-mike.looijmans@topic.nl>
 <20200323113120.GI1922688@smile.fi.intel.com>
 <35eef6af-bf1f-53e0-56a7-aa8161b4f867@topic.nl>
 <20200323134719.GN1922688@smile.fi.intel.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <1b99c64a-bf5c-0533-d70e-ab2734676e11@topic.nl>
Date:   Mon, 23 Mar 2020 14:58:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200323134719.GN1922688@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0027.eurprd05.prod.outlook.com
 (2603:10a6:208:55::40) To DB3PR0402MB3947.eurprd04.prod.outlook.com
 (2603:10a6:8:7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM0PR05CA0027.eurprd05.prod.outlook.com (2603:10a6:208:55::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend Transport; Mon, 23 Mar 2020 13:58:40 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1954909e-2137-4f78-0672-08d7cf324dad
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3913:|DB6PR0401MB2424:
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2424454F7C2457AB5C269DF396F00@DB6PR0401MB2424.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(346002)(396003)(39840400004)(199004)(186003)(16526019)(8936002)(31686004)(36756003)(26005)(508600001)(81156014)(31696002)(8676002)(66476007)(66556008)(81166006)(5660300002)(52116002)(66946007)(42882007)(16576012)(2906002)(44832011)(36916002)(6486002)(6916009)(2616005)(53546011)(956004)(316002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3913;H:DB3PR0402MB3947.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: N0UCEdyzdGNj4uiSugZdToARJRt/egFdBHbdsgMkaQRdj2dkKvJkhMknqv9cLQs8Abs3Sb2p3Hhkusc10ZYwAlSKdGR4mhoTOXLlSz1qSixPb6vtw+ttkj0RwuXmfyEbfS+sRhLgFA3YRwqsWYfJAfxUAJFa1rkFwnMuQ5up818lL4XtgrZFpOrMKEodxEFsHAxEaeXe0xXeWddxVc1SqWof+jV5E0SHcA1SeorPt2xYixFLN/OhkR3pKiARadzPFmpcHNdJPfmdOTt/iqA4CBVdweyJLsWeWVg47wIxknJ3ZQPSrhvCuLIrMi6zC1DhNnYEWbnfTLtWz0xOB4nk+C/fCbrlUbTKyHH6KgClAYKSiye2lqknTeprpEuD5295yM12UpWsZSPQLmQeQyayqdCakA9XVhlumjKaxG8x77eW9JGVzYXYNaFnuS+Q/xwo
X-MS-Exchange-AntiSpam-MessageData: DhEm98EsHkWxg/Kh3RrBkEqtLCJWmLRjpFcb6J/Jozgknd7nufJrarjVshFXzdYUFk6TABH0boej3PVGe/jO7Ntxikp8qn6EY15W/GKI2S6WHjsb3Iqi8aiOWutnY8s54pC9U1P6GroZN0J75RXALA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3913
X-CodeTwo-MessageID: 0327296a-e67d-4382-a0e8-aa896adfe386.20200323135842@westeu13-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT032.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:13.81.10.179;IPV:;CTRY:NL;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39840400004)(346002)(396003)(199004)(46966005)(53546011)(186003)(16526019)(26005)(316002)(16576012)(36756003)(36916002)(336012)(44832011)(6486002)(70586007)(70206006)(42882007)(31696002)(4326008)(2616005)(5660300002)(956004)(356004)(82310400001)(31686004)(2906002)(6916009)(508600001)(7636002)(7596002)(246002)(8676002)(47076004)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2424;H:westeu13-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:westeu13-emailsignatures-cloud.codetwo.com;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 01ce2c1c-114d-426b-725c-08d7cf324b09
X-Forefront-PRVS: 0351D213B3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4AUPoUBsyQa6YaDyeFE8Qhb8pDZZzumvx62XzTw7nFEwFPSLtrWZqGR8YLJfVrx1+me7YWoBzWafZIxaDWUVMri6MuXoPoudd7iYXPQ0z17Z4GHmfHx1CZQQOExdFSuoX8HLlXPyvUMhv2rziCLVz8rtNeYMms1fqobyOQHyZlfQVYQiLWRhDik0ZW7lIU5z42koV/y2aMLJ/uQUrNuMJmqgX/EwT5XWQAMtfN6nnXW8gFtorYM7dHcIXRNeqekXLANlnMHiLDLgxrgAU70HKsWAGDPh+9hJXI3WqRbsr4z5pj6WeBaFvLKZJ1ZkV+J/ApwO9o7sQMNedRHkh/esvwO2DUVApkPZgFt4L5LPoihO7kwvpgN4F8zhqHaw3SQ+3op8qk0xW57S58UgZzQ9pki9k77bJYkmLbsYaR7Adars3S+7I/z3jQzzb4b20BBcIxzUgJac3HUZPWTfZux/koIR8Fq5WbB4WGhJsgxrU8oaiT5KXsV//MFtGPDWrCt9ovvh3obbslRJ+YRl4KoYA==
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 13:58:45.2784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1954909e-2137-4f78-0672-08d7cf324dad
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.81.10.179];Helo=[westeu13-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2424
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 23-03-2020 14:47, Andy Shevchenko wrote:
> On Mon, Mar 23, 2020 at 01:33:58PM +0100, Mike Looijmans wrote:
>> On 23-03-2020 12:31, Andy Shevchenko wrote:
>>> On Mon, Mar 23, 2020 at 10:28:30AM +0100, Mike Looijmans wrote:
>>>> The BMI088 is a combined module with both accelerometer and gyroscope.
>>>> This adds the accelerometer driver support for the SPI interface.
>>>> The gyroscope part is already supported by the BMG160 driver.
>>>
>>>
>>> Thank you, the comment about shared buffer given to v3 still applies.
>>> Also see below.
> 
> Since you didn't comment on many, I assume you are in favor to follow.
> Please, comment if it's not the case.

Didn't mention it explicitly, but no comment means "I agree".


> 
> ...
> 
>> As most of the method body depends on that "bool" argument, I would actually
>> just split it into separate "enable" and "disable" methods. Simpler to read
>> and understand, and probably doesn't make a difference in compiled size
>> either.
> 
> It's even better!
> 
> ...

Hmm, reading the datasheet again about the power modes is now confusing 
me. It's been awhile since I read that, and I don't think that I got it 
right....

there are two power setting registers, and it's not quite clear to me 
any more what I'm supposed to do with them...

I think the intention is that I just set ACC_PWR_CTRL to "4" after 
reset/probe, and leave it there, and use the ACC_PWR_CONF register to go 
in and out of suspend state. This affects the temperature sensor as well.


I'll need a bit of caffeine before I get to v5.


> 
>>>> +#ifndef BMI088_ACCEL_H
>>>> +#define BMI088_ACCEL_H
>>>> +
>>>> +extern const struct regmap_config bmi088_regmap_conf;
>>>> +extern const struct dev_pm_ops bmi088_accel_pm_ops;
>>>
>>> Do you need extern?
>>
>> probably not.
>>
>>>
>>>> +int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>>>> +			    const char *name, bool block_supported);
>>>> +int bmi088_accel_core_remove(struct device *dev);
>>>
>>> This needs
>>>
>>> #include <linux/types.h>
>>>
>>> struct device;
>>> struct regmap;
>>>
>>
>> Hmm, and "struct regmap_config" as well I guess (see above)
> 
> Oh, it requires headers then
> 
> So,
> 
> #include <linux/pm.h>
> #include <linux/regmap.h>
> #include <linux/types.h>
> 
> struct device;
> 


-- 
Mike Looijmans
