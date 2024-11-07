Return-Path: <linux-iio+bounces-11973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6969C04A1
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 12:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E699283FD9
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA1520F5C4;
	Thu,  7 Nov 2024 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="nc1xACRM"
X-Original-To: linux-iio@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D0F1EF934;
	Thu,  7 Nov 2024 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980078; cv=none; b=Rco6gxgbqclblr2lUOeT2bUqq57LUevY6EFybZxj6wQbCxmDallgPUIEXMyFGX5niI0jSAHtIJhnbDLyvpLpA43QTLDb7lOnNiET98bKDOiAyjqmXvBmnd3gy2jt9fwDGBv+2UY2oH/hO/j7J0DnaKofriirKqtkIaqsqjsrxHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980078; c=relaxed/simple;
	bh=nr3hhchgbJXU3zKrI1mTUMWVwAV8/ckc/EyxldarVYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NY7p64+1T0Ydy23XScezo2ZWCGO4PHjiedPNQVuYj7dGYQoI2HKaR5XzxN2dgjoU7DNhExt1QAxvvRBxEtquR6l+kFdx/Vsufpt/6Otvr+gHPtXvmUkR58srdeUX3FjhaxKUuIq5xQPHSAhKEuzkDSINmCNGH8wgYPBf2Cq0c0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=nc1xACRM; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jC0GDxJY4SJFyWBJ52PjtrRBRAUKVurzeGeMP459lcU=; b=nc1xACRM+sGtq+lREzqlVPG/Fk
	owQXDgv8tcb9f7Tghm4yFf6mfXYWaTPJ+RuJI0RXk/riYJloo3LiccNMuoliVj8Jo/JQc7Nk3yN4v
	GvOQ5SmFqvV4wsW8gG8g4svGdOYaqcUhsFxxrZowEa9Ybg74gjxQE/w+j+9Tzc4/IRlg2z0vnoHfB
	ttnaw+h5VLDUNEa42a9WiwtuhfF6CH99m/d+ozuRoH0YLLzeRRNndZzuzhonX5KjoZj5IxJRqcD9B
	dzrhOKXUhVRh1VxYY0yH1FKHpMWHcWKPuiUPrp0w8JwOpqxNf1M5i7JsxpOo3UgzMqiwOnQ+o5T5E
	lHQgRO8w==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t90z3-0005lF-O7; Thu, 07 Nov 2024 12:47:29 +0100
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
Subject: [PATCH v9 7/9] hwmon: add driver for the hwmon parts of qnap-mcu devices
Date: Thu,  7 Nov 2024 12:47:10 +0100
Message-ID: <20241107114712.538976-8-heiko@sntech.de>
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

The MCU can be found on network-attached-storage devices made by QNAP
and provides access to fan control including reading back its RPM as
well as reading the temperature of the NAS case.

Acked-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/hwmon/index.rst          |   1 +
 Documentation/hwmon/qnap-mcu-hwmon.rst |  27 ++
 MAINTAINERS                            |   1 +
 drivers/hwmon/Kconfig                  |  12 +
 drivers/hwmon/Makefile                 |   1 +
 drivers/hwmon/qnap-mcu-hwmon.c         | 364 +++++++++++++++++++++++++
 6 files changed, 406 insertions(+)
 create mode 100644 Documentation/hwmon/qnap-mcu-hwmon.rst
 create mode 100644 drivers/hwmon/qnap-mcu-hwmon.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index ea3b5be8fe4f..e134a4f8558f 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -199,6 +199,7 @@ Hardware Monitoring Kernel Drivers
    pxe1610
    pwm-fan
    q54sj108a2
+   qnap-mcu-hwmon
    raspberrypi-hwmon
    sbrmi
    sbtsi_temp
diff --git a/Documentation/hwmon/qnap-mcu-hwmon.rst b/Documentation/hwmon/qnap-mcu-hwmon.rst
new file mode 100644
index 000000000000..83407e3408f2
--- /dev/null
+++ b/Documentation/hwmon/qnap-mcu-hwmon.rst
@@ -0,0 +1,27 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver qnap-mcu-hwmon
+============================
+
+This driver enables the use of the hardware monitoring and fan control
+of the MCU used on some QNAP network attached storage devices.
+
+Author: Heiko Stuebner <heiko@sntech.de>
+
+Description
+-----------
+
+The driver implements a simple interface for driving the fan controlled by
+setting its PWM output value and exposes the fan rpm and case-temperature
+to user space through hwmon's sysfs interface.
+
+The fan rotation speed returned via the optional 'fan1_input' is calculated
+inside the MCU device.
+
+The driver provides the following sensor accesses in sysfs:
+
+=============== ======= =======================================================
+fan1_input	ro	fan tachometer speed in RPM
+pwm1		rw	relative speed (0-255), 255=max. speed.
+temp1_input	ro	Measured temperature in millicelsius
+=============== ======= =======================================================
diff --git a/MAINTAINERS b/MAINTAINERS
index 9e66441c50da..4e6719d15d75 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18881,6 +18881,7 @@ F:	drivers/media/tuners/qm1d1c0042*
 QNAP MCU DRIVER
 M:	Heiko Stuebner <heiko@sntech.de>
 S:	Maintained
