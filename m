Return-Path: <linux-iio+bounces-16142-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 335E6A48539
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 17:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D611895B9A
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 16:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D90F1D5CEE;
	Thu, 27 Feb 2025 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="VvkRzLoc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [94.124.121.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436A21B4155
	for <linux-iio@vger.kernel.org>; Thu, 27 Feb 2025 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673799; cv=none; b=UIvL9LC0poF344YAZxvEgKWauzZTYkRVkmDs0ojOXyxqZ6J/s5hHxNHT0/2rQOZEwNwSRvwBp2aIWK2cBGV/Tb+dJ9f/Wut0NaVn+Rq7r6HU+Wm03t7Bad+5FiBx87oSw59D6avbIn2rZGOGy7AUiEMoHK9viY6zif4r9/UZTgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673799; c=relaxed/simple;
	bh=Ci4iEofNi/A3KqnWp1wBtnkAHH9ioysLtvdMsJT1jxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmCthDOdnuztY0yslduWIuPiGjKdR/dFccfhwslyBawXTGQ1ZowCZEpeC8yOrQeCeyj6Qq8qhyD6bNkH2h5GFD01Z5JedB3Mri1W5AVwkiedmmbmB5BoDGnJfgTd9dYljYQYUtK2iHn4HfCUR9mzQi5bqMjEW4EYUqydBBRZaLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=VvkRzLoc; arc=none smtp.client-ip=94.124.121.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=LREqZWlByDH431/N9Cv4nihXE45uZhdr4aeQQDars7g=;
	b=VvkRzLocyDRNAt/u0RmcjPF4ncX72ebot1jRHLB+NximQMH/wK4kYWiOUplRLaeAcXLUCDsVC0Fkt
	 YebA7Q5O4S2pT9LK8+q33lAmXynyr7uRf6GtrN+GGbNFbZIzWO6MPTZsYvH4t97zGJWc1sMT9YTFLH
	 H18m5+eUirjt3wZ497kMECk4WlMSUaR/j58UDgXn6Xm7Y9uDBfVCxbqU+PeUeY/dQEuoSMSizGsKr2
	 ffVpyqONoMzTpXAuYg0K8B4sgC4hpZcV23TXTZ0sefJazftN+x09JtljLaj+Sbx1mNHdXlpc4pYNLg
	 HWVM06WCkMSn8GmnRkfYEYw33Nk871A==
X-MSG-ID: eaf0501f-f527-11ef-8b43-005056817704
From: David Jander <david@protonic.nl>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	David Jander <david@protonic.nl>
Subject: [RFC PATCH 3/7] motion: Add simple-pwm.c PWM based DC motor controller driver
Date: Thu, 27 Feb 2025 17:28:19 +0100
Message-ID: <20250227162823.3585810-4-david@protonic.nl>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227162823.3585810-1-david@protonic.nl>
References: <20250227162823.3585810-1-david@protonic.nl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a simple DC-motor motion control driver that implements
 - 1 or 2 PWM channels for uni-directional or bi-directional drive
 - Trapezoidal acceleration profiles
 - Time-based movements
 - External trigger support

Tested with TI DRV8873

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/motion/Kconfig      |  13 ++-
 drivers/motion/Makefile     |   1 +
 drivers/motion/simple-pwm.c | 199 ++++++++++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+), 1 deletion(-)
 create mode 100644 drivers/motion/simple-pwm.c

diff --git a/drivers/motion/Kconfig b/drivers/motion/Kconfig
index 7715301c667e..63c4bdedb12a 100644
--- a/drivers/motion/Kconfig
+++ b/drivers/motion/Kconfig
@@ -11,7 +11,6 @@ menuconfig MOTION
 
 if MOTION
 
-
 config TMC5240
 	tristate "TMC5240 stepper motor driver"
 	depends on SPI
@@ -23,6 +22,18 @@ config TMC5240
 	  To compile this driver as a module, choose M here: the
 	  module will be called tmc5240.
 
+config MOTION_SIMPLE_PWM
+	tristate "Simple PWM base DC motor driver"
+	depends on PWM
+	select MOTION_HELPERS
+	help
+	  Say Y here is you have a DC motor driver you wish to control
+	  with 1 or 2 PWM outputs. Typically this is an H-bridge or similar
+	  driver, like the TI DRV8873 for example.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called "motion-simple-pwm".
+
 config MOTION_HELPERS
 	bool
 	depends on MOTION
diff --git a/drivers/motion/Makefile b/drivers/motion/Makefile
index 4f4e31138503..6b13b527fa17 100644
--- a/drivers/motion/Makefile
+++ b/drivers/motion/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_MOTION)		+= motion-core.o
 obj-$(CONFIG_MOTION_HELPERS)	+= motion-helpers.o
 obj-$(CONFIG_TMC5240)		+= tmc5240.o
