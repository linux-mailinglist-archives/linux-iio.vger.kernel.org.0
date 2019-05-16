Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D62A9209C1
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2019 16:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfEPOcH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 May 2019 10:32:07 -0400
Received: from mail-eopbgr750051.outbound.protection.outlook.com ([40.107.75.51]:31461
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727302AbfEPOcH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 May 2019 10:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCdwOJmsrFRlbTkiAd/vYXJDOdpDWYHmoxWnhfQFdKQ=;
 b=qnB7plYhKWKURqIUlvvH3EH0JlS/7XyhfUPU5Y3NUAI922nst41B+DY9js9HX57mTRm03eePx3PDV4Swop1/Hs5C24ojtSCJh+RMBuIlRnP4xYWzZFXO0LJcDGANRG/+ub5jgNq0Frl+Eg58LKGBhqQGANOJGC9f/7KSP3wojy8=
Received: from CY4PR03CA0105.namprd03.prod.outlook.com (2603:10b6:910:4d::46)
 by CO2PR03MB2261.namprd03.prod.outlook.com (2603:10b6:102:13::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.17; Thu, 16 May
 2019 14:32:00 +0000
Received: from SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by CY4PR03CA0105.outlook.office365.com
 (2603:10b6:910:4d::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16 via Frontend
 Transport; Thu, 16 May 2019 14:31:59 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT019.mail.protection.outlook.com (10.152.72.130) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Thu, 16 May 2019 14:31:59 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4GEVwxV027667
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 16 May 2019 07:31:58 -0700
Received: from ben-Latitude-E6540.analog.com (10.50.1.133) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 16 May 2019 10:31:57 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 4/5] iio: adc: ad7606: Add support for software mode for ad7616
Date:   Thu, 16 May 2019 17:32:07 +0300
Message-ID: <20190516143208.19294-4-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516143208.19294-1-beniamin.bia@analog.com>
References: <20190516143208.19294-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(136003)(346002)(2980300002)(199004)(189003)(5820100001)(2906002)(2870700001)(14444005)(106002)(5660300002)(26005)(76176011)(6916009)(54906003)(426003)(316002)(47776003)(446003)(476003)(336012)(1076003)(186003)(305945005)(72206003)(77096007)(2616005)(8676002)(36756003)(356004)(2351001)(86362001)(246002)(70206006)(70586007)(478600001)(53416004)(50466002)(126002)(7636002)(11346002)(107886003)(486006)(7696005)(23676004)(50226002)(8936002)(7416002)(6666004)(44832011)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2261;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0bccb3f-2a95-4658-61e8-08d6da0b4175
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:CO2PR03MB2261;
X-MS-TrafficTypeDiagnostic: CO2PR03MB2261:
X-Microsoft-Antispam-PRVS: <CO2PR03MB2261BA9816295989908A9463F00A0@CO2PR03MB2261.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0039C6E5C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: d1dro5xmMYYubz9tf3od8207rYpakSmX2SavWy9ETlj+05GFuVB3UpbsE+A7a9MxnKfsMqz6h10QO8vU2Evthmzlnq/TszuBeVL4UwamWvUrqZQPrKCQ+8xRaCXGkc2DRYWrr9MpNcd4WaDm89GD3zQJRNqlMB0aeCYT1ttyVPCYHW6nPbgMuvMkB3FNq1dPNl8qUpoJxN6jzAEMM3ocpMb2rfkg9Brc7gYnWZYA0C/Bhf8JhQSBN7r5t1YlypqKum0n9JLW2D0iSzl+BWLTyo20CkAxhap3c/mFSxSQvDLSIFO6jhxqN2yX1B3F+zglo4GGwi1/fFF2WkSswOH+UedmVxBtKOl1zP7fkkuxvU3cL2RirrZ6kA7M1Ojdwn6Lo3dhxlptm4RLkgC4RGyDxsb3NHorgQCMrfSlnl45SU4=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2019 14:31:59.1106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bccb3f-2a95-4658-61e8-08d6da0b4175
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2261
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Support for ad7616 running in software was added. In order
to activate the software mode, HW_RNGSEL pins must be pulled low.
Oversampling and input ranges are now configured in corresponding
registers. Ad7616 has multiple scale options when it is configured
in software mode.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/adc/ad7606.c | 111 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 103 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 6df81117cacc..f77df3efe43f 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -29,6 +29,20 @@
 
 #include "ad7606.h"
 
+#define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
+#define AD7606_OS_MODE			0x08
+
+#define AD7616_CONFIGURATION_REGISTER	0x02
+#define AD7616_OS_MASK			GENMASK(4,  2)
+#define AD7616_BURST_MODE		BIT(6)
+#define AD7616_SEQEN_MODE		BIT(5)
+#define AD7616_RANGE_CH_ADDR_OFF	0x04
+#define AD7616_RANGE_CH_ADDR(ch)	((((ch) & 0x1) << 1) + ((ch) >> 3))
+#define AD7616_RANGE_CH_MSK(ch)		(GENMASK(1, 0) << ((ch) & 0x6))
+#define AD7616_RANGE_CH_MODE(ch, mode)	((mode) << (ch & GENMASK(2, 1)))
+
+static int ad7616_sw_mode_config(struct iio_dev *indio_dev);
+
 /*
  * Scales are computed as 5000/32768 and 10000/32768 respectively,
  * so that when applied to the raw values they provide mV values
@@ -37,6 +51,11 @@ static const unsigned int ad7606_scale_avail[2] = {
 	152588, 305176
 };
 
+
+static const unsigned int ad7616_sw_scale_avail[3] = {
+	76293, 152588, 305176
+};
+
 static const unsigned int ad7606_oversampling_avail[7] = {
 	1, 2, 4, 8, 16, 32, 64,
 };
@@ -282,6 +301,26 @@ static int ad7606_write_os_hw(struct iio_dev *indio_dev, int val)
 	return 0;
 }
 
+static int ad7616_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int ch_addr, mode;
+
+	ch_addr = AD7616_RANGE_CH_ADDR_OFF + AD7616_RANGE_CH_ADDR(ch);
+	mode = AD7616_RANGE_CH_MODE(ch, ((val + 1) & 0x3));
+
+	return ad7606_spi_write_mask(st, ch_addr, AD7616_RANGE_CH_MSK(ch),
+				     mode);
+}
+
+static int ad7616_write_os_sw(struct iio_dev *indio_dev, int val)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	return ad7606_spi_write_mask(st, AD7616_CONFIGURATION_REGISTER,
+				     AD7616_OS_MASK, val << 2);
+}
+
 static int ad7606_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val,
@@ -368,14 +407,14 @@ static const struct attribute_group ad7606_attribute_group_range = {
 	.attrs = ad7606_attributes_range,
 };
 
-#define AD760X_CHANNEL(num, mask) {				\
+#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all) {	\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
 		.channel = num,					\
 		.address = num,					\
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
-		.info_mask_shared_by_all = mask,		\
+		.info_mask_separate = mask_sep,			\
+		.info_mask_shared_by_type = mask_type,		\
+		.info_mask_shared_by_all = mask_all,		\
 		.scan_index = num,				\
 		.scan_type = {					\
 			.sign = 's',				\
@@ -385,11 +424,18 @@ static const struct attribute_group ad7606_attribute_group_range = {
 		},						\
 }
 
-#define AD7605_CHANNEL(num)	\
-	AD760X_CHANNEL(num, 0)
+#define AD7605_CHANNEL(num)				\
+	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
+		BIT(IIO_CHAN_INFO_SCALE), 0)
+
+#define AD7606_CHANNEL(num)				\
+	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
+		BIT(IIO_CHAN_INFO_SCALE),		\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
 
-#define AD7606_CHANNEL(num)	\
-	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
+#define AD7616_CHANNEL(num)	\
+	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),\
+		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
 
 static const struct iio_chan_spec ad7605_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(4),
@@ -441,6 +487,26 @@ static const struct iio_chan_spec ad7616_channels[] = {
 	AD7606_CHANNEL(15),
 };
 
+static const struct iio_chan_spec ad7616_sw_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(16),
+	AD7616_CHANNEL(0),
+	AD7616_CHANNEL(1),
+	AD7616_CHANNEL(2),
+	AD7616_CHANNEL(3),
+	AD7616_CHANNEL(4),
+	AD7616_CHANNEL(5),
+	AD7616_CHANNEL(6),
+	AD7616_CHANNEL(7),
+	AD7616_CHANNEL(8),
+	AD7616_CHANNEL(9),
+	AD7616_CHANNEL(10),
+	AD7616_CHANNEL(11),
+	AD7616_CHANNEL(12),
+	AD7616_CHANNEL(13),
+	AD7616_CHANNEL(14),
+	AD7616_CHANNEL(15),
+};
+
 static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
 	/* More devices added in future */
 	[ID_AD7605_4] = {
@@ -468,9 +534,13 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
 	[ID_AD7616] = {
 		.channels = ad7616_channels,
 		.num_channels = 17,
+		.sw_mode_config = ad7616_sw_mode_config,
 		.oversampling_avail = ad7616_oversampling_avail,
 		.oversampling_num = ARRAY_SIZE(ad7616_oversampling_avail),
 		.os_req_reset = true,
+		.spi_rd_wr_cmd = ad7616_spi_rd_wr_cmd,
+		.write_scale_sw = ad7616_write_scale_sw,
+		.write_os_sw = ad7616_write_os_sw,
 	},
 };
 
@@ -604,6 +674,23 @@ static void ad7606_regulator_disable(void *data)
 	regulator_disable(st->reg);
 }
 
+static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	/*
+	 * Scale can be configured individually for each channel
+	 * in software mode.
+	 */
+	indio_dev->channels = ad7616_sw_channels;
+
+	/* Activate Burst mode and SEQEN MODE */
+	return ad7606_spi_write_mask(st,
+			      AD7616_CONFIGURATION_REGISTER,
+			      AD7616_BURST_MODE | AD7616_SEQEN_MODE,
+			      AD7616_BURST_MODE | AD7616_SEQEN_MODE);
+}
+
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 const char *name, unsigned int id,
 		 const struct ad7606_bus_ops *bops)
@@ -677,6 +764,10 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	if (ret)
 		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
 
+	/* AD7616 requires al least 15ms to reconfigure after a reset */
+	if (msleep_interruptible(15))
+		return -ERESTARTSYS;
+
 	st->write_scale = ad7606_write_scale_hw;
 	st->write_os = ad7606_write_os_hw;
 
@@ -685,6 +776,10 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 							 "adi,sw-mode");
 
 	if (st->sw_mode_en) {
+		/* Scale of 0.076293 is only available in sw mode */
+		st->scale_avail = ad7616_sw_scale_avail;
+		st->num_scales = ARRAY_SIZE(ad7616_sw_scale_avail);
+
 		/* After reset, in software mode, ±10 V is set by default */
 		memset32(st->range, 2, ARRAY_SIZE(st->range));
 		indio_dev->info = &ad7606_info_os_and_range;
-- 
2.17.1

