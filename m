Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E22EB139346
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 15:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgAMOOu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 09:14:50 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:10672 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbgAMOOu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 09:14:50 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DEABvD022794;
        Mon, 13 Jan 2020 09:14:27 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xfbvb4cup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 09:14:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dF6gDjliHdl7Gn1W40uoteKp3nOxGYYekDzXraZJZwUuITACO38/W9dHwu4fqsHH7TPM3kFKIkE4jqWCLLGZv03S+EHk8iU3dl+GuiiCYmld4RZeZBZwO0RxuIl9TAyGa1KUoybTOUf05znZIKco01B0lAN302ibLV0nlbuEmdmhyOEt6AmX4T/0NFnlnJ82eVkOaL9Kw2Ky3Xv85Y1acUeFZaz41kag29KNAk1GQp2G4scJzF9NCN1MT7mv6/S7UQ6jU2KQcRk3gQMpNxATVqjF3fZRWRCjEMXvVMWog117vg3zhL6n8tlPY+xocQ/WBaBqJQ9QGIX5KbRveRGQLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbNd9KVhQZqjJwYg3y+P68SCZe6Kqx4Oxx6VI6U9KCU=;
 b=Z786HtPJHpYojZxpkaPQXpWJx50gl/MYZVuH0XeA+Cwn/czLYqXpNqdifCgZkE2s//LiZDYOuuEYLrf/asom9mSHKftDXJ+xKNh9dfXUagiYD+kQNfxXMtzYbxutBAFMz5iUmI9O9nF9vwBDZwbLkN6+FpJ1wUymrqcgXlJJf6kp5kh4QLOqhFP7gdDCgvOC2uemWiT9RVQrhw+768SYuDyVBOeDbABSOGeKwGd4PRbdFYuC7//H6V78eJMSnFH1d75GqR0B4FQCI54hb2gzpWdxrYCICPwUnNtRKSeKkhj72HCroT6tDLXYGHq1SP3Mw1cZ+siPgOjAzjeL4N4bbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbNd9KVhQZqjJwYg3y+P68SCZe6Kqx4Oxx6VI6U9KCU=;
 b=trZAjiUQNbO/bcLPlSmMfMICCGM31UaG4QQ580YUtX7ShRAmJ47eFRW6zMAZpYzpST8LVHMNzsWvZQI66jLU/e0jIB9OEn+kLdJO+4j8uyxFJ+ijD+GGpCGkEAhcDTVuRzqoNKQUMBxN6OE4LF+z6IzFSAvvaM6EIRRQMrlMzs4=
