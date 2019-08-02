Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5DB77F452
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2019 12:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405120AbfHBKEZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Aug 2019 06:04:25 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2438 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390716AbfHBKEN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Aug 2019 06:04:13 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72A2L6q028756;
        Fri, 2 Aug 2019 06:03:28 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2050.outbound.protection.outlook.com [104.47.33.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u4jdfg3tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 06:03:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLEMVJ/is7LIzueyaxVuy/8eKs9mRVvpPOVsZZntwp6V6s8g2JEEcLg+aNFSy+1vSbXUdtQus2JtNAMJZe67OLgLpqG94kvqTIC5OGSpldPgHpzSHSWnSYi8GbLzqGtd6T5bmZdu/M3z62Mm7vMNldxK1gQGQNFeeJdcgiZUFj8tg07nUPY40ohdEPY2BkTSDNo4NUUpWNpZp3sEqVStzwyNv1HNKe5wY0oaUrpS4baQRE1PqDt5JqRUOR0lcvSbJXesFfzCsuk4dLi/hVFDKV2pJwen94Wdy/jZCB7vd8pZFscghXfyScB0ixvTqzDa/zxbc/lAjKooVqi9N3UpHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNK2/8LN8VMf9bRy4br24HkEx5YObFuWM0J5rqw5GFY=;
 b=QitxlB2sTLY6cLd7BZ5b2tPAEaSCC0Az7CFSV7aSuVuW5TK2L4GVF9Cb/I1pKkBLzU5BIXWje+oRL/oNYGIwujBQVzulZgZspi1sE4bpC1XDN36HQJpnHNH2CkCzLXlwnMiA/LMX1cNIN3fKdA6JxLW1lqm7lfYWjhnb8u6w4xfrRblCsKEjNfS+t8rlOonHSYlloQx4j0pej16oY/9yEng+cPUgXPv4O+kmJTFGbX1LO3SOd4LiWRjPHjz+axA766WkN6h7HjiG2/hxUnG4zFcGbZMsoJDgWinOFMdAs1UjPk6h2UWX65GVQqRQiTkL/W3+rX1UHrsoSyOrMkGwXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNK2/8LN8VMf9bRy4br24HkEx5YObFuWM0J5rqw5GFY=;
 b=HuSkQtzwbHMkWdQCcbNOaLTo6zS5GCaMpJzl8DEiTO5uFOP+fZ/DdaaMeNI6joTUW5GmgtcGxf5PN3ayCVX6Qn5R23/K/hKjvb+DPFLl1rsHqWwP9B9e+agpOx2Psin+JUCAmXV5K5rTESoT9XfCR4Kq1/7SjykBVtDMaoY+9fA=
Received: from DM3PR03CA0022.namprd03.prod.outlook.com (2603:10b6:0:50::32) by
 MWHPR03MB3310.namprd03.prod.outlook.com (2603:10b6:301:43::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Fri, 2 Aug 2019 10:03:25 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by DM3PR03CA0022.outlook.office365.com
 (2603:10b6:0:50::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.12 via Frontend
 Transport; Fri, 2 Aug 2019 10:03:24 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2136.14
 via Frontend Transport; Fri, 2 Aug 2019 10:03:24 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x72A3NQC025274
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 2 Aug 2019 03:03:23 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 2 Aug 2019 06:03:23 -0400
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
Subject: [PATCH 1/4] iio: adc: ad7606: Add support for AD7606B ADC
Date:   Fri, 2 Aug 2019 13:03:01 +0300
Message-ID: <20190802100304.15899-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(136003)(376002)(39860400002)(346002)(396003)(2980300002)(189003)(199004)(478600001)(7636002)(50226002)(14444005)(486006)(476003)(126002)(70586007)(5660300002)(246002)(2616005)(106002)(8936002)(356004)(6666004)(70206006)(1076003)(316002)(8676002)(5820100001)(426003)(305945005)(44832011)(54906003)(336012)(7416002)(86362001)(186003)(4326008)(2906002)(107886003)(2351001)(2870700001)(36756003)(50466002)(26005)(6916009)(23676004)(47776003)(7696005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3310;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c535782-5af1-4246-c8fd-08d71730a865
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MWHPR03MB3310;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3310:
X-Microsoft-Antispam-PRVS: <MWHPR03MB33102C6540E898AFAAEB49A7F0D90@MWHPR03MB3310.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 011787B9DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 7hlZJM1Eo86lkmEG+AAS6Xh5zDvKbvGZYGBUyV7VHgJmdmT6TqF6E0iZQheRKQmUytHm+BSDELje7BqIG3k2Xg45PadohDnDOqvY/SW0N81ObhqKHPrYFzDVD8tDKsiDcunlzBIUwlj++UAtfIIIxK+kSi91HYVf/SUj/XtJmvufmbdtR9D0F0Yv+E9Jsg6eGJW+HuhJrv1Ghuj6gAEZ1VWDdv/+jUzjh6wRbdgT4GF4NEOx9vzR6/yH5rPinrmttAZOLw/fRJvwIc3U/qhZZ4Dwvmj2j7foTqSWzAmqNba7j+EsfWL5Fd7LpWAe6zZkAVEMBBLWZA8X7NkS2jRNw/suKu8VCRVmAhrkX9a640jdzTK3XQnX4Tw/ZK3mEL2KwxeDEV93IiG+phIlsyC2CsPT0/jBJ8CG9jq7oYoWGnM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2019 10:03:24.6365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c535782-5af1-4246-c8fd-08d71730a865
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3310
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020102
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
---
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

