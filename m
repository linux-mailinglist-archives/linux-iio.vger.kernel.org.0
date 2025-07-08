Return-Path: <linux-iio+bounces-21451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9C2AFDB9C
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 01:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A8F3B27E0
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jul 2025 23:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F76B230997;
	Tue,  8 Jul 2025 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D/HcpYGS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A690522CBD3;
	Tue,  8 Jul 2025 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016317; cv=none; b=Sz2mS7DTsemNL7+4ndegMye3Jqeu5lGWRT3Kq1lxF1uXk3OGHiS4NDAkyAQB/PDiEfOlq6CR5b0ZZKYg4JI9opySfuunJORGxD91+PkurGwJpoZDKfnZOjngFJ5+Hqe1Oiz7mSRjVmW7jQGCw4kvaSAzMU6fUUW9i+qjD5DvckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016317; c=relaxed/simple;
	bh=tpX+MF7VNylgYbHYkQWk2GTeGRybgZToOXusgNNIBP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o2dEM+KHxysS8OWUa1yVNe6T8u0nHT86wriNByUG5zZbDG/daSVI6kNxh+UwocpQSxVkc2Apkl4ej7aaTSXDfj9Z56OrhvEG24uhfQvfNeKLMYhQYj2Eti/TY+4V9Ia6gn3mYhxQQM+d1sturHMpuOMxHk/X6jbMwBds1WBdYzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D/HcpYGS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752016315; x=1783552315;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tpX+MF7VNylgYbHYkQWk2GTeGRybgZToOXusgNNIBP0=;
  b=D/HcpYGSv8AaPSpY4UKlbyaBmuEyAJf4p8popwVpOrxi8KQe+VZm/1sA
   q4pgDJO0hD9NUS3h6jdxl5pZLdwUy7+OdFT8rcR1I9y6Ro/b38oKNNHRQ
   g/swpRthRf+4S4p3EA4cRaM1gH/ALnK7/DiV921iwPvNwL8gf1GloTLvD
   j+Ve/ES7gpoY629cUk8lt7kVU160XGlhcpEXugmKwf0E4IkXNk/lpebkQ
   iXlNXTQO3fGujZEQ6L6y1FWTadnobKb0/vWSkTSNMqp5Ez/9ZXzAky274
   3LewZX39ZCeQoI80WUBcDvs4uzUFG2ByDYN3xJ9nqTrJDJnEmJeyGqV1p
   A==;
X-CSE-ConnectionGUID: h9TsNNoWRUCPRMN8xKoUgA==
X-CSE-MsgGUID: EciIRsuxR5KTLosINSsO3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53986819"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="53986819"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:11:53 -0700
X-CSE-ConnectionGUID: 1Qh807BySjCWQHlEyoHvRw==
X-CSE-MsgGUID: 5edmlpERSlemHDL2z4fPJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="186622600"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.102])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 16:11:48 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 2971511FB58;
	Wed,  9 Jul 2025 02:11:45 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uZHTV-0044eE-0N;
	Wed, 09 Jul 2025 02:11:45 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Haibo Chen <haibo.chen@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Gerald Loacker <gerald.loacker@wolfvision.net>,
	Andreas Klinger <ak@it-klinger.de>,
	Crt Mori <cmo@melexis.com>,
	Waqar Hameed <waqar.hameed@axis.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Bo Liu <liubo03@inspur.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sean Nyekjaer <sean@geanix.com>,
	Frank Li <Frank.Li@nxp.com>,
	Han Xu <han.xu@nxp.com>,
	Rayyan Ansari <rayyan@ansari.sh>,
	Gustavo Vaz <gustavo.vaz@usp.br>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Alexandru Ardelean <aardelean@baylibre.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	chuguangqing <chuguangqing@inspur.com>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	David Laight <david.laight@aculab.com>,
	Jakob Hauser <jahau@rocketmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2 00/12] iio: Remove redundant pm_runtime_mark_last_busy() calls
Date: Wed,  9 Jul 2025 02:11:44 +0300
Message-Id: <20250708231144.971170-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

