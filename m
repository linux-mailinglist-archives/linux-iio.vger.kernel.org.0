Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB3884D4A
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2019 15:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbfHGNcr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Aug 2019 09:32:47 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3350 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388393AbfHGNcq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Aug 2019 09:32:46 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77DS0Jl029504;
        Wed, 7 Aug 2019 09:31:53 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2053.outbound.protection.outlook.com [104.47.36.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u7bcx3bd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 09:31:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqpJjcEXe8+X8QpN6ZcUwaSZWCWzLAMHKA9LuVOuJxfypXXFN0ZVqy0ZOvZdCmaGqW6Alq0xkKfG91c0TyGDQaQLal+WJxBIzsvrN6uZjhD0e0ZHrHWE/4OFrI9Nxi91bQ46Tq1OfnI4ywzOAN017C6meb7n3OPnyeR79PUlmOug+kx6cdsljvT8KbUPznfj1zxyi2Uo8M1sZFSafmYGoDJxWBpw/VWdpT8p1lNMeWReOK0y0jTHrMwUAiDWBOVbV9i9JXKAhHmr0RplE0gqZ3di1qrYGFRld2588DFCTzr4rd5CWDthGSzkkiAn9S+oZhWgQbPhdL1mViN0CZYJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjKxyIUqHuAIlhPJ0Vfy27zwmRxNJnbxhGJ71ylOYgw=;
 b=O/chVLoSM0D1qnCaGwuYCINaiUKZ0xfp+BqaLuwVwHkMSgR7zWMKL5wDKIo9VJQPAB5SN4TNI1meHK0ey2juNajx2KsmgraHqFuc2LaPNR8TM61zAr2jH/qp1tiAybd5Okl60LwAQvMygRF8UGtURlMyd6pWGyhsQCk+jL+SE2Dre485kZ4vGlKl0c3o0GoMKAmA0yFQvlzhuZ3SBpx/75K7sZRzyGD99FxSiqDIvkBLwKtgpGWFcNteTpkk3uBAJzOa2B6Tzi1z8VGixWa6OYoKIPlnwQ602oX8OZIjbXLIp+6hypQjtNMsW50jFzdfbVgm3fgN7UuXZ+vmz2W1tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjKxyIUqHuAIlhPJ0Vfy27zwmRxNJnbxhGJ71ylOYgw=;
 b=jDgJrLLdl8OcZp4hw4G6NMtwC5ILtgCh1bCiXW5ucTxY4CHPWB30Zr6qpXMMueB0YFqikchkJjdAE9zPL8MnHWovMZbetVXU6KAlOSpzdsptOWsemLSw1FwZSpuNEOJ23bdyEFHjYT1oTcpPi4pS9C9JqJV3R6IBeKF/nZhFgKQ=
Received: from DM6PR03CA0056.namprd03.prod.outlook.com (2603:10b6:5:100::33)
 by MWHPR03MB2429.namprd03.prod.outlook.com (2603:10b6:300:b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14; Wed, 7 Aug
 2019 13:31:50 +0000
Received: from CY1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by DM6PR03CA0056.outlook.office365.com
 (2603:10b6:5:100::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.16 via Frontend
 Transport; Wed, 7 Aug 2019 13:31:50 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT041.mail.protection.outlook.com (10.152.74.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Wed, 7 Aug 2019 13:31:48 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x77DVi0O028918
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 7 Aug 2019 06:31:44 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 7 Aug 2019 09:31:47 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <paulmck@linux.ibm.com>,
        <mchehab+samsung@kernel.org>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <biabeniamin@outlook.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v2 1/4] iio: adc: ad7606: Add support for AD7606B ADC
Date:   Wed, 7 Aug 2019 16:31:34 +0300
Message-ID: <20190807133137.11185-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(189003)(199004)(4326008)(246002)(50466002)(7636002)(36756003)(305945005)(478600001)(2870700001)(106002)(86362001)(7416002)(186003)(47776003)(1076003)(26005)(6916009)(8676002)(2906002)(14444005)(2351001)(44832011)(336012)(50226002)(2616005)(8936002)(54906003)(107886003)(5660300002)(476003)(6666004)(356004)(426003)(126002)(5820100001)(70586007)(70206006)(7696005)(23676004)(316002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2429;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7fd00ec-97a8-4ce0-1214-08d71b3b9a1c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MWHPR03MB2429;
X-MS-TrafficTypeDiagnostic: MWHPR03MB2429:
X-Microsoft-Antispam-PRVS: <MWHPR03MB2429F4D055996FC52C694AE9F0D40@MWHPR03MB2429.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 01221E3973
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: XstJhy1cuVOu6GBa8nJgQ+D6Rv5ZUJZrkTDY5kFaU/J3RU12nipF2EKxLS/hsJoMxQQv0HBAdxY8Ja1fHvf7DTRBTdCA1akjjPYsDQ2iFlSbAQtr5bE/UfzzO5MXNzi/k0Zir9VBs+8BtAZ9fovrh069135/+DqBDOZfJUVbIuopBOkhNe3J9tLBaoBIrsP4DWnlELyYPLOKH5SlwkSItKWVy2YPpyJJGdWanrE8HyiSvxVQS8xzqTI2YhUMmxl5VVV+x0GpkmixbX8zY5DadeSiOaCbdY/vjw4vKsdBBH92QP7gRpA9NkD2qlGKO6woAKybHlmDUoEcrAuqrcmTquvb/HMK/VhYZH+akS+ZAAbSarb84fhE9EwnDykm6YIibLqgAwSoHtOHVlipXSYp0KtMXlFUS++QbYyA+ftykKE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2019 13:31:48.8237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fd00ec-97a8-4ce0-1214-08d71b3b9a1c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2429
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070147
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

The AD7606B is a 16-bit ADC that supports simultaneous sampling of 8
channels. It is pin compatible to AD7606, but adds extra modes by
writing to the register map.

The AD7606B can be configured to work in software mode by setting all
oversampling pins to high. This mode is selected by default.
The oversampling ratio is configured from the OS_MODE register (address
0x08) with the addition of OS=128 and OS=256 that were not available in
hardware mode.

The device is configured to output data on a single spi channel, but this
configuration must be done right after restart. That is why the delay was
removed for devices which doesn't require it.

Moreover, in software mode, the range gpio has no longer its function.
Instead, the scale can be configured individually for each channel from
the RANGE_CH registers (address 0x03 to 0x06). Besides the already
supported ±10 V and ±5 V ranges, software mode can also accommodate the
±2.5 V range.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Co-developed-by: Beniamin Bia <beniamin.bia@analog.com>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
Changes in v2:
-nothing changed

 drivers/iio/adc/ad7606.c     |  13 ++++-
 drivers/iio/adc/ad7606.h     |   4 ++
 drivers/iio/adc/ad7606_spi.c | 107 +++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index ed2d08437e5d..f5ba94c03a8d 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -410,12 +410,19 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
 		.oversampling_avail = ad7606_oversampling_avail,
 		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	},
+	[ID_AD7606B] = {
+		.channels = ad7606_channels,
+		.num_channels = 9,
+		.oversampling_avail = ad7606_oversampling_avail,
+		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	},
 	[ID_AD7616] = {
 		.channels = ad7616_channels,
 		.num_channels = 17,
 		.oversampling_avail = ad7616_oversampling_avail,
 		.oversampling_num = ARRAY_SIZE(ad7616_oversampling_avail),
 		.os_req_reset = true,
+		.init_delay_ms = 15,
 	},
 };
 
@@ -631,8 +638,10 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
 
 	/* AD7616 requires al least 15ms to reconfigure after a reset */
-	if (msleep_interruptible(15))
-		return -ERESTARTSYS;
+	if (st->chip_info->init_delay_ms) {
+		if (msleep_interruptible(st->chip_info->init_delay_ms))
+			return -ERESTARTSYS;
+	}
 
 	st->write_scale = ad7606_write_scale_hw;
 	st->write_os = ad7606_write_os_hw;
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index eeaaa8b905db..9350ef1f63b5 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -46,6 +46,8 @@
  *			oversampling ratios.
  * @oversampling_num	number of elements stored in oversampling_avail array
  * @os_req_reset	some devices require a reset to update oversampling
+ * @init_delay_ms	required delay in miliseconds for initialization
+ *			after a restart
  */
 struct ad7606_chip_info {
 	const struct iio_chan_spec	*channels;
@@ -53,6 +55,7 @@ struct ad7606_chip_info {
 	const unsigned int		*oversampling_avail;
 	unsigned int			oversampling_num;
 	bool				os_req_reset;
+	unsigned long			init_delay_ms;
 };
 
 /**
@@ -155,6 +158,7 @@ enum ad7606_supported_device_ids {
 	ID_AD7606_8,
 	ID_AD7606_6,
 	ID_AD7606_4,
+	ID_AD7606B,
 	ID_AD7616,
 };
 
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 98ed52b74507..070ee7e31e2c 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -31,6 +31,20 @@
 /* The range of the channel is stored on 2 bits*/
 #define AD7616_RANGE_CH_MSK(ch)		(0b11 << (((ch) & 0b11) * 2))
 #define AD7616_RANGE_CH_MODE(ch, mode)	((mode) << ((((ch) & 0b11)) * 2))
+
+#define AD7606_CONFIGURATION_REGISTER	0x02
+#define AD7606_SINGLE_DOUT		0x0
+
+/*
+ * Range for AD7606B channels are stored in registers starting with address 0x3.
+ * Each register stores range for 2 channels(4 bits per channel).
+ */
+#define AD7606_RANGE_CH_MSK(ch)		(GENMASK(3, 0) << (4 * ((ch) & 0x1)))
+#define AD7606_RANGE_CH_MODE(ch, mode)	\
+	((GENMASK(3, 0) & mode) << (4 * ((ch) & 0x1)))
+#define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
+#define AD7606_OS_MODE			0x08
+
 static const struct iio_chan_spec ad7616_sw_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(16),
 	AD7616_CHANNEL(0),
@@ -51,6 +65,22 @@ static const struct iio_chan_spec ad7616_sw_channels[] = {
 	AD7616_CHANNEL(15),
 };
 
+static const struct iio_chan_spec ad7606B_sw_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+	AD7616_CHANNEL(0),
+	AD7616_CHANNEL(1),
+	AD7616_CHANNEL(2),
+	AD7616_CHANNEL(3),
+	AD7616_CHANNEL(4),
+	AD7616_CHANNEL(5),
+	AD7616_CHANNEL(6),
+	AD7616_CHANNEL(7),
+};
+
+static const unsigned int ad7606B_oversampling_avail[9] = {
+	1, 2, 4, 8, 16, 32, 64, 128, 256
+};
+
 static u16 ad7616_spi_rd_wr_cmd(int addr, char isWriteOp)
 {
 	/*
@@ -60,6 +90,16 @@ static u16 ad7616_spi_rd_wr_cmd(int addr, char isWriteOp)
 	return ((addr & 0x7F) << 1) | ((isWriteOp & 0x1) << 7);
 }
 
+static u16 ad7606B_spi_rd_wr_cmd(int addr, char isWriteOp)
+{
+	/*
+	 * The address of register consists of one bit which
+	 * specifies a read command placed bit 6, followed by
+	 * 6 bits of address.
+	 */
+	return (addr & 0x3F) | (((~isWriteOp) & 0x1) << 6);
+}
+
 static int ad7606_spi_read_block(struct device *dev,
 				 int count, void *buf)
 {
@@ -169,6 +209,23 @@ static int ad7616_write_os_sw(struct iio_dev *indio_dev, int val)
 				     AD7616_OS_MASK, val << 2);
 }
 
+static int ad7606_write_scale_sw(struct iio_dev *indio_dev, int ch, int val)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	return ad7606_spi_write_mask(st,
+				     AD7606_RANGE_CH_ADDR(ch),
+				     AD7606_RANGE_CH_MSK(ch),
+				     AD7606_RANGE_CH_MODE(ch, val));
+}
+
+static int ad7606_write_os_sw(struct iio_dev *indio_dev, int val)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	return ad7606_spi_reg_write(st, AD7606_OS_MODE, val);
+}
+
 static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