+F:	drivers/hwmon/qnap-mcu-hwmon.c
 F:	drivers/input/misc/qnap-mcu-input.c
 F:	drivers/leds/leds-qnap-mcu.c
 F:	drivers/mfd/qnap-mcu.c
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 08a3c863f80a..74d33a96f7cc 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1800,6 +1800,18 @@ config SENSORS_PWM_FAN
 	  This driver can also be built as a module. If so, the module
 	  will be called pwm-fan.
 
+config SENSORS_QNAP_MCU_HWMON
+	tristate "QNAP MCU hardware monitoring"
+	depends on MFD_QNAP_MCU
+	depends on THERMAL || THERMAL=n
+	help
+	  Say yes here to enable support for fan and temperature sensor
+	  connected to a QNAP MCU, as found in a number of QNAP network
+	  attached storage devices.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called qnap-mcu-hwmon.
+
 config SENSORS_RASPBERRYPI_HWMON
 	tristate "Raspberry Pi voltage monitor"
 	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 9554d2fdcf7b..872f70f9902d 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -187,6 +187,7 @@ obj-$(CONFIG_SENSORS_POWERZ)	+= powerz.o
 obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
 obj-$(CONFIG_SENSORS_PT5161L)	+= pt5161l.o
 obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
+obj-$(CONFIG_SENSORS_QNAP_MCU_HWMON)	+= qnap-mcu-hwmon.o
 obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)	+= raspberrypi-hwmon.o
 obj-$(CONFIG_SENSORS_SBTSI)	+= sbtsi_temp.o
 obj-$(CONFIG_SENSORS_SBRMI)	+= sbrmi.o
