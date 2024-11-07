Return-Path: <linux-iio+bounces-11980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 125369C04C6
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 12:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DB82843C8
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 11:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6883D20F5DC;
	Thu,  7 Nov 2024 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="KqK7eP+4"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BBC20EA3D;
	Thu,  7 Nov 2024 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980081; cv=none; b=kkGTKisb1/4+XOfHNykmf/bVYm5sQ4MuX1K738mRH0UEd+4YKNOsbj6wLDa5mxakfgxtOyRipAceI7ncJC2sgS1QACrLAndc0KAKg1vZm//adoB4FxycMTgTtSqiLw9zZYW7Kg+cQzYPZGHyRV4nv055K9NpPa0wgRhFqtjpTM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980081; c=relaxed/simple;
	bh=q+CyW7hRxRJsOwECDdSaZ1apYnxVlMukFZ91eS8dwyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQP27RHMngKQ15HXnjbuyxuqfhsnoPfJ+1JmAxESzr0ZVJ6RYz4EmsLPnaaDYdPx0WCMFYhiYqityBkxoGWY/1FpoNs0zpq4ttwR62hbA8i9vFO0PJS8eGOGY4c6wM+5eMvjEDJsOrH56qnI8ZoZQjyLV3ZB3t3R3gtNz8ut2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=KqK7eP+4; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NJxGQ943tcxwIm5MzLn/1i2mcCJ6TCeIRz2CYSjjGsk=; b=KqK7eP+4k8YnyjR9nCAIyfm+57
	EhP7vQfX7XohLQiihWkqYZHP8PSdOfJnyLSMqVziRCzYEn2EyO+4MONpm5WYUSyw8DfUwYQdcLa6H
	gJoI0O8v7LLBQ9ginaJJZSY82/CN1uZA80ZVH5LIMgAZntS3Vw171mUlk+Kp/YW1fpdreJoMZe5OS
	X+qP8xsIfOipZNnfrGv4LbkpKzYMHaOr4NTTxiyYmAytAiqNEk3cnTG+ut78AMFWNq0FdPRz7LtIE
	ypKELdkrDQYNh38oqj6uSELIfmr2oNKeHsYFD+rI2YcbC5//TppQNfIEc90AbCXyO5gJ2Va3d5DJf
	+H6Kowag==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t90z1-0005lF-8W; Thu, 07 Nov 2024 12:47:27 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org,
	jikos@kernel.org,
	jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org,
	dmitry.torokhov@gmail.com,
	pavel@ucw.cz,
	ukleinek@debian.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH v9 4/9] mfd: add base driver for qnap-mcu devices
Date: Thu,  7 Nov 2024 12:47:07 +0100
Message-ID: <20241107114712.538976-5-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107114712.538976-1-heiko@sntech.de>
References: <20241107114712.538976-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These microcontroller units are used in network-attached-storage devices
made by QNAP and provide additional functionality to the system.

This adds the base driver that implements the serial protocol via
serdev and additionally hooks into the poweroff handlers to turn
off the parts of the system not supplied by the general PMIC.

Turning off (at least the TSx33 devices using Rockchip SoCs) consists of
two separate actions. Turning off the MCU alone does not turn off the main
SoC and turning off only the SoC/PMIC does not turn off the hard-drives.
Also if the MCU is not turned off, the system also won't start again until
it is unplugged from power.

So on shutdown the MCU needs to be turned off separately before the
main PMIC.

The protocol spoken by the MCU is sadly not documented, but was
obtained by listening to the chatter on the serial port, as thankfully
the "hal_app" program from QNAPs firmware allows triggering all/most
MCU actions from the command line.

The implementation of how to talk to the serial device got some
inspiration from the rave-sp servdev driver.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 MAINTAINERS                  |   6 +
 drivers/mfd/Kconfig          |  13 ++
 drivers/mfd/Makefile         |   2 +
 drivers/mfd/qnap-mcu.c       | 338 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/qnap-mcu.h |  26 +++
 5 files changed, 385 insertions(+)
 create mode 100644 drivers/mfd/qnap-mcu.c
 create mode 100644 include/linux/mfd/qnap-mcu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 65b7bbfeea96..cd8d18f76d28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18878,6 +18878,12 @@ L:	linux-media@vger.kernel.org
 S:	Odd Fixes
 F:	drivers/media/tuners/qm1d1c0042*
 
+QNAP MCU DRIVER
+M:	Heiko Stuebner <heiko@sntech.de>
+S:	Maintained
+F:	drivers/mfd/qnap-mcu.c
+F:	include/linux/qnap-mcu.h
+
 QNX4 FILESYSTEM
 M:	Anders Larsen <al@alarsen.net>
 S:	Maintained
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ae23b317a64e..74f4de8cd6f1 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2386,6 +2386,19 @@ config MFD_INTEL_M10_BMC_PMCI
 	  additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_QNAP_MCU
