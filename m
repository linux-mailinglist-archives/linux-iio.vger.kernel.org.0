Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0722B5DA
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2019 14:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfE0M4t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 May 2019 08:56:49 -0400
Received: from mail-eopbgr810089.outbound.protection.outlook.com ([40.107.81.89]:19280
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfE0M4t (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 May 2019 08:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7Px++6zObfKo6Q0xm7HxH3xMQ3lo45Lz3O7Sn4UmhE=;
 b=O6clW+EoH5Qdpa2s26yotTyMU5Q/BWaY1AGUyXHuI6p6xdm0Wt86UBltTR90ClBDHUudWnPXWe5IlT4vd+VlrC7Uc+0+ryidM8n3cY83c5epeVr62JXNXrEyX3Zb2FcMDiAft3NaLXhweqlbSC0eM7vT3oKVcF8Hi8zrPOHKbag=
Received: from BN3PR03CA0112.namprd03.prod.outlook.com (2603:10b6:400:4::30)
 by BN3PR03MB2259.namprd03.prod.outlook.com (2a01:111:e400:7bba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.21; Mon, 27 May
 2019 12:56:43 +0000
Received: from BL2NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BN3PR03CA0112.outlook.office365.com
 (2603:10b6:400:4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.16 via Frontend
 Transport; Mon, 27 May 2019 12:56:42 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT028.mail.protection.outlook.com (10.152.77.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Mon, 27 May 2019 12:56:42 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x4RCugng022647
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 27 May 2019 05:56:42 -0700
Received: from ben-Latitude-E6540.analog.com (10.50.1.100) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 27 May 2019 08:56:41 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v2 3/4] iio: adc: ad7606: Add support for software mode for ad7616
Date:   Mon, 27 May 2019 15:56:49 +0300
Message-ID: <20190527125650.2405-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527125650.2405-1-beniamin.bia@analog.com>
References: <20190527125650.2405-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(189003)(199004)(5820100001)(44832011)(107886003)(36756003)(126002)(486006)(26005)(476003)(2616005)(446003)(11346002)(77096007)(356004)(50466002)(70586007)(70206006)(316002)(426003)(186003)(336012)(7416002)(2870700001)(106002)(54906003)(1076003)(7696005)(47776003)(2906002)(23676004)(5660300002)(8676002)(72206003)(8936002)(76176011)(478600001)(50226002)(2351001)(53416004)(7636002)(6916009)(86362001)(14444005)(305945005)(4326008)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2259;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dae9c85-f5b8-4b8f-6ece-08d6e2a2c469
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709054)(1401327)(2017052603328);SRVR:BN3PR03MB2259;
X-MS-TrafficTypeDiagnostic: BN3PR03MB2259:
X-Microsoft-Antispam-PRVS: <BN3PR03MB22591861D5863546726FEE54F01D0@BN3PR03MB2259.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0050CEFE70
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: I3YQBHN2k1EiBCJ0J1NitTqAQg1XG8mx64K0uA3CX0YRVW8EoXwcCM+w9DC5uypapkhr35Bz0uu7Dzoq2dT2A/SA/Cl6PKMPQvHefpaua6e0awnxJjyEWJMJtCrC98nv8EaCkkot8Z3JxjAObxC5n87JlCyBEviXxo1mZXbGo5o/Cu1YJBnQMzrm4GbLVWYRYWUK5IH59r8pm9gNe2t0nL1zCJE532ZEcp7P2sig5jNFv7ecYq99kK9ATHlDTMciCSYUoIBUBVdZjf8f8rmNoSK5SXII2mjes1SvVqAVOupWi4O8EC5bQYhOra7HwSf81CDcanm0w6vSriWUkeZcO0gb4dYnn8PBLahNa+2ZE1CdVvATydcu0qMQbRADLeUK8buPgdp+wawkTtq2QEBwOlat4BvGfCKpNZlfyjO3jRM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2019 12:56:42.6316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dae9c85-f5b8-4b8f-6ece-08d6e2a2c469
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2259
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Support for ad7616 running in software was added. In order
to activate the software mode, HW_RNGSEL pins must be pulled low.
Oversampling and input ranges are now configured in corresponding
registers. Ad7616 has multiple scale options when it is configured
in software mode.
Also, in order to support multiple devices in software mode, the spi
the calculation of registers address must be generic. Because
the length of address and bit which specifies the read/write operation is
different for every device, calculation of address was made generic.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v2:
-squashed with the patch which introduces the reg access function.
-some casting warnings were fixed.

 drivers/iio/adc/ad7606.c | 171 +++++++++++++++++++++++++++++++++++++--
 drivers/iio/adc/ad7606.h |   4 +
 2 files changed, 167 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index aba0fd123a51..8e09ad4bb72e 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -25,8 +25,24 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
+#include <linux/spi/spi.h>
+
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
@@ -35,6 +51,11 @@ static const unsigned int ad7606_scale_avail[2] = {
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
@@ -43,6 +64,11 @@ static const unsigned int ad7616_oversampling_avail[8] = {
 	1, 2, 4, 8, 16, 32, 64, 128,
 };
 
+static u16 ad7616_spi_rd_wr_cmd(int addr, char isWriteOp)
+{
+	return ((addr & 0x7F) << 1) | ((isWriteOp & 0x1) << 7);
+}
+
 static int ad7606_reset(struct ad7606_state *st)
 {
 	if (st->gpio_reset) {
@@ -55,6 +81,59 @@ static int ad7606_reset(struct ad7606_state *st)
 	return -ENODEV;
 }
 
+static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int addr)
+{
+	struct spi_device *spi = to_spi_device(st->dev);
+	struct spi_transfer t[] = {
+		{
+			.tx_buf = &st->d16[0],
+			.len = 2,
+			.cs_change = 0,
+		}, {
+			.rx_buf = &st->d16[1],
+			.len = 2,
+		},
+	};
+	int ret;
+
+	st->d16[0] = cpu_to_be16(st->chip_info->spi_rd_wr_cmd(addr, 0) << 8);
+
+	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
+	if (ret < 0)
+		return ret;
+
+	return be16_to_cpu(st->d16[1]);
+}
+
+static int ad7606_spi_reg_write(struct ad7606_state *st,
+				unsigned int addr,
+				unsigned int val)
+{
+	struct spi_device *spi = to_spi_device(st->dev);
+
+	st->d16[0] = cpu_to_be16((st->chip_info->spi_rd_wr_cmd(addr, 1) << 8) |
+				  (val & 0x1FF));
+
+	return spi_write(spi, &st->d16[0], sizeof(st->d16[0]));
+}
+
+static int ad7606_spi_write_mask(struct ad7606_state *st,
+				 unsigned int addr,
+				 unsigned long mask,
+				 unsigned int val)
+{
+	int readval;
+
+	readval = ad7606_spi_reg_read(st, addr);
+	if (readval < 0)
+		return readval;
+
+	readval &= ~mask;
+	readval |= val;
+
+	return ad7606_spi_reg_write(st, addr, readval);
+}
+
 static int ad7606_read_samples(struct ad7606_state *st)
 {
 	unsigned int num = st->chip_info->num_channels;
@@ -222,6 +301,26 @@ static int ad7606_write_os_hw(struct iio_dev *indio_dev, int val)
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
@@ -308,14 +407,14 @@ static const struct attribute_group ad7606_attribute_group_range = {
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
@@ -325,11 +424,18 @@ static const struct attribute_group ad7606_attribute_group_range = {
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
@@ -381,6 +487,26 @@ static const struct iio_chan_spec ad7616_channels[] = {
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
@@ -408,9 +534,13 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
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
 
@@ -544,6 +674,23 @@ static void ad7606_regulator_disable(void *data)
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
@@ -617,6 +764,10 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	if (ret)
 		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
 
+	/* AD7616 requires al least 15ms to reconfigure after a reset */
+	if (msleep_interruptible(15))
+		return -ERESTARTSYS;
+
 	st->write_scale = ad7606_write_scale_hw;
 	st->write_os = ad7606_write_os_hw;
 
@@ -625,6 +776,10 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 							 "adi,sw-mode");
 
 	if (st->sw_mode_en) {
+		/* Scale of 0.076293 is only available in sw mode */
+		st->scale_avail = ad7616_sw_scale_avail;
+		st->num_scales = ARRAY_SIZE(ad7616_sw_scale_avail);
+
 		/* After reset, in software mode, ±10 V is set by default */
 		memset32(st->range, 2, ARRAY_SIZE(st->range));
 		indio_dev->info = &ad7606_info_os_and_range;
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index d8a509c2c428..154dc5d1a0cf 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -16,6 +16,7 @@
  *			oversampling ratios.
  * @oversampling_num	number of elements stored in oversampling_avail array
  * @os_req_reset	some devices require a reset to update oversampling
+ * @spi_rd_wr_cmd	pointer to the function which calculates the spi address
  * @write_scale_sw	pointer to the function which writes the scale via spi
 			in software mode
  * @write_os_sw		pointer to the function which writes the os via spi
@@ -29,6 +30,7 @@ struct ad7606_chip_info {
 	const unsigned int		*oversampling_avail;
 	unsigned int			oversampling_num;
 	bool				os_req_reset;
+	u16 (*spi_rd_wr_cmd)(int addr, char isWriteOp);
 	int (*write_scale_sw)(struct iio_dev *indio_dev, int ch, int val);
 	int (*write_os_sw)(struct iio_dev *indio_dev, int val);
 	int (*sw_mode_config)(struct iio_dev *indio_dev);
@@ -63,6 +65,7 @@ struct ad7606_chip_info {
  * @complete		completion to indicate end of conversion
  * @trig		The IIO trigger associated with the device.
  * @data		buffer for reading data from the device
+ * @d16			be16 buffer for reading data from the device
  */
 struct ad7606_state {
 	struct device			*dev;
@@ -96,6 +99,7 @@ struct ad7606_state {
 	 * 16 * 16-bit samples + 64-bit timestamp
 	 */
 	unsigned short			data[20] ____cacheline_aligned;
+	__be16				d16[2];
 };
 
 /**
-- 
2.17.1

