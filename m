Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581B81ECBCA
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jun 2020 10:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgFCIrT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jun 2020 04:47:19 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:57203 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbgFCIrP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jun 2020 04:47:15 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.143.22])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id 0C3625521DEA;
        Wed,  3 Jun 2020 10:47:11 +0200 (CEST)
Received: from localhost.localdomain (34.103.240.102) by DAG2EX1.emp2.local
 (172.16.2.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 3 Jun 2020
 10:47:10 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <jic23@kernel.org>,
        <andy.shevchenko@gmail.com>, <pmeerw@pmeerw.net>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH v4 2/4] iio: chemical: scd30: add I2C interface driver
Date:   Wed, 3 Jun 2020 10:44:39 +0200
Message-ID: <20200603084441.33952-3-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200603084441.33952-1-tomasz.duszynski@octakon.com>
References: <20200603084441.33952-1-tomasz.duszynski@octakon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [34.103.240.102]
X-ClientProxiedBy: DAG3EX1.emp2.local (172.16.2.21) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 7173952732648397847
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudefledgtdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomhepvfhomhgrshiiucffuhhsiiihnhhskhhiuceothhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevjedvkeeuieehveeggeduuddvhfduhffhhedufeejudehkeeuhffgheduffduudenucfkpheptddrtddrtddrtddpfeegrddutdefrddvgedtrddutddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtohepphhmvggvrhifsehpmhgvvghrfidrnhgvth
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add I2C interface driver for the SCD30 sensor.

Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
---
 MAINTAINERS                      |   1 +
 drivers/iio/chemical/Kconfig     |  11 +++
 drivers/iio/chemical/Makefile    |   1 +
 drivers/iio/chemical/scd30_i2c.c | 139 +++++++++++++++++++++++++++++++
 4 files changed, 152 insertions(+)
 create mode 100644 drivers/iio/chemical/scd30_i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 41a509cca6f1..13aed3473b7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15142,6 +15142,7 @@ M:	Tomasz Duszynski <tomasz.duszynski@octakon.com>
 S:	Maintained
 F:	drivers/iio/chemical/scd30.h
 F:	drivers/iio/chemical/scd30_core.c
+F:	drivers/iio/chemical/scd30_i2c.c
 
 SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 99e852b67e55..970d34888c2e 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -96,6 +96,17 @@ config SCD30_CORE
 	  To compile this driver as a module, choose M here: the module will
 	  be called scd30_core.
 
+config SCD30_I2C
+	tristate "SCD30 carbon dioxide sensor I2C driver"
+	depends on SCD30_CORE && I2C
+	select CRC8
+	help
+	  Say Y here to build support for the Sensirion SCD30 I2C interface
+	  driver.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called scd30_i2c.
+
 config SENSIRION_SGP30
 	tristate "Sensirion SGPxx gas sensors"
 	depends on I2C
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index c9804b041ecd..0966ca34e34b 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_CCS811)		+= ccs811.o
 obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
 obj-$(CONFIG_PMS7003) += pms7003.o
 obj-$(CONFIG_SCD30_CORE) += scd30_core.o
+obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
 obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
 obj-$(CONFIG_SPS30) += sps30.o
 obj-$(CONFIG_VZ89X)		+= vz89x.o
