Return-Path: <linux-iio+bounces-26966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EF2CAF4A0
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 09:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 475713015583
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 08:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF462877F4;
	Tue,  9 Dec 2025 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="echLdR9a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94348262D27;
	Tue,  9 Dec 2025 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765268809; cv=none; b=JtaN0O24uv9gOI12EG5G5Q22gVKcwqRXYZDONJAKnpU4CCce/1bmzrZNRgKzeLWd91ee3pOngFOpKQjHw/xjcvHFBkmSNpxo5HHq6bioxa60hZx6Kk+4csCfDGa6mQvJpFrtXEQwjc5cDBh+cNkhTaObjMD+ypqOi/XVBQQGg9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765268809; c=relaxed/simple;
	bh=K7ANdXcomz10Sspv/pjHNCxRJFAen6zvKd0HlvOYUOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q3s36mkyXUV6GDG3Bu8wMmHwxQGpKXk0rjXRPGPQu7eKjOAY766oNg8W18NYQNVp997Bg4Ved511n+aGxp3jOUXrLHr1QchHkVcyLDf+8twsV8U5ITnDhCS8XLShAaAwOkVnLGabTamBwCWVBsm/lbPalyEZ7N8XN3qCOw2EVec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=echLdR9a; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0B9B41A2059;
	Tue,  9 Dec 2025 08:26:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D61B5606E2;
	Tue,  9 Dec 2025 08:26:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 45162102F0BF6;
	Tue,  9 Dec 2025 09:26:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765268801; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CAwakq+M3XLQ3v6bO0sb810odQLx1Otn6654dEAbP5M=;
	b=echLdR9axeZh9TeJIHGvnBK53KeBdylSdJUOrtlaZe1QpbZ5otkvtD8hmkdy2tvff8cVe7
	nV6wuIXopjjn0Kuekqe6vl8QYkFNyD/nrLAx4SFX3PD1MtN2pkSb+9nB9D2CkMF1/Y8p5o
	Sfn4UIBbRvd6RctGMgBsPfmy6RaaHrotE29NOfVTZYkf8AD/CggIMGG4/lxc2ZVSaCBMiX
	kE4JW86lRcU6ZET1Ijjkv+W2GJCXbiTshlMp2Dlv4s12tIDCont6hOMveimLgA4guqCVxz
	uT7r0QXLXjopjZs4lzCWgtFqcs6qqoKoU7oizxHA88TyG5fV+TMxfOMmIB6QvA==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 09 Dec 2025 09:25:56 +0100
Subject: [PATCH v2 2/2] iio: inkern: Use namespaced exports
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251209-iio-inkern-use-namespaced-exports-v2-2-9799a33c4b7f@bootlin.com>
References: <20251209-iio-inkern-use-namespaced-exports-v2-0-9799a33c4b7f@bootlin.com>
In-Reply-To: <20251209-iio-inkern-use-namespaced-exports-v2-0-9799a33c4b7f@bootlin.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Guenter Roeck <linux@roeck-us.net>, 
 Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Mariel Tinaco <Mariel.Tinaco@analog.com>, 
 Kevin Tsai <ktsai@capellamicro.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Hans de Goede <hansg@kernel.org>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Paul Cercueil <paul@crapouillou.net>, Iskren Chernev <me@iskren.info>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Matheus Castello <matheus@castello.eng.br>, 
 Saravanan Sekar <sravanhome@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Use namespaced exports for IIO consumer API functions.

This will make it easier to manage the IIO export surface. Consumer drivers
will only be provided access to a specific set of functions, thereby
restricting usage of internal IIO functions by other parts of the kernel.

