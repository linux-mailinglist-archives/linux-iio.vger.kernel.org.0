Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC82187B8D
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2019 15:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfHINmS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Aug 2019 09:42:18 -0400
Received: from mail-eopbgr720054.outbound.protection.outlook.com ([40.107.72.54]:51616
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbfHINmS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Aug 2019 09:42:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcbFzZEbBwSoq77sxP1xG4BZZBBZiQID03NnA6wC6hbVVQ1HLx/DLOlkAnUOjdq++FldZTqutNVPE6GFIJZLkM1VIqiZ1yHHl2BK+nQqunmtcNjp9UkaPm6CfvM8XaFRrPHtZV23wqq/o9F7LwfdDTG2MVwNbU7HaKKzPlFlmaPf30EMCC9JdK39zRuvmV9KFIxFT1sKyGntwrovhnUNSyhLbn1L17DYMH9VubmiGhOoY0uKgNzYeY67KeS8eflcn4uTAuDxt1JRnK0zn4juUtb/f6gH6stjoM3mmMzRXDmqnCAAwTn3oJeeQAuuWOWxNsKbMwtQP4G530yOEDH7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eA3reDPRKvxtUMPs96iWt0dr/nF5pBZz4C99poFv/fE=;
 b=Qs0b4IQRQEt8u28AixEMxeYiUM83wjKRoUjZLssvOINj9Udv8zxV0jAGHTR8uXecTYgR6iRmFlIlAGxUj3K0TAlg+LwNY+Ff/7UOgIgboIK7mNQvhlN+D8k67LDELkHuu1ipkVebL/nl5GVxcYTaM8NRbkn0j/EFFV+xy3cb8E2PnlEpjA0UFbVkoeUM0N78T7v8zlsR9VII3aN6WhnmloQzQGUZsEZwEIPNPFKp2fr1DHM67hfMGLEDcYRzi61I28xzX519m+tnz+LvQQWPd3XTK1xsBD9M/WxfCjJdt/GSdAArrNUbvvnOgdygx1o8VXr4kap8pMNyh1ZqbT41Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eA3reDPRKvxtUMPs96iWt0dr/nF5pBZz4C99poFv/fE=;
 b=VT20mNzWMoGiMp6VKawQ1ZWtApJQB/QcTdGzNeS08J1beoWMo81QqswgAThF77mPgNtQDrL6psmujgHD4J1xkFf6X470QGugv8vCr4VZOFe17s54wjgAqRVOQ3YeJDfWYn2sC41WZ3u/f0MOpP+hzJyxAXRqzELDoF7J8D+5FBA=
Received: from DM6PR02CA0016.namprd02.prod.outlook.com (2603:10b6:5:1c::29) by
 BL0PR02MB4818.namprd02.prod.outlook.com (2603:10b6:208:28::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Fri, 9 Aug 2019 13:42:14 +0000
Received: from SN1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by DM6PR02CA0016.outlook.office365.com
 (2603:10b6:5:1c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.16 via Frontend
 Transport; Fri, 9 Aug 2019 13:42:14 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT051.mail.protection.outlook.com (10.152.73.103) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Fri, 9 Aug 2019 13:42:13 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hw59p-0006b8-Dr; Fri, 09 Aug 2019 06:42:13 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hw59k-0002oy-B3; Fri, 09 Aug 2019 06:42:08 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x79Dg3nB012094;
        Fri, 9 Aug 2019 06:42:03 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1hw59e-0002nt-N1; Fri, 09 Aug 2019 06:42:02 -0700
Subject: Re: ina226 as IIO device instead of HWMON
To:     Guenter Roeck <linux@roeck-us.net>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        mtitinger@baylibre.com, Kevin Hilman <khilman@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>, narmstrong@baylibre.com
References: <24e73088-94f5-c231-37a4-90f1f63f0587@xilinx.com>
 <a3760f34-02a3-a6ee-6b97-2705612aa735@roeck-us.net>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <7405c36a-797e-d25f-1a70-19f4a0b1de04@xilinx.com>
Date:   Fri, 9 Aug 2019 15:42:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a3760f34-02a3-a6ee-6b97-2705612aa735@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(199004)(189003)(356004)(126002)(9786002)(53546011)(2486003)(446003)(6306002)(58126008)(81156014)(11346002)(52146003)(478600001)(81166006)(6246003)(15188155005)(76176011)(426003)(229853002)(966005)(26005)(65956001)(65806001)(8936002)(5660300002)(36386004)(2906002)(23676004)(50466002)(230700001)(70206006)(14444005)(36756003)(305945005)(486006)(31696002)(31686004)(44832011)(70586007)(336012)(47776003)(476003)(186003)(65826007)(316002)(16799955002)(64126003)(110136005)(2501003)(63266004)(2616005)(106002)(8676002)(19623215001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4818;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc0d92ff-e356-4ce7-6084-08d71ccf6301
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BL0PR02MB4818;
X-MS-TrafficTypeDiagnostic: BL0PR02MB4818:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <BL0PR02MB48185791813413391E8085B2C6D60@BL0PR02MB4818.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 01244308DF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: yNoQTlbQhW9cWRYw35pwayWC5yvs3sf3wp4oLLHGjgaFidqAn7Xce64t39JcwtH+H4/BBFnPYnsfvlCfjVFU/EINsgOidfYtBAFSvF5SoLjLD9CufrUEKDqUx0xcGhPIAkkHQAXsA7S4GKiJCRkc1vde7CLQ3xFqqv/Dm1qqMeMKdX8VyXxFM7Iavo5NB3CYF74hNtkl61UJx+SQXm0874a/J267ne42wESiFPb+RX7o2VAGydkgpuab3t7g6yEWmlBYxmUYum8dRhbJbFBd3vQain7IPyizoS8bykHR5wf+L0skcoxdX5vSix3UnAzhK35D8cOSUTQUR0AgbxhKZH1aVXzg7CSBmNjFQXi/g73cPcEAPzv+TuceboDAJ3eGO5Eo562qNe9ntZIqy5812pkpFCcb8Pok7k4zAF4UlIM=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2019 13:42:13.8104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0d92ff-e356-4ce7-6084-08d71ccf6301
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4818
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 09. 08. 19 15:02, Guenter Roeck wrote:
> Hi Michal,
> 
> On 8/9/19 3:37 AM, Michal Simek wrote:
>> Hi,
>>
>> we are dealing with one issue with ina226 on xilinx platform when hwmon
>> driver is used. We have board for battery monitoring with shunt resistor
>> setup to 10 Ohm which is out of config value in hwmon driver. I have
> 
> Took me a while to understand that you mean 10 Ohm, not mOhm.

yes.

> Well, yes, that is a bit large. I'd be open to accept a patch fixing that,
> though I don't immediately know how to update the devicetree property (and,
> unless I am missing something, the iio driver has the same problem).

There is shunt-resistor property in uOhm that's why 10 Ohm is like this
shunt-resistor = <10000000>;

> 
>> temporary code to workaround this but I have also found that ina226 is
>> supported via iio framework. I have seen that Baylibre was trying to add
>> generic iio support to sigrok.
>> http://wiki.baylibre.com/doku.php?id=acme:oldstart
>>
>> I expect you wanted to use sigrok also for ina226.
>>
>> Anyway my question is if there is any standard tool which is capable to
>> calculate and show information from iio ina226 chip which is can be used
>> instead of lm-sensors and hwmon driver.
>>
>> I would expect that iio-hwmon could be also used but didn't try that yet
>> with ina226 chip.
>>
> 
> I don't immediately see why iio-hwmon couldn't be used. Also, if you don't
> use the ina226 as hardware monitoring device, iio would be a more
> appropriate
> solution anyway.

I have tried this and found that IIO_POWER is not exported via iio-hwmon
driver.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
/tree/drivers/hwmon/iio_hwmon.c?h=next-20190809#n104

It is easy to add because ina226 iio export power via channel 2

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/iio/adc/ina2xx-adc.c?h=next-20190809#n690

Also dt description is easy to add. + iio-channels = <1>; to ina226 dt node.
       iio-hwmon {
               compatible = "iio-hwmon";
               io-channels = <&ps_pmbus 1>, <&ps_pmbus 2>, <&ps_pmbus 3>;
       };

> 
> FWIW, we should actually remove the in22xx hwmon driver at some point and
> ask users to use the iio driver combined with the iio-hwmon bridge instead
> (after making sure that the iio driver combined with the iio-hwmon bridge
> provides the same functionality).

The functionality is likely the same but I would expect that with this
new driver we should get something more. Especially that sigrok
connection looks interesting.
In our system we have SoC which have a lot of ina226 which monitors the
second SoC and would be nice to get precise information or graphs out of
it via standard user space tools or directly to web page.

Thanks,
Michal