Late last year I posted a set to switch to __pm_runtime_mark_last_busy()
and gradually get rid of explicit pm_runtime_mark_last_busy() calls in
drivers, embedding them in the appropriate pm_runtime_*autosuspend*()
calls. The overall feedback I got at the time was that this is an
unnecessary intermediate step, and removing the
pm_runtime_mark_last_busy() calls can be done after adding them to the
relevant Runtime PM autosuspend related functions. The latter part has
been done and is present in Rafael's tree at the moment, also see
<URL:https://lore.kernel.org/linux-pm/CAJZ5v0g7-8UWp6ATOy+=oGdxDaCnfKHBG_+kbiTr+VeuXZsUFQ@mail.gmail.com/>:

	git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
		pm-runtime-6.17-rc1

So before merging these, please pull Rafael's tag. My thinking is indeed
these would be best merged via the respective trees as there's some
potential for conflicts (there are around 920 call sites modified here).

These patches are on next-20250701.

since v1:

- Drop unneeded braces.

- Further rework call sites that simply assigned a local variable (ret) to
  return it, by removing that local variable and the redundant else
  clause.

The diff from v1 (<20250704075225.3212486-1-sakari.ailus@linux.intel.com>)
for iio patches is:

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index f45beae83f8b..fe1783d439de 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -332,11 +332,10 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
-	if (on) {
+	if (on)
 		ret = pm_runtime_resume_and_get(dev);
-	} else {
+	else
 		ret = pm_runtime_put_autosuspend(dev);
-	}
 
 	if (ret < 0) {
 		dev_err(dev,
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 44d770729186..2823ddde4bf2 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -636,9 +636,8 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 
 	if (on)
 		ret = pm_runtime_resume_and_get(&data->client->dev);
-	else {
+	else
 		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	}
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"Failed: %s for %d\n", __func__, on);
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 5863478bab62..393294df02db 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -224,11 +224,10 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
 #ifdef CONFIG_PM
 	int ret;
 
-	if (on) {
+	if (on)
 		ret = pm_runtime_resume_and_get(&client->dev);
-	} else {
+	else
 		ret = pm_runtime_put_autosuspend(&client->dev);
-	}
 
 	if (ret < 0) {
 		dev_err(&client->dev,
diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
index 22768f43fd24..247c2eda8420 100644
--- a/drivers/iio/accel/mma9551_core.c
+++ b/drivers/iio/accel/mma9551_core.c
@@ -671,9 +671,8 @@ int mma9551_set_power_state(struct i2c_client *client, bool on)
 
 	if (on)
 		ret = pm_runtime_resume_and_get(&client->dev);
-	else {
+	else
 		ret = pm_runtime_put_autosuspend(&client->dev);
-	}
 
 	if (ret < 0) {
 		dev_err(&client->dev,
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 67846fefe21a..b4c36e6a7490 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1140,9 +1140,8 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 
 	at91_adc_configure_trigger_registers(st, state);
 
-	if (!state) {
+	if (!state)
 		pm_runtime_put_autosuspend(st->dev);
-	}
 
 	return 0;
 }
diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index 467c6a9213ab..3a17b3898bf6 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -163,11 +163,10 @@ static int rcar_gyroadc_set_power(struct rcar_gyroadc *priv, bool on)
 {
 	struct device *dev = priv->dev;
 
-	if (on) {
+	if (on)
 		return pm_runtime_resume_and_get(dev);
-	} else {
-		return pm_runtime_put_autosuspend(dev);
-	}
+
+	return pm_runtime_put_autosuspend(dev);
 }
 
 static int rcar_gyroadc_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 29264a410def..39389091ee29 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -588,9 +588,8 @@ static int rzg2l_adc_resume(struct device *dev)
 	return 0;
 
 rpm_restore:
-	if (adc->was_rpm_active) {
+	if (adc->was_rpm_active)
 		pm_runtime_put_autosuspend(dev);
-	}
 resets_restore:
 	reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 	return ret;
diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index d3920fcb131b..f2a93c63ca14 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -374,11 +374,10 @@ static int ads1015_set_power_state(struct ads1015_data *data, bool on)
 	int ret;
 	struct device *dev = regmap_get_device(data->regmap);
 
-	if (on) {
+	if (on)
 		ret = pm_runtime_resume_and_get(dev);
-	} else {
+	else
 		ret = pm_runtime_put_autosuspend(dev);
-	}
 
 	return ret < 0 ? ret : 0;
 }
diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index 7d47c7dddbf8..0988c991cf60 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -95,16 +95,14 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
 	if (en && dac->common->hfsel)
 		udelay(1);
 
-	if (!enable) {
+	if (!enable)
 		pm_runtime_put_autosuspend(dev);
-	}
 
 	return 0;
 
 err_put_pm:
-	if (enable) {
+	if (enable)
 		pm_runtime_put_autosuspend(dev);
-	}
 
 	return ret;
 }
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 4dbe3c0cc5eb..38394b5f3275 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -309,9 +309,8 @@ static int bmg160_set_power_state(struct bmg160_data *data, bool on)
 
 	if (on)
 		ret = pm_runtime_get_sync(dev);
-	else {
+	else
 		ret = pm_runtime_put_autosuspend(dev);
-	}
 
 	if (ret < 0) {
 		dev_err(dev, "Failed: bmg160_set_power_state for %d\n", on);
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 42016d56c852..3cd91d8a89ee 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -747,11 +747,10 @@ static int kmx61_set_power_state(struct kmx61_data *data, bool on, u8 device)
 		data->mag_ps = on;
 	}
 
-	if (on) {
+	if (on)
 		ret = pm_runtime_resume_and_get(&data->client->dev);
-	} else {
+	else
 		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	}
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"Failed: kmx61_set_power_state for %d, ret %d\n",
diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 5ff20d423def..374bccad9119 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -336,15 +336,11 @@ static int isl29028_ir_get(struct isl29028_chip *chip, int *ir_data)
 static int isl29028_set_pm_runtime_busy(struct isl29028_chip *chip, bool on)
 {
 	struct device *dev = regmap_get_device(chip->regmap);
-	int ret;
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(dev);
-	} else {
-		ret = pm_runtime_put_autosuspend(dev);
-	}
+	if (on)
+		return pm_runtime_resume_and_get(dev);
 
-	return ret;
+	return pm_runtime_put_autosuspend(dev);
 }
 
 /* Channel IO */
diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index 93823421f42f..98a1f1624c75 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -185,14 +185,10 @@ static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
 		mutex_unlock(&data->lock);
 	}
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(&data->client->dev);
+	if (on)
+		return pm_runtime_resume_and_get(&data->client->dev);
 
