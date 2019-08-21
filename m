Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1429751A
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2019 10:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfHUIhF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Aug 2019 04:37:05 -0400
Received: from mail-eopbgr690063.outbound.protection.outlook.com ([40.107.69.63]:39842
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727085AbfHUIhF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Aug 2019 04:37:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pif25F/HJC+IMBl5NGU2BQI8rcc8edWpVidiyu9ZWR3+8TGGjNLvJeQ6pWyIniUzP1qSsERb67Y/VtuB5QXK4OVwOHsw1aiqFTkv6Mdzg6k33U/VxDBw7lV2nhEy4nEJc1hKaY4bvD0BdRYWoI0FYLMP1bPLqjUrMxZzRUkqg4hvVPevWrW4rNR/kBKY9qAbuS5mSgB6ZU+ma3LZi0+9JCRgHV6rFOcP0KFPFJFGaLZvPl2Bgrr+G98cgSjuVViqnxjpdmSJ8zZ/Cjdm0GyYZmrqZPtHqd3Hn0N+CwRyHEAaF1DPpSIJ2+/M2Ojsa0DMyWhvDPWalwmew8L0fpo+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVkYCPSdIIeJmTrWtD+T5BFmGZyu+K6FPYhv8Gn5jXE=;
 b=Nre9yk2+tgYmyJEYaZ3dNroLlVHd3O+VtyOg57w6f3xqRqy0JJzSFi8jOEcq3c1BsTFVRTl/sxzs6UMjU5E43BkVUADMKnp/G2f6bq9zuML7n6XS3xC7sAfVnZIGjmLq0sIZQR5ajcTIctAf2YK8pw1urhaL9Dmsn7y3AcKXNbb7o2Zl9ZBGftaLwsyQtac9jOCiZ3Q9nipfAhh3kwSwgP4djMwCH9CASb3dEgkfMfiClqYII6EIgv3UYyK2dmFGDJ0sg2C2qECprGgEz+YvQV7K9+4BQRMUYfQynLyClDonpURvq9T9sCqAsbeQaIpIpf2zsd+y+Sa9gsMK5dDrMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=electromag.com.au smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVkYCPSdIIeJmTrWtD+T5BFmGZyu+K6FPYhv8Gn5jXE=;
 b=fSri4sCW7s//gKwd3CA9cyAQPLuLlWGLwPeh3Bkm2T/pXbr7tZQJn4SLhDeqgLExcibVnPJ7GCp5fISRVIuwd+dhgE8azBrnhaw0JMR1xtgGl8dLrZX2ESEj7PKrOsu1yz+9WNVndJE4pPJD0EJMTyTGfFUcnfOlaqri4Ooulzk=
Received: from MWHPR02CA0038.namprd02.prod.outlook.com (2603:10b6:301:60::27)
 by BYAPR02MB4037.namprd02.prod.outlook.com (2603:10b6:a02:f9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.18; Wed, 21 Aug
 2019 08:36:23 +0000
Received: from SN1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by MWHPR02CA0038.outlook.office365.com
 (2603:10b6:301:60::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2178.16 via Frontend
 Transport; Wed, 21 Aug 2019 08:36:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; electromag.com.au; dkim=none (message not signed)
 header.d=none;electromag.com.au; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT012.mail.protection.outlook.com (10.152.72.95) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2178.16
 via Frontend Transport; Wed, 21 Aug 2019 08:36:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i0M6M-0000O8-W9; Wed, 21 Aug 2019 01:36:18 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i0M6H-00009r-Ia; Wed, 21 Aug 2019 01:36:13 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x7L8a8ad018858;
        Wed, 21 Aug 2019 01:36:08 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1i0M6B-00008X-NA; Wed, 21 Aug 2019 01:36:07 -0700
Subject: Re: [PATCH 2/4] iio: adc: ina2xx: Setup better name then simple
 ina2xx
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
 <e1a9d7c5f94a4942a97a242e530a3bfdda8bbc74.1566310292.git.michal.simek@xilinx.com>
 <1c96bed1-2651-3667-3573-2167cd788bd7@electromag.com.au>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <282e9668-affd-7266-b144-125a59e08e5b@xilinx.com>
Date:   Wed, 21 Aug 2019 10:36:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1c96bed1-2651-3667-3573-2167cd788bd7@electromag.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(199004)(189003)(31696002)(44832011)(486006)(478600001)(426003)(23676004)(52146003)(2486003)(305945005)(229853002)(446003)(11346002)(230700001)(76176011)(6246003)(31686004)(47776003)(70206006)(336012)(70586007)(36386004)(106002)(65956001)(65806001)(8936002)(7416002)(36756003)(2906002)(356004)(6666004)(53546011)(186003)(5660300002)(54906003)(9786002)(8676002)(110136005)(4326008)(126002)(50466002)(476003)(81156014)(81166006)(316002)(58126008)(14444005)(2616005)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4037;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 678bcaee-0c35-42ac-0282-08d72612a466
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BYAPR02MB4037;
X-MS-TrafficTypeDiagnostic: BYAPR02MB4037:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR02MB40377E26BC41FA7EDD3B681CC6AA0@BYAPR02MB4037.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0136C1DDA4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: L3L9iPCRWfbXdrvZpRiMVBLjPXrP1tLecBUdF9nmhZnCevSGvOeDi9oTb+q5DZzhnlCduOKvEFgGU6/hJ8tRMVt2zymY6QLiJAdgb6VcgtAUzKaI6VRJIIyhPwyUix+c8MmH9UrfvsiwDcVekzClHYyJZk9NXQA88fPCbRU97ijN8XZkdP+wA2lkU3/cT9wcoL6CKqZnDrNMOLW/73HhsexHDvxlaryGIv4ExxiL1ClUaTW6CKbxxQURGZm/gI7OAI3iF2SUfzatubUnW+HfUQohTHH0G/h/2irgTM+bWhQJoT/QQP9Ph1E4dnYd0WWdjbTobjUl9Sjtbmf83esYU9NDf+X7RGA5Q+vmQxQQcYNqrS3yJsLzLBYF10rJpPO9o7q7qVF7b1ArwX5M9vQV3sa32aAAt5cxMXQWkaEgnOk=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2019 08:36:19.9725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 678bcaee-0c35-42ac-0282-08d72612a466
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4037
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 21. 08. 19 4:10, Phil Reid wrote:
> On 20/08/2019 22:11, Michal Simek wrote:
>> On systems with multiple ina2xx chips it is impossible to find out which
>> iio device is which one based on probe order. That's why it is
>> necessary to
>> setup better name based on possition.
>> The patch is reusing dev_name which is setup by core with client->name.
>>
>> name char array was setup to 128 byte length to correspond the same name
>> length by HID device.
>>
>> Before this patch:
>> iio:device9: ina226 (buffer capable)
>> After:
>> iio:device9: ina226-3-004a (buffer capable)
> 
> Could this break existing user space code that's just looking for just
> ina226.
> I2c bus numbers aren't all that great at id'ing devices either. It's
> better than
> nothing but depending on what cards we have plugged into our system the
> same device gets
> a different bus number.

Fair point. Let's wait what dt guys say about label property.
I can simply drop this patch and use just this.

indio_dev->name = of_get_property(np, "label", NULL) ? : id->name;

Thanks,
Michal
