Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B157A6C94E
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2019 08:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfGRG2W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 02:28:22 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32394 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728103AbfGRG2W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 02:28:22 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6I6NsA3008860;
        Thu, 18 Jul 2019 02:28:16 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2057.outbound.protection.outlook.com [104.47.32.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tt0q7u4xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 02:28:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPou0lkd+dKizZRoPdP3uW08J1bIjYnWBFS1kZtauh/lxj5Pp1+abftJkhcGSzjHyDfFe5yzcS2AM7uflYxAEEK4EIN1dRqSYdl3AqxzGOeFX+9qF2IfSLMeItPlLlQZ3azGDklr7hTmAbBqQID4rFc0yQxvCQ3RatmKpK7bM8yyzAgXYZiRkTkiluth7QcT3SAJvjsT1hgb/81jbTsC0aG1y0DqIDomm6QAm2oh21KYAG+9ikhk1eNZT4eQrU/k8MFcvAHx9gJadGENSWlB4uBSMkjRdhGQYSxq08gZ8H1J8HvJ3hvt4sAgU/dYnp50Z0ZInJy0NWrnMCULHcn6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7ir+aW7G+bJUz8t8gaHRHG4yrB7iJxbvtChOSZ/lc0=;
 b=lN9uf/hzkHW8Tr+LS/BYvyes95iCsOkGP44cM1O7buGNmYoDjs9mF3SHsNSdvPLVqbN/iJlHy728TKDKYrqA+AqRFITy9E2aNv2Cw+c5kgJ7eppThNHQCVwT+3bVMsGgUj8Pd2Fp4T3zxEYZb4UU/rhu2FmUwnFn/prxIXcOLHc1POgyr5j5602gvdx8rFFQPvsvND4UFTnd/nSmqFyGMDeXcRMoxJycKnK4yGV93HM8StxG0wuKKUPZC/d8gfHME4mm2116Jn4o7t+5/W41BlanPh/fJV7RSAp7ukn4Enm8JBdnwfWSXiR4ZafBiA781TIqOhoo475sLUR5nF5+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7ir+aW7G+bJUz8t8gaHRHG4yrB7iJxbvtChOSZ/lc0=;
 b=d7VB2oWnZr75700yLGCt4h/OwcRbprdVEkck1C7wqCltsBt4yfBqkhnh1NwVZqtlfTuw5qE6H+k5Qkk3Ww6xLEQSlQ5JTmAO4YIv7WopZyqzAvuXui0UmLMrNwsDfXZxnUBjRGtkN0FNGlP09bH6LoO38q2NBGOcoUXTAEDFclM=
Received: from DM6PR03CA0017.namprd03.prod.outlook.com (2603:10b6:5:40::30) by
 BYAPR03MB3832.namprd03.prod.outlook.com (2603:10b6:a03:6e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.12; Thu, 18 Jul 2019 06:28:12 +0000
Received: from CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by DM6PR03CA0017.outlook.office365.com
 (2603:10b6:5:40::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.14 via Frontend
 Transport; Thu, 18 Jul 2019 06:28:12 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT063.mail.protection.outlook.com (10.152.75.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Thu, 18 Jul 2019 06:28:10 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x6I6SAQN015291
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 17 Jul 2019 23:28:10 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 18 Jul 2019 02:28:09 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 4/5] iio: adc: ad7606: Add support for software mode for ad7616
Date:   Thu, 18 Jul 2019 09:27:33 +0300
Message-ID: <20190718062734.17306-4-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718062734.17306-1-beniamin.bia@analog.com>
References: <20190718062734.17306-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(2980300002)(199004)(189003)(5820100001)(30864003)(8936002)(70206006)(26005)(476003)(126002)(2616005)(446003)(186003)(2870700001)(11346002)(2906002)(86362001)(1076003)(356004)(305945005)(6666004)(478600001)(70586007)(47776003)(50226002)(246002)(8676002)(106002)(54906003)(316002)(5660300002)(7636002)(107886003)(486006)(44832011)(14444005)(76176011)(50466002)(6916009)(23676004)(36756003)(426003)(7696005)(4326008)(2351001)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3832;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bda84914-e726-4436-d223-08d70b491b3e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BYAPR03MB3832;
X-MS-TrafficTypeDiagnostic: BYAPR03MB3832:
X-Microsoft-Antispam-PRVS: <BYAPR03MB38321F6B801C0E2FC679BC99F0C80@BYAPR03MB3832.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 01026E1310
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: rawg9S8B2idLlwra85LfziqnuhL/yYtj/VY5DPsSVGzpiR0wgI4uQ5qSToUh0crhOuBUkPvT4HiJ8UQuFQTRaMs9jKEGtqRICe5oEQInAiagrKImwnvPj/msvcExlFbVaqExPtUKL2f0Os38RQBBWykF/XpYdDIDtQBFY7XTFY7dIqZUCBcN58dRaJ4FzTF7FvNJbq2k1uiEafQTKcc5Re1lS1/I7uJEkTWYaVTQ4uI6F++8UEMiFV4lHA91eV4KVxqD+j0PRc25sEPn9b4AlKb5P4aAExnecTFc5dr6LdbRllFXU+3pTllepHQII0CsCK3AJeTd2OlWobGFV3PB3RvwQAGmpOKfArnJI84qVSRATBjO3qXYkTo0s3GuZMfCc8R1Ocg5jE7BGvCj30dOrx4KUDwVclppt2tPFzdn7gE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2019 06:28:10.7389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bda84914-e726-4436-d223-08d70b491b3e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3832
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180072
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
calculation of registers address must be generic. Because
the length of address and bit which specifies the read/write operation is
different for every device, calculation of address was made generic.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v2:
-aditional comments added to explain calculation of range register address
-range macros were simplified

 drivers/iio/adc/ad7606.c     |   9 ++
 drivers/iio/adc/ad7606.h     |  38 ++++++--
 drivers/iio/adc/ad7606_spi.c | 175 ++++++++++++++++++++++++++++++++++-
 3 files changed, 213 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index a6034cf7238a..be2330c8b277 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -35,6 +35,11 @@ static const unsigned int ad7606_scale_avail[2] = {
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
@@ -606,6 +611,10 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
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
index a6aac33aa33c..eeaaa8b905db 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -8,14 +8,14 @@
 #ifndef IIO_ADC_AD7606_H_
 #define IIO_ADC_AD7606_H_
 
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
@@ -25,11 +25,18 @@
 		},						\
 }
 
-#define AD7605_CHANNEL(num)	\
-	AD760X_CHANNEL(num, 0)
+#define AD7605_CHANNEL(num)				\
+	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
+		BIT(IIO_CHAN_INFO_SCALE), 0)
 
-#define AD7606_CHANNEL(num)	\
-	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
+#define AD7606_CHANNEL(num)				\
+	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
+		BIT(IIO_CHAN_INFO_SCALE),		\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
+
+#define AD7616_CHANNEL(num)	\
+	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),\
+		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
 
 /**
  * struct ad7606_chip_info - chip specific information
@@ -77,6 +84,7 @@ struct ad7606_chip_info {
  * @complete		completion to indicate end of conversion
  * @trig		The IIO trigger associated with the device.
  * @data		buffer for reading data from the device
+ * @d16			be16 buffer for reading data from the device
  */
 struct ad7606_state {
 	struct device			*dev;
@@ -110,6 +118,7 @@ struct ad7606_state {
 	 * 16 * 16-bit samples + 64-bit timestamp
 	 */
 	unsigned short			data[20] ____cacheline_aligned;
+	__be16				d16[2];
 };
 
 /**
@@ -117,11 +126,24 @@ struct ad7606_state {
  * @read_block		function pointer for reading blocks of data
  * @sw_mode_config:	pointer to a function which configured the device
  *			for software mode
+ * @reg_read	function pointer for reading spi register
+ * @reg_write	function pointer for writing spi register
+ * @write_mask	function pointer for write spi register with mask
+ * @rd_wr_cmd	pointer to the function which calculates the spi address
  */
 struct ad7606_bus_ops {
 	/* more methods added in future? */
 	int (*read_block)(struct device *dev, int num, void *data);
 	int (*sw_mode_config)(struct iio_dev *indio_dev);
+	int (*reg_read)(struct ad7606_state *st, unsigned int addr);
+	int (*reg_write)(struct ad7606_state *st,
+				unsigned int addr,
+				unsigned int val);
+	int (*write_mask)(struct ad7606_state *st,
+				 unsigned int addr,
+				 unsigned long mask,
+				 unsigned int val);
+	u16 (*rd_wr_cmd)(int addr, char isWriteOp);
 };
 
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index b7faef69a58f..98ed52b74507 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -15,6 +15,51 @@
 
 #define MAX_SPI_FREQ_HZ		23500000	/* VDRIVE above 4.75 V */
 
+#define AD7616_CONFIGURATION_REGISTER	0x02
+#define AD7616_OS_MASK			GENMASK(4, 2)
+#define AD7616_BURST_MODE		BIT(6)
+#define AD7616_SEQEN_MODE		BIT(5)
+#define AD7616_RANGE_CH_A_ADDR_OFF	0x04
+#define AD7616_RANGE_CH_B_ADDR_OFF	0x06
+/*
+ * Range of channels from a group are stored in 2 registers.
+ * 0, 1, 2, 3 in a register followed by 4, 5, 6, 7 in second register.
+ * For channels from second group(8-15) the order is the same, only with
+ * an offset of 2 for register address.
+ */
+#define AD7616_RANGE_CH_ADDR(ch)	((ch) >> 2)
+/* The range of the channel is stored on 2 bits*/
+#define AD7616_RANGE_CH_MSK(ch)		(0b11 << (((ch) & 0b11) * 2))
+#define AD7616_RANGE_CH_MODE(ch, mode)	((mode) << ((((ch) & 0b11)) * 2))
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
+static u16 ad7616_spi_rd_wr_cmd(int addr, char isWriteOp)
+{
+	/*
+	 * The address of register consist of one w/r bit
+	 * 6 bits of address followed by one reserved bit.
+	 */
+	return ((addr & 0x7F) << 1) | ((isWriteOp & 0x1) << 7);
+}
+
 static int ad7606_spi_read_block(struct device *dev,
 				 int count, void *buf)
 {
@@ -35,17 +80,145 @@ static int ad7606_spi_read_block(struct device *dev,
 	return 0;
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
+	st->d16[0] = cpu_to_be16(st->bops->rd_wr_cmd(addr, 0) << 8);
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
+	st->d16[0] = cpu_to_be16((st->bops->rd_wr_cmd(addr, 1) << 8) |
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
+	readval = st->bops->reg_read(st, addr);
+	if (readval < 0)
+		return readval;
+
+	readval &= ~mask;
+	readval |= val;
+
+	return st->bops->reg_write(st, addr, readval);
+}
+
+static int ad7616_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int ch_addr, mode, ch_index;
+
+
+	/*
+	 * Ad7616 has 16 channels divided in group A and group B.
+	 * The range of channels from A are stored in registers with address 4
+	 * while channels from B are stored in register with address 6.
+	 * The last bit from channels determines if it is from group A or B
+	 * because the order of channels in iio is 0A, 0B, 1A, 1B...
+	 */
+	ch_index = ch >> 1;
+
+	ch_addr = AD7616_RANGE_CH_ADDR(ch_index);
+
+	if ((ch & 0x1) == 0) /* channel A */
+		ch_addr += AD7616_RANGE_CH_A_ADDR_OFF;
+	else	/* channel B */
+		ch_addr += AD7616_RANGE_CH_B_ADDR_OFF;
+
+	/* 0b01 for 2.5v, 0b10 for 5v and 0b11 for 10v */
+	mode = AD7616_RANGE_CH_MODE(ch_index, ((val + 1) & 0b11));
+	return st->bops->write_mask(st, ch_addr, AD7616_RANGE_CH_MSK(ch_index),
+				     mode);
+}
+
+static int ad7616_write_os_sw(struct iio_dev *indio_dev, int val)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	return st->bops->write_mask(st, AD7616_CONFIGURATION_REGISTER,
+				     AD7616_OS_MASK, val << 2);
+}
+
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
+	st->write_scale = ad7616_write_scale_sw;
+	st->write_os = &ad7616_write_os_sw;
+
+	/* Activate Burst mode and SEQEN MODE */
+	return st->bops->write_mask(st,
+			      AD7616_CONFIGURATION_REGISTER,
+			      AD7616_BURST_MODE | AD7616_SEQEN_MODE,
+			      AD7616_BURST_MODE | AD7616_SEQEN_MODE);
+}
+
 static const struct ad7606_bus_ops ad7606_spi_bops = {
 	.read_block = ad7606_spi_read_block,
 };
 
+static const struct ad7606_bus_ops ad7616_spi_bops = {
+	.read_block = ad7606_spi_read_block,
+	.reg_read = ad7606_spi_reg_read,
+	.reg_write = ad7606_spi_reg_write,
+	.write_mask = ad7606_spi_write_mask,
+	.rd_wr_cmd = ad7616_spi_rd_wr_cmd,
+	.sw_mode_config = ad7616_sw_mode_config,
+};
+
 static int ad7606_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
+	const struct ad7606_bus_ops *bops;
+
+	switch (id->driver_data) {
+	case ID_AD7616:
+		bops = &ad7616_spi_bops;
+		break;
+	default:
+		bops = &ad7606_spi_bops;
+		break;
+	}
 
 	return ad7606_probe(&spi->dev, spi->irq, NULL,
 			    id->name, id->driver_data,
-			    &ad7606_spi_bops);
+			    bops);
 }
 
 static const struct spi_device_id ad7606_id_table[] = {
-- 
2.17.1