diff --git a/drivers/hwmon/qnap-mcu-hwmon.c b/drivers/hwmon/qnap-mcu-hwmon.c
new file mode 100644
index 000000000000..29057514739c
--- /dev/null
+++ b/drivers/hwmon/qnap-mcu-hwmon.c
@@ -0,0 +1,364 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Driver for hwmon elements found on QNAP-MCU devices
+ *
+ * Copyright (C) 2024 Heiko Stuebner <heiko@sntech.de>
+ */
+
+#include <linux/fwnode.h>
+#include <linux/hwmon.h>
+#include <linux/mfd/qnap-mcu.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/thermal.h>
+
+struct qnap_mcu_hwmon {
+	struct qnap_mcu *mcu;
+	struct device *dev;
+
+	unsigned int pwm_min;
+	unsigned int pwm_max;
+
+	struct fwnode_handle *fan_node;
+	unsigned int fan_state;
+	unsigned int fan_max_state;
+	unsigned int *fan_cooling_levels;
+
+	struct thermal_cooling_device *cdev;
+	struct hwmon_chip_info info;
+};
+
+static int qnap_mcu_hwmon_get_rpm(struct qnap_mcu_hwmon *hwm)
+{
+	static const u8 cmd[] = { '@', 'F', 'A' };
+	u8 reply[6];
+	int ret;
+
+	/* poll the fan rpm */
+	ret = qnap_mcu_exec(hwm->mcu, cmd, sizeof(cmd), reply, sizeof(reply));
+	if (ret)
+		return ret;
+
+	/* First 2 bytes must mirror the sent command */
+	if (memcmp(cmd, reply, 2))
+		return -EIO;
+
+	return reply[4] * 30;
+}
+
+static int qnap_mcu_hwmon_get_pwm(struct qnap_mcu_hwmon *hwm)
+{
+	static const u8 cmd[] = { '@', 'F', 'Z', '0' }; /* 0 = fan-id? */
+	u8 reply[4];
+	int ret;
+
+	/* poll the fan pwm */
+	ret = qnap_mcu_exec(hwm->mcu, cmd, sizeof(cmd), reply, sizeof(reply));
+	if (ret)
+		return ret;
+
+	/* First 3 bytes must mirror the sent command */
+	if (memcmp(cmd, reply, 3))
+		return -EIO;
+
+	return reply[3];
+}
+
+static int qnap_mcu_hwmon_set_pwm(struct qnap_mcu_hwmon *hwm, u8 pwm)
+{
+	const u8 cmd[] = { '@', 'F', 'W', '0', pwm }; /* 0 = fan-id?, pwm 0-255 */
+
+	/* set the fan pwm */
+	return qnap_mcu_exec_with_ack(hwm->mcu, cmd, sizeof(cmd));
+}
+
+static int qnap_mcu_hwmon_get_temp(struct qnap_mcu_hwmon *hwm)
+{
+	static const u8 cmd[] = { '@', 'T', '3' };
+	u8 reply[4];
+	int ret;
+
+	/* poll the fan rpm */
+	ret = qnap_mcu_exec(hwm->mcu, cmd, sizeof(cmd), reply, sizeof(reply));
+	if (ret)
+		return ret;
+
+	/* First bytes must mirror the sent command */
+	if (memcmp(cmd, reply, sizeof(cmd)))
+		return -EIO;
+
+	/*
+	 * There is an unknown bit set in bit7.
+	 * Bits [6:0] report the actual temperature as returned by the
+	 * original qnap firmware-tools, so just drop bit7 for now.
+	 */
+	return (reply[3] & 0x7f) * 1000;
+}
+
+static int qnap_mcu_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
+				u32 attr, int channel, long val)
+{
+	struct qnap_mcu_hwmon *hwm = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_pwm_input:
+		if (val < 0 || val > 255)
+			return -EINVAL;
+
+		if (val != 0)
+			val = clamp_val(val, hwm->pwm_min, hwm->pwm_max);
+
+		return qnap_mcu_hwmon_set_pwm(hwm, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int qnap_mcu_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			       u32 attr, int channel, long *val)
+{
+	struct qnap_mcu_hwmon *hwm = dev_get_drvdata(dev);
+	int ret;
+
+	switch (type) {
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_input:
+			ret = qnap_mcu_hwmon_get_pwm(hwm);
+			if (ret < 0)
+				return ret;
+
+			*val = ret;
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+	case hwmon_fan:
+		ret = qnap_mcu_hwmon_get_rpm(hwm);
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
+		return 0;
+	case hwmon_temp:
+		ret = qnap_mcu_hwmon_get_temp(hwm);
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t qnap_mcu_hwmon_is_visible(const void *data,
+					 enum hwmon_sensor_types type,
+					 u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_temp:
+		return 0444;
+
+	case hwmon_pwm:
+		return 0644;
+
+	case hwmon_fan:
+		return 0444;
+
+	default:
+		return 0;
+	}
+}
+
+static const struct hwmon_ops qnap_mcu_hwmon_hwmon_ops = {
+	.is_visible = qnap_mcu_hwmon_is_visible,
+	.read = qnap_mcu_hwmon_read,
+	.write = qnap_mcu_hwmon_write,
+};
+
+/* thermal cooling device callbacks */
+static int qnap_mcu_hwmon_get_max_state(struct thermal_cooling_device *cdev,
+					unsigned long *state)
+{
+	struct qnap_mcu_hwmon *hwm = cdev->devdata;
+
+	if (!hwm)
+		return -EINVAL;
+
+	*state = hwm->fan_max_state;
+
+	return 0;
+}
+
+static int qnap_mcu_hwmon_get_cur_state(struct thermal_cooling_device *cdev,
+					unsigned long *state)
+{
+	struct qnap_mcu_hwmon *hwm = cdev->devdata;
+
+	if (!hwm)
+		return -EINVAL;
+
+	*state = hwm->fan_state;
+
+	return 0;
+}
+
+static int qnap_mcu_hwmon_set_cur_state(struct thermal_cooling_device *cdev,
+					unsigned long state)
+{
+	struct qnap_mcu_hwmon *hwm = cdev->devdata;
+	int ret;
+
+	if (!hwm || state > hwm->fan_max_state)
+		return -EINVAL;
+
+	if (state == hwm->fan_state)
+		return 0;
+
+	ret = qnap_mcu_hwmon_set_pwm(hwm, hwm->fan_cooling_levels[state]);
+	if (ret)
+		return ret;
+
+	hwm->fan_state = state;
+
+	return ret;
+}
+
+static const struct thermal_cooling_device_ops qnap_mcu_hwmon_cooling_ops = {
+	.get_max_state = qnap_mcu_hwmon_get_max_state,
+	.get_cur_state = qnap_mcu_hwmon_get_cur_state,
+	.set_cur_state = qnap_mcu_hwmon_set_cur_state,
+};
+
+static void devm_fan_node_release(void *data)
+{
+	struct qnap_mcu_hwmon *hwm = data;
+
+	fwnode_handle_put(hwm->fan_node);
+}
+
+static int qnap_mcu_hwmon_get_cooling_data(struct device *dev, struct qnap_mcu_hwmon *hwm)
+{
+	struct fwnode_handle *fwnode;
+	int num, i, ret;
+
+	fwnode = device_get_named_child_node(dev->parent, "fan-0");
+	if (!fwnode)
+		return 0;
+
+	/* if we found the fan-node, we're keeping it until device-unbind */
+	hwm->fan_node = fwnode;
+	ret = devm_add_action_or_reset(dev, devm_fan_node_release, hwm);
+	if (ret)
+		return ret;
+
+	num = fwnode_property_count_u32(fwnode, "cooling-levels");
+	if (num <= 0)
+		return dev_err_probe(dev, num ? : -EINVAL,
+				     "Failed to count elements in 'cooling-levels'\n");
+
+	hwm->fan_cooling_levels = devm_kcalloc(dev, num, sizeof(u32),
+					       GFP_KERNEL);
+	if (!hwm->fan_cooling_levels)
+		return -ENOMEM;
+
+	ret = fwnode_property_read_u32_array(fwnode, "cooling-levels",
+					     hwm->fan_cooling_levels, num);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read 'cooling-levels'\n");
+
+	for (i = 0; i < num; i++) {
+		if (hwm->fan_cooling_levels[i] > hwm->pwm_max)
+			return dev_err_probe(dev, -EINVAL, "fan state[%d]:%d > %d\n", i,
+					     hwm->fan_cooling_levels[i], hwm->pwm_max);
+	}
+
+	hwm->fan_max_state = num - 1;
+
+	return 0;
+}
+
+static const struct hwmon_channel_info * const qnap_mcu_hwmon_channels[] = {
+	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT),
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL
+};
+
+static int qnap_mcu_hwmon_probe(struct platform_device *pdev)
+{
+	struct qnap_mcu *mcu = dev_get_drvdata(pdev->dev.parent);
+	const struct qnap_mcu_variant *variant = pdev->dev.platform_data;
+	struct qnap_mcu_hwmon *hwm;
+	struct thermal_cooling_device *cdev;
+	struct device *dev = &pdev->dev;
+	struct device *hwmon;
+	int ret;
+
+	hwm = devm_kzalloc(dev, sizeof(*hwm), GFP_KERNEL);
+	if (!hwm)
+		return -ENOMEM;
+
+	hwm->mcu = mcu;
+	hwm->dev = &pdev->dev;
+	hwm->pwm_min = variant->fan_pwm_min;
+	hwm->pwm_max = variant->fan_pwm_max;
+
+	platform_set_drvdata(pdev, hwm);
+
+	/*
+	 * Set duty cycle to maximum allowed.
+	 */
+	ret = qnap_mcu_hwmon_set_pwm(hwm, hwm->pwm_max);
+	if (ret)
+		return ret;
+
+	hwm->info.ops = &qnap_mcu_hwmon_hwmon_ops;
+	hwm->info.info = qnap_mcu_hwmon_channels;
+
+	ret = qnap_mcu_hwmon_get_cooling_data(dev, hwm);
+	if (ret)
+		return ret;
+
+	hwm->fan_state = hwm->fan_max_state;
+
+	hwmon = devm_hwmon_device_register_with_info(dev, "qnapmcu",
+						     hwm, &hwm->info, NULL);
+	if (IS_ERR(hwmon))
+		return dev_err_probe(dev, PTR_ERR(hwmon), "Failed to register hwmon device\n");
+
+	/*
+	 * Only register cooling device when we found cooling-levels.
+	 * qnap_mcu_hwmon_get_cooling_data() will fail when reading malformed
+	 * levels and only succeed with either no or correct cooling levels.
+	 */
+	if (IS_ENABLED(CONFIG_THERMAL) && hwm->fan_cooling_levels) {
+		cdev = devm_thermal_of_cooling_device_register(dev,
+					to_of_node(hwm->fan_node), "qnap-mcu-hwmon",
+					hwm, &qnap_mcu_hwmon_cooling_ops);
+		if (IS_ERR(cdev))
+			return dev_err_probe(dev, PTR_ERR(cdev),
+				"Failed to register qnap-mcu-hwmon as cooling device\n");
+		hwm->cdev = cdev;
+	}
+
+	return 0;
+}
+
+static struct platform_driver qnap_mcu_hwmon_driver = {
+	.probe = qnap_mcu_hwmon_probe,
+	.driver = {
+		.name = "qnap-mcu-hwmon",
+	},
+};
+module_platform_driver(qnap_mcu_hwmon_driver);
+
+MODULE_ALIAS("platform:qnap-mcu-hwmon");
+MODULE_AUTHOR("Heiko Stuebner <heiko@sntech.de>");
+MODULE_DESCRIPTION("QNAP MCU hwmon driver");
+MODULE_LICENSE("GPL");
-- 
2.45.2


