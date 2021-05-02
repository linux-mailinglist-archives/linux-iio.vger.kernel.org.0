Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FE5370BB5
	for <lists+linux-iio@lfdr.de>; Sun,  2 May 2021 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhEBNtr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 May 2021 09:49:47 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:35623 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232056AbhEBNtq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 May 2021 09:49:46 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.138.108])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id D340CA3B133A;
        Sun,  2 May 2021 15:48:52 +0200 (CEST)
Received: from arch.lan (89.70.221.198) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 2 May 2021
 15:48:52 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH v2 2/3] iio: sps30: add support for serial interface
Date:   Sun, 2 May 2021 15:44:30 +0200
Message-ID: <20210502134431.42647-3-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210502134431.42647-1-tomasz.duszynski@octakon.com>
References: <20210502134431.42647-1-tomasz.duszynski@octakon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [89.70.221.198]
X-ClientProxiedBy: DAG4EX1.emp2.local (172.16.2.31) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 12521132864618454039
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdefuddguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuggftrfgrthhtvghrnhepveejvdekueeiheevgeegudduvdfhudfhhfehudefjeduheekuefhgfehudffuddunecukfhppedtrddtrddtrddtpdekledrjedtrddvvddurdduleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtoheprhhosghhodgutheskhgvrhhnvghlrdhorhhg
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sensor has support for both i2c and serial communication interfaces.
Both offer very similar set of features. Minor differences don't impact
overall functionality like doing measurements, etc.

Support for i2c have already been added, this patch adds support
for the latter ie. serial interface.

Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
---
 MAINTAINERS                         |   1 +
 drivers/iio/chemical/Kconfig        |  11 +
 drivers/iio/chemical/Makefile       |   1 +
 drivers/iio/chemical/sps30_serial.c | 428 ++++++++++++++++++++++++++++
 4 files changed, 441 insertions(+)
 create mode 100644 drivers/iio/chemical/sps30_serial.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b39a9c48736..cab9a63ad2cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16138,6 +16138,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/chemical/sensirion,sps30.yaml
 F:	drivers/iio/chemical/sps30.c
 F:	drivers/iio/chemical/sps30_i2c.c
+F:	drivers/iio/chemical/sps30_serial.c
 
 SERIAL DEVICE BUS
 M:	Rob Herring <robh@kernel.org>
diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 2b45a76ab7bc..a4920646e9be 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -148,6 +148,17 @@ config SPS30_I2C
 	  To compile this driver as a module, choose M here: the module will
 	  be called sps30_i2c.
 
+config SPS30_SERIAL
+	tristate "SPS30 particulate matter sensor serial driver"
+	depends on SERIAL_DEV_BUS
+	select SPS30
+	help
+	  Say Y here to build support for the Sensirion SPS30 serial interface
+	  driver.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called sps30_serial.
+
 config VZ89X
 	tristate "SGX Sensortech MiCS VZ89X VOC sensor"
 	depends on I2C
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index 41c264a229c0..4898690cc155 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -18,4 +18,5 @@ obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
 obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
 obj-$(CONFIG_SPS30) += sps30.o
 obj-$(CONFIG_SPS30_I2C) += sps30_i2c.o
+obj-$(CONFIG_SPS30_SERIAL) += sps30_serial.o
 obj-$(CONFIG_VZ89X)		+= vz89x.o
