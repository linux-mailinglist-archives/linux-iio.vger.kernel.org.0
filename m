Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651201E93FD
	for <lists+linux-iio@lfdr.de>; Sat, 30 May 2020 23:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgE3Viw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 May 2020 17:38:52 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:53741 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729314AbgE3Viv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 May 2020 17:38:51 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.143.168])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id C494454AA499;
        Sat, 30 May 2020 23:38:47 +0200 (CEST)
Received: from arch.lan (89.70.180.118) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Sat, 30 May
 2020 23:38:41 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <jic23@kernel.org>,
        <andy.shevchenko@gmail.com>, <pmeerw@pmeerw.net>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH v2 3/4] iio: chemical: scd30: add serial interface driver
Date:   Sat, 30 May 2020 23:36:29 +0200
Message-ID: <20200530213630.87159-4-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200530213630.87159-1-tomasz.duszynski@octakon.com>
References: <20200530213630.87159-1-tomasz.duszynski@octakon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [89.70.180.118]
X-ClientProxiedBy: DAG2EX1.emp2.local (172.16.2.11) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 15161086670580112407
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudeftddgudeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuggftrfgrthhtvghrnhepveejvdekueeiheevgeegudduvdfhudfhhfehudefjeduheekuefhgfehudffuddunecukfhppedtrddtrddtrddtpdekledrjedtrddukedtrdduudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtohepphhmvggvrhifsehpmhgvvghrfidrnhgvth
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add serial interface driver for the SCD30 sensor.

Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
---
 MAINTAINERS                         |   1 +
 drivers/iio/chemical/Kconfig        |  11 ++
 drivers/iio/chemical/Makefile       |   1 +
 drivers/iio/chemical/scd30_serial.c | 266 ++++++++++++++++++++++++++++
 4 files changed, 279 insertions(+)
 create mode 100644 drivers/iio/chemical/scd30_serial.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 13aed3473b7e..5db4b446c8ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15143,6 +15143,7 @@ S:	Maintained
 F:	drivers/iio/chemical/scd30.h
 F:	drivers/iio/chemical/scd30_core.c
 F:	drivers/iio/chemical/scd30_i2c.c
+F:	drivers/iio/chemical/scd30_serial.c
 
 SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 970d34888c2e..10bb431bc3ce 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -107,6 +107,17 @@ config SCD30_I2C
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
index 0966ca34e34b..fef63dd5bf92 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
 obj-$(CONFIG_PMS7003) += pms7003.o
 obj-$(CONFIG_SCD30_CORE) += scd30_core.o
 obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
+obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
 obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
 obj-$(CONFIG_SPS30) += sps30.o
 obj-$(CONFIG_VZ89X)		+= vz89x.o
diff --git a/drivers/iio/chemical/scd30_serial.c b/drivers/iio/chemical/scd30_serial.c
new file mode 100644
index 000000000000..07d7d3110fe0
--- /dev/null
+++ b/drivers/iio/chemical/scd30_serial.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sensirion SCD30 carbon dioxide sensor serial driver
+ *
+ * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
+ */
+#include <linux/crc16.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/iio/iio.h>
+#include <linux/jiffies.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/serdev.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <asm/unaligned.h>
+
+#include "scd30.h"
+
+#define SCD30_SERDEV_ADDR 0x61
+#define SCD30_SERDEV_WRITE 0x06
+#define SCD30_SERDEV_READ 0x03
+#define SCD30_SERDEV_MAX_BUF_SIZE 17
+#define SCD30_SERDEV_RX_HEADER_SIZE 3
+#define SCD30_SERDEV_CRC_SIZE 2
+#define SCD30_SERDEV_TIMEOUT msecs_to_jiffies(200)
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
+				u16 arg, void *response, int size)
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
+	char txbuf[SCD30_SERDEV_MAX_BUF_SIZE] = { SCD30_SERDEV_ADDR },
+	     rxbuf[SCD30_SERDEV_MAX_BUF_SIZE], *rsp = response;
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
+	struct scd30_serdev_priv *priv;
+	struct scd30_state *state;
+	int num;
+
+	if (!indio_dev)
+		return 0;
+
+	state = iio_priv(indio_dev);
+	priv = state->priv;
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
+	irq = fwnode_irq_get(dev_fwnode(dev), 0);
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
2.26.2

