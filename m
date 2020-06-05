Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACC81EFF16
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jun 2020 19:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgFERdx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Jun 2020 13:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgFERdw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jun 2020 13:33:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB41CC08C5C2;
        Fri,  5 Jun 2020 10:33:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 725872A5072
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 2/7] Input: use input_device_enabled()
Date:   Fri,  5 Jun 2020 19:33:30 +0200
Message-Id: <20200605173335.13753-3-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605173335.13753-1-andrzej.p@collabora.com>
References: <20200604072853.GP89269@dtor-ws>
 <20200605173335.13753-1-andrzej.p@collabora.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the newly added helper in relevant input drivers.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 drivers/input/joystick/xpad.c               |  4 ++--
 drivers/input/keyboard/ep93xx_keypad.c      |  2 +-
 drivers/input/keyboard/gpio_keys.c          |  4 ++--
 drivers/input/keyboard/imx_keypad.c         |  4 ++--
 drivers/input/keyboard/ipaq-micro-keys.c    |  2 +-
 drivers/input/keyboard/lpc32xx-keys.c       |  4 ++--
 drivers/input/keyboard/pmic8xxx-keypad.c    |  4 ++--
 drivers/input/keyboard/pxa27x_keypad.c      |  2 +-
 drivers/input/keyboard/samsung-keypad.c     |  4 ++--
 drivers/input/keyboard/spear-keyboard.c     |  8 ++++----
 drivers/input/keyboard/st-keyscan.c         |  4 ++--
 drivers/input/keyboard/tegra-kbc.c          |  4 ++--
 drivers/input/misc/drv260x.c                |  4 ++--
 drivers/input/misc/drv2665.c                |  4 ++--
 drivers/input/misc/drv2667.c                |  4 ++--
 drivers/input/misc/gp2ap002a00f.c           |  4 ++--
 drivers/input/misc/kxtj9.c                  |  4 ++--
 drivers/input/misc/sirfsoc-onkey.c          |  2 +-
 drivers/input/mouse/navpoint.c              |  4 ++--
 drivers/input/touchscreen/ad7879.c          |  6 +++---
 drivers/input/touchscreen/atmel_mxt_ts.c    |  4 ++--
 drivers/input/touchscreen/auo-pixcir-ts.c   |  8 ++++----
 drivers/input/touchscreen/bu21029_ts.c      |  4 ++--
 drivers/input/touchscreen/chipone_icn8318.c |  4 ++--
 drivers/input/touchscreen/cyttsp_core.c     |  4 ++--
 drivers/input/touchscreen/eeti_ts.c         |  4 ++--
 drivers/input/touchscreen/ektf2127.c        |  4 ++--
 drivers/input/touchscreen/imx6ul_tsc.c      |  4 ++--
 drivers/input/touchscreen/ipaq-micro-ts.c   |  2 +-
 drivers/input/touchscreen/iqs5xx.c          |  4 ++--
 drivers/input/touchscreen/lpc32xx_ts.c      |  4 ++--
 drivers/input/touchscreen/melfas_mip4.c     |  4 ++--
 drivers/input/touchscreen/mms114.c          |  6 +++---
 drivers/input/touchscreen/pixcir_i2c_ts.c   |  8 ++++----
 drivers/input/touchscreen/ucb1400_ts.c      |  4 ++--
 drivers/input/touchscreen/wm97xx-core.c     | 14 +++++++++-----
 drivers/input/touchscreen/zforce_ts.c       |  8 ++++----
 37 files changed, 86 insertions(+), 82 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index c77cdb3b62b5..d8b6bc2d2171 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1902,7 +1902,7 @@ static int xpad_suspend(struct usb_interface *intf, pm_message_t message)
 			xpad360w_poweroff_controller(xpad);
 	} else {
 		mutex_lock(&input->mutex);
-		if (input->users)
+		if (input_device_enabled(input))
 			xpad_stop_input(xpad);
 		mutex_unlock(&input->mutex);
 	}
