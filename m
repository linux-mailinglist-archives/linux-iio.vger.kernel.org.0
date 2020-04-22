Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5241B4712
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 16:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgDVOUG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 10:20:06 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:57629 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbgDVOUF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 10:20:05 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.156.173])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4A8E05A6DE6D;
        Wed, 22 Apr 2020 16:13:07 +0200 (CEST)
Received: from arch.lan (89.70.31.203) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 22 Apr
 2020 16:13:06 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <jic23@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH 3/6] iio: chemical: scd30: add serial interface driver
Date:   Wed, 22 Apr 2020 16:11:32 +0200
Message-ID: <20200422141135.86419-4-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [89.70.31.203]
X-ClientProxiedBy: DAG3EX2.emp2.local (172.16.2.22) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 5833005946154015767
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrgeejgdeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecukfhppedtrddtrddtrddtpdekledrjedtrdefuddrvddtfeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrgh
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add serial interface driver for the SCD30 sensor.

Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
---
 drivers/iio/chemical/Kconfig        |  11 ++
 drivers/iio/chemical/Makefile       |   1 +
 drivers/iio/chemical/scd30_serial.c | 262 ++++++++++++++++++++++++++++
 3 files changed, 274 insertions(+)
 create mode 100644 drivers/iio/chemical/scd30_serial.c

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 0c99f37b6bb0..1b7a58d320e7 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -96,6 +96,17 @@ config SCD30_I2C
 	  To compile this driver as a module, choose M here: the module will
 	  be called scd30_i2c.
 
+config SCD30_SERIAL
+	tristate "SCD30 carbon dioxide sensor serial driver"
+	depends on SCD30_CORE && SERIAL_DEV_BUS
+	select CRC16
+	help
+	  Say Y here to build support for the Sensirion SCD30 serial interface
+	  driver.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called scd30_serial.
+
 config SENSIRION_SGP30
 	tristate "Sensirion SGPxx gas sensors"
 	depends on I2C
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index f60c8ef358c3..1fac1b14f825 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
 obj-$(CONFIG_PMS7003) += pms7003.o
 obj-$(CONFIG_SCD30_CORE) += scd30_core.o
 obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
+obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
 obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
 obj-$(CONFIG_SPS30) += sps30.o
 obj-$(CONFIG_VZ89X)		+= vz89x.o
