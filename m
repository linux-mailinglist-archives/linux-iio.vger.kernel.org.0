Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD4C877A1
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2019 12:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfHIKiK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Aug 2019 06:38:10 -0400
Received: from mail-eopbgr780040.outbound.protection.outlook.com ([40.107.78.40]:26160
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbfHIKiK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Aug 2019 06:38:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vpqs9BmRfG9u1sZIvrKKgQFCmZtBIrKUt64IpkHJk1IBAcfLk0YY7Xkwnt5by+Y0iERK/GCWCPeb5x2Y0IRAHQE2Jd/CrnnmbbHDTZpL6MY6k+ul7lJXgGT38ztnq1CPLpdSv6zeCg60ePq5DjpyPscdNgwxi8rM+iO0a1s6RL8W98knDuzfI1sncZ/K2IMI8s2TiXnIwyU4/ugVYcvVcLCDkHL+pTXp2LtaQErH274FY0BUPeOUBF8gxOlRMMq9DPU9+TTMIUT/vStpnMm2PR0NLYB7LTfoY1WWsau4cgzsK7S1CwsADgXyxAhD1E9qxyAt9mkt2sVJKBTjjX5TQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOaoXhSoeojsw9lCagC2OttUgoFzWJmgr+s+t4wzTq8=;
 b=f4fPWBYUI1fFlShQ2tT8qi+vksCgveNBFSb1fPYrnqxzG2T8fmhpA53ySC/gF7oVIVMUyBjyuRbmThG/lYvxxkgZmSvfSPSaS657GzqGMZ3KVP2ebQ2cVhwpv8xgfhDatof5WnhDS6KZf2WbnCWqCEAfqetEhgA3bDLVaBDk3DEOqFtrzdrvxWwr/w1BOxunFxnYI9EfMYD0kDK0i2nKO4LoTuAdRwjyW6wgLY8JZGQLBXYCNaMT5E+w7p4DFiHDih1j6MlImYf13RERz56RaegnWQC7/CvO2PDr7U3Ch0yZ9DJF8H6u5Gpm7KSwrZuiWJe8oeaOaG6bs1K81PSfqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=xilinx.com;dmarc=bestguesspass action=none
 header.from=xilinx.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOaoXhSoeojsw9lCagC2OttUgoFzWJmgr+s+t4wzTq8=;
 b=VzhAIzuZUVizV/RWtUqINK7dhdiYZwKFEswdfe8X4MN3cv56yzZXDv5KmS5HGBB07jemnwLZ8F+/3gjlwdSIa5yxuUNPWbaISK40nRCm+k2Q4l+rT3h4mOXr4Yhv++deaE5OJ80OiHdYadjkC0vTyOBHxBx9csLUH3iNodOombY=
Received: from DM6PR02CA0005.namprd02.prod.outlook.com (20.176.108.18) by
 SN6PR02MB4831.namprd02.prod.outlook.com (52.135.116.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 9 Aug 2019 10:38:07 +0000
Received: from BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by DM6PR02CA0005.outlook.office365.com
 (2603:10b6:5:1c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14 via Frontend
 Transport; Fri, 9 Aug 2019 10:38:07 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT007.mail.protection.outlook.com (10.152.77.46) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Fri, 9 Aug 2019 10:38:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:55049 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hw2He-0007CY-75; Fri, 09 Aug 2019 03:38:06 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hw2HZ-0005Vk-4R; Fri, 09 Aug 2019 03:38:01 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x79Abxfv004123;
        Fri, 9 Aug 2019 03:38:00 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1hw2HX-0005Vf-N7; Fri, 09 Aug 2019 03:37:59 -0700
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        mtitinger@baylibre.com, Kevin Hilman <khilman@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Guenter Roeck <linux@roeck-us.net>, narmstrong@baylibre.com
From:   Michal Simek <michal.simek@xilinx.com>
Subject: ina226 as IIO device instead of HWMON
Message-ID: <24e73088-94f5-c231-37a4-90f1f63f0587@xilinx.com>
Date:   Fri, 9 Aug 2019 12:37:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(346002)(2980300002)(189003)(199004)(2486003)(36756003)(356004)(64126003)(2501003)(14444005)(6306002)(966005)(230700001)(26005)(23676004)(52146003)(4744005)(186003)(305945005)(44832011)(9786002)(16799955002)(65806001)(65956001)(106002)(31696002)(15188155005)(476003)(8676002)(50466002)(70206006)(58126008)(110136005)(2616005)(8936002)(316002)(47776003)(126002)(31686004)(426003)(63266004)(336012)(478600001)(65826007)(5660300002)(81156014)(70586007)(486006)(2906002)(81166006)(42866002)(5001870100001)(19623215001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4831;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05159f57-aeef-4541-cac0-08d71cb5aa9d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:SN6PR02MB4831;
X-MS-TrafficTypeDiagnostic: SN6PR02MB4831:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <SN6PR02MB483119A7E85386D17F6BB4DAC6D60@SN6PR02MB4831.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 01244308DF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: +LvfpEsWFJgeSB+Vs7BJYKw3G4lzQkdbqXUId+FhuQnj9tIJU5WtZlFdZf7AotbV2NBEfjtefE1Sbwmgl1HaJaNJZic16cLBrRBBdYAMzBv4HpHi5SY2DPaaQrf1xtUeepUyR8Vet9ei2ClcBXfCbk8pb7ZHyT3CanwA/wi4R6AIy69HdQRrjhQK1JUlQXwci4gALaAmDo5sgJChoqaio/B7X5FtFMHB1B3yGoMK/r20DSct5BYkuhH+YPDbr9YiYw+DcLUQI94hxvciGPXpEznpMmHTTr5uhJ2/abn72j+6UTol4lrV1YdPV2DNwwRa2GDuIcgYf9+DAYOXYz3dFuiwl9+XbMxFdJwlIC1Ir1cxduzqS24b01ap8FdF7cKFZOxk/1+nrF1gIuddwpKLH6etz2EcXZViyo9te0+0EBA=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2019 10:38:07.1599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05159f57-aeef-4541-cac0-08d71cb5aa9d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4831
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

we are dealing with one issue with ina226 on xilinx platform when hwmon
driver is used. We have board for battery monitoring with shunt resistor
setup to 10 Ohm which is out of config value in hwmon driver. I have
temporary code to workaround this but I have also found that ina226 is
supported via iio framework. I have seen that Baylibre was trying to add
generic iio support to sigrok.
http://wiki.baylibre.com/doku.php?id=acme:oldstart

I expect you wanted to use sigrok also for ina226.

Anyway my question is if there is any standard tool which is capable to
calculate and show information from iio ina226 chip which is can be used
instead of lm-sensors and hwmon driver.

I would expect that iio-hwmon could be also used but didn't try that yet
with ina226 chip.

Thanks,
Michal
