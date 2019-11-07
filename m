Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E81B6F3207
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2019 16:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbfKGPIY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Nov 2019 10:08:24 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25234 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727925AbfKGPIY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Nov 2019 10:08:24 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA7F3dAH008719;
        Thu, 7 Nov 2019 10:07:47 -0500
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2057.outbound.protection.outlook.com [104.47.49.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w41vvjcxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Nov 2019 10:07:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNAZtD//KvC6KTuLntDgMGvIugruoZMeBHpBkvvthCeBAKQBnch0NkxbAlphwfce3BujoNHbzcKmMIHyVmYkrhnxkng3AtPeGJbCxdN3e/1r4m1avZoR3clmd4ZjH/yEbTH0nvKdpVsEi8M62N/XCC51p6lSAyzFaOz39yvO6OQYr1lSUhCMWSQ16H76fWyG6ay1B4kDfjxhKH221dId6/Lze/VpKiGMFj75PtzN/GMxRbsB4E9YIYPENh3yvr/XW9YdlxXMqjhHpyBZMD/mvjLqgpq52L3vBr5oAVQzPiz0mSHz5jk2sz6Ry7+vnwrWCVmndkVdEaONZJpNMHUtEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1Vx4pTy9Sa6Yp5aBc0gLVrFXvnCpzcjFmrGf5OzBLk=;
 b=QKnOM+b0DRewsGcmgXvb01zYKnnCdlWbiUou74ISBdxwPtnRQlcwnbqVWdlTe4yWbxmWA/+CNuoMdyNdM1Pume2PvoDC41JtmknAZfTqCOs3MfpUXH/CEpqMxG55DRh5Zzfhnz206Wjr/uc8guGEfGQQsslQEXUMozELzZHWSpjGFwefwmzHogOoy4vFW03TU5WczGHvT6PeIC8JPNknrpPn+gf8Ma0zpZOpjCsUGRb/GxI/Ctz+F8zMyEnvGUKEtqxD970wvdUhq/0At6cgagbPYi8CKxr6Q0xclb7JNunHUNHAVTSQpUse9iOSiAcBy2d9Ctfelfqyc3yuEIrNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=driverdev.osuosl.org
 smtp.mailfrom=analog.com; dmarc=bestguesspass action=none
 header.from=analog.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1Vx4pTy9Sa6Yp5aBc0gLVrFXvnCpzcjFmrGf5OzBLk=;
 b=mxt5OELYRASZcoip/huzYRhhyGpLrJGQi/EA4NX8fcloCEzCWHe4OFX9n9a18Fjf3Zode2okRY+9QXZq+X0BbXceGXVS8pAL2K34GWyU11roh3qKReRCv12M3KxVmtWkpWRLMJsPPVEeS9X7s8j2BVsHrMWUA5ZeEykRvaNE21U=
Received: from BN6PR03CA0074.namprd03.prod.outlook.com (2603:10b6:405:6f::12)
 by DM6PR03MB4378.namprd03.prod.outlook.com (2603:10b6:5:103::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Thu, 7 Nov
 2019 15:07:44 +0000
Received: from CY1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BN6PR03CA0074.outlook.office365.com
 (2603:10b6:405:6f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Thu, 7 Nov 2019 15:07:44 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT028.mail.protection.outlook.com (10.152.75.132) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Thu, 7 Nov 2019 15:07:43 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xA7F7gdp024198
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 7 Nov 2019 07:07:42 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 7 Nov 2019 10:07:42 -0500
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
        Paul Cercueil <paul.cercueil@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v3 1/4] iio: adc: Add support for AD7091R5 ADC
Date:   Thu, 7 Nov 2019 17:07:56 +0200
Message-ID: <20191107150759.5937-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(199004)(189003)(86362001)(966005)(50226002)(36756003)(4326008)(70206006)(8936002)(47776003)(48376002)(486006)(44832011)(2906002)(126002)(2616005)(50466002)(107886003)(476003)(246002)(106002)(1076003)(54906003)(7696005)(51416003)(186003)(26005)(426003)(14444005)(8676002)(5660300002)(70586007)(316002)(336012)(356004)(478600001)(6666004)(7636002)(2351001)(6916009)(6306002)(7416002)(305945005)(30864003)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4378;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f6a1157-d2e0-4cb2-001f-08d763943dc6
X-MS-TrafficTypeDiagnostic: DM6PR03MB4378:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM6PR03MB4378FE15B11356C636D9CFEFF0780@DM6PR03MB4378.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4NRRn/cw+EX8pqo7gK3bG7fgaSxN4FIc+cYQu2KTtauszLn16ZkZE5K3iaYGyKmpGTRLyvfEXqm0apvFoOtNSWbSxnp0c3yHXkY5bnZm+77XtRRmMH8dWYhwy80HI3Ed9XBZc3+ZabAH6EjwFV4Yri8RMfEagqTQdcxNOU8D0Y2I1KaCuPECpYeGoLkOgw9u/dLP2dwsd/hT/Uf2Ki8kLzrG4oKK5hMT/GC/XxLbQMOfYfHaAH2LXf01/sieTQy+LsAIDlNAQjplclledm5iIPcuq4wMVnnTu45XOzgsr8UGKkncy+E635gHBQlkmqhb8LJGGB6A7GIgfctoMqxuEtwAk5p3fvn6TB+jc6Zb6gPRmq4YtKtH/2ZfLWEGTRMYsMJ90DQBE4xx/TMjxjrTcGwaQYQcUNxhSgrVlBpNSBi4VVgiNvl+Rym5bipwAf89v/gV4aXsvEzevb0XkyistgVC1qviAB40m+4ZZvNsJyY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 15:07:43.6028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6a1157-d2e0-4cb2-001f-08d763943dc6
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4378
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-07_05:2019-11-07,2019-11-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911070145
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
Changes in v3:
-parameters for functions calls were aligned
-iio_device_register replaced by devm_iio_device_register
-duplication of regmap_update_bits calls removed in set_mode

 drivers/iio/adc/Kconfig        |   7 +
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/ad7091r-base.c | 261 +++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7091r-base.h |  25 ++++
 drivers/iio/adc/ad7091r5.c     | 102 +++++++++++++
 5 files changed, 396 insertions(+)
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
index 000000000000..2ebc40dfd927
--- /dev/null
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -0,0 +1,261 @@
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
+		ret = -EINVAL;
+		break;
+	}
+
+	ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
+				 AD7091R_REG_CONF_MODE_MASK, conf);
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
index 000000000000..f7b3326032e8
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

