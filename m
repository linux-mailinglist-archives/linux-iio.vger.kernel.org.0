Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4683F946F
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2019 16:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfKLPgG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Nov 2019 10:36:06 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:22078 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726376AbfKLPgF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Nov 2019 10:36:05 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xACFNvJM014840;
        Tue, 12 Nov 2019 10:35:30 -0500
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2059.outbound.protection.outlook.com [104.47.33.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w7prfs1g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 10:35:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4XMiJh1HI3kQVfngANf1qTGt6Z9roJNpLClMf9gL0pAJpNdQ6P//9GPnk6C1NPMBL44m7FwXObJ3J1+4WEQy2OV/BpeZMMGJeoRyfZrK/U2/ecjQeFNgnMm7z4jDJXHrKYNQ6H4NPpj/LBmbdXM6QEGzp5Q98f6jS2jaRijkULr63NIlJb5HbOq5tJqJOJ3zjleB7bBt1ioilSE1YY/Xks/ENVsZQq98NGvXIfFNIR3BFGzpaTcJlSYFmIFDK+SucMII+5NyWdc2wrr2Xt1rhBdgeS5bEDF820Y+t1MHCkPoHh/sUrWEq9hkz/wDT4I+Z9ht3fSrjxWfKkLiXXRGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiGm8K3lxAsmd6drp0bjxFiXoqzRz9/xLu3WuiT3Drc=;
 b=TajOMrF12aiUOQCMujXN39HFfP+qnT6NbgryAQ8AYIku07DtpnLjtKdSn8gd/0hNblQPYe8xtzFvwvtVUd0SH0uk2iG4tnyq2q3olkY0m2FieoycX+Bktf1Uuzbafxb8r33KLGjhRPmYgEc3Rulx0dU3fmH7d156mPyHR7n40U73Ah/LYFoURREXddSZohg/+vwOAhzj3TS7jJ61Kh0ZlPFdABxvl/+8oRj4w6B6q+CFTDWodczjoPcpoGJ7zkiCPpjcxg7L0BSdY6VzrSRki3x7xPLGU/KEgSEij3DI++xvkrg1OrAU5+nuCr9gtoPJa1LQVIgSKFdCSCk83n2GCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiGm8K3lxAsmd6drp0bjxFiXoqzRz9/xLu3WuiT3Drc=;
 b=zLX9nx/6j9euJLbrmlKVlz7WQIr3oPUVOkbXtvkWar7MzurbcqVATOUVXkzWI3MvGQekDRNtZLwkHTegf+9mymLgkA0RPXHU4wRN0/1hmzyjQenzQSL126ZARinUyIvwoegmPVZX7Dme8I4/S5H4xBlR7F7GK6s3TwJZYP0mmoE=
Received: from BN3PR03CA0098.namprd03.prod.outlook.com (2603:10b6:400:4::16)
 by BN7PR03MB3618.namprd03.prod.outlook.com (2603:10b6:406:c3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Tue, 12 Nov
 2019 15:35:28 +0000
Received: from BL2NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BN3PR03CA0098.outlook.office365.com
 (2603:10b6:400:4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.23 via Frontend
 Transport; Tue, 12 Nov 2019 15:35:28 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT023.mail.protection.outlook.com (10.152.77.72) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Tue, 12 Nov 2019 15:35:28 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xACFZIBJ012255
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 12 Nov 2019 07:35:19 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 12 Nov 2019 10:35:26 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <paulmck@linux.ibm.com>, <mchehab+samsung@kernel.org>,
        <linus.walleij@linaro.org>, <nicolas.ferre@microchip.com>,
        <biabeniamin@outlook.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 1/3] iio: Add ADM1177 Hot Swap Controller and Digital Power Monitor driver
Date:   Tue, 12 Nov 2019 17:35:50 +0200
Message-ID: <20191112153552.27431-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(44832011)(486006)(2616005)(126002)(107886003)(2351001)(356004)(6666004)(966005)(47776003)(478600001)(8936002)(50226002)(246002)(6916009)(305945005)(50466002)(70206006)(70586007)(8676002)(476003)(48376002)(7636002)(51416003)(1076003)(36756003)(16586007)(7696005)(316002)(2906002)(6306002)(5660300002)(14444005)(106002)(4326008)(54906003)(336012)(7416002)(426003)(186003)(86362001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3618;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c302acf6-daf7-4a07-863d-08d76785f1f8
X-MS-TrafficTypeDiagnostic: BN7PR03MB3618:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <BN7PR03MB3618D09FDD3D66EE035BB7D1F0770@BN7PR03MB3618.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 021975AE46
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aGjr6jU4rIVrEV4iaZpFC1OGt81Z9mqk84EGR3NKn2qpVlKwOZv6jlFQ9vOLikHcRZ7MWAzov2flmG3TG5Ss3Nv3TkMbhfpMgpOlJ3Tzex0nna4iiXkrZtgVXWBAe5OzFX4CXDtQzJG1eeXR3166S6p6bx/RNWGLpmacuP4jHbsQfYhvZJh/5qYOGTLdC7Awb/caWPXKn6VEe7qEvKLrA3itb/4nhDSYzaVVGMfQ6CTllyIPGBtPcl7aQS3bio5PS9MAdlAb8SmLNjOgUgd8UKeZFvkEYlIbv5UQOfTK8uZ9i8Lkpm0P9+0JNn0wdDmWpOj2m//WTzr7l8niKjQaPqPZFVG+SNfBSY5VhE0DUxJdKob0EwtrZVPrFYcVx7db7gjZJQ8kH3uw//nffeZnUaSGERUoLGgzNa0ZqFc2xg9XBdzYtd8kEanokdHaDmrbZo1G/Dzr3WHxlVU4KC/0vLhPmNHJrLKC4mDbbWlx1Zo=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 15:35:28.3531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c302acf6-daf7-4a07-863d-08d76785f1f8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3618
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-12_05:2019-11-11,2019-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911120134
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

ADM1177 is a Hot Swap Controller and Digital Power Monitor with
Soft Start Pin.

Datasheet:
Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1177.pdf

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Co-developed-by: Beniamin Bia <beniamin.bia@analog.com>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/adc/Kconfig   |  12 ++
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/adm1177.c | 257 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 270 insertions(+)
 create mode 100644 drivers/iio/adc/adm1177.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 9554890a3200..4db8c6dcb595 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -228,6 +228,18 @@ config ASPEED_ADC
 	  To compile this driver as a module, choose M here: the module will be
 	  called aspeed_adc.
 
+config ADM1177
+	tristate "Analog Devices ADM1177 Digital Power Monitor driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Analog Devices:
+	  ADM1177 Hot Swap Controller and Digital Power Monitor
+	  with Soft Start Pin. Provides direct access
+	  via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called adm1177.
+
 config AT91_ADC
 	tristate "Atmel AT91 ADC"
 	depends on ARCH_AT91
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 5ecc481c2967..7899d6a158f3 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_AD7887) += ad7887.o
 obj-$(CONFIG_AD7949) += ad7949.o
 obj-$(CONFIG_AD799X) += ad799x.o
 obj-$(CONFIG_ASPEED_ADC) += aspeed_adc.o
+obj-$(CONFIG_ADM1177) += adm1177.o
 obj-$(CONFIG_AT91_ADC) += at91_adc.o
 obj-$(CONFIG_AT91_SAMA5D2_ADC) += at91-sama5d2_adc.o
 obj-$(CONFIG_AXP20X_ADC) += axp20x_adc.o
diff --git a/drivers/iio/adc/adm1177.c b/drivers/iio/adc/adm1177.c
new file mode 100644
index 000000000000..daec34566a65
--- /dev/null
+++ b/drivers/iio/adc/adm1177.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADM1177 Hot Swap Controller and Digital Power Monitor with Soft Start Pin
+ *
+ * Copyright 2015-2019 Analog Devices Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+
+/*  Command Byte Operations */
+#define ADM1177_CMD_V_CONT	BIT(0)
+#define ADM1177_CMD_V_ONCE	BIT(1)
+#define ADM1177_CMD_I_CONT	BIT(2)
+#define ADM1177_CMD_I_ONCE	BIT(3)
+#define ADM1177_CMD_VRANGE	BIT(4)
+#define ADM1177_CMD_STATUS_RD	BIT(6)
+
+/* Extended Register */
+#define ADM1177_REG_ALERT_EN	1
+#define ADM1177_REG_ALERT_TH	2
+#define ADM1177_REG_CONTROL	3
+
+/* ADM1177_REG_ALERT_EN */
+#define ADM1177_EN_ADC_OC1	BIT(0)
+#define ADM1177_EN_ADC_OC4	BIT(1)
+#define ADM1177_EN_HS_ALERT	BIT(2)
+#define ADM1177_EN_OFF_ALERT	BIT(3)
+#define ADM1177_CLEAR		BIT(4)
+
+/* ADM1177_REG_CONTROL */
+#define ADM1177_SWOFF		BIT(0)
+
+#define ADM1177_BITS		12
+
+/**
+ * struct adm1177_state - driver instance specific data
+ * @client		pointer to i2c client
+ * @reg			regulator info for the the power supply of the device
+ * @command		internal control register
+ * @r_sense_uohm	current sense resistor value
+ * @alert_threshold_ua	current limit for shutdown
+ * @vrange_high		internal voltage divider
+ */
+struct adm1177_state {
+	struct i2c_client	*client;
+	struct regulator	*reg;
+	u8			command;
+	u32			r_sense_uohm;
+	u32			alert_threshold_ua;
+	bool			vrange_high;
+};
+
+static int adm1177_read(struct adm1177_state *st, u8 num, u8 *data)
+{
+	struct i2c_client *client = st->client;
+	int ret = 0;
+
+	ret = i2c_master_recv(client, data, num);
+	if (ret < 0) {
+		dev_err(&client->dev, "I2C read error\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int adm1177_write_cmd(struct adm1177_state *st, u8 cmd)
+{
+	st->command = cmd;
+	return i2c_smbus_write_byte(st->client, cmd);
+}
+
+static int adm1177_write_reg(struct adm1177_state *st, u8 reg, u8 val)
+{
+	return i2c_smbus_write_byte_data(st->client, reg, val);
+}
+
+static int adm1177_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long mask)
+{
+	struct adm1177_state *st = iio_priv(indio_dev);
+	u8 data[3];
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		adm1177_read(st, 3, data);
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = (data[0] << 4) | (data[2] >> 4);
+			return IIO_VAL_INT;
+		case IIO_CURRENT:
+			*val = (data[1] << 4) | (data[2] & 0xF);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			if (st->command & ADM1177_CMD_VRANGE)
+				*val = 6650;
+			else
+				*val = 26350;
+
+			*val2 = ADM1177_BITS;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_CURRENT:
+			*val = 105840 / st->r_sense_uohm;
+
+			*val2 = ADM1177_BITS;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_chan_spec adm1177_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.channel = 0,
+	},
+	{
+		.type = IIO_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.channel = 0,
+	},
+};
+
+static const struct iio_info adm1177_info = {
+	.read_raw = &adm1177_read_raw,
+};
+static void adm1177_remove(void *data)
+{
+	struct adm1177_state *st = data;
+
+	if (st->reg)
+		regulator_disable(st->reg);
+}
+
+static int adm1177_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	int ret;
+	struct device_node *np;
+	struct adm1177_state *st;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	st->client = client;
+
+	np = client->dev.of_node;
+
+	st->reg = devm_regulator_get_optional(&client->dev, "vref");
+	if (IS_ERR(st->reg)) {
+		if (PTR_ERR(st->reg) == EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		st->reg = NULL;
+	} else {
+		ret = regulator_enable(st->reg);
+		if (ret)
+			return ret;
+		ret = devm_add_action_or_reset(&client->dev, adm1177_remove,
+					       st);
+		if (ret)
+			return ret;
+	}
+
+	of_property_read_u32(np, "adi,r-sense-micro-ohms", &st->r_sense_uohm);
+	of_property_read_u32(np, "adi,shutdown-threshold-microamp",
+			     &st->alert_threshold_ua);
+	st->vrange_high = of_property_read_bool(np,
+				"adi,vrange-high-enable");
+	if (st->alert_threshold_ua) {
+		unsigned int val;
+
+		val = (st->alert_threshold_ua * st->r_sense_uohm * 0xFF);
+		val /= 105840000U;
+		if (val > 0xFF) {
+			dev_err(&client->dev,
+				"Requested shutdown current %d uA above limit\n",
+				st->alert_threshold_ua);
+
+			val = 0xFF;
+		}
+		adm1177_write_reg(st, ADM1177_REG_ALERT_TH, val);
+	}
+
+	adm1177_write_cmd(st, ADM1177_CMD_V_CONT |
+			      ADM1177_CMD_I_CONT |
+			      (st->vrange_high ? 0 : ADM1177_CMD_VRANGE));
+
+	indio_dev->name = id->name;
+	indio_dev->channels = adm1177_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adm1177_channels);
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &adm1177_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id adm1177_ids[] = {
+	{ "adm1177", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, adm1177_ids);
+
+static const struct of_device_id adm1177_dt_ids[] = {
+	{ .compatible = "adi,adm1177" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, adm1177_dt_ids);
+
+static struct i2c_driver adm1177_driver = {
+	.driver = {
+		.name = "adm1177",
+		.of_match_table = adm1177_dt_ids,
+	},
+	.probe = adm1177_probe,
+	.id_table = adm1177_ids,
+};
+module_i2c_driver(adm1177_driver);
+
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADM1177 ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