@@ -1922,7 +1922,7 @@ static int xpad_resume(struct usb_interface *intf)
 		retval = xpad360w_start_input(xpad);
 	} else {
 		mutex_lock(&input->mutex);
-		if (input->users) {
+		if (input_device_enabled(input)) {
 			retval = xpad_start_input(xpad);
 		} else if (xpad->xtype == XTYPE_XBOXONE) {
 			/*
diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index 7c70492d9d6b..8194e843d047 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -208,7 +208,7 @@ static int ep93xx_keypad_resume(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
-	if (input_dev->users) {
+	if (input_device_enabled(input_dev)) {
 		if (!keypad->enabled) {
 			ep93xx_keypad_config(keypad);
 			clk_enable(keypad->clk);
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 53c9ff338dea..03ad27189553 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -966,7 +966,7 @@ static int __maybe_unused gpio_keys_suspend(struct device *dev)
 			return error;
 	} else {
 		mutex_lock(&input->mutex);
-		if (input->users)
+		if (input_device_enabled(input))
 			gpio_keys_close(input);
 		mutex_unlock(&input->mutex);
 	}
@@ -984,7 +984,7 @@ static int __maybe_unused gpio_keys_resume(struct device *dev)
 		gpio_keys_disable_wakeup(ddata);
 	} else {
 		mutex_lock(&input->mutex);
-		if (input->users)
+		if (input_device_enabled(input))
 			error = gpio_keys_open(input);
 		mutex_unlock(&input->mutex);
 	}
diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 5a46d113e909..1f5c9ea5e9e5 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -532,7 +532,7 @@ static int __maybe_unused imx_kbd_noirq_suspend(struct device *dev)
 	/* imx kbd can wake up system even clock is disabled */
 	mutex_lock(&input_dev->mutex);
 
-	if (input_dev->users)
+	if (input_device_enabled(input_dev))
 		clk_disable_unprepare(kbd->clk);
 
 	mutex_unlock(&input_dev->mutex);
@@ -562,7 +562,7 @@ static int __maybe_unused imx_kbd_noirq_resume(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
-	if (input_dev->users) {
+	if (input_device_enabled(input_dev)) {
 		ret = clk_prepare_enable(kbd->clk);
 		if (ret)
 			goto err_clk;
diff --git a/drivers/input/keyboard/ipaq-micro-keys.c b/drivers/input/keyboard/ipaq-micro-keys.c
index e3f9e445e880..13a66a8e3411 100644
--- a/drivers/input/keyboard/ipaq-micro-keys.c
+++ b/drivers/input/keyboard/ipaq-micro-keys.c
@@ -140,7 +140,7 @@ static int __maybe_unused micro_key_resume(struct device *dev)
 
 	mutex_lock(&input->mutex);
 
-	if (input->users)
+	if (input_device_enabled(input))
 		micro_key_start(keys);
 
 	mutex_unlock(&input->mutex);
diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
index 348af2aeb5de..943aeeb0de79 100644
--- a/drivers/input/keyboard/lpc32xx-keys.c
+++ b/drivers/input/keyboard/lpc32xx-keys.c
@@ -273,7 +273,7 @@ static int lpc32xx_kscan_suspend(struct device *dev)
 
 	mutex_lock(&input->mutex);
 
-	if (input->users) {
+	if (input_device_enabled(input)) {
 		/* Clear IRQ and disable clock */
 		writel(1, LPC32XX_KS_IRQ(kscandat->kscan_base));
 		clk_disable_unprepare(kscandat->clk);
@@ -292,7 +292,7 @@ static int lpc32xx_kscan_resume(struct device *dev)
 
 	mutex_lock(&input->mutex);
 
-	if (input->users) {
+	if (input_device_enabled(input)) {
 		/* Enable clock and clear IRQ */
 		retval = clk_prepare_enable(kscandat->clk);
 		if (retval == 0)
diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
index 91d5811d6f0e..43b4533e7c41 100644
--- a/drivers/input/keyboard/pmic8xxx-keypad.c
+++ b/drivers/input/keyboard/pmic8xxx-keypad.c
@@ -633,7 +633,7 @@ static int pmic8xxx_kp_suspend(struct device *dev)
 	} else {
 		mutex_lock(&input_dev->mutex);
 
-		if (input_dev->users)
+		if (input_device_enabled(input_dev))
 			pmic8xxx_kp_disable(kp);
 
 		mutex_unlock(&input_dev->mutex);
@@ -653,7 +653,7 @@ static int pmic8xxx_kp_resume(struct device *dev)
 	} else {
 		mutex_lock(&input_dev->mutex);
 
-		if (input_dev->users)
+		if (input_device_enabled(input_dev))
 			pmic8xxx_kp_enable(kp);
 
 		mutex_unlock(&input_dev->mutex);
diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 7e65708b25a4..a7f8257c8a02 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -694,7 +694,7 @@ static int pxa27x_keypad_resume(struct device *dev)
 	} else {
 		mutex_lock(&input_dev->mutex);
 
-		if (input_dev->users) {
+		if (input_device_enabled(input_dev)) {
 			/* Enable unit clock */
 			ret = clk_prepare_enable(keypad->clk);
 			if (!ret)
diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 70c1d086bdd2..74ec068fbf2f 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -537,7 +537,7 @@ static int samsung_keypad_suspend(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
-	if (input_dev->users)
+	if (input_device_enabled(input_dev))
 		samsung_keypad_stop(keypad);
 
 	samsung_keypad_toggle_wakeup(keypad, true);
@@ -557,7 +557,7 @@ static int samsung_keypad_resume(struct device *dev)
 
 	samsung_keypad_toggle_wakeup(keypad, false);
 
-	if (input_dev->users)
+	if (input_device_enabled(input_dev))
 		samsung_keypad_start(keypad);
 
 	mutex_unlock(&input_dev->mutex);
diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 9b8d78f87253..9838c79cb288 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -318,7 +318,7 @@ static int __maybe_unused spear_kbd_suspend(struct device *dev)
 		writel_relaxed(val, kbd->io_base + MODE_CTL_REG);
 
 	} else {
-		if (input_dev->users) {
+		if (input_device_enabled(input_dev)) {
 			writel_relaxed(mode_ctl_reg & ~MODE_CTL_START_SCAN,
 					kbd->io_base + MODE_CTL_REG);
 			clk_disable(kbd->clk);
@@ -326,7 +326,7 @@ static int __maybe_unused spear_kbd_suspend(struct device *dev)
 	}
 
 	/* store current configuration */
-	if (input_dev->users)
+	if (input_device_enabled(input_dev))
 		kbd->mode_ctl_reg = mode_ctl_reg;
 
 	/* restore previous clk state */
@@ -351,12 +351,12 @@ static int __maybe_unused spear_kbd_resume(struct device *dev)
 			disable_irq_wake(kbd->irq);
 		}
 	} else {
-		if (input_dev->users)
+		if (input_device_enabled(input_dev))
 			clk_enable(kbd->clk);
 	}
 
 	/* restore current configuration */
-	if (input_dev->users)
+	if (input_device_enabled(input_dev))
 		writel_relaxed(kbd->mode_ctl_reg, kbd->io_base + MODE_CTL_REG);
 
 	mutex_unlock(&input_dev->mutex);
diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
index 27562cd67fb6..a045d61165ac 100644
--- a/drivers/input/keyboard/st-keyscan.c
+++ b/drivers/input/keyboard/st-keyscan.c
@@ -221,7 +221,7 @@ static int keyscan_suspend(struct device *dev)
 
 	if (device_may_wakeup(dev))
 		enable_irq_wake(keypad->irq);
-	else if (input->users)
+	else if (input_device_enabled(input))
 		keyscan_stop(keypad);
 
 	mutex_unlock(&input->mutex);
@@ -239,7 +239,7 @@ static int keyscan_resume(struct device *dev)
 
 	if (device_may_wakeup(dev))
 		disable_irq_wake(keypad->irq);
-	else if (input->users)
+	else if (input_device_enabled(input))
 		retval = keyscan_start(keypad);
 
 	mutex_unlock(&input->mutex);
diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index d34d6947960f..9671842a082a 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -756,7 +756,7 @@ static int tegra_kbc_suspend(struct device *dev)
 		enable_irq(kbc->irq);
 		enable_irq_wake(kbc->irq);
 	} else {
-		if (kbc->idev->users)
+		if (input_device_enabled(kbc->idev))
 			tegra_kbc_stop(kbc);
 	}
 	mutex_unlock(&kbc->idev->mutex);
@@ -796,7 +796,7 @@ static int tegra_kbc_resume(struct device *dev)
 			input_sync(kbc->idev);
 		}
 	} else {
-		if (kbc->idev->users)
+		if (input_device_enabled(kbc->idev))
 			err = tegra_kbc_start(kbc);
 	}
 	mutex_unlock(&kbc->idev->mutex);
diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 79d7fa710a71..11c1983e286a 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -580,7 +580,7 @@ static int __maybe_unused drv260x_suspend(struct device *dev)
 
 	mutex_lock(&haptics->input_dev->mutex);
 
-	if (haptics->input_dev->users) {
+	if (input_device_enabled(haptics->input_dev)) {
 		ret = regmap_update_bits(haptics->regmap,
 					 DRV260X_MODE,
 					 DRV260X_STANDBY_MASK,
@@ -612,7 +612,7 @@ static int __maybe_unused drv260x_resume(struct device *dev)
 
 	mutex_lock(&haptics->input_dev->mutex);
 
-	if (haptics->input_dev->users) {
+	if (input_device_enabled(haptics->input_dev)) {
 		ret = regulator_enable(haptics->regulator);
 		if (ret) {
 			dev_err(dev, "Failed to enable regulator\n");
diff --git a/drivers/input/misc/drv2665.c b/drivers/input/misc/drv2665.c
index 918ad9c3fa81..e4df1a3b8655 100644
--- a/drivers/input/misc/drv2665.c
+++ b/drivers/input/misc/drv2665.c
@@ -230,7 +230,7 @@ static int __maybe_unused drv2665_suspend(struct device *dev)
 
 	mutex_lock(&haptics->input_dev->mutex);
 
-	if (haptics->input_dev->users) {
+	if (input_device_enabled(haptics->input_dev)) {
 		ret = regmap_update_bits(haptics->regmap, DRV2665_CTRL_2,
 					 DRV2665_STANDBY, DRV2665_STANDBY);
 		if (ret) {
@@ -259,7 +259,7 @@ static int __maybe_unused drv2665_resume(struct device *dev)
 
 	mutex_lock(&haptics->input_dev->mutex);
 
-	if (haptics->input_dev->users) {
+	if (input_device_enabled(haptics->input_dev)) {
 		ret = regulator_enable(haptics->regulator);
 		if (ret) {
 			dev_err(dev, "Failed to enable regulator\n");
diff --git a/drivers/input/misc/drv2667.c b/drivers/input/misc/drv2667.c
index bb9d5784df17..be4be2e0fd6f 100644
--- a/drivers/input/misc/drv2667.c
+++ b/drivers/input/misc/drv2667.c
@@ -405,7 +405,7 @@ static int __maybe_unused drv2667_suspend(struct device *dev)
 
 	mutex_lock(&haptics->input_dev->mutex);
 
-	if (haptics->input_dev->users) {
+	if (input_device_enabled(haptics->input_dev)) {
 		ret = regmap_update_bits(haptics->regmap, DRV2667_CTRL_2,
 					 DRV2667_STANDBY, DRV2667_STANDBY);
 		if (ret) {
@@ -434,7 +434,7 @@ static int __maybe_unused drv2667_resume(struct device *dev)
 
 	mutex_lock(&haptics->input_dev->mutex);
 
-	if (haptics->input_dev->users) {
+	if (input_device_enabled(haptics->input_dev)) {
 		ret = regulator_enable(haptics->regulator);
 		if (ret) {
 			dev_err(dev, "Failed to enable regulator\n");
diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
index 90abda8eea67..5f61ef90b2f2 100644
--- a/drivers/input/misc/gp2ap002a00f.c
+++ b/drivers/input/misc/gp2ap002a00f.c
@@ -230,7 +230,7 @@ static int __maybe_unused gp2a_suspend(struct device *dev)
 		enable_irq_wake(client->irq);
 	} else {
 		mutex_lock(&dt->input->mutex);
-		if (dt->input->users)
+		if (input_device_enabled(dt->input))
 			retval = gp2a_disable(dt);
 		mutex_unlock(&dt->input->mutex);
 	}
@@ -248,7 +248,7 @@ static int __maybe_unused gp2a_resume(struct device *dev)
 		disable_irq_wake(client->irq);
 	} else {
 		mutex_lock(&dt->input->mutex);
-		if (dt->input->users)
+		if (input_device_enabled(dt->input))
 			retval = gp2a_enable(dt);
 		mutex_unlock(&dt->input->mutex);
 	}
diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index 52313c6e3fb3..bbb81617c2b2 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -503,7 +503,7 @@ static int __maybe_unused kxtj9_suspend(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
-	if (input_dev->users)
+	if (input_device_enabled(input_dev))
 		kxtj9_disable(tj9);
 
 	mutex_unlock(&input_dev->mutex);
@@ -518,7 +518,7 @@ static int __maybe_unused kxtj9_resume(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
-	if (input_dev->users)
+	if (input_device_enabled(input_dev))
 		kxtj9_enable(tj9);
 
 	mutex_unlock(&input_dev->mutex);
diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index 60e1f31ee60a..7982bf8fb839 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -181,7 +181,7 @@ static int __maybe_unused sirfsoc_pwrc_resume(struct device *dev)
 	 * if users touch X_ONKEY_B, see arch/arm/mach-prima2/pm.c
 	 */
 	mutex_lock(&input->mutex);
-	if (input->users)
+	if (input_device_enabled(input))
 		sirfsoc_pwrc_toggle_interrupts(pwrcdrv, true);
 	mutex_unlock(&input->mutex);
 
diff --git a/drivers/input/mouse/navpoint.c b/drivers/input/mouse/navpoint.c
index 0b75248c8380..643d4b805b64 100644
--- a/drivers/input/mouse/navpoint.c
+++ b/drivers/input/mouse/navpoint.c
@@ -322,7 +322,7 @@ static int __maybe_unused navpoint_suspend(struct device *dev)
 	struct input_dev *input = navpoint->input;
 
 	mutex_lock(&input->mutex);
-	if (input->users)
+	if (input_device_enabled(input))
 		navpoint_down(navpoint);
 	mutex_unlock(&input->mutex);
 
@@ -336,7 +336,7 @@ static int __maybe_unused navpoint_resume(struct device *dev)
 	struct input_dev *input = navpoint->input;
 
 	mutex_lock(&input->mutex);
-	if (input->users)
+	if (input_device_enabled(input))
 		navpoint_up(navpoint);
 	mutex_unlock(&input->mutex);
 
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 556a2af46e18..e850853328f1 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -306,7 +306,7 @@ static int __maybe_unused ad7879_suspend(struct device *dev)
 
 	mutex_lock(&ts->input->mutex);
 
-	if (!ts->suspended && !ts->disabled && ts->input->users)
+	if (!ts->suspended && !ts->disabled && input_device_enabled(ts->input))
 		__ad7879_disable(ts);
 
 	ts->suspended = true;
@@ -322,7 +322,7 @@ static int __maybe_unused ad7879_resume(struct device *dev)
 
 	mutex_lock(&ts->input->mutex);
 
-	if (ts->suspended && !ts->disabled && ts->input->users)
+	if (ts->suspended && !ts->disabled && input_device_enabled(ts->input))
 		__ad7879_enable(ts);
 
 	ts->suspended = false;
@@ -339,7 +339,7 @@ static void ad7879_toggle(struct ad7879 *ts, bool disable)
 {
 	mutex_lock(&ts->input->mutex);
 
-	if (!ts->suspended && ts->input->users != 0) {
+	if (!ts->suspended && input_device_enabled(ts->input)) {
 
 		if (disable) {
 			if (ts->disabled)
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index ae60442efda0..47b7936bc3e3 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3151,7 +3151,7 @@ static int __maybe_unused mxt_suspend(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
-	if (input_dev->users)
+	if (input_device_enabled(input_dev))
 		mxt_stop(data);
 
 	mutex_unlock(&input_dev->mutex);
@@ -3174,7 +3174,7 @@ static int __maybe_unused mxt_resume(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
-	if (input_dev->users)
+	if (input_device_enabled(input_dev))
 		mxt_start(data);
 
 	mutex_unlock(&input_dev->mutex);
diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index 8e9f3b7b8180..c33e63ca6142 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -414,7 +414,7 @@ static int __maybe_unused auo_pixcir_suspend(struct device *dev)
 	 */
 	if (device_may_wakeup(&client->dev)) {
 		/* need to start device if not open, to be wakeup source */
-		if (!input->users) {
+		if (!input_device_enabled(input)) {
 			ret = auo_pixcir_start(ts);
 			if (ret)
 				goto unlock;
@@ -422,7 +422,7 @@ static int __maybe_unused auo_pixcir_suspend(struct device *dev)
 
 		enable_irq_wake(client->irq);
 		ret = auo_pixcir_power_mode(ts, AUO_PIXCIR_POWER_SLEEP);
-	} else if (input->users) {
+	} else if (input_device_enabled(input)) {
 		ret = auo_pixcir_stop(ts);
 	}
 
@@ -445,14 +445,14 @@ static int __maybe_unused auo_pixcir_resume(struct device *dev)
 		disable_irq_wake(client->irq);
 
 		/* need to stop device if it was not open on suspend */
-		if (!input->users) {
+		if (!input_device_enabled(input)) {
 			ret = auo_pixcir_stop(ts);
 			if (ret)
 				goto unlock;
 		}
 
 		/* device wakes automatically from SLEEP */
-	} else if (input->users) {
+	} else if (input_device_enabled(input)) {
 		ret = auo_pixcir_start(ts);
 	}
 
diff --git a/drivers/input/touchscreen/bu21029_ts.c b/drivers/input/touchscreen/bu21029_ts.c
index 49a8d4bbca3a..341925edb8e6 100644
--- a/drivers/input/touchscreen/bu21029_ts.c
+++ b/drivers/input/touchscreen/bu21029_ts.c
@@ -430,7 +430,7 @@ static int __maybe_unused bu21029_suspend(struct device *dev)
 
 	if (!device_may_wakeup(dev)) {
 		mutex_lock(&bu21029->in_dev->mutex);
-		if (bu21029->in_dev->users)
+		if (input_device_enabled(bu21029->in_dev))
 			bu21029_stop_chip(bu21029->in_dev);
 		mutex_unlock(&bu21029->in_dev->mutex);
 	}
@@ -445,7 +445,7 @@ static int __maybe_unused bu21029_resume(struct device *dev)
 
 	if (!device_may_wakeup(dev)) {
 		mutex_lock(&bu21029->in_dev->mutex);
-		if (bu21029->in_dev->users)
+		if (input_device_enabled(bu21029->in_dev))
 			bu21029_start_chip(bu21029->in_dev);
 		mutex_unlock(&bu21029->in_dev->mutex);
 	}
diff --git a/drivers/input/touchscreen/chipone_icn8318.c b/drivers/input/touchscreen/chipone_icn8318.c
index d91d2fd78649..f2fb41fb031e 100644
--- a/drivers/input/touchscreen/chipone_icn8318.c
+++ b/drivers/input/touchscreen/chipone_icn8318.c
@@ -154,7 +154,7 @@ static int icn8318_suspend(struct device *dev)
 	struct icn8318_data *data = i2c_get_clientdata(to_i2c_client(dev));
 
 	mutex_lock(&data->input->mutex);
-	if (data->input->users)
+	if (input_device_enabled(data->input))
 		icn8318_stop(data->input);
 	mutex_unlock(&data->input->mutex);
 
@@ -166,7 +166,7 @@ static int icn8318_resume(struct device *dev)
 	struct icn8318_data *data = i2c_get_clientdata(to_i2c_client(dev));
 
 	mutex_lock(&data->input->mutex);
-	if (data->input->users)
+	if (input_device_enabled(data->input))
 		icn8318_start(data->input);
 	mutex_unlock(&data->input->mutex);
 
diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index 3f5d463dbeed..6e49cb80ec6d 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -479,7 +479,7 @@ static int __maybe_unused cyttsp_suspend(struct device *dev)
 
 	mutex_lock(&ts->input->mutex);
 
-	if (ts->input->users) {
+	if (input_device_enabled(ts->input)) {
 		retval = cyttsp_disable(ts);
 		if (retval == 0)
 			ts->suspended = true;
@@ -496,7 +496,7 @@ static int __maybe_unused cyttsp_resume(struct device *dev)
 
 	mutex_lock(&ts->input->mutex);
 
-	if (ts->input->users)
+	if (input_device_enabled(ts->input))
 		cyttsp_enable(ts);
 
 	ts->suspended = false;
diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 2e1404cd09ec..a639ba7e56ea 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -241,7 +241,7 @@ static int __maybe_unused eeti_ts_suspend(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
-	if (input_dev->users)
+	if (input_device_enabled(input_dev))
 		eeti_ts_stop(eeti);
 
 	mutex_unlock(&input_dev->mutex);
@@ -263,7 +263,7 @@ static int __maybe_unused eeti_ts_resume(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
-	if (input_dev->users)
+	if (input_device_enabled(input_dev))
 		eeti_ts_start(eeti);
 
 	mutex_unlock(&input_dev->mutex);
diff --git a/drivers/input/touchscreen/ektf2127.c b/drivers/input/touchscreen/ektf2127.c
index eadd389cf81f..263bbeb6cee9 100644
--- a/drivers/input/touchscreen/ektf2127.c
+++ b/drivers/input/touchscreen/ektf2127.c
@@ -154,7 +154,7 @@ static int __maybe_unused ektf2127_suspend(struct device *dev)
 	struct ektf2127_ts *ts = i2c_get_clientdata(to_i2c_client(dev));
 
 	mutex_lock(&ts->input->mutex);
-	if (ts->input->users)
+	if (input_device_enabled(ts->input))
 		ektf2127_stop(ts->input);
 	mutex_unlock(&ts->input->mutex);
 
@@ -166,7 +166,7 @@ static int __maybe_unused ektf2127_resume(struct device *dev)
 	struct ektf2127_ts *ts = i2c_get_clientdata(to_i2c_client(dev));
 
 	mutex_lock(&ts->input->mutex);
-	if (ts->input->users)
+	if (input_device_enabled(ts->input))
 		ektf2127_start(ts->input);
 	mutex_unlock(&ts->input->mutex);
 
diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index 9ed258854349..59d4a4e9ecc2 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -509,7 +509,7 @@ static int __maybe_unused imx6ul_tsc_suspend(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
-	if (input_dev->users) {
+	if (input_device_enabled(input_dev)) {
 		imx6ul_tsc_disable(tsc);
 
 		clk_disable_unprepare(tsc->tsc_clk);
@@ -530,7 +530,7 @@ static int __maybe_unused imx6ul_tsc_resume(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 
-	if (input_dev->users) {
+	if (input_device_enabled(input_dev)) {
 		retval = clk_prepare_enable(tsc->adc_clk);
 		if (retval)
 			goto out;
diff --git a/drivers/input/touchscreen/ipaq-micro-ts.c b/drivers/input/touchscreen/ipaq-micro-ts.c
index 5c3977e1af6f..0eb5689fe65f 100644
--- a/drivers/input/touchscreen/ipaq-micro-ts.c
+++ b/drivers/input/touchscreen/ipaq-micro-ts.c
@@ -135,7 +135,7 @@ static int __maybe_unused micro_ts_resume(struct device *dev)
 
 	mutex_lock(&input->mutex);
 
-	if (input->users)
+	if (input_device_enabled(input))
 		micro_ts_toggle_receive(ts, true);
 
 	mutex_unlock(&input->mutex);
diff --git a/drivers/input/touchscreen/iqs5xx.c b/drivers/input/touchscreen/iqs5xx.c
index 5875bb1099a8..8b7b94ef7f39 100644
--- a/drivers/input/touchscreen/iqs5xx.c
+++ b/drivers/input/touchscreen/iqs5xx.c
@@ -1017,7 +1017,7 @@ static int __maybe_unused iqs5xx_suspend(struct device *dev)
 
 	mutex_lock(&input->mutex);
 
-	if (input->users)
+	if (input_device_enabled(input))
 		error = iqs5xx_set_state(iqs5xx->client, IQS5XX_SUSPEND);
 
 	mutex_unlock(&input->mutex);
@@ -1036,7 +1036,7 @@ static int __maybe_unused iqs5xx_resume(struct device *dev)
 
 	mutex_lock(&input->mutex);
 
-	if (input->users)
+	if (input_device_enabled(input))
 		error = iqs5xx_set_state(iqs5xx->client, IQS5XX_RESUME);
 
 	mutex_unlock(&input->mutex);
diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchscreen/lpc32xx_ts.c
index b2cd9472e2d1..b51450b3d943 100644
--- a/drivers/input/touchscreen/lpc32xx_ts.c
+++ b/drivers/input/touchscreen/lpc32xx_ts.c
@@ -334,7 +334,7 @@ static int lpc32xx_ts_suspend(struct device *dev)
 	 */
 	mutex_lock(&input->mutex);
 
-	if (input->users) {
+	if (input_device_enabled(input)) {
 		if (device_may_wakeup(dev))
 			enable_irq_wake(tsc->irq);
 		else
@@ -353,7 +353,7 @@ static int lpc32xx_ts_resume(struct device *dev)
 
 	mutex_lock(&input->mutex);
 
-	if (input->users) {
+	if (input_device_enabled(input)) {
 		if (device_may_wakeup(dev))
 			disable_irq_wake(tsc->irq);
 		else
diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
index 247c3aaba2d8..d33586919f58 100644
--- a/drivers/input/touchscreen/melfas_mip4.c
+++ b/drivers/input/touchscreen/melfas_mip4.c
@@ -1539,7 +1539,7 @@ static int __maybe_unused mip4_suspend(struct device *dev)
 
 	if (device_may_wakeup(dev))
 		ts->wake_irq_enabled = enable_irq_wake(client->irq) == 0;
-	else if (input->users)
+	else if (input_device_enabled(input))
 		mip4_disable(ts);
 
 	mutex_unlock(&input->mutex);
@@ -1557,7 +1557,7 @@ static int __maybe_unused mip4_resume(struct device *dev)
 
 	if (ts->wake_irq_enabled)
 		disable_irq_wake(client->irq);
-	else if (input->users)
+	else if (input_device_enabled(input))
 		mip4_enable(ts);
 
 	mutex_unlock(&input->mutex);
diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 2ef1adaed9af..a87caa51204e 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -198,7 +198,7 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 	int error;
 
 	mutex_lock(&input_dev->mutex);
-	if (!input_dev->users) {
+	if (!input_device_enabled(input_dev)) {
 		mutex_unlock(&input_dev->mutex);
 		goto out;
 	}
@@ -554,7 +554,7 @@ static int __maybe_unused mms114_suspend(struct device *dev)
 	input_sync(input_dev);
 
 	mutex_lock(&input_dev->mutex);
-	if (input_dev->users)
+	if (input_device_enabled(input_dev))
 		mms114_stop(data);
 	mutex_unlock(&input_dev->mutex);
 
@@ -569,7 +569,7 @@ static int __maybe_unused mms114_resume(struct device *dev)
 	int error;
 
 	mutex_lock(&input_dev->mutex);
-	if (input_dev->users) {
+	if (input_device_enabled(input_dev)) {
 		error = mms114_start(data);
 		if (error < 0) {
 			mutex_unlock(&input_dev->mutex);
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 9aa098577350..dc148b4bed74 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -415,14 +415,14 @@ static int __maybe_unused pixcir_i2c_ts_suspend(struct device *dev)
 	mutex_lock(&input->mutex);
 
 	if (device_may_wakeup(&client->dev)) {
-		if (!input->users) {
+		if (!input_device_enabled(input)) {
 			ret = pixcir_start(ts);
 			if (ret) {
 				dev_err(dev, "Failed to start\n");
 				goto unlock;
 			}
 		}
-	} else if (input->users) {
+	} else if (input_device_enabled(input)) {
 		ret = pixcir_stop(ts);
 	}
 
@@ -442,14 +442,14 @@ static int __maybe_unused pixcir_i2c_ts_resume(struct device *dev)
 	mutex_lock(&input->mutex);
 
 	if (device_may_wakeup(&client->dev)) {
-		if (!input->users) {
+		if (!input_device_enabled(input)) {
 			ret = pixcir_stop(ts);
 			if (ret) {
 				dev_err(dev, "Failed to stop\n");
 				goto unlock;
 			}
 		}
-	} else if (input->users) {
+	} else if (input_device_enabled(input)) {
 		ret = pixcir_start(ts);
 	}
 
diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index 807d39e18091..e3f2c940ef3d 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -410,7 +410,7 @@ static int __maybe_unused ucb1400_ts_suspend(struct device *dev)
 
 	mutex_lock(&idev->mutex);
 
-	if (idev->users)
+	if (input_device_enabled(idev))
 		ucb1400_ts_stop(ucb);
 
 	mutex_unlock(&idev->mutex);
@@ -424,7 +424,7 @@ static int __maybe_unused ucb1400_ts_resume(struct device *dev)
 
 	mutex_lock(&idev->mutex);
 
-	if (idev->users)
+	if (input_device_enabled(idev))
 		ucb1400_ts_start(ucb);
 
 	mutex_unlock(&idev->mutex);
diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index 0a174bd82915..2c2f1b6c5eff 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -806,23 +806,25 @@ static int __maybe_unused wm97xx_suspend(struct device *dev)
 	else
 		suspend_mode = 0;
 
-	if (wm->input_dev->users)
+	mutex_lock(&wm->input_dev->mutex);
+	if (input_device_enabled(wm->input_dev))
 		cancel_delayed_work_sync(&wm->ts_reader);
 
 	/* Power down the digitiser (bypassing the cache for resume) */
 	reg = wm97xx_reg_read(wm, AC97_WM97XX_DIGITISER2);
 	reg &= ~WM97XX_PRP_DET_DIG;
-	if (wm->input_dev->users)
+	if (input_device_enabled(wm->input_dev))
 		reg |= suspend_mode;
 	wm->ac97->bus->ops->write(wm->ac97, AC97_WM97XX_DIGITISER2, reg);
 
 	/* WM9713 has an additional power bit - turn it off if there
 	 * are no users or if suspend mode is zero. */
 	if (wm->id == WM9713_ID2 &&
-	    (!wm->input_dev->users || !suspend_mode)) {
+	    (!input_device_enabled(wm->input_dev) || !suspend_mode)) {
 		reg = wm97xx_reg_read(wm, AC97_EXTENDED_MID) | 0x8000;
 		wm97xx_reg_write(wm, AC97_EXTENDED_MID, reg);
 	}
+	mutex_unlock(&wm->input_dev->mutex);
 
 	return 0;
 }
@@ -831,11 +833,12 @@ static int __maybe_unused wm97xx_resume(struct device *dev)
 {
 	struct wm97xx *wm = dev_get_drvdata(dev);
 
+	mutex_lock(&wm->input_dev->mutex);
 	/* restore digitiser and gpios */
 	if (wm->id == WM9713_ID2) {
 		wm97xx_reg_write(wm, AC97_WM9713_DIG1, wm->dig[0]);
 		wm97xx_reg_write(wm, 0x5a, wm->misc);
-		if (wm->input_dev->users) {
+		if (input_device_enabled(wm->input_dev)) {
 			u16 reg;
 			reg = wm97xx_reg_read(wm, AC97_EXTENDED_MID) & 0x7fff;
 			wm97xx_reg_write(wm, AC97_EXTENDED_MID, reg);
@@ -852,11 +855,12 @@ static int __maybe_unused wm97xx_resume(struct device *dev)
 	wm97xx_reg_write(wm, AC97_GPIO_STATUS, wm->gpio[4]);
 	wm97xx_reg_write(wm, AC97_MISC_AFE, wm->gpio[5]);
 
-	if (wm->input_dev->users && !wm->pen_irq) {
+	if (input_device_enabled(wm->input_dev) && !wm->pen_irq) {
 		wm->ts_reader_interval = wm->ts_reader_min_interval;
 		queue_delayed_work(wm->ts_workq, &wm->ts_reader,
 				   wm->ts_reader_interval);
 	}
+	mutex_unlock(&wm->input_dev->mutex);
 
 	return 0;
 }
diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index 5230519b0f74..495629628af6 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -626,14 +626,14 @@ static int __maybe_unused zforce_suspend(struct device *dev)
 		dev_dbg(&client->dev, "suspend while being a wakeup source\n");
 
 		/* Need to start device, if not open, to be a wakeup source. */
-		if (!input->users) {
+		if (!input_device_enabled(input)) {
 			ret = zforce_start(ts);
 			if (ret)
 				goto unlock;
 		}
 
 		enable_irq_wake(client->irq);
-	} else if (input->users) {
+	} else if (input_device_enabled(input)) {
 		dev_dbg(&client->dev,
 			"suspend without being a wakeup source\n");
 
@@ -670,12 +670,12 @@ static int __maybe_unused zforce_resume(struct device *dev)
 		disable_irq_wake(client->irq);
 
 		/* need to stop device if it was not open on suspend */
-		if (!input->users) {
+		if (!input_device_enabled(input)) {
 			ret = zforce_stop(ts);
 			if (ret)
 				goto unlock;
 		}
-	} else if (input->users) {
+	} else if (input_device_enabled(input)) {
 		dev_dbg(&client->dev, "resume without being a wakeup source\n");
 
 		enable_irq(client->irq);
-- 
2.17.1

