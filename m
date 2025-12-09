Return-Path: <linux-iio+bounces-26964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DFFCAF49D
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 09:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1B7B305FAA3
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 08:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3489F25F994;
	Tue,  9 Dec 2025 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fHyy3p3R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA9527BF7C;
	Tue,  9 Dec 2025 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765268796; cv=none; b=aSO8ZoKJLTIgvlpFO0iLZmZZUkQRtCyJmnhm2wRl0pWbsO2cwejHzuuR8OGT8pC9KAPQBT+JZU5qTKodfRrZul9jO65pyUAXFQgdGWumARflbjnONa3R7u1WNwcOUcLcnKzhl0z8BFIDMXFFV/2MFvX02mFtL4FltcNDz5In/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765268796; c=relaxed/simple;
	bh=MT/qY8MX0ozkYBW0qMvzRIWzDIZmrsZJkEszJ+YNa54=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oL0vbRK65ZQrFm5mSxgw9gyQjxZIBe7GRMNzE2QL6zR0Ic2Qh0xD0OKpMILjxv1wNpTo9ugveOSQADGPbWZrjOknpCOd5U5Y2HohqZTLjRZahyxzTBfMMm7tSN5GJRESDb+mAHZZvS8wW7ndqZSvdnbLW+nbHm3FNCX0OC6ZPgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fHyy3p3R; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 52F5AC180E0;
	Tue,  9 Dec 2025 08:26:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0BFF760714;
	Tue,  9 Dec 2025 08:26:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0CD79102F0BF6;
	Tue,  9 Dec 2025 09:26:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765268783; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=wcg04tlEy44VWHetyJPa6vtgrSi9hQkJ8Wr3ssO16Z0=;
	b=fHyy3p3RXDvWm/ScQ573O19lBfA7i99dTtnNMKIgZo6j5P27qUaUjbhNTv08DA8IFMfpHy
	AgxHwoL/NW76FusS9uDh40xSgmfteD+0AIKiUzKm6X50QBH9u+CGQe/shfCBYk6cYKg2TZ
	8gN2cTM7D1TIOGI5CBJ9VtNcRcbmeEPaK0KH5amKURGuYmw9NosAHrgGe3H35kv5rwXRKw
	4FLoSOslR05puLB4/PTfDmvtHxQZ+eNY+xwyZu7eIBJfZyxeM1KAbSzgzSDiYTjCGWaCLA
	VyDhDTs5Dy0D0lluZeF/pIm4ZgCjPNF9eHgaCtNllGMYqa2jowZM4WLyZc41kQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH v2 0/2] iio: inkern: Use namespaced exports
Date: Tue, 09 Dec 2025 09:25:54 +0100
Message-Id: <20251209-iio-inkern-use-namespaced-exports-v2-0-9799a33c4b7f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABLdN2kC/42NQQ6CMBAAv0J6dk13gRA8+Q/DoZRFNkpLWiQYw
 t+t+AGPM4eZTUUOwlFdsk0FXiSKdwnolCk7GHdnkC6xIk0lIlUg4kHcg4ODV2RwZuQ4Gcsd8Dr
 5MEcosLe6JsrbklXqTIF7WY/HrUk8SJx9eB/LBb/2VyeNf9QXBITOYJ2XfaWpyK+t9/NT3Nn6U
 TX7vn8Avu6Bn9QAAAA=
X-Change-ID: 20251127-iio-inkern-use-namespaced-exports-41fc09223b5e
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

Hello everyone,

This is version two of my series which introduces namespaced exports for
the IIO consumer API.

Best Regards,

Romain

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Changes in v2:
- Separated out ds4424 changes.
- Improved commit descriptions.
- Link to v1: https://lore.kernel.org/r/20251201-iio-inkern-use-namespaced-exports-v1-1-da1935f70243@bootlin.com

---
Romain Gantois (2):
      iio: dac: ds4424: drop unused include IIO consumer header
      iio: inkern: Use namespaced exports

 drivers/extcon/extcon-adc-jack.c                |  1 +
 drivers/hwmon/iio_hwmon.c                       |  1 +
 drivers/hwmon/ntc_thermistor.c                  |  1 +
 drivers/iio/adc/envelope-detector.c             |  1 +
 drivers/iio/afe/iio-rescale.c                   |  1 +
 drivers/iio/buffer/industrialio-buffer-cb.c     |  1 +
 drivers/iio/buffer/industrialio-hw-consumer.c   |  1 +
 drivers/iio/dac/ad8460.c                        |  1 +
 drivers/iio/dac/dpot-dac.c                      |  1 +
 drivers/iio/dac/ds4424.c                        |  1 -
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
 53 files changed, 78 insertions(+), 28 deletions(-)
---
base-commit: 99fece7ab29c9654d7945312b275b527757ac4b3
change-id: 20251127-iio-inkern-use-namespaced-exports-41fc09223b5e

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