Received: from BN8PR03CA0004.namprd03.prod.outlook.com (2603:10b6:408:94::17)
 by CY4PR03MB2424.namprd03.prod.outlook.com (2603:10b6:903:36::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.11; Mon, 13 Jan
 2020 14:14:25 +0000
Received: from BL2NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by BN8PR03CA0004.outlook.office365.com
 (2603:10b6:408:94::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.16 via Frontend
 Transport; Mon, 13 Jan 2020 14:14:25 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT042.mail.protection.outlook.com (10.152.76.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Mon, 13 Jan 2020 14:14:24 +0000
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id 00DEENMb031481
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 13 Jan 2020 06:14:24 -0800
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 13 Jan
 2020 06:14:23 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 13 Jan 2020 09:14:22 -0500
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00DEECCU005491;
        Mon, 13 Jan 2020 09:14:12 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 1/3] iio: amplifiers: hmc425a: Add support for HMC425A step attenuator with gpio interface
Date:   Mon, 13 Jan 2020 16:15:53 +0200
Message-ID: <20200113141555.16117-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(199004)(189003)(44832011)(336012)(6666004)(356004)(7416002)(8936002)(1076003)(426003)(54906003)(6916009)(70586007)(5660300002)(70206006)(36756003)(7636002)(4326008)(316002)(2616005)(966005)(8676002)(7696005)(2906002)(107886003)(246002)(86362001)(478600001)(26005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2424;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdf0f58a-5346-4405-f851-08d79832e4ad
X-MS-TrafficTypeDiagnostic: CY4PR03MB2424:
X-Microsoft-Antispam-PRVS: <CY4PR03MB24248B3B049172FD1C0B092DF0350@CY4PR03MB2424.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 028166BF91
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WX9qfJ7jsd9bk56b1SkIExOICDaUGizEjGLG+fY3Fv1ZXEkRLxOkr7G2h+V586d2ykDPBEI7gvjTof6mZT+MSSejUH0Lfp/poLr/WwBuCRe8CrgqoVfk9Yzh2ehRpuh8QH1QCP695R2j1uGcoyi+oVJQr26QHrm4dhL3j3dS0lwka1QabbjTKdSK8Rdpy6N5lPRJqVUYpVb+eQcl8L8rXleQqkFcMjUPv4iLY9EgytVeb3OBwMqvPNoW6LnRxMQIDkA6hzGub+UopjRuXfv7XjZYivs50vN9AiPWNHSYwEPE6CTmjBpp3BSGtfuocewzki79gjO+HbMyCmyUwH0aXVTP6vtPL74yShslmuj4UxmUiGqpjqEm2IX+pyUMnvKnzJatEhK42RvVvmgVNmoD/g4bA6f7nHIuXLO6hkRX2BGfoqAcx9NYKpMcmWsZj7EXWo4SKdaI4eImK4gUcoxjnFnPUjTnZaz4IjzuxOjrUu34CrHlkpotbb+3mBl5sGNwCMkuf3eHXZWqPbJ9e22DfA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 14:14:24.8097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf0f58a-5346-4405-f851-08d79832e4ad
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2424
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_04:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001130117
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

This patch adds support for the HMC425A 0.5 dB LSB GaAs MMIC 6-BIT
DIGITAL POSITIVE CONTROL ATTENUATOR, 2.2 - 8.0 GHz.

Datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/hmc425A.pdf

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/amplifiers/Kconfig   |  10 ++
 drivers/iio/amplifiers/Makefile  |   1 +
 drivers/iio/amplifiers/hmc425a.c | 247 +++++++++++++++++++++++++++++++
 3 files changed, 258 insertions(+)
 create mode 100644 drivers/iio/amplifiers/hmc425a.c

diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
index da7f126d197b..9b02c9a2bc8a 100644
--- a/drivers/iio/amplifiers/Kconfig
+++ b/drivers/iio/amplifiers/Kconfig
@@ -22,4 +22,14 @@ config AD8366
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad8366.
 
+config HMC425
+	tristate "Analog Devices HMC425A and similar GPIO Gain Amplifiers"
+	depends on GPIOLIB
+	help
+	  Say yes here to build support for Analog Devices HMC425A and similar
+	  gain amplifiers or step attenuators.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hmc425a.
+
 endmenu
diff --git a/drivers/iio/amplifiers/Makefile b/drivers/iio/amplifiers/Makefile
index 9abef2ebe9bc..19a89db1d9b1 100644
--- a/drivers/iio/amplifiers/Makefile
+++ b/drivers/iio/amplifiers/Makefile
@@ -5,3 +5,4 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AD8366) += ad8366.o
+obj-$(CONFIG_HMC425) += hmc425a.o
\ No newline at end of file
diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
new file mode 100644
index 000000000000..525ebadaf1e8
--- /dev/null
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HMC425A and similar Gain Amplifiers
+ *
+ * Copyright 2020 Analog Devices Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
+
+enum hmc425a_type {
+	ID_HMC425A,
+};
+
+struct hmc425a_chip_info {
+	const struct iio_chan_spec	*channels;
+	unsigned int			num_channels;
+	unsigned int			num_gpios;
+	int				gain_min;
+	int				gain_max;
+	int				default_gain;
+};
+
+struct hmc425a_state {
+	struct	regulator *reg;
+	struct	mutex lock; /* protect sensor state */
+	struct	hmc425a_chip_info *chip_info;
+	struct	gpio_descs *gpios;
+	enum	hmc425a_type type;
+	u32	gain;
+};
+
+static int hmc425a_write(struct iio_dev *indio_dev, u32 value)
+{
+	struct hmc425a_state *st = iio_priv(indio_dev);
+	int i, *values;
+
+	values = kmalloc_array(st->chip_info->num_gpios, sizeof(int),
+			       GFP_KERNEL);
+	if (!values)
+		return -ENOMEM;
+
+	for (i = 0; i < st->chip_info->num_gpios; i++)
+		values[i] = (value >> i) & 1;
+
+	gpiod_set_array_value_cansleep(st->gpios->ndescs, st->gpios->desc,
+				       values);
+	kfree(values);
+	return 0;
+}
+
+static int hmc425a_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long m)
+{
+	struct hmc425a_state *st = iio_priv(indio_dev);
+	int code, gain = 0;
+	int ret;
+
+	mutex_lock(&st->lock);
+	switch (m) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		code = st->gain;
+
+		switch (st->type) {
+		case ID_HMC425A:
+			gain = ~code * -500;
+			break;
+		}
+
+		/* Values in dB */
+		*val = gain / 1000;
+		*val2 = (gain % 1000) * 1000;
+
+		ret = IIO_VAL_INT_PLUS_MICRO_DB;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&st->lock);
+
+	return ret;
+};
+
+static int hmc425a_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct hmc425a_state *st = iio_priv(indio_dev);
+	struct hmc425a_chip_info *inf = st->chip_info;
+	int code = 0, gain;
+	int ret;
+
+	/* Values in dB */
+	if (val < 0)
+		gain = (val * 1000) - (val2 / 1000);
+	else
+		gain = (val * 1000) + (val2 / 1000);
+
+	if (gain > inf->gain_max || gain < inf->gain_min)
+		return -EINVAL;
+
+	switch (st->type) {
+	case ID_HMC425A:
+		code = ~((abs(gain) / 500) & 0x3F);
+		break;
+	}
+
+	mutex_lock(&st->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		st->gain = code;
+
+		ret = hmc425a_write(indio_dev, st->gain);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static const struct iio_info hmc425a_info = {
+	.read_raw = &hmc425a_read_raw,
+	.write_raw = &hmc425a_write_raw,
+};
+
+#define HMC425A_CHAN(_channel)                                          \
+{                                                                      \
+	.type = IIO_VOLTAGE, .output = 1, .indexed = 1,                \
+	.channel = _channel,                                           \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),         \
+}
+
+static const struct iio_chan_spec hmc425a_channels[] = {
+	HMC425A_CHAN(0),
+};
+
+/* Match table for of_platform binding */
+static const struct of_device_id hmc425a_of_match[] = {
+	{ .compatible = "adi,hmc425a", .data = (void *)ID_HMC425A },
+	{},
+};
+MODULE_DEVICE_TABLE(of, hmc425a_of_match);
+
+static void hmc425a_remove(void *data)
+{
+	struct hmc425a_state *st = data;
+
+	regulator_disable(st->reg);
+}
+
+static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
+	[ID_HMC425A] = {
+		.channels = hmc425a_channels,
+		.num_channels = ARRAY_SIZE(hmc425a_channels),
+		.num_gpios = 6,
+		.gain_min = -31500,
+		.gain_max = 0,
+		.default_gain = -0x40, /* set default gain -31.5db*/
+	},
+};
+
+static int hmc425a_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *id;
+	struct iio_dev *indio_dev;
+	struct hmc425a_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	id = of_match_device(hmc425a_of_match, &pdev->dev);
+	if (!id)
+		ret = -ENODEV;
+
+	st->type = (enum hmc425a_type)id->data;
+
+	st->chip_info = &hmc425a_chip_info_tbl[st->type];
+	indio_dev->num_channels = st->chip_info->num_channels;
+	indio_dev->channels = st->chip_info->channels;
+	st->gain = st->chip_info->default_gain;
+
+	st->gpios = devm_gpiod_get_array(&pdev->dev, "ctrl", GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpios)) {
+		ret = PTR_ERR(st->gpios);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get gpios\n");
+		return ret;
+	}
+
+	if (st->gpios->ndescs != st->chip_info->num_gpios) {
+		dev_err(&pdev->dev, "%d GPIOs needed to operate\n",
+			st->chip_info->num_gpios);
+		return -ENODEV;
+	}
+
+	st->reg = devm_regulator_get(&pdev->dev, "vcc");
+	if (!IS_ERR(st->reg)) {
+		ret = regulator_enable(st->reg);
+		if (ret)
+			return ret;
+		ret = devm_add_action_or_reset(&pdev->dev, hmc425a_remove, st);
+		if (ret)
+			return ret;
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+	mutex_init(&st->lock);
+
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->name = np->name;
+	indio_dev->info = &hmc425a_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static struct platform_driver hmc425a_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = hmc425a_of_match,
+	},
+	.probe = hmc425a_probe,
+};
+module_platform_driver(hmc425a_driver);
+
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
+MODULE_DESCRIPTION(
+	"Analog Devices HMC425A and similar GPIO control Gain Amplifiers");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