-	} else {
-		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	}
-
-	return ret;
+	return pm_runtime_put_autosuspend(&data->client->dev);
 
 err:
 	mutex_unlock(&data->lock);
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 15e2cca22e4d..fd538aec4819 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -358,11 +358,10 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
 	 * Note: If either measurement is re-enabled before _suspend(),
 	 * both stay enabled until _suspend().
 	 */
-	if (on) {
+	if (on)
 		ret = pm_runtime_resume_and_get(&data->client->dev);
-	} else {
+	else
 		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	}
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"Failed: rpr0521_set_power_state for %d, ret %d\n",
diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index d3a4923e5adc..8801a491de77 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -641,15 +641,10 @@ static const struct iio_chan_spec tsl2583_channels[] = {
 
 static int tsl2583_set_pm_runtime_busy(struct tsl2583_chip *chip, bool on)
 {
-	int ret;
+	if (on)
+		return pm_runtime_resume_and_get(&chip->client->dev);
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(&chip->client->dev);
-	} else {
-		ret = pm_runtime_put_autosuspend(&chip->client->dev);
-	}
-
-	return ret;
+	return pm_runtime_put_autosuspend(&chip->client->dev);
 }
 
 static int tsl2583_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 8f0f85e98f3a..d2f5a44892a8 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -361,18 +361,13 @@ static int us5182d_shutdown_en(struct us5182d_data *data, u8 state)
 
 static int us5182d_set_power_state(struct us5182d_data *data, bool on)
 {
-	int ret;
-
 	if (data->power_mode == US5182D_ONESHOT)
 		return 0;
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(&data->client->dev);
-	} else {
-		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	}
+	if (on)
+		return pm_runtime_resume_and_get(&data->client->dev);
 
