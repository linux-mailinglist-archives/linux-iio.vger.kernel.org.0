Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A46099DD76
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2019 08:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfH0GPX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Aug 2019 02:15:23 -0400
Received: from mail-eopbgr820085.outbound.protection.outlook.com ([40.107.82.85]:12385
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbfH0GPW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Aug 2019 02:15:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6xyHJ+r2XJQn/NiDaCoAuRGQmFs1XayJTvf2DPHeopaIeFqaHGZNbBQQbSnneR70KOtlbgQC7FTgwZBH/U7KX9JhWkfzilR/niiz60sP4FVu12QftIhQI5ejjSvm1JXwozrzvfrVa9OVRM6swCeB+jWz5SEPl9hYzpOxnpyw88ZsvdtR8LqkRt2fQjFbb/LgZ1o3PjJdrqjn5LNeQVvulxmPP2ja1fB1o2zSgr2HPeJlz3NoxyIQ9/ylwD7iL7bGytZhBf58k3O5C0fZVA18iebvN9C51vNqkukaRlht5KaZt7y146+9cWNBjBMOTuWmlyJ/plgfjto2cn0roJhIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfx6WV4kn+AaeJYJ5MgHv3HuI2PI0SsjWKSLF19xHsE=;
 b=jv5YJAPe2anT7NJL4E1rbJIP6+DuT9vsDsQErUVZTRHu3FQK3MkPDKeAE+uQP020zh6LBu0H0lTLqYBjN8vkPlhG5x0rBN4TEVlEzm8doV+btkx2pAU4rGFkW5XyU+DU1Qh60mv7OTOqRT/p/YU4IZeW85/NC4cVXlGmZ+quP5XAlOU8TiJq/63PN6O7hrOfeckfsXHTDK34cjENHZIKcbjG+SB1PcXGb6biP9mG1z8lWB/j0AQ738uJVo+NcKnhtQ4m3ULGRO2hs9RVcYiQd5lp/1yZeZlS2JKPZv5iBHDFp63LaFY716oohu9PI4FuKb8Q/TSDfcFarYfM2mIxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=gmx.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfx6WV4kn+AaeJYJ5MgHv3HuI2PI0SsjWKSLF19xHsE=;
 b=PiU6LfnvHyZGjguFBMmRCZNrV2ckbzhIM0qfwN5iI1zkNyEGCB1wYHHNgDKVzHLANLMinTh0HFp6KXH1UwDfPBsHoiK8LROIaEYmqtF9SauPIqR9aPzk7gQ4MTem/73t3Iabxe+YV4dzJi/YH/JytM4XZBGf+3Zyg5YAZH3ulBg=
Received: from BN6PR02CA0038.namprd02.prod.outlook.com (2603:10b6:404:5f::24)
 by SN6PR02MB4048.namprd02.prod.outlook.com (2603:10b6:805:2c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21; Tue, 27 Aug
 2019 06:15:19 +0000
Received: from CY1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BN6PR02CA0038.outlook.office365.com
 (2603:10b6:404:5f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.17 via Frontend
 Transport; Tue, 27 Aug 2019 06:15:17 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT017.mail.protection.outlook.com (10.152.75.181) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2199.13
 via Frontend Transport; Tue, 27 Aug 2019 06:15:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:52175 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i2UlA-0002Uv-D2; Mon, 26 Aug 2019 23:15:16 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i2Ul5-0005UP-9j; Mon, 26 Aug 2019 23:15:11 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1i2Ukw-00057v-GZ; Mon, 26 Aug 2019 23:15:02 -0700
Subject: Re: [PATCH 4/4] iio: adc: ina2xx: Use label proper for device
 identification
To:     Phil Reid <preid@electromag.com.au>,
        Jonathan Cameron <jic23@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, linux@roeck-us.net,
        Colin Ian King <colin.king@canonical.com>,
        linux-iio@vger.kernel.org,
        =?UTF-8?Q?Stefan_Br=c3=bcns?= <stefan.bruens@rwth-aachen.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
References: <cover.1566310292.git.michal.simek@xilinx.com>
 <0542b562a813c5c22c42484ac24bbb626ac3c022.1566310292.git.michal.simek@xilinx.com>
 <970c3988-24e4-26c2-9027-d8ff40c3a9bb@electromag.com.au>
 <bca73b6d-87ae-f8cc-b9f4-3b0a558942d9@xilinx.com>
 <20190825190753.7d52c3f9@archlinux>
 <af5fdfc3-dbc8-40fc-2893-c786670f28d4@electromag.com.au>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <2135d69c-c429-00ad-9ddf-41c2e88d6d06@xilinx.com>
Date:   Tue, 27 Aug 2019 08:14:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <af5fdfc3-dbc8-40fc-2893-c786670f28d4@electromag.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(396003)(2980300002)(199004)(189003)(5660300002)(26005)(53546011)(478600001)(186003)(426003)(316002)(7416002)(76176011)(336012)(36386004)(446003)(11346002)(36756003)(2616005)(476003)(50466002)(486006)(81156014)(65806001)(81166006)(8676002)(44832011)(2486003)(52146003)(23676004)(58126008)(110136005)(4326008)(31686004)(8936002)(2906002)(2870700001)(6246003)(6666004)(70586007)(14444005)(70206006)(126002)(31696002)(305945005)(9786002)(356004)(229853002)(65956001)(106002)(47776003)(54906003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4048;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e80f1b5-5448-457d-c680-08d72ab5ee7b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:SN6PR02MB4048;
X-MS-TrafficTypeDiagnostic: SN6PR02MB4048:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR02MB404896BB49A0017E148FA8E2C6A00@SN6PR02MB4048.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0142F22657
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: clNwxkhKEn9PSaNiqoPDCAjALzRHfuwEl1Vw/W+fr8MDzGnCqzoM25YOY26+4Co4taxjdyfzxd8QCeBMcu6a7z6o9+FE84APHzySHHfIVQzNkDA4xp7is+Ayk8SMmyJRoedLwMRd46jZBvfpJ5Cn25mIzAA9WkNYu/rvm+m50jnGxznGxdxSMkEs6sOQ+pqxQ7Wd/XuiMNkONmUzsRXI3G9DRP/yrFUXhO3vhwVIGgoXVgI4laRXRoM8wwjFJgLExGm/X3p9aFm6jn0xcmQIyrRqBPigAtyzlNJYf9Ob1Oa/x/cGY2Zo4JS0z41zgiVbJn3CcMuwHySluwjJskU9j8UdhQFUcIw5Eh04IgLEbe8SQeD3wl0J4SbSpllE0bDW0HlZrQshqPTnTatajZFDqEts33hke32SR9s1jS5Q+lE=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2019 06:15:16.8886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e80f1b5-5448-457d-c680-08d72ab5ee7b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4048
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 27. 08. 19 5:55, Phil Reid wrote:
> On 26/08/2019 02:07, Jonathan Cameron wrote:
>> On Wed, 21 Aug 2019 11:12:00 +0200
>> Michal Simek <michal.simek@xilinx.com> wrote:
>>
>>> On 21. 08. 19 4:11, Phil Reid wrote:
>>>> On 20/08/2019 22:11, Michal Simek wrote:
>>>>> Add support for using label property for easier device
>>>>> identification via
>>>>> iio framework.
>>>>>
>>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>>> ---
>>>>>
>>>>>    drivers/iio/adc/ina2xx-adc.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/iio/adc/ina2xx-adc.c
>>>>> b/drivers/iio/adc/ina2xx-adc.c
>>>>> index 7c7c63677bf4..077c54915f70 100644
>>>>> --- a/drivers/iio/adc/ina2xx-adc.c
>>>>> +++ b/drivers/iio/adc/ina2xx-adc.c
>>>>> @@ -1033,7 +1033,7 @@ static int ina2xx_probe(struct i2c_client
>>>>> *client,
>>>>>        snprintf(chip->name, sizeof(chip->name), "%s-%s",
>>>>>             client->name, dev_name(&client->dev));
>>>>>    -    indio_dev->name = chip->name;
>>>>> +    indio_dev->name = of_get_property(np, "label", NULL) ? :
>>>>> chip->name;
>>>>>        indio_dev->setup_ops = &ina2xx_setup_ops;
>>>>>          buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
>>>>>   
>>>> I like this personally. It'd be nice if it was a core function so
>>>> it could be an opt in to any iio device.
>>>>
>>>> Don't know how well received that'd be thou.
>>>>    
>> I'm not particularly keen on changing the semantics of existing
>> ABI, but how about adding new ABI to provide this?
>>
>> /sys/bus/iio/devices/iio\:device0/label for example?
>>
>> I haven't thought about it in depth yet though.  If you spin
>> a patch with that and the DT docs we'll be more likely to get
>> a view from DT maintainers if this is acceptable use of label.
>>
> 
> I've sent "iio: core: Add optional symbolic label to device attributes"
> for further discussion.

Series looks good. I expect that there will be also update in libiio if
this is accepted.

Thanks,
Michal
