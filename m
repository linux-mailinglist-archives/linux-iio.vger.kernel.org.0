Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10262FC18
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2019 15:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfE3NSZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 May 2019 09:18:25 -0400
Received: from mail-eopbgr720053.outbound.protection.outlook.com ([40.107.72.53]:5062
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbfE3NSZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 May 2019 09:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPNoV7LAFcqtIErQgXV/LKzyp/cD2BJ5GqozgM8s4ZM=;
 b=Dqpr15KDN5SKHGnLQBRBSTODdd1MJZTapXDgY0CZcs4O/+TXuYz55YpLhwbY5nYPbQnNytcNp13gRnvE2v98hg06M4qqD9JyccXTvkbstKPG5bQB4FQ8oKytAVFK1vUACamZxcI98G//M/BfpPr/l50jsCiUP8pTc0Sx7dwtK+Y=
Received: from DM6PR03CA0063.namprd03.prod.outlook.com (2603:10b6:5:100::40)
 by DM2PR03MB560.namprd03.prod.outlook.com (2a01:111:e400:241c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.17; Thu, 30 May
 2019 13:18:22 +0000
Received: from BL2NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by DM6PR03CA0063.outlook.office365.com
 (2603:10b6:5:100::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.17 via Frontend
 Transport; Thu, 30 May 2019 13:18:22 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT057.mail.protection.outlook.com (10.152.77.36) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Thu, 30 May 2019 13:18:22 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4UDIMeV015965
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Thu, 30 May 2019 06:18:22 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 30 May 2019
 09:18:21 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Paul Cercueil <paul.cercueil@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 4/5] iio: amplifiers: ad8366: Add support for the ADA4961 DGA
Date:   Thu, 30 May 2019 16:18:11 +0300
Message-ID: <20190530131812.3476-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530131812.3476-1-alexandru.ardelean@analog.com>
References: <20190530131812.3476-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(376002)(2980300002)(199004)(189003)(8676002)(14444005)(2870700001)(186003)(50226002)(8936002)(2616005)(305945005)(11346002)(1076003)(54906003)(6916009)(44832011)(246002)(36756003)(86362001)(7636002)(336012)(5660300002)(77096007)(2906002)(26005)(50466002)(476003)(2351001)(106002)(70206006)(966005)(446003)(53416004)(486006)(316002)(4326008)(47776003)(6306002)(6666004)(51416003)(7696005)(426003)(48376002)(107886003)(126002)(478600001)(70586007)(356004)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB560;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 777fb962-2284-4428-0506-08d6e5014a45
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709054)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:DM2PR03MB560;
X-MS-TrafficTypeDiagnostic: DM2PR03MB560:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM2PR03MB560EE8CAA2609EF39B7671EF9180@DM2PR03MB560.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 00531FAC2C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: xqZFtYv6IGLjxote4dhQZzKxrv3gRl8TipdrreEnjKN1bq9Hj5UGUfRAT6TbhtPM7aCaWb1GMNFLGDuBC9MrS77DixBpSiYO8OVbqqGoC64jpJQDT7z24GAwhVlDYCzmBC7L1v0/erHQU3L2kPOt55OVKMk657nJO5FUMcVqLdNz86hLBMrNLtei0WSEcmuSw/bhM0JFYkzzfChTQl1MDpLDTWBkKp1BfClG9lAn/aPjDYwLL78IcOtKpCfM2syW7pTJbWOjo0Fe/e8lbI5D/jNjqntWlqTmqIXfoAXFFp3Miv9SpJ24rslN3X/FuDxXl49jUUJSykH+r3kWJmHJczYvkU8PR/s2LYT6OWaHpKr5gAYrGwE4CRwO6kn9eqeowSgR2RSSz8e2UuJ/fEych6WwtIaQWjjhtCNqd31Qa/A=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2019 13:18:22.2348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 777fb962-2284-4428-0506-08d6e5014a45
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB560
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Paul Cercueil <paul.cercueil@analog.com>

This change adds support for the ADA4961 BiCMOS RF Digital Gain Amplifier,
(DGA), which is optimized for driving heavy loads out 2.0 GHz and beyond.
The device typically achieves -90 dBc IMD3 performance at 500 MHz and
-85  dBc at 1.5 GHz.

Datasheet link:
 http://www.analog.com/media/en/technical-documentation/data-sheets/ADA4961.pdf

This change re-uses the existing ad8366 driver, as most logic is similar.
Also, this chip has a reset pin which is initialized during probe.

Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/amplifiers/Kconfig  |  9 ++++++---
 drivers/iio/amplifiers/ad8366.c | 34 +++++++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
index da5830da9bcf..259058da8811 100644
--- a/drivers/iio/amplifiers/Kconfig
+++ b/drivers/iio/amplifiers/Kconfig
@@ -7,12 +7,15 @@
 menu "Amplifiers"
 
 config AD8366
-	tristate "Analog Devices AD8366 VGA"
+	tristate "Analog Devices AD8366 and similar Gain Amplifiers"
 	depends on SPI
 	select BITREVERSE
 	help
-	  Say yes here to build support for Analog Devices AD8366
-	  SPI Dual-Digital Variable Gain Amplifier (VGA).
+	  Say yes here to build support for Analog Devices AD8366 and similar
+	  gain amplifiers. This driver supports the following gain amplifiers
+	  from Analog Devices:
+	    AD8366 Dual-Digital Variable Gain Amplifier (VGA)
+	    ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad8366.
diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 1beda6409301..0a9883e8eb2e 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * AD8366 SPI Dual-Digital Variable Gain Amplifier (VGA)
+ * AD8366 and similar Gain Amplifiers
+ * This driver supports the following gain amplifiers:
+ *   AD8366 Dual-Digital Variable Gain Amplifier (VGA)
+ *   ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
  *
  * Copyright 2012-2019 Analog Devices Inc.
  */
@@ -11,6 +14,7 @@
 #include <linux/sysfs.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/bitrev.h>
@@ -20,6 +24,7 @@
 
 enum ad8366_type {
 	ID_AD8366,
+	ID_ADA4961,
 };
 
 struct ad8366_info {
@@ -31,6 +36,7 @@ struct ad8366_state {
 	struct spi_device	*spi;
 	struct regulator	*reg;
 	struct mutex            lock; /* protect sensor state */
+	struct gpio_desc	*reset_gpio;
 	unsigned char		ch[2];
 	enum ad8366_type	type;
 	struct ad8366_info	*info;
@@ -46,6 +52,10 @@ static struct ad8366_info ad8366_infos[] = {
 		.gain_min = 4500,
 		.gain_max = 20500,
 	},
+	[ID_ADA4961] = {
+		.gain_min = -6000,
+		.gain_max = 15000,
+	},
 };
 
 static int ad8366_write(struct iio_dev *indio_dev,
@@ -62,6 +72,9 @@ static int ad8366_write(struct iio_dev *indio_dev,
 		st->data[0] = ch_b >> 4;
 		st->data[1] = (ch_b << 4) | (ch_a >> 2);
 		break;
+	case ID_ADA4961:
+		st->data[0] = ch_a & 0x1F;
+		break;
 	}
 
 	ret = spi_write(st->spi, st->data, indio_dev->num_channels);
@@ -90,6 +103,9 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
 		case ID_AD8366:
 			gain = code * 253 + 4500;
 			break;
+		case ID_ADA4961:
+			gain = 15000 - code * 1000;
+			break;
 		}
 
 		/* Values in dB */
@@ -130,6 +146,9 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
 	case ID_AD8366:
 		code = (gain - 4500) / 253;
 		break;
+	case ID_ADA4961:
+		code = (15000 - gain) / 1000;
+		break;
 	}
 
 	mutex_lock(&st->lock);
@@ -164,6 +183,10 @@ static const struct iio_chan_spec ad8366_channels[] = {
 	AD8366_CHAN(1),
 };
 
+static const struct iio_chan_spec ada4961_channels[] = {
+	AD8366_CHAN(0),
+};
+
 static int ad8366_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -193,6 +216,12 @@ static int ad8366_probe(struct spi_device *spi)
 		indio_dev->channels = ad8366_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ad8366_channels);
 		break;
+	case ID_ADA4961:
+		st->reset_gpio = devm_gpiod_get(&spi->dev, "reset",
+			GPIOD_OUT_HIGH);
+		indio_dev->channels = ada4961_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ada4961_channels);
+		break;
 	default:
 		dev_err(&spi->dev, "Invalid device ID\n");
 		ret = -EINVAL;
@@ -238,6 +267,7 @@ static int ad8366_remove(struct spi_device *spi)
 
 static const struct spi_device_id ad8366_id[] = {
 	{"ad8366",  ID_AD8366},
+	{"ada4961", ID_ADA4961},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad8366_id);
@@ -254,5 +284,5 @@ static struct spi_driver ad8366_driver = {
 module_spi_driver(ad8366_driver);
 
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD8366 VGA");
+MODULE_DESCRIPTION("Analog Devices AD8366 and similar Gain Amplifiers");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