-	return ret;
+	return pm_runtime_put_autosuspend(&data->client->dev);
 }
 
 static int us5182d_read_value(struct us5182d_data *data,
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 39e2cf20038a..7d70bb71b432 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -576,15 +576,11 @@ static bool vcnl4010_is_in_periodic_mode(struct vcnl4000_data *data)
 static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
 {
 	struct device *dev = &data->client->dev;
-	int ret;
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(dev);
-	} else {
-		ret = pm_runtime_put_autosuspend(dev);
-	}
+	if (on)
+		return pm_runtime_resume_and_get(dev);
 
-	return ret;
+	return pm_runtime_put_autosuspend(dev);
 }
 
 static int vcnl4040_read_als_it(struct vcnl4000_data *data, int *val, int *val2)
diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 079fb49bf73b..963747927425 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -141,16 +141,12 @@ static const struct iio_trigger_ops vcnl4035_trigger_ops = {
 
 static int vcnl4035_set_pm_runtime_state(struct vcnl4035_data *data, bool on)
 {
-	int ret;
 	struct device *dev = &data->client->dev;
 
-	if (on) {
-		ret = pm_runtime_resume_and_get(dev);
-	} else {
-		ret = pm_runtime_put_autosuspend(dev);
-	}
+	if (on)
+		return pm_runtime_resume_and_get(dev);
 
-	return ret;
+	return pm_runtime_put_autosuspend(dev);
 }
 
 static int vcnl4035_read_info_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 53d860e640a9..7c5fef79ad04 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -260,11 +260,10 @@ static int bmc150_magn_set_power_state(struct bmc150_magn_data *data, bool on)
 #ifdef CONFIG_PM
 	int ret;
 
-	if (on) {
+	if (on)
 		ret = pm_runtime_resume_and_get(data->dev);
-	} else {
+	else
 		ret = pm_runtime_put_autosuspend(data->dev);
-	}
 
 	if (ret < 0) {
 		dev_err(data->dev,
diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index f2e2c638a2b6..310467ce39e2 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -117,9 +117,8 @@ static int srf04_read(struct srf04_data *data)
 	udelay(data->cfg->trigger_pulse_us);
 	gpiod_set_value(data->gpiod_trig, 0);
 
-	if (data->gpiod_power) {
+	if (data->gpiod_power)
 		pm_runtime_put_autosuspend(data->dev);
-	}
 
 	/* it should not take more than 20 ms until echo is rising */
 	ret = wait_for_completion_killable_timeout(&data->rising, HZ/50);


Sakari Ailus (12):
  iio: accel: Remove redundant pm_runtime_mark_last_busy() calls
  iio: adc: Remove redundant pm_runtime_mark_last_busy() calls
  iio: chemical: Remove redundant pm_runtime_mark_last_busy() calls
  iio: common: Remove redundant pm_runtime_mark_last_busy() calls
  iio: dac: Remove redundant pm_runtime_mark_last_busy() calls
  iio: gyro: Remove redundant pm_runtime_mark_last_busy() calls
  iio: imu: Remove redundant pm_runtime_mark_last_busy() calls
  iio: light: Remove redundant pm_runtime_mark_last_busy() calls
  iio: magnetometer: Remove redundant pm_runtime_mark_last_busy() calls
  iio: pressure: Remove redundant pm_runtime_mark_last_busy() calls
  iio: proximity: Remove redundant pm_runtime_mark_last_busy() calls
  iio: temperature: Remove redundant pm_runtime_mark_last_busy() calls

 drivers/iio/accel/bmc150-accel-core.c               |  6 ++----
 drivers/iio/accel/bmi088-accel-core.c               |  3 ---
 drivers/iio/accel/fxls8962af-core.c                 |  1 -
 drivers/iio/accel/kxcjk-1013.c                      |  4 +---
 drivers/iio/accel/kxsd9.c                           |  3 ---
 drivers/iio/accel/mma8452.c                         |  6 ++----
 drivers/iio/accel/mma9551_core.c                    |  4 +---
 drivers/iio/accel/msa311.c                          |  6 ------
 drivers/iio/adc/ab8500-gpadc.c                      |  1 -
 drivers/iio/adc/at91-sama5d2_adc.c                  | 13 +------------
 drivers/iio/adc/imx8qxp-adc.c                       |  2 --
 drivers/iio/adc/imx93_adc.c                         |  1 -
 drivers/iio/adc/rcar-gyroadc.c                      |  8 +++-----
 drivers/iio/adc/rzg2l_adc.c                         |  6 +-----
 drivers/iio/adc/stm32-adc-core.c                    |  1 -
 drivers/iio/adc/stm32-adc.c                         |  7 -------
 drivers/iio/adc/sun4i-gpadc-iio.c                   |  2 --
 drivers/iio/adc/ti-ads1015.c                        |  6 ++----
 drivers/iio/adc/ti-ads1100.c                        |  1 -
 drivers/iio/adc/ti-ads1119.c                        |  2 --
 drivers/iio/chemical/atlas-sensor.c                 |  2 --
 drivers/iio/chemical/bme680_core.c                  |  3 ---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c |  1 -
 drivers/iio/dac/stm32-dac.c                         |  9 ++-------
 drivers/iio/gyro/bmg160_core.c                      |  4 +---
 drivers/iio/gyro/fxas21002c_core.c                  |  2 --
 drivers/iio/gyro/mpu3050-core.c                     |  3 ---
 drivers/iio/gyro/mpu3050-i2c.c                      |  1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c   |  5 -----
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c  |  1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c    |  5 -----
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c    |  1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c          |  6 ------
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c       |  1 -
 drivers/iio/imu/kmx61.c                             |  6 ++----
 drivers/iio/light/apds9306.c                        |  2 --
 drivers/iio/light/apds9960.c                        |  1 -
 drivers/iio/light/bh1780.c                          |  1 -
 drivers/iio/light/gp2ap002.c                        |  2 --
 drivers/iio/light/isl29028.c                        | 11 +++--------
 drivers/iio/light/ltrf216a.c                        |  1 -
 drivers/iio/light/pa12203001.c                      | 11 +++--------
 drivers/iio/light/rpr0521.c                         |  6 ++----
 drivers/iio/light/tsl2583.c                         | 12 +++---------
 drivers/iio/light/tsl2591.c                         |  2 --
 drivers/iio/light/us5182d.c                         | 12 +++---------
 drivers/iio/light/vcnl4000.c                        | 11 +++--------
 drivers/iio/light/vcnl4035.c                        | 11 +++--------
 drivers/iio/magnetometer/ak8974.c                   |  2 --
 drivers/iio/magnetometer/ak8975.c                   |  1 -
 drivers/iio/magnetometer/als31300.c                 |  2 --
 drivers/iio/magnetometer/bmc150_magn.c              |  6 ++----
 drivers/iio/magnetometer/tmag5273.c                 |  2 --
 drivers/iio/magnetometer/yamaha-yas530.c            |  2 --
 drivers/iio/pressure/bmp280-core.c                  |  5 -----
 drivers/iio/pressure/icp10100.c                     |  1 -
 drivers/iio/pressure/mpl115.c                       |  2 --
 drivers/iio/pressure/zpa2326.c                      |  2 --
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c   |  1 -
 drivers/iio/proximity/srf04.c                       |  4 +---
 drivers/iio/temperature/mlx90614.c                  |  1 -
 drivers/iio/temperature/mlx90632.c                  |  1 -
 drivers/iio/temperature/mlx90635.c                  |  1 -
 63 files changed, 41 insertions(+), 208 deletions(-)

-- 
2.39.5