+obj-$(CONFIG_MOTION_SIMPLE_PWM)	+= simple-pwm.o
diff --git a/drivers/motion/simple-pwm.c b/drivers/motion/simple-pwm.c
new file mode 100644
index 000000000000..89626c792235
--- /dev/null
+++ b/drivers/motion/simple-pwm.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Motion Control Subsystem - Simple speed proportional-PWM based motor driver
+ *
+ * Copyright (C) 2024 Protonic Holland
+ *      David Jander <david@protonic.nl>
+ */
+
+#include <asm-generic/errno-base.h>
+#include <linux/err.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/motion.h>
+#include <linux/types.h>
+#include <linux/pm.h>
+#include <linux/pwm.h>
+#include <asm/unaligned.h>
+
+#include "motion-core.h"
+#include "motion-helpers.h"
+
+#define MOTPWM_PWM_SCALE 100000
+#define MOTPWM_TIMER_PERIOD (20 * NSEC_PER_MSEC)
+
+struct motpwm {
+	struct pwm_device *pwms[2];
+	struct motion_device mdev;
+	struct platform_device *pdev;
+	bool pwm_inverted;
+};
+
+static inline int __effective_dc(struct motpwm *mp, unsigned int dc)
+{
+	if (mp->pwm_inverted)
+		return MOTPWM_PWM_SCALE - dc;
+	return dc;
+}
+
+static inline int __motpwm_set_speed_locked(struct motpwm *mp, unsigned int dir,
+		unsigned int dc, bool enable)
+{
+	struct pwm_state ps;
+	int cidx = !dir;
+	struct pwm_device *pwm, *cpwm;
+
+	dir = !!dir;
+	pwm = mp->pwms[dir];
+	cpwm = mp->pwms[cidx];
+
+	if (cpwm) {
+		pwm_init_state(cpwm, &ps);
+		ps.duty_cycle = __effective_dc(mp, 0);
+		ps.enabled = enable;
+		pwm_apply_might_sleep(cpwm, &ps);
+	}
+	if (!pwm)
+		return -EINVAL;
+
+	pwm_init_state(pwm, &ps);
+	pwm_set_relative_duty_cycle(&ps, __effective_dc(mp, dc), MOTPWM_PWM_SCALE);
+	ps.enabled = enable;
+	pwm_apply_might_sleep(pwm, &ps);
+
+	return 0;
+}
+
+static void motpwm_startup(struct motion_device *mdev)
+{
+	dev_info(mdev->dev, "Startup\n");
+}
+
+static void motpwm_powerdown(struct motion_device *mdev)
+{
+	struct motpwm *mp = container_of(mdev, struct motpwm, mdev);
+
+	dev_info(mdev->dev, "Shutdown\n");
+	__motpwm_set_speed_locked(mp, 0, 0, false);
+}
+
+static int motpwm_check_speed(struct motion_device *mdev, unsigned int dir,
+		unsigned int speed)
+{
+	struct motpwm *mp = container_of(mdev, struct motpwm, mdev);
+
+	if (!mp->pwms[!!dir])
+		return -EINVAL;
+
+	if (speed > MOTPWM_PWM_SCALE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void motpwm_set_speed(struct motion_device *mdev, unsigned int dir,
+		unsigned int speed)
+{
+	struct motpwm *mp = container_of(mdev, struct motpwm, mdev);
+
+	__motpwm_set_speed_locked(mp, dir, speed, true);
+}
+
+static struct motion_timed_speed_ops motpwm_mts_ops = {
+	.startup = motpwm_startup,
+	.powerdown = motpwm_powerdown,
+	.check_speed = motpwm_check_speed,
+	.set_speed = motpwm_set_speed
+};
+
+static int motpwm_probe(struct platform_device *pdev)
+{
+	struct motpwm *mp;
+	struct device *dev = &pdev->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+
+	mp = devm_kzalloc(dev, sizeof(struct motpwm), GFP_KERNEL);
+	if (!mp)
+		return -ENOMEM;
+
+	mp->pwms[0] = devm_fwnode_pwm_get(dev, fwnode, "left");
+	if (IS_ERR(mp->pwms[0])) {
+		int err = PTR_ERR(mp->pwms[0]);
+
+		if (err == -ENODEV)
+			mp->pwms[0] = NULL;
+		else
+			return err;
+	}
+	mp->pwms[1] = devm_fwnode_pwm_get(dev, fwnode, "right");
+	if (IS_ERR(mp->pwms[1])) {
+		int err = PTR_ERR(mp->pwms[1]);
+
+		if (err == -ENODEV)
+			mp->pwms[1] = NULL;
+		else
+			return err;
+	}
+	if (!mp->pwms[0] && !mp->pwms[1]) {
+		dev_err(dev, "Need at least one PWM");
+		return -ENODEV;
+	}
+
+	mp->pwm_inverted = fwnode_property_read_bool(fwnode, "motion,pwm-inverted");
+
+	mp->pdev = pdev;
+	platform_set_drvdata(pdev, mp);
+
+	mp->mdev.parent = &pdev->dev;
+	motion_timed_speed_init(&mp->mdev, &motpwm_mts_ops, MOTPWM_PWM_SCALE);
+	mp->mdev.capabilities.type = MOT_TYPE_DC_MOTOR;
+	mp->mdev.capabilities.subdiv = 1;
+	motion_fwnode_get_capabilities(&mp->mdev, fwnode);
+
+	return motion_register_device(&mp->mdev);
+}
+
+static void motpwm_shutdown(struct platform_device *pdev)
+{
+	struct motpwm *mp = platform_get_drvdata(pdev);
+
+	motion_unregister_device(&mp->mdev);
+}
+
+static int motpwm_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int motpwm_resume(struct device *dev)
+{
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(motpwm_pm, motpwm_suspend, motpwm_resume);
+
+static const struct of_device_id motpwm_of_match[] = {
+	{ .compatible = "motion-simple-pwm" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, motpwm_of_match);
+
+static struct platform_driver motpwm_driver = {
+	.probe = motpwm_probe,
+	.shutdown = motpwm_shutdown,
+	.driver = {
+		.name = "motion-simple-pwm",
+		.pm = pm_sleep_ptr(&motpwm_pm),
+		.of_match_table = motpwm_of_match,
+	},
+};
+
+module_platform_driver(motpwm_driver);
+
+MODULE_AUTHOR("David Jander <david@protonic.nl>");
+MODULE_DESCRIPTION("Simple PWM based DC motor motion control driver");
+MODULE_LICENSE("GPL");
-- 
2.47.2