@@ -189,6 +246,42 @@ static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
 			      AD7616_BURST_MODE | AD7616_SEQEN_MODE);
 }
 
+static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned long os[3] = {1};
+
+	/*
+	 * Software mode is enabled when all three oversampling
+	 * pins are set to high. If oversampling gpios are defined
+	 * in the device tree, then they need to be set to high,
+	 * otherwise, they must be hardwired to VDD
+	 */
+	if (st->gpio_os) {
+		gpiod_set_array_value(ARRAY_SIZE(os),
+				      st->gpio_os->desc, st->gpio_os->info, os);
+	}
+	/* OS of 128 and 256 are available only in software mode */
+	st->oversampling_avail = ad7606B_oversampling_avail;
+	st->num_os_ratios = ARRAY_SIZE(ad7606B_oversampling_avail);
+
+	st->write_scale = ad7606_write_scale_sw;
+	st->write_os = &ad7606_write_os_sw;
+
+	/* Configure device spi to output on a single channel */
+	st->bops->reg_write(st,
+			    AD7606_CONFIGURATION_REGISTER,
+			    AD7606_SINGLE_DOUT);
+
+	/*
+	 * Scale can be configured individually for each channel
+	 * in software mode.
+	 */
+	indio_dev->channels = ad7606B_sw_channels;
+
+	return 0;
+}
+
 static const struct ad7606_bus_ops ad7606_spi_bops = {
 	.read_block = ad7606_spi_read_block,
 };
