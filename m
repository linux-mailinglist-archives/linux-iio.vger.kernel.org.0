Return-Path: <linux-iio+bounces-6352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D29F090B2A3
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 16:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C5D1B2B7E7
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 14:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4791B5833;
	Mon, 17 Jun 2024 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="edG+un33"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B898419B5B2
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632187; cv=none; b=DuIA6ZIn0CJl+DDbDywOTyC3HlP+Fphzc0/39+5o16Ew6i9vEkT2A7snB9JRMhd1zTtm+dWXSJ5PnYvyGCFgJq3GoT3vJMPys7Pb+4+MI+1wuzatS709UKet7pAswJR7ADf0gaINjjQjkLPZNIJOLvGUOMkBjTZu1iQUvx8y/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632187; c=relaxed/simple;
	bh=+vMkV4nmlC5o3WoCL8T3Cf/sOOrCOwcnxXg4rxYbHm8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b1R5EC72vLwhzR7KV5VRR4Mx9rhveTdN8/G8W2NMR1Xr266+E6ea6e7kzb3ZWRwF7WiLQeKiSR6ChEmYgKzFEhhKCVhapd3XE2lJ/r5GlfCFNEK3oiQZuBMUT50d+a46UTRbrUNdFUg+67X8lrDb7/SAxFvGpG3a5mWE9AxzeJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=edG+un33; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7955f3d4516so481825485a.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 06:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718632185; x=1719236985; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zEZzvAHWKcqdW88FUmiOeBtiUSRBF94/JlX6CLy/U9k=;
        b=edG+un33NDf/L/gU5FsDbS8KKdaTv0hErGY0U5f+mAWMD4KVQOgIL94GOtbGoPkRe8
         o8K15BmlDN9GCziTgZ/qkiDT0Nn2AEx4Gq77X+7/90F4mJv9f/rSYvy+6MMEa62McGp0
         m08oqunbSfAKMC9npHZfdSgq4F2Mhod5hHi1mnB6oLEUtrpdZosEjd4+saAqW0bzwKKW
         cmnAzCBzme1tCqBaH+W9aB8ER63gerAGljhNkFSpcIya2XKGvvj8jpd5vgvigRWEmxPh
         nmGLZkaycNLi0OdCzEK6SBM8eb+y/J07e0T+F30CUkt0qaPHtJC/i9CymMZJLO/xGMak
         DIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632185; x=1719236985;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEZzvAHWKcqdW88FUmiOeBtiUSRBF94/JlX6CLy/U9k=;
        b=YkvlTLC8yDwGkXAwISowcKuQZFWiG4Te0uy8t/F8GopmVKynxYqC5c6Tpngttu1s35
         lKVp9QN6c/3qpeclsCTSDj1oFdSJvwXiYh+5tqorvk6djhzkAAwr7G7t7yKKLrVFY0z5
         AjUX4iORryb9GVdhF42UDnACgrgXTUWD+jFnliZUsFEsdqRXR4+rviV/oI3SJcWT0iAv
         xZ/KUvsiSwAesj5/2LdqhrfIIDt7vd4PK0rFeBuF9gXwePltm+GyO4BcImbdPFdAf5iz
         ZQyn8qlRCKIwmDEj7RCYJ+sb9dGHfCqoYYZVYpWn5Wahh14eR7n2fV1EvBZanDFH2IQU
         fZsA==
X-Gm-Message-State: AOJu0Yz/1UO314E90jpYi4Oy1QSlmOXQXFiRqlwK63EZK0joFzZSyUBh
	FfMuNnK1xXRq6GMQuyCk+rv+udYC9abBUHRM3UaQJb8XlfNUcBtJu/kh8yF1RoI=
