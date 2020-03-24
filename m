Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9505419066C
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 08:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgCXHi4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 03:38:56 -0400
Received: from mail-eopbgr140051.outbound.protection.outlook.com ([40.107.14.51]:31384
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725905AbgCXHiz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 24 Mar 2020 03:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DFHc/Weq/0bKaBE2qB/PxYtzBT7hqO7V75hVKIwUKo=;
 b=NTl1HCS3RAUBRWFF4CYznsC+ciCrVyQ5IXjxqNMs160AdsBmiUWmMF+TGq2QA1jvw+FYm1ie86ZAe57zpMGl0fPRKI1wdHs0sHgrtlD2uME65ggws4UcZjBk0nbPIb43NkeFIt7xpGpmZKJvS4VW8JOtIwDBwcla/RDMe/xKEP4=
Received: from AM5PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:203:69::14) by DB6PR0402MB2776.eurprd04.prod.outlook.com
 (2603:10a6:4:95::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Tue, 24 Mar
 2020 07:38:50 +0000
Received: from HE1EUR01FT040.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:69:cafe::b7) by AM5PR0202CA0004.outlook.office365.com
 (2603:10a6:203:69::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Tue, 24 Mar 2020 07:38:50 +0000
Authentication-Results: spf=pass (sender IP is 13.81.10.179)
 smtp.mailfrom=topicproducts.com; pmeerw.net; dkim=fail (signature did not
 verify) header.d=topicbv.onmicrosoft.com;pmeerw.net; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.81.10.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.81.10.179; helo=westeu13-emailsignatures-cloud.codetwo.com;
Received: from westeu13-emailsignatures-cloud.codetwo.com (13.81.10.179) by
 HE1EUR01FT040.mail.protection.outlook.com (10.152.1.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Tue, 24 Mar 2020 07:38:49 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (104.47.9.54) by westeu13-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 24 Mar 2020 07:38:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqRcaTKDKvGPwFhvNEZeUqmup1d2ap/FfBTZFaL24p+o8TnTzqdjUJKw9aQGXOPdq9/xSFLdfreV1nGJr2Vl4DtryC+zj/Iimap09Hov4eiBh0CiszRtinsvwJSGwniIwygUG6gMabtmPxAsz9dHfaHk2srPayyOEQvdR66U3tr6WP0jeDZdaYXP48lI3SkF6dqINUxsMwssT6qtroZz5qJays0w3NNp/qiiBMlTItEx3FVehyDPqiai77KlfBp5S75/+J75+wt16JUW/cR+PL+TKCGR+vLZf/3HOQsDXp4GxxLU+AHLSTy5axL6a9o3qc6sQaWi1SEM6nLiXvvOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DFHc/Weq/0bKaBE2qB/PxYtzBT7hqO7V75hVKIwUKo=;
 b=FvMpGtkLk/x1w3mWB3RNGK0wjQ7N1OswS3pJUbpA3xtafNZmEKuwDIk2Ce4CjNMaWciT1wj5sc3mbYMAPsMIuLLYfR1xqO5TXCXAmhXpD2oz1zt5C0aRxujG9RC8PfXXT0NRN/71411Zk3SzMCQXL2+/oajpTlGyhnBg4EnE3rv6f0mzAElRTZ/BEIfHFV4xB4/Q2JfLBXcD/cLd/7NcH2yfg735ctQ78p8gwv4hsXYEaX6o8C3X3/kJQO6+fWVoSAzKbf43CRdekitXSZ6gXSxOzabyEQXZlFa1XJBmGbyptenDgvuFvsXC2AA8+EtBW7wXg5uWmIgeIoyLyYuZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DFHc/Weq/0bKaBE2qB/PxYtzBT7hqO7V75hVKIwUKo=;
 b=mHgqee1bs4ywTRUcvwWPR1tlQWkn3lQ8AzOOLqw/TRGoJobWmGGw7DO+3aVTTLl4udclv9QGX2RubPhuOANDIIMdgbORftFEFnA1DnGV5W4llausEl7tSax3WPijBtuXiT3bXfp5DHod+abKvPG+7G0BN5DZeWJ62KUXYSN7phg=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) by
 DB3PR0402MB3852.eurprd04.prod.outlook.com (52.134.71.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.19; Tue, 24 Mar 2020 07:38:43 +0000
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71]) by DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 07:38:43 +0000
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
Message-ID: <d63f74fb-bf1a-d76c-1722-a92b02116044@topic.nl>
Date:   Tue, 24 Mar 2020 08:38:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200323134719.GN1922688@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::29) To DB3PR0402MB3947.eurprd04.prod.outlook.com
 (2603:10a6:8:7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM0PR01CA0016.eurprd01.prod.exchangelabs.com (2603:10a6:208:69::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Tue, 24 Mar 2020 07:38:43 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5026d8fd-1d92-4f21-2440-08d7cfc664d8
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3852:|DB6PR0402MB2776:
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2776D2A09C1418FD492BEBA696F10@DB6PR0402MB2776.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;OLM:7219;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(376002)(39840400004)(366004)(396003)(136003)(346002)(44832011)(2616005)(8676002)(81156014)(2906002)(31696002)(186003)(26005)(6486002)(81166006)(8936002)(53546011)(956004)(16526019)(66476007)(66946007)(66556008)(6916009)(5660300002)(4326008)(508600001)(31686004)(316002)(36756003)(16576012)(36916002)(52116002)(42882007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3852;H:DB3PR0402MB3947.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9sKcleaMausBMNFvAA912TPGKFUzjaIPEhU/8iUUPOm6Jj0cuAw2z4eRFsOUEFuEpDpUrOZ/gb7cFpmSIGGojY4Y+WnMpj8gQ8Zt3B5YNbtr2nvKOAidTYj27u1SbquhKsjxN+6vBy+2nFSZe+DjbJk0tNPkBixQMcGbrE/crC+tjThihM1km5jnQIDxPuc/iZL8bq2qyc8GuXvrJqDvH1ild1Z9gBqrXNC0UYRvvh4/Fw54Fxb4eVAo3cliRhJ6Dy5fQnum6oEM9VmLCdtMj6XZVMplLFYoh7mWnIizg6DCONHocDqGwFeWe9BbXPHUvc2jvOazihy2PtWt3HUCPd8N+jxzETcLU9SMQTuA/+XtQ0niHIIf9n6IrXUopgtzko9KmcAI3kdgusZh6lrcD2n+C70yXBRs4bxkmNKdpdh+D+JyfSNf++Vl1tIwZLkD
X-MS-Exchange-AntiSpam-MessageData: BJt+QdpXIUT30avAmwKM9t7yWA+ghabdZbHcgwY0Yyy0ZhvvJ4Zn6SnZtcwFxQeFsJwXU2Ushhy15I5+f7QyqVNti81FATMcAr6c6h1ubFbSVZoYRB7acZkDqRpCoP10R3KnDJAc9DUXKt4RiSK5ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3852
X-CodeTwo-MessageID: b9db8945-953f-4887-8a46-89c82abb9317.20200324073847@westeu13-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT040.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:13.81.10.179;IPV:;CTRY:NL;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39840400004)(346002)(46966005)(7636002)(31686004)(2906002)(47076004)(6916009)(6486002)(4326008)(36916002)(31696002)(356004)(16576012)(7596002)(36756003)(316002)(70206006)(336012)(508600001)(70586007)(53546011)(42882007)(8936002)(16526019)(186003)(8676002)(246002)(26005)(956004)(44832011)(2616005)(82310400001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2776;H:westeu13-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:westeu13-emailsignatures-cloud.codetwo.com;
X-MS-Office365-Filtering-Correlation-Id-Prvs: b5da75ad-59c8-40e8-410d-08d7cfc660fb
X-Forefront-PRVS: 03524FBD26
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UGTNYZGK6xkCQ6H7+prtpV1aHQ5VULBx8gxpg5VCmTeHQ/AY4A2un8wjIdOX8Fn2WMQOZZqatWghgOOx1B+jac8CfkqxOlT34R3q5pr6UjPp94JbgyH8PtBkSh066Qu5elJQzSBnKLucrpWBKkvi3J0UN6RFpk/4b9qPp6ZD+STR1B9u7IwtlpmA2QbD4pUz/xV2dbPupBGR2Jh0fJ4PbImaMHH4RMEkqwIRA3bqXU5EqvXbYC/F5O1a8x9PxiBN422MayuMptpuz2dus+1ii7ZavRogTjHhHc6OZhY8ASrB8jqiR40YA+tCfxPzqDeyLsajKXrUaDSDxlCHtji8CwrkwJWWML+RV9kHnPAXNZTUpiotjw3YYbP8IipWM4Qg/1mgAAGU1EJ6o+QgnAf60F0Q/Qzv0XHryG5DcQbh2QLqlO5xZTh2KYS/0to2aNaVzCyqQlF74ywTFt9VkThWNiJ1S/YPu6QWPObM2Iy/QPX6/mp7SS7/wRtBO7quXk+dmoksZqkj1ko/uIm1S77F3w==
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 07:38:49.6816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5026d8fd-1d92-4f21-2440-08d7cfc664d8
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.81.10.179];Helo=[westeu13-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2776
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

Apparently I do, without "extern" the compiler will complain:
  multiple definition of `bmi088_accel_pm_ops'

with variable declarations the "extern" keyword is needed.