This change cannot be split into several parts without breaking
bisectability, thus all of the affected drivers are modified at once.

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com> # for power-supply
Acked-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/extcon/extcon-adc-jack.c                |  1 +
 drivers/hwmon/iio_hwmon.c                       |  1 +
 drivers/hwmon/ntc_thermistor.c                  |  1 +
 drivers/iio/adc/envelope-detector.c             |  1 +
 drivers/iio/afe/iio-rescale.c                   |  1 +
 drivers/iio/buffer/industrialio-buffer-cb.c     |  1 +
 drivers/iio/buffer/industrialio-hw-consumer.c   |  1 +
 drivers/iio/dac/ad8460.c                        |  1 +
 drivers/iio/dac/dpot-dac.c                      |  1 +
 drivers/iio/inkern.c                            | 54 ++++++++++++-------------
 drivers/iio/light/cm3605.c                      |  1 +
 drivers/iio/light/gp2ap002.c                    |  1 +
 drivers/iio/multiplexer/iio-mux.c               |  1 +
 drivers/iio/potentiostat/lmp91000.c             |  1 +
 drivers/input/joystick/adc-joystick.c           |  1 +
 drivers/input/keyboard/adc-keys.c               |  1 +
 drivers/input/touchscreen/colibri-vf50-ts.c     |  1 +
 drivers/input/touchscreen/resistive-adc-touch.c |  1 +
 drivers/phy/motorola/phy-cpcap-usb.c            |  1 +
 drivers/power/supply/ab8500_btemp.c             |  1 +
 drivers/power/supply/ab8500_charger.c           |  1 +
 drivers/power/supply/ab8500_fg.c                |  1 +
 drivers/power/supply/axp20x_ac_power.c          |  1 +
 drivers/power/supply/axp20x_battery.c           |  1 +
 drivers/power/supply/axp20x_usb_power.c         |  1 +
 drivers/power/supply/axp288_fuel_gauge.c        |  1 +
 drivers/power/supply/cpcap-battery.c            |  1 +
 drivers/power/supply/cpcap-charger.c            |  1 +
 drivers/power/supply/da9150-charger.c           |  1 +
 drivers/power/supply/generic-adc-battery.c      |  1 +
 drivers/power/supply/ingenic-battery.c          |  1 +
 drivers/power/supply/intel_dc_ti_battery.c      |  1 +
 drivers/power/supply/lego_ev3_battery.c         |  1 +
 drivers/power/supply/lp8788-charger.c           |  1 +
 drivers/power/supply/max17040_battery.c         |  1 +
 drivers/power/supply/mp2629_charger.c           |  1 +
 drivers/power/supply/mt6370-charger.c           |  1 +
 drivers/power/supply/qcom_smbx.c                |  1 +
 drivers/power/supply/rn5t618_power.c            |  1 +
 drivers/power/supply/rx51_battery.c             |  1 +
 drivers/power/supply/sc27xx_fuel_gauge.c        |  1 +
 drivers/power/supply/twl4030_charger.c          |  1 +
 drivers/power/supply/twl4030_madc_battery.c     |  1 +
 drivers/power/supply/twl6030_charger.c          |  1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c        |  1 +
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c     |  1 +
 drivers/thermal/renesas/rzg3s_thermal.c         |  1 +
 drivers/thermal/thermal-generic-adc.c           |  1 +
 sound/soc/codecs/audio-iio-aux.c                |  1 +
 sound/soc/samsung/aries_wm8994.c                |  1 +
 sound/soc/samsung/midas_wm1811.c                |  1 +
 sound/soc/stm/stm32_adfsdm.c                    |  1 +
 52 files changed, 78 insertions(+), 27 deletions(-)

diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc-jack.c
index 7e3c9f38297b..e735f43dcdeb 100644
--- a/drivers/extcon/extcon-adc-jack.c
+++ b/drivers/extcon/extcon-adc-jack.c
@@ -210,3 +210,4 @@ module_platform_driver(adc_jack_driver);
 MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
 MODULE_DESCRIPTION("ADC Jack extcon driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index e376d4cde5ad..4c7843fbcc50 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -222,3 +222,4 @@ module_platform_driver(iio_hwmon_driver);
 MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
 MODULE_DESCRIPTION("IIO to hwmon driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index d21f7266c411..417807fad80b 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -706,3 +706,4 @@ MODULE_DESCRIPTION("NTC Thermistor Driver");
 MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:ntc-thermistor");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
index 5b16fe737659..fea20e7e6cd9 100644
--- a/drivers/iio/adc/envelope-detector.c
+++ b/drivers/iio/adc/envelope-detector.c
@@ -406,3 +406,4 @@ module_platform_driver(envelope_detector_driver);
 MODULE_DESCRIPTION("Envelope detector using a DAC and a comparator");
 MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index ecaf59278c6f..d7f55109af3e 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -609,3 +609,4 @@ module_platform_driver(rescale_driver);
 MODULE_DESCRIPTION("IIO rescale driver");
 MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index 3e27385069ed..608ea9afc15a 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -153,3 +153,4 @@ EXPORT_SYMBOL_GPL(iio_channel_cb_get_iio_dev);
 MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
 MODULE_DESCRIPTION("Industrial I/O callback buffer");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index 526b2a8d725d..d7ff086ed783 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -211,3 +211,4 @@ EXPORT_SYMBOL_GPL(iio_hw_consumer_disable);
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("Hardware consumer buffer the IIO framework");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
index 6e45686902dd..ad654819ca22 100644
--- a/drivers/iio/dac/ad8460.c
+++ b/drivers/iio/dac/ad8460.c
@@ -955,3 +955,4 @@ MODULE_AUTHOR("Mariel Tinaco <mariel.tinaco@analog.com");
 MODULE_DESCRIPTION("AD8460 DAC driver");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index d1b8441051ae..49dbdb7df955 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -254,3 +254,4 @@ module_platform_driver(dpot_dac_driver);
 MODULE_DESCRIPTION("DAC emulation driver using a digital potentiometer");
 MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 1e5eb5a41271..c75c3a8d233f 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -281,7 +281,7 @@ struct iio_channel *fwnode_iio_channel_get_by_name(struct fwnode_handle *fwnode,
 
 	return ERR_PTR(-ENODEV);
 }
-EXPORT_SYMBOL_GPL(fwnode_iio_channel_get_by_name);
+EXPORT_SYMBOL_NS_GPL(fwnode_iio_channel_get_by_name, "IIO_CONSUMER");
 
 static struct iio_channel *fwnode_iio_channel_get_all(struct device *dev)
 {
@@ -386,7 +386,7 @@ struct iio_channel *iio_channel_get(struct device *dev,
 
 	return iio_channel_get_sys(name, channel_name);
 }
-EXPORT_SYMBOL_GPL(iio_channel_get);
+EXPORT_SYMBOL_NS_GPL(iio_channel_get, "IIO_CONSUMER");
 
 void iio_channel_release(struct iio_channel *channel)
 {
@@ -395,7 +395,7 @@ void iio_channel_release(struct iio_channel *channel)
 	iio_device_put(channel->indio_dev);
 	kfree(channel);
 }
-EXPORT_SYMBOL_GPL(iio_channel_release);
+EXPORT_SYMBOL_NS_GPL(iio_channel_release, "IIO_CONSUMER");
 
 static void devm_iio_channel_free(void *iio_channel)
 {
@@ -418,7 +418,7 @@ struct iio_channel *devm_iio_channel_get(struct device *dev,
 
 	return channel;
 }
-EXPORT_SYMBOL_GPL(devm_iio_channel_get);
+EXPORT_SYMBOL_NS_GPL(devm_iio_channel_get, "IIO_CONSUMER");
 
 struct iio_channel *devm_fwnode_iio_channel_get_by_name(struct device *dev,
 							struct fwnode_handle *fwnode,
@@ -437,7 +437,7 @@ struct iio_channel *devm_fwnode_iio_channel_get_by_name(struct device *dev,
 
 	return channel;
 }
-EXPORT_SYMBOL_GPL(devm_fwnode_iio_channel_get_by_name);
+EXPORT_SYMBOL_NS_GPL(devm_fwnode_iio_channel_get_by_name, "IIO_CONSUMER");
 
 struct iio_channel *iio_channel_get_all(struct device *dev)
 {
@@ -506,7 +506,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 		iio_device_put(chans[i].indio_dev);
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(iio_channel_get_all);
+EXPORT_SYMBOL_NS_GPL(iio_channel_get_all, "IIO_CONSUMER");
 
 void iio_channel_release_all(struct iio_channel *channels)
 {
@@ -518,7 +518,7 @@ void iio_channel_release_all(struct iio_channel *channels)
 	}
 	kfree(channels);
 }
-EXPORT_SYMBOL_GPL(iio_channel_release_all);
+EXPORT_SYMBOL_NS_GPL(iio_channel_release_all, "IIO_CONSUMER");
 
 static void devm_iio_channel_free_all(void *iio_channels)
 {
@@ -541,7 +541,7 @@ struct iio_channel *devm_iio_channel_get_all(struct device *dev)
 
 	return channels;
 }
-EXPORT_SYMBOL_GPL(devm_iio_channel_get_all);
+EXPORT_SYMBOL_NS_GPL(devm_iio_channel_get_all, "IIO_CONSUMER");
 
 static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 			    enum iio_chan_info_enum info)
@@ -585,7 +585,7 @@ int iio_read_channel_raw(struct iio_channel *chan, int *val)
 
 	return iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
 }
-EXPORT_SYMBOL_GPL(iio_read_channel_raw);
+EXPORT_SYMBOL_NS_GPL(iio_read_channel_raw, "IIO_CONSUMER");
 
 int iio_read_channel_average_raw(struct iio_channel *chan, int *val)
 {
@@ -597,7 +597,7 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val)
 
 	return iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_AVERAGE_RAW);
 }
-EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
+EXPORT_SYMBOL_NS_GPL(iio_read_channel_average_raw, "IIO_CONSUMER");
 
 int iio_multiply_value(int *result, s64 multiplier,
 		       unsigned int type, int val, int val2)
@@ -701,7 +701,7 @@ int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
 	return iio_convert_raw_to_processed_unlocked(chan, raw, processed,
 						     scale);
 }