diff --git a/drivers/iio/chemical/scd30_serial.c b/drivers/iio/chemical/scd30_serial.c
new file mode 100644
index 000000000000..93b98d5f2cc4
--- /dev/null
+++ b/drivers/iio/chemical/scd30_serial.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sensirion SCD30 carbon dioxide sensor serial driver
+ *
+ * Copyright (c) Tomasz Duszynski <tomasz.duszynski@octakon.com>
+ */
+#include <asm/unaligned.h>
+#include <linux/crc16.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/iio/iio.h>
+#include <linux/jiffies.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/serdev.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "scd30.h"
+
+#define SCD30_SERDEV_ADDR 0x61
+#define SCD30_SERDEV_WRITE 0x06
+#define SCD30_SERDEV_READ 0x03
+#define SCD30_SERDEV_MAX_BUF_SIZE 17
+#define SCD30_SERDEV_RX_HEADER_SIZE 3
+#define SCD30_SERDEV_CRC_SIZE 2
+#define SCD30_SERDEV_TIMEOUT msecs_to_jiffies(500)
+
+struct scd30_serdev_priv {
+	struct completion meas_ready;
+	char *buf;
+	int num_expected;
+	int num;
+};
+
+static u16 scd30_serdev_cmd_lookup_tbl[] = {
+	[CMD_START_MEAS] = 0x0036,
+	[CMD_STOP_MEAS] = 0x0037,
+	[CMD_MEAS_INTERVAL] = 0x0025,
+	[CMD_MEAS_READY] = 0x0027,
+	[CMD_READ_MEAS] = 0x0028,
+	[CMD_ASC] = 0x003a,
+	[CMD_FRC] = 0x0039,
+	[CMD_TEMP_OFFSET] = 0x003b,
+	[CMD_FW_VERSION] = 0x0020,
+	[CMD_RESET] = 0x0034,
+};
+
+static u16 scd30_serdev_calc_crc(const char *buf, int size)
+{
+	return crc16(0xffff, buf, size);
+}
+
+static int scd30_serdev_xfer(struct scd30_state *state, char *txbuf, int txsize,
+			     char *rxbuf, int rxsize)
+{
+	struct serdev_device *serdev = to_serdev_device(state->dev);
+	struct scd30_serdev_priv *priv = state->priv;
+	int ret;
+
+	priv->buf = rxbuf;
+	priv->num_expected = rxsize;
+	priv->num = 0;
+
+	ret = serdev_device_write(serdev, txbuf, txsize, SCD30_SERDEV_TIMEOUT);
+	if (ret < txsize)
+		return ret < 0 ? ret : -EIO;
+
+	ret = wait_for_completion_interruptible_timeout(&priv->meas_ready,
+							SCD30_SERDEV_TIMEOUT);
+	if (ret > 0)
+		ret = 0;
+	else if (!ret)
+		ret = -ETIMEDOUT;
+
+	return ret;
+}
+
+static int scd30_serdev_command(struct scd30_state *state, enum scd30_cmd cmd,
+				u16 arg, char *rsp, int size)
+{
+	/*
+	 * Communication over serial line is based on modbus protocol (or rather
+	 * its variation called modbus over serial to be precise). Upon
+	 * receiving a request device should reply with response.
+	 *
+	 * Frame below represents a request message. Each field takes
+	 * exactly one byte.
+	 *
+	 * +------+------+-----+-----+-------+-------+-----+-----+
+	 * | dev  | op   | reg | reg | byte1 | byte0 | crc | crc |
+	 * | addr | code | msb | lsb |       |       | lsb | msb |
+	 * +------+------+-----+-----+-------+-------+-----+-----+
+	 *
+	 * The message device replies with depends on the 'op code' field from
+	 * the request. In case it was set to SCD30_SERDEV_WRITE sensor should
+	 * reply with unchanged request. Otherwise 'op code' was set to
+	 * SCD30_SERDEV_READ and response looks like the one below. As with
+	 * request, each field takes one byte.
+	 *
+	 * +------+------+--------+-------+-----+-------+-----+-----+
+	 * | dev  | op   | num of | byte0 | ... | byteN | crc | crc |
+	 * | addr | code | bytes  |       |     |       | lsb | msb |
+	 * +------+------+--------+-------+-----+-------+-----+-----+
+	 */
+	char rxbuf[SCD30_SERDEV_MAX_BUF_SIZE];
+	char txbuf[SCD30_SERDEV_MAX_BUF_SIZE] = { SCD30_SERDEV_ADDR };
+	int ret, rxsize, txsize = 2;
+	u16 crc;
+
+	put_unaligned_be16(scd30_serdev_cmd_lookup_tbl[cmd], txbuf + txsize);
+	txsize += 2;
+
+	if (rsp) {
+		txbuf[1] = SCD30_SERDEV_READ;
+		if (cmd == CMD_READ_MEAS)
+			/* number of u16 words to read */
+			put_unaligned_be16(size / 2, txbuf + txsize);
+		else
+			put_unaligned_be16(0x0001, txbuf + txsize);
+		txsize += 2;
+		crc = scd30_serdev_calc_crc(txbuf, txsize);
+		put_unaligned_le16(crc, txbuf + txsize);
+		txsize += 2;
+		rxsize = SCD30_SERDEV_RX_HEADER_SIZE + size +
+			 SCD30_SERDEV_CRC_SIZE;
+	} else {
+		if ((cmd == CMD_STOP_MEAS) || (cmd == CMD_RESET))
+			arg = 0x0001;
+
+		txbuf[1] = SCD30_SERDEV_WRITE;
+		put_unaligned_be16(arg, txbuf + txsize);
+		txsize += 2;
+		crc = scd30_serdev_calc_crc(txbuf, txsize);
+		put_unaligned_le16(crc, txbuf + txsize);
+		txsize += 2;
+		rxsize = txsize;
+	}
+
+	ret = scd30_serdev_xfer(state, txbuf, txsize, rxbuf, rxsize);
+	if (ret)
+		return ret;
+
+	switch (txbuf[1]) {
+	case SCD30_SERDEV_WRITE:
+		if (memcmp(txbuf, txbuf, txsize)) {
+			dev_err(state->dev, "wrong message received\n");
+			return -EIO;
+		}
+		break;
+	case SCD30_SERDEV_READ:
+		if (rxbuf[2] != (rxsize -
+				 SCD30_SERDEV_RX_HEADER_SIZE -
+				 SCD30_SERDEV_CRC_SIZE)) {
+			dev_err(state->dev,
+				"received data size does not match header\n");
+			return -EIO;
+		}
+
+		rxsize -= SCD30_SERDEV_CRC_SIZE;
+		crc = get_unaligned_le16(rxbuf + rxsize);
+		if (crc != scd30_serdev_calc_crc(rxbuf, rxsize)) {
+			dev_err(state->dev, "data integrity check failed\n");
+			return -EIO;
+		}
+
+		rxsize -= SCD30_SERDEV_RX_HEADER_SIZE;
+		memcpy(rsp, rxbuf + SCD30_SERDEV_RX_HEADER_SIZE, rxsize);
+		break;
+	default:
+		dev_err(state->dev, "received unknown op code\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int scd30_serdev_receive_buf(struct serdev_device *serdev,
+				    const unsigned char *buf, size_t size)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
+	struct scd30_state *state = iio_priv(indio_dev);
+	struct scd30_serdev_priv *priv = state->priv;
+	int num;
+
+	/* just in case sensor puts some unexpected bytes on the bus */
+	if (!priv->buf)
+		return 0;
+
+	if (priv->num + size >= priv->num_expected)
+		num = priv->num_expected - priv->num;
+	else
+		num = size;
+
+	memcpy(priv->buf + priv->num, buf, num);
+	priv->num += num;
+
+	if (priv->num == priv->num_expected) {
+		priv->buf = NULL;
+		complete(&priv->meas_ready);
+	}
+
+	return num;
+}
+
+static const struct serdev_device_ops scd30_serdev_ops = {
+	.receive_buf = scd30_serdev_receive_buf,
+	.write_wakeup = serdev_device_write_wakeup,
+};
+
+static int scd30_serdev_probe(struct serdev_device *serdev)
+{
+	struct device *dev = &serdev->dev;
+	struct scd30_serdev_priv *priv;
+	int irq, ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	init_completion(&priv->meas_ready);
+	serdev_device_set_client_ops(serdev, &scd30_serdev_ops);
+
+	ret = devm_serdev_device_open(dev, serdev);
+	if (ret)
+		return ret;
+
+	serdev_device_set_baudrate(serdev, 19200);
+	serdev_device_set_flow_control(serdev, false);
+
+	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+	if (ret)
+		return ret;
+
+	irq = of_irq_get(dev->of_node, 0);
+	if (irq <= 0)
+		irq = 0;
+
+	return scd30_probe(dev, irq, KBUILD_MODNAME, priv,
+			   scd30_serdev_command);
+}
+
+static const struct of_device_id scd30_serdev_of_match[] = {
+	{ .compatible = "sensirion,scd30" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, scd30_serdev_of_match);
+
+static struct serdev_device_driver scd30_serdev_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = scd30_serdev_of_match,
+		.pm = &scd30_pm_ops,
+	},
+	.probe = scd30_serdev_probe,
+};
+module_serdev_device_driver(scd30_serdev_driver);
+
+MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
+MODULE_DESCRIPTION("Sensirion SCD30 carbon dioxide sensor serial driver");
+MODULE_LICENSE("GPL v2");
-- 
2.26.1

