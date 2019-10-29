Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF46E8984
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2019 14:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388256AbfJ2Nai (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Oct 2019 09:30:38 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2940 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726858AbfJ2Nai (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2019 09:30:38 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TDRqPI015098;
        Tue, 29 Oct 2019 09:29:15 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2058.outbound.protection.outlook.com [104.47.33.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vvk26f2yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 09:29:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U18vShZwpHU5lhVVyZuWUCTTRx2kUX50uc9navf9djIwIigv0lQ5oGjPJ3VoUxYCDVI4PPwJYRgv7abwGWnxDuJC5TYpoPIUyQDKrBweC3WzE9SlEHpWh3x0JXu8COtypnLDwtr67S0Fxh0CEEoGS8GfdG1oS3pBLri+fEOu2zYkpGKzxFoURN2w3KyUk+SzhO9CbBaExoFPeYmW572JIOZPrh8FAeaaWtUBgbHFr5R8FRudxBRjYw58AopSBJQtzAuCu33xcruR4W5udXdaT8dYr0PBE50JGZDPq42taVYkXBi7ZuYzHKJx68mE5rGm3gUbdKIgunQe/xfIhF8nOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwOQSctrHkMqvmUhNhpYdgInKnkuVMe+jVc9or4fY+g=;
 b=ahnCi/Rr7OHW2DViWibfRT7TscdAtFMgCQ6QYlhpG9PVdv9UFCZjYUQ3uSfFdW6FCm/jvKu9j7g6Plz40pnt5scg+3AEl+sO0jYZxEqgd+C+hUgZfNcUXi8s86zLAckBBK/vvhYzYa63JOQAnenIzIQ5KcxugpffnKrHjdmrxFCtS+mHZA6/Ee7hIxJ026dT9iNhjVzFlrFlHiFonApfXvdJtoNHgbr+vW1HU77f0f1uucO9v8HC/TRBvTWqMLmZrOdi5r/HHQNbMlI5y+50APS4UK/IbVSDjorD6uu/C1YDSskZldbk4682RrPg8JJ/O/R9UhJIWZTh5qzcI5CdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwOQSctrHkMqvmUhNhpYdgInKnkuVMe+jVc9or4fY+g=;
 b=qhD/Ja7LVA3Oq8arxXr6BicqhdpGM13ZvQs91ftH2hikjygJL8qjBbggvihx140FP3mzTq7UFGaqGJ3Fsx//cEzXNGx9N7U48q9Hjg5UeW2tFmnydxumNwz8O3EYKZ6MS+I9xc4ro7vuTl5bTb3QjQq/sf2ZtI/ka7MS399nlc8=
Received: from BN6PR03CA0086.namprd03.prod.outlook.com (2603:10b6:405:6f::24)
 by SN6PR03MB4206.namprd03.prod.outlook.com (2603:10b6:805:c5::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Tue, 29 Oct
 2019 13:29:12 +0000
Received: from CY1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by BN6PR03CA0086.outlook.office365.com
 (2603:10b6:405:6f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.23 via Frontend
 Transport; Tue, 29 Oct 2019 13:29:11 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT030.mail.protection.outlook.com (10.152.75.163) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Tue, 29 Oct 2019 13:29:11 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x9TDT24P025579
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 29 Oct 2019 06:29:02 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 29 Oct 2019 09:29:09 -0400
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
        Paul Cercueil <paul.cercueil@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v2 1/4] iio: adc: Add support for AD7091R5 ADC
Date:   Tue, 29 Oct 2019 18:29:25 +0200
Message-ID: <20191029162928.9720-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(199004)(189003)(7696005)(476003)(6666004)(36756003)(7416002)(51416003)(356004)(1076003)(126002)(246002)(86362001)(486006)(44832011)(26005)(8676002)(2351001)(5660300002)(7636002)(70586007)(50226002)(70206006)(305945005)(6306002)(8936002)(336012)(2616005)(107886003)(186003)(6916009)(966005)(48376002)(14444005)(316002)(47776003)(16586007)(54906003)(478600001)(50466002)(426003)(106002)(4326008)(2906002)(30864003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB4206;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dc8c1ad-802b-409d-846c-08d75c73fbf0
X-MS-TrafficTypeDiagnostic: SN6PR03MB4206:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <SN6PR03MB4206FFD9BA1E9FDC9C7E1D9AF0610@SN6PR03MB4206.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0205EDCD76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgZ7A7vmv05MFyDajDiM/D/Eafhq9lHZKLY4jTB/wyvb7qANOCNEsIEJZ0ZTuwURPJaFH1YKk3OR1NlSI2G5akTltg6Ar3fo9eHv4ARkdL+kNyEwK/UgSpzYqk+P2Q6FAvyTJbqTwKEpw1a7KLgGTudSPod9gr0+7nvXiyUeESTW1BopCMz34DXcHwbdxKSLnrYhjv/7ZC8sAlI3pzXWyxVsTAS0C9ndGPtFE4glKbHhQ+PIEvH6IGKf4srtq/iYZ/2WHV75L1s+y/GnI3uJMnzqtOcF3XPM4N/C1hqWbvG7RrPlfVCzCmlxKZCReg1juuRvhGBY8e+golFhJJSNXLJLf3L1uI6IJXX++VftsUq5HOhTb1ThYLd4fyD1IlSqHRRfEV4FTCHvT3MGmOcsa7elg8n2zlXWMk7cVWMe7Tw9wNZzUHjollFTLHx6N4+WBbYSEaqlcSsi8FFfpMlE2Aoq3HM2Gc1Dj2yZuhomWZw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2019 13:29:11.2671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc8c1ad-802b-409d-846c-08d75c73fbf0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4206
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_04:2019-10-28,2019-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910290132
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Paul Cercueil <paul.cercueil@analog.com>

AD7091 is 4-Channel, I2C, Ultra Low Power,12-Bit ADC.

Datasheet:
Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ad7091r-5.pdf

Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
Co-developed-by: Beniamin Bia <beniamin.bia@analog.com>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v2:
-blank lines removed
-prefix added to macros
-comments rework
-error checking syntax changed
-iio mutex replaced by a mutex
-device remove function was removed and later replaced by devm_add_action
-regmap include removed from header

 drivers/iio/adc/Kconfig        |   7 +
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/ad7091r-base.c | 264 +++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7091r-base.h |  25 ++++
 drivers/iio/adc/ad7091r5.c     | 102 +++++++++++++
 5 files changed, 399 insertions(+)
 create mode 100644 drivers/iio/adc/ad7091r-base.c
 create mode 100644 drivers/iio/adc/ad7091r-base.h
 create mode 100644 drivers/iio/adc/ad7091r5.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7e3286265a38..80b1b9551749 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -22,6 +22,13 @@ config AD7124
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad7124.
 
+config AD7091R5
+	tristate "Analog Devices AD7091R5 ADC Driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say yes here to build support for Analog Devices AD7091R-5 ADC.
+
 config AD7266
 	tristate "Analog Devices AD7265/AD7266 ADC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index ef9cc485fb67..55e44735aaac 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -6,6 +6,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
 obj-$(CONFIG_AD7124) += ad7124.o
+obj-$(CONFIG_AD7091R5) += ad7091r5.o ad7091r-base.o
 obj-$(CONFIG_AD7266) += ad7266.o
 obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7298) += ad7298.o
diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
new file mode 100644
index 000000000000..c2500f614d54
--- /dev/null
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AD7091RX Analog to Digital converter driver
+ *
+ * Copyright 2014-2019 Analog Devices Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "ad7091r-base.h"
+
+#define AD7091R_REG_RESULT  0
+#define AD7091R_REG_CHANNEL 1
+#define AD7091R_REG_CONF    2
+#define AD7091R_REG_ALERT   3
+#define AD7091R_REG_CH_LOW_LIMIT(ch) ((ch) * 3 + 4)
+#define AD7091R_REG_CH_HIGH_LIMIT(ch) ((ch) * 3 + 5)
+#define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
+
+/* AD7091R_REG_RESULT */
+#define AD7091R_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)
+#define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
+
+/* AD7091R_REG_CONF */
+#define AD7091R_REG_CONF_AUTO   BIT(8)
+#define AD7091R_REG_CONF_CMD    BIT(10)
+
+#define AD7091R_REG_CONF_MODE_MASK  \
+	(AD7091R_REG_CONF_AUTO | AD7091R_REG_CONF_CMD)
+
+enum ad7091r_mode {
+	AD7091R_MODE_SAMPLE,
+	AD7091R_MODE_COMMAND,
+	AD7091R_MODE_AUTOCYCLE,
+};
+
+struct ad7091r_state {
+	struct device *dev;
+	struct regmap *map;
+	const struct ad7091r_chip_info *chip_info;
+	enum ad7091r_mode mode;
+	struct mutex lock;
+};
+
+static int ad7091r_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
+{
+	int ret;
+
+	switch (mode) {
+	case AD7091R_MODE_SAMPLE:
+		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
+					 AD7091R_REG_CONF_MODE_MASK, 0);
+		break;
+	case AD7091R_MODE_COMMAND:
+		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
+					 AD7091R_REG_CONF_MODE_MASK,
+					 AD7091R_REG_CONF_CMD);
+		break;
+	case AD7091R_MODE_AUTOCYCLE:
+		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
+					 AD7091R_REG_CONF_MODE_MASK,
+					 AD7091R_REG_CONF_AUTO);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret)
+		return ret;
+
+	st->mode = mode;
+
+	return ret;
+}
+
+static int ad7091r_set_channel(struct ad7091r_state *st, unsigned int channel)
+{
+	unsigned int foo;
+	int ret;
+
+	/* AD7091R_REG_CHANNEL specified which channels to be converted */
+	ret = regmap_write(st->map, AD7091R_REG_CHANNEL,
+			BIT(channel) | (BIT(channel) << 8));
+	if (ret)
+		return ret;
+
+	/*
+	 * There is a latency of one conversion before the channel conversion
+	 * sequence is updated
+	 */
+	return regmap_read(st->map, AD7091R_REG_RESULT, &foo);
+}
+
+static int ad7091r_read_one(struct iio_dev *iio_dev,
+		unsigned int channel, unsigned int *read_val)
+{
+	struct ad7091r_state *st = iio_priv(iio_dev);
+	unsigned int val;
+	int ret;
+
+	ret = ad7091r_set_channel(st, channel);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->map, AD7091R_REG_RESULT, &val);
+	if (ret)
+		return ret;
+
+	if (AD7091R_REG_RESULT_CH_ID(val) != channel)
+		return -EIO;
+
+	*read_val = AD7091R_REG_RESULT_CONV_RESULT(val);
+
+	return 0;
+}
+
+static int ad7091r_read_raw(struct iio_dev *iio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long m)
+{
+	struct ad7091r_state *st = iio_priv(iio_dev);
+	unsigned int read_val;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	switch (m) {
+	case IIO_CHAN_INFO_RAW:
+		if (st->mode != AD7091R_MODE_COMMAND) {
+			ret = -EBUSY;
+			goto unlock;
+		}
+
+		ret = ad7091r_read_one(iio_dev, chan->channel, &read_val);
+		if (ret)
+			goto unlock;
+
+		*val = read_val;
+		ret = IIO_VAL_INT;
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static const struct iio_info ad7091r_info = {
+	.read_raw = ad7091r_read_raw,
+};
+
+static irqreturn_t ad7091r_event_handler(int irq, void *private)
+{
+	struct ad7091r_state *st = (struct ad7091r_state *) private;
+	struct iio_dev *iio_dev = dev_get_drvdata(st->dev);
+	unsigned int i, read_val;
+	int ret;
+	s64 timestamp = iio_get_time_ns(iio_dev);
+
+	ret = regmap_read(st->map, AD7091R_REG_ALERT, &read_val);
+	if (ret)
+		return IRQ_HANDLED;
+
+	for (i = 0; i < st->chip_info->num_channels; i++) {
+		if (read_val & BIT(i * 2))
+			iio_push_event(iio_dev,
+					IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
+						IIO_EV_TYPE_THRESH,
+						IIO_EV_DIR_RISING), timestamp);
+		if (read_val & BIT(i * 2 + 1))
+			iio_push_event(iio_dev,
+					IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
+						IIO_EV_TYPE_THRESH,
+						IIO_EV_DIR_FALLING), timestamp);
+	}
+
+	return IRQ_HANDLED;
+}
+
+int ad7091r_probe(struct device *dev, const char *name,
+		const struct ad7091r_chip_info *chip_info,
+		struct regmap *map, int irq)
+{
+	struct iio_dev *iio_dev;
+	struct ad7091r_state *st;
+	int ret;
+
+	iio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(iio_dev);
+	st->dev = dev;
+	st->chip_info = chip_info;
+	st->map = map;
+
+	iio_dev->dev.parent = dev;
+	iio_dev->name = name;
+	iio_dev->info = &ad7091r_info;
+	iio_dev->modes = INDIO_DIRECT_MODE;
+
+	iio_dev->num_channels = chip_info->num_channels;
+	iio_dev->channels = chip_info->channels;
+
+	if (irq) {
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+				ad7091r_event_handler,
+				IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, st);
+		if (ret)
+			return ret;
+	}
+
+	/* Use command mode by default to convert only desired channels*/
+	ret = ad7091r_set_mode(st, AD7091R_MODE_COMMAND);
+	if (ret < 0)
+		return ret;
+
+	return iio_device_register(iio_dev);
+}
+EXPORT_SYMBOL_GPL(ad7091r_probe);
+
+static bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case AD7091R_REG_RESULT:
+	case AD7091R_REG_ALERT:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case AD7091R_REG_RESULT:
+	case AD7091R_REG_ALERT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+const struct regmap_config ad7091r_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.writeable_reg = ad7091r_writeable_reg,
+	.volatile_reg = ad7091r_volatile_reg,
+};
+EXPORT_SYMBOL_GPL(ad7091r_regmap_config);
+
+MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7091Rx multi-channel converters");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
new file mode 100644
index 000000000000..5f1147735953
--- /dev/null
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AD7091RX Analog to Digital converter driver
+ *
+ * Copyright 2014-2019 Analog Devices Inc.
+ */
+
+#ifndef __DRIVERS_IIO_ADC_AD7091R_BASE_H__
+#define __DRIVERS_IIO_ADC_AD7091R_BASE_H__
+
+struct device;
+struct ad7091r_state;
+
+struct ad7091r_chip_info {
+	unsigned int num_channels;
+	const struct iio_chan_spec *channels;
+};
+
+extern const struct regmap_config ad7091r_regmap_config;
+
+int ad7091r_probe(struct device *dev, const char *name,
+		const struct ad7091r_chip_info *chip_info,
+		struct regmap *map, int irq);
+
+#endif /* __DRIVERS_IIO_ADC_AD7091R5_BASE_H__ */
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
new file mode 100644
index 000000000000..2c44dd02ba1a
--- /dev/null
+++ b/drivers/iio/adc/ad7091r5.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AD7091R5 Analog to Digital converter driver
+ *
+ * Copyright 2014-2019 Analog Devices Inc.
+ */
+
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "ad7091r-base.h"
+
+static const struct iio_event_spec ad7091r5_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+};
+
+#define AD7091R_CHANNEL(idx, bits, ev, num_ev) { \
+	.type = IIO_VOLTAGE, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.indexed = 1, \
+	.channel = idx, \
+	.event_spec = ev, \
+	.num_event_specs = num_ev, \
+}
+static const struct iio_chan_spec ad7091r5_channels_irq[] = {
+	AD7091R_CHANNEL(0, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
+	AD7091R_CHANNEL(1, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
+	AD7091R_CHANNEL(2, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
+	AD7091R_CHANNEL(3, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
+};
+
+static const struct iio_chan_spec ad7091r5_channels_noirq[] = {
+	AD7091R_CHANNEL(0, 12, NULL, 0),
+	AD7091R_CHANNEL(1, 12, NULL, 0),
+	AD7091R_CHANNEL(2, 12, NULL, 0),
+	AD7091R_CHANNEL(3, 12, NULL, 0),
+};
+#undef AD7091R_CHANNEL
+
+static const struct ad7091r_chip_info ad7091r5_chip_info_irq = {
+	.channels = ad7091r5_channels_irq,
+	.num_channels = ARRAY_SIZE(ad7091r5_channels_irq),
+};
+
+static const struct ad7091r_chip_info ad7091r5_chip_info_noirq = {
+	.channels = ad7091r5_channels_noirq,
+	.num_channels = ARRAY_SIZE(ad7091r5_channels_noirq),
+};
+
+static int ad7091r5_i2c_probe(struct i2c_client *i2c,
+		const struct i2c_device_id *id)
+{
+	const struct ad7091r_chip_info *chip_info;
+	struct regmap *map = devm_regmap_init_i2c(i2c, &ad7091r_regmap_config);
+
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	if (i2c->irq)
+		chip_info = &ad7091r5_chip_info_irq;
+	else
+		chip_info = &ad7091r5_chip_info_noirq;
+
+	return ad7091r_probe(&i2c->dev, id->name, chip_info, map, i2c->irq);
+}
+
+static const struct i2c_device_id ad7091r5_i2c_ids[] = {
+	{"ad7091r5", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ad7091r5_i2c_ids);
+
+static struct i2c_driver ad7091r5_driver = {
+	.driver = {
+		.name = "ad7091r5",
+	},
+	.probe = ad7091r5_i2c_probe,
+	.id_table = ad7091r5_i2c_ids,
+};
+module_i2c_driver(ad7091r5_driver);
+
+MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7091R5 multi-channel ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

