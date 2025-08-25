Return-Path: <linux-iio+bounces-23230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 079FFB34262
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 15:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76615188A9FE
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 13:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F46F2ECD10;
	Mon, 25 Aug 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beORAhg3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C35F286D50;
	Mon, 25 Aug 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130060; cv=none; b=aBGJ6YQaqCqaNkRTn4EX253aYfM1LPX1HTRSW2AIoUF9OAysKUZ5t92aJ9DfrnRkRHu4KrwXyIfDiwsMG6ugpqp00t7muYAAbAfJO5nLNUzwGKTNdr98iq521WguPbv8Vme+oIxya3Ly1JKXpjiKyKyHub0Y9KZ2NdbnmAwm3EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130060; c=relaxed/simple;
	bh=h8KYyuHuFwjgcmdF6lDE+3T/TcaauwbKkHbIgmMmcbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8KcoIikX8cFd91Cu9MhJlsv3Hd/71c0/Xn0ixCW4nz5ltCDq/xnZJam3q92CuK0tfh1HfA5Uujil4j8PjdZgDVkYY2rraWZAz5YfjvjT1WxcRUCucwUY5yjqFYt8sMcVmay746LUQftOa4GxG5uLcyJKz4Ohf+EZQoSj6PWNuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beORAhg3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756130058; x=1787666058;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h8KYyuHuFwjgcmdF6lDE+3T/TcaauwbKkHbIgmMmcbo=;
  b=beORAhg3VZS5mVcLO0bkaGBqtDvJefQpRkX52+RFQrgeNF9tRmwcy4/4
   LsOxivMLk4M7nUt4V5kYTjlqMZM3wn66mk4qZ5OZS/48/n/PvWIhi84Mf
   h3rvVqXfCUvg5YoUwBBdbLzkhCVb3WmSIWnFAjcTmJoVYjwshArjRn+x8
   x9xiqd9GLYQPK/YxHAn/spKSrhgxAZSEuwa7rMI1p4Cg08GCmveij/6VN
   5wQ7q/FBPQ/dcaZlGFTuDVfj4EZhBuRvlq9xosWYfuBg5AxUJ35x//+LO
   7Foj8TDx3SGkmZCBxcbrpRp1wqg1YKS5962d+VQy/Xv6EHdQ1uxxMe8hd
   w==;
X-CSE-ConnectionGUID: /zFRXmggRpW9/bKvL+DimA==
X-CSE-MsgGUID: vUgVg1K5RGGVIHCgPxj+Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="68936505"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="68936505"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:54:15 -0700
X-CSE-ConnectionGUID: 6Zq36epbSYaPlqSo9P8dQg==
X-CSE-MsgGUID: iZMQQn3xTlyEOBHZR+oS+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="174583468"
Received: from vpanait-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.7])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:54:11 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id B5683121F61;
	Mon, 25 Aug 2025 16:54:01 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uqXe5-00000007PNz-2m8J;
	Mon, 25 Aug 2025 16:54:01 +0300
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
Subject: [PATCH v3 00/12] iio: Remove redundant pm_runtime_mark_last_busy() calls
Date: Mon, 25 Aug 2025 16:53:49 +0300
Message-ID: <20250825135401.1765847-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.2
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
been done and is present in v6.17-rc1.

These patches are on next-20250825.

It'd be nice to merge these as fixes for 6.17.

since v2:

- Drop some unneeded newlines.

- Further clean up stm32_dac_set_enable_state().

- Avoid #ifdefs in bmc150_magn_set_power_state() by assuming
  pm_runtime_put_autosuspend() won't meaningfully fail (and what would you
  do about it anyway?).

since v1:

- Drop unneeded braces.

- Further rework call sites that simply assigned a local variable (ret) to
  return it, by removing that local variable and the redundant else
  clause.

The diff from rebased v2
(<20250708231144.971170-1-sakari.ailus@linux.intel.com>) for iio patches
is:

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index fe1783d439de..3c5d1560b163 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -336,7 +336,6 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
 		ret = pm_runtime_resume_and_get(dev);
 	else
 		ret = pm_runtime_put_autosuspend(dev);
