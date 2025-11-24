Return-Path: <linux-iio+bounces-26420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE9DC81207
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 15:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B01EB4E5073
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD5284B26;
	Mon, 24 Nov 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jUTyAbVW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FBD27A103
	for <linux-iio@vger.kernel.org>; Mon, 24 Nov 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995723; cv=none; b=l+/o2CaHa083pvbxk8e1gLDmLvzc1MXH/pJtI1FpX3R+nVQombJ1UITkNto+UdYkTcMMxA7NZ/g0jmqazt8PBfudpQewNt2ysAdzG99SexH+Ce30Oam5CRb6rfIzZj2DEwylDkPAvuIZs4Djfe6YCQ0DsEl5cQKeizeGeLrvh8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995723; c=relaxed/simple;
	bh=suJwmvgTWH7YIdvHYZtN9EhThoS3zl2nNeCckyOK7vY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m9Led2nGJUFaiSzw9t9ciT+wP+OxLc7t4AdpDovm6HQhOeYsZBsJWKbWvvMw0z7yeRYDluBUyrIeZU2xCXNKKG0JdCVw0AFryHEhvuEMnVYJGOBjUmRftcQqY7Q7iNxeqwiITafwaj4OyKidy9rCvD1m/zvLbLE7+NR7zzZZNvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jUTyAbVW; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BCB164E4189B;
	Mon, 24 Nov 2025 14:48:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8B4F7606FC;
	Mon, 24 Nov 2025 14:48:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 80FB3103719DA;
	Mon, 24 Nov 2025 15:48:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763995716; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=lMMnsIAMX15PebOo+vvp3kZXhfsSNZFvuA90j6sbfwQ=;
	b=jUTyAbVW7z6HgIL0UvQTBUOY3RBSlX8VdTeX0gsaimyCSTq2lU4LBJlcJGjHswWYg3w4Ba
	FcB7MoEShZEeCM5CVYDH+y18Sle5bUpyOLmuMH6zzeLu/qH19bjyhLRfqdHUMgk9lHiRyQ
	FQSZckmayvnZ/ROF+b0f63MuIo26mCh5HR41kU8Dpa/S/d7gKSY2WIo22OTRxm+iaWngVs
	d75WdjxaLOdvnMGIaJBZe5ADWVwr7jYOpUKYlQpUI6Lw1pwinp6w7bMGETMpK8tkLRbZTG
	pLlfMWKRdYryjbDETCxuFEfYhgemlNUMjvtHvmj90IL+h9pqy5BjQfmQbG+1WA==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH v4 0/6] Add support for the LTM8054 voltage regulator
Date: Mon, 24 Nov 2025 15:48:04 +0100
Message-Id: <20251124-ltm8054-driver-v4-0-107a8a814abe@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACRwJGkC/2XOTQrCMBCG4auUrI1k0qQ/rryHuEibiQ20jSQlK
 KV3N60gapfvwDx8MwnoLQZyymbiMdpg3ZhCHDLSdmq8IbU6NeGMS1byivbTUDEpqPY2oqcArVG
 iFMAKSdLT3aOxjw28XFN3NkzOPzc/wnp9UzUU/1QEyqjRAssKdJ439blxburteGzdQFYs8i+Ay
 x3AE9A0BSjBQDHd7oH8A0BavAPybQEYVMhMIdUvsCzLC7uLZAkwAQAA
X-Change-ID: 20250728-ltm8054-driver-11cfa4741065
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Guenter Roeck <linux@roeck-us.net>, 
 Peter Rosin <peda@axentia.se>, Mariel Tinaco <Mariel.Tinaco@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Kevin Tsai <ktsai@capellamicro.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Paul Cercueil <paul@crapouillou.net>, Iskren Chernev <me@iskren.info>, 
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
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Dixit Parmar <dixitparmar19@gmail.com>, linux-hwmon@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Hello everyone,

This is version four of my series which adds initial support of the Linear
Technology LTM8054 voltage regulator. The driver supports a fixed voltage
and a tunable output current limit using a DAC-controlled pin.

I'd say that the most unusual part of this series is the usage of the IIO
consumer API in a regulator driver. I think this makes sense here, since
the regulator driver has to access a DAC to read/set the output current
limit.

Since the regulator driver writes microvolts and the IIO consumer API takes
millivolts, the reads and writes to the CTL DAC have to be scaled by a
factor of 1000. Scaled reads are already supported in IIO, but scaled
writes are not, which is why I've implemented them in patch 2/4.

Moreover, the IIO read/write operations are done in quite a roundabout way
in the driver's regulator callbacks. This is due to a unsafe locking
interaction: the regulator callbacks are called under regulator lock, which
means they have an active ww_mutex reservation ID. Or, some IIO drivers
will perform regulator operations when read/written to, thus taking a new
ww_mutex reservation ID.  Taking two consecutive reservation IDs for the
same ww_mutex context without freeing the first ID is forbidden (and
lockdep will complain about this). The most straightforward solution I've
found is to move the actual IIO read/write operations to a different
thread, and to wait for them to complete with a timeout from the main
callback thread.

Please let me know what you think.

Thanks,

Romain

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Changes in v4:
- Various style improvements.
- Used namespaced exports for the IIO consumer API.
- Mitigated bug caused by abs() corner case.
- Link to v3: https://lore.kernel.org/r/20251106-ltm8054-driver-v3-0-fd1feae0f65a@bootlin.com

