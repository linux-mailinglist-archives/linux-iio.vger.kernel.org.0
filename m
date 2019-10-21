Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 087F2DEED0
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 16:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfJUOIl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 10:08:41 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25530 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728083AbfJUOIk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 10:08:40 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9LE31Ye013898;
        Mon, 21 Oct 2019 10:06:08 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2057.outbound.protection.outlook.com [104.47.46.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vqyd6ubtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 10:06:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cx+2A3RLw6x4eSoDhPjFdyWVZfiKmXAY3l9CvSc5EJW7QOKs3VMImtEqzKxBaktGH3muBT3Ph9agY57wfAx8tjQjNbgqoYZ4WP20P2bElWaLdNnpJMMFUk/4K9NBvCwZTD6zbz8IE+FlBZnWu/tXk5mJ/wJvSJcvb6f/0udlo8wlL2ZnFz/ie8F4JxZBKEHpfRZ8z5MgqIUR7heeGt2H8YRumrVTRIbnLauwQn6ppBO7DIJwrdDF5Fz0/7GUH7jWFn6XfL+Hm9vmXr2tbbdtw7nBOJCwKbHuQJLxMTU3GFlAiUi5tsUUiDacVn5Sn0BQf003dmvfABqvWfm3awosFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LkLHYF9+AcgnZnsjMroP//oyqGRGXaZQlmEMitedqw=;
 b=ASMFu83zAtyY+KSLc7Hg08M6x3UNebHTH4cYcamVac7XCFymcGomqvIS6+61InpdXxLmplPLlb39t2b3OI6zAxct1Si5Dd63qXA2Y4MrzgMZF+aVXe4RKHJ4PhODWU04oBFwzp1G4uyJShifTTeN6m7a5LakOuRSIhtKqHTq1JLL4u4+nvcme3r+YFnd1ohayYJZ+M86xHTVOds2fwIz+FIQLwkbFs2lLWpTos/cGRmOgle6K7UMGswvGNb8jbVVkFCZPVKtKjiQKGOTGlTJOi7S1iU3ndWZZFhOVPYfZRzFVv0XAX74lgopIzOMtH05biHB+SRwF+cheta+64LGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LkLHYF9+AcgnZnsjMroP//oyqGRGXaZQlmEMitedqw=;
 b=UuSNOG+ngwDM0dm/E635eAYi7BLmbfNLslBlZTMgIcrKuhpMYV2KnamsGa5He+eSzVvCTLiVL59tcVlkY5Jg7DTvEub0DWH/VqIo9fhBez+/npV2KrSCR97o1tTqFghjJGyWPhkRTtajyMelBnT9vad5EetPZ/mrfbdBXMY0Cn0=
Received: from CY1PR03CA0014.namprd03.prod.outlook.com (2603:10b6:600::24) by
 MWHPR03MB2591.namprd03.prod.outlook.com (2603:10b6:300:47::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Mon, 21 Oct 2019 14:06:05 +0000
Received: from SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by CY1PR03CA0014.outlook.office365.com
 (2603:10b6:600::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.21 via Frontend
 Transport; Mon, 21 Oct 2019 14:06:05 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT006.mail.protection.outlook.com (10.152.72.68) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Mon, 21 Oct 2019 14:06:04 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x9LE5ug8013193
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 21 Oct 2019 07:05:56 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 21 Oct 2019 10:06:03 -0400
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
Subject: [PATCH 1/4] iio: adc: Add support for AD7091R5 ADC
Date:   Mon, 21 Oct 2019 20:06:05 +0300
Message-ID: <20191021170608.26412-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(246002)(966005)(86362001)(1076003)(356004)(50466002)(478600001)(6916009)(8936002)(8676002)(50226002)(70206006)(426003)(70586007)(44832011)(486006)(126002)(476003)(186003)(2351001)(5660300002)(14444005)(30864003)(2616005)(26005)(336012)(47776003)(51416003)(7696005)(7636002)(7416002)(305945005)(107886003)(4326008)(36756003)(6306002)(2906002)(106002)(48376002)(16586007)(54906003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2591;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83b4ae52-9ffc-432f-44f4-08d7562fd016
X-MS-TrafficTypeDiagnostic: MWHPR03MB2591:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <MWHPR03MB25912B285F67455F16228D94F0690@MWHPR03MB2591.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0197AFBD92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UoO9Mzy0EFGyUK6/Qa/cxd5G9UjT5r4dtwkpB5G5JmKVQv0FsdgTWs6x1qTUOjiezlDZrUHh4gM0qFOosPauBvRQIg6X1yd7TvAP7XKLdSVvzgJkxy5h8Z2egvJJZwSSVmNM9zO7jJNiG9OtAwzCcscYIcXnSreykIrLrxBSjdkQY8G77shluya9ZhF03HYbk0GSMFe9RqiSlE6O+AZltFBWFsxGdlLCDEkdDYfifHcokj6IYEux8PIj7FyLA1D5DnTPUxu0Q+wC6WxyV59dI+11OQ+LVuBYjXRQqjPCbDklZTl0CtYaHTeWMnaURJJMcxexm2rY2MoLxATDA2XjhASagCoLdirHT7qvZJrCBljkfqqXfuciUzn7dgalOuctT42Gv0rHUEtGGvSHMchThJyYqlxQw5zqKaT15Upk++CzeIbJDFDgufOpy+JAxKCDoVQx5SDlT+WjUxC4JnkYm615gwnW/7SqluXjUtOz9Zo=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 14:06:04.8784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b4ae52-9ffc-432f-44f4-08d7562fd016
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2591
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-21_04:2019-10-21,2019-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910210133
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
 drivers/iio/adc/Kconfig        |   7 +
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/ad7091r-base.c | 273 +++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7091r-base.h |  30 ++++
 drivers/iio/adc/ad7091r5.c     | 108 +++++++++++++
 5 files changed, 419 insertions(+)
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
index 000000000000..140413329754
--- /dev/null
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AD7091RX Analog to Digital converter driver
+ *
+ * Copyright 2014 Analog Devices Inc.
+ *
+ */
+
+#include "ad7091r-base.h"
+
+#include <linux/bitops.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
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
+#define REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)
+#define REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
+
+/* AD7091R_REG_CONF */
+#define REG_CONF_AUTO   BIT(8)
+#define REG_CONF_CMD    BIT(10)
+
+#define REG_CONF_MODE_MASK  (REG_CONF_AUTO | REG_CONF_CMD)
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
+};
+
+static int ad7091r_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
+{
+	int ret;
+
+	switch (mode) {
+	case AD7091R_MODE_SAMPLE:
+		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
+				REG_CONF_MODE_MASK, 0);
+		break;
+	case AD7091R_MODE_COMMAND:
+		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
+				REG_CONF_MODE_MASK, REG_CONF_CMD);
+		break;
+	case AD7091R_MODE_AUTOCYCLE:
+		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
+				REG_CONF_MODE_MASK, REG_CONF_AUTO);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (!ret)
+		st->mode = mode;
+	return ret;
+}
+
+static int ad7091r_set_channel(struct ad7091r_state *st, unsigned int channel)
+{
+	unsigned int foo;
+	int ret;
+
+	/* AD7091R_REG_CHANNEL is a 8-bit register */
+	ret = regmap_write(st->map, AD7091R_REG_CHANNEL,
+			BIT(channel) | (BIT(channel) << 8));
+	if (ret)
+		return ret;
+
+	/*
+	 *  There is a latency of one conversion before the channel conversion
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
+	/* TODO: locking */
+	ret = ad7091r_set_channel(st, channel);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->map, AD7091R_REG_RESULT, &val);
+	if (ret)
+		return ret;
+
+	if (REG_RESULT_CH_ID(val) != channel)
+		return -EIO;
+
+	*read_val = REG_RESULT_CONV_RESULT(val);
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
+	mutex_lock(&iio_dev->mlock);
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
+	mutex_unlock(&iio_dev->mlock);
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
+		return IRQ_HANDLED; /* TODO */
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
+	dev_set_drvdata(dev, iio_dev);
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
+	/* Use command mode by default */
+	ret = ad7091r_set_mode(st, AD7091R_MODE_COMMAND);
+	if (ret < 0)
+		return ret;
+
+	ret = iio_device_register(iio_dev);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev, "Probed\n");
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ad7091r_probe);
+
+int ad7091r_remove(struct device *dev)
+{
+	struct iio_dev *iio_dev = dev_get_drvdata(dev);
+
+	iio_device_unregister(iio_dev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ad7091r_remove);
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
+//MODULE_AUTHOR("Paul Cercueil <paul.cercueil@analog.com>");
+//MODULE_DESCRIPTION("Analog Devices AD7091Rx multi-channel converters");
+//MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
new file mode 100644
index 000000000000..7a29f86ea82b
--- /dev/null
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AD7091RX Analog to Digital converter driver
+ *
+ * Copyright 2014 Analog Devices Inc.
+ *
+ */
+
+#ifndef __DRIVERS_IIO_DAC_AD7091R_BASE_H__
+#define __DRIVERS_IIO_DAC_AD7091R_BASE_H__
+
+#include <linux/types.h>
+#include <linux/regmap.h>
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
+int ad7091r_remove(struct device *dev);
+
+#endif /* __DRIVERS_IIO_DAC_AD7091R5_BASE_H__ */
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
new file mode 100644
index 000000000000..1ba838c58c31
--- /dev/null
+++ b/drivers/iio/adc/ad7091r5.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AD7091R5 Analog to Digital converter driver
+ *
+ * Copyright 2014 Analog Devices Inc.
+ *
+ */
+
+#include "ad7091r-base.h"
+
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
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
+static int ad7091r5_i2c_remove(struct i2c_client *i2c)
+{
+	return ad7091r_remove(&i2c->dev);
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
+	.remove = ad7091r5_i2c_remove,
+	.id_table = ad7091r5_i2c_ids,
+};
+module_i2c_driver(ad7091r5_driver);
+
+MODULE_AUTHOR("Beniamin Bia <beniamin.bia@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7091R5 multi-channel ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

