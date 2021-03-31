Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878C5343E69
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 11:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhCVKwJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 06:52:09 -0400
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:30944
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229990AbhCVKv7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 Mar 2021 06:51:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QznckstltPN6uD7N6atjhinXpNbJImJMkkdj0nWHRIIZR/vyL/DjgckyMguJW3AdDw5nXjyni0qv4+z93vhASZ2t91SlNVGKU+4cPFJSxW8FR/yl6o3uYNHPRBWypkrFl1elCT0v7YzyqPWzDUQdAG0OXagImNuaTjcfXocNfeIfFmD9AMyY9Syt7KEs29CmK4TyyGX/6rxVS1QJwPlsOR5VmjWTQ63dVICrYC/+EXnG3Lmg20z4MvcJf19z/RecKWoYQcswntufGpzoexY+gz/CbOBNcv/YKfybajjgAk8FZgYAhKBr6I7qHb3TdKSmKdtoSty91y8+NvcwOoCaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YADO0DczhSRAQN6N8tT0lwVPhOPIYUWtyAeYhnzGtqI=;
 b=S2yEcUZtaRJLNWDjmv78DQbZjw3V0ao1AKKTjjpulmXvcEePbcqs6txAYp4c4x+79NTF+5GCD29GIhQSst8952MyC15oFseFvViDrKWRRE1RZd8nMjF6uEWiv8Nf57KW1u7Z9RoCHOQFZpse1fg2HWTwAVsI6xd/aDYiQC0agxGgF4eCnAQmHlKwsKTnl0IwCsWJb474DsYLDiUGvWdiY78dknmvLO55ya4jMnsY27zNIfxqHquK1iDe8k69KqOqf70V2bpi16rCrEHx3rjHYlQpjvCE5CSJoa28bZZB3sMiE+uiDSG3KGcFI4a1uIPLP4dwsc8wIVq99/z1VPHTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YADO0DczhSRAQN6N8tT0lwVPhOPIYUWtyAeYhnzGtqI=;
 b=dJ6TbityUmWZrobpMZBvGlQZ/+76Ukijwp3afYkdkT+IIbeuKTaItZRWwPz0XvzadT7sbgcPywQJ5R/iZnF7zT29AUoKD0VKY6UB0xCIXuVZdjy/CDlxa0M2lClLi+998WEst1Kc52SUgn4SybSbCl7z3uO5/q4J6lWkonFpHFQ=
