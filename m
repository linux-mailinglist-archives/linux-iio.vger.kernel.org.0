Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B72E45E58E
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2019 15:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfGCNdN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jul 2019 09:33:13 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:51866 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725847AbfGCNdM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jul 2019 09:33:12 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63BXTQd010609;
        Wed, 3 Jul 2019 07:37:41 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2059.outbound.protection.outlook.com [104.47.49.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2tg79xtt0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 07:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOxrpUCVmViFi5MzRafJN+44iNe/bPEFFPZWE8myDMU=;
 b=OBzGjol1j5G7ompvi7tzPq4TM2nIheGpUrA6JNFoobIFoHc7RsXADLcePBaHEPcTheaRf/LHVnkmaSmfexY79lioe1HH2aIpRdV69MBCdk4De9g4G/jRciSpbBjgAkqphy8VoIfsGqGiZxcaaUM+ek9Q6/cTwBRCch9Dc8dlY+M=
Received: from DM6PR03CA0020.namprd03.prod.outlook.com (2603:10b6:5:40::33) by
 MN2PR03MB4720.namprd03.prod.outlook.com (2603:10b6:208:ae::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.15; Wed, 3 Jul 2019 11:37:38 +0000
Received: from BL2NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by DM6PR03CA0020.outlook.office365.com
 (2603:10b6:5:40::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.18 via Frontend
 Transport; Wed, 3 Jul 2019 11:37:38 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT019.mail.protection.outlook.com (10.152.77.166) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Wed, 3 Jul 2019 11:37:38 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x63Bbbeg016762
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 3 Jul 2019 04:37:37 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 3 Jul 2019 07:37:37 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 4/5] iio: adc: ad7606: Add support for software mode for ad7616
Date:   Wed, 3 Jul 2019 17:36:47 +0300
Message-ID: <20190703143648.24402-4-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190703143648.24402-1-beniamin.bia@analog.com>
References: <20190703143648.24402-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(136003)(2980300002)(199004)(189003)(7636002)(54906003)(2351001)(305945005)(107886003)(106002)(4326008)(8936002)(50226002)(336012)(486006)(126002)(6916009)(476003)(2616005)(446003)(11346002)(36756003)(44832011)(14444005)(50466002)(7696005)(76176011)(186003)(426003)(77096007)(23676004)(316002)(2870700001)(26005)(47776003)(5820100001)(70586007)(246002)(70206006)(72206003)(478600001)(1076003)(86362001)(356004)(6666004)(2906002)(8676002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4720;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3efa91f7-f6cb-405d-b560-08d6ffaad9c9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MN2PR03MB4720;
X-MS-TrafficTypeDiagnostic: MN2PR03MB4720:
X-Microsoft-Antispam-PRVS: <MN2PR03MB4720757B5E4D8EAE8EB09392F0FB0@MN2PR03MB4720.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 00872B689F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: TwydDVFtW4YsaxEqatisdaq0dMQqjfZOuXkhhDTMD8OVWxqUr7lTuQsVjtFG5GNkEfTmB53oLxVqW9gNQm2nhfrxiuJS2rR15a2NDhreLBBM9UHHwSV/I206nYSipi+ROnI0YsGLBQnSlBWv4DHgvUkOJrhjktJfLdsz/Becq/hcE9qXwRxQSLdU58o4/eJFfao7MvPNoQDELDJPrUa0yl3Km56rlFKrxJbOQ9qXu/Ph6KUQpDORqNe/c2LOzQHBWZE/TC+Xyrl3sbzinpPnKPlIyoRaKtXKwfA2TYnzA+/sc3hTwqe2BGL1D1HHIse/QAI1ymGO9h24wt8LvBmmwo4ahQt4u8qzOzZ1cTD/PROTE38Q8eqDugDI8S0iZYklw6+QlQYGDSen7fB0zWiMQ5AAhsKb12AdxK2gXbf4B7g=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2019 11:37:38.1901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efa91f7-f6cb-405d-b560-08d6ffaad9c9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4720
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030140
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
 drivers/iio/adc/ad7606.c     |   9 +++
 drivers/iio/adc/ad7606.h     |  38 +++++++--
 drivers/iio/adc/ad7606_spi.c | 148 ++++++++++++++++++++++++++++++++++-
 3 files changed, 186 insertions(+), 9 deletions(-)

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
index b7faef69a58f..d96d8d6d5fc5 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -15,6 +15,40 @@
 
 #define MAX_SPI_FREQ_HZ		23500000	/* VDRIVE above 4.75 V */
 
+#define AD7616_CONFIGURATION_REGISTER	0x02
+#define AD7616_OS_MASK			GENMASK(4,  2)
+#define AD7616_BURST_MODE		BIT(6)
+#define AD7616_SEQEN_MODE		BIT(5)
+#define AD7616_RANGE_CH_ADDR_OFF	0x04
+#define AD7616_RANGE_CH_ADDR(ch)	((((ch) & 0x1) << 1) + ((ch) >> 3))
+#define AD7616_RANGE_CH_MSK(ch)		(GENMASK(1, 0) << ((ch) & 0x6))
+#define AD7616_RANGE_CH_MODE(ch, mode)	((mode) << (ch & GENMASK(2, 1)))
+
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
+	return ((addr & 0x7F) << 1) | ((isWriteOp & 0x1) << 7);
+}
+
 static int ad7606_spi_read_block(struct device *dev,
 				 int count, void *buf)
 {
@@ -35,17 +69,129 @@ static int ad7606_spi_read_block(struct device *dev,
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
+	unsigned int ch_addr, mode;
+
+	ch_addr = AD7616_RANGE_CH_ADDR_OFF + AD7616_RANGE_CH_ADDR(ch);
+	mode = AD7616_RANGE_CH_MODE(ch, ((val + 1) & 0x3));
+
+	return st->bops->write_mask(st, ch_addr, AD7616_RANGE_CH_MSK(ch),
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

