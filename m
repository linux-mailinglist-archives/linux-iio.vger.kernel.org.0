Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70C92FC1C
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2019 15:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfE3NSl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 May 2019 09:18:41 -0400
Received: from mail-eopbgr720068.outbound.protection.outlook.com ([40.107.72.68]:23787
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbfE3NSk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 May 2019 09:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Trlajzb0awiOTSvrQOKtls3/+u4AKlRVcMYz9lJR3rg=;
 b=bOvm4J2MuvGqwkk/cqY9G0OZOxwB9/qPryHyMNPJ22z+2QJtPgh53AOokd/iufhrrmb5tWIS+BvPeNbUKnxTHEaK9euZplpSwQIm5JqpsloZd6KOb+J2hq6PronCkjI4DThY1P/e0aUN5h2ZhHgjQADiIIEwsHxh9mm41bcc/BY=
Received: from BN3PR03CA0063.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::23) by DM5PR03MB3129.namprd03.prod.outlook.com
 (2603:10b6:4:3c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.17; Thu, 30 May
 2019 13:18:24 +0000
Received: from BL2NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by BN3PR03CA0063.outlook.office365.com
 (2a01:111:e400:7a4d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.16 via Frontend
 Transport; Thu, 30 May 2019 13:18:24 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT026.mail.protection.outlook.com (10.152.77.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Thu, 30 May 2019 13:18:23 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4UDINjp015968
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Thu, 30 May 2019 06:18:23 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 30 May 2019
 09:18:23 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 5/5] iio: amplifiers: ad8366: Add support for ADL5240 VGA
Date:   Thu, 30 May 2019 16:18:12 +0300
Message-ID: <20190530131812.3476-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530131812.3476-1-alexandru.ardelean@analog.com>
References: <20190530131812.3476-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(2980300002)(189003)(199004)(356004)(6666004)(7636002)(8936002)(77096007)(8676002)(6916009)(50226002)(246002)(186003)(26005)(336012)(426003)(966005)(6306002)(305945005)(70586007)(316002)(70206006)(478600001)(107886003)(47776003)(5820100001)(2351001)(53416004)(36756003)(2906002)(4326008)(1076003)(5660300002)(50466002)(76176011)(7696005)(14444005)(106002)(23676004)(486006)(2870700001)(446003)(11346002)(2616005)(476003)(126002)(44832011)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3129;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83d88d08-04e3-45db-47e5-08d6e5014b20
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709054)(1401327)(2017052603328);SRVR:DM5PR03MB3129;
X-MS-TrafficTypeDiagnostic: DM5PR03MB3129:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM5PR03MB31294508E96B3BC42ED4F902F9180@DM5PR03MB3129.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 00531FAC2C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: cBlueqRDPnpvoN0pkphdaCB9/rBd9MthFQORhut+wOnlmf6+aogUb1Lu4ghbHkmmiRiAkzBJZrWRNUDROghOZERxsW8TFAiZUP0WcaXOps/RwwapJd2EavFFgq0c3zn7rGRxem8CMMhnRHBTinMPo8nFik7JA6fKzKwJ3ctNpYlkR0ZWwEc5BgZWq+aLMzCv6INPq6EJ4XT7T+iMsO2UXirtdFLQi1i+0IYlOdejEbG+yUg9od1U5TXvAimI7RLAhaT3mkiSyr7IMZzfAXhm+Y+MuN4xpbW6Yz4uzN6d+25v+mnAvhe02GXAGytdi3VGS/vxY24G1r/4pOF2hOgZ0kT5oHa0SgCFBb0nc8Zt+6Cd7GVBhvC5Pz+u1rO0nUuNEZL2g2/uVXC+1cPAY5+A+j1EA/RjtNOsedUKoB7ubGc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2019 13:18:23.6707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d88d08-04e3-45db-47e5-08d6e5014b20
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3129
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADL5240 is a high performance, digitally controlled variable gain
amplifier (VGA) operating from 100 MHz to 4000 MHz. The VGA integrates a
high performance, 20 dB gain, internally matched amplifier (AMP) with a
6-bit digital step attenuator (DSA) that has a gain control range of
31.5 dB in 0.5 dB steps with ±0.25 dB step accuracy.

Datasheet link:
  https://www.analog.com/media/en/technical-documentation/data-sheets/adl5240.pdf

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/amplifiers/Kconfig  |  1 +
 drivers/iio/amplifiers/ad8366.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
index 259058da8811..871e8060d996 100644
--- a/drivers/iio/amplifiers/Kconfig
+++ b/drivers/iio/amplifiers/Kconfig
@@ -16,6 +16,7 @@ config AD8366
 	  from Analog Devices:
 	    AD8366 Dual-Digital Variable Gain Amplifier (VGA)
 	    ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
+	    ADL5240 Digitally controlled variable gain amplifier (VGA)
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad8366.
diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 0a9883e8eb2e..0176d3d8cc9c 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -4,6 +4,7 @@
  * This driver supports the following gain amplifiers:
  *   AD8366 Dual-Digital Variable Gain Amplifier (VGA)
  *   ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
+ *   ADL5240 Digitally controlled variable gain amplifier (VGA)
  *
  * Copyright 2012-2019 Analog Devices Inc.
  */
@@ -25,6 +26,7 @@
 enum ad8366_type {
 	ID_AD8366,
 	ID_ADA4961,
+	ID_ADL5240,
 };
 
 struct ad8366_info {
@@ -56,6 +58,10 @@ static struct ad8366_info ad8366_infos[] = {
 		.gain_min = -6000,
 		.gain_max = 15000,
 	},
+	[ID_ADL5240] = {
+		.gain_min = -11500,
+		.gain_max = 20000,
+	},
 };
 
 static int ad8366_write(struct iio_dev *indio_dev,
@@ -75,6 +81,9 @@ static int ad8366_write(struct iio_dev *indio_dev,
 	case ID_ADA4961:
 		st->data[0] = ch_a & 0x1F;
 		break;
+	case ID_ADL5240:
+		st->data[0] = (ch_a & 0x3F);
+		break;
 	}
 
 	ret = spi_write(st->spi, st->data, indio_dev->num_channels);
@@ -106,6 +115,9 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
 		case ID_ADA4961:
 			gain = 15000 - code * 1000;
 			break;
+		case ID_ADL5240:
+			gain = 20000 - 31500 + code * 500;
+			break;
 		}
 
 		/* Values in dB */
@@ -149,6 +161,9 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
 	case ID_ADA4961:
 		code = (15000 - gain) / 1000;
 		break;
+	case ID_ADL5240:
+		code = ((gain - 500 - 20000) / 500) & 0x3F;
+		break;
 	}
 
 	mutex_lock(&st->lock);
@@ -217,6 +232,7 @@ static int ad8366_probe(struct spi_device *spi)
 		indio_dev->num_channels = ARRAY_SIZE(ad8366_channels);
 		break;
 	case ID_ADA4961:
+	case ID_ADL5240:
 		st->reset_gpio = devm_gpiod_get(&spi->dev, "reset",
 			GPIOD_OUT_HIGH);
 		indio_dev->channels = ada4961_channels;
@@ -268,6 +284,7 @@ static int ad8366_remove(struct spi_device *spi)
 static const struct spi_device_id ad8366_id[] = {
 	{"ad8366",  ID_AD8366},
 	{"ada4961", ID_ADA4961},
+	{"adl5240", ID_ADL5240},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad8366_id);
-- 
2.20.1