+	tristate "QNAP microcontroller unit core driver"
+	depends on SERIAL_DEV_BUS
+	select MFD_CORE
+	help
+	  Select this to get support for the QNAP MCU device found in
+	  several devices of QNAP network attached storage products that
+	  implements additional functionality for the device, like fan
+	  and LED control.
+
+	  This driver implements the base serial protocol to talk to the
+	  device and provides functions for the other parts to hook into.
+
 config MFD_RSMU_I2C
 	tristate "Renesas Synchronization Management Unit with I2C"
 	depends on I2C && OF
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index e057d6d6faef..b2d540934179 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -288,5 +288,7 @@ obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)   += intel-m10-bmc-pmci.o
 obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
 obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
 
+obj-$(CONFIG_MFD_QNAP_MCU)	+= qnap-mcu.o
+
 obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu_i2c.o rsmu_core.o
 obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu_spi.o rsmu_core.o
diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
new file mode 100644
index 000000000000..4be39d8b2905
--- /dev/null
+++ b/drivers/mfd/qnap-mcu.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Core driver for the microcontroller unit in QNAP NAS devices that is
+ * connected via a dedicated UART port.
+ *
+ * Copyright (C) 2024 Heiko Stuebner <heiko@sntech.de>
+ */
+
+#include <linux/cleanup.h>
+#include <linux/export.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/qnap-mcu.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/reboot.h>
+#include <linux/serdev.h>
+#include <linux/slab.h>
+
+/* The longest command found so far is 5 bytes long */
+#define QNAP_MCU_MAX_CMD_SIZE		5
+#define QNAP_MCU_MAX_DATA_SIZE		36
+#define QNAP_MCU_CHECKSUM_SIZE		1
+
+#define QNAP_MCU_RX_BUFFER_SIZE		\
+		(QNAP_MCU_MAX_DATA_SIZE + QNAP_MCU_CHECKSUM_SIZE)
+
+#define QNAP_MCU_TX_BUFFER_SIZE		\
+		(QNAP_MCU_MAX_CMD_SIZE + QNAP_MCU_CHECKSUM_SIZE)
+
+#define QNAP_MCU_ACK_LEN		2
+#define QNAP_MCU_VERSION_LEN		4
+
+#define QNAP_MCU_TIMEOUT_MS		500
+
+/**
+ * struct qnap_mcu_reply - Reply to a command
+ *
+ * @data:	Buffer to store reply payload in
+ * @length:	Expected reply length, including the checksum
+ * @received:	Received number of bytes, so far
+ * @done:	Triggered when the entire reply has been received
+ */
+struct qnap_mcu_reply {
+	u8 *data;
+	size_t length;
+	size_t received;
+	struct completion done;
+};
+
+/**
+ * struct qnap_mcu - QNAP NAS embedded controller
+ *
+ * @serdev:	Pointer to underlying serdev
+ * @bus_lock:	Lock to serialize access to the device
+ * @reply:	Reply data structure
+ * @variant:	Device variant specific information
+ * @version:	MCU firmware version
+ */
+struct qnap_mcu {
+	struct serdev_device *serdev;
+	struct mutex bus_lock;
+	struct qnap_mcu_reply reply;
+	const struct qnap_mcu_variant *variant;
+	u8 version[QNAP_MCU_VERSION_LEN];
+};
+
+/*
+ * The QNAP-MCU uses a basic XOR checksum.
+ * It is always the last byte and XORs the whole previous message.
+ */
+static u8 qnap_mcu_csum(const u8 *buf, size_t size)
+{
+	u8 csum = 0;
+
+	while (size--)
+		csum ^= *buf++;
+
+	return csum;
+}
+
+static int qnap_mcu_write(struct qnap_mcu *mcu, const u8 *data, u8 data_size)
+{
+	unsigned char tx[QNAP_MCU_TX_BUFFER_SIZE];
+	size_t length = data_size + QNAP_MCU_CHECKSUM_SIZE;
+
+	if (length > sizeof(tx)) {
+		dev_err(&mcu->serdev->dev, "data too big for transmit buffer");
+		return -EINVAL;
+	}
+
+	memcpy(tx, data, data_size);
+	tx[data_size] = qnap_mcu_csum(data, data_size);
+
+	serdev_device_write_flush(mcu->serdev);
+
+	return serdev_device_write(mcu->serdev, tx, length, HZ);
+}
+
+static size_t qnap_mcu_receive_buf(struct serdev_device *serdev, const u8 *buf, size_t size)
+{
+	struct device *dev = &serdev->dev;
+	struct qnap_mcu *mcu = dev_get_drvdata(dev);
+	struct qnap_mcu_reply *reply = &mcu->reply;
+	const u8 *src = buf;
+	const u8 *end = buf + size;
+
+	if (!reply->length) {
+		dev_warn(dev, "Received %zu bytes, we were not waiting for\n", size);
+		return size;
+	}
+
+	while (src < end) {
+		reply->data[reply->received] = *src++;
+		reply->received++;
+
+		if (reply->received == reply->length) {
+			/* We don't expect any characters from the device now */
+			reply->length = 0;
+
+			complete(&reply->done);
+
+			/*
+			 * We report the consumed number of bytes. If there
+			 * are still bytes remaining (though there shouldn't)
+			 * the serdev layer will re-execute this handler with
+			 * the remainder of the Rx bytes.
+			 */
+			return src - buf;
+		}
+	}
+
+	/*
+	 * The only way to get out of the above loop and end up here
+	 * is through consuming all of the supplied data, so here we
+	 * report that we processed it all.
+	 */
+	return size;
+}
+
+static const struct serdev_device_ops qnap_mcu_serdev_device_ops = {
+	.receive_buf  = qnap_mcu_receive_buf,
+	.write_wakeup = serdev_device_write_wakeup,
+};
+
+int qnap_mcu_exec(struct qnap_mcu *mcu,
+		  const u8 *cmd_data, size_t cmd_data_size,
+		  u8 *reply_data, size_t reply_data_size)
+{
+	unsigned char rx[QNAP_MCU_RX_BUFFER_SIZE];
+	size_t length = reply_data_size + QNAP_MCU_CHECKSUM_SIZE;
+	struct qnap_mcu_reply *reply = &mcu->reply;
+	int ret = 0;
+
+	if (length > sizeof(rx)) {
+		dev_err(&mcu->serdev->dev, "expected data too big for receive buffer");
+		return -EINVAL;
+	}
+
+	mutex_lock(&mcu->bus_lock);
+
+	reply->data = rx,
+	reply->length = length,
+	reply->received = 0,
+	reinit_completion(&reply->done);
+
+	qnap_mcu_write(mcu, cmd_data, cmd_data_size);
+
+	serdev_device_wait_until_sent(mcu->serdev, msecs_to_jiffies(QNAP_MCU_TIMEOUT_MS));
+
+	if (!wait_for_completion_timeout(&reply->done, msecs_to_jiffies(QNAP_MCU_TIMEOUT_MS))) {
+		dev_err(&mcu->serdev->dev, "Command timeout\n");
+		ret = -ETIMEDOUT;
+	} else {
+		u8 crc = qnap_mcu_csum(rx, reply_data_size);
+
+		if (crc != rx[reply_data_size]) {
+			dev_err(&mcu->serdev->dev,
+				"Invalid Checksum received\n");
+			ret = -EIO;
+		} else {
+			memcpy(reply_data, rx, reply_data_size);
+		}
+	}
+
+	mutex_unlock(&mcu->bus_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qnap_mcu_exec);
+
+int qnap_mcu_exec_with_ack(struct qnap_mcu *mcu,
+			   const u8 *cmd_data, size_t cmd_data_size)
+{
+	u8 ack[QNAP_MCU_ACK_LEN];
+	int ret;
+
+	ret = qnap_mcu_exec(mcu, cmd_data, cmd_data_size, ack, sizeof(ack));
+	if (ret)
+		return ret;
+
+	/* Should return @0 */
+	if (ack[0] != '@' || ack[1] != '0') {
+		dev_err(&mcu->serdev->dev, "Did not receive ack\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qnap_mcu_exec_with_ack);
+
+static int qnap_mcu_get_version(struct qnap_mcu *mcu)
+{
+	const u8 cmd[] = { '%', 'V' };
+	u8 rx[14];
+	int ret;
+
+	/* Reply is the 2 command-bytes + 4 bytes describing the version */
+	ret = qnap_mcu_exec(mcu, cmd, sizeof(cmd), rx, QNAP_MCU_VERSION_LEN + 2);
+	if (ret)
+		return ret;
+
+	memcpy(mcu->version, &rx[2], QNAP_MCU_VERSION_LEN);
+
+	return 0;
+}
+
+/*
+ * The MCU controls power to the peripherals but not the CPU.
+ *
+ * So using the PMIC to power off the system keeps the MCU and hard-drives
+ * running. This also then prevents the system from turning back on until
+ * the MCU is turned off by unplugging the power cable.
+ * Turning off the MCU alone on the other hand turns off the hard drives,
+ * LEDs, etc while the main SoC stays running - including its network ports.
+ */
+static int qnap_mcu_power_off(struct sys_off_data *data)
+{
+	const u8 cmd[] = { '@', 'C', '0' };
+	struct qnap_mcu *mcu = data->cb_data;
+	int ret;
+
+	ret = qnap_mcu_exec_with_ack(mcu, cmd, sizeof(cmd));
+	if (ret) {
+		dev_err(&mcu->serdev->dev, "MCU poweroff failed %d\n", ret);
+		return NOTIFY_STOP;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static const struct qnap_mcu_variant qnap_ts433_mcu = {
+	.baud_rate = 115200,
+	.num_drives = 4,
+	.fan_pwm_min = 51,  /* Specified in original model.conf */
+	.fan_pwm_max = 255,
+	.usb_led = true,
+};
+
+static struct mfd_cell qnap_mcu_cells[] = {
+	{ .name = "qnap-mcu-input", },
+	{ .name = "qnap-mcu-leds", },
+	{ .name = "qnap-mcu-hwmon", }
+};
+
+static int qnap_mcu_probe(struct serdev_device *serdev)
+{
+	struct device *dev = &serdev->dev;
+	struct qnap_mcu *mcu;
+	int ret;
+
+	mcu = devm_kzalloc(dev, sizeof(*mcu), GFP_KERNEL);
+	if (!mcu)
+		return -ENOMEM;
+
+	mcu->serdev = serdev;
+	dev_set_drvdata(dev, mcu);
+
+	mcu->variant = of_device_get_match_data(dev);
+	if (!mcu->variant)
+		return -ENODEV;
+
+	mutex_init(&mcu->bus_lock);
+	init_completion(&mcu->reply.done);
+
+	serdev_device_set_client_ops(serdev, &qnap_mcu_serdev_device_ops);
+	ret = devm_serdev_device_open(dev, serdev);
+	if (ret)
+		return ret;
+
+	serdev_device_set_baudrate(serdev, mcu->variant->baud_rate);
+	serdev_device_set_flow_control(serdev, false);
+
+	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set parity\n");
+
+	ret = qnap_mcu_get_version(mcu);
+	if (ret)
+		return ret;
+
+	ret = devm_register_sys_off_handler(dev,
+					    SYS_OFF_MODE_POWER_OFF_PREPARE,
+					    SYS_OFF_PRIO_DEFAULT,
+					    &qnap_mcu_power_off, mcu);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register poweroff handler\n");
+
+	for (int i = 0; i < ARRAY_SIZE(qnap_mcu_cells); i++) {
+		qnap_mcu_cells[i].platform_data = mcu->variant;
+		qnap_mcu_cells[i].pdata_size = sizeof(*mcu->variant);
+	}
+
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, qnap_mcu_cells,
+				   ARRAY_SIZE(qnap_mcu_cells), NULL, 0, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add child devices\n");
+
+	return 0;
+}
+
+static const struct of_device_id qnap_mcu_dt_ids[] = {
+	{ .compatible = "qnap,ts433-mcu", .data = &qnap_ts433_mcu },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, qnap_mcu_dt_ids);
+
+static struct serdev_device_driver qnap_mcu_drv = {
+	.probe = qnap_mcu_probe,
+	.driver = {
+		.name = "qnap-mcu",
+		.of_match_table = qnap_mcu_dt_ids,
+	},
+};
+module_serdev_device_driver(qnap_mcu_drv);
+
+MODULE_AUTHOR("Heiko Stuebner <heiko@sntech.de>");
+MODULE_DESCRIPTION("QNAP MCU core driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/qnap-mcu.h b/include/linux/mfd/qnap-mcu.h
new file mode 100644
index 000000000000..8d48c212fd44
--- /dev/null
+++ b/include/linux/mfd/qnap-mcu.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Core definitions for QNAP MCU MFD driver.
+ * Copyright (C) 2024 Heiko Stuebner <heiko@sntech.de>
+ */
+
+#ifndef _LINUX_QNAP_MCU_H_
+#define _LINUX_QNAP_MCU_H_
+
+struct qnap_mcu;
+
+struct qnap_mcu_variant {
+	u32 baud_rate;
+	int num_drives;
+	int fan_pwm_min;
+	int fan_pwm_max;
+	bool usb_led;
+};
+
+int qnap_mcu_exec(struct qnap_mcu *mcu,
+		  const u8 *cmd_data, size_t cmd_data_size,
+		  u8 *reply_data, size_t reply_data_size);
+int qnap_mcu_exec_with_ack(struct qnap_mcu *mcu,
+			   const u8 *cmd_data, size_t cmd_data_size);
+
+#endif /* _LINUX_QNAP_MCU_H_ */
-- 
2.45.2