Received: from MN2PR20CA0027.namprd20.prod.outlook.com (2603:10b6:208:e8::40)
 by BYAPR02MB5638.namprd02.prod.outlook.com (2603:10b6:a03:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Mon, 22 Mar
 2021 10:51:55 +0000
Received: from BL2NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:e8:cafe::24) by MN2PR20CA0027.outlook.office365.com
 (2603:10b6:208:e8::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 10:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT010.mail.protection.outlook.com (10.152.77.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.24 via Frontend Transport; Mon, 22 Mar 2021 10:51:54 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 22 Mar 2021 03:51:32 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Mon, 22 Mar 2021 03:51:32 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 pmeerw@pmeerw.net,
 linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.6] (port=46094 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <raviteja.narayanam@xilinx.com>)
        id 1lOI9i-0007fI-Od; Mon, 22 Mar 2021 03:51:31 -0700
From:   Raviteja Narayanam <raviteja.narayanam@xilinx.com>
To:     <robh+dt@kernel.org>, <jic23@kernel.org>
CC:     <michal.simek@xilinx.com>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Raviteja Narayanam <raviteja.narayanam@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 2/2] iio: adc: Add support for TI INA260 power monitors
Date:   Mon, 22 Mar 2021 16:20:56 +0530
Message-ID: <20210322105056.30571-3-raviteja.narayanam@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210322105056.30571-1-raviteja.narayanam@xilinx.com>
References: <20210322105056.30571-1-raviteja.narayanam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3b913d0-16be-4c31-388e-08d8ed208207
X-MS-TrafficTypeDiagnostic: BYAPR02MB5638:
X-Microsoft-Antispam-PRVS: <BYAPR02MB563816DA4A7E7B3AED18EF09CA659@BYAPR02MB5638.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ezV0la+XrsAqLJOy8POuowwspaPWDgaVxiJ/YpBRrjbVapopVq8hpBWQnhwXzDwrFjb/xxZjCHVTBK+qbWXdozXGcHTcOZ58xUM2C1OLuYg5bi58fsIY45iLmd37/B5fMNGiZ1KzBKp3Ru79+27T73OnPzInK3aIk91Tsn+zzarA6o8OXzOKZg8UQJ7I8FqpcV6kM/mfl42c0QID8vJtfoyWPMwf1ZJaeY0ssUQ7w2lcB0I4df5MiD5bUg50I2iLBo4bvh/XruN/ME+alE9xWQsqYNA4DhymiL6VcexO6RVNllmWjaWeklKmkWY1tXbtZHCYvl56d1bQouWC3ADMv+tYpJZl/a55BaZZ+t1FGJNF532tqdGKEtU8gw/BDYm0bfd1FxX4JvO+U7wH/l5tW5lRLUgAiweE44NlRh1dpgrVodvkp/NCVk6bzw7CvoyDE0c6F6WozH6vqtylAUMRl7X/7IpmRDgeiwbhZCw6d+2Eq+jZw4MTq1TjjuhaVU8oD1hlvlVtGSj6dWPOUdBvIC+UONt8xDtj6IPi56aLFsHWlIjINnsganeVvh2x2/aUVGZWdPtMJYoSEuxYL8kahR7QLMXvkh7h3eQDmSY3vj9A0hLii0Iddg7+dYMEm6iEdSSSzuO092g+KJeXOIVNWxL1ENA5niq0o8ntBZI4YyUZDtPpn55OtOPUiJVJHh21
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(46966006)(8676002)(82310400003)(7636003)(426003)(4326008)(44832011)(186003)(82740400003)(356005)(107886003)(110136005)(7696005)(30864003)(6666004)(54906003)(478600001)(2616005)(8936002)(47076005)(70586007)(83380400001)(70206006)(26005)(1076003)(5660300002)(9786002)(336012)(316002)(2906002)(36906005)(36860700001)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 10:51:54.7691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b913d0-16be-4c31-388e-08d8ed208207
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5638
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This driver supports software buffer mode and raw reads of ina260
iio channels.

In software buffer mode, a kthread will capture the active scan_elements
periodically using a delay. This can produce a stream of up to 3
channels plus a 64 bits timestamp based on the scan_elements.

Signed-off-by: Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 MAINTAINERS                  |   8 +
 drivers/iio/adc/Kconfig      |  12 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ina260-adc.c | 556 +++++++++++++++++++++++++++++++++++
 4 files changed, 577 insertions(+)
 create mode 100644 drivers/iio/adc/ina260-adc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index aa84121c5611..768a4b148035 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8760,6 +8760,14 @@ F:	Documentation/hwmon/ina2xx.rst
 F:	drivers/hwmon/ina2xx.c
 F:	include/linux/platform_data/ina2xx.h
 
+INA260 POWER MONITOR DRIVER
+M:	Raviteja Narayanam <raviteja.narayanam@xilinx.com>
+R:	Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
+R:	Michal Simek <michal.simek@xilinx.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,ina260.yaml
+F:	drivers/iio/adc/ina260-adc.c
+
 INDUSTRY PACK SUBSYSTEM (IPACK)
 M:	Samuel Iglesias Gonsalvez <siglesias@igalia.com>
 M:	Jens Taprogge <jens.taprogge@taprogge.org>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index bf7d22fa4be2..f6f8fd6bd113 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -497,6 +497,18 @@ config INA2XX_ADC
 	  Say yes here to build support for TI INA2xx family of Power Monitors.
 	  This driver is mutually exclusive with the HWMON version.
 
