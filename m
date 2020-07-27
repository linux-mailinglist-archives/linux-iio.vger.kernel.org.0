Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17F922F48E
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 18:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgG0QQe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 12:16:34 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13200 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726268AbgG0QQe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 12:16:34 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RFxhBB030752;
        Mon, 27 Jul 2020 12:16:33 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 32gek677u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 12:16:32 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 06RGGVUU045800
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 27 Jul 2020 12:16:31 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 27 Jul
 2020 12:16:30 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 27 Jul 2020 12:16:30 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06RGGShi009603;
        Mon, 27 Jul 2020 12:16:29 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>
Subject: [PATCH v7 1/9] hwmon: pmbus: adm1266: add support
Date:   Mon, 27 Jul 2020 19:18:06 +0300
Message-ID: <20200727161814.14076-2-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727161814.14076-1-alexandru.tachici@analog.com>
References: <20200727161814.14076-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_11:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1011 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270110
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Add pmbus probing driver for the adm1266 Cascadable
Super Sequencer with Margin Control and Fault Recording.
Driver is using the pmbus_core, creating sysfs files
under hwmon for inputs: vh1->vh4 and vp1->vp13.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 Documentation/hwmon/adm1266.rst | 37 +++++++++++++++++++
 Documentation/hwmon/index.rst   |  1 +
 drivers/hwmon/pmbus/Kconfig     |  9 +++++
 drivers/hwmon/pmbus/Makefile    |  1 +
 drivers/hwmon/pmbus/adm1266.c   | 65 +++++++++++++++++++++++++++++++++
 5 files changed, 113 insertions(+)
 create mode 100644 Documentation/hwmon/adm1266.rst
 create mode 100644 drivers/hwmon/pmbus/adm1266.c

diff --git a/Documentation/hwmon/adm1266.rst b/Documentation/hwmon/adm1266.rst
new file mode 100644
index 000000000000..9257f8a48650
--- /dev/null
+++ b/Documentation/hwmon/adm1266.rst
@@ -0,0 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver adm1266
+=====================
+
+Supported chips:
+  * Analog Devices ADM1266
+    Prefix: 'adm1266'
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1266.pdf
+
+Author: Alexandru Tachici <alexandru.tachici@analog.com>
+
+
+Description
+-----------
+
+This driver supports hardware monitoring for Analog Devices ADM1266 sequencer.
+
+ADM1266 is a sequencer that features voltage readback from 17 channels via an
+integrated 12 bit SAR ADC, accessed using a PMBus interface.
+
+The driver is a client driver to the core PMBus driver. Please see
+Documentation/hwmon/pmbus for details on PMBus client drivers.
+
+
+Sysfs entries
+-------------
+
+The following attributes are supported. Limits are read-write, history reset
+attributes are write-only, all other attributes are read-only.
+
+inX_label		"voutx"
+inX_input		Measured voltage.
+inX_min			Minimum Voltage.
+inX_max			Maximum voltage.
+inX_min_alarm		Voltage low alarm.
+inX_max_alarm		Voltage high alarm.
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 55ff4b7c5349..056f7107d7b8 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -30,6 +30,7 @@ Hardware Monitoring Kernel Drivers
    adm1026
    adm1031
    adm1177
+   adm1266
    adm1275
    adm9240
    ads7828
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index a337195b1c39..da34083e1ffd 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -26,6 +26,15 @@ config SENSORS_PMBUS
 	  This driver can also be built as a module. If so, the module will
 	  be called pmbus.
 
+config SENSORS_ADM1266
+	tristate "Analog Devices ADM1266 Sequencer"
+	help
+	  If you say yes here you get hardware monitoring support for Analog
+	  Devices ADM1266 Cascadable Super Sequencer.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called adm1266.
+
 config SENSORS_ADM1275
 	tristate "Analog Devices ADM1275 and compatibles"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index c4b15db996ad..da41d22be1c9 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_PMBUS)		+= pmbus_core.o
 obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
+obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
 obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
 obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
 obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
new file mode 100644
index 000000000000..79e8d90886b8
--- /dev/null
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADM1266 - Cascadable Super Sequencer with Margin
+ * Control and Fault Recording
+ *
+ * Copyright 2020 Analog Devices Inc.
+ */
+
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include "pmbus.h"
+#include <linux/slab.h>
+
+struct adm1266_data {
+	struct pmbus_driver_info info;
+	struct i2c_client *client;
+};
+
+static int adm1266_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct adm1266_data *data;
+	int i;
+
+	data = devm_kzalloc(&client->dev, sizeof(struct adm1266_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	data->info.pages = 17;
+	data->info.format[PSC_VOLTAGE_OUT] = linear;
+	for (i = 0; i < data->info.pages; i++)
+		data->info.func[i] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
+
+	return pmbus_do_probe(client, id, &data->info);
+}
+
+static const struct of_device_id adm1266_of_match[] = {
+	{ .compatible = "adi,adm1266" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adm1266_of_match);
+
+static const struct i2c_device_id adm1266_id[] = {
+	{ "adm1266", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adm1266_id);
+
+static struct i2c_driver adm1266_driver = {
+	.driver = {
+		   .name = "adm1266",
+		   .of_match_table = adm1266_of_match,
+		  },
+	.probe = adm1266_probe,
+	.remove = pmbus_do_remove,
+	.id_table = adm1266_id,
+};
+
+module_i2c_driver(adm1266_driver);
+
+MODULE_AUTHOR("Alexandru Tachici <alexandru.tachici@analog.com>");
+MODULE_DESCRIPTION("PMBus driver for Analog Devices ADM1266");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