diff --git a/drivers/iio/chemical/sps30_serial.c b/drivers/iio/chemical/sps30_serial.c
new file mode 100644
index 000000000000..3dc1a9e2ae82
--- /dev/null
+++ b/drivers/iio/chemical/sps30_serial.c
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sensirion SPS30 particulate matter sensor serial driver
+ *
+ * Copyright (c) 2021 Tomasz Duszynski <tomasz.duszynski@octakon.com>
+ */
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/iio/iio.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/serdev.h>
+#include <linux/types.h>
+
+#include "sps30.h"
+
+#define SPS30_SERIAL_DEV_NAME "sps30"
+
+#define SPS30_SERIAL_SOF_EOF 0x7e
+#define SPS30_SERIAL_TIMEOUT msecs_to_jiffies(20)
+#define SPS30_SERIAL_MAX_BUF_SIZE 263
+#define SPS30_SERIAL_ESCAPE_CHAR 0x7d
+
+#define SPS30_SERIAL_FRAME_MIN_SIZE 7
+#define SPS30_SERIAL_FRAME_ADR_OFFSET 1
+#define SPS30_SERIAL_FRAME_CMD_OFFSET 2
+#define SPS30_SERIAL_FRAME_MOSI_LEN_OFFSET 3
+#define SPS30_SERIAL_FRAME_MISO_STATE_OFFSET 3
+#define SPS30_SERIAL_FRAME_MISO_LEN_OFFSET 4
+#define SPS30_SERIAL_FRAME_MISO_DATA_OFFSET 5
+
+#define SPS30_SERIAL_START_MEAS 0x00
+#define SPS30_SERIAL_STOP_MEAS 0x01
+#define SPS30_SERIAL_READ_MEAS 0x03
+#define SPS30_SERIAL_RESET 0xd3
+#define SPS30_SERIAL_CLEAN_FAN 0x56
+#define SPS30_SERIAL_PERIOD 0x80
+#define SPS30_SERIAL_DEV_INFO 0xd0
+#define SPS30_SERIAL_READ_VERSION 0xd1
+
+struct sps30_serial_priv {
+	struct completion new_frame;
+	unsigned char buf[SPS30_SERIAL_MAX_BUF_SIZE];
+	size_t num;
+	bool escaped;
+	bool done;
+};
+
+static int sps30_serial_xfer(struct sps30_state *state, const unsigned char *buf, size_t size)
+{
+	struct serdev_device *serdev = to_serdev_device(state->dev);
+	struct sps30_serial_priv *priv = state->priv;
+	int ret;
+
+	priv->num = 0;
+	priv->escaped = false;
+	priv->done = false;
+
+	ret = serdev_device_write(serdev, buf, size, SPS30_SERIAL_TIMEOUT);
+	if (ret < 0)
+		return ret;
+	if (ret != size)
+		return -EIO;
+
+	ret = wait_for_completion_interruptible_timeout(&priv->new_frame, SPS30_SERIAL_TIMEOUT);
+	if (ret < 0)
+		return ret;
+	if (!ret)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static struct {
+	unsigned char byte;
+	unsigned char byte2;
+} sps30_serial_bytes[] = {
+	{ 0x11, 0x31 },
+	{ 0x13, 0x33 },
+	{ 0x7e, 0x5e },
+	{ 0x7d, 0x5d },
+};
+
+static int sps30_serial_put_byte(unsigned char *buf, unsigned char byte)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sps30_serial_bytes); i++) {
+		if (sps30_serial_bytes[i].byte != byte)
+			continue;
+
+		buf[0] = SPS30_SERIAL_ESCAPE_CHAR;
+		buf[1] = sps30_serial_bytes[i].byte2;
+
+		return 2;
+	}
+
+	buf[0] = byte;
+
+	return 1;
+}
+
+static char sps30_serial_get_byte(bool escaped, unsigned char byte2)
+{
+	int i;
+
+	if (!escaped)
+		return byte2;
+
+	for (i = 0; i < ARRAY_SIZE(sps30_serial_bytes); i++) {
+		if (sps30_serial_bytes[i].byte2 != byte2)
+			continue;
+
+		return sps30_serial_bytes[i].byte;
+	}
+
+	return 0;
+}
+
+static unsigned char sps30_serial_calc_chksum(const unsigned char *buf, size_t num)
+{
+	unsigned int chksum = 0;
+	size_t i;
+
+	for (i = 0; i < num; i++)
+		chksum += buf[i];
+
+	return ~chksum;
+}
+
+static int sps30_serial_prep_frame(unsigned char *buf, unsigned char cmd,
+				   const unsigned char *arg, size_t arg_size)
+{
+	unsigned char chksum;
+	int num = 0;
+	size_t i;
+
+	buf[num++] = SPS30_SERIAL_SOF_EOF;
+	buf[num++] = 0;
+	num += sps30_serial_put_byte(buf + num, cmd);
+	num += sps30_serial_put_byte(buf + num, arg_size);
+
+	for (i = 0; i < arg_size; i++)
+		num += sps30_serial_put_byte(buf + num, arg[i]);
+
+	/* SOF isn't checksummed */
+	chksum = sps30_serial_calc_chksum(buf + 1, num - 1);
+	num += sps30_serial_put_byte(buf + num, chksum);
+	buf[num++] = SPS30_SERIAL_SOF_EOF;
+
+	return num;
+}
+
+static bool sps30_serial_frame_valid(struct sps30_state *state, const unsigned char *buf)
+{
+	struct sps30_serial_priv *priv = state->priv;
+	unsigned char chksum;
+
+	if ((priv->num < SPS30_SERIAL_FRAME_MIN_SIZE) ||
+	    (priv->num != SPS30_SERIAL_FRAME_MIN_SIZE +
+	     priv->buf[SPS30_SERIAL_FRAME_MISO_LEN_OFFSET])) {
+		dev_err(state->dev, "frame has invalid number of bytes\n");
+		return false;
+	}
+
+	if ((priv->buf[SPS30_SERIAL_FRAME_ADR_OFFSET] != buf[SPS30_SERIAL_FRAME_ADR_OFFSET]) ||
+	    (priv->buf[SPS30_SERIAL_FRAME_CMD_OFFSET] != buf[SPS30_SERIAL_FRAME_CMD_OFFSET])) {
+		dev_err(state->dev, "frame has wrong ADR and CMD bytes\n");
+		return false;
+	}
+
+	if (priv->buf[SPS30_SERIAL_FRAME_MISO_STATE_OFFSET]) {
+		dev_err(state->dev, "frame with non-zero state received (0x%02x)\n",
+			priv->buf[SPS30_SERIAL_FRAME_MISO_STATE_OFFSET]);
+		return false;
+	}
+
+	/* SOF, checksum and EOF are not checksummed */
+	chksum = sps30_serial_calc_chksum(priv->buf + 1, priv->num - 3);
+	if (priv->buf[priv->num - 2] != chksum) {
+		dev_err(state->dev, "frame integrity check failed\n");
+		return false;
+	}
+
+	return true;
+}
+
+static int sps30_serial_command(struct sps30_state *state, unsigned char cmd,
+				const void *arg, size_t arg_size, void *rsp, size_t rsp_size)
+{
+	struct sps30_serial_priv *priv = state->priv;
+	unsigned char buf[SPS30_SERIAL_MAX_BUF_SIZE];
+	int ret, size;
+
+	size = sps30_serial_prep_frame(buf, cmd, arg, arg_size);
+	ret = sps30_serial_xfer(state, buf, size);
+	if (ret)
+		return ret;
+
+	if (!sps30_serial_frame_valid(state, buf))
+		return -EIO;
+
+	if (rsp) {
+		rsp_size = min_t(size_t, priv->buf[SPS30_SERIAL_FRAME_MISO_LEN_OFFSET], rsp_size);
+		memcpy(rsp, &priv->buf[SPS30_SERIAL_FRAME_MISO_DATA_OFFSET], rsp_size);
+	}
+
+	return rsp_size;
+}
+
+static int sps30_serial_receive_buf(struct serdev_device *serdev,
+				    const unsigned char *buf, size_t size)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
+	struct sps30_serial_priv *priv;
+	struct sps30_state *state;
+	unsigned char byte;
+	size_t i;
+
+	if (!indio_dev)
+		return 0;
+
+	state = iio_priv(indio_dev);
+	priv = state->priv;
+
+	/* just in case device put some unexpected data on the bus */
+	if (priv->done)
+		return size;
+
+	/* wait for the start of frame */
+	if (!priv->num && size && buf[0] != SPS30_SERIAL_SOF_EOF)
+		return 1;
+
+	if (priv->num + size >= ARRAY_SIZE(priv->buf))
+		size = ARRAY_SIZE(priv->buf) - priv->num;
+
+	for (i = 0; i < size; i++) {
+		byte = buf[i];
+		/* remove stuffed bytes on-the-fly */
+		if (byte == SPS30_SERIAL_ESCAPE_CHAR) {
+			priv->escaped = true;
+			continue;
+		}
+
+		byte = sps30_serial_get_byte(priv->escaped, byte);
+		if (priv->escaped && !byte)
+			dev_warn(state->dev, "unrecognized escaped char (0x%02x)\n", byte);
+
+		priv->buf[priv->num++] = byte;
+
+		/* EOF received */
+		if (!priv->escaped && byte == SPS30_SERIAL_SOF_EOF) {
+			if (priv->num < SPS30_SERIAL_FRAME_MIN_SIZE)
+				continue;
+
+			priv->done = true;
+			complete(&priv->new_frame);
+			i++;
+			break;
+		}
+
+		priv->escaped = false;
+	}
+
+	return i;
+}
+
+static const struct serdev_device_ops sps30_serial_device_ops = {
+	.receive_buf = sps30_serial_receive_buf,
+	.write_wakeup = serdev_device_write_wakeup,
+};
+
+static int sps30_serial_start_meas(struct sps30_state *state)
+{
+	/* request BE IEEE754 formatted data */
+	unsigned char buf[] = { 0x01, 0x03 };
+
+	return sps30_serial_command(state, SPS30_SERIAL_START_MEAS, buf, sizeof(buf), NULL, 0);
+}
+
+static int sps30_serial_stop_meas(struct sps30_state *state)
+{
+	return sps30_serial_command(state, SPS30_SERIAL_STOP_MEAS, NULL, 0, NULL, 0);
+}
+
+static int sps30_serial_reset(struct sps30_state *state)
+{
+	int ret;
+
+	ret = sps30_serial_command(state, SPS30_SERIAL_RESET, NULL, 0, NULL, 0);
+	msleep(500);
+
+	return ret;
+}
+
+static int sps30_serial_read_meas(struct sps30_state *state, __be32 *meas, size_t num)
+{
+	int ret;
+
+	/* measurements are ready within a second */
+	if (msleep_interruptible(1000))
+		return -EINTR;
+
+	ret = sps30_serial_command(state, SPS30_SERIAL_READ_MEAS, NULL, 0, meas, num * sizeof(num));
+	if (ret < 0)
+		return ret;
+	/* if measurements aren't ready sensor returns empty frame */
+	if (ret == SPS30_SERIAL_FRAME_MIN_SIZE)
+		return -ETIMEDOUT;
+	if (ret != num * sizeof(*meas))
+		return -EIO;
+
+	return 0;
+}
+
+static int sps30_serial_clean_fan(struct sps30_state *state)
+{
+	return sps30_serial_command(state, SPS30_SERIAL_CLEAN_FAN, NULL, 0, NULL, 0);
+}
+
+static int sps30_serial_read_cleaning_period(struct sps30_state *state, __be32 *period)
+{
+	unsigned char buf[] = { 0x00 };
+	int ret;
+
+	ret = sps30_serial_command(state, SPS30_SERIAL_PERIOD, buf, sizeof(buf),
+				   period, sizeof(*period));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(*period))
+		return -EIO;
+
+	return 0;
+}
+
+static int sps30_serial_write_cleaning_period(struct sps30_state *state, __be32 period)
+{
+	unsigned char buf[5] = { 0x00 };
+
+	memcpy(buf + 1, &period, sizeof(period));
+
+	return sps30_serial_command(state, SPS30_SERIAL_PERIOD, buf, sizeof(buf), NULL, 0);
+}
+
+static int sps30_serial_show_info(struct sps30_state *state)
+{
+	/* extra nul byte just in case serial number isn't a valid string */
+	unsigned char buf[32 + 1] = { 0x00 };
+	struct device *dev = state->dev;
+	int ret;
+
+	/* tell device to return serial number */
+	buf[0] = 0x03;
+	ret = sps30_serial_command(state, SPS30_SERIAL_DEV_INFO, buf, 1, buf, sizeof(buf) - 1);
+	if (ret < 0)
+		return ret;
+
+	dev_info(dev, "serial number: %s\n", buf);
+
+	ret = sps30_serial_command(state, SPS30_SERIAL_READ_VERSION, NULL, 0, buf, sizeof(buf) - 1);
+	if (ret < 0)
+		return ret;
+	if (ret < 2)
+		return -EIO;
+
+	dev_info(dev, "fw version: %u.%u\n", buf[0], buf[1]);
+
+	return 0;
+}
+
+static const struct sps30_ops sps30_serial_ops = {
+	.start_meas = sps30_serial_start_meas,
+	.stop_meas = sps30_serial_stop_meas,
+	.read_meas = sps30_serial_read_meas,
+	.reset = sps30_serial_reset,
+	.clean_fan = sps30_serial_clean_fan,
+	.read_cleaning_period = sps30_serial_read_cleaning_period,
+	.write_cleaning_period = sps30_serial_write_cleaning_period,
+	.show_info = sps30_serial_show_info,
+};
+
+static int sps30_serial_probe(struct serdev_device *serdev)
+{
+	struct device *dev = &serdev->dev;
+	struct sps30_serial_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	init_completion(&priv->new_frame);
+	serdev_device_set_client_ops(serdev, &sps30_serial_device_ops);
+
+	ret = devm_serdev_device_open(dev, serdev);
+	if (ret)
+		return ret;
+
+	serdev_device_set_baudrate(serdev, 115200);
+	serdev_device_set_flow_control(serdev, false);
+
+	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+	if (ret)
+		return ret;
+
+	return sps30_probe(dev, SPS30_SERIAL_DEV_NAME, priv, &sps30_serial_ops);
+}
+
+static const struct of_device_id sps30_serial_of_match[] = {
+	{ .compatible = "sensirion,sps30" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sps30_serial_of_match);
+
+static struct serdev_device_driver sps30_serial_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = sps30_serial_of_match,
+	},
+	.probe = sps30_serial_probe,
+};
+module_serdev_device_driver(sps30_serial_driver);
+
+MODULE_AUTHOR("Tomasz Duszynski <tomasz.duszynski@octakon.com>");
+MODULE_DESCRIPTION("Sensirion SPS30 particulate matter sensor serial driver");
+MODULE_LICENSE("GPL v2");
-- 
2.31.1