X-Google-Smtp-Source: AGHT+IGl+FE2+2KgsFe4nDCWU6ldgP4GuYAR3dN1AUsj37hFWlNJf2lL8nOBoXUFKBqFYKKh6gBcWA==
X-Received: by 2002:a05:620a:24c9:b0:795:233c:6980 with SMTP id af79cd13be357-79810103071mr2016071085a.20.1718632184654;
        Mon, 17 Jun 2024 06:49:44 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aaecc004sm432892285a.31.2024.06.17.06.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:49:44 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v3 00/41] iio: simplify with regmap_set_bits(),
 regmap_clear_bits()
Date: Mon, 17 Jun 2024 09:49:40 -0400
Message-Id: <20240617-review-v3-0-88d1338c4cca@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPQ+cGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0MTXZCi1HJd81QzgxRDU8tUc9MUJaDigqLUtMwKsEHRsbW1AEPlT+1
 YAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Chen-Yu Tsai <wens@csie.org>, 
 Hans de Goede <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Saravanan Sekar <sravanhome@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Crt Mori <cmo@melexis.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.13.0

Simplify the way regmap is accessed in iio drivers.

Instead of using regmap_update_bits() and passing the mask twice, use
regmap_set_bits().

Instead of using regmap_update_bits() and passing val = 0, use
regmap_clear_bits().

The series is marked as v3, but the previous two revisions were single
patches. There was also a resend of v1 due to not properly CCing the
mailing lists on the first attempt. Trailers were pulled in from those
where relevant.

