Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20EC42FC17
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2019 15:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfE3NSY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 May 2019 09:18:24 -0400
Received: from mail-eopbgr790044.outbound.protection.outlook.com ([40.107.79.44]:43084
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726557AbfE3NSY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 May 2019 09:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nqCcnM0fIyA+uAqeJ/aznZCWdOyU4mW+lzWkFXNqqU=;
 b=htqAoUxrDyJkjs7h2t5XWFxD91KCrtZ+FZgaYDurx8hdhZpF41m09Nr3JRqlGlJeiOT0WYvuOUbSyUU8u7Z5WOhiDI4sgat5eLV3/DaYBgLxyJ9lKKBKPlAEV6uuYTfFUGJ72bbLtksdbsYjmeG2iyqcmt/OZ5+WHfBn/fSJWS8=
Received: from DM6PR03CA0026.namprd03.prod.outlook.com (2603:10b6:5:40::39) by
 DM2PR03MB557.namprd03.prod.outlook.com (2a01:111:e400:241b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.20; Thu, 30 May
 2019 13:18:21 +0000
Received: from BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by DM6PR03CA0026.outlook.office365.com
 (2603:10b6:5:40::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.17 via Frontend
 Transport; Thu, 30 May 2019 13:18:21 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT017.mail.protection.outlook.com (10.152.77.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Thu, 30 May 2019 13:18:21 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x4UDIKof024240
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Thu, 30 May 2019 06:18:20 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 30 May 2019
 09:18:20 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/5] iio: amplifiers: ad8366: rework driver to allow other chips
Date:   Thu, 30 May 2019 16:18:10 +0300
Message-ID: <20190530131812.3476-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530131812.3476-1-alexandru.ardelean@analog.com>
References: <20190530131812.3476-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(346002)(2980300002)(199004)(189003)(107886003)(2870700001)(356004)(446003)(126002)(6916009)(426003)(336012)(5660300002)(11346002)(486006)(478600001)(2906002)(70586007)(305945005)(7636002)(53416004)(4326008)(7696005)(51416003)(476003)(2616005)(76176011)(186003)(6666004)(8676002)(316002)(77096007)(26005)(86362001)(44832011)(106002)(1076003)(36756003)(246002)(50466002)(8936002)(2351001)(14444005)(70206006)(50226002)(47776003)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB557;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: beeed77c-2558-4df5-0ca2-08d6e5014989
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709054)(1401327)(2017052603328);SRVR:DM2PR03MB557;
X-MS-TrafficTypeDiagnostic: DM2PR03MB557:
X-Microsoft-Antispam-PRVS: <DM2PR03MB55701D09C826D35DA83E138F9180@DM2PR03MB557.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 00531FAC2C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: GwJfzcVnhQyEZSYAK/elS0shECeb0++lfDFUx3bKiWD8FfDJNaA/s767xEGjyz/lcmtvZxTreFDhCUis0jPV7iZi4mX6dm+oWp7fM+ttu6AkMw1Y+ggiZvHvlwqBwrtR5XZkCS3IL2TCnYYg+yKUn+8MNvmgXgukDZPEc8zPdjnPwtQzioEoi5nVFWpqYrMgEYxwVqSXtRq7keO/0DQaZxivOqDFSJNz8/JQwdO8cgrRQp3Q94bKxFk9iXmB4FODMX19uJ9s/kfwwmXZncftRu2qVQytGgnOETIrzc3XHRrS0DoPPlo/i6SuNOvpTzi7FWa+Ym3blZcQzlcSjVIPeMFr1IX2XXfdXCRcDjXTsyDaYYywLlXeAuscSLjaRusBlVLvNBNogI0SAhPxbpxwNKZF+7mTNOMngA4HmvKMwFE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2019 13:18:21.0049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beeed77c-2558-4df5-0ca2-08d6e5014989
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB557
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The SPI gain amplifiers are simple devices, with 1 or 2 channels, to which
are read-from/written-to.

The gain computation in ad8366_write_raw() has been updated to compute gain
in dB for negative values.

This driver will be extended to support other chips as well.
To do that, this rework handles the AD8366 device as a special-case (via
switch-statements). This will make things easier when adding new chips.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 81 +++++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 24ff5475d9f2..1beda6409301 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -18,11 +18,22 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
+enum ad8366_type {
+	ID_AD8366,
+};
+
+struct ad8366_info {
+	int gain_min;
+	int gain_max;
+};
+
 struct ad8366_state {
 	struct spi_device	*spi;
 	struct regulator	*reg;
 	struct mutex            lock; /* protect sensor state */
 	unsigned char		ch[2];
+	enum ad8366_type	type;
+	struct ad8366_info	*info;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -30,19 +41,30 @@ struct ad8366_state {
 	unsigned char		data[2] ____cacheline_aligned;
 };
 
+static struct ad8366_info ad8366_infos[] = {
+	[ID_AD8366] = {
+		.gain_min = 4500,
+		.gain_max = 20500,
+	},
+};
+
 static int ad8366_write(struct iio_dev *indio_dev,
 			unsigned char ch_a, unsigned char ch_b)
 {
 	struct ad8366_state *st = iio_priv(indio_dev);
 	int ret;
 
-	ch_a = bitrev8(ch_a & 0x3F);
-	ch_b = bitrev8(ch_b & 0x3F);
+	switch (st->type) {
+	case ID_AD8366:
+		ch_a = bitrev8(ch_a & 0x3F);
+		ch_b = bitrev8(ch_b & 0x3F);
 
-	st->data[0] = ch_b >> 4;
-	st->data[1] = (ch_b << 4) | (ch_a >> 2);
+		st->data[0] = ch_b >> 4;
+		st->data[1] = (ch_b << 4) | (ch_a >> 2);
+		break;
+	}
 
-	ret = spi_write(st->spi, st->data, ARRAY_SIZE(st->data));
+	ret = spi_write(st->spi, st->data, indio_dev->num_channels);
 	if (ret < 0)
 		dev_err(&indio_dev->dev, "write failed (%d)", ret);
 
@@ -57,17 +79,22 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad8366_state *st = iio_priv(indio_dev);
 	int ret;
-	unsigned code;
+	int code, gain = 0;
 
 	mutex_lock(&st->lock);
 	switch (m) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		code = st->ch[chan->channel];
 
+		switch (st->type) {
+		case ID_AD8366:
+			gain = code * 253 + 4500;
+			break;
+		}
+
 		/* Values in dB */
-		code = code * 253 + 4500;
-		*val = code / 1000;
-		*val2 = (code % 1000) * 1000;
+		*val = gain / 1000;
+		*val2 = (gain % 1000) * 1000;
 
 		ret = IIO_VAL_INT_PLUS_MICRO_DB;
 		break;
@@ -86,19 +113,24 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct ad8366_state *st = iio_priv(indio_dev);
-	unsigned code;
+	struct ad8366_info *inf = st->info;
+	int code = 0, gain;
 	int ret;
 
-	if (val < 0 || val2 < 0)
-		return -EINVAL;
-
 	/* Values in dB */
-	code = (((u8)val * 1000) + ((u32)val2 / 1000));
+	if (val < 0)
+		gain = (val * 1000) - (val2 / 1000);
+	else
+		gain = (val * 1000) + (val2 / 1000);
 
-	if (code > 20500 || code < 4500)
+	if (gain > inf->gain_max || gain < inf->gain_min)
 		return -EINVAL;
 
-	code = (code - 4500) / 253;
+	switch (st->type) {
+	case ID_AD8366:
+		code = (gain - 4500) / 253;
+		break;
+	}
 
 	mutex_lock(&st->lock);
 	switch (mask) {
@@ -154,13 +186,24 @@ static int ad8366_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 	mutex_init(&st->lock);
 	st->spi = spi;
+	st->type = spi_get_device_id(spi)->driver_data;
+
+	switch (st->type) {
+	case ID_AD8366:
+		indio_dev->channels = ad8366_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ad8366_channels);
+		break;
+	default:
+		dev_err(&spi->dev, "Invalid device ID\n");
+		ret = -EINVAL;
+		goto error_disable_reg;
+	}
 
+	st->info = &ad8366_infos[st->type];
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad8366_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = ad8366_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ad8366_channels);
 
 	ret = ad8366_write(indio_dev, 0 , 0);
 	if (ret < 0)
@@ -194,7 +237,7 @@ static int ad8366_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad8366_id[] = {
-	{"ad8366", 0},
+	{"ad8366",  ID_AD8366},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad8366_id);
-- 
2.20.1

