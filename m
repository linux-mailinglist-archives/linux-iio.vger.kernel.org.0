Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A2E2FE658
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jan 2021 10:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbhAUJ1I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jan 2021 04:27:08 -0500
Received: from mail-eopbgr140084.outbound.protection.outlook.com ([40.107.14.84]:19363
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728396AbhAUJDv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 Jan 2021 04:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91BuuveDeE1SK8bGafmYslD+BClI40bsSHn2318QMek=;
 b=ksd4VSYuMHjeo1/XP6plzNs3WTA8z+8v1J79Wf7H4fFzEhlKvcWuLYTvuvIFfiYl0FQ3gsUxoj4RY6zX7JafFaXislVjD/3q3137J3NOX923rOAimHCdrc4HzvF+MRL7LTfnnSygsow5qEMJQ9KIPgNRaMNm4Ib4Pt646KfRb4c=
Received: from AM6P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::33)
 by VI1PR04MB4061.eurprd04.prod.outlook.com (2603:10a6:803:4d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Thu, 21 Jan
 2021 09:02:57 +0000
Received: from HE1EUR01FT024.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:8b:cafe::6b) by AM6P191CA0020.outlook.office365.com
 (2603:10a6:209:8b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14 via Frontend
 Transport; Thu, 21 Jan 2021 09:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 HE1EUR01FT024.mail.protection.outlook.com (10.152.0.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Thu, 21 Jan 2021 09:02:56 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.110) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 21 Jan 2021 09:02:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a09QLWXdaRMGnjKgfkqzYEM2cZlyo80IM2Z0sHqSJvqs12Pzi3myKN1mQ9XjnpBU8ekUKvzUcsXv8Il9S1F4XoIQUWZPGLuv75waq4NxSqYQtTh9XuSQIfueXZLV0/tpbuAN7cNYcLYXDOZDGSZoAJRBDVO1vp567lN1rAWfb0QFqYBM2RckNr5OwJj0mN6NbqET6QoL0nWPcEDCB5/KGMuX01ZmDd0hTjAcIS6DCA1KtCxpdtXqigTsaVYCGA2itcgtGan/4WWlaHOeceITjVwn3yphSv8LH0mmiKr8HtBxqkAf2gN+GVarrrtT+FMWOoUMHvv3u7wx1MasqeV/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sj5PJiDgOBbHEffmqohmhsqLUda9rWDvZHK1V/Sx81k=;
 b=VOtvkLIBjk4HPbfocHnCsNtX6qCNr1dQZ59D8vO70WqSC6Z+PLHxnpWQKnud8IyEIzXIvVEJL9mi6Iw3qcL8TiQgnRBRQ5jS+NMbsQvOQlL3m9Y9y0bOx16Yg8/fxyd9AxzMAXr5YMNQCeKiJHwMQTUnZiXg397XN15/bIq6cos+o4ETdXTCs1XztXpO0ERRBbZ1cUoxJSuozQCHCw6seERdFqi92HMLy/7VyzwXZ2aamnCw1KYGTlaput43/yOR+4SUFD2XuYlfoSSDo+Xs3VlpoHdqn9nfv51IYMseB4fFVMHZilW0gRckAEDbq67wGH9gHk/Vb0czrHezhDifag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB8PR04MB6427.eurprd04.prod.outlook.com (2603:10a6:10:10a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Thu, 21 Jan
 2021 09:02:51 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::792a:b2ef:ed50:a1a2]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::792a:b2ef:ed50:a1a2%4]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 09:02:51 +0000
Subject: Re: [PATCH v6 2/2] iio: accel: Add support for the Bosch-Sensortec
 BMI088
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     linux-iio@vger.kernel.org, Dan Robertson <dan@dlrobertson.com>,
        =?UTF-8?B?R2HDq3RhbiBBbmRyw6k=?= <rvlander@gaetanandre.eu>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