Link to v2: https://lore.kernel.org/linux-iio/20240613133927.3851344-1-tgamblin@baylibre.com/
Link to v1: https://lore.kernel.org/linux-iio/20240611165214.4091591-1-tgamblin@baylibre.com/

Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
Trevor Gamblin (41):
      iio: accel: fxls8962af-core: Make use of regmap_set_bits(), regmap_clear_bits()
      iio: accel: kxsd9: Make use of regmap_clear_bits()
      iio: accel: msa311: make use of regmap_clear_bits()
      iio: adc: ad4130: make use of regmap_clear_bits()
      iio: adc: axp20x_adc: make use of regmap_set_bits()
      iio: adc: axp288_adc: make use of regmap_set_bits()
      iio: adc: bcm_iproc_adc: make use of regmap_clear_bits()
      iio: adc: berlin2-adc: make use of regmap_clear_bits(), regmap_set_bits()
      iio: adc: cpcap-adc: make use of regmap_clear_bits(), regmap_set_bits()
      iio: adc: fsl-imx25-gcq: make use of regmap_clear_bits(), regmap_set_bits()
      iio: adc: ina2xx-adc: make use of regmap_clear_bits()
      iio: adc: intel_mrfld_adc: make use of regmap_clear_bits()
      iio: adc: meson_saradc: make use of regmap_clear_bits(), regmap_set_bits()
      iio: adc: mp2629_adc: make use of regmap_clear_bits(), regmap_set_bits()
      iio: adc: qcom-spmi-rradc: make use of regmap_clear_bits(), regmap_set_bits()
      iio: adc: rn5t618-adc: make use of regmap_set_bits()
      iio: adc: sc27xx_adc: make use of regmap_clear_bits(), regmap_set_bits()
      iio: adc: stm32-dfsdm-adc: make use of regmap_clear_bits(), regmap_set_bits()
      iio: dac: ltc2688: make use of regmap_set_bits()
      iio: dac: stm32-dac-core: make use of regmap_set_bits()
      iio: gyro: bmg160_core: make use of regmap_clear_bits()
      iio: gyro: mpu3050-core: make use of regmap_clear_bits(), regmap_set_bits()
      iio: health: afe4403: make use of regmap_clear_bits(), regmap_set_bits()
      iio: health: afe4404: make use of regmap_clear_bits(), regmap_set_bits()
      iio: health: max30100: make use of regmap_set_bits()
      iio: health: max30102: make use of regmap_set_bits()
      iio: imu: inv_icm42600: make use of regmap_clear_bits(), regmap_set_bits()
      iio: light: adux1020: make use of regmap_clear_bits(), regmap_set_bits()
      iio: light: iqs621-als: make use of regmap_clear_bits()
      iio: light: isl29018: make use of regmap_clear_bits()
      iio: light: st_uvis25_core: make use of regmap_clear_bits()
      iio: light: veml6030: make use of regmap_clear_bits()
      iio: magnetometer: ak8974: make use of regmap_set_bits()
      iio: magnetometer: mmc35240: make use of regmap_set_bits()
      iio: pressure: bmp280-core: make use of regmap_clear_bits()
      iio: proximity: sx9324: make use of regmap_set_bits()
      iio: proximity: sx9360: make use of regmap_set_bits()
      iio: proximity: sx9500: make use of regmap_clear_bits(), regmap_set_bits()
      iio: proximity: sx_common: make use of regmap_clear_bits(), regmap_set_bits()
      iio: temperature: mlx90632: make use of regmap_clear_bits()
      iio: trigger: stm32-timer-trigger: make use of regmap_clear_bits(), regmap_set_bits()

 drivers/iio/accel/fxls8962af-core.c                |  18 ++--
 drivers/iio/accel/kxsd9.c                          |   6 +-
 drivers/iio/accel/msa311.c                         |   8 +-
 drivers/iio/adc/ad4130.c                           |   4 +-
 drivers/iio/adc/axp20x_adc.c                       |   5 +-
 drivers/iio/adc/axp288_adc.c                       |   4 +-
 drivers/iio/adc/bcm_iproc_adc.c                    |   8 +-
 drivers/iio/adc/berlin2-adc.c                      |  24 +++--
 drivers/iio/adc/cpcap-adc.c                        |  46 ++++------
 drivers/iio/adc/fsl-imx25-gcq.c                    |  16 ++--
 drivers/iio/adc/ina2xx-adc.c                       |   3 +-
 drivers/iio/adc/intel_mrfld_adc.c                  |   4 +-
 drivers/iio/adc/meson_saradc.c                     | 101 +++++++++------------
 drivers/iio/adc/mp2629_adc.c                       |  19 ++--
 drivers/iio/adc/qcom-spmi-rradc.c                  |  50 +++++-----
 drivers/iio/adc/rn5t618-adc.c                      |   5 +-
 drivers/iio/adc/sc27xx_adc.c                       |  41 ++++-----
 drivers/iio/adc/stm32-dfsdm-adc.c                  |  29 +++---
 drivers/iio/dac/ltc2688.c                          |   5 +-
 drivers/iio/dac/stm32-dac-core.c                   |   5 +-
 drivers/iio/gyro/bmg160_core.c                     |   4 +-
 drivers/iio/gyro/mpu3050-core.c                    |  33 +++----
 drivers/iio/health/afe4403.c                       |   9 +-
 drivers/iio/health/afe4404.c                       |   9 +-
 drivers/iio/health/max30100.c                      |   5 +-
 drivers/iio/health/max30102.c                      |   5 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |  14 ++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   |   9 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c    |   4 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c    |   4 +-
 drivers/iio/light/adux1020.c                       |  13 ++-
 drivers/iio/light/iqs621-als.c                     |   4 +-
 drivers/iio/light/isl29018.c                       |   6 +-
 drivers/iio/light/st_uvis25_core.c                 |   4 +-
 drivers/iio/light/veml6030.c                       |   4 +-
 drivers/iio/magnetometer/ak8974.c                  |  11 +--
 drivers/iio/magnetometer/mmc35240.c                |   8 +-
 drivers/iio/pressure/bmp280-core.c                 |   4 +-
 drivers/iio/proximity/sx9324.c                     |   5 +-
 drivers/iio/proximity/sx9360.c                     |   5 +-
 drivers/iio/proximity/sx9500.c                     |  12 +--
 drivers/iio/proximity/sx_common.c                  |   9 +-
 drivers/iio/temperature/mlx90632.c                 |   4 +-
 drivers/iio/trigger/stm32-timer-trigger.c          |  34 ++++---
 44 files changed, 273 insertions(+), 347 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240614-review-7e60d159e75d

Best regards,
-- 
Trevor Gamblin <tgamblin@baylibre.com>


