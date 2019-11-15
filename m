Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6180DFDF7B
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 14:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfKON52 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 08:57:28 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:41652 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727508AbfKON51 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 08:57:27 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFDm0xN000401;
        Fri, 15 Nov 2019 08:56:55 -0500
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2056.outbound.protection.outlook.com [104.47.49.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w7prk1k8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 08:56:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcNq8Gci/U9rrD+EFV9G0d39D9FAjhrCzeDuna61QSUI1zZqqmuRQtvgcbSz6KP1rZ+XJX7kPeJ+oz68fU7r/3Tkf9tNlmn2vlPbCi3LUOOanMJO1KoWWxe3AKxItHWc3vCagBORAxGdfeTHuM2fUU8Fg4UYe9vil1bkR16If6duXAUL5FGGmQIHrPd+uWIVs/y6DDg5rPifE+yComYzrFTI9LpCGhIh8NeRevUpsulk6HovcpYU122wreDma2Jsek66jM5u8W83eg7xMHv7VRTr450Js0SwynB03cQjB83u7LZR8U7kSq/iitHkinXm16o4gKWz5zAAigN9l4FGrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iokQfkBUrZdmlsXIZOPlgHsjlMAWrQBYkL7CoRBeVI0=;
 b=kcFkpmViDv2dkgosHmGrhthc+53xD09yhvuZW+X2SgQwtU+bCWKSTIcGkVikqCoIIefyMvGh8jjFHWh8L7Pi50IWOgxTLchoYwxROIslSyxW4faaJdhyk3RqWB4aAl2t9Ph0RniWXYPN5r/Y3HVeQDto9ZwTyr4IzZX/8kCikXkSxY1Zybby/4dQNlwcTOx+pUWcnE4jhNxMGy6stYmGFbTo5GMC57uJAxBksyLXB/nfCVXcXk7F4lhJ9Tsy6XS1xsER1f3oOgswYm8k5TAewyweDH/ShLR8IhnosD7wU5ysIX/iJ50fox9I2mr4EADCDfn7E3LaBor3FAhtzCaw6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iokQfkBUrZdmlsXIZOPlgHsjlMAWrQBYkL7CoRBeVI0=;
 b=You3WFPFZGKWq8/49zBoPbTuLMw1pt7f95MOYrxqzqSBd/S/WeVNI+edJ4TsogD0AQ8ma1E6oX29Lc8T/tL8zVWAZ1LylhBQ/axfxA+2nevWUl9btXwAAXV7UcvOZ6VGBO0SrSIXiEiWZDBcYZh2jeMp01jGMJaJ8x7SIfatlQ4=
Received: from BN6PR03CA0089.namprd03.prod.outlook.com (2603:10b6:405:6f::27)
 by MWHPR03MB2495.namprd03.prod.outlook.com (2603:10b6:300:8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.27; Fri, 15 Nov
 2019 13:56:52 +0000
Received: from SN1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BN6PR03CA0089.outlook.office365.com
 (2603:10b6:405:6f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.27 via Frontend
 Transport; Fri, 15 Nov 2019 13:56:51 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT018.mail.protection.outlook.com (10.152.72.122) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2451.23
 via Frontend Transport; Fri, 15 Nov 2019 13:56:51 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAFDugEr003023
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 15 Nov 2019 05:56:42 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 15 Nov 2019 08:56:49 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>,
        Paul Cercueil <paul.cercueil@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v5 1/4] iio: adc: Add support for AD7091R5 ADC
Date:   Fri, 15 Nov 2019 15:57:20 +0200
Message-ID: <20191115135723.12219-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(6666004)(356004)(2906002)(36756003)(486006)(7636002)(70586007)(70206006)(305945005)(47776003)(5660300002)(54906003)(2616005)(30864003)(2351001)(7696005)(4326008)(476003)(16586007)(126002)(186003)(7416002)(44832011)(106002)(316002)(6916009)(26005)(51416003)(6306002)(8676002)(966005)(246002)(86362001)(50226002)(426003)(8936002)(336012)(50466002)(478600001)(14444005)(48376002)(107886003)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2495;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46fd23c0-39b0-4526-4076-08d769d3aa8a
X-MS-TrafficTypeDiagnostic: MWHPR03MB2495:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <MWHPR03MB24953377248C368A7D58A020F0700@MWHPR03MB2495.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02229A4115
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rr8/+Hi0/kR5J8RGvUX1wU2L2ZNsrMyxVZUSHzedcg/5DigzHl+4KM8qGp7M5PvU/Vfc+RmalOr4TQcjF5mR9TX7YeQwqz9VmU8bpb8Ensqoa0tK9LMEYigeJ8r7+K1v5WTE9qYqIUNz/YSU3OY9BeF3Z4kxho9uYP7VJ4CeF81DC+G1zQ9bgrU+pkT1UFsDO/JNv+5kieHWDKDKDJ+IIR5sNaeqhKImGfuho4FnLeJuc1IC0ANUBvAkc8kZi2jh9hZr5yJ6TKxT3G0p365oluq6vt42H1k3eTDPnAWQbAf84MfPNGN67nFssJvsCfGwNHAKWKcazABf5pvBO2pa7WhKPtS3PEADJxtCzrNaBDgFjjFAyI7LItyoT19bUPwNgWz99807muwaH0UEwtyXff/LSsED7IurlXTu8p/5ekr5dGYL7ULXE7tkLs5cWQpAjSqPV6Po9YfmTA9SjK3Uonm5l08+BcZ5/8/4Zy0CsfY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 13:56:51.5176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fd23c0-39b0-4526-4076-08d769d3aa8a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2495
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_04:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150126
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Paul Cercueil <paul.cercueil@analog.com>

AD7091R5 is 4-Channel, I2C, Ultra Low Power,12-Bit ADC.

This driver will also support AD7091R2/4/8 in the future.

Datasheet:
Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ad7091r-5.pdf

Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
Co-developed-by: Beniamin Bia <beniamin.bia@analog.com>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v5:
-nothing changed

 drivers/iio/adc/Kconfig        |   7 +
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/ad7091r-base.c | 260 +++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7091r-base.h |  25 ++++
 drivers/iio/adc/ad7091r5.c     | 108 ++++++++++++++
 5 files changed, 401 insertions(+)
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
index 000000000000..854de7c654c2
--- /dev/null
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -0,0 +1,260 @@
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
+	struct mutex lock; /*lock to prevent concurent reads */
+};
+
+static int ad7091r_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
+{
+	int ret, conf;
+
+	switch (mode) {
+	case AD7091R_MODE_SAMPLE:
+		conf = 0;
+		break;
+	case AD7091R_MODE_COMMAND:
+		conf = AD7091R_REG_CONF_CMD;
+		break;
+	case AD7091R_MODE_AUTOCYCLE:
+		conf = AD7091R_REG_CONF_AUTO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
+				 AD7091R_REG_CONF_MODE_MASK, conf);
+	if (ret)
+		return ret;
+
+	st->mode = mode;
+
+	return 0;
+}
+
+static int ad7091r_set_channel(struct ad7091r_state *st, unsigned int channel)
+{
+	unsigned int dummy;
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
+	return regmap_read(st->map, AD7091R_REG_RESULT, &dummy);
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
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, iio_dev);
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
index 000000000000..b0b4fe01a681
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
+#endif /* __DRIVERS_IIO_ADC_AD7091R_BASE_H__ */
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
new file mode 100644
index 000000000000..30ff0108a6ed
--- /dev/null
+++ b/drivers/iio/adc/ad7091r5.c
@@ -0,0 +1,108 @@
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
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
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
+static const struct of_device_id ad7091r5_dt_ids[] = {
+	{ .compatible = "adi,ad7091r5" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ad7091r5_dt_ids);
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
+		.of_match_table = ad7091r5_dt_ids,
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