References: <20210119124622.9490-1-mike.looijmans@topic.nl>
 <20210119124622.9490-2-mike.looijmans@topic.nl>
 <20210120202244.000009f6@Huawei.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c4ec3c42-7acb-4ce8-997f-adf405d31335@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.ca49b241-105e-4dde-a295-e8168cb6d390@emailsignatures365.codetwo.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
Message-ID: <46ad8902-4965-5b8d-865c-58c35568a7bf@topic.nl>
Date:   Thu, 21 Jan 2021 10:02:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20210120202244.000009f6@Huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [81.173.50.109]
X-ClientProxiedBy: AM0PR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::30) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.80.121] (81.173.50.109) by AM0PR01CA0089.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14 via Frontend Transport; Thu, 21 Jan 2021 09:02:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0bcf615-f483-4070-7120-08d8bdeb5835
X-MS-TrafficTypeDiagnostic: DB8PR04MB6427:|VI1PR04MB4061:
X-Microsoft-Antispam-PRVS: <VI1PR04MB4061E3152EAF05A8597C516A96A10@VI1PR04MB4061.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: nf3Scio+WdvWBsy7bBGuG4xKzhq4XrC6rvrTJvHU+LSg/nxZPaXvaJAFwLMClL/2pWF2YsqQ5FXAbunnst51jP9L3VJ6oI1lbNdrBhPi+fcJlmvw+3aj6zS+f+/tS2PyMr0zGhFpYwVEJ8rnEmIU2a36vluR5Ah3PVjH+D+3gaQtOZWNa1Jfy5TtpM7fVeZVL0hIeshNC+C/8SGoB4FfzZ29rY43ox5h16LnzRu4hNCVSG88Q6Be3IVYpj3GPwEaw9VGiV7pka2D4xe8AxhH0oxXomcgMZIknYZLLbZpTA1iHaEzb1cZnlqrIuBna1LqzXk8G6oSjGvDwt/eWGtQ3X3X9uNUWWORZnUAyeQ8sloKnU7ByH9KSt4Z8Kk0074E0WrER9cfqkVOUavRegWZLj8M6MFrdiCQYynhkyxoJUxiQgZHGLenrhtOsWDaSJQp
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39830400003)(136003)(396003)(376002)(16576012)(54906003)(956004)(8676002)(7416002)(5660300002)(6916009)(2616005)(36756003)(36916002)(44832011)(316002)(52116002)(83380400001)(42882007)(2906002)(16526019)(26005)(66556008)(30864003)(66476007)(186003)(478600001)(31696002)(66946007)(4326008)(83170400001)(53546011)(6486002)(8936002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dkREeEhkZ01yVjFjOVhRODFLY0FZSUx3QjFkek1IUUdKMC8ycDNCdEMweGkv?=
 =?utf-8?B?dkVBU1QrNEM2UDRUbi91SVNqVzNtS204bnpwVFV6aVhVQkNYbWFtYWU5NE9M?=
 =?utf-8?B?bnlPWk5SMEFKaGZsUmE4b0VyZE9ZUUN2bXVmUHA3WFlXYVBhalFZL3ovT25P?=
 =?utf-8?B?b1pUbFhNbUh3Ly9YWWFyZEdIeXh2TzhDejlheXdzaHNSTmJCRU9zNGJyaC9x?=
 =?utf-8?B?eHVRaHZrUzVDcm1YcUkyMTkyR3ZyVFNPeFppSkdxaVZtUmkrdDhlNFJnd3Ro?=
 =?utf-8?B?Tk4rUHBLRDkrcys3Tis4b3NESDdUdW9QaTc1OSs2bjlnNWpnYzZmWS9HL1ZF?=
 =?utf-8?B?enpZMUhRdGlrcFVOanVxOXFWaEVGQ1lnT2FHQU4zVHhZZGpOMzZNb0VjM0x1?=
 =?utf-8?B?b0xnZmc1aWc5VTNzSDc3VGM5S3pxQWwvV3d1aVZ6WnZtQi9BcEQwbFJhb2Fl?=
 =?utf-8?B?SXRLVGlrRXZoZmRjaEE2azhGY1BxejVka25LNUlCNzBWNzJHUkNQbVlXTXRJ?=
 =?utf-8?B?K2JiZ2hhV25YRzRUQ3c5RjE2dEUva0h6dTlaUm45ck1sZE50U3QyaGFDdzhW?=
 =?utf-8?B?WW5uSktQNm1nUWU3NVRRSkdzSkdMdk52VlhLVHpHaEpOR2tqL1NqZEZOd3l1?=
 =?utf-8?B?T0txSzJESExVSEw0TmFvWXI1YTN6UytQaWxIbEhnMjdiYzNIMm84cmRScnd3?=
 =?utf-8?B?c29VMFY5L2JoaWlKakJLQzh0ZjhBazk5anEydmpta2tZUllUYmdYSEFNNTBR?=
 =?utf-8?B?cUhVN0hEc01zazRJSDdKa0JiTjBSSnZ6R04xeDBLQTF5bmg5cmpZUFhQTjBs?=
 =?utf-8?B?clV6Rmwwa21wVHJvK2ZDelQyYnhCbVdUVUVtYXpSZkhDN09Od1dRRGhRc3NQ?=
 =?utf-8?B?d211aTJENjRRTHRpUS9kQlhLWWtJN0pQSnlpL2hFR0tYMzNqQTB2Y2hDVEZH?=
 =?utf-8?B?Q25PYTNQY1BkUU1hQnhOUElaR24rU2pXNVAxUWtSaCtiZExvYjRsU1BlSjVs?=
 =?utf-8?B?U0RydUdUZmk2RWhURis2YWFrSnA3dHNwOGNSbWVRUXFtZEkraHFjTW5kNFEr?=
 =?utf-8?B?Z2V2dEU4TlVPVWJUMjVYYjl0dUVqWkN0ZlRBOXAvVGdYMUZHbms4NXNWZlF4?=
 =?utf-8?B?YnB1bnREbTNGSXFqYmQyc1p2YlN5YVpIUlRVVk9uaXVPeTU5ZStobFJ4UGM1?=
 =?utf-8?B?MFlMMDBtVjBVK2FEOGxMK01JbldiVWpQODJZWGVlSG04SkIwbUQwZ1I0TUZn?=
 =?utf-8?B?QzVqWVZvTVo0SXVidUt1MjM3V0VqYTYraDREbXdlb1VWTWlyV0NNcXR5U3Jw?=
 =?utf-8?Q?7GkXHNICtUO6YOG+G2u+czpAerP6+oCrHW?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6427
X-CodeTwo-MessageID: c9fb02f5-3b53-4dd7-96df-4b01e4907227.20210121090254@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT024.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4e02fc39-cdc0-4ec5-ced3-08d8bdeb54dc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCCvdbJAzmUJ7PuSkG02ixK8OemrbEhco4/K1Rj3Vuakt9fAXZ6fvCJRIuyvwBk1gpLR//HSALxrzx4PzjtEn6ZOhksGsgsTrD4LdHBI3pCXspZn/SkyWOH1LZlsLt/pH3KbZkqRiwjcR6laHm3lrqCF9Dfnwlo9kL1rwPnvwPpD/b9bLz1ji8NOXltjglSITin1h4Q7RqqgQkSBMHCf+nwdoZpxMtZmuZAZJABVGhe1kqr6mDSWqJiHHNVXrpNXdUC8ywc0ppfWTAGHZ8leMdeffj8Fa4k3eEFqisrN/xYmF5EwHIRe/JZ0ylF+HRmZHvxLo5fjYlRefjT3XJUdLfRiCYvEXyL9I4FBYwFt7J5CpU0MQvYwNfZMRr+oxSVSp0u0gIE6uEgvNFVod6kWh8EF9o98zb56bACHNwO0KVaBDHN5SgoiiTcYSQLo+01zvXZb4Mg+GS4gVRP4zwAcHZ6O31/mN8PlntFEUFhC0xjTrhhKQiZ8Tc1gTAOIFyzx+kEUlUy6FiLk+hHPG0Yadp7vSUfiA4NbUWlI7hEF9HyhZAXiiBKMGyTRE0RukRhuAEXUW8pyG0waJeuQ8jtt9KC7tQqNQ2ZdqxSJ525N+LultlqzBZfQSQYnx4oIVM3tfWJ9KSoRaruNjkbiGUJKRMf8ndFxdQDIWsXZ1mBV/rP+XSk6DxWc2B2DGuSIrOZT
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(396003)(346002)(136003)(376002)(39830400003)(70586007)(70206006)(36756003)(54906003)(5660300002)(8676002)(32650700002)(42882007)(31686004)(4326008)(82310400003)(6916009)(7416002)(316002)(36916002)(336012)(30864003)(956004)(478600001)(15974865002)(7596003)(2906002)(6486002)(7636003)(8936002)(83170400001)(356005)(31696002)(16576012)(2616005)(186003)(16526019)(53546011)(83380400001)(44832011)(26005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 09:02:56.4868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bcf615-f483-4070-7120-08d8bdeb5835
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT024.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4061
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Comments inlined below.


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topicproducts.com=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 20-01-2021 21:22, Jonathan Cameron wrote:
> On Tue, 19 Jan 2021 13:46:22 +0100
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
>=20
>> The BMI088 is a combined module with both accelerometer and gyroscope.
>> This adds the accelerometer driver support for the SPI interface.
>> The gyroscope part is already supported by the BMG160 driver.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>
>> Changes in v6:
>> Hope you have good memory - v5 was almost a year ago now
> *laughs* fresh review so probably disagree with what I said back then on
> something :)
>=20
>=20
> A few really small comments inline seeing as you are respinning anyway.
>=20
>> Remove superfluous *val=3D0
>> Make sample_frequency selection into read_avail list
>>
>> Changes in v5:
>> Add includes and forward defines in header
>> BIT(7) instead of 0x80
>> Reset already sets defaults, do not set them again
>> Remove now unused bmi088_accel_set_bw
>> Remove unused AXIS_MAX
>> Use MASK define for ODR setting
>> Explain buffer use and alignment
>> Split bmi088_accel_set_power_state into "on" and "off" parts
>> Cosmetic changes to improve readability
>>
>> Changes in v4:
>> Remove unused #include directives
>> Remove unused #defines for event and irq
>> Replace (ret < 0) with (ret) for all regmap calls
>> Consistent checking of IO errors in probe and init
>> Removed #ifdef CONFIG_PM guard
>> Use bitops for set_frequency instead of loop with shift
>> s/__s16/s16/g
>> Remove excess blank lines
>> Don't return -EAGAIN in pm_runtime
>>
>> Changes in v3:
>> Processed comments from Jonathan Cameron and Lars-Peter Clausen
>> implement runtime PM (tested by code tracing) and sleep
>> fix scale and offset factors for accel and temperature and
>> return raw values instead of pre-scaled ones
>> Use iio_device_{claim,release}_direct_mode
>> Remove unused code and structs
>> Use a cache-aligned buffer for bulk read
>> Configure and enable caching register values
>>
>> Changes in v2:
>> Remove unused typedefs and variables
>> Fix error return when iio_device_register fails
>>
>>   drivers/iio/accel/Kconfig             |  18 +
>>   drivers/iio/accel/Makefile            |   2 +
>>   drivers/iio/accel/bmi088-accel-core.c | 630 ++++++++++++++++++++++++++
>>   drivers/iio/accel/bmi088-accel-spi.c  |  85 ++++
>>   drivers/iio/accel/bmi088-accel.h      |  18 +
>>   5 files changed, 753 insertions(+)
>>   create mode 100644 drivers/iio/accel/bmi088-accel-core.c
>>   create mode 100644 drivers/iio/accel/bmi088-accel-spi.c
>>   create mode 100644 drivers/iio/accel/bmi088-accel.h
>>
>> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
>> index 2e0c62c39155..cceda3cecbcf 100644
>> --- a/drivers/iio/accel/Kconfig
>> +++ b/drivers/iio/accel/Kconfig
>> @@ -157,6 +157,24 @@ config BMC150_ACCEL_SPI
>>   	tristate
>>   	select REGMAP_SPI
>>  =20
>> +config BMI088_ACCEL
>> +	tristate "Bosch BMI088 Accelerometer Driver"
>> +	depends on SPI
>> +	select IIO_BUFFER
>> +	select IIO_TRIGGERED_BUFFER
>> +	select REGMAP
>> +	select BMI088_ACCEL_SPI
>> +	help
>> +	  Say yes here to build support for the Bosch BMI088 accelerometer.
>> +
>> +	  This is a combo module with both accelerometer and gyroscope. This
>> +	  driver only implements the accelerometer part, which has its own
>> +	  address and register map. BMG160 provides the gyroscope driver.
>> +
>> +config BMI088_ACCEL_SPI
>> +	tristate
>> +	select REGMAP_SPI
>> +
>>   config DA280
>>   	tristate "MiraMEMS DA280 3-axis 14-bit digital accelerometer driver"
>>   	depends on I2C
>> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
>> index 4f6c1ebe13b0..32cd1342a31a 100644
>> --- a/drivers/iio/accel/Makefile
>> +++ b/drivers/iio/accel/Makefile
>> @@ -20,6 +20,8 @@ obj-$(CONFIG_BMA400_SPI) +=3D bma400_spi.o
>>   obj-$(CONFIG_BMC150_ACCEL) +=3D bmc150-accel-core.o
>>   obj-$(CONFIG_BMC150_ACCEL_I2C) +=3D bmc150-accel-i2c.o
>>   obj-$(CONFIG_BMC150_ACCEL_SPI) +=3D bmc150-accel-spi.o
>> +obj-$(CONFIG_BMI088_ACCEL) +=3D bmi088-accel-core.o
>> +obj-$(CONFIG_BMI088_ACCEL_SPI) +=3D bmi088-accel-spi.o
>>   obj-$(CONFIG_DA280)	+=3D da280.o
>>   obj-$(CONFIG_DA311)	+=3D da311.o
>>   obj-$(CONFIG_DMARD06)	+=3D dmard06.o
>> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/b=
mi088-accel-core.c
>> new file mode 100644
>> index 000000000000..788e54ed0728
>> --- /dev/null
>> +++ b/drivers/iio/accel/bmi088-accel-core.c
>> @@ -0,0 +1,630 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * 3-axis accelerometer driver supporting following Bosch-Sensortec chi=
ps:
>> + *  - BMI088
>> + *
>> + * Copyright (c) 2018-2020, Topic Embedded Products
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/delay.h>
> As below. Alphabetical ordering preferred.

Will do.

>=20
>> +#include <linux/slab.h>
>> +#include <linux/acpi.h>
>> +#include <linux/pm.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/regmap.h>
>> +#include <asm/unaligned.h>
>> +
>> +#include "bmi088-accel.h"
> ...
>=20
>> +static int bmi088_accel_chip_init(struct bmi088_accel_data *data)
>> +{
>> +	struct device *dev =3D regmap_get_device(data->regmap);
>> +	int ret, i;
>> +	unsigned int val;
>> +
>> +	/* Do a dummy read to enable SPI interface, won't harm I2C */
>> +	regmap_read(data->regmap, BMI088_ACCEL_REG_INT_STATUS, &val);
>> +
>> +	/*
>> +	 * Reset chip to get it in a known good state. A delay of 1ms after
>> +	 * reset is required according to the data sheet
>> +	 */
>> +	ret =3D regmap_write(data->regmap, BMI088_ACCEL_REG_RESET,
>> +			   BMI088_ACCEL_RESET_VAL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	usleep_range(1000, 2000);
>> +
>> +	/* Do a dummy read again after a reset to enable the SPI interface */
>> +	regmap_read(data->regmap, BMI088_ACCEL_REG_INT_STATUS, &val);
>> +
>> +	/* Read chip ID */
>> +	ret =3D regmap_read(data->regmap, BMI088_ACCEL_REG_CHIP_ID, &val);
>> +	if (ret) {
>> +		dev_err(dev, "Error: Reading chip id\n");
>> +		return ret;
>> +	}
>> +
>> +	/* Validate chip ID */
>> +	for (i =3D 0; i < ARRAY_SIZE(bmi088_accel_chip_info_tbl); i++) {
>> +		if (bmi088_accel_chip_info_tbl[i].chip_id =3D=3D val) {
>> +			data->chip_info =3D &bmi088_accel_chip_info_tbl[i];
>> +			break;
>> +		}
>> +	}
>> +	if (i =3D=3D ARRAY_SIZE(bmi088_accel_chip_info_tbl)) {
>> +		dev_err(dev, "Invalid chip %x\n", val);
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* Enable accelerometer after reset */
>> +	return bmi088_accel_enable(data, true);
>=20
> We bring the device up here, but I'm not seeing it turned off again
> in either error paths of probe or remove.
> Am I missing it somewhere?

Nah makes sense to put it back in the disabled state at removal.
I'll re-use the "suspend" code in the "remove" call so it'll be less code i=
n=20
total and things will be symetric.

>=20
>> +}
>> +
>> +int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
>> +	int irq, const char *name, bool block_supported)
>> +{
>> +	struct bmi088_accel_data *data;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +
>> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data =3D iio_priv(indio_dev);
>> +	dev_set_drvdata(dev, indio_dev);
>> +
>> +	data->regmap =3D regmap;
>> +
>> +	ret =3D bmi088_accel_chip_init(data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mutex_init(&data->mutex);
>> +
>> +	indio_dev->dev.parent =3D dev;
>> +	indio_dev->channels =3D data->chip_info->channels;
>> +	indio_dev->num_channels =3D data->chip_info->num_channels;
>> +	indio_dev->name =3D name ? name : data->chip_info->name;
>> +	indio_dev->available_scan_masks =3D bmi088_accel_scan_masks;
>> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
>> +	indio_dev->info =3D &bmi088_accel_info;
>> +
>> +	ret =3D pm_runtime_set_active(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pm_runtime_enable(dev);
>> +	pm_runtime_set_autosuspend_delay(dev, BMI088_AUTO_SUSPEND_DELAY_MS);
>> +	pm_runtime_use_autosuspend(dev);
>> +
>> +	ret =3D iio_device_register(indio_dev);
>> +	if (ret)
>> +		dev_err(dev, "Unable to register iio device\n");
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(bmi088_accel_core_probe);
>> +
>> +int bmi088_accel_core_remove(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>> +	struct bmi088_accel_data *data =3D iio_priv(indio_dev);
>> +
>> +	iio_device_unregister(indio_dev);
>> +
>> +	pm_runtime_disable(dev);
>> +	pm_runtime_set_suspended(dev);
>> +	pm_runtime_put_noidle(dev);
>> +
>> +	mutex_lock(&data->mutex);
>> +	bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_SUSPEND);
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(bmi088_accel_core_remove);
>> +
>> +/* When going into system sleep, put the chip in power down */
>> +static int __maybe_unused bmi088_accel_suspend(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>> +	struct bmi088_accel_data *data =3D iio_priv(indio_dev);
>> +
>> +	mutex_lock(&data->mutex);
>> +	bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_SUSPEND);
>> +	bmi088_accel_enable(data, false);
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused bmi088_accel_resume(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>> +	struct bmi088_accel_data *data =3D iio_priv(indio_dev);
>> +
>> +	mutex_lock(&data->mutex);
>> +	bmi088_accel_enable(data, true);
>> +	bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_ACTIVE);
>> +	mutex_unlock(&data->mutex);
>> +
>> +	return 0;
>> +}
>> +
>> +/* For runtime PM put the chip in suspend mode */
>> +static int __maybe_unused bmi088_accel_runtime_suspend(struct device *d=
ev)
>> +{
>> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>> +	struct bmi088_accel_data *data =3D iio_priv(indio_dev);
>> +
>> +	return bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_SUSPEND);
>> +}
>> +
>> +static int __maybe_unused bmi088_accel_runtime_resume(struct device *de=
v)
>> +{
>> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>> +	struct bmi088_accel_data *data =3D iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	ret =3D bmi088_accel_set_mode(data, BMI088_ACCEL_MODE_ACTIVE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	usleep_range(BMI088_ACCEL_MAX_STARTUP_TIME_US,
>> +		     BMI088_ACCEL_MAX_STARTUP_TIME_US * 2);
>> +
>> +	return 0;
>> +}
>> +
>> +const struct dev_pm_ops bmi088_accel_pm_ops =3D {
>> +	SET_SYSTEM_SLEEP_PM_OPS(bmi088_accel_suspend, bmi088_accel_resume)
>> +	SET_RUNTIME_PM_OPS(bmi088_accel_runtime_suspend,
>> +			   bmi088_accel_runtime_resume, NULL)
>> +};
>> +EXPORT_SYMBOL_GPL(bmi088_accel_pm_ops);
>> +
>> +MODULE_AUTHOR("Niek van Agt <niek.van.agt@topicproducts.com>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("BMI088 accelerometer driver (core)");
>> diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bm=
i088-accel-spi.c
>> new file mode 100644
>> index 000000000000..7794090b8e6d
>> --- /dev/null
>> +++ b/drivers/iio/accel/bmi088-accel-spi.c
>> @@ -0,0 +1,85 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * 3-axis accelerometer driver supporting following Bosch-Sensortec chi=
ps:
>> + *  - BMI088
>> + *
>> + * Copyright (c) 2018-2020, Topic Embedded Products
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/regmap.h>
>=20
> If no other reason for ordering ever so slight preference for
> alphabetical order.

Will do

>=20
>> +
>> +#include "bmi088-accel.h"
>> +
>> +int bmi088_regmap_spi_write(void *context, const void *data, size_t cou=
nt)

This should have been a static (as reported by build bot)

>> +{
>> +	struct spi_device *spi =3D context;
>> +
>> +	/* Write register is same as generic SPI */
>> +	return spi_write(spi, data, count);
>> +}
>> +
>> +int bmi088_regmap_spi_read(void *context, const void *reg,
>> +				size_t reg_size, void *val, size_t val_size)
>> +{
>> +	struct spi_device *spi =3D context;
>> +	u8 addr[2];
>> +
>> +	addr[0] =3D *(u8 *)reg;
>> +	addr[0] |=3D BIT(7); /* Set RW =3D '1' */
>> +	addr[1] =3D 0; /* Read requires a dummy byte transfer */
>> +
>> +	return spi_write_then_read(spi, addr, sizeof(addr), val, val_size);
>> +}
>> +
>> +static struct regmap_bus bmi088_regmap_bus =3D {
>> +	.write =3D bmi088_regmap_spi_write,
>> +	.read =3D bmi088_regmap_spi_read,
>> +	.reg_format_endian_default =3D REGMAP_ENDIAN_BIG,
>> +	.val_format_endian_default =3D REGMAP_ENDIAN_BIG,
>=20
> Aren't these both 8 bits, making endian rather irrelevant?

Indeed, all registers are accessed as 8-bit only. Where bulk-read is involv=
ed,=20
the byte order in interpreted in code.

>=20
>> +};
> ...
>=20

