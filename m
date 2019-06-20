Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B395F4CAF6
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2019 11:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfFTJfX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 05:35:23 -0400
Received: from mail-eopbgr770071.outbound.protection.outlook.com ([40.107.77.71]:9094
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725925AbfFTJfX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Jun 2019 05:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0PVaOH+gsirioJtKnMwB8zuZ8zQabuEKQHuNYKFLpU=;
 b=SZk8M3QwB/vXX00qWoqk5iX2bUQdTl06qIpitoezhJIr3hlbhNpjTG0USrVGNpofM9XioGaYU+FaDF70BWpX1HJScXVFGvuK3Gwm/kIowovisCjrJs2d6r6QfLUGsLfh5JdbCxQ2K1Dzh4NitPfnCGXSdl1Y0kDXVExWxKDvQAg=
Received: from BL0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:2d::21)
 by MWHPR03MB3136.namprd03.prod.outlook.com (2603:10b6:301:3c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.13; Thu, 20 Jun
 2019 09:35:20 +0000
Received: from SN1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BL0PR03CA0008.outlook.office365.com
 (2603:10b6:208:2d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14 via Frontend
 Transport; Thu, 20 Jun 2019 09:35:20 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT040.mail.protection.outlook.com (10.152.72.195) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Thu, 20 Jun 2019 09:35:19 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5K9ZI0m011368
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 20 Jun 2019 02:35:18 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Jun 2019 05:35:17 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [RESEND PATCH 1/4] iio: adc: ad7124: Remove input number limitation
Date:   Thu, 20 Jun 2019 12:34:49 +0300
Message-ID: <20190620093452.12891-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(2980300002)(37524003)(199004)(189003)(50466002)(70206006)(356004)(5660300002)(186003)(478600001)(47776003)(246002)(7696005)(16586007)(77096007)(1076003)(316002)(2351001)(336012)(8936002)(48376002)(26005)(4326008)(486006)(44832011)(126002)(2906002)(6666004)(51416003)(476003)(426003)(107886003)(54906003)(50226002)(106002)(86362001)(6916009)(305945005)(36756003)(70586007)(72206003)(2616005)(7636002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3136;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d04fc1e7-2ec0-478e-ef7e-08d6f5629c36
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:MWHPR03MB3136;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3136:
X-Microsoft-Antispam-PRVS: <MWHPR03MB31361CDCCC5F3A812594607C81E40@MWHPR03MB3136.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0074BBE012
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: xs/+cMWSsbRBHi+CvljPkJPq5iybrBKOomRIUiV7x8b9DCREi/TlJSIFSP4MpkmYJkKzVlb0A0KoxvV/bQeG97qqPUZvrqG858Mqnw03iTCbmFMBhexWiSoomQE6sj+ZBurZixDAIq6/17efa4ADv471l5FEWKpJ+QjYj2zqUuGtpqSwg4Ra8r7DL0ATpRcLZ74rasKos/yUk2lxzA9kyCy4SwuvVpktnynWnyC32vrnEZQygPh2C/+Ajkqei6JeiPW0KFIOPrCluauWFOnr0NTgAqpaWf19BeRV4QpupgnnUy0Nm0yG6jSPLzZMpTtWIWTKnPZyQNC2h30ADDC5gOS+vFlTuq9A3tR6W54CC7cd38waH6FFWiBwfop1Oax+oEiOzmLDKb6OpW/JfM5JADXYhoS14EHCb6iKlocRpZg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2019 09:35:19.2627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d04fc1e7-2ec0-478e-ef7e-08d6f5629c36
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3136
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver limits the user to use only 4/8 differential inputs, but this
device has the option to use pseudo-differential channels. This will
increase the number of channels to be equal with the number of inputs so 8
channels for ad7124-4 and 16 for ad7124-8.

This patch removes the check between channel nodes and num_inputs value.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/iio/adc/ad7124.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 659ef37d5fe8..810234db9c0d 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -462,13 +462,6 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 		if (ret)
 			goto err;
 
-		if (ain[0] >= st->chip_info->num_inputs ||
-		    ain[1] >= st->chip_info->num_inputs) {
-			dev_err(indio_dev->dev.parent,
-				"Input pin number out of range.\n");
-			ret = -EINVAL;
-			goto err;
-		}
 		st->channel_config[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
 						  AD7124_CHANNEL_AINM(ain[1]);
 		st->channel_config[channel].bipolar =
-- 
2.17.1