-EXPORT_SYMBOL_GPL(iio_convert_raw_to_processed);
+EXPORT_SYMBOL_NS_GPL(iio_convert_raw_to_processed, "IIO_CONSUMER");
 
 int iio_read_channel_attribute(struct iio_channel *chan, int *val, int *val2,
 			       enum iio_chan_info_enum attribute)
@@ -714,13 +714,13 @@ int iio_read_channel_attribute(struct iio_channel *chan, int *val, int *val2,
 
 	return iio_channel_read(chan, val, val2, attribute);
 }
-EXPORT_SYMBOL_GPL(iio_read_channel_attribute);
+EXPORT_SYMBOL_NS_GPL(iio_read_channel_attribute, "IIO_CONSUMER");
 
 int iio_read_channel_offset(struct iio_channel *chan, int *val, int *val2)
 {
 	return iio_read_channel_attribute(chan, val, val2, IIO_CHAN_INFO_OFFSET);
 }
-EXPORT_SYMBOL_GPL(iio_read_channel_offset);
+EXPORT_SYMBOL_NS_GPL(iio_read_channel_offset, "IIO_CONSUMER");
 
 int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
 				     unsigned int scale)
@@ -748,20 +748,20 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
 							     scale);
 	}
 }
-EXPORT_SYMBOL_GPL(iio_read_channel_processed_scale);
+EXPORT_SYMBOL_NS_GPL(iio_read_channel_processed_scale, "IIO_CONSUMER");
 
 int iio_read_channel_processed(struct iio_channel *chan, int *val)
 {
 	/* This is just a special case with scale factor 1 */
 	return iio_read_channel_processed_scale(chan, val, 1);
 }
-EXPORT_SYMBOL_GPL(iio_read_channel_processed);
+EXPORT_SYMBOL_NS_GPL(iio_read_channel_processed, "IIO_CONSUMER");
 
 int iio_read_channel_scale(struct iio_channel *chan, int *val, int *val2)
 {
 	return iio_read_channel_attribute(chan, val, val2, IIO_CHAN_INFO_SCALE);
 }
-EXPORT_SYMBOL_GPL(iio_read_channel_scale);
+EXPORT_SYMBOL_NS_GPL(iio_read_channel_scale, "IIO_CONSUMER");
 
 static int iio_channel_read_avail(struct iio_channel *chan,
 				  const int **vals, int *type, int *length,
@@ -790,7 +790,7 @@ int iio_read_avail_channel_attribute(struct iio_channel *chan,
 
 	return iio_channel_read_avail(chan, vals, type, length, attribute);
 }
-EXPORT_SYMBOL_GPL(iio_read_avail_channel_attribute);
+EXPORT_SYMBOL_NS_GPL(iio_read_avail_channel_attribute, "IIO_CONSUMER");
 
 int iio_read_avail_channel_raw(struct iio_channel *chan,
 			       const int **vals, int *length)
@@ -807,7 +807,7 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(iio_read_avail_channel_raw);
+EXPORT_SYMBOL_NS_GPL(iio_read_avail_channel_raw, "IIO_CONSUMER");
 
 static int iio_channel_read_max(struct iio_channel *chan,
 				int *val, int *val2, int *type,
@@ -863,7 +863,7 @@ int iio_read_max_channel_raw(struct iio_channel *chan, int *val)
 
 	return iio_channel_read_max(chan, val, NULL, &type, IIO_CHAN_INFO_RAW);
 }
-EXPORT_SYMBOL_GPL(iio_read_max_channel_raw);
+EXPORT_SYMBOL_NS_GPL(iio_read_max_channel_raw, "IIO_CONSUMER");
 
 static int iio_channel_read_min(struct iio_channel *chan,
 				int *val, int *val2, int *type,
@@ -919,7 +919,7 @@ int iio_read_min_channel_raw(struct iio_channel *chan, int *val)
 
 	return iio_channel_read_min(chan, val, NULL, &type, IIO_CHAN_INFO_RAW);
 }
-EXPORT_SYMBOL_GPL(iio_read_min_channel_raw);
+EXPORT_SYMBOL_NS_GPL(iio_read_min_channel_raw, "IIO_CONSUMER");
 
 int iio_get_channel_type(struct iio_channel *chan, enum iio_chan_type *type)
 {
@@ -933,7 +933,7 @@ int iio_get_channel_type(struct iio_channel *chan, enum iio_chan_type *type)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(iio_get_channel_type);
+EXPORT_SYMBOL_NS_GPL(iio_get_channel_type, "IIO_CONSUMER");
 
 static int iio_channel_write(struct iio_channel *chan, int val, int val2,
 			     enum iio_chan_info_enum info)
@@ -957,13 +957,13 @@ int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,
 
 	return iio_channel_write(chan, val, val2, attribute);
 }
-EXPORT_SYMBOL_GPL(iio_write_channel_attribute);
+EXPORT_SYMBOL_NS_GPL(iio_write_channel_attribute, "IIO_CONSUMER");
 
 int iio_write_channel_raw(struct iio_channel *chan, int val)
 {
 	return iio_write_channel_attribute(chan, val, 0, IIO_CHAN_INFO_RAW);
 }
-EXPORT_SYMBOL_GPL(iio_write_channel_raw);
+EXPORT_SYMBOL_NS_GPL(iio_write_channel_raw, "IIO_CONSUMER");
 
 unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan)
 {
@@ -978,7 +978,7 @@ unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan)
 
 	return i;
 }