-
 	if (ret < 0) {
 		dev_err(dev,
 			"Failed: %s for %d\n", __func__, on);
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 393294df02db..15172ba2972c 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -228,7 +228,6 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
 		ret = pm_runtime_resume_and_get(&client->dev);
 	else
 		ret = pm_runtime_put_autosuspend(&client->dev);
-
 	if (ret < 0) {
 		dev_err(&client->dev,
 			"failed to change power state to %d\n", on);
diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
index 247c2eda8420..2ccb1fb19b96 100644
--- a/drivers/iio/accel/mma9551_core.c
+++ b/drivers/iio/accel/mma9551_core.c
@@ -673,7 +673,6 @@ int mma9551_set_power_state(struct i2c_client *client, bool on)
 		ret = pm_runtime_resume_and_get(&client->dev);
 	else
 		ret = pm_runtime_put_autosuspend(&client->dev);
-
 	if (ret < 0) {
 		dev_err(&client->dev,
 			"failed to change power state to %d\n", on);
diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index 0988c991cf60..e8688f9d6df7 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -82,9 +82,9 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
 
 	ret = regmap_update_bits(dac->common->regmap, STM32_DAC_CR, msk, en);
 	mutex_unlock(&dac->lock);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(&indio_dev->dev, "%s failed\n", str_enable_disable(en));
-		goto err_put_pm;
+		goto err_pm_put;
 	}
 
 	/*
@@ -95,14 +95,8 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
 	if (en && dac->common->hfsel)
 		udelay(1);
 
-	if (!enable)
-		pm_runtime_put_autosuspend(dev);
-
-	return 0;
-
-err_put_pm:
-	if (enable)
-		pm_runtime_put_autosuspend(dev);
+err_pm_put:
+	pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 7c5fef79ad04..6a73f6e2f1f0 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -257,20 +257,17 @@ static int bmc150_magn_set_power_mode(struct bmc150_magn_data *data,
 
 static int bmc150_magn_set_power_state(struct bmc150_magn_data *data, bool on)
 {
-#ifdef CONFIG_PM
-	int ret;
+	int ret = 0;
 
 	if (on)
 		ret = pm_runtime_resume_and_get(data->dev);
 	else
-		ret = pm_runtime_put_autosuspend(data->dev);
-
+		pm_runtime_put_autosuspend(data->dev);
 	if (ret < 0) {
 		dev_err(data->dev,
 			"failed to change power state to %d\n", on);
 		return ret;
 	}
-#endif
 
 	return 0;
 }


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

 drivers/iio/accel/bmc150-accel-core.c         |  7 ++-----
 drivers/iio/accel/bmi088-accel-core.c         |  3 ---
 drivers/iio/accel/fxls8962af-core.c           |  1 -
 drivers/iio/accel/kxcjk-1013.c                |  4 +---
 drivers/iio/accel/kxsd9.c                     |  3 ---
 drivers/iio/accel/mma8452.c                   |  7 ++-----
 drivers/iio/accel/mma9551_core.c              |  5 +----
 drivers/iio/accel/msa311.c                    |  6 ------
 drivers/iio/adc/ab8500-gpadc.c                |  1 -
 drivers/iio/adc/at91-sama5d2_adc.c            | 13 +------------
 drivers/iio/adc/imx8qxp-adc.c                 |  2 --
 drivers/iio/adc/imx93_adc.c                   |  1 -
 drivers/iio/adc/rcar-gyroadc.c                |  8 +++-----
 drivers/iio/adc/rzg2l_adc.c                   |  2 --
 drivers/iio/adc/stm32-adc-core.c              |  1 -
 drivers/iio/adc/stm32-adc.c                   |  7 -------
 drivers/iio/adc/sun4i-gpadc-iio.c             |  2 --
 drivers/iio/adc/ti-ads1015.c                  |  6 ++----
 drivers/iio/adc/ti-ads1100.c                  |  1 -
 drivers/iio/adc/ti-ads1119.c                  |  2 --
 drivers/iio/chemical/atlas-sensor.c           |  2 --
 drivers/iio/chemical/bme680_core.c            |  3 ---
 .../common/hid-sensors/hid-sensor-trigger.c   |  1 -
 drivers/iio/dac/stm32-dac.c                   | 19 ++++---------------
 drivers/iio/gyro/bmg160_core.c                |  4 +---
 drivers/iio/gyro/fxas21002c_core.c            |  2 --
 drivers/iio/gyro/mpu3050-core.c               |  3 ---
 drivers/iio/gyro/mpu3050-i2c.c                |  1 -
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c |  5 -----
 .../imu/inv_icm42600/inv_icm42600_buffer.c    |  1 -
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  |  5 -----
 .../iio/imu/inv_icm42600/inv_icm42600_temp.c  |  1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  6 ------
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  1 -
 drivers/iio/imu/kmx61.c                       |  6 ++----
 drivers/iio/light/apds9306.c                  |  2 --
 drivers/iio/light/apds9960.c                  |  1 -
 drivers/iio/light/bh1780.c                    |  1 -
 drivers/iio/light/gp2ap002.c                  |  2 --
 drivers/iio/light/isl29028.c                  | 11 +++--------
 drivers/iio/light/ltrf216a.c                  |  1 -
 drivers/iio/light/pa12203001.c                | 11 +++--------
 drivers/iio/light/rpr0521.c                   |  6 ++----
 drivers/iio/light/tsl2583.c                   | 12 +++---------
 drivers/iio/light/tsl2591.c                   |  2 --
 drivers/iio/light/us5182d.c                   | 12 +++---------
 drivers/iio/light/vcnl4000.c                  | 11 +++--------
 drivers/iio/light/vcnl4035.c                  | 11 +++--------
 drivers/iio/magnetometer/ak8974.c             |  2 --
 drivers/iio/magnetometer/ak8975.c             |  1 -
 drivers/iio/magnetometer/als31300.c           |  2 --
 drivers/iio/magnetometer/bmc150_magn.c        | 13 ++++---------
 drivers/iio/magnetometer/tmag5273.c           |  2 --
 drivers/iio/magnetometer/yamaha-yas530.c      |  2 --
 drivers/iio/pressure/bmp280-core.c            |  5 -----
 drivers/iio/pressure/icp10100.c               |  1 -
 drivers/iio/pressure/mpl115.c                 |  2 --
 drivers/iio/pressure/zpa2326.c                |  2 --
 .../iio/proximity/pulsedlight-lidar-lite-v2.c |  1 -
 drivers/iio/proximity/srf04.c                 |  4 +---
 drivers/iio/temperature/mlx90614.c            |  1 -
 drivers/iio/temperature/mlx90632.c            |  1 -
 drivers/iio/temperature/mlx90635.c            |  1 -
 63 files changed, 44 insertions(+), 221 deletions(-)

-- 
2.47.2