@@ -202,6 +295,15 @@ static const struct ad7606_bus_ops ad7616_spi_bops = {
 	.sw_mode_config = ad7616_sw_mode_config,
 };
 
+static const struct ad7606_bus_ops ad7606B_spi_bops = {
+	.read_block = ad7606_spi_read_block,
+	.reg_read = ad7606_spi_reg_read,
+	.reg_write = ad7606_spi_reg_write,
+	.write_mask = ad7606_spi_write_mask,
+	.rd_wr_cmd = ad7606B_spi_rd_wr_cmd,
+	.sw_mode_config = ad7606B_sw_mode_config,
+};
+
 static int ad7606_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
@@ -211,6 +313,9 @@ static int ad7606_spi_probe(struct spi_device *spi)
 	case ID_AD7616:
 		bops = &ad7616_spi_bops;
 		break;
+	case ID_AD7606B:
+		bops = &ad7606B_spi_bops;
+		break;
 	default:
 		bops = &ad7606_spi_bops;
 		break;
@@ -226,6 +331,7 @@ static const struct spi_device_id ad7606_id_table[] = {
 	{ "ad7606-4", ID_AD7606_4 },
 	{ "ad7606-6", ID_AD7606_6 },
 	{ "ad7606-8", ID_AD7606_8 },
+	{ "ad7606b",  ID_AD7606B },
 	{ "ad7616",   ID_AD7616 },
 	{}
 };
@@ -236,6 +342,7 @@ static const struct of_device_id ad7606_of_match[] = {
 	{ .compatible = "adi,ad7606-4" },
 	{ .compatible = "adi,ad7606-6" },
 	{ .compatible = "adi,ad7606-8" },
+	{ .compatible = "adi,ad7606b" },
 	{ .compatible = "adi,ad7616" },
 	{ },
 };
-- 
2.17.1