-EXPORT_SYMBOL_GPL(iio_get_channel_ext_info_count);
+EXPORT_SYMBOL_NS_GPL(iio_get_channel_ext_info_count, "IIO_CONSUMER");
 
 static const struct iio_chan_spec_ext_info *
 iio_lookup_ext_info(const struct iio_channel *chan, const char *attr)
@@ -1013,7 +1013,7 @@ ssize_t iio_read_channel_ext_info(struct iio_channel *chan,
 	return ext_info->read(chan->indio_dev, ext_info->private,
 			      chan->channel, buf);
 }
-EXPORT_SYMBOL_GPL(iio_read_channel_ext_info);
+EXPORT_SYMBOL_NS_GPL(iio_read_channel_ext_info, "IIO_CONSUMER");
 
 ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
 				   const char *buf, size_t len)
@@ -1027,7 +1027,7 @@ ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
 	return ext_info->write(chan->indio_dev, ext_info->private,
 			       chan->channel, buf, len);
 }
-EXPORT_SYMBOL_GPL(iio_write_channel_ext_info);
+EXPORT_SYMBOL_NS_GPL(iio_write_channel_ext_info, "IIO_CONSUMER");
 
 ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf)
 {
@@ -1038,4 +1038,4 @@ ssize_t iio_read_channel_label(struct iio_channel *chan, char *buf)
 
 	return do_iio_read_channel_label(chan->indio_dev, chan->channel, buf);
 }