diff --git a/drivers/iio/chemical/scd30_i2c.c b/drivers/iio/chemical/scd30_i2c.c
new file mode 100644
index 000000000000..875892a070ee
--- /dev/null
+++ b/drivers/iio/chemical/scd30_i2c.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sensirion SCD30 carbon dioxide sensor i2c driver
+ *
+ * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
+ *
+ * I2C slave address: 0x61
+ */
+#include <linux/crc8.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <asm/unaligned.h>
+
+#include "scd30.h"
+
+#define SCD30_I2C_MAX_BUF_SIZE 18
+#define SCD30_I2C_CRC8_POLYNOMIAL 0x31
+
+static u16 scd30_i2c_cmd_lookup_tbl[] = {
+	[CMD_START_MEAS] = 0x0010,
+	[CMD_STOP_MEAS] = 0x0104,
+	[CMD_MEAS_INTERVAL] = 0x4600,
+	[CMD_MEAS_READY] = 0x0202,
+	[CMD_READ_MEAS] = 0x0300,
+	[CMD_ASC] = 0x5306,
+	[CMD_FRC] = 0x5204,
+	[CMD_TEMP_OFFSET] = 0x5403,
+	[CMD_FW_VERSION] = 0xd100,
+	[CMD_RESET] = 0xd304,
+};
+
+DECLARE_CRC8_TABLE(scd30_i2c_crc8_tbl);
+
+static int scd30_i2c_xfer(struct scd30_state *state, char *txbuf, int txsize,
+			  char *rxbuf, int rxsize)
+{
+	struct i2c_client *client = to_i2c_client(state->dev);
+	int ret;
+
+	/*
+	 * repeated start is not supported hence instead of sending two i2c
+	 * messages in a row we send one by one
+	 */
+	ret = i2c_master_send(client, txbuf, txsize);
+	if (ret < 0)
+		return ret;
+	if (ret != txsize)
+		return -EIO;
+
+	if (!rxbuf)
+		return 0;
+
+	ret = i2c_master_recv(client, rxbuf, rxsize);
+	if (ret < 0)
+		return ret;
+	if (ret != rxsize)
+		return -EIO;
+
+	return 0;
+}
+
+static int scd30_i2c_command(struct scd30_state *state, enum scd30_cmd cmd, u16 arg,
+			     void *response, int size)
+{
+	char buf[SCD30_I2C_MAX_BUF_SIZE];
+	char *rsp = response;
+	int i, ret;
+	char crc;
+
+	put_unaligned_be16(scd30_i2c_cmd_lookup_tbl[cmd], buf);
+	i = 2;
+
+	if (rsp) {
+		/* each two bytes are followed by a crc8 */
+		size += size / 2;
+	} else {
+		put_unaligned_be16(arg, buf + i);
+		crc = crc8(scd30_i2c_crc8_tbl, buf + i, 2, CRC8_INIT_VALUE);
+		i += 2;
+		buf[i] = crc;
+		i += 1;
+
+		/* commands below don't take an argument */
+		if ((cmd == CMD_STOP_MEAS) || (cmd == CMD_RESET))
+			i -= 3;
+	}
+
+	ret = scd30_i2c_xfer(state, buf, i, buf, size);
+	if (ret)
+		return ret;
+
+	/* validate received data and strip off crc bytes */
+	for (i = 0; i < size; i += 3) {
+		crc = crc8(scd30_i2c_crc8_tbl, buf + i, 2, CRC8_INIT_VALUE);
+		if (crc != buf[i + 2]) {
+			dev_err(state->dev, "data integrity check failed\n");
+			return -EIO;
+		}
+
+		*rsp++ = buf[i];
+		*rsp++ = buf[i + 1];
+	}
+
+	return 0;
+}
+
+static int scd30_i2c_probe(struct i2c_client *client)
+{
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+
+	crc8_populate_msb(scd30_i2c_crc8_tbl, SCD30_I2C_CRC8_POLYNOMIAL);
+
+	return scd30_probe(&client->dev, client->irq, client->name, NULL, scd30_i2c_command);
+}
+
+static const struct of_device_id scd30_i2c_of_match[] = {
+	{ .compatible = "sensirion,scd30" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, scd30_i2c_of_match);
+
+static struct i2c_driver scd30_i2c_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = scd30_i2c_of_match,
+		.pm = &scd30_pm_ops,
+	},
+	.probe_new = scd30_i2c_probe,
+};
+module_i2c_driver(scd30_i2c_driver);
+
+MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
+MODULE_DESCRIPTION("Sensirion SCD30 carbon dioxide sensor i2c driver");
+MODULE_LICENSE("GPL v2");
-- 
2.27.0