Changes in v3:
- Made IIO operations to an asynchronous context to avoid locking issue.
- Made CTL DAC control optional.
- Make various style adjustments to the LTM8054 driver.
- Link to v2: https://lore.kernel.org/r/20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com

Changes in v2:
- Refactored iio_convert_processed_to_raw() to match what was done in Hans'
  series.
- Added unit tests for IIO division.
- Fixed coding style issues and removed unnecessary casts.
- Link to v1: https://lore.kernel.org/r/20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com

---
Romain Gantois (6):
      regulator: dt-bindings: Add Linear Technology LTM8054 regulator
      iio: inkern: Use namespaced exports
      iio: add processed write API
      iio: test: Add kunit tests for iio_divide_by_value()
      regulator: Support the LTM8054 voltage regulator
      regulator: ltm8054: Support output current limit control

 .../devicetree/bindings/regulator/adi,ltm8054.yaml |  71 ++++
 MAINTAINERS                                        |   6 +
 drivers/extcon/extcon-adc-jack.c                   |   1 +
 drivers/hwmon/iio_hwmon.c                          |   1 +
 drivers/hwmon/ntc_thermistor.c                     |   1 +
 drivers/iio/adc/envelope-detector.c                |   1 +
 drivers/iio/afe/iio-rescale.c                      |   1 +
 drivers/iio/buffer/industrialio-buffer-cb.c        |   1 +
 drivers/iio/buffer/industrialio-hw-consumer.c      |   1 +
 drivers/iio/dac/ad8460.c                           |   1 +
 drivers/iio/dac/dpot-dac.c                         |   1 +
 drivers/iio/dac/ds4424.c                           |   1 +
 drivers/iio/inkern.c                               | 187 ++++++++--
 drivers/iio/light/cm3605.c                         |   1 +
 drivers/iio/light/gp2ap002.c                       |   1 +
 drivers/iio/multiplexer/iio-mux.c                  |   1 +
 drivers/iio/potentiostat/lmp91000.c                |   1 +
 drivers/iio/test/Kconfig                           |  12 +
 drivers/iio/test/Makefile                          |   1 +
 drivers/iio/test/iio-test-divide.c                 | 247 ++++++++++++++
 drivers/iio/test/iio-test-multiply.c               |   1 +
 drivers/input/joystick/adc-joystick.c              |   1 +
 drivers/input/keyboard/adc-keys.c                  |   1 +
 drivers/input/touchscreen/colibri-vf50-ts.c        |   1 +
 drivers/input/touchscreen/resistive-adc-touch.c    |   1 +
 drivers/phy/motorola/phy-cpcap-usb.c               |   1 +
 drivers/power/supply/ab8500_btemp.c                |   1 +
 drivers/power/supply/ab8500_charger.c              |   1 +
 drivers/power/supply/ab8500_fg.c                   |   1 +
 drivers/power/supply/axp20x_ac_power.c             |   1 +
 drivers/power/supply/axp20x_battery.c              |   1 +
 drivers/power/supply/axp20x_usb_power.c            |   1 +
 drivers/power/supply/axp288_fuel_gauge.c           |   1 +
 drivers/power/supply/cpcap-battery.c               |   1 +
 drivers/power/supply/cpcap-charger.c               |   1 +
 drivers/power/supply/da9150-charger.c              |   1 +
 drivers/power/supply/generic-adc-battery.c         |   1 +
 drivers/power/supply/ingenic-battery.c             |   1 +
 drivers/power/supply/intel_dc_ti_battery.c         |   1 +
 drivers/power/supply/lego_ev3_battery.c            |   1 +
 drivers/power/supply/lp8788-charger.c              |   1 +
 drivers/power/supply/max17040_battery.c            |   1 +
 drivers/power/supply/mp2629_charger.c              |   1 +
 drivers/power/supply/mt6370-charger.c              |   1 +
 drivers/power/supply/qcom_smbx.c                   |   1 +
 drivers/power/supply/rn5t618_power.c               |   1 +
 drivers/power/supply/rx51_battery.c                |   1 +
 drivers/power/supply/sc27xx_fuel_gauge.c           |   1 +
 drivers/power/supply/twl4030_charger.c             |   1 +
 drivers/power/supply/twl4030_madc_battery.c        |   1 +
 drivers/power/supply/twl6030_charger.c             |   1 +
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/ltm8054-regulator.c              | 379 +++++++++++++++++++++
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   1 +
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   1 +
 drivers/thermal/renesas/rzg3s_thermal.c            |   1 +
 drivers/thermal/thermal-generic-adc.c              |   1 +
 include/linux/iio/consumer.h                       |  36 ++
 sound/soc/codecs/audio-iio-aux.c                   |   1 +
 sound/soc/samsung/aries_wm8994.c                   |   1 +
 sound/soc/samsung/midas_wm1811.c                   |   1 +
 sound/soc/stm/stm32_adfsdm.c                       |   1 +
 63 files changed, 972 insertions(+), 30 deletions(-)
---
base-commit: cda7b38e04b41bf0e19deed2999d725f440a5abd
change-id: 20250728-ltm8054-driver-11cfa4741065

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