-EXPORT_SYMBOL_GPL(iio_read_channel_label);
+EXPORT_SYMBOL_NS_GPL(iio_read_channel_label, "IIO_CONSUMER");
diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
index 0c17378e27d1..1bd11292d005 100644
--- a/drivers/iio/light/cm3605.c
+++ b/drivers/iio/light/cm3605.c
@@ -325,3 +325,4 @@ module_platform_driver(cm3605_driver);
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("CM3605 ambient light and proximity sensor driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index a0d8a58f2704..04b1f6eade0e 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -717,3 +717,4 @@ module_i2c_driver(gp2ap002_driver);
 MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
 MODULE_DESCRIPTION("GP2AP002 ambient light and proximity sensor driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index b742ca9a99d1..e193913f5af7 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -464,3 +464,4 @@ module_platform_driver(mux_driver);
 MODULE_DESCRIPTION("IIO multiplexer driver");
 MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index eccc2a34358f..7d993f2acda4 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -423,3 +423,4 @@ module_i2c_driver(lmp91000_driver);
 MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
 MODULE_DESCRIPTION("LMP91000 digital potentiostat");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
index ff44f9978b71..4fa42f88bcfa 100644
--- a/drivers/input/joystick/adc-joystick.c
+++ b/drivers/input/joystick/adc-joystick.c
@@ -329,3 +329,4 @@ module_platform_driver(adc_joystick_driver);
 MODULE_DESCRIPTION("Input driver for joysticks connected over ADC");
 MODULE_AUTHOR("Artur Rojek <contact@artur-rojek.eu>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/input/keyboard/adc-keys.c b/drivers/input/keyboard/adc-keys.c
index f1753207429d..d687459a0c80 100644
--- a/drivers/input/keyboard/adc-keys.c
+++ b/drivers/input/keyboard/adc-keys.c
@@ -202,3 +202,4 @@ module_platform_driver(adc_keys_driver);
 MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@free-electrons.com>");
 MODULE_DESCRIPTION("Input driver for resistor ladder connected on ADC");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/input/touchscreen/colibri-vf50-ts.c b/drivers/input/touchscreen/colibri-vf50-ts.c
index 98d5b2ba63fb..89c4d7b2b89e 100644
--- a/drivers/input/touchscreen/colibri-vf50-ts.c
+++ b/drivers/input/touchscreen/colibri-vf50-ts.c
@@ -372,3 +372,4 @@ module_platform_driver(vf50_touch_driver);
 MODULE_AUTHOR("Sanchayan Maity");
 MODULE_DESCRIPTION("Colibri VF50 Touchscreen driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/input/touchscreen/resistive-adc-touch.c b/drivers/input/touchscreen/resistive-adc-touch.c
index 7e761ec73273..2fefd652864c 100644
--- a/drivers/input/touchscreen/resistive-adc-touch.c
+++ b/drivers/input/touchscreen/resistive-adc-touch.c
@@ -301,3 +301,4 @@ module_platform_driver(grts_driver);
 MODULE_AUTHOR("Eugen Hristev <eugen.hristev@microchip.com>");
 MODULE_DESCRIPTION("Generic ADC Resistive Touch Driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/phy-cpcap-usb.c
index 7cb020dd3423..9591672b0511 100644
--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -717,3 +717,4 @@ MODULE_ALIAS("platform:cpcap_usb");
 MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
 MODULE_DESCRIPTION("CPCAP usb phy driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index e5202a7b6209..36b0c52a4b8b 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -829,3 +829,4 @@ MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Johan Palsson, Karl Komierowski, Arun R Murthy");
 MODULE_ALIAS("platform:ab8500-btemp");
 MODULE_DESCRIPTION("AB8500 battery temperature driver");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 5f4537766e5b..6e49d1b28254 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3751,3 +3751,4 @@ MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Johan Palsson, Karl Komierowski, Arun R Murthy");
 MODULE_ALIAS("platform:ab8500-charger");
 MODULE_DESCRIPTION("AB8500 charger management driver");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 9dd99722667a..5fa559f796aa 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3252,3 +3252,4 @@ MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Johan Palsson, Karl Komierowski");
 MODULE_ALIAS("platform:ab8500-fg");
 MODULE_DESCRIPTION("AB8500 Fuel Gauge driver");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
index 5f6ea416fa30..e9049d6229df 100644
--- a/drivers/power/supply/axp20x_ac_power.c
+++ b/drivers/power/supply/axp20x_ac_power.c
@@ -421,3 +421,4 @@ module_platform_driver(axp20x_ac_power_driver);
 MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
 MODULE_DESCRIPTION("AXP20X and AXP22X PMICs' AC power supply driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 50ca8e110085..ee8701a6e907 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -1155,3 +1155,4 @@ module_platform_driver(axp20x_batt_driver);
 MODULE_DESCRIPTION("Battery power supply driver for AXP20X and AXP22X PMICs");
 MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index e75d1e377ac1..599adcf84968 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -1080,3 +1080,4 @@ module_platform_driver(axp20x_usb_power_driver);
 MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
 MODULE_DESCRIPTION("AXP20x PMIC USB power supply status driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index a3d71fc72064..c6897dd808fc 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -817,3 +817,4 @@ MODULE_AUTHOR("Ramakrishna Pallala <ramakrishna.pallala@intel.com>");
 MODULE_AUTHOR("Todd Brandt <todd.e.brandt@linux.intel.com>");
 MODULE_DESCRIPTION("Xpower AXP288 Fuel Gauge Driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 8106d1edcbc2..542c3c70e3cb 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -1176,3 +1176,4 @@ module_platform_driver(cpcap_battery_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
 MODULE_DESCRIPTION("CPCAP PMIC Battery Driver");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index d0c3008db534..89bc0fc3c9f8 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -977,3 +977,4 @@ MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
 MODULE_DESCRIPTION("CPCAP Battery Charger Interface driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:cpcap-charger");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/da9150-charger.c b/drivers/power/supply/da9150-charger.c
index 27f36ef5b88d..58449df6068c 100644
--- a/drivers/power/supply/da9150-charger.c
+++ b/drivers/power/supply/da9150-charger.c
@@ -644,3 +644,4 @@ module_platform_driver(da9150_charger_driver);
 MODULE_DESCRIPTION("Charger Driver for DA9150");
 MODULE_AUTHOR("Adam Thomson <Adam.Thomson.Opensource@diasemi.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index f5f2566b3a32..d18c8ee40405 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -298,3 +298,4 @@ module_platform_driver(gab_driver);
 MODULE_AUTHOR("anish kumar <yesanishhere@gmail.com>");
 MODULE_DESCRIPTION("generic battery driver using IIO");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/supply/ingenic-battery.c
index b111c7ce2be3..5be269f17bff 100644
--- a/drivers/power/supply/ingenic-battery.c
+++ b/drivers/power/supply/ingenic-battery.c
@@ -190,3 +190,4 @@ module_platform_driver(ingenic_battery_driver);
 MODULE_DESCRIPTION("Battery driver for Ingenic JZ47xx SoCs");
 MODULE_AUTHOR("Artur Rojek <contact@artur-rojek.eu>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/intel_dc_ti_battery.c b/drivers/power/supply/intel_dc_ti_battery.c
index 56b0c92e9d28..1a16ded563bc 100644
--- a/drivers/power/supply/intel_dc_ti_battery.c
+++ b/drivers/power/supply/intel_dc_ti_battery.c
@@ -387,3 +387,4 @@ MODULE_ALIAS("platform:" DEV_NAME);
 MODULE_AUTHOR("Hans de Goede <hansg@kernel.org>");
 MODULE_DESCRIPTION("Intel Dollar Cove (TI) battery driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/lego_ev3_battery.c b/drivers/power/supply/lego_ev3_battery.c
index 28454de05761..414816662b06 100644
--- a/drivers/power/supply/lego_ev3_battery.c
+++ b/drivers/power/supply/lego_ev3_battery.c
@@ -231,3 +231,4 @@ module_platform_driver(lego_ev3_battery_driver);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Lechner <david@lechnology.com>");
 MODULE_DESCRIPTION("LEGO MINDSTORMS EV3 Battery Driver");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index f0a680c155c4..8c6ec98362d0 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -727,3 +727,4 @@ MODULE_DESCRIPTION("TI LP8788 Charger Driver");
 MODULE_AUTHOR("Milo Kim");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:lp8788-charger");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index c1640bc6accd..1fe658bfecc1 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -635,3 +635,4 @@ module_i2c_driver(max17040_i2c_driver);
 MODULE_AUTHOR("Minkyu Kang <mk7.kang@samsung.com>");
 MODULE_DESCRIPTION("MAX17040 Fuel Gauge");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/mp2629_charger.c b/drivers/power/supply/mp2629_charger.c
index d281c1059629..ed49f9a04c8c 100644
--- a/drivers/power/supply/mp2629_charger.c
+++ b/drivers/power/supply/mp2629_charger.c
@@ -660,3 +660,4 @@ module_platform_driver(mp2629_charger_driver);
 MODULE_AUTHOR("Saravanan Sekar <sravanhome@gmail.com>");
 MODULE_DESCRIPTION("MP2629 Charger driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
index e6db961d5818..2d02fdf37d70 100644
--- a/drivers/power/supply/mt6370-charger.c
+++ b/drivers/power/supply/mt6370-charger.c
@@ -941,3 +941,4 @@ module_platform_driver(mt6370_chg_driver);
 MODULE_AUTHOR("ChiaEn Wu <chiaen_wu@richtek.com>");
 MODULE_DESCRIPTION("MediaTek MT6370 Charger Driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index b1cb925581ec..63b88754155c 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -1050,3 +1050,4 @@ module_platform_driver(qcom_spmi_smb);
 MODULE_AUTHOR("Casey Connolly <casey.connolly@linaro.org>");
 MODULE_DESCRIPTION("Qualcomm SMB2 Charger Driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/rn5t618_power.c b/drivers/power/supply/rn5t618_power.c
index 40dec55a9f73..a3f30e390c11 100644
--- a/drivers/power/supply/rn5t618_power.c
+++ b/drivers/power/supply/rn5t618_power.c
@@ -821,3 +821,4 @@ module_platform_driver(rn5t618_power_driver);
 MODULE_ALIAS("platform:rn5t618-power");
 MODULE_DESCRIPTION("Power supply driver for RICOH RN5T618");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/rx51_battery.c b/drivers/power/supply/rx51_battery.c
index b0220ec2d926..57266921dc8e 100644
--- a/drivers/power/supply/rx51_battery.c
+++ b/drivers/power/supply/rx51_battery.c
@@ -246,3 +246,4 @@ MODULE_ALIAS("platform:rx51-battery");
 MODULE_AUTHOR("Pali Rohár <pali@kernel.org>");
 MODULE_DESCRIPTION("Nokia RX-51 battery driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index a7ed9de8a289..1719ec4173e6 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -1350,3 +1350,4 @@ module_platform_driver(sc27xx_fgu_driver);
 
 MODULE_DESCRIPTION("Spreadtrum SC27XX PMICs Fual Gauge Unit Driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 04216b2bfb6c..151f7b24e9b9 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -1144,3 +1144,4 @@ MODULE_AUTHOR("Gražvydas Ignotas");
 MODULE_DESCRIPTION("TWL4030 Battery Charger Interface driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:twl4030_bci");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/twl4030_madc_battery.c b/drivers/power/supply/twl4030_madc_battery.c
index 3935162e350b..9b3785d1643c 100644
--- a/drivers/power/supply/twl4030_madc_battery.c
+++ b/drivers/power/supply/twl4030_madc_battery.c
@@ -237,3 +237,4 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Lukas Märdian <lukas@goldelico.com>");
 MODULE_DESCRIPTION("twl4030_madc battery driver");
 MODULE_ALIAS("platform:twl4030_madc_battery");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/power/supply/twl6030_charger.c b/drivers/power/supply/twl6030_charger.c
index b4ec26ff257c..82911a811f4e 100644
--- a/drivers/power/supply/twl6030_charger.c
+++ b/drivers/power/supply/twl6030_charger.c
@@ -579,3 +579,4 @@ module_platform_driver(twl6030_charger_driver);
 
 MODULE_DESCRIPTION("TWL6030 Battery Charger Interface driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index d7f2e6ca92c2..bb6222c8cc5f 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -1069,3 +1069,4 @@ module_platform_driver(adc_tm5_driver);
 
 MODULE_DESCRIPTION("SPMI PMIC Thermal Monitor ADC driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index f39ca0ddd17b..fb003ca96454 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -904,3 +904,4 @@ module_platform_driver(qpnp_tm_driver);
 MODULE_ALIAS("platform:spmi-temp-alarm");
 MODULE_DESCRIPTION("QPNP PMIC Temperature Alarm driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/thermal/renesas/rzg3s_thermal.c b/drivers/thermal/renesas/rzg3s_thermal.c
index e25e36c99a88..7ced8f76a0ec 100644
--- a/drivers/thermal/renesas/rzg3s_thermal.c
+++ b/drivers/thermal/renesas/rzg3s_thermal.c
@@ -270,3 +270,4 @@ module_platform_driver(rzg3s_thermal_driver);
 MODULE_DESCRIPTION("Renesas RZ/G3S Thermal Sensor Unit Driver");
 MODULE_AUTHOR("Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index 7c844589b153..cfdb8e674dd2 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -228,3 +228,4 @@ module_platform_driver(gadc_thermal_driver);
 MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
 MODULE_DESCRIPTION("Generic ADC thermal driver using IIO framework with DT");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/sound/soc/codecs/audio-iio-aux.c b/sound/soc/codecs/audio-iio-aux.c
index 588e48044c13..864a5a676495 100644
--- a/sound/soc/codecs/audio-iio-aux.c
+++ b/sound/soc/codecs/audio-iio-aux.c
@@ -312,3 +312,4 @@ module_platform_driver(audio_iio_aux_driver);
 MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
 MODULE_DESCRIPTION("IIO ALSA SoC aux driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/sound/soc/samsung/aries_wm8994.c b/sound/soc/samsung/aries_wm8994.c
index 3723329b266d..b6f0f3c0d393 100644
--- a/sound/soc/samsung/aries_wm8994.c
+++ b/sound/soc/samsung/aries_wm8994.c
@@ -700,3 +700,4 @@ module_platform_driver(aries_audio_driver);
 MODULE_DESCRIPTION("ALSA SoC ARIES WM8994");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:aries-audio-wm8994");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/sound/soc/samsung/midas_wm1811.c b/sound/soc/samsung/midas_wm1811.c
index 239e958b88d3..12c4962f901d 100644
--- a/sound/soc/samsung/midas_wm1811.c
+++ b/sound/soc/samsung/midas_wm1811.c
@@ -773,3 +773,4 @@ module_platform_driver(midas_driver);
 MODULE_AUTHOR("Simon Shields <simon@lineageos.org>");
 MODULE_DESCRIPTION("ASoC support for Midas");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_CONSUMER");
diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index c914d1c46850..dabcd2759187 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -407,3 +407,4 @@ MODULE_DESCRIPTION("stm32 DFSDM DAI driver");
 MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" STM32_ADFSDM_DRV_NAME);
+MODULE_IMPORT_NS("IIO_CONSUMER");

-- 
2.51.2