+config INA260_ADC
+	tristate "Texas Instruments INA260 Power Monitors IIO driver"
+	depends on I2C
+	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
+	help
+	  Say yes here to build support for TI INA260 power monitor.
+	  This driver can also be built as a module. It supports software buffer
+	  mode and raw reads of ina260 iio channels. Up to 4 channels are
+	  supported including timestamp.
+
 config INGENIC_ADC
 	tristate "Ingenic JZ47xx SoCs ADC driver"
 	depends on MIPS || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 5fca90ada0ec..a3bbcad64a41 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_HI8435) += hi8435.o
 obj-$(CONFIG_HX711) += hx711.o
 obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
 obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
+obj-$(CONFIG_INA260_ADC) += ina260-adc.o
 obj-$(CONFIG_INGENIC_ADC) += ingenic-adc.o
 obj-$(CONFIG_INTEL_MRFLD_ADC) += intel_mrfld_adc.o
 obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
diff --git a/drivers/iio/adc/ina260-adc.c b/drivers/iio/adc/ina260-adc.c
new file mode 100644
index 000000000000..7f74aa94fd31
--- /dev/null
+++ b/drivers/iio/adc/ina260-adc.c
@@ -0,0 +1,556 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * INA260 power monitor driver
+ * Based on drivers/iio/adc/ina2xx-adc.c
+ *
+ * Copyright (C) 2021 Xilinx, Inc.
+ */
+
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/sysfs.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/sched/task.h>
+#include <linux/util_macros.h>
+
+/* INA260 registers definition */
+#define INA260_CONFIG		0x00
+#define INA260_CURRENT		0x01
+#define INA260_VOLTAGE		0x02
+#define INA260_POWER		0x03
+#define INA260_MASK_ENABLE	0x06
+#define INA260_ALERT_LIMIT	0x07
+#define INA260_MANF_ID		0xFE
+#define INA260_DIE_ID		0xFF
+
+#define INA260_CONFIG_DEFAULT	0x6327
+
+#define INA260_CURRENT_LSB	1250
+#define INA260_VOLTAGE_LSB	1250
+#define INA260_POWER_LSB	10
+
+/* Bits */
+#define INA260_CVRF		BIT(3)
+
+#define INA260_MODE_MASK	GENMASK(2, 0)
+#define INA260_VOLT_MASK	GENMASK(8, 6)
+#define INA260_SHIFT_VOLT(val)	((val) << 6)
+#define INA260_CURR_MASK	GENMASK(5, 3)
+#define INA260_SHIFT_CURR(val)	((val) << 3)
+#define INA260_AVG_MASK		GENMASK(11, 9)
+#define INA260_SHIFT_AVG(val)	((val) << 9)
+
+#define SAMPLING_PERIOD(x) ({		\
+	typeof(x) _x = (x);		\
+	(_x->config->volt_conv_time	\
+	+ _x->config->curr_conv_time)	\
+	* _x->config->avgs; })
+
+static bool ina260_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	return (reg == INA260_CONFIG) || (reg == INA260_MASK_ENABLE) ||
+		(reg == INA260_ALERT_LIMIT);
+}
+
+static bool ina260_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	return (reg != INA260_CONFIG);
+}
+
+static inline bool is_signed_reg(unsigned int reg)
+{
+	return (reg == INA260_CURRENT);
+}
+
+static const struct regmap_config ina260_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = 8,
+	.writeable_reg = ina260_is_writeable_reg,
+	.volatile_reg = ina260_is_volatile_reg,
+};
+
+enum ina260_ids {ina260 = 0};
+
+/**
+ * struct ina260_config - For configurable parameters
+ * @config_default: Default configuration
+ * @volt_conv_time: Bus voltage conversion time
+ * @curr_conv_time: Shunt current conversion time
+ * @avgs: Number of samples collected and averaged
+ */
+struct ina260_config {
+	u16 config_default;
+	int volt_conv_time;
+	int curr_conv_time;
+	int avgs;
+};
+
+/**
+ * struct ina260_chip - For device specific data
+ * @regmap: Regmap pointer to device registers
+ * @task: Pointer to task created by buffer mode
+ * @lock: Mutex to enable use of multiple user apps
+ * @chip_id: Id to determine chip
+ * @config: Pointer to config structure
+ */
+struct ina260_chip {
+	struct regmap *regmap;
+	struct task_struct *task;
+	struct mutex lock; /* Lock for device writes */
+	enum ina260_ids chip_id;
+	struct ina260_config *config;
+};
+
+static struct ina260_config ina260_config[] = {
+	[ina260] = {
+		.config_default = INA260_CONFIG_DEFAULT,
+		.volt_conv_time = 1100,
+		.curr_conv_time = 1100,
+		.avgs = 4,
+	},
+};
+
+static int ina260_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct ina260_chip *chip = iio_priv(indio_dev);
+	unsigned int regval;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (iio_buffer_enabled(indio_dev))
+			return -EBUSY;
+
+		ret = regmap_read(chip->regmap, chan->address, &regval);
+		if (ret)
+			return ret;
+
+		if (is_signed_reg(chan->address))
+			*val = (s16)regval;
+		else
+			*val = regval;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->address) {
+		case INA260_CURRENT:
+			*val = INA260_CURRENT_LSB;
+			*val2 = 1000;
+			return IIO_VAL_FRACTIONAL;
+
+		case INA260_VOLTAGE:
+			*val = INA260_VOLTAGE_LSB;
+			*val2 = 1000;
+			return IIO_VAL_FRACTIONAL;
+
+		case INA260_POWER:
+			*val = INA260_POWER_LSB;
+			return IIO_VAL_INT;
+		}
+		return -EINVAL;
+
+	case IIO_CHAN_INFO_INT_TIME:
+		*val = 0;
+		if (chan->address == INA260_VOLTAGE)
+			*val2 = chip->config->volt_conv_time;
+		else
+			*val2 = chip->config->curr_conv_time;
+
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = DIV_ROUND_CLOSEST(1000000, SAMPLING_PERIOD(chip));
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = chip->config->avgs;
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static const int ina260_avg_tab[] = { 1, 4, 16, 64, 128, 256, 512, 1024 };
+
+/* Conversion times in uS */
+static const int ina260_conv_time_tab[] = { 140, 204, 332, 588, 1100, 2116, 4156, 8244 };
+
+static int ina260_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct ina260_chip *chip = iio_priv(indio_dev);
+	unsigned int config;
+	int ret, bits;
+
+	if (iio_buffer_enabled(indio_dev))
+		return -EBUSY;
+
+	mutex_lock(&chip->lock);
+
+	ret = regmap_read(chip->regmap, INA260_CONFIG, &config);
+	if (ret)
+		goto err;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		if (val2 > 8244 || val2 < 140) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		bits = find_closest(val2, ina260_conv_time_tab,
+				    ARRAY_SIZE(ina260_conv_time_tab));
+
+		if (chan->address == INA260_VOLTAGE) {
+			chip->config->volt_conv_time = ina260_conv_time_tab[bits];
+			config &= ~INA260_VOLT_MASK;
+			config |= INA260_SHIFT_VOLT(bits) & INA260_VOLT_MASK;
+		} else {
+			chip->config->curr_conv_time = ina260_conv_time_tab[bits];
+			config &= ~INA260_CURR_MASK;
+			config |= INA260_SHIFT_CURR(bits) & INA260_CURR_MASK;
+		}
+		break;
+
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		bits = find_closest(val, ina260_avg_tab, ARRAY_SIZE(ina260_avg_tab));
+		chip->config->avgs = ina260_avg_tab[bits];
+		config &= ~INA260_AVG_MASK;
+		config |= INA260_SHIFT_AVG(bits) & INA260_AVG_MASK;
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+	if (!ret)
+		ret = regmap_write(chip->regmap, INA260_CONFIG, config);
+err:
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static int ina260_debug_reg(struct iio_dev *indio_dev,
+			    unsigned int reg, unsigned int writeval, unsigned int *readval)
+{
+	struct ina260_chip *chip = iio_priv(indio_dev);
+
+	if (!readval)
+		return regmap_write(chip->regmap, reg, writeval);
+
+	return regmap_read(chip->regmap, reg, readval);
+}
+
+#define INA260_CHAN_VOLTAGE(_index, _address) { \
+	.type = IIO_VOLTAGE, \
+	.address = (_address), \
+	.indexed = 1, \
+	.channel = (_index), \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+	BIT(IIO_CHAN_INFO_SCALE) | \
+	BIT(IIO_CHAN_INFO_INT_TIME), \
+	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+	BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+	.scan_index = (_index), \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = 16, \
+		.storagebits = 16, \
+		.endianness = IIO_CPU, \
+	} \
+}
+
+#define INA260_CHAN_CURRENT(_index, _address) { \
+	.type = IIO_CURRENT, \
+	.address = (_address), \
+	.indexed = 1, \
+	.channel = (_index), \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+	BIT(IIO_CHAN_INFO_SCALE) | \
+	BIT(IIO_CHAN_INFO_INT_TIME), \
+	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+	BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+	.scan_index = (_index), \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = 16, \
+		.storagebits = 16, \
+		.endianness = IIO_CPU, \
+	} \
+}
+
+#define INA260_CHAN_POWER(_index, _address) { \
+	.type = IIO_POWER, \
+	.address = (_address), \
+	.indexed = 1, \
+	.channel = (_index), \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+	BIT(IIO_CHAN_INFO_SCALE), \
+	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+	BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+	.scan_index = (_index), \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = 16, \
+		.storagebits = 16, \
+		.endianness = IIO_CPU, \
+	} \
+}
+
+static const struct iio_chan_spec ina260_channels[] = {
+	INA260_CHAN_CURRENT(0, INA260_CURRENT),
+	INA260_CHAN_VOLTAGE(1, INA260_VOLTAGE),
+	INA260_CHAN_POWER(2, INA260_POWER),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+/* Possible integration times for current and voltage */
+static IIO_CONST_ATTR_NAMED(ina260_integration_time_available,
+			    integration_time_available,
+			    "0.000140 0.000204 0.000332 0.000588 0.001100 0.002116 0.004156 0.008244");
+
+static struct attribute *ina260_attributes[] = {
+	&iio_const_attr_ina260_integration_time_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ina260_attribute_group = {
+	.attrs = ina260_attributes,
+};
+
+static const struct iio_info ina260_info = {
+	.attrs = &ina260_attribute_group,
+	.read_raw = ina260_read_raw,
+	.write_raw = ina260_write_raw,
+	.debugfs_reg_access = ina260_debug_reg,
+};
+
+static int ina260_conversion_ready(struct iio_dev *indio_dev)
+{
+	struct ina260_chip *chip = iio_priv(indio_dev);
+	unsigned int alert;
+	int ret;
+
+	ret = regmap_read(chip->regmap, INA260_MASK_ENABLE, &alert);
+	if (ret < 0)
+		return ret;
+
+	return (alert & INA260_CVRF);
+}
+
+static int ina260_work_buffer(struct iio_dev *indio_dev)
+{
+	/* data buffer needs space for channel data and timestap */
+	unsigned short data[3 + sizeof(s64) / sizeof(short)];
+	struct ina260_chip *chip = iio_priv(indio_dev);
+	int bit, ret, i = 0;
+	s64 time;
+
+	time = iio_get_time_ns(indio_dev);
+
+	/*
+	 * Read current, voltage and power from device
+	 */
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+		unsigned int val;
+
+		ret = regmap_read(chip->regmap, INA260_CURRENT + bit, &val);
+		if (ret < 0)
+			return ret;
+
+		data[i++] = val;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, data, time);
+
+	return 0;
+}
+
+static int ina260_capture_thread(void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct ina260_chip *chip = iio_priv(indio_dev);
+	int sampling_us = SAMPLING_PERIOD(chip);
+	struct timespec64 next, now, delta;
+	s64 delay_us;
+	int ret;
+
+	ktime_get_ts64(&next);
+
+	do {
+		while (1) {
+			/* Check if conversion is ready */
+			ret = ina260_conversion_ready(indio_dev);
+			if (ret < 0)
+				return ret;
+
+			/*
+			 * If the conversion was not yet finished,
+			 * reset the reference timestamp.
+			 */
+			if (ret == 0)
+				ktime_get_ts64(&next);
+			else
+				break;
+		}
+		/* Read the data from sensor and push it to buffers */
+		ret = ina260_work_buffer(indio_dev);
+		if (ret < 0)
+			return ret;
+
+		ktime_get_ts64(&now);
+		/*
+		 * Advance the timestamp for the next poll by one sampling
+		 * interval, and sleep for the remainder (next - now)
+		 * In case "next" has already passed, the interval is added
+		 * multiple times, i.e. samples are dropped.
+		 */
+		do {
+			timespec64_add_ns(&next, 1000 * sampling_us);
+			delta = timespec64_sub(next, now);
+			delay_us = div_s64(timespec64_to_ns(&delta), 1000);
+		} while (delay_us <= 0);
+
+		usleep_range(delay_us, (delay_us * 3) >> 1);
+
+	} while (!kthread_should_stop());
+
+	return 0;
+}
+
+static int ina260_buffer_enable(struct iio_dev *indio_dev)
+{
+	struct ina260_chip *chip = iio_priv(indio_dev);
+	unsigned int sampling_us = SAMPLING_PERIOD(chip);
+	struct task_struct *task;
+
+	task = kthread_create(ina260_capture_thread, (void *)indio_dev,
+			      "%s:%d-%uus", indio_dev->name, indio_dev->id,
+			      sampling_us);
+
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+
+	get_task_struct(task);
+	wake_up_process(task);
+	chip->task = task;
+
+	return 0;
+}
+
+static int ina260_buffer_disable(struct iio_dev *indio_dev)
+{
+	struct ina260_chip *chip = iio_priv(indio_dev);
+
+	if (chip->task) {
+		kthread_stop(chip->task);
+		put_task_struct(chip->task);
+		chip->task = NULL;
+	}
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ina260_setup_ops = {
+	.postenable = &ina260_buffer_enable,
+	.predisable = &ina260_buffer_disable,
+};
+
+static int ina260_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct iio_buffer *buffer;
+	struct ina260_chip *chip;
+	enum ina260_ids type = 0;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	chip = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+
+	chip->regmap = devm_regmap_init_i2c(client, &ina260_regmap_config);
+	if (IS_ERR(chip->regmap)) {
+		dev_err(&client->dev, "failed to allocate register map\n");
+		return PTR_ERR(chip->regmap);
+	}
+
+	mutex_init(&chip->lock);
+
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->dev.of_node = client->dev.of_node;
+
+	chip->config = &ina260_config[type];
+	ret = regmap_write(chip->regmap, INA260_CONFIG,
+			   chip->config->config_default);
+	if (ret) {
+		dev_err(&client->dev, "Error configuring the device\n");
+		return ret;
+	}
+	indio_dev->channels = ina260_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ina260_channels);
+	indio_dev->info = &ina260_info;
+	indio_dev->name = id->name;
+	indio_dev->setup_ops = &ina260_setup_ops;
+
+	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
+	if (!buffer)
+		return -ENOMEM;
+
+	iio_device_attach_buffer(indio_dev, buffer);
+
+	return iio_device_register(indio_dev);
+}
+
+static int ina260_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ina260_chip *chip = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	/* Power down */
+	return regmap_update_bits(chip->regmap, INA260_CONFIG, INA260_MODE_MASK, 0);
+}
+
+static const struct i2c_device_id ina260_id[] = {
+	{"ina260", ina260},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ina260_id);
+
+static const struct of_device_id ina260_of_match[] = {
+	{
+		.compatible = "ti,ina260",
+		.data = (void *)ina260
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ina260_of_match);
+
+static struct i2c_driver ina260_driver = {
+	.driver = {
+		.name = "ina260-adc",
+		.of_match_table = ina260_of_match,
+	},
+	.probe = ina260_probe,
+	.remove = ina260_remove,
+	.id_table = ina260_id,
+};
+module_i2c_driver(ina260_driver);
+
+MODULE_AUTHOR("Raviteja Narayanam <raviteja.narayanam@xilinx.com>");
+MODULE_DESCRIPTION("Texas Instruments INA 260 ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

