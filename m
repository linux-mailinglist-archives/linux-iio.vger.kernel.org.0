Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB52F975BC
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2019 11:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfHUJMX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Aug 2019 05:12:23 -0400
Received: from mail-eopbgr700057.outbound.protection.outlook.com ([40.107.70.57]:57472
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbfHUJMX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Aug 2019 05:12:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbB0EqQGv/XPJXd0uSn+kiAjWarSq3iuhJZID26adsrRY2mEfCExkbw73X1K9IHCsHxqjPWCN6VPbNCaSJiQYjNFefbowtH+TIDdr6sybNiFxf6hnB35MlYmgN88P29fhJ+1QdZdAia8juyhUZzziXo999vzG7fbb0n+YCaNoziCJ/fuC8ge38ngu7oc+TBJFSMBdHUIBkj1aKNBqww+IKGfKPOtTRG9ZBk48ZSQueM1J8DV9lw987cZfn38DBHiowy3W9GK/7LxXR4rOOmZfQ9eJyo3MD0SN7rLLjsMNkSf+8gPerKxv5RbjNHQu3+PHOqsn9EuIVnrNljt44OzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIzmignZqShhqYYoKk9eBnoGqar1Lya9Kfay9bVwLic=;
 b=KQhkCgPUmtPJO8V0oOj3/q2dublA9zBjwJ9L3VxmFrhnwzfYOQ2rNHvLb6qt2uwsEGdd1afmcPivtX3ZFdXGgfSnKLpDG3oX9z5/elfTLjSeFNewC5j9+dRZZACj4BACdMEXaiPSN8WI/D6u8vuzKgs4Lni/JVxv6C9zVkDMQKZrezJq/Eh6Rk/uZRp+l9wddL1jqhftjhMZPf4X74PERcA2vPECm2sVY86BjTZQid1OSLpu9ImSd8vlxcVa02mmgSLNDpzd/GBJd7mBIZpNDLoq9uCuWySa5if0wDfGBgR9uzk+XBv0d5rgG6hvveTPxyuWbv3Ja0HtHFqztqqZiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=electromag.com.au smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIzmignZqShhqYYoKk9eBnoGqar1Lya9Kfay9bVwLic=;
 b=SRF7txpToEuzqvTVAsiSV7TYu+y/ARdFga0e6vSapQkjhbInFAqSLe1FnHwbqHt1J4B+BDPZPd4F5SluFCG5a6olTjxgilwLNp/I36X8DrwuJZCJG0DKgiuBltcOMXaI/04Gw8ePe65TtbzjNKSBgNYMYEwgB288mBKHvsdCDqs=
Received: from MWHPR02CA0013.namprd02.prod.outlook.com (2603:10b6:300:4b::23)
 by BYAPR02MB5303.namprd02.prod.outlook.com (2603:10b6:a03:67::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.18; Wed, 21 Aug
 2019 09:12:20 +0000
Received: from BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by MWHPR02CA0013.outlook.office365.com
 (2603:10b6:300:4b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.14 via Frontend
 Transport; Wed, 21 Aug 2019 09:12:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; electromag.com.au; dkim=none (message not signed)
 header.d=none;electromag.com.au; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT007.mail.protection.outlook.com (10.152.77.46) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2178.16
 via Frontend Transport; Wed, 21 Aug 2019 09:12:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:34442 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i0MfB-00025w-LM; Wed, 21 Aug 2019 02:12:17 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i0Mf6-0005jV-Hl; Wed, 21 Aug 2019 02:12:12 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x7L9C4gR012429;
        Wed, 21 Aug 2019 02:12:04 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1i0Mey-0005bl-DI; Wed, 21 Aug 2019 02:12:04 -0700
Subject: Re: [PATCH 4/4] iio: adc: ina2xx: Use label proper for device
 identification
To:     Phil Reid <preid@electromag.com.au>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, linux@roeck-us.net
Cc:     Colin Ian King <colin.king@canonical.com>,
        linux-iio@vger.kernel.org,
        =?UTF-8?Q?Stefan_Br=c3=bcns?= <stefan.bruens@rwth-aachen.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
References: <cover.1566310292.git.michal.simek@xilinx.com>
 <0542b562a813c5c22c42484ac24bbb626ac3c022.1566310292.git.michal.simek@xilinx.com>
 <970c3988-24e4-26c2-9027-d8ff40c3a9bb@electromag.com.au>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <bca73b6d-87ae-f8cc-b9f4-3b0a558942d9@xilinx.com>
Date:   Wed, 21 Aug 2019 11:12:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <970c3988-24e4-26c2-9027-d8ff40c3a9bb@electromag.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(2980300002)(199004)(189003)(31686004)(52146003)(4326008)(2486003)(70206006)(229853002)(76176011)(26005)(356004)(23676004)(11346002)(486006)(476003)(2616005)(336012)(6666004)(44832011)(2906002)(70586007)(126002)(446003)(8936002)(426003)(186003)(14444005)(53546011)(5660300002)(316002)(9786002)(7416002)(106002)(81166006)(81156014)(31696002)(8676002)(2870700001)(36386004)(58126008)(65956001)(6246003)(65806001)(305945005)(36756003)(54906003)(47776003)(50466002)(110136005)(478600001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5303;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52df10bb-b351-4ed7-571d-08d72617aa95
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BYAPR02MB5303;
X-MS-TrafficTypeDiagnostic: BYAPR02MB5303:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR02MB5303C481828DDE8EC28F9ECDC6AA0@BYAPR02MB5303.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:480;
X-Forefront-PRVS: 0136C1DDA4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: vyyzriMOl2jEEPUUpwOAdXQdYRf8630tV4LVOFuNA+Nr4ID99unr+xRxKHxYxy1ITStsLh3x7w2eIfeYRgxuaA2JoCOk1tQi/ByRzJdXk6H6YYTVqEVVtdU68IDMBMFBFMxWVqLBtWdpbtmzDDA8hrgZcb8KndEtffZHBXr1Ez6ebKYMJajDpFikc8H3dwb+kunmtvLxt1M5ZwV3Jxtlpw6Vy0aZXa9KjZaBHW46PmJTx7mIt4XtCv7CjF/+vcTMTsLKVMnb1QSreN+QL0xEgISxqnmLsF+AmJLUUFY/PqUvi9nJETO0EZoU2c06jjiUR/aeXZnt8ToX/+gEFJgCMjnzsk7DF1mSGk1YIHnklcRCQncaeEpJ75NO3AaPGnDjWNEobG+DbLuLcB1/EF1uoHgEkGEwLgVRyva9X8kMzgk=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2019 09:12:18.2420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52df10bb-b351-4ed7-571d-08d72617aa95
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5303
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 21. 08. 19 4:11, Phil Reid wrote:
> On 20/08/2019 22:11, Michal Simek wrote:
>> Add support for using label property for easier device identification via
>> iio framework.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>   drivers/iio/adc/ina2xx-adc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
>> index 7c7c63677bf4..077c54915f70 100644
>> --- a/drivers/iio/adc/ina2xx-adc.c
>> +++ b/drivers/iio/adc/ina2xx-adc.c
>> @@ -1033,7 +1033,7 @@ static int ina2xx_probe(struct i2c_client *client,
>>       snprintf(chip->name, sizeof(chip->name), "%s-%s",
>>            client->name, dev_name(&client->dev));
>>   -    indio_dev->name = chip->name;
>> +    indio_dev->name = of_get_property(np, "label", NULL) ? : chip->name;
>>       indio_dev->setup_ops = &ina2xx_setup_ops;
>>         buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
>>
> I like this personally. It'd be nice if it was a core function so
> it could be an opt in to any iio device.
> 
> Don't know how well received that'd be thou.
> 

Something like this?

diff --git a/drivers/iio/industrialio-core.c
b/drivers/iio/industrialio-core.c
index 524a686077ca..d21b495d36a1 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1647,6 +1647,9 @@ int __iio_device_register(struct iio_dev
*indio_dev, struct module *this_mod)
        if (!indio_dev->dev.of_node && indio_dev->dev.parent)
                indio_dev->dev.of_node = indio_dev->dev.parent->of_node;

+       indio_dev->name = of_get_property(indio_dev->dev.of_node,
"label", NULL) ? :
+                                         indio_dev->name;
+
        ret = iio_check_unique_scan_index(indio_dev);
        if (ret < 0)
                return ret;


M
