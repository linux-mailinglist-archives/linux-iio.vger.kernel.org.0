Return-Path: <linux-iio+bounces-17978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D43A86793
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 22:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0A67AC85E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 20:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC99328152A;
	Fri, 11 Apr 2025 20:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="slI5rZjE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C06B281342
	for <linux-iio@vger.kernel.org>; Fri, 11 Apr 2025 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404601; cv=none; b=RD6sNzza9iq9WcrGdHnVoRmvUBaaBubil8FbpK4ae7TP851MEi/vWBwiG92ls5QzbeA3Y5qcPhJS0BrEPTNRFX8NXtQB3DRxgW+iLI4Tub3/suC1GG/pqB3RbWD4sigkgIs5+BuoBuELcTE+wgrj+ORlzApuRTZzBzh8qXKQWRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404601; c=relaxed/simple;
	bh=zq3oMfkCgLC7ttdRiXwWVPz0/CLK4LJ/n5D5uJwkwlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V35oe9LqF7FU4wghVhk8r5ErPXM8JQ+ZVciexyw1bcSzGYpfpMRNt5t7HKj4S0CNcCYeI4ULz25aWgHaDIkymDXnW0DfNBEmZJBc11GV/hx3CsRMYLHLYWtbnA+CBJkJJqo0QYuj/Dw7O4dT1XHMPYlvonNzBjp8CB8rS01fQfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=slI5rZjE; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2c6ed7ec0a5so1118928fac.1
        for <linux-iio@vger.kernel.org>; Fri, 11 Apr 2025 13:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744404590; x=1745009390; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DLwB5hGUbw6N1GDx+/cmEP0jFvIyD0Rs2e5Uo4gS+F8=;
        b=slI5rZjEfuRfVGeRoAVIWPhoLnyru2UquQbws/QO8G1A7jmRKXBz/HFouAh78eUbxX
         eQirMXncHLIPSnGE5F8FqeZsgPB5mTDKNsVDcFRhLdgETdXVsDOtSuXOMpdDgGoXJfvf
         dfsWz3ZAo6sXU6D0PGzRIDwCWrnETpNFxByN84NuMv3umrlcv1mGcy7WDiSxgSDR5OWq
         wcl3KizrtJsKYq64v8/Qn13ItjTPm0zRNaDAhuysduL7QvY2ZU4rqQvw+elXgqon7Z9M
         oTCAWx0Yl7Fc6/RE5cu4FIlXMhJuzwZYkwSS5aktgTNcbG6kmDgbbIdSP/uV+TY4pF2k
         9V3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744404590; x=1745009390;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLwB5hGUbw6N1GDx+/cmEP0jFvIyD0Rs2e5Uo4gS+F8=;
        b=lVo+rh3eIQI0N2VX+VC1wUOqlZriauE0mf7MarXkQnI5c5HtMHoBRe8MKpmIjHH82l
         gLp1bLXdFPPmgDLFFthHFuLKE55SzPgCtgfGQ5k1T+j5NKA4DNXgbXcTYvngxeWJq/rZ
         Z/0Q2W2N4PM/Cr1IvYg425glzlr4g+z+GpeSGxhkm1ExjZku6xpKPAz7AcBuIQpBO1oL
         VlU3CE4ngpL9G+zb3cda+xI1jcS3QtQbSYqs3v81C3COPkR+jxPJUFZ7AOSDavqpgsXl
         QXzMTdAlUQjqBr3vgODGk+l1SAgcxZmpdhX7W57h9GqTeT+IlCcNA7xryWQcSgAGoteT
         DcYQ==
X-Gm-Message-State: AOJu0Yzf02XofJW/6w5mI9Ia+p6oYthYxTd6tEjzBpIh2rtsuVFoJWpX
	T1lvv8dW+mbimv6BfSevnX37NU2O06FJ785Uw1NkfGC7GflN/LCg4SPvEjcz1OU=
X-Gm-Gg: ASbGncsdZPyvqbraKMtU3IyfXxqIv0pnr6YzRFAiPwfTOiG0xUr4kT3ZJuKLpgsnBHi
	VpemGOVGaLbRX9gSZqhC7Z5IFFkxry0vumCtsNhMPxlB8tmuNlLCFcqObAh4EQUIwnWIKUllPqC
	kchQU5n8cM0xPt8xStUUbO8gqn25ZjlKzCWxdno97bs1oMWHSUIC71FsvE1HXfuz8rSWUwDWMLr
	nJr66AuvGOvvZrkUVG0I/EawK1p8jqMcpm6C8PKgIKNlc8pT+5nX0Z6aeaXMGi0Z9lwQY7GVxJL
	xeayAGTxOtH9qcbviRuNJ/0IolWB114AnMrH/inUUXNSDC7OBtDHKNFOfFPvEDCYCFGfCJWnIxj
	3K8DwhRw=
X-Google-Smtp-Source: AGHT+IF9zXlDSyFttKNL6s2+lgmNuZ6TfkS7QQEKyyyHZUYoHjEhj7K/W2VVrGuXb3iFdnVo5JTZ9w==
X-Received: by 2002:a05:6870:b9ce:b0:2c8:34df:8c4f with SMTP id 586e51a60fabf-2d0d5fc1a9fmr2280481fac.37.1744404589102;
        Fri, 11 Apr 2025 13:49:49 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d096cd2528sm1316316fac.36.2025.04.11.13.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 13:49:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 11 Apr 2025 15:49:34 -0500
Subject: [PATCH] iio: normalize array sentinel style
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-iio-sentinel-normalization-v1-1-d293de3e3d93@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAF2A+WcC/x3MywqDMBBG4VeRWXcg8d6+SnERddQf7KQkUkTx3
 RtcfotzTooSIJFe2UlBfojwmmAfGQ2L01kYYzLlJq9MaS0DnqPoBpWV1YePW3G4LWX8rPqmtW1
 txqKhNPgGmbDf83d3XX8W0W/ubAAAAA==
X-Change-ID: 20250411-iio-sentinel-normalization-95b781860d37
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-staging@lists.linux.dev, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=212137;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=zq3oMfkCgLC7ttdRiXwWVPz0/CLK4LJ/n5D5uJwkwlw=;
 b=kA0DAAoBwswgAf8Bj8AByyZiAGf5gGOhqFlEEkKDaDgB9glZPWmm1wZ7/Tg+J2EYysfv1YzFb
 YkBMwQAAQoAHRYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJn+YBjAAoJEMLMIAH/AY/AzZ0H/RVf
 cvyZZqjzOaLS6IRlrY2f/4keBwg+kyJKd6krlN6JbXe6432ZgU4KrXx5ROwyYy1vjPLEVYUErfl
 69eW4YR9Ucs4+DZc78okrY8ckkqezGQVzMgLM1Q8yXPvScQJjObJEEa+OiyvbUJNDI3nha1pbCe
 fiqya5PX2Q+6yxGwS1XWUZlAVt6szVvHZiTlty8jaXKJmRvdSmyY2Q7Pk3B/rI/ONl8CR727pvB
 hvgpWhXdrieAb8tcgO8kqXyQmcc++Zj+5BqhzTOv9rMDAgjLG2y9R0X8EQTXnb4bOUFZr4L8k4Y
 JwctNPIwrdFd6pbAyYKJM5tVvPOlQFdSFSI95ck=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use `\t(\{ ?\},|\{\}|\{\s*/\*.*\*/\s*\},?)$` regex to find and replace
the array sentinel in all IIO drivers to the same style.

For some time, we've been trying to consistently use `{ }` (no trailing
comma, no comment, one space between braces) for array sentinels in the
IIO subsystem. Still nearly 50% of existing code uses a different style.
To save reviewers from having to request this trivial change as
frequently, let's normalize the style in all existing IIO drivers.
At least when code is copy/pasted to new drivers, the style will be
consistent.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This seems to come up in nearly every new driver, so maybe best to just
clean this up once and for all. I didn't bother cc'ing all the
individual maintainers since the list was quite long and the change
is trivial.
---
 drivers/iio/accel/adxl367_i2c.c                           |  2 +-
 drivers/iio/accel/adxl367_spi.c                           |  4 ++--
 drivers/iio/accel/adxl372_i2c.c                           |  2 +-
 drivers/iio/accel/adxl372_spi.c                           |  2 +-
 drivers/iio/accel/bma220_spi.c                            |  4 ++--
 drivers/iio/accel/bmc150-accel-i2c.c                      |  6 +++---
 drivers/iio/accel/bmc150-accel-spi.c                      |  4 ++--
 drivers/iio/accel/bmi088-accel-i2c.c                      |  4 ++--
 drivers/iio/accel/bmi088-accel-spi.c                      |  4 ++--
 drivers/iio/accel/da280.c                                 |  4 ++--
 drivers/iio/accel/da311.c                                 |  2 +-
 drivers/iio/accel/dmard10.c                               |  2 +-
 drivers/iio/accel/fxls8962af-i2c.c                        |  4 ++--
 drivers/iio/accel/fxls8962af-spi.c                        |  4 ++--
 drivers/iio/accel/hid-sensor-accel-3d.c                   |  2 +-
 drivers/iio/accel/kxsd9-i2c.c                             |  2 +-
 drivers/iio/accel/kxsd9-spi.c                             |  2 +-
 drivers/iio/accel/kxsd9.c                                 |  2 +-
 drivers/iio/accel/mma7660.c                               |  4 ++--
 drivers/iio/accel/mma9551.c                               |  4 ++--
 drivers/iio/accel/mma9553.c                               |  6 +++---
 drivers/iio/accel/mxc4005.c                               |  4 ++--
 drivers/iio/accel/sca3000.c                               |  2 +-
 drivers/iio/accel/sca3300.c                               |  4 ++--
 drivers/iio/accel/st_accel_i2c.c                          |  6 +++---
 drivers/iio/accel/st_accel_spi.c                          |  4 ++--
 drivers/iio/accel/stk8312.c                               |  2 +-
 drivers/iio/accel/stk8ba50.c                              |  4 ++--
 drivers/iio/adc/ad7280a.c                                 |  2 +-
 drivers/iio/adc/ad7768-1.c                                |  2 +-
 drivers/iio/adc/ad7791.c                                  |  2 +-
 drivers/iio/adc/ad799x.c                                  |  2 +-
 drivers/iio/adc/adi-axi-adc.c                             |  2 +-
 drivers/iio/adc/axp20x_adc.c                              |  8 ++++----
 drivers/iio/adc/axp288_adc.c                              |  4 ++--
 drivers/iio/adc/cpcap-adc.c                               |  2 +-
 drivers/iio/adc/da9150-gpadc.c                            |  2 +-
 drivers/iio/adc/envelope-detector.c                       |  4 ++--
 drivers/iio/adc/fsl-imx25-gcq.c                           |  2 +-
 drivers/iio/adc/hi8435.c                                  |  2 +-
 drivers/iio/adc/imx7d_adc.c                               |  2 +-
 drivers/iio/adc/imx8qxp-adc.c                             |  2 +-
 drivers/iio/adc/imx93_adc.c                               |  2 +-
 drivers/iio/adc/intel_mrfld_adc.c                         |  4 ++--
 drivers/iio/adc/lpc18xx_adc.c                             |  2 +-
 drivers/iio/adc/ltc2471.c                                 |  2 +-
 drivers/iio/adc/max1363.c                                 |  4 ++--
 drivers/iio/adc/max77541-adc.c                            |  2 +-
 drivers/iio/adc/meson_saradc.c                            |  2 +-
 drivers/iio/adc/mt6359-auxadc.c                           |  2 +-
 drivers/iio/adc/mt6370-adc.c                              |  2 +-
 drivers/iio/adc/npcm_adc.c                                |  2 +-
 drivers/iio/adc/pac1921.c                                 |  4 ++--
 drivers/iio/adc/palmas_gpadc.c                            |  2 +-
 drivers/iio/adc/rcar-gyroadc.c                            |  2 +-
 drivers/iio/adc/rn5t618-adc.c                             |  2 +-
 drivers/iio/adc/rzg2l_adc.c                               |  2 +-
 drivers/iio/adc/spear_adc.c                               |  2 +-
 drivers/iio/adc/stm32-adc.c                               |  4 ++--
 drivers/iio/adc/stm32-dfsdm-adc.c                         |  8 ++++----
 drivers/iio/adc/sun20i-gpadc-iio.c                        |  2 +-
 drivers/iio/adc/sun4i-gpadc-iio.c                         |  6 +++---
 drivers/iio/adc/ti-adc128s052.c                           |  2 +-
 drivers/iio/adc/ti-lmp92064.c                             |  2 +-
 drivers/iio/adc/twl6030-gpadc.c                           |  2 +-
 drivers/iio/adc/vf610_adc.c                               |  4 ++--
 drivers/iio/adc/xilinx-xadc-core.c                        |  2 +-
 drivers/iio/addac/ad74413r.c                              |  4 ++--
 drivers/iio/afe/iio-rescale.c                             |  2 +-
 drivers/iio/amplifiers/ad8366.c                           |  2 +-
 drivers/iio/amplifiers/ada4250.c                          |  4 ++--
 drivers/iio/amplifiers/hmc425a.c                          |  4 ++--
 drivers/iio/cdc/ad7150.c                                  |  4 ++--
 drivers/iio/cdc/ad7746.c                                  |  4 ++--
 drivers/iio/chemical/ags02ma.c                            |  4 ++--
 drivers/iio/chemical/atlas-ezo-sensor.c                   |  4 ++--
 drivers/iio/chemical/atlas-sensor.c                       |  2 +-
 drivers/iio/chemical/bme680_i2c.c                         |  4 ++--
 drivers/iio/chemical/bme680_spi.c                         |  4 ++--
 drivers/iio/chemical/sunrise_co2.c                        |  4 ++--
 drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c    |  2 +-
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c      |  2 +-
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c |  2 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c                |  4 ++--
 drivers/iio/common/ssp_sensors/ssp_dev.c                  |  2 +-
 drivers/iio/dac/ad5064.c                                  |  8 ++++----
 drivers/iio/dac/ad5360.c                                  |  2 +-
 drivers/iio/dac/ad5380.c                                  |  2 +-
 drivers/iio/dac/ad5446.c                                  |  6 +++---
 drivers/iio/dac/ad5449.c                                  |  2 +-
 drivers/iio/dac/ad5504.c                                  |  4 ++--
 drivers/iio/dac/ad5592r-base.c                            |  2 +-
 drivers/iio/dac/ad5592r.c                                 |  6 +++---
 drivers/iio/dac/ad5593r.c                                 |  6 +++---
 drivers/iio/dac/ad5624r_spi.c                             |  4 ++--
 drivers/iio/dac/ad5686-spi.c                              |  2 +-
 drivers/iio/dac/ad5686.c                                  |  2 +-
 drivers/iio/dac/ad5696-i2c.c                              |  4 ++--
 drivers/iio/dac/ad5755.c                                  |  4 ++--
 drivers/iio/dac/ad5758.c                                  |  2 +-
 drivers/iio/dac/ad5761.c                                  |  2 +-
 drivers/iio/dac/ad5766.c                                  |  6 +++---
 drivers/iio/dac/ad5770r.c                                 |  4 ++--
 drivers/iio/dac/ad5791.c                                  |  2 +-
 drivers/iio/dac/ad7293.c                                  |  4 ++--
 drivers/iio/dac/ad7303.c                                  |  6 +++---
 drivers/iio/dac/ad8801.c                                  |  2 +-
 drivers/iio/dac/ad9739a.c                                 |  4 ++--
 drivers/iio/dac/adi-axi-dac.c                             |  4 ++--
 drivers/iio/dac/dpot-dac.c                                |  2 +-
 drivers/iio/dac/ds4424.c                                  |  2 +-
 drivers/iio/dac/lpc18xx_dac.c                             |  2 +-
 drivers/iio/dac/ltc1660.c                                 |  4 ++--
 drivers/iio/dac/ltc2632.c                                 |  6 +++---
 drivers/iio/dac/ltc2688.c                                 | 12 ++++++------
 drivers/iio/dac/max5522.c                                 |  4 ++--
 drivers/iio/dac/max5821.c                                 |  2 +-
 drivers/iio/dac/mcp4725.c                                 |  4 ++--
 drivers/iio/dac/mcp4728.c                                 |  6 +++---
 drivers/iio/dac/mcp4821.c                                 |  4 ++--
 drivers/iio/dac/mcp4922.c                                 |  2 +-
 drivers/iio/dac/stm32-dac-core.c                          |  2 +-
 drivers/iio/dac/stm32-dac.c                               |  4 ++--
 drivers/iio/dac/ti-dac082s085.c                           |  2 +-
 drivers/iio/dac/ti-dac5571.c                              |  6 +++---
 drivers/iio/dac/ti-dac7311.c                              |  2 +-
 drivers/iio/dac/ti-dac7612.c                              |  4 ++--
 drivers/iio/dac/vf610_dac.c                               |  4 ++--
 drivers/iio/filter/admv8818.c                             |  6 +++---
 drivers/iio/frequency/ad9523.c                            |  2 +-
 drivers/iio/frequency/adf4350.c                           |  6 +++---
 drivers/iio/frequency/adf4371.c                           |  6 +++---
 drivers/iio/frequency/adf4377.c                           |  4 ++--
 drivers/iio/frequency/admv1013.c                          |  6 +++---
 drivers/iio/frequency/admv1014.c                          |  4 ++--
 drivers/iio/frequency/adrf6780.c                          |  4 ++--
 drivers/iio/gyro/adis16080.c                              |  2 +-
 drivers/iio/gyro/adis16260.c                              |  2 +-
 drivers/iio/gyro/adxrs450.c                               |  2 +-
 drivers/iio/gyro/bmg160_i2c.c                             |  4 ++--
 drivers/iio/gyro/bmg160_spi.c                             |  2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c                     |  2 +-
 drivers/iio/gyro/mpu3050-core.c                           |  2 +-
 drivers/iio/gyro/mpu3050-i2c.c                            |  4 ++--
 drivers/iio/gyro/st_gyro_i2c.c                            |  4 ++--
 drivers/iio/gyro/st_gyro_spi.c                            |  4 ++--
 drivers/iio/health/afe4403.c                              |  4 ++--
 drivers/iio/health/afe4404.c                              |  4 ++--
 drivers/iio/health/max30100.c                             |  2 +-
 drivers/iio/health/max30102.c                             |  2 +-
 drivers/iio/humidity/am2315.c                             |  2 +-
 drivers/iio/humidity/hid-sensor-humidity.c                |  2 +-
 drivers/iio/humidity/hts221_i2c.c                         |  6 +++---
 drivers/iio/humidity/hts221_spi.c                         |  4 ++--
 drivers/iio/humidity/htu21.c                              |  4 ++--
 drivers/iio/imu/adis16400.c                               |  2 +-
 drivers/iio/imu/adis16460.c                               |  4 ++--
 drivers/iio/imu/adis16475.c                               |  2 +-
 drivers/iio/imu/adis16480.c                               |  2 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                       |  6 +++---
 drivers/iio/imu/bmi160/bmi160_spi.c                       |  6 +++---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c         |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c          |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c           |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c           |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c                |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c                 |  4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c                 |  4 ++--
 drivers/iio/imu/kmx61.c                                   |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c               |  6 +++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c               |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c               |  4 ++--
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c               |  6 +++---
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c               |  4 ++--
 drivers/iio/light/acpi-als.c                              |  2 +-
 drivers/iio/light/adux1020.c                              |  2 +-
 drivers/iio/light/al3000a.c                               |  2 +-
 drivers/iio/light/al3010.c                                |  4 ++--
 drivers/iio/light/al3320a.c                               |  6 +++---
 drivers/iio/light/apds9960.c                              |  2 +-
 drivers/iio/light/bh1780.c                                |  2 +-
 drivers/iio/light/cm3232.c                                |  4 ++--
 drivers/iio/light/cm3323.c                                |  4 ++--
 drivers/iio/light/cm3605.c                                |  2 +-
 drivers/iio/light/cros_ec_light_prox.c                    |  2 +-
 drivers/iio/light/gp2ap002.c                              |  2 +-
 drivers/iio/light/hid-sensor-als.c                        |  2 +-
 drivers/iio/light/hid-sensor-prox.c                       |  2 +-
 drivers/iio/light/isl29018.c                              |  4 ++--
 drivers/iio/light/isl29028.c                              |  4 ++--
 drivers/iio/light/jsa1212.c                               |  2 +-
 drivers/iio/light/ltr390.c                                |  4 ++--
 drivers/iio/light/ltr501.c                                |  6 +++---
 drivers/iio/light/ltrf216a.c                              |  4 ++--
 drivers/iio/light/opt4001.c                               |  2 +-
 drivers/iio/light/pa12203001.c                            |  4 ++--
 drivers/iio/light/st_uvis25_i2c.c                         |  4 ++--
 drivers/iio/light/st_uvis25_spi.c                         |  4 ++--
 drivers/iio/light/stk3310.c                               |  8 ++++----
 drivers/iio/light/tsl2563.c                               |  4 ++--
 drivers/iio/light/tsl2583.c                               |  4 ++--
 drivers/iio/light/tsl2591.c                               |  2 +-
 drivers/iio/light/tsl2772.c                               |  4 ++--
 drivers/iio/light/us5182d.c                               |  6 +++---
 drivers/iio/light/vcnl4000.c                              |  4 ++--
 drivers/iio/light/veml6040.c                              |  4 ++--
 drivers/iio/light/veml6075.c                              |  2 +-
 drivers/iio/light/vl6180.c                                |  2 +-
 drivers/iio/magnetometer/ak8974.c                         |  6 +++---
 drivers/iio/magnetometer/ak8975.c                         |  4 ++--
 drivers/iio/magnetometer/als31300.c                       |  4 ++--
 drivers/iio/magnetometer/bmc150_magn_i2c.c                |  2 +-
 drivers/iio/magnetometer/bmc150_magn_spi.c                |  2 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c             |  2 +-
 drivers/iio/magnetometer/hmc5843_i2c.c                    |  2 +-
 drivers/iio/magnetometer/mmc35240.c                       |  4 ++--
 drivers/iio/magnetometer/st_magn_i2c.c                    |  4 ++--
 drivers/iio/magnetometer/st_magn_spi.c                    |  4 ++--
 drivers/iio/magnetometer/tmag5273.c                       |  4 ++--
 drivers/iio/magnetometer/yamaha-yas530.c                  |  4 ++--
 drivers/iio/multiplexer/iio-mux.c                         |  2 +-
 drivers/iio/orientation/hid-sensor-incl-3d.c              |  2 +-
 drivers/iio/orientation/hid-sensor-rotation.c             |  2 +-
 drivers/iio/position/hid-sensor-custom-intel-hinge.c      |  2 +-
 drivers/iio/potentiometer/ad5272.c                        |  4 ++--
 drivers/iio/potentiometer/ds1803.c                        |  4 ++--
 drivers/iio/potentiometer/max5432.c                       |  2 +-
 drivers/iio/potentiometer/max5487.c                       |  2 +-
 drivers/iio/potentiometer/mcp4018.c                       |  4 ++--
 drivers/iio/potentiometer/mcp41010.c                      |  4 ++--
 drivers/iio/potentiometer/mcp4131.c                       |  4 ++--
 drivers/iio/potentiometer/mcp4531.c                       |  4 ++--
 drivers/iio/potentiometer/tpl0102.c                       |  2 +-
 drivers/iio/potentiostat/lmp91000.c                       |  4 ++--
 drivers/iio/pressure/abp060mg.c                           |  2 +-
 drivers/iio/pressure/bmp280-i2c.c                         |  4 ++--
 drivers/iio/pressure/bmp280-spi.c                         |  2 +-
 drivers/iio/pressure/cros_ec_baro.c                       |  2 +-
 drivers/iio/pressure/dlhl60d.c                            |  4 ++--
 drivers/iio/pressure/dps310.c                             |  4 ++--
 drivers/iio/pressure/hid-sensor-press.c                   |  2 +-
 drivers/iio/pressure/hp03.c                               |  2 +-
 drivers/iio/pressure/hp206c.c                             |  4 ++--
 drivers/iio/pressure/hsc030pa_i2c.c                       |  4 ++--
 drivers/iio/pressure/hsc030pa_spi.c                       |  4 ++--
 drivers/iio/pressure/mpl115_spi.c                         |  2 +-
 drivers/iio/pressure/mprls0025pa_i2c.c                    |  4 ++--
 drivers/iio/pressure/mprls0025pa_spi.c                    |  4 ++--
 drivers/iio/pressure/ms5637.c                             |  4 ++--
 drivers/iio/pressure/rohm-bm1390.c                        |  4 ++--
 drivers/iio/pressure/st_pressure_i2c.c                    |  6 +++---
 drivers/iio/pressure/st_pressure_spi.c                    |  4 ++--
 drivers/iio/pressure/zpa2326_spi.c                        |  2 +-
 drivers/iio/proximity/as3935.c                            |  4 ++--
 drivers/iio/proximity/cros_ec_mkbp_proximity.c            |  2 +-
 drivers/iio/proximity/hx9023s.c                           |  4 ++--
 drivers/iio/proximity/irsd200.c                           |  2 +-
 drivers/iio/proximity/isl29501.c                          |  4 ++--
 drivers/iio/proximity/mb1232.c                            |  2 +-
 drivers/iio/proximity/ping.c                              |  2 +-
 drivers/iio/proximity/srf04.c                             |  2 +-
 drivers/iio/proximity/srf08.c                             |  2 +-
 drivers/iio/proximity/sx9310.c                            |  6 +++---
 drivers/iio/proximity/sx9324.c                            |  2 +-
 drivers/iio/proximity/sx9500.c                            |  4 ++--
 drivers/iio/proximity/vcnl3020.c                          |  2 +-
 drivers/iio/resolver/ad2s1200.c                           |  2 +-
 drivers/iio/resolver/ad2s1210.c                           |  2 +-
 drivers/iio/resolver/ad2s90.c                             |  4 ++--
 drivers/iio/temperature/hid-sensor-temperature.c          |  2 +-
 drivers/iio/temperature/ltc2983.c                         |  4 ++--
 drivers/iio/temperature/maxim_thermocouple.c              |  2 +-
 drivers/iio/temperature/mcp9600.c                         |  4 ++--
 drivers/iio/temperature/tmp007.c                          |  2 +-
 drivers/iio/temperature/tsys01.c                          |  4 ++--
 drivers/iio/temperature/tsys02d.c                         |  2 +-
 drivers/iio/test/iio-test-format.c                        |  2 +-
 drivers/iio/test/iio-test-gts.c                           |  2 +-
 drivers/iio/test/iio-test-rescale.c                       |  2 +-
 drivers/iio/trigger/stm32-lptimer-trigger.c               |  2 +-
 drivers/iio/trigger/stm32-timer-trigger.c                 |  4 ++--
 drivers/staging/iio/accel/adis16203.c                     |  2 +-
 drivers/staging/iio/adc/ad7816.c                          |  2 +-
 drivers/staging/iio/addac/adt7316-i2c.c                   |  2 +-
 drivers/staging/iio/frequency/ad9832.c                    |  2 +-
 drivers/staging/iio/frequency/ad9834.c                    |  4 ++--
 drivers/staging/iio/impedance-analyzer/ad5933.c           |  4 ++--
 tools/iio/iio_generic_buffer.c                            |  2 +-
 288 files changed, 473 insertions(+), 473 deletions(-)

diff --git a/drivers/iio/accel/adxl367_i2c.c b/drivers/iio/accel/adxl367_i2c.c
index 80f0b642b9b0a593ff8c7565c42aebf1675f83fe..1c7d2eb054a21ff1fd222a0d12af501af7f37b01 100644
--- a/drivers/iio/accel/adxl367_i2c.c
+++ b/drivers/iio/accel/adxl367_i2c.c
@@ -68,7 +68,7 @@ MODULE_DEVICE_TABLE(i2c, adxl367_i2c_id);
 
 static const struct of_device_id adxl367_of_match[] = {
 	{ .compatible = "adi,adxl367" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adxl367_of_match);
 
diff --git a/drivers/iio/accel/adxl367_spi.c b/drivers/iio/accel/adxl367_spi.c
index 49d7c8fbe8edc8ee21daf2acb005e39cc613fb7a..3fed56bb905454b0fb0fea2355d9167c60916ba8 100644
--- a/drivers/iio/accel/adxl367_spi.c
+++ b/drivers/iio/accel/adxl367_spi.c
@@ -139,13 +139,13 @@ static int adxl367_spi_probe(struct spi_device *spi)
 
 static const struct spi_device_id adxl367_spi_id[] = {
 	{ "adxl367", 0 },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, adxl367_spi_id);
 
 static const struct of_device_id adxl367_of_match[] = {
 	{ .compatible = "adi,adxl367" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adxl367_of_match);
 
diff --git a/drivers/iio/accel/adxl372_i2c.c b/drivers/iio/accel/adxl372_i2c.c
index 43d5fd921be7b9d531976a81aff4bc1068361718..186d4fe9a556a0713bfa3c22c06ca1a4ea427678 100644
--- a/drivers/iio/accel/adxl372_i2c.c
+++ b/drivers/iio/accel/adxl372_i2c.c
@@ -43,7 +43,7 @@ static int adxl372_i2c_probe(struct i2c_client *client)
 
 static const struct i2c_device_id adxl372_i2c_id[] = {
 	{ "adxl372" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adxl372_i2c_id);
 
diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
index 1ab1997a55b1f828a1cc2b3be2243c6efb35ea6f..39941b519c3bba7b46b1ebd3a3a9d0fb04ced891 100644
--- a/drivers/iio/accel/adxl372_spi.c
+++ b/drivers/iio/accel/adxl372_spi.c
@@ -34,7 +34,7 @@ static int adxl372_spi_probe(struct spi_device *spi)
 
 static const struct spi_device_id adxl372_spi_id[] = {
 	{ "adxl372", 0 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, adxl372_spi_id);
 
diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 96ba028157ee50bc4edfc6e6ed4801a0ca3bfee5..978108fb74e9607aba6f4eb8fea7d94fc6f58da4 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -307,12 +307,12 @@ static DEFINE_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume);
 
 static const struct spi_device_id bma220_spi_id[] = {
 	{"bma220", 0},
-	{}
+	{ }
 };
 
 static const struct acpi_device_id bma220_acpi_id[] = {
 	{"BMA0220", 0},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, bma220_spi_id);
 
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index 0d4ce6c389317209f1b3cdf5cec913dafc876023..b4604f441553b259a9285d478f9cb0c02cbb4581 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -240,7 +240,7 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
 	{"BOSC0200"},
 	{"BSBA0150"},
 	{"DUAL250E"},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
 
@@ -255,7 +255,7 @@ static const struct i2c_device_id bmc150_accel_id[] = {
 	{"bmc150_accel"},
 	{"bmc156_accel", BOSCH_BMC156},
 	{"bmi055_accel"},
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, bmc150_accel_id);
@@ -271,7 +271,7 @@ static const struct of_device_id bmc150_accel_of_match[] = {
 	{ .compatible = "bosch,bmc150_accel" },
 	{ .compatible = "bosch,bmc156_accel" },
 	{ .compatible = "bosch,bmi055_accel" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, bmc150_accel_of_match);
 
diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/bmc150-accel-spi.c
index 70b3642656abcd6120807ae8f34a4e65a78dc884..26ce50b37716cab2aac1303e2e7f28909ea3d3f3 100644
--- a/drivers/iio/accel/bmc150-accel-spi.c
+++ b/drivers/iio/accel/bmc150-accel-spi.c
@@ -48,7 +48,7 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
 	{"BMC150A"},
 	{"BMI055A"},
 	{"BSBA0150"},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
 
@@ -62,7 +62,7 @@ static const struct spi_device_id bmc150_accel_id[] = {
 	{"bmc150_accel"},
 	{"bmc156_accel", BOSCH_BMC156},
 	{"bmi055_accel"},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, bmc150_accel_id);
 
diff --git a/drivers/iio/accel/bmi088-accel-i2c.c b/drivers/iio/accel/bmi088-accel-i2c.c
index bd22bd0d3c250da8e2e161685cf0a8d7926eb42c..310f863029bb1fd05f87d9ee8bfe338246e371ea 100644
--- a/drivers/iio/accel/bmi088-accel-i2c.c
+++ b/drivers/iio/accel/bmi088-accel-i2c.c
@@ -40,7 +40,7 @@ static const struct of_device_id bmi088_of_match[] = {
 	{ .compatible = "bosch,bmi085-accel" },
 	{ .compatible = "bosch,bmi088-accel" },
 	{ .compatible = "bosch,bmi090l-accel" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, bmi088_of_match);
 
@@ -48,7 +48,7 @@ static const struct i2c_device_id bmi088_accel_id[] = {
 	{ "bmi085-accel",  BOSCH_BMI085 },
 	{ "bmi088-accel",  BOSCH_BMI088 },
 	{ "bmi090l-accel", BOSCH_BMI090L },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bmi088_accel_id);
 
diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
index c9d51a74c07fbbc214d704eb804a09d85ac08929..44cb50c76cb1beac198630d92c95d0321e6ca188 100644
--- a/drivers/iio/accel/bmi088-accel-spi.c
+++ b/drivers/iio/accel/bmi088-accel-spi.c
@@ -67,7 +67,7 @@ static const struct of_device_id bmi088_of_match[] = {
 	{ .compatible = "bosch,bmi085-accel" },
 	{ .compatible = "bosch,bmi088-accel" },
 	{ .compatible = "bosch,bmi090l-accel" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, bmi088_of_match);
 
@@ -75,7 +75,7 @@ static const struct spi_device_id bmi088_accel_id[] = {
 	{"bmi085-accel",  BOSCH_BMI085},
 	{"bmi088-accel",  BOSCH_BMI088},
 	{"bmi090l-accel", BOSCH_BMI090L},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, bmi088_accel_id);
 
diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index 9922868288449cc9f85cf6cf53a351d84c5acc49..c2dd123b90219799ddbbb1a1a340b2b945524137 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -157,7 +157,7 @@ static const struct da280_match_data da280_match_data = { "da280", 3 };
 static const struct acpi_device_id da280_acpi_match[] = {
 	{ "NSA2513", (kernel_ulong_t)&da217_match_data },
 	{ "MIRAACC", (kernel_ulong_t)&da280_match_data },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, da280_acpi_match);
 
@@ -165,7 +165,7 @@ static const struct i2c_device_id da280_i2c_id[] = {
 	{ "da217", (kernel_ulong_t)&da217_match_data },
 	{ "da226", (kernel_ulong_t)&da226_match_data },
 	{ "da280", (kernel_ulong_t)&da280_match_data },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, da280_i2c_id);
 
diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
index 94f827acdd1c9fc7245287417b6a32567a995ea1..e1df7b009d895c8276e856f72727191f78dd3786 100644
--- a/drivers/iio/accel/da311.c
+++ b/drivers/iio/accel/da311.c
@@ -269,7 +269,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(da311_pm_ops, da311_suspend, da311_resume);
 
 static const struct i2c_device_id da311_i2c_id[] = {
 	{ "da311" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, da311_i2c_id);
 
diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
index 35c0eefb741e997fe9f533c441327e57ec5c1ff8..71cd1928baa62cb0d50eeb0f478dace789391930 100644
--- a/drivers/iio/accel/dmard10.c
+++ b/drivers/iio/accel/dmard10.c
@@ -232,7 +232,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(dmard10_pm_ops, dmard10_suspend,
 
 static const struct i2c_device_id dmard10_i2c_id[] = {
 	{ "dmard10" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, dmard10_i2c_id);
 
diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
index 1b9156b6b2e3093f433961a41dbbfdde15616000..106198a12474490da3685e826830c5fcefc856ef 100644
--- a/drivers/iio/accel/fxls8962af-i2c.c
+++ b/drivers/iio/accel/fxls8962af-i2c.c
@@ -32,14 +32,14 @@ static const struct i2c_device_id fxls8962af_id[] = {
 	{ "fxls8964af", fxls8964af },
 	{ "fxls8967af", fxls8967af },
 	{ "fxls8974cf", fxls8974cf },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
 
 static const struct of_device_id fxls8962af_of_match[] = {
 	{ .compatible = "nxp,fxls8962af" },
 	{ .compatible = "nxp,fxls8964af" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, fxls8962af_of_match);
 
diff --git a/drivers/iio/accel/fxls8962af-spi.c b/drivers/iio/accel/fxls8962af-spi.c
index 46fc6e002714f6893c5e22b11de315465a26a17f..bdafd1f615d90f4837cdfe1b0d650fe14032f18e 100644
--- a/drivers/iio/accel/fxls8962af-spi.c
+++ b/drivers/iio/accel/fxls8962af-spi.c
@@ -30,14 +30,14 @@ static int fxls8962af_probe(struct spi_device *spi)
 static const struct of_device_id fxls8962af_spi_of_match[] = {
 	{ .compatible = "nxp,fxls8962af" },
 	{ .compatible = "nxp,fxls8964af" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, fxls8962af_spi_of_match);
 
 static const struct spi_device_id fxls8962af_spi_id_table[] = {
 	{ "fxls8962af", fxls8962af },
 	{ "fxls8964af", fxls8964af },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, fxls8962af_spi_id_table);
 
diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 078fab2abb68bfcfd073b2cc9443f7a2ae85cc5a..3214506d133df0b692fd1e9e4d9797aeb8611235 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -440,7 +440,7 @@ static const struct platform_device_id hid_accel_3d_ids[] = {
 	{	/* gravity sensor */
 		.name = "HID-SENSOR-20007b",
 	},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, hid_accel_3d_ids);
 
diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
index 3857d2edf25075381a8872bc973861ab500f9e13..1fa88b99149e7f3c8051859a98c360e8d8209ee6 100644
--- a/drivers/iio/accel/kxsd9-i2c.c
+++ b/drivers/iio/accel/kxsd9-i2c.c
@@ -38,7 +38,7 @@ static void kxsd9_i2c_remove(struct i2c_client *client)
 
 static const struct of_device_id kxsd9_of_match[] = {
 	{ .compatible = "kionix,kxsd9", },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, kxsd9_of_match);
 
diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
index a05f4467d94a4a8bc0a0139183600ecc444a8fc9..cbb6c64126654a95209d79b004328aea25e746b0 100644
--- a/drivers/iio/accel/kxsd9-spi.c
+++ b/drivers/iio/accel/kxsd9-spi.c
@@ -38,7 +38,7 @@ static void kxsd9_spi_remove(struct spi_device *spi)
 
 static const struct spi_device_id kxsd9_spi_id[] = {
 	{"kxsd9", 0},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, kxsd9_spi_id);
 
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 0ededf8cfdca6bf390ace701ca11433a92549758..fb14b875e20d0de9f43308aadf2fd09393cf0ed9 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -273,7 +273,7 @@ kxsd9_get_mount_matrix(const struct iio_dev *indio_dev,
 
 static const struct iio_chan_spec_ext_info kxsd9_ext_info[] = {
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, kxsd9_get_mount_matrix),
-	{ },
+	{ }
 };
 
 #define KXSD9_ACCEL_CHAN(axis, index)						\
diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index 2894aff80161fac32f2ccc00e45c577c7546476d..d0a16f227903531ed968408e884a53149505fb7e 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -262,7 +262,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(mma7660_pm_ops, mma7660_suspend,
 
 static const struct i2c_device_id mma7660_i2c_id[] = {
 	{ "mma7660" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mma7660_i2c_id);
 
@@ -274,7 +274,7 @@ MODULE_DEVICE_TABLE(of, mma7660_of_match);
 
 static const struct acpi_device_id mma7660_acpi_id[] = {
 	{"MMA7660", 0},
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(acpi, mma7660_acpi_id);
diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 1b96687da01a695d9fce7ff7fd9afcd4d9b5fbbb..b89bad9e6fe6224a7c2c73d34b80d1e4be838138 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -578,14 +578,14 @@ static const struct dev_pm_ops mma9551_pm_ops = {
 
 static const struct acpi_device_id mma9551_acpi_match[] = {
 	{"MMA9551", 0},
-	{},
+	{ }
 };
 
 MODULE_DEVICE_TABLE(acpi, mma9551_acpi_match);
 
 static const struct i2c_device_id mma9551_id[] = {
 	{ "mma9551" },
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, mma9551_id);
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 00e224efc8ed2d03d08a22fb0eb51b7dc1b1ddcc..1bbe660b254fcfc426fe07d25082098caf440e57 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -919,7 +919,7 @@ static const struct iio_enum mma9553_calibgender_enum = {
 static const struct iio_chan_spec_ext_info mma9553_ext_info[] = {
 	IIO_ENUM("calibgender", IIO_SHARED_BY_TYPE, &mma9553_calibgender_enum),
 	IIO_ENUM_AVAILABLE("calibgender", IIO_SHARED_BY_TYPE, &mma9553_calibgender_enum),
-	{},
+	{ }
 };
 
 #define MMA9553_PEDOMETER_CHANNEL(_type, _mask) {		\
@@ -1216,14 +1216,14 @@ static const struct dev_pm_ops mma9553_pm_ops = {
 
 static const struct acpi_device_id mma9553_acpi_match[] = {
 	{"MMA9553", 0},
-	{},
+	{ }
 };
 
 MODULE_DEVICE_TABLE(acpi, mma9553_acpi_match);
 
 static const struct i2c_device_id mma9553_id[] = {
 	{ "mma9553" },
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, mma9553_id);
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index cb5c4e354fc044bacd6a468a2f544bdac62b987c..c9c4bab08a815194e6aced272c437423e88fc86f 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -573,14 +573,14 @@ static const struct acpi_device_id mxc4005_acpi_match[] = {
 	{"MXC4005",	0},
 	{"MXC6655",	0},
 	{"MDA6655",	0},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, mxc4005_acpi_match);
 
 static const struct of_device_id mxc4005_of_match[] = {
 	{ .compatible = "memsic,mxc4005", },
 	{ .compatible = "memsic,mxc6655", },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mxc4005_of_match);
 
diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 3fb0f386c3db603714a746c28be36ee78d1b2a6a..aabe4491efd727613b058b009b45187062b19a32 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1541,7 +1541,7 @@ static const struct spi_device_id sca3000_id[] = {
 	{"sca3000_e02", e02},
 	{"sca3000_e04", e04},
 	{"sca3000_e05", e05},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, sca3000_id);
 
diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index ca0ce83e42b2cec52219b91f3c5d513c9f80d55e..9b00a3d7056d8caf7b45bd20b2c2674d072492e2 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -674,14 +674,14 @@ static int sca3300_probe(struct spi_device *spi)
 static const struct of_device_id sca3300_dt_ids[] = {
 	{ .compatible = "murata,sca3300"},
 	{ .compatible = "murata,scl3300"},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
 
 static const struct spi_device_id sca3300_ids[] = {
 	{ "sca3300" },
 	{ "scl3300" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, sca3300_ids);
 
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index ab4fdba75a0a904970f7280dd31ee5acc8ad20a8..f24449500533af7c2d081ba24fee6cac972c2621 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -126,14 +126,14 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,iis328dq",
 		.data = IIS328DQ_ACCEL_DEV_NAME,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
 
 static const struct acpi_device_id st_accel_acpi_match[] = {
 	{"SMO8840", (kernel_ulong_t)LIS2DH12_ACCEL_DEV_NAME},
 	{"SMO8A90", (kernel_ulong_t)LNG2DM_ACCEL_DEV_NAME},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, st_accel_acpi_match);
 
@@ -164,7 +164,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 	{ LSM303C_ACCEL_DEV_NAME },
 	{ SC7A20_ACCEL_DEV_NAME },
 	{ IIS328DQ_ACCEL_DEV_NAME },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
 
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 6146754fe47f706aff8760e39cf1d7f32678fcd5..d8ec0555f42a5956464f663aefc2fa734a32aca8 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -108,7 +108,7 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,iis328dq",
 		.data = IIS328DQ_ACCEL_DEV_NAME,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
 
@@ -167,7 +167,7 @@ static const struct spi_device_id st_accel_id_table[] = {
 	{ LIS302DL_ACCEL_DEV_NAME },
 	{ LSM303C_ACCEL_DEV_NAME },
 	{ IIS328DQ_ACCEL_DEV_NAME },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, st_accel_id_table);
 
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 471c154c3631b03bcdba01004dd172e7b3578e89..d3ff1287c01794bfc730627bb0069062d62dab02 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -635,7 +635,7 @@ static const struct i2c_device_id stk8312_i2c_id[] = {
 	/* Deprecated in favour of lowercase form */
 	{ "STK8312" },
 	{ "stk8312" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, stk8312_i2c_id);
 
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index cab592a68622566408834cd401283378081ab7b4..e5fed3eac2c816dfb961d4838ce3b0dfcd8eb230 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -526,13 +526,13 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stk8ba50_pm_ops, stk8ba50_suspend,
 
 static const struct i2c_device_id stk8ba50_i2c_id[] = {
 	{ "stk8ba50" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, stk8ba50_i2c_id);
 
 static const struct acpi_device_id stk8ba50_acpi_id[] = {
 	{"STK8BA50", 0},
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(acpi, stk8ba50_acpi_id);
diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index f9f32737db8079a5b96847442a64fea811438363..dda2986ccda075fbfa04851a1ceac7a186b47537 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -572,7 +572,7 @@ static const struct iio_chan_spec_ext_info ad7280_cell_ext_info[] = {
 		.write = ad7280_store_balance_timer,
 		.shared = IIO_SEPARATE,
 	},
-	{}
+	{ }
 };
 
 static const struct iio_event_spec ad7280_events[] = {
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 5a863005aca6d1082b91a52655eaaa83c6871151..91b96a45970ac76de20f048007a3524fa2ea8a7e 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -658,7 +658,7 @@ static int ad7768_probe(struct spi_device *spi)
 
 static const struct spi_device_id ad7768_id_table[] = {
 	{ "ad7768-1", 0 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7768_id_table);
 
diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index 597c2686ffa4855a0fdd9a18edbefe4dc1a164f2..041fc25e3209bdd6908df27f25aa77e78574c992 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -464,7 +464,7 @@ static const struct spi_device_id ad7791_spi_ids[] = {
 	{ "ad7789", AD7789 },
 	{ "ad7790", AD7790 },
 	{ "ad7791", AD7791 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7791_spi_ids);
 
diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 993f4651b73a72fd4edb5f1e835ed735ab60c58a..9c02f919913940ebbc66f4967d6d175fa7d3bc67 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -958,7 +958,7 @@ static const struct i2c_device_id ad799x_id[] = {
 	{ "ad7994", ad7994 },
 	{ "ad7997", ad7997 },
 	{ "ad7998", ad7998 },
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, ad799x_id);
diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index cf942c043457ccea49207c3900153ee371b3774f..4116c44197b8d03bcd62fa6328f21a55fc3e0da2 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -702,7 +702,7 @@ static const struct of_device_id adi_axi_adc_of_match[] = {
 	{ .compatible = "adi,axi-adc-10.0.a", .data = &adc_generic },
 	{ .compatible = "adi,axi-ad485x", .data = &adi_axi_ad485x },
 	{ .compatible = "adi,axi-ad7606x", .data = &adc_ad7606 },
-	{ /* end of list */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adi_axi_adc_of_match);
 
diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 9fd7027623d0c2ed49d91b25d1e9cfea59caa929..71584ffd36324800e23945df7984ac98ba88b793 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -163,14 +163,14 @@ static const struct iio_map axp20x_maps[] = {
 	IIO_MAP("batt_v", "axp20x-battery-power-supply", "batt_v"),
 	IIO_MAP("batt_chrg_i", "axp20x-battery-power-supply", "batt_chrg_i"),
 	IIO_MAP("batt_dischrg_i", "axp20x-battery-power-supply", "batt_dischrg_i"),
-	{ /* sentinel */ }
+	{ }
 };
 
 static const struct iio_map axp22x_maps[] = {
 	IIO_MAP("batt_v", "axp20x-battery-power-supply", "batt_v"),
 	IIO_MAP("batt_chrg_i", "axp20x-battery-power-supply", "batt_chrg_i"),
 	IIO_MAP("batt_dischrg_i", "axp20x-battery-power-supply", "batt_dischrg_i"),
-	{ /* sentinel */ }
+	{ }
 };
 
 static struct iio_map axp717_maps[] = {
@@ -1074,7 +1074,7 @@ static const struct of_device_id axp20x_adc_of_match[] = {
 	{ .compatible = "x-powers,axp221-adc", .data = (void *)&axp22x_data, },
 	{ .compatible = "x-powers,axp717-adc", .data = (void *)&axp717_data, },
 	{ .compatible = "x-powers,axp813-adc", .data = (void *)&axp813_data, },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, axp20x_adc_of_match);
 
@@ -1084,7 +1084,7 @@ static const struct platform_device_id axp20x_adc_id_match[] = {
 	{ .name = "axp22x-adc", .driver_data = (kernel_ulong_t)&axp22x_data, },
 	{ .name = "axp717-adc", .driver_data = (kernel_ulong_t)&axp717_data, },
 	{ .name = "axp813-adc", .driver_data = (kernel_ulong_t)&axp813_data, },
-	{ /* sentinel */ },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, axp20x_adc_id_match);
 
diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index 45542efc3ece0c1ca28becba494b8f9826ee43bd..c8283279c47756880e368c62e4c443e345f95067 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -110,7 +110,7 @@ static const struct iio_map axp288_adc_default_maps[] = {
 	IIO_MAP("BATT_CHG_I", "axp288-chrg", "axp288-chrg-curr"),
 	IIO_MAP("BATT_DISCHRG_I", "axp288-chrg", "axp288-chrg-d-curr"),
 	IIO_MAP("BATT_V", "axp288-batt", "axp288-batt-volt"),
-	{},
+	{ }
 };
 
 static int axp288_adc_read_channel(int *val, unsigned long address,
@@ -207,7 +207,7 @@ static const struct dmi_system_id axp288_adc_ts_bias_override[] = {
 		},
 		.driver_data = (void *)(uintptr_t)AXP288_ADC_TS_BIAS_80UA,
 	},
-	{}
+	{ }
 };
 
 static int axp288_adc_initialize(struct axp288_adc_info *info)
diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
index c218acf6c9c6067afdea20468508d06f4a0e9d01..ba7cbd3b48222543aa82f14054b4e20e260e8d69 100644
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -942,7 +942,7 @@ static const struct of_device_id cpcap_adc_id_table[] = {
 		.compatible = "motorola,mapphone-cpcap-adc",
 		.data = &mapphone_adc,
 	},
-	{ /* sentinel */ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, cpcap_adc_id_table);
 
diff --git a/drivers/iio/adc/da9150-gpadc.c b/drivers/iio/adc/da9150-gpadc.c
index 0290345ade84176addb53eae2c6d8630faa504f1..b99291ce2a45ff235feeff19f329ba4505dd1a52 100644
--- a/drivers/iio/adc/da9150-gpadc.c
+++ b/drivers/iio/adc/da9150-gpadc.c
@@ -296,7 +296,7 @@ static const struct iio_map da9150_gpadc_default_maps[] = {
 	IIO_MAP("VBUS", "da9150-charger", "CHAN_VBUS"),
 	IIO_MAP("TJUNC_CORE", "da9150-charger", "CHAN_TJUNC"),
 	IIO_MAP("VBAT", "da9150-charger", "CHAN_VBAT"),
-	{},
+	{ }
 };
 
 static int da9150_gpadc_probe(struct platform_device *pdev)
diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
index e911c25d106d470566675c951b3d3fcc70af4a59..5b16fe737659bc70f4ec13112859a34400c9e7be 100644
--- a/drivers/iio/adc/envelope-detector.c
+++ b/drivers/iio/adc/envelope-detector.c
@@ -305,7 +305,7 @@ static const struct iio_chan_spec_ext_info envelope_detector_ext_info[] = {
 	{ .name = "compare_interval",
 	  .read = envelope_show_comp_interval,
 	  .write = envelope_store_comp_interval, },
-	{ /* sentinel */ }
+	{ }
 };
 
 static const struct iio_chan_spec envelope_detector_iio_channel = {
@@ -390,7 +390,7 @@ static int envelope_detector_probe(struct platform_device *pdev)
 
 static const struct of_device_id envelope_detector_match[] = {
 	{ .compatible = "axentia,tse850-envelope-detector", },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, envelope_detector_match);
 
diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index b3f037510e35c51c3b516d3834906979b0a25fe9..f8c220f6a7b47d90d181bc16deb623125bf17c52 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -372,7 +372,7 @@ static int mx25_gcq_probe(struct platform_device *pdev)
 
 static const struct of_device_id mx25_gcq_ids[] = {
 	{ .compatible = "fsl,imx25-gcq", },
-	{ /* Sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mx25_gcq_ids);
 
diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index 689e34f069877ec525c5f9ee7258d5140d4bba70..b4562aae84770d11c281d9ed2886f7ab1d2aff75 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -351,7 +351,7 @@ static const struct iio_enum hi8435_sensing_mode = {
 static const struct iio_chan_spec_ext_info hi8435_ext_info[] = {
 	IIO_ENUM("sensing_mode", IIO_SEPARATE, &hi8435_sensing_mode),
 	IIO_ENUM_AVAILABLE("sensing_mode", IIO_SHARED_BY_TYPE, &hi8435_sensing_mode),
-	{},
+	{ }
 };
 
 #define HI8435_VOLTAGE_CHANNEL(num)			\
diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index 828d3fea6d43ebb0b347e82b0d332ef07567db92..09ce71f6e941e5676cbea3c49bbae74122085304 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -413,7 +413,7 @@ static const struct iio_info imx7d_adc_iio_info = {
 
 static const struct of_device_id imx7d_adc_match[] = {
 	{ .compatible = "fsl,imx7d-adc", },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, imx7d_adc_match);
 
diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
index 3d19d7d744aa46d8bfaeb2c36503297f56ebd36f..be13a6ed7e00b986ad4984d6582298d8d817f4d9 100644
--- a/drivers/iio/adc/imx8qxp-adc.c
+++ b/drivers/iio/adc/imx8qxp-adc.c
@@ -481,7 +481,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(imx8qxp_adc_pm_ops,
 
 static const struct of_device_id imx8qxp_adc_match[] = {
 	{ .compatible = "nxp,imx8qxp-adc", },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, imx8qxp_adc_match);
 
diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
index 002eb19587d679789a9affa1f9514a720998c470..7feaafd2316f246bd0c32fea99309900b5c65099 100644
--- a/drivers/iio/adc/imx93_adc.c
+++ b/drivers/iio/adc/imx93_adc.c
@@ -464,7 +464,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(imx93_adc_pm_ops,
 
 static const struct of_device_id imx93_adc_match[] = {
 	{ .compatible = "nxp,imx93-adc", },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, imx93_adc_match);
 
diff --git a/drivers/iio/adc/intel_mrfld_adc.c b/drivers/iio/adc/intel_mrfld_adc.c
index c178850eaaab103bba5729ada102e0e2408bf4de..101c1a0ce591eb66a65b35e965b2529b825db61d 100644
--- a/drivers/iio/adc/intel_mrfld_adc.c
+++ b/drivers/iio/adc/intel_mrfld_adc.c
@@ -174,7 +174,7 @@ static const struct iio_map iio_maps[] = {
 	IIO_MAP("CH6", "bcove-temp",    "SYSTEMP0"),
 	IIO_MAP("CH7", "bcove-temp",    "SYSTEMP1"),
 	IIO_MAP("CH8", "bcove-temp",    "SYSTEMP2"),
-	{}
+	{ }
 };
 
 static int mrfld_adc_probe(struct platform_device *pdev)
@@ -222,7 +222,7 @@ static int mrfld_adc_probe(struct platform_device *pdev)
 
 static const struct platform_device_id mrfld_adc_id_table[] = {
 	{ .name = "mrfld_bcove_adc" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, mrfld_adc_id_table);
 
diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
index 450a243d1f7c0111d99364e031e9f95e0797f880..7e5d181ff7021e6adeb8e152d1d577c83b7a101f 100644
--- a/drivers/iio/adc/lpc18xx_adc.c
+++ b/drivers/iio/adc/lpc18xx_adc.c
@@ -188,7 +188,7 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
 
 static const struct of_device_id lpc18xx_adc_match[] = {
 	{ .compatible = "nxp,lpc1850-adc" },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, lpc18xx_adc_match);
 
diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
index 97c417c3a4eb066cc8181df7b6ff916f10a7c541..a579107fd5c9e5ab66fe29f1f37bd0001352e626 100644
--- a/drivers/iio/adc/ltc2471.c
+++ b/drivers/iio/adc/ltc2471.c
@@ -138,7 +138,7 @@ static int ltc2471_i2c_probe(struct i2c_client *client)
 static const struct i2c_device_id ltc2471_i2c_id[] = {
 	{ "ltc2471", ltc2471 },
 	{ "ltc2473", ltc2473 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc2471_i2c_id);
 
diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 35717ec082cedbb3300a873256bc147d37439ed1..d0546c681625a57be884623372274a4186f30b8f 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1551,7 +1551,7 @@ static const struct of_device_id max1363_of_match[] = {
 	MAX1363_COMPATIBLE("maxim,max11645", max11645),
 	MAX1363_COMPATIBLE("maxim,max11646", max11646),
 	MAX1363_COMPATIBLE("maxim,max11647", max11647),
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, max1363_of_match);
 
@@ -1672,7 +1672,7 @@ static const struct i2c_device_id max1363_id[] = {
 	MAX1363_ID_TABLE("max11645", max11645),
 	MAX1363_ID_TABLE("max11646", max11646),
 	MAX1363_ID_TABLE("max11647", max11647),
-	{ /* sentinel */ }
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, max1363_id);
diff --git a/drivers/iio/adc/max77541-adc.c b/drivers/iio/adc/max77541-adc.c
index 21d024bde16ba00332ee7ae77f87425f169dec20..0aa04d143ad4cc3a46cb28924f7652851bbbb449 100644
--- a/drivers/iio/adc/max77541-adc.c
+++ b/drivers/iio/adc/max77541-adc.c
@@ -176,7 +176,7 @@ static int max77541_adc_probe(struct platform_device *pdev)
 
 static const struct platform_device_id max77541_adc_platform_id[] = {
 	{ "max77541-adc" },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, max77541_adc_platform_id);
 
diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index c0f2a2ef0c6888b0dac86fe3a6507caba498731b..4ff88603e4fcac0873ad67954a4257d48a573e91 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1342,7 +1342,7 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
 		.compatible = "amlogic,meson-g12a-saradc",
 		.data = &meson_sar_adc_g12a_data,
 	},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, meson_sar_adc_of_match);
 
diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
index a4970cfb49a5d4e14e6d8e6dd2f0013327e6687e..eecf88b05c6fa6acdcf8c8ba07bab11a6df4cdb0 100644
--- a/drivers/iio/adc/mt6359-auxadc.c
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -588,7 +588,7 @@ static const struct of_device_id mt6359_auxadc_of_match[] = {
 	{ .compatible = "mediatek,mt6357-auxadc", .data = &mt6357_chip_info },
 	{ .compatible = "mediatek,mt6358-auxadc", .data = &mt6358_chip_info },
 	{ .compatible = "mediatek,mt6359-auxadc", .data = &mt6359_chip_info },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mt6359_auxadc_of_match);
 
diff --git a/drivers/iio/adc/mt6370-adc.c b/drivers/iio/adc/mt6370-adc.c
index 0bc112135bca1e5922ae19a7bd591f555e863240..7c71fe5e8d313f8e6cc8d66e1a6b5b1b26e8b9dc 100644
--- a/drivers/iio/adc/mt6370-adc.c
+++ b/drivers/iio/adc/mt6370-adc.c
@@ -336,7 +336,7 @@ static int mt6370_adc_probe(struct platform_device *pdev)
 
 static const struct of_device_id mt6370_adc_of_id[] = {
 	{ .compatible = "mediatek,mt6370-adc", },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mt6370_adc_of_id);
 
diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index 7c1511ee3a4b4a3278e0390f59809ccd9ef9722f..c8283873cdee676a287b2661f04556197a9ef239 100644
--- a/drivers/iio/adc/npcm_adc.c
+++ b/drivers/iio/adc/npcm_adc.c
@@ -196,7 +196,7 @@ static const struct iio_info npcm_adc_iio_info = {
 static const struct of_device_id npcm_adc_match[] = {
 	{ .compatible = "nuvoton,npcm750-adc", .data = &npxm7xx_adc_info},
 	{ .compatible = "nuvoton,npcm845-adc", .data = &npxm8xx_adc_info},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, npcm_adc_match);
 
diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index beb5511c4504006171c56139b928cc4f1f9be77b..ef75e9e51c241a04163591ecb33176e4c46bef01 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -900,7 +900,7 @@ static ssize_t pac1921_read_scale_avail(struct iio_dev *indio_dev,
 
 static const struct iio_chan_spec_ext_info pac1921_ext_info_voltage[] = {
 	PAC1921_EXT_INFO_SCALE_AVAIL,
-	{}
+	{ }
 };
 
 static const struct iio_chan_spec_ext_info pac1921_ext_info_current[] = {
@@ -911,7 +911,7 @@ static const struct iio_chan_spec_ext_info pac1921_ext_info_current[] = {
 		.write = pac1921_write_shunt_resistor,
 		.shared = IIO_SEPARATE,
 	},
-	{}
+	{ }
 };
 
 static const struct iio_event_spec pac1921_overflow_event[] = {
diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index d283ee8fb1d2f219674ece7faa5492503671ac94..7c01e33be04c4cc89c3749706515f214336ec495 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -1164,7 +1164,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(palmas_pm_ops, palmas_gpadc_suspend,
 
 static const struct of_device_id of_palmas_gpadc_match_tbl[] = {
 	{ .compatible = "ti,palmas-gpadc", },
-	{ /* end */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_palmas_gpadc_match_tbl);
 
diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index 221c075da198d62b1c02d2fa285e607f46dddfcb..cc326f21d398271ca3c37d2c0c39209c766eb9f0 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -307,7 +307,7 @@ static const struct of_device_id rcar_gyroadc_child_match[] __maybe_unused = {
 		.compatible	= "maxim,max11100",
 		.data		= (void *)RCAR_GYROADC_MODE_SELECT_3_MAX1162,
 	},
-	{ /* sentinel */ }
+	{ }
 };
 
 static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
diff --git a/drivers/iio/adc/rn5t618-adc.c b/drivers/iio/adc/rn5t618-adc.c
index b33536157adc998668d4d0c6d6a3e806d28381a1..d6f6b351f2af85b2102b8f6fd51c3975e44a1ffa 100644
--- a/drivers/iio/adc/rn5t618-adc.c
+++ b/drivers/iio/adc/rn5t618-adc.c
@@ -188,7 +188,7 @@ static const struct iio_chan_spec rn5t618_adc_iio_channels[] = {
 static const struct iio_map rn5t618_maps[] = {
 	IIO_MAP("VADP", "rn5t618-power", "vadp"),
 	IIO_MAP("VUSB", "rn5t618-power", "vusb"),
-	{ /* sentinel */ }
+	{ }
 };
 
 static int rn5t618_adc_probe(struct platform_device *pdev)
diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 8097e59da5160ce9c130cbc613c1fb43f922dda6..9674d48074c9a7d88b0378159ad3659754a884d7 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -507,7 +507,7 @@ static const struct rzg2l_adc_hw_params rzg3s_hw_params = {
 static const struct of_device_id rzg2l_adc_match[] = {
 	{ .compatible = "renesas,r9a08g045-adc", .data = &rzg3s_hw_params },
 	{ .compatible = "renesas,rzg2l-adc", .data = &rzg2l_hw_params },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, rzg2l_adc_match);
 
diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index b6dd096391c11ab62afee6b9e25f11e01c7cc2cc..e3a865c79686ebf73dafddabdc6822dfcff3df51 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -345,7 +345,7 @@ static int spear_adc_probe(struct platform_device *pdev)
 
 static const struct of_device_id spear_adc_dt_ids[] = {
 	{ .compatible = "st,spear600-adc", },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, spear_adc_dt_ids);
 
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 5dbf5f136768ef119e308c449469a5f97c863412..27aec9a18a0f9668eec63e05ebb9825acabd3ca0 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -469,7 +469,7 @@ static struct stm32_adc_trig_info stm32h7_adc_trigs[] = {
 	{ LPTIM1_OUT, STM32_EXT18 },
 	{ LPTIM2_OUT, STM32_EXT19 },
 	{ LPTIM3_OUT, STM32_EXT20 },
-	{},
+	{ }
 };
 
 /*
@@ -1876,7 +1876,7 @@ static const struct iio_chan_spec_ext_info stm32_adc_ext_info[] = {
 		.read = iio_enum_available_read,
 		.private = (uintptr_t)&stm32_adc_trig_pol,
 	},
-	{},
+	{ }
 };
 
 static void stm32_adc_debugfs_init(struct iio_dev *indio_dev)
diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 726ddafc9f6d296f4584bce4a3e43e96aae8fbef..f583924eb16bb100aa669d9e7b1d61f592a99200 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -108,7 +108,7 @@ static const struct stm32_dfsdm_str2field stm32_dfsdm_chan_type[] = {
 	{ "SPI_F", 1 }, /* SPI with data on falling edge */
 	{ "MANCH_R", 2 }, /* Manchester codec, rising edge = logic 0 */
 	{ "MANCH_F", 3 }, /* Manchester codec, falling edge = logic 1 */
-	{},
+	{ }
 };
 
 /* DFSDM channel clock source */
@@ -121,7 +121,7 @@ static const struct stm32_dfsdm_str2field stm32_dfsdm_chan_src[] = {
 	{ "CLKOUT_F", DFSDM_CHANNEL_SPI_CLOCK_INTERNAL_DIV2_FALLING },
 	/* Internal SPI clock divided by 2 (falling edge) */
 	{ "CLKOUT_R", DFSDM_CHANNEL_SPI_CLOCK_INTERNAL_DIV2_RISING },
-	{},
+	{ }
 };
 
 static int stm32_dfsdm_str2val(const char *str,
@@ -167,7 +167,7 @@ static const struct stm32_dfsdm_trig_info stm32_dfsdm_trigs[] = {
 	{ LPTIM1_OUT, 26 },
 	{ LPTIM2_OUT, 27 },
 	{ LPTIM3_OUT, 28 },
-	{},
+	{ }
 };
 
 static int stm32_dfsdm_get_jextsel(struct iio_dev *indio_dev,
@@ -1747,7 +1747,7 @@ static const struct of_device_id stm32_dfsdm_adc_match[] = {
 		.compatible = "st,stm32-dfsdm-dmic",
 		.data = &stm32h7_dfsdm_audio_data,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stm32_dfsdm_adc_match);
 
diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-gpadc-iio.c
index 2428ea69d6761f546993533555b3172050b866d4..e4dfe76e636267253adab2a32b6fa541b494d6f0 100644
--- a/drivers/iio/adc/sun20i-gpadc-iio.c
+++ b/drivers/iio/adc/sun20i-gpadc-iio.c
@@ -243,7 +243,7 @@ static int sun20i_gpadc_probe(struct platform_device *pdev)
 
 static const struct of_device_id sun20i_gpadc_of_id[] = {
 	{ .compatible = "allwinner,sun20i-d1-gpadc" },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, sun20i_gpadc_of_id);
 
diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 8b27458dcd661bb6cd9958d2ea0c5746ee68f35c..6b8d6bee18737e4e0b851835c034b13ba33f91ec 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -116,7 +116,7 @@ struct sun4i_gpadc_iio {
 
 static const struct iio_map sun4i_gpadc_hwmon_maps[] = {
 	IIO_MAP("temp_adc", "iio_hwmon.0", NULL),
-	{ /* sentinel */ },
+	{ }
 };
 
 static const struct iio_chan_spec sun4i_gpadc_channels[] = {
@@ -485,7 +485,7 @@ static const struct of_device_id sun4i_gpadc_of_id[] = {
 		.compatible = "allwinner,sun8i-a33-ths",
 		.data = &sun8i_a33_gpadc_data,
 	},
-	{ /* sentinel */ }
+	{ }
 };
 
 static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
@@ -685,7 +685,7 @@ static const struct platform_device_id sun4i_gpadc_id[] = {
 	{ "sun4i-a10-gpadc-iio", (kernel_ulong_t)&sun4i_gpadc_data },
 	{ "sun5i-a13-gpadc-iio", (kernel_ulong_t)&sun5i_gpadc_data },
 	{ "sun6i-a31-gpadc-iio", (kernel_ulong_t)&sun6i_gpadc_data },
-	{ /* sentinel */ },
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, sun4i_gpadc_id);
 
diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index a456ea78462f3d8422126092c7932c509e299316..330648d34fe2d6c53fb78e4be0501a99a6328451 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -184,7 +184,7 @@ static const struct of_device_id adc128_of_match[] = {
 	{ .compatible = "ti,adc124s021", .data = &adc128_config[2] },
 	{ .compatible = "ti,adc124s051", .data = &adc128_config[2] },
 	{ .compatible = "ti,adc124s101", .data = &adc128_config[2] },
-	{ /* sentinel */ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adc128_of_match);
 
diff --git a/drivers/iio/adc/ti-lmp92064.c b/drivers/iio/adc/ti-lmp92064.c
index 1e4a78677fe5cfb7d1c3c45bba619880a1e5a765..86eef3320de9e09087bd603a6a942575bfb6ce07 100644
--- a/drivers/iio/adc/ti-lmp92064.c
+++ b/drivers/iio/adc/ti-lmp92064.c
@@ -366,7 +366,7 @@ MODULE_DEVICE_TABLE(spi, lmp92064_id_table);
 
 static const struct of_device_id lmp92064_of_table[] = {
 	{ .compatible = "ti,lmp92064" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, lmp92064_of_table);
 
diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index ef7430e6877dcd160a644a4a72bd1e79fdb42be0..3ac774ebf678478b9bdc83f702c3a5c9e05c36bd 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -871,7 +871,7 @@ static const struct of_device_id of_twl6030_match_tbl[] = {
 		.compatible = "ti,twl6032-gpadc",
 		.data = &twl6032_pdata,
 	},
-	{ /* end */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_twl6030_match_tbl);
 
diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index f506ca4150b17413c462caf9ba3d33fdbc519238..805e1973b090fb01d8949bdc2a46d77d3f1d73c8 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -505,7 +505,7 @@ static const struct iio_enum vf610_conversion_mode = {
 
 static const struct iio_chan_spec_ext_info vf610_ext_info[] = {
 	IIO_ENUM("conversion_mode", IIO_SHARED_BY_DIR, &vf610_conversion_mode),
-	{},
+	{ }
 };
 
 #define VF610_ADC_CHAN(_idx, _chan_type) {			\
@@ -813,7 +813,7 @@ static const struct vf610_chip_info imx6sx_chip_info = {
 static const struct of_device_id vf610_adc_match[] = {
 	{ .compatible = "fsl,imx6sx-adc", .data = &imx6sx_chip_info},
 	{ .compatible = "fsl,vf610-adc", .data = &vf610_chip_info},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, vf610_adc_match);
 
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index e1f8740ae688b0aeda7e6adf74944be17ed08399..e257c1b94a5f747c44729583da77cf012c36024c 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1186,7 +1186,7 @@ static const struct of_device_id xadc_of_match_table[] = {
 		.compatible = "xlnx,system-management-wiz-1.3",
 		.data = &xadc_us_axi_ops
 	},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, xadc_of_match_table);
 
diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index f14d12b03da6673443c479abaa66bee65670bbad..8c53c9ae73b53073c00473e201dd9fd2b884614e 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1505,14 +1505,14 @@ static const struct of_device_id ad74413r_dt_id[] = {
 		.compatible = "adi,ad74413r",
 		.data = &ad74413r_chip_info_data,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad74413r_dt_id);
 
 static const struct spi_device_id ad74413r_spi_id[] = {
 	{ .name = "ad74412r", .driver_data = (kernel_ulong_t)&ad74412r_chip_info_data },
 	{ .name = "ad74413r", .driver_data = (kernel_ulong_t)&ad74413r_chip_info_data },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad74413r_spi_id);
 
diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index b6a46036d5eadfcb9487d2eaaab1eb68d820096a..ecaf59278c6feebbb0f4d8d9947433ba55ee186a 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -514,7 +514,7 @@ static const struct of_device_id rescale_match[] = {
 	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
 	{ .compatible = "temperature-transducer",
 	  .data = &rescale_cfg[TEMP_TRANSDUCER], },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, rescale_match);
 
diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 31564afb13a2028f018926663387b47bfc967199..e73c9b9833959e498fd03b37f9bedf2226b2f42a 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -330,7 +330,7 @@ static const struct spi_device_id ad8366_id[] = {
 	{"adl5240", ID_ADL5240},
 	{"hmc792a", ID_HMC792},
 	{"hmc1119", ID_HMC1119},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad8366_id);
 
diff --git a/drivers/iio/amplifiers/ada4250.c b/drivers/iio/amplifiers/ada4250.c
index 566f0e1c98a5728f083c42380ee160045f7e2dba..74f8429d652b17b4d1f38366e23ce6a2b3e9b218 100644
--- a/drivers/iio/amplifiers/ada4250.c
+++ b/drivers/iio/amplifiers/ada4250.c
@@ -378,13 +378,13 @@ static int ada4250_probe(struct spi_device *spi)
 
 static const struct spi_device_id ada4250_id[] = {
 	{ "ada4250", 0 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ada4250_id);
 
 static const struct of_device_id ada4250_of_match[] = {
 	{ .compatible = "adi,ada4250" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ada4250_of_match);
 
diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index e92d7f399e337dbffb8daa8f0de90283ba15f47e..4dbf894c7e3b55d0aedacd24b4d625e001240333 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -270,7 +270,7 @@ static const struct iio_chan_spec_ext_info ltc6373_ext_info[] = {
 		.write = ltc6373_write_powerdown,
 		.shared = IIO_SEPARATE,
 	},
-	{}
+	{ }
 };
 
 #define HMC425A_CHAN(_channel)						\
@@ -407,7 +407,7 @@ static const struct of_device_id hmc425a_of_match[] = {
 	  .data = &hmc425a_chip_info_tbl[ID_ADRF5740]},
 	{ .compatible = "adi,ltc6373",
 	  .data = &hmc425a_chip_info_tbl[ID_LTC6373]},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, hmc425a_of_match);
 
diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
index e64a41bae32c67e43fc9021c186170c4bacb2ae3..427d32e398b36068188011f8e934a94ca7650b15 100644
--- a/drivers/iio/cdc/ad7150.c
+++ b/drivers/iio/cdc/ad7150.c
@@ -631,7 +631,7 @@ static const struct i2c_device_id ad7150_id[] = {
 	{ "ad7150", AD7150 },
 	{ "ad7151", AD7151 },
 	{ "ad7156", AD7150 },
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, ad7150_id);
@@ -640,7 +640,7 @@ static const struct of_device_id ad7150_of_match[] = {
 	{ "adi,ad7150" },
 	{ "adi,ad7151" },
 	{ "adi,ad7156" },
-	{}
+	{ }
 };
 static struct i2c_driver ad7150_driver = {
 	.driver = {
diff --git a/drivers/iio/cdc/ad7746.c b/drivers/iio/cdc/ad7746.c
index ba18dbbe0940ab1ea501e76b57409d6ccb30550d..8a306d55c72a84b8fd14abb12bb4b3aca7d0345b 100644
--- a/drivers/iio/cdc/ad7746.c
+++ b/drivers/iio/cdc/ad7746.c
@@ -792,7 +792,7 @@ static const struct i2c_device_id ad7746_id[] = {
 	{ "ad7745", 7745 },
 	{ "ad7746", 7746 },
 	{ "ad7747", 7747 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad7746_id);
 
@@ -800,7 +800,7 @@ static const struct of_device_id ad7746_of_match[] = {
 	{ .compatible = "adi,ad7745" },
 	{ .compatible = "adi,ad7746" },
 	{ .compatible = "adi,ad7747" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7746_of_match);
 
diff --git a/drivers/iio/chemical/ags02ma.c b/drivers/iio/chemical/ags02ma.c
index 8fcd80946543638957fd7bb2ba5bab0388b66629..151178d4e8f49e8e26ee1d824788d8ff38495ac8 100644
--- a/drivers/iio/chemical/ags02ma.c
+++ b/drivers/iio/chemical/ags02ma.c
@@ -140,13 +140,13 @@ static int ags02ma_probe(struct i2c_client *client)
 
 static const struct i2c_device_id ags02ma_id_table[] = {
 	{ "ags02ma" },
-	{ /* Sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ags02ma_id_table);
 
 static const struct of_device_id ags02ma_of_table[] = {
 	{ .compatible = "aosong,ags02ma" },
-	{ /* Sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ags02ma_of_table);
 
diff --git a/drivers/iio/chemical/atlas-ezo-sensor.c b/drivers/iio/chemical/atlas-ezo-sensor.c
index 761a853a4d17e5cd0eda956d91edd2ce36476e24..de0b87edd1887f5cf28cc50a36542f65f9d77dc5 100644
--- a/drivers/iio/chemical/atlas-ezo-sensor.c
+++ b/drivers/iio/chemical/atlas-ezo-sensor.c
@@ -189,7 +189,7 @@ static const struct i2c_device_id atlas_ezo_id[] = {
 	{ "atlas-co2-ezo", (kernel_ulong_t)&atlas_ezo_devices[ATLAS_CO2_EZO] },
 	{ "atlas-o2-ezo", (kernel_ulong_t)&atlas_ezo_devices[ATLAS_O2_EZO] },
 	{ "atlas-hum-ezo", (kernel_ulong_t)&atlas_ezo_devices[ATLAS_HUM_EZO] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, atlas_ezo_id);
 
@@ -197,7 +197,7 @@ static const struct of_device_id atlas_ezo_dt_ids[] = {
 	{ .compatible = "atlas,co2-ezo", .data = &atlas_ezo_devices[ATLAS_CO2_EZO], },
 	{ .compatible = "atlas,o2-ezo", .data = &atlas_ezo_devices[ATLAS_O2_EZO], },
 	{ .compatible = "atlas,hum-ezo", .data = &atlas_ezo_devices[ATLAS_HUM_EZO], },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, atlas_ezo_dt_ids);
 
diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 593b73ccbeb7f6123aa5709a0382e2d4b4dacf83..bde473f9483fbf7c10c028685b01c2f45d3a02ef 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -593,7 +593,7 @@ static const struct i2c_device_id atlas_id[] = {
 	{ "atlas-orp-sm", (kernel_ulong_t)&atlas_devices[ATLAS_ORP_SM] },
 	{ "atlas-do-sm", (kernel_ulong_t)&atlas_devices[ATLAS_DO_SM] },
 	{ "atlas-rtd-sm", (kernel_ulong_t)&atlas_devices[ATLAS_RTD_SM] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, atlas_id);
 
diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
index ac7763f98a6ab3e95bec342414f50728b1f9443b..5560ea708b3614e06ee906dd69c87d5e0c40c7a7 100644
--- a/drivers/iio/chemical/bme680_i2c.c
+++ b/drivers/iio/chemical/bme680_i2c.c
@@ -37,13 +37,13 @@ static int bme680_i2c_probe(struct i2c_client *client)
 
 static const struct i2c_device_id bme680_i2c_id[] = {
 	{ "bme680" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bme680_i2c_id);
 
 static const struct of_device_id bme680_of_i2c_match[] = {
 	{ .compatible = "bosch,bme680", },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, bme680_of_i2c_match);
 
diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
index ecb24ba0ebc9a75b530056e12dee9b641329f38b..ced5af23846a73e0378dc936b2cf8c9508760301 100644
--- a/drivers/iio/chemical/bme680_spi.c
+++ b/drivers/iio/chemical/bme680_spi.c
@@ -140,13 +140,13 @@ static int bme680_spi_probe(struct spi_device *spi)
 
 static const struct spi_device_id bme680_spi_id[] = {
 	{"bme680", 0},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, bme680_spi_id);
 
 static const struct of_device_id bme680_of_spi_match[] = {
 	{ .compatible = "bosch,bme680", },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, bme680_of_spi_match);
 
diff --git a/drivers/iio/chemical/sunrise_co2.c b/drivers/iio/chemical/sunrise_co2.c
index cdb8696a4e814ef3e4089c3e74abe437ca8ce7e9..af79efde37e89170128ef9351bf1ad8b993d4a2d 100644
--- a/drivers/iio/chemical/sunrise_co2.c
+++ b/drivers/iio/chemical/sunrise_co2.c
@@ -373,7 +373,7 @@ static const struct iio_chan_spec_ext_info sunrise_concentration_ext_info[] = {
 		.read = iio_enum_available_read,
 		.private = (uintptr_t)&sunrise_error_statuses_enum,
 	},
-	{}
+	{ }
 };
 
 static const struct iio_chan_spec sunrise_channels[] = {
@@ -519,7 +519,7 @@ static int sunrise_probe(struct i2c_client *client)
 
 static const struct of_device_id sunrise_of_match[] = {
 	{ .compatible = "senseair,sunrise-006-0-0007" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, sunrise_of_match);
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
index 119acb078af3bfdb33bcca905cc2e4822f92bbd6..2d3d148b420687c4ad4adc7ca0931193f1bb2dc0 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
@@ -121,7 +121,7 @@ static const struct platform_device_id cros_ec_lid_angle_ids[] = {
 	{
 		.name = DRV_NAME,
 	},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, cros_ec_lid_angle_ids);
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 66153b1850f109916d2ccb25f82d9977f2f0f24c..82cef4a124427239137038d63a9bf8a7f4a78b07 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -311,7 +311,7 @@ static const struct platform_device_id cros_ec_sensors_ids[] = {
 	{
 		.name = "cros-ec-mag",
 	},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, cros_ec_sensors_ids);
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 40d5b10c74e082888cc5c1dd909eadff76162cbf..576d7b451767a0aa068e4a5a81ce89b058c239cb 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -480,7 +480,7 @@ const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[] = {
 		.shared = IIO_SHARED_BY_ALL,
 		.read = cros_ec_sensors_id
 	},
-	{ },
+	{ }
 };
 EXPORT_SYMBOL_GPL(cros_ec_sensors_ext_info);
 
diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 1a62dd902f05682795ac3ee22fd94c0c0aed4213..da516c46e057b8be283d534720b4958d4dee5162 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -417,7 +417,7 @@ static const struct iio_chan_spec_ext_info scmi_iio_ext_info[] = {
 		.read = scmi_iio_get_raw_available,
 		.shared = IIO_SHARED_BY_TYPE,
 	},
-	{},
+	{ }
 };
 
 static void scmi_iio_set_timestamp_channel(struct iio_chan_spec *iio_chan,
@@ -704,7 +704,7 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
 
 static const struct scmi_device_id scmi_id_table[] = {
 	{ SCMI_PROTOCOL_SENSOR, "iiodev" },
-	{},
+	{ }
 };
 
 MODULE_DEVICE_TABLE(scmi, scmi_id_table);
diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 22ea10eb48ae71b369b20568938ba102e1b46a6b..7c488672936f79acd13343c6cd2bd118f90b6e13 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -434,7 +434,7 @@ static const struct of_device_id ssp_of_match[] = {
 		.compatible	= "samsung,sensorhub-thermostat",
 		.data		= &ssp_thermostat_info,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ssp_of_match);
 
diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index 905988724f2731f164f99be11d6a7a70d13d61a7..84be5174babd965e7b8fa74dc5b356ca97237f72 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -378,7 +378,7 @@ static const struct iio_chan_spec_ext_info ad5064_ext_info[] = {
 	},
 	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad5064_powerdown_mode_enum),
 	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ad5064_powerdown_mode_enum),
-	{ },
+	{ }
 };
 
 static const struct iio_chan_spec_ext_info ltc2617_ext_info[] = {
@@ -390,7 +390,7 @@ static const struct iio_chan_spec_ext_info ltc2617_ext_info[] = {
 	},
 	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ltc2617_powerdown_mode_enum),
 	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ltc2617_powerdown_mode_enum),
-	{ },
+	{ }
 };
 
 #define AD5064_CHANNEL(chan, addr, bits, _shift, _ext_info) {		\
@@ -936,7 +936,7 @@ static const struct spi_device_id ad5064_spi_ids[] = {
 	{"ad5668-1", ID_AD5668_1},
 	{"ad5668-2", ID_AD5668_2},
 	{"ad5668-3", ID_AD5668_2}, /* similar enough to ad5668-2 */
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5064_spi_ids);
 
@@ -1048,7 +1048,7 @@ static const struct i2c_device_id ad5064_i2c_ids[] = {
 	{"ltc2635-h10", ID_LTC2635_H10},
 	{"ltc2635-l8", ID_LTC2635_L8},
 	{"ltc2635-h8", ID_LTC2635_H8},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad5064_i2c_ids);
 
diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index e0b7f658d61196c191ade50dcba22d7ec2d5cc49..a57b0a093112bc14404c7e1fcc27b4d4b136cdce 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -542,7 +542,7 @@ static const struct spi_device_id ad5360_ids[] = {
 	{ "ad5371", ID_AD5371 },
 	{ "ad5372", ID_AD5372 },
 	{ "ad5373", ID_AD5373 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5360_ids);
 
diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 392a1c7aee03b515e9e068a1fc9bb4e594bef267..f63af704b77e3dc60d11bda7ac44d3a4ed6a7ec4 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -246,7 +246,7 @@ static const struct iio_chan_spec_ext_info ad5380_ext_info[] = {
 	IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE,
 		 &ad5380_powerdown_mode_enum),
 	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ad5380_powerdown_mode_enum),
-	{ },
+	{ }
 };
 
 #define AD5380_CHANNEL(_bits) {					\
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 6ad99f97eed55ff4ff4be22f3d6ef3a858dcf87e..ad304b0fec08352d51c3ef25c53897c03b10ab56 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -141,7 +141,7 @@ static const struct iio_chan_spec_ext_info ad5446_ext_info_powerdown[] = {
 	},
 	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad5446_powerdown_mode_enum),
 	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ad5446_powerdown_mode_enum),
-	{ },
+	{ }
 };
 
 #define _AD5446_CHANNEL(bits, storage, _shift, ext) { \
@@ -440,7 +440,7 @@ static const struct spi_device_id ad5446_spi_ids[] = {
 	{"dac101s101", ID_AD5310},
 	{"dac121s101", ID_AD5320},
 	{"dac7512", ID_AD5320},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5446_spi_ids);
 
@@ -543,7 +543,7 @@ static const struct i2c_device_id ad5446_i2c_ids[] = {
 	{"ad5602", ID_AD5602},
 	{"ad5612", ID_AD5612},
 	{"ad5622", ID_AD5622},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad5446_i2c_ids);
 
diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
index 1c996016756a8bdfde2375a4b044997433b514fb..d8c32526025936465b9ef490186a7e78c3c17b46 100644
--- a/drivers/iio/dac/ad5449.c
+++ b/drivers/iio/dac/ad5449.c
@@ -337,7 +337,7 @@ static const struct spi_device_id ad5449_spi_ids[] = {
 	{ "ad5439", ID_AD5439 },
 	{ "ad5443", ID_AD5443 },
 	{ "ad5449", ID_AD5449 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5449_spi_ids);
 
diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index ff0765c8af47f89659a0cd5756b97f6d6c0462ed..355bcb6a8ba0bc931d5eca8cf07093cf2a586c0a 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -242,7 +242,7 @@ static const struct iio_chan_spec_ext_info ad5504_ext_info[] = {
 	IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE,
 		 &ad5504_powerdown_mode_enum),
 	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ad5504_powerdown_mode_enum),
-	{ },
+	{ }
 };
 
 #define AD5504_CHANNEL(_chan) { \
@@ -320,7 +320,7 @@ static int ad5504_probe(struct spi_device *spi)
 static const struct spi_device_id ad5504_id[] = {
 	{"ad5504", ID_AD5504},
 	{"ad5501", ID_AD5501},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5504_id);
 
diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 50d19304bacbc6e0b0ced51e0fdf948b603d04e6..0eb435a144b11b6cbfd0a7cfa1a6056e399af7fc 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -490,7 +490,7 @@ static const struct iio_chan_spec_ext_info ad5592r_ext_info[] = {
 	 .read = ad5592r_show_scale_available,
 	 .shared = IIO_SHARED_BY_TYPE,
 	 },
-	{},
+	{ }
 };
 
 static void ad5592r_setup_channel(struct iio_dev *iio_dev,
diff --git a/drivers/iio/dac/ad5592r.c b/drivers/iio/dac/ad5592r.c
index fd82d8701322c4ec5b3bcb5d413e369e7c5a26b8..92d1b629b85dca18c21820cd1a7c2588fb36cea4 100644
--- a/drivers/iio/dac/ad5592r.c
+++ b/drivers/iio/dac/ad5592r.c
@@ -137,19 +137,19 @@ static void ad5592r_spi_remove(struct spi_device *spi)
 
 static const struct spi_device_id ad5592r_spi_ids[] = {
 	{ .name = "ad5592r", },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5592r_spi_ids);
 
 static const struct of_device_id ad5592r_of_match[] = {
 	{ .compatible = "adi,ad5592r", },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad5592r_of_match);
 
 static const struct acpi_device_id ad5592r_acpi_match[] = {
 	{"ADS5592", },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, ad5592r_acpi_match);
 
diff --git a/drivers/iio/dac/ad5593r.c b/drivers/iio/dac/ad5593r.c
index ddd13ad821a794ad501d101c36c651d82119cabb..9a8525c61173ba5d992e4a1b21a08c10cf4a1bc1 100644
--- a/drivers/iio/dac/ad5593r.c
+++ b/drivers/iio/dac/ad5593r.c
@@ -116,19 +116,19 @@ static void ad5593r_i2c_remove(struct i2c_client *i2c)
 
 static const struct i2c_device_id ad5593r_i2c_ids[] = {
 	{ .name = "ad5593r", },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad5593r_i2c_ids);
 
 static const struct of_device_id ad5593r_of_match[] = {
 	{ .compatible = "adi,ad5593r", },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad5593r_of_match);
 
 static const struct acpi_device_id ad5593r_acpi_match[] = {
 	{"ADS5593", },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, ad5593r_acpi_match);
 
diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
index 2fd38ac8f698856910d186099f8ffa2c34ebe5d1..13aefe769bad893069ec4f5158f9c60bf296bc9f 100644
--- a/drivers/iio/dac/ad5624r_spi.c
+++ b/drivers/iio/dac/ad5624r_spi.c
@@ -160,7 +160,7 @@ static const struct iio_chan_spec_ext_info ad5624r_ext_info[] = {
 	IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE,
 		 &ad5624r_powerdown_mode_enum),
 	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ad5624r_powerdown_mode_enum),
-	{ },
+	{ }
 };
 
 #define AD5624R_CHANNEL(_chan, _bits) { \
@@ -266,7 +266,7 @@ static const struct spi_device_id ad5624r_id[] = {
 	{"ad5624r5", ID_AD5624R5},
 	{"ad5644r5", ID_AD5644R5},
 	{"ad5664r5", ID_AD5664R5},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5624r_id);
 
diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index 9c727aa6ea189a7ed6353392bcb73e113e5d5bdb..df8619e0c09286cf70ae3f4f17a83f9256ea530e 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -112,7 +112,7 @@ static const struct spi_device_id ad5686_spi_id[] = {
 	{"ad5685r", ID_AD5685R},
 	{"ad5686", ID_AD5686},
 	{"ad5686r", ID_AD5686R},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5686_spi_id);
 
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 763af690c444399a620fd0e55c1e916b1beb8b39..d9cae9555e5df4211634d2b90b0c5a70dc1a8525 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -185,7 +185,7 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
 	},
 	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad5686_powerdown_mode_enum),
 	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ad5686_powerdown_mode_enum),
-	{ },
+	{ }
 };
 
 #define AD5868_CHANNEL(chan, addr, bits, _shift) {		\
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index 0156f32c12c88edb46303cf8a3b79c7ed7624036..d3327bca0e077a301a8e4ed2092e8835e75279c0 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -82,7 +82,7 @@ static const struct i2c_device_id ad5686_i2c_id[] = {
 	{"ad5695r", ID_AD5695R},
 	{"ad5696", ID_AD5696},
 	{"ad5696r", ID_AD5696R},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad5686_i2c_id);
 
@@ -101,7 +101,7 @@ static const struct of_device_id ad5686_of_match[] = {
 	{ .compatible = "adi,ad5695r" },
 	{ .compatible = "adi,ad5696" },
 	{ .compatible = "adi,ad5696r" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad5686_of_match);
 
diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 05e80b6ae2cc3fe2be68e5477e95047889e3ef83..d0e5f35462b1b811c32f39a47d855729928df679 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -522,7 +522,7 @@ static const struct iio_chan_spec_ext_info ad5755_ext_info[] = {
 		.write = ad5755_write_powerdown,
 		.shared = IIO_SEPARATE,
 	},
-	{ },
+	{ }
 };
 
 #define AD5755_CHANNEL(_bits) {					\
@@ -853,7 +853,7 @@ static const struct spi_device_id ad5755_id[] = {
 	{ "ad5757", (kernel_ulong_t)&ad5755_chip_info_tbl[ID_AD5757] },
 	{ "ad5735", (kernel_ulong_t)&ad5755_chip_info_tbl[ID_AD5735] },
 	{ "ad5737", (kernel_ulong_t)&ad5755_chip_info_tbl[ID_AD5737] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5755_id);
 
diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 98771e37a7b52cf9a16a664e5510f903c53f49a6..4ed4fda76ea97fb1a18f81856f367c0a4f0d397b 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -878,7 +878,7 @@ static int ad5758_probe(struct spi_device *spi)
 
 static const struct spi_device_id ad5758_id[] = {
 	{ "ad5758", 0 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5758_id);
 
diff --git a/drivers/iio/dac/ad5761.c b/drivers/iio/dac/ad5761.c
index 0aa5ba7f465482edffdc5b23bbf79fb210075913..124571ba35d1021cccbcf6883cd16607ba108af9 100644
--- a/drivers/iio/dac/ad5761.c
+++ b/drivers/iio/dac/ad5761.c
@@ -348,7 +348,7 @@ static const struct spi_device_id ad5761_id[] = {
 	{"ad5721r", ID_AD5721R},
 	{"ad5761", ID_AD5761},
 	{"ad5761r", ID_AD5761R},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5761_id);
 
diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
index f658ac8086aaa488540855c849daf46abc21275f..dc766c8fd37073457ad2cceeb9e57ec809d7aef4 100644
--- a/drivers/iio/dac/ad5766.c
+++ b/drivers/iio/dac/ad5766.c
@@ -437,7 +437,7 @@ static const struct iio_chan_spec_ext_info ad5766_ext_info[] = {
 	IIO_ENUM("dither_scale", IIO_SEPARATE, &ad5766_dither_scale_enum),
 	IIO_ENUM_AVAILABLE("dither_scale", IIO_SEPARATE,
 			   &ad5766_dither_scale_enum),
-	{}
+	{ }
 };
 
 #define AD576x_CHANNEL(_chan, _bits) {					\
@@ -648,14 +648,14 @@ static int ad5766_probe(struct spi_device *spi)
 static const struct of_device_id ad5766_dt_match[] = {
 	{ .compatible = "adi,ad5766" },
 	{ .compatible = "adi,ad5767" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad5766_dt_match);
 
 static const struct spi_device_id ad5766_spi_ids[] = {
 	{ "ad5766", ID_AD5766 },
 	{ "ad5767", ID_AD5767 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5766_spi_ids);
 
diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
index 25cf11d0471b60071a7912d3886b6d8baac9dc0e..6eb4027a44fba20a9a789428f3ed278054c65497 100644
--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -637,13 +637,13 @@ static int ad5770r_probe(struct spi_device *spi)
 
 static const struct of_device_id ad5770r_of_id[] = {
 	{ .compatible = "adi,ad5770r", },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad5770r_of_id);
 
 static const struct spi_device_id ad5770r_id[] = {
 	{ "ad5770r", 0 },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad5770r_id);
 
diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 07848be3f8d5654418ebbac7b33c14fd1014a2c8..8214e524afdb1ac6b2f6baf69d6594694800b6a4 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -312,7 +312,7 @@ static const struct iio_chan_spec_ext_info ad5791_ext_info[] = {
 	IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE,
 		 &ad5791_powerdown_mode_enum),
 	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ad5791_powerdown_mode_enum),
-	{ },
+	{ }
 };
 
 #define AD5791_DEFINE_CHIP_INFO(_name, bits, _shift, _lin_comp)		\
diff --git a/drivers/iio/dac/ad7293.c b/drivers/iio/dac/ad7293.c
index d3f49b5337d2f512363d50b434d99d4e9b95059f..99fa2d1f8299eb29996e5816e822394b4d1acf21 100644
--- a/drivers/iio/dac/ad7293.c
+++ b/drivers/iio/dac/ad7293.c
@@ -859,13 +859,13 @@ static int ad7293_probe(struct spi_device *spi)
 
 static const struct spi_device_id ad7293_id[] = {
 	{ "ad7293", 0 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7293_id);
 
 static const struct of_device_id ad7293_of_match[] = {
 	{ .compatible = "adi,ad7293" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7293_of_match);
 
diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index bff6bf697d9c17ba220ded7f1f2e3f909b77a1fa..a88cc639047df2f98da2f89f5ccd3b6b7a35677b 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -173,7 +173,7 @@ static const struct iio_chan_spec_ext_info ad7303_ext_info[] = {
 		.write = ad7303_write_dac_powerdown,
 		.shared = IIO_SEPARATE,
 	},
-	{ },
+	{ }
 };
 
 #define AD7303_CHANNEL(chan) {					\
@@ -264,13 +264,13 @@ static int ad7303_probe(struct spi_device *spi)
 
 static const struct of_device_id ad7303_spi_of_match[] = {
 	{ .compatible = "adi,ad7303", },
-	{ /* sentinel */ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7303_spi_of_match);
 
 static const struct spi_device_id ad7303_spi_ids[] = {
 	{ "ad7303", 0 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7303_spi_ids);
 
diff --git a/drivers/iio/dac/ad8801.c b/drivers/iio/dac/ad8801.c
index 8a362fae2ecac109d0c7ac3abeacf946b4d55882..60e663af1cc18fed102918e184cb56f859e5e891 100644
--- a/drivers/iio/dac/ad8801.c
+++ b/drivers/iio/dac/ad8801.c
@@ -153,7 +153,7 @@ static int ad8801_probe(struct spi_device *spi)
 static const struct spi_device_id ad8801_ids[] = {
 	{"ad8801", ID_AD8801},
 	{"ad8803", ID_AD8803},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad8801_ids);
 
diff --git a/drivers/iio/dac/ad9739a.c b/drivers/iio/dac/ad9739a.c
index b6a65359b0b47669b4dbe7cf4e49d3f7426efbc6..d77b46d83bd4ce46cb38c56f790f9d63b2564e15 100644
--- a/drivers/iio/dac/ad9739a.c
+++ b/drivers/iio/dac/ad9739a.c
@@ -442,13 +442,13 @@ static int ad9739a_probe(struct spi_device *spi)
 
 static const struct of_device_id ad9739a_of_match[] = {
 	{ .compatible = "adi,ad9739a" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad9739a_of_match);
 
 static const struct spi_device_id ad9739a_id[] = {
 	{"ad9739a"},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad9739a_id);
 
diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 892d770aec69c4259de777058801c9ab33c79923..93129013775761dea5aba61b36485c50586007fe 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -469,7 +469,7 @@ static const struct iio_chan_spec_ext_info axi_dac_ext_info[] = {
 	IIO_BACKEND_EX_INFO("scale1", IIO_SEPARATE, AXI_DAC_SCALE_TONE_2),
 	IIO_BACKEND_EX_INFO("phase0", IIO_SEPARATE, AXI_DAC_PHASE_TONE_1),
 	IIO_BACKEND_EX_INFO("phase1", IIO_SEPARATE, AXI_DAC_PHASE_TONE_2),
-	{}
+	{ }
 };
 
 static int axi_dac_extend_chan(struct iio_backend *back,
@@ -961,7 +961,7 @@ static const struct axi_dac_info dac_ad3552r = {
 static const struct of_device_id axi_dac_of_match[] = {
 	{ .compatible = "adi,axi-dac-9.1.b", .data = &dac_generic },
 	{ .compatible = "adi,axi-ad3552r", .data = &dac_ad3552r },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, axi_dac_of_match);
 
diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index f36f10bfb6be7863a56b911b5f58671ef530c977..d1b8441051ae192d495808ed8566503477850211 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -237,7 +237,7 @@ static void dpot_dac_remove(struct platform_device *pdev)
 
 static const struct of_device_id dpot_dac_match[] = {
 	{ .compatible = "dpot-dac" },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dpot_dac_match);
 
diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index e89e4c0546531f186563da3c5e312e1811e8a79a..a26a99753418db66d013f31bcad7072bcff60813 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -301,7 +301,7 @@ MODULE_DEVICE_TABLE(i2c, ds4424_id);
 static const struct of_device_id ds4424_of_match[] = {
 	{ .compatible = "maxim,ds4422" },
 	{ .compatible = "maxim,ds4424" },
-	{ },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, ds4424_of_match);
diff --git a/drivers/iio/dac/lpc18xx_dac.c b/drivers/iio/dac/lpc18xx_dac.c
index 2332b0c22691522d44407a51544d60292a833de0..aa1c73f8429d31a77e42ee469c40ac9477464ec5 100644
--- a/drivers/iio/dac/lpc18xx_dac.c
+++ b/drivers/iio/dac/lpc18xx_dac.c
@@ -179,7 +179,7 @@ static void lpc18xx_dac_remove(struct platform_device *pdev)
 
 static const struct of_device_id lpc18xx_dac_match[] = {
 	{ .compatible = "nxp,lpc1850-dac" },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, lpc18xx_dac_match);
 
diff --git a/drivers/iio/dac/ltc1660.c b/drivers/iio/dac/ltc1660.c
index 2758fc8a5ad5cade6c03a50e13a13f9407b31b51..6e80b49f466552579f32e33ef1562c197ef2e9b3 100644
--- a/drivers/iio/dac/ltc1660.c
+++ b/drivers/iio/dac/ltc1660.c
@@ -219,14 +219,14 @@ static void ltc1660_remove(struct spi_device *spi)
 static const struct of_device_id ltc1660_dt_ids[] = {
 	{ .compatible = "lltc,ltc1660", .data = (void *)ID_LTC1660 },
 	{ .compatible = "lltc,ltc1665", .data = (void *)ID_LTC1665 },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc1660_dt_ids);
 
 static const struct spi_device_id ltc1660_id[] = {
 	{"ltc1660", ID_LTC1660},
 	{"ltc1665", ID_LTC1665},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ltc1660_id);
 
diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index 999348836d877dfaf21a2cccde4589c303f19af1..105f939f7e540771af9d31c978215085fbed02bd 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -176,7 +176,7 @@ static const struct iio_chan_spec_ext_info ltc2632_ext_info[] = {
 		.write = ltc2632_write_dac_powerdown,
 		.shared = IIO_SEPARATE,
 	},
-	{ },
+	{ }
 };
 
 #define LTC2632_CHANNEL(_chan, _bits) { \
@@ -372,7 +372,7 @@ static const struct spi_device_id ltc2632_id[] = {
 	{ "ltc2636-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636H12] },
 	{ "ltc2636-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636H10] },
 	{ "ltc2636-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636H8] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ltc2632_id);
 
@@ -432,7 +432,7 @@ static const struct of_device_id ltc2632_of_match[] = {
 		.compatible = "lltc,ltc2636-h8",
 		.data = &ltc2632_chip_info_tbl[ID_LTC2636H8]
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2632_of_match);
 
diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
index bdc857c7fa6d8d33cbb81e2d498ea24196a27c13..757b4831dc3e7c14574e3d811ba9a48d8350213a 100644
--- a/drivers/iio/dac/ltc2688.c
+++ b/drivers/iio/dac/ltc2688.c
@@ -608,7 +608,7 @@ static const struct iio_chan_spec_ext_info ltc2688_toggle_sym_ext_info[] = {
 			      ltc2688_reg_bool_get, ltc2688_reg_bool_set),
 	LTC2688_CHAN_EXT_INFO("symbol", LTC2688_CMD_SW_TOGGLE, IIO_SEPARATE,
 			      ltc2688_reg_bool_get, ltc2688_reg_bool_set),
-	{}
+	{ }
 };
 
 static const struct iio_chan_spec_ext_info ltc2688_toggle_ext_info[] = {
@@ -621,7 +621,7 @@ static const struct iio_chan_spec_ext_info ltc2688_toggle_ext_info[] = {
 			      ltc2688_dither_toggle_set),
 	LTC2688_CHAN_EXT_INFO("powerdown", LTC2688_CMD_POWERDOWN, IIO_SEPARATE,
 			      ltc2688_reg_bool_get, ltc2688_reg_bool_set),
-	{}
+	{ }
 };
 
 static struct iio_chan_spec_ext_info ltc2688_dither_ext_info[] = {
@@ -649,13 +649,13 @@ static struct iio_chan_spec_ext_info ltc2688_dither_ext_info[] = {
 			      ltc2688_dither_toggle_set),
 	LTC2688_CHAN_EXT_INFO("powerdown", LTC2688_CMD_POWERDOWN, IIO_SEPARATE,
 			      ltc2688_reg_bool_get, ltc2688_reg_bool_set),
-	{}
+	{ }
 };
 
 static const struct iio_chan_spec_ext_info ltc2688_ext_info[] = {
 	LTC2688_CHAN_EXT_INFO("powerdown", LTC2688_CMD_POWERDOWN, IIO_SEPARATE,
 			      ltc2688_reg_bool_get, ltc2688_reg_bool_set),
-	{}
+	{ }
 };
 
 #define LTC2688_CHANNEL(_chan) {					\
@@ -991,13 +991,13 @@ static int ltc2688_probe(struct spi_device *spi)
 
 static const struct of_device_id ltc2688_of_id[] = {
 	{ .compatible = "adi,ltc2688" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2688_of_id);
 
 static const struct spi_device_id ltc2688_id[] = {
 	{ "ltc2688" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ltc2688_id);
 
diff --git a/drivers/iio/dac/max5522.c b/drivers/iio/dac/max5522.c
index 9f72155dcbc7850f90c13e289b93639f5eed68c5..1b8fe6b8d26ef37757621cbc15a726fab228f927 100644
--- a/drivers/iio/dac/max5522.c
+++ b/drivers/iio/dac/max5522.c
@@ -174,7 +174,7 @@ static int max5522_spi_probe(struct spi_device *spi)
 
 static const struct spi_device_id max5522_ids[] = {
 	{ "max5522", (kernel_ulong_t)&max5522_chip_info_tbl[ID_MAX5522] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, max5522_ids);
 
@@ -183,7 +183,7 @@ static const struct of_device_id max5522_of_match[] = {
 		.compatible = "maxim,max5522",
 		.data = &max5522_chip_info_tbl[ID_MAX5522],
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, max5522_of_match);
 
diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index b062a18be5e7967f4d96f4b2f37719c2bd93c60e..e7e29359f8fe5a5c33c29a100b2ce381f2321f71 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -137,7 +137,7 @@ static const struct iio_chan_spec_ext_info max5821_ext_info[] = {
 	},
 	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &max5821_powerdown_mode_enum),
 	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &max5821_powerdown_mode_enum),
-	{ },
+	{ }
 };
 
 #define MAX5821_CHANNEL(chan) {					\
diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 1337fb02ccf5594e19e1a836c60480b99708ebba..62972494a2291af62fd62ae893b4cefd6f00c227 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -241,7 +241,7 @@ static const struct iio_chan_spec_ext_info mcp4725_ext_info[] = {
 			&mcp472x_powerdown_mode_enum[MCP4725]),
 	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
 			   &mcp472x_powerdown_mode_enum[MCP4725]),
-	{ },
+	{ }
 };
 
 static const struct iio_chan_spec_ext_info mcp4726_ext_info[] = {
@@ -255,7 +255,7 @@ static const struct iio_chan_spec_ext_info mcp4726_ext_info[] = {
 			&mcp472x_powerdown_mode_enum[MCP4726]),
 	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
 			   &mcp472x_powerdown_mode_enum[MCP4726]),
-	{ },
+	{ }
 };
 
 static const struct iio_chan_spec mcp472x_channel[] = {
diff --git a/drivers/iio/dac/mcp4728.c b/drivers/iio/dac/mcp4728.c
index 192175dc6419eaea475a3edbfb31cee047c6a607..4f30b99110b790d902786503324a118970f27a29 100644
--- a/drivers/iio/dac/mcp4728.c
+++ b/drivers/iio/dac/mcp4728.c
@@ -286,7 +286,7 @@ static const struct iio_chan_spec_ext_info mcp4728_ext_info[] = {
 	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &mcp4728_powerdown_mode_enum),
 	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
 			   &mcp4728_powerdown_mode_enum),
-	{},
+	{ }
 };
 
 static const struct iio_chan_spec mcp4728_channels[MCP4728_N_CHANNELS] = {
@@ -573,13 +573,13 @@ static int mcp4728_probe(struct i2c_client *client)
 
 static const struct i2c_device_id mcp4728_id[] = {
 	{ "mcp4728" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp4728_id);
 
 static const struct of_device_id mcp4728_of_match[] = {
 	{ .compatible = "microchip,mcp4728" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp4728_of_match);
 
diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
index c1a59bbbba3cc1634f5c70be07dea9b6a1a282ed..748bdca9a964dd39386295f347d52aa8c217c616 100644
--- a/drivers/iio/dac/mcp4821.c
+++ b/drivers/iio/dac/mcp4821.c
@@ -206,7 +206,7 @@ static const struct of_device_id mcp4821_of_table[] = {
 	MCP4821_COMPATIBLE("microchip,mcp4812", ID_MCP4812),
 	MCP4821_COMPATIBLE("microchip,mcp4821", ID_MCP4821),
 	MCP4821_COMPATIBLE("microchip,mcp4822", ID_MCP4822),
-	{ /* Sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp4821_of_table);
 
@@ -217,7 +217,7 @@ static const struct spi_device_id mcp4821_id_table[] = {
 	{ "mcp4812", (kernel_ulong_t)&mcp4821_chip_info_table[ID_MCP4812]},
 	{ "mcp4821", (kernel_ulong_t)&mcp4821_chip_info_table[ID_MCP4821]},
 	{ "mcp4822", (kernel_ulong_t)&mcp4821_chip_info_table[ID_MCP4822]},
-	{ /* Sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, mcp4821_id_table);
 
diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
index 26aa9905981340d8248ba93b0d339ce47c6f393e..74f338afcab98d78d961b9cf0ae6cb6626329ebe 100644
--- a/drivers/iio/dac/mcp4922.c
+++ b/drivers/iio/dac/mcp4922.c
@@ -161,7 +161,7 @@ static const struct spi_device_id mcp4922_id[] = {
 	{"mcp4912", ID_MCP4912},
 	{"mcp4921", ID_MCP4921},
 	{"mcp4922", ID_MCP4922},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, mcp4922_id);
 
diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
index 95ed5197d16f563ab68eefebec41a30f8c191b02..8ef702917060963005c19021959e983b41611df3 100644
--- a/drivers/iio/dac/stm32-dac-core.c
+++ b/drivers/iio/dac/stm32-dac-core.c
@@ -239,7 +239,7 @@ static const struct of_device_id stm32_dac_of_match[] = {
 		.compatible = "st,stm32h7-dac-core",
 		.data = (void *)&stm32h7_dac_cfg,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stm32_dac_of_match);
 
diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index 3bfb368b3a234022ef88ee25e8d19fb2dbc7531e..344388338d9b029009ba2f04a2bae05ee43c64d0 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -250,7 +250,7 @@ static const struct iio_chan_spec_ext_info stm32_dac_ext_info[] = {
 	},
 	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &stm32_dac_powerdown_mode_en),
 	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &stm32_dac_powerdown_mode_en),
-	{},
+	{ }
 };
 
 #define STM32_DAC_CHANNEL(chan, name) {			\
@@ -392,7 +392,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stm32_dac_pm_ops, stm32_dac_suspend,
 
 static const struct of_device_id stm32_dac_of_match[] = {
 	{ .compatible = "st,stm32-dac", },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stm32_dac_of_match);
 
diff --git a/drivers/iio/dac/ti-dac082s085.c b/drivers/iio/dac/ti-dac082s085.c
index 8e1590e3cc8b28c3b669aac8a0f578784adb9aab..715870c8a9c4a8940d5e932b6555d2be341b43c1 100644
--- a/drivers/iio/dac/ti-dac082s085.c
+++ b/drivers/iio/dac/ti-dac082s085.c
@@ -161,7 +161,7 @@ static const struct iio_chan_spec_ext_info ti_dac_ext_info[] = {
 	},
 	IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE, &ti_dac_powerdown_mode),
 	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ti_dac_powerdown_mode),
-	{ },
+	{ }
 };
 
 #define TI_DAC_CHANNEL(chan) {					\
diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index c5162b72951af6c4d0a56a93cf3f3d65ead8aa12..bdc3f94aef98dea64341996430c3dbfaf56a3abf 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -216,7 +216,7 @@ static const struct iio_chan_spec_ext_info dac5571_ext_info[] = {
 	},
 	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &dac5571_powerdown_mode),
 	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &dac5571_powerdown_mode),
-	{},
+	{ }
 };
 
 #define dac5571_CHANNEL(chan, name) {				\
@@ -398,7 +398,7 @@ static const struct of_device_id dac5571_of_id[] = {
 	{.compatible = "ti,dac5573", .data = &dac5571_spec[quad_8bit] },
 	{.compatible = "ti,dac6573", .data = &dac5571_spec[quad_10bit] },
 	{.compatible = "ti,dac7573", .data = &dac5571_spec[quad_12bit] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dac5571_of_id);
 
@@ -414,7 +414,7 @@ static const struct i2c_device_id dac5571_id[] = {
 	{"dac5573", (kernel_ulong_t)&dac5571_spec[quad_8bit] },
 	{"dac6573", (kernel_ulong_t)&dac5571_spec[quad_10bit] },
 	{"dac7573", (kernel_ulong_t)&dac5571_spec[quad_12bit] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, dac5571_id);
 
diff --git a/drivers/iio/dac/ti-dac7311.c b/drivers/iio/dac/ti-dac7311.c
index 6f4aa4794a0cabe07ea5a73522826891f23e04c1..3d2ce61f0db653db9ea0f23a94ffd4ff5e3192a2 100644
--- a/drivers/iio/dac/ti-dac7311.c
+++ b/drivers/iio/dac/ti-dac7311.c
@@ -147,7 +147,7 @@ static const struct iio_chan_spec_ext_info ti_dac_ext_info[] = {
 	},
 	IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE, &ti_dac_powerdown_mode),
 	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ti_dac_powerdown_mode),
-	{ },
+	{ }
 };
 
 #define TI_DAC_CHANNEL(chan) {					\
diff --git a/drivers/iio/dac/ti-dac7612.c b/drivers/iio/dac/ti-dac7612.c
index 8195815de26feabc96102abcca851a82476b2b41..c308eca02b88bd23ff3c91dcb39caf9789dd7b66 100644
--- a/drivers/iio/dac/ti-dac7612.c
+++ b/drivers/iio/dac/ti-dac7612.c
@@ -166,7 +166,7 @@ static int dac7612_probe(struct spi_device *spi)
 
 static const struct spi_device_id dac7612_id[] = {
 	{"ti-dac7612"},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, dac7612_id);
 
@@ -174,7 +174,7 @@ static const struct of_device_id dac7612_of_match[] = {
 	{ .compatible = "ti,dac7612" },
 	{ .compatible = "ti,dac7612u" },
 	{ .compatible = "ti,dac7612ub" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dac7612_of_match);
 
diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
index 82a078fa98ad9a86d1d09b456a93321d197b3d0e..b30ff7bb44002d4f02c5eb4ac7633774d16b7813 100644
--- a/drivers/iio/dac/vf610_dac.c
+++ b/drivers/iio/dac/vf610_dac.c
@@ -99,7 +99,7 @@ static const struct iio_enum vf610_conversion_mode = {
 static const struct iio_chan_spec_ext_info vf610_ext_info[] = {
 	IIO_ENUM("conversion_mode", IIO_SHARED_BY_DIR,
 		&vf610_conversion_mode),
-	{},
+	{ }
 };
 
 #define VF610_DAC_CHAN(_chan_type) { \
@@ -166,7 +166,7 @@ static const struct iio_info vf610_dac_iio_info = {
 
 static const struct of_device_id vf610_dac_match[] = {
 	{ .compatible = "fsl,vf610-dac", },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, vf610_dac_match);
 
diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index cc8ce0fe74e7c6e738accd1e5f2035ccfee299db..19f823446cdad9176beee4949f0466bf51d6f126 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -602,7 +602,7 @@ static const struct iio_enum admv8818_mode_enum = {
 static const struct iio_chan_spec_ext_info admv8818_ext_info[] = {
 	IIO_ENUM("filter_mode", IIO_SHARED_BY_ALL, &admv8818_mode_enum),
 	IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_ALL, &admv8818_mode_enum),
-	{ },
+	{ }
 };
 
 #define ADMV8818_CHAN(_channel) {				\
@@ -797,13 +797,13 @@ static int admv8818_probe(struct spi_device *spi)
 
 static const struct spi_device_id admv8818_id[] = {
 	{ "admv8818", 0 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, admv8818_id);
 
 static const struct of_device_id admv8818_of_match[] = {
 	{ .compatible = "adi,admv8818" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, admv8818_of_match);
 
diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index b1554ced7a26b8c331e833f3125a9927e8ace289..63c485e9e44cdd598418b8c89c71102643a1ad1a 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -1032,7 +1032,7 @@ static int ad9523_probe(struct spi_device *spi)
 
 static const struct spi_device_id ad9523_id[] = {
 	{"ad9523-1", 9523},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad9523_id);
 
diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 61828e61e27589b68ca729cac9cfa9c3b83da9a1..47f1c7e9efa9f425a4c7cf82be930234e2c18434 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -373,7 +373,7 @@ static const struct iio_chan_spec_ext_info adf4350_ext_info[] = {
 	_ADF4350_EXT_INFO("frequency_resolution", ADF4350_FREQ_RESOLUTION),
 	_ADF4350_EXT_INFO("refin_frequency", ADF4350_FREQ_REFIN),
 	_ADF4350_EXT_INFO("powerdown", ADF4350_PWRDOWN),
-	{ },
+	{ }
 };
 
 static const struct iio_chan_spec adf4350_chan = {
@@ -682,14 +682,14 @@ static int adf4350_probe(struct spi_device *spi)
 static const struct of_device_id adf4350_of_match[] = {
 	{ .compatible = "adi,adf4350", },
 	{ .compatible = "adi,adf4351", },
-	{ /* sentinel */ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adf4350_of_match);
 
 static const struct spi_device_id adf4350_id[] = {
 	{"adf4350", 4350},
 	{"adf4351", 4351},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, adf4350_id);
 
diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index 9a84e81787b1120a12467a5375a0777a0ef7f7ec..d6dc7827fb410da487610e1203f5e19da79f8a30 100644
--- a/drivers/iio/frequency/adf4371.c
+++ b/drivers/iio/frequency/adf4371.c
@@ -438,7 +438,7 @@ static const struct iio_chan_spec_ext_info adf4371_ext_info[] = {
 	_ADF4371_EXT_INFO("frequency", ADF4371_FREQ),
 	_ADF4371_EXT_INFO("powerdown", ADF4371_POWER_DOWN),
 	_ADF4371_EXT_INFO("name", ADF4371_CHANNEL_NAME),
-	{ },
+	{ }
 };
 
 #define ADF4371_CHANNEL(index) { \
@@ -626,14 +626,14 @@ static int adf4371_probe(struct spi_device *spi)
 static const struct spi_device_id adf4371_id_table[] = {
 	{ "adf4371", (kernel_ulong_t)&adf4371_chip_info },
 	{ "adf4372", (kernel_ulong_t)&adf4372_chip_info },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, adf4371_id_table);
 
 static const struct of_device_id adf4371_of_match[] = {
 	{ .compatible = "adi,adf4371", .data = &adf4371_chip_info },
 	{ .compatible = "adi,adf4372", .data = &adf4372_chip_info},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adf4371_of_match);
 
diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index 45ceeb828d6b683d8e28cf6df74be25854e2cbec..08833b7035e4babee0aa167005a762c0f0b0b6c1 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -985,14 +985,14 @@ static int adf4377_probe(struct spi_device *spi)
 static const struct spi_device_id adf4377_id[] = {
 	{ "adf4377", (kernel_ulong_t)&adf4377_chip_info },
 	{ "adf4378", (kernel_ulong_t)&adf4378_chip_info },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, adf4377_id);
 
 static const struct of_device_id adf4377_of_match[] = {
 	{ .compatible = "adi,adf4377", .data = &adf4377_chip_info },
 	{ .compatible = "adi,adf4378", .data = &adf4378_chip_info },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adf4377_of_match);
 
diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index 8ef583680ad0b18959225a8129ca1fcd7f4b0db0..6f50884d7130637a9a74af7807c6d328def58589 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -407,7 +407,7 @@ static int admv1013_freq_change(struct notifier_block *nb, unsigned long action,
 static const struct iio_chan_spec_ext_info admv1013_ext_info[] = {
 	_ADMV1013_EXT_INFO("i_calibphase", IIO_SEPARATE, ADMV1013_RFMOD_I_CALIBPHASE),
 	_ADMV1013_EXT_INFO("q_calibphase", IIO_SEPARATE, ADMV1013_RFMOD_Q_CALIBPHASE),
-	{ },
+	{ }
 };
 
 #define ADMV1013_CHAN_PHASE(_channel, _channel2, _admv1013_ext_info) {		\
@@ -615,13 +615,13 @@ static int admv1013_probe(struct spi_device *spi)
 
 static const struct spi_device_id admv1013_id[] = {
 	{ "admv1013", 0 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, admv1013_id);
 
 static const struct of_device_id admv1013_of_match[] = {
 	{ .compatible = "adi,admv1013" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, admv1013_of_match);
 
diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
index 986b87a72577e596645448a4969b4e1fa5842a28..7a8f92ec80a2e8f699e90550379b8c99ec9ebffd 100644
--- a/drivers/iio/frequency/admv1014.c
+++ b/drivers/iio/frequency/admv1014.c
@@ -792,13 +792,13 @@ static int admv1014_probe(struct spi_device *spi)
 
 static const struct spi_device_id admv1014_id[] = {
 	{ "admv1014", 0 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, admv1014_id);
 
 static const struct of_device_id admv1014_of_match[] = {
 	{ .compatible = "adi,admv1014" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, admv1014_of_match);
 
diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
index 57ee908fc747e153347ced3d87af515716d90efc..a7a21f929970d4ee947fe22a3ad81a5e3b6f226a 100644
--- a/drivers/iio/frequency/adrf6780.c
+++ b/drivers/iio/frequency/adrf6780.c
@@ -487,13 +487,13 @@ static int adrf6780_probe(struct spi_device *spi)
 
 static const struct spi_device_id adrf6780_id[] = {
 	{ "adrf6780", 0 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, adrf6780_id);
 
 static const struct of_device_id adrf6780_of_match[] = {
 	{ .compatible = "adi,adrf6780" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adrf6780_of_match);
 
diff --git a/drivers/iio/gyro/adis16080.c b/drivers/iio/gyro/adis16080.c
index 14b3abf6dce95294e9b0f35ee049757675fe30ce..178bba95a70943d40ed7ca875aa05ec4a290eb1b 100644
--- a/drivers/iio/gyro/adis16080.c
+++ b/drivers/iio/gyro/adis16080.c
@@ -214,7 +214,7 @@ static int adis16080_probe(struct spi_device *spi)
 static const struct spi_device_id adis16080_ids[] = {
 	{ "adis16080", ID_ADIS16080 },
 	{ "adis16100", ID_ADIS16100 },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, adis16080_ids);
 
diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index c151fbb59ffe884a3ecefa8e1004e518e46c93c0..586e6cfa14a95437ea38197d4213566cc652ef4d 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -414,7 +414,7 @@ static const struct spi_device_id adis16260_id[] = {
 	{"adis16250", ADIS16260},
 	{"adis16255", ADIS16260},
 	{"adis16251", ADIS16251},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, adis16260_id);
 
diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
index f84438e0c42c5840217680496e1aa5f43326d4d9..5dadb88a4d92c27b4bcba121660198311c50150b 100644
--- a/drivers/iio/gyro/adxrs450.c
+++ b/drivers/iio/gyro/adxrs450.c
@@ -446,7 +446,7 @@ static int adxrs450_probe(struct spi_device *spi)
 static const struct spi_device_id adxrs450_id[] = {
 	{"adxrs450", ID_ADXRS450},
 	{"adxrs453", ID_ADXRS453},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, adxrs450_id);
 
diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
index e6caab49f98a7048d64eef2fe6f9731d38dafbdc..1fb8a7969c25d32473f9289f0951e974b60570fa 100644
--- a/drivers/iio/gyro/bmg160_i2c.c
+++ b/drivers/iio/gyro/bmg160_i2c.c
@@ -41,7 +41,7 @@ static void bmg160_i2c_remove(struct i2c_client *client)
 
 static const struct acpi_device_id bmg160_acpi_match[] = {
 	{"BMG0160", 0},
-	{},
+	{ }
 };
 
 MODULE_DEVICE_TABLE(acpi, bmg160_acpi_match);
@@ -50,7 +50,7 @@ static const struct i2c_device_id bmg160_i2c_id[] = {
 	{ "bmg160" },
 	{ "bmi055_gyro" },
 	{ "bmi088_gyro" },
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, bmg160_i2c_id);
diff --git a/drivers/iio/gyro/bmg160_spi.c b/drivers/iio/gyro/bmg160_spi.c
index ac04b3b1b554a80c40a42896a42f5cee910613a8..6aecc5eb83472ee515c33315d78668bd9a753957 100644
--- a/drivers/iio/gyro/bmg160_spi.c
+++ b/drivers/iio/gyro/bmg160_spi.c
@@ -36,7 +36,7 @@ static const struct spi_device_id bmg160_spi_id[] = {
 	{"bmg160", 0},
 	{"bmi055_gyro", 0},
 	{"bmi088_gyro", 0},
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(spi, bmg160_spi_id);
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 54b6f6fbdcaa12abac3bab53c72c14464eeaa568..c43990c518f7756e1269dac61c791d34e2704ff0 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -375,7 +375,7 @@ static const struct platform_device_id hid_gyro_3d_ids[] = {
 		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
 		.name = "HID-SENSOR-200076",
 	},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, hid_gyro_3d_ids);
 
diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index d66224bed8e3aba5f9805b837ab25ca7b74b5548..16553948c5c3a40b79cb2c9663e2d42e18782fa6 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -684,7 +684,7 @@ mpu3050_get_mount_matrix(const struct iio_dev *indio_dev,
 
 static const struct iio_chan_spec_ext_info mpu3050_ext_info[] = {
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, mpu3050_get_mount_matrix),
-	{ },
+	{ }
 };
 
 #define MPU3050_AXIS_CHANNEL(axis, index)				\
diff --git a/drivers/iio/gyro/mpu3050-i2c.c b/drivers/iio/gyro/mpu3050-i2c.c
index 29ecfa6fd633505ae0e9aa1653d90bb5f73dcb1e..8e284f47242c5c281769beda824652db4cda2b43 100644
--- a/drivers/iio/gyro/mpu3050-i2c.c
+++ b/drivers/iio/gyro/mpu3050-i2c.c
@@ -95,7 +95,7 @@ static void mpu3050_i2c_remove(struct i2c_client *client)
  */
 static const struct i2c_device_id mpu3050_i2c_id[] = {
 	{ "mpu3050" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mpu3050_i2c_id);
 
@@ -103,7 +103,7 @@ static const struct of_device_id mpu3050_i2c_of_match[] = {
 	{ .compatible = "invensense,mpu3050", .data = "mpu3050" },
 	/* Deprecated vendor ID from the Input driver */
 	{ .compatible = "invn,mpu3050", .data = "mpu3050" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mpu3050_i2c_of_match);
 
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index d4b11bdba66693cf1343d20fedad32450ebee3be..aef5ec8f9deef2e9e39837377b1348768455f875 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -54,7 +54,7 @@ static const struct of_device_id st_gyro_of_match[] = {
 		.compatible = "st,lsm9ds0-gyro",
 		.data = LSM9DS0_GYRO_DEV_NAME,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st_gyro_of_match);
 
@@ -102,7 +102,7 @@ static const struct i2c_device_id st_gyro_id_table[] = {
 	{ L3G4IS_GYRO_DEV_NAME },
 	{ LSM330_GYRO_DEV_NAME },
 	{ LSM9DS0_GYRO_DEV_NAME },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, st_gyro_id_table);
 
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index 811f712711f5ef7725a96422c81ab31d4dcdbb49..f645da157372b5dc106bc451ea0b4dee263d6fc7 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -59,7 +59,7 @@ static const struct of_device_id st_gyro_of_match[] = {
 		.compatible = "st,lsm9ds0-gyro",
 		.data = LSM9DS0_GYRO_DEV_NAME,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st_gyro_of_match);
 
@@ -107,7 +107,7 @@ static const struct spi_device_id st_gyro_id_table[] = {
 	{ L3G4IS_GYRO_DEV_NAME },
 	{ LSM330_GYRO_DEV_NAME },
 	{ LSM9DS0_GYRO_DEV_NAME },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, st_gyro_id_table);
 
diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 13e1dd4dd62cad0023ed0b4268a4b0deda5a207a..1582cfc03579d29bb830896517d92104df900bab 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -411,7 +411,7 @@ static const struct regmap_config afe4403_regmap_config = {
 
 static const struct of_device_id afe4403_of_match[] = {
 	{ .compatible = "ti,afe4403", },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, afe4403_of_match);
 
@@ -574,7 +574,7 @@ static int afe4403_probe(struct spi_device *spi)
 
 static const struct spi_device_id afe4403_ids[] = {
 	{ "afe4403", 0 },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, afe4403_ids);
 
diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index d49e1572a439f8b861e937e2903e9726924a17be..99ff68aed27c8ac512fb8f6d1acb5e588e46f6e4 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -419,7 +419,7 @@ static const struct regmap_config afe4404_regmap_config = {
 
 static const struct of_device_id afe4404_of_match[] = {
 	{ .compatible = "ti,afe4404", },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, afe4404_of_match);
 
@@ -581,7 +581,7 @@ static int afe4404_probe(struct i2c_client *client)
 
 static const struct i2c_device_id afe4404_ids[] = {
 	{ "afe4404" },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, afe4404_ids);
 
diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index e08d143a707c0b26f2ea3c75fad87f9f4a6884a1..846664a4ee905caabb146ffd08b6a474d61064a0 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -483,7 +483,7 @@ static void max30100_remove(struct i2c_client *client)
 
 static const struct i2c_device_id max30100_id[] = {
 	{ "max30100" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max30100_id);
 
diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index dacc489f7293281bbd8945c6ecc638e850c14f2a..f5f29d2fec574357f2287991c954a3caa501a624 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -615,7 +615,7 @@ static const struct i2c_device_id max30102_id[] = {
 	{ "max30101", max30105 },
 	{ "max30102", max30102 },
 	{ "max30105", max30105 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max30102_id);
 
diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index 2323974b805c55f3b4cdcc6cae18bdeef7f729e8..f021c3e6d88691de58084e83e0c5c5b03a1bb893 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -253,7 +253,7 @@ static int am2315_probe(struct i2c_client *client)
 
 static const struct i2c_device_id am2315_i2c_id[] = {
 	{ "am2315" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, am2315_i2c_id);
 
diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index a40e1eb6e98c26dce76c188542a70eec7d0f872e..be2338d5f407086d3d5d8645ba30d9e3a46da627 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -276,7 +276,7 @@ static const struct platform_device_id hid_humidity_ids[] = {
 		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
 		.name = "HID-SENSOR-200032",
 	},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, hid_humidity_ids);
 
diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
index 87a8e3c8d277275c065f081c19e6e620cbfef8f5..cbaa7d1af6c4e7988348ef70074791b4f2fda237 100644
--- a/drivers/iio/humidity/hts221_i2c.c
+++ b/drivers/iio/humidity/hts221_i2c.c
@@ -42,19 +42,19 @@ static int hts221_i2c_probe(struct i2c_client *client)
 
 static const struct acpi_device_id hts221_acpi_match[] = {
 	{"SMO9100", 0},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, hts221_acpi_match);
 
 static const struct of_device_id hts221_i2c_of_match[] = {
 	{ .compatible = "st,hts221", },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, hts221_i2c_of_match);
 
 static const struct i2c_device_id hts221_i2c_id_table[] = {
 	{ HTS221_DEV_NAME },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, hts221_i2c_id_table);
 
diff --git a/drivers/iio/humidity/hts221_spi.c b/drivers/iio/humidity/hts221_spi.c
index 00154b9d66b5d590b4484786174b407a222bfa11..e6fef2acd523ecbba26d2e3c103f95bfdc358a40 100644
--- a/drivers/iio/humidity/hts221_spi.c
+++ b/drivers/iio/humidity/hts221_spi.c
@@ -42,13 +42,13 @@ static int hts221_spi_probe(struct spi_device *spi)
 
 static const struct of_device_id hts221_spi_of_match[] = {
 	{ .compatible = "st,hts221", },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, hts221_spi_of_match);
 
 static const struct spi_device_id hts221_spi_id_table[] = {
 	{ HTS221_DEV_NAME },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, hts221_spi_id_table);
 
diff --git a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c
index 6402e393edb875771c9313dd9ff33d7d9c74ce0f..7f1775bd26fdb2f2c08235a7544d8e5a7f893e4a 100644
--- a/drivers/iio/humidity/htu21.c
+++ b/drivers/iio/humidity/htu21.c
@@ -232,14 +232,14 @@ static int htu21_probe(struct i2c_client *client)
 static const struct i2c_device_id htu21_id[] = {
 	{"htu21", HTU21},
 	{"ms8607-humidity", MS8607},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, htu21_id);
 
 static const struct of_device_id htu21_of_match[] = {
 	{ .compatible = "meas,htu21", },
 	{ .compatible = "meas,ms8607-humidity", },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, htu21_of_match);
 
diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 3086dd53620382d25c5b0c35aa1b3aeea8cc722d..90ed3f9bb39c502996161d9df3addcb093ccd11a 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -1212,7 +1212,7 @@ static const struct spi_device_id adis16400_id[] = {
 	{"adis16405", ADIS16400},
 	{"adis16445", ADIS16445},
 	{"adis16448", ADIS16448},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, adis16400_id);
 
diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index ecf74046fde1f87a69fc2d57268fc64ab7c9a9ef..ba1887d36577c8f4078ede762b8b98dd373d1046 100644
--- a/drivers/iio/imu/adis16460.c
+++ b/drivers/iio/imu/adis16460.c
@@ -395,13 +395,13 @@ static int adis16460_probe(struct spi_device *spi)
 
 static const struct spi_device_id adis16460_ids[] = {
 	{ "adis16460", 0 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, adis16460_ids);
 
 static const struct of_device_id adis16460_of_match[] = {
 	{ .compatible = "adi,adis16460" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adis16460_of_match);
 
diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index df8c6cd911694a29f6e68dd6eedeb16f497d732e..924395b7e3b45dd3a6459d6eb788fa2ec86c4a29 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -2058,7 +2058,7 @@ static const struct of_device_id adis16475_of_match[] = {
 		.data = &adis16475_chip_info[ADIS16577_2] },
 	{ .compatible = "adi,adis16577-3",
 		.data = &adis16475_chip_info[ADIS16577_3] },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adis16475_of_match);
 
diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 727e0a11eac14771b1052aee4e301ab0bb9c4870..543d5c4bfb114eff00b230ffdc36f6a34c00ce72 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -1852,7 +1852,7 @@ static const struct of_device_id adis16480_of_match[] = {
 	{ .compatible = "adi,adis16547-1" },
 	{ .compatible = "adi,adis16547-2" },
 	{ .compatible = "adi,adis16547-3" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adis16480_of_match);
 
diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index 214503fa4af56ea9b2640b0e2b1c4aa01269426b..9fa3a19a8977f7292e48a5ec165986997f60b206 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -39,7 +39,7 @@ static int bmi160_i2c_probe(struct i2c_client *client)
 static const struct i2c_device_id bmi160_i2c_id[] = {
 	{ "bmi120" },
 	{ "bmi160" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bmi160_i2c_id);
 
@@ -55,14 +55,14 @@ static const struct acpi_device_id bmi160_acpi_match[] = {
 	{"10EC5280", 0},
 	{"BMI0120", 0},
 	{"BMI0160", 0},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);
 
 static const struct of_device_id bmi160_of_match[] = {
 	{ .compatible = "bosch,bmi120" },
 	{ .compatible = "bosch,bmi160" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, bmi160_of_match);
 
diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index 8fbaab22db812369a66564fff698653c1e0e32d0..ebb586904215bad67c615de9f299df294d0f83ef 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -36,21 +36,21 @@ static int bmi160_spi_probe(struct spi_device *spi)
 static const struct spi_device_id bmi160_spi_id[] = {
 	{"bmi120", 0},
 	{"bmi160", 0},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, bmi160_spi_id);
 
 static const struct acpi_device_id bmi160_acpi_match[] = {
 	{"BMI0120", 0},
 	{"BMI0160", 0},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);
 
 static const struct of_device_id bmi160_of_match[] = {
 	{ .compatible = "bosch,bmi120" },
 	{ .compatible = "bosch,bmi160" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, bmi160_of_match);
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 1a67f5ce1800c2871be750a584f638292ace98b9..e6cd9dcb0687d19554e63a69dc60f065c58d70ee 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -157,7 +157,7 @@ static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_infos[] = {
 			   &inv_icm42600_accel_power_mode_enum),
 	IIO_ENUM("power_mode", IIO_SHARED_BY_TYPE,
 		 &inv_icm42600_accel_power_mode_enum),
-	{},
+	{ }
 };
 
 static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 70bac8ca28fae7eea25e015108adc9d208e3bc55..b4d7ce1432a4f4d096599877040a89ede0625e0b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -57,7 +57,7 @@ enum inv_icm42600_gyro_scan {
 
 static const struct iio_chan_spec_ext_info inv_icm42600_gyro_ext_infos[] = {
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42600_get_mount_matrix),
-	{},
+	{ }
 };
 
 static const struct iio_chan_spec inv_icm42600_gyro_channels[] = {
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index 04e440fe023aa3869529b0f0be003ea0544bfb8d..02f9dd126d94b8bfe1dc124919dff1bf837c6853 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -110,7 +110,7 @@ static const struct of_device_id inv_icm42600_of_matches[] = {
 		.compatible = "invensense,icm42631",
 		.data = (void *)INV_CHIP_ICM42631,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, inv_icm42600_of_matches);
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index 2bd2c4c8e50c3fe081e882aca6c64736510b474c..47111944971983311bc152d36177861549fe0049 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -107,7 +107,7 @@ static const struct of_device_id inv_icm42600_of_matches[] = {
 		.compatible = "invensense,icm42631",
 		.data = (void *)INV_CHIP_ICM42631,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, inv_icm42600_of_matches);
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
index 373e59f6d91a5b058e739023b2c46c5826e88ec0..a9bcf02e5b43fac0e210c6f78816a3c042b52f3d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
@@ -39,7 +39,7 @@ static const struct dmi_system_id inv_mpu_dev_list[] = {
 		},
 	},
 	/* Add more matching tables here..*/
-	{}
+	{ }
 };
 
 static int asus_acpi_get_sensor_info(struct acpi_device *adev,
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 91d77f94d2046aa141eaf33c17d0d5391fe606eb..8dc61812a8fc46c907ba7019965444a29d551e63 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -192,7 +192,7 @@ static const struct i2c_device_id inv_mpu_id[] = {
 	{"iam20680", INV_IAM20680},
 	{"iam20680hp", INV_IAM20680HP},
 	{"iam20680ht", INV_IAM20680HT},
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, inv_mpu_id);
@@ -276,7 +276,7 @@ MODULE_DEVICE_TABLE(of, inv_of_match);
 
 static const struct acpi_device_id inv_acpi_match[] = {
 	{"INVN6500", INV_MPU6500},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 20de6eb5cd35568623ed3e6ae6aac49a632a681a..1f4c62142b606688a80476f83c9538b614dfa544 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -83,7 +83,7 @@ static const struct spi_device_id inv_mpu_id[] = {
 	{"iam20680", INV_IAM20680},
 	{"iam20680hp", INV_IAM20680HP},
 	{"iam20680ht", INV_IAM20680HT},
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(spi, inv_mpu_id);
@@ -163,7 +163,7 @@ MODULE_DEVICE_TABLE(of, inv_of_match);
 
 static const struct acpi_device_id inv_acpi_match[] = {
 	{"INVN6000", INV_MPU6000},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
 
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index e19c5d3137c6fd96ec5f9314c183c11835dea0af..2bdfb2619137c353c2659f554f4ff84b612e1718 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1487,7 +1487,7 @@ static const struct dev_pm_ops kmx61_pm_ops = {
 
 static const struct i2c_device_id kmx61_id[] = {
 	{ "kmx611021" },
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, kmx61_id);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 25e1de89b6e49fe28b337c1d79087c491a25878b..7c933218036b840ccb7e4ed424968c7e5adb7d38 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -138,13 +138,13 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 		.compatible = "st,asm330lhhxg1",
 		.data = (void *)ST_ASM330LHHXG1_ID,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
 
 static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
 	{ "SMO8B30", ST_LSM6DS3TRC_ID, },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, st_lsm6dsx_i2c_acpi_match);
 
@@ -173,7 +173,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
 	{ ST_ISM330IS_DEV_NAME, ST_ISM330IS_ID },
 	{ ST_ASM330LHB_DEV_NAME, ST_ASM330LHB_ID },
 	{ ST_ASM330LHHXG1_DEV_NAME, ST_ASM330LHHXG1_ID },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
index f968f32890d17447ae9579c433c4a3eb6a84740b..cb5c5d7e1f3db26fcd97521aabd830e0b27ea790 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
@@ -17,7 +17,7 @@
 static const struct i3c_device_id st_lsm6dsx_i3c_ids[] = {
 	I3C_DEVICE(0x0104, 0x006C, (void *)ST_LSM6DSO_ID),
 	I3C_DEVICE(0x0104, 0x006B, (void *)ST_LSM6DSR_ID),
-	{ /* sentinel */ },
+	{ }
 };
 MODULE_DEVICE_TABLE(i3c, st_lsm6dsx_i3c_ids);
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index 4b4b6d45524fb8779039e123c1f2a5ed1d7cf846..3389b15df0bc0678fe613f0dbe20a84919600b46 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -133,7 +133,7 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
 		.compatible = "st,asm330lhhxg1",
 		.data = (void *)ST_ASM330LHHXG1_ID,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
 
@@ -162,7 +162,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
 	{ ST_ISM330IS_DEV_NAME, ST_ISM330IS_ID },
 	{ ST_ASM330LHB_DEV_NAME, ST_ASM330LHB_ID },
 	{ ST_ASM330LHHXG1_DEV_NAME, ST_ASM330LHHXG1_ID },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
 
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
index 8cc071463249d42b66cf91b93c66a244c5db8992..4232a9d800fc97c2c3139157dd931a47d1022449 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
@@ -28,20 +28,20 @@ static const struct of_device_id st_lsm9ds0_of_match[] = {
 		.compatible = "st,lsm9ds0-imu",
 		.data = LSM9DS0_IMU_DEV_NAME,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st_lsm9ds0_of_match);
 
 static const struct i2c_device_id st_lsm9ds0_id_table[] = {
 	{ LSM303D_IMU_DEV_NAME },
 	{ LSM9DS0_IMU_DEV_NAME },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, st_lsm9ds0_id_table);
 
 static const struct acpi_device_id st_lsm9ds0_acpi_match[] = {
 	{"ACCL0001", (kernel_ulong_t)LSM303D_IMU_DEV_NAME},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, st_lsm9ds0_acpi_match);
 
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
index 806e55f75f656d861b9414ce8eaebdbebbb95ec4..acea8a0757d73b4f50456b29a7f05308b4fc734f 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c
@@ -28,14 +28,14 @@ static const struct of_device_id st_lsm9ds0_of_match[] = {
 		.compatible = "st,lsm9ds0-imu",
 		.data = LSM9DS0_IMU_DEV_NAME,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st_lsm9ds0_of_match);
 
 static const struct spi_device_id st_lsm9ds0_id_table[] = {
 	{ LSM303D_IMU_DEV_NAME },
 	{ LSM9DS0_IMU_DEV_NAME },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, st_lsm9ds0_id_table);
 
diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 2d91caf24dd0ae77f72ad7573d28d8532ba6f984..032e6cae8b80535ff29599c47bbcc1de55072673 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -230,7 +230,7 @@ static int acpi_als_add(struct acpi_device *device)
 
 static const struct acpi_device_id acpi_als_device_ids[] = {
 	{"ACPI0008", 0},
-	{},
+	{ }
 };
 
 MODULE_DEVICE_TABLE(acpi, acpi_als_device_ids);
diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
index 9240983a6cc47d0fd8a564f2d71c133c15b9af2e..e321f89c534042c417dbe26cabb35a7dde9ae42b 100644
--- a/drivers/iio/light/adux1020.c
+++ b/drivers/iio/light/adux1020.c
@@ -820,7 +820,7 @@ static int adux1020_probe(struct i2c_client *client)
 
 static const struct i2c_device_id adux1020_id[] = {
 	{ "adux1020" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adux1020_id);
 
diff --git a/drivers/iio/light/al3000a.c b/drivers/iio/light/al3000a.c
index 6d5115b2a06c5acce18d831b9c41d3d5121fba12..6f301c0670454e2f729e1b2545e6203cdbc91c11 100644
--- a/drivers/iio/light/al3000a.c
+++ b/drivers/iio/light/al3000a.c
@@ -190,7 +190,7 @@ MODULE_DEVICE_TABLE(i2c, al3000a_id);
 
 static const struct of_device_id al3000a_of_match[] = {
 	{ .compatible = "dynaimage,al3000a" },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, al3000a_of_match);
 
diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 8e703c81f9547c1a5eaabe8fa1d57aadedbc1346..0932fa2b49fa7cd99f10c7b4dbbbb51f111618c6 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -219,13 +219,13 @@ static DEFINE_SIMPLE_DEV_PM_OPS(al3010_pm_ops, al3010_suspend, al3010_resume);
 
 static const struct i2c_device_id al3010_id[] = {
 	{"al3010", },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, al3010_id);
 
 static const struct of_device_id al3010_of_match[] = {
 	{ .compatible = "dynaimage,al3010", },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, al3010_of_match);
 
diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 31f5e033c386ddf69586287431b2092f88946db6..63f5a85912fc9a72858c49f6c207e385fbd2cde7 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -247,19 +247,19 @@ static DEFINE_SIMPLE_DEV_PM_OPS(al3320a_pm_ops, al3320a_suspend,
 
 static const struct i2c_device_id al3320a_id[] = {
 	{ "al3320a" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, al3320a_id);
 
 static const struct of_device_id al3320a_of_match[] = {
 	{ .compatible = "dynaimage,al3320a", },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, al3320a_of_match);
 
 static const struct acpi_device_id al3320a_acpi_match[] = {
 	{"CALS0001"},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, al3320a_acpi_match);
 
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index d30441d3370309fce9d6c717d42b829ff1db3174..0003a29bf264e93ee4e0949f65ffaf31fed17ce7 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -1157,7 +1157,7 @@ static const struct dev_pm_ops apds9960_pm_ops = {
 
 static const struct i2c_device_id apds9960_id[] = {
 	{ "apds9960" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, apds9960_id);
 
diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index 475f44954f61106260d9de0939e59bb3c34ef65e..c7c877d2fe67f7391207c860e844bb8184d96bf8 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -264,7 +264,7 @@ MODULE_DEVICE_TABLE(i2c, bh1780_id);
 
 static const struct of_device_id of_bh1780_match[] = {
 	{ .compatible = "rohm,bh1780gli", },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, of_bh1780_match);
 
diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index 5b00ad2a014e9945d92b14ce5ea141ba6ac4e743..e864d2ef036e87b7a3ca286770594681eacd8e58 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -369,7 +369,7 @@ static void cm3232_remove(struct i2c_client *client)
 
 static const struct i2c_device_id cm3232_id[] = {
 	{ "cm3232" },
-	{}
+	{ }
 };
 
 static int cm3232_suspend(struct device *dev)
@@ -406,7 +406,7 @@ MODULE_DEVICE_TABLE(i2c, cm3232_id);
 
 static const struct of_device_id cm3232_of_match[] = {
 	{.compatible = "capella,cm3232"},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, cm3232_of_match);
 
diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 79a64e2ff812460a765112c2cd49ef17c6c1ac5c..79ad6e2209cab6350caf70e1f9b0ec45b97e92b3 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -251,13 +251,13 @@ static int cm3323_probe(struct i2c_client *client)
 
 static const struct i2c_device_id cm3323_id[] = {
 	{ "cm3323" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, cm3323_id);
 
 static const struct of_device_id cm3323_of_match[] = {
 	{ .compatible = "capella,cm3323", },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, cm3323_of_match);
 
diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
index 675c0fd44db45a7c32b98c21be61e1d5d4a0e081..0c17378e27d19e8a829cdcbebbbcf402278ffbab 100644
--- a/drivers/iio/light/cm3605.c
+++ b/drivers/iio/light/cm3605.c
@@ -307,7 +307,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(cm3605_dev_pm_ops, cm3605_pm_suspend,
 
 static const struct of_device_id cm3605_of_match[] = {
 	{.compatible = "capella,cm3605"},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, cm3605_of_match);
 
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index 19e529c84e957a13f02b2a15a9fc1333d5308cc7..815806ceb5c89dde841d4f9d551a02ece51c6c5d 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -249,7 +249,7 @@ static const struct platform_device_id cros_ec_light_prox_ids[] = {
 	{
 		.name = "cros-ec-light",
 	},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, cros_ec_light_prox_ids);
 
diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index d56ee217fe538c8babb5df510932bd6e67c59ea6..42859e5b1089daf97bbb793e43fc8844ca10301a 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -700,7 +700,7 @@ MODULE_DEVICE_TABLE(i2c, gp2ap002_id_table);
 static const struct of_device_id gp2ap002_of_match[] = {
 	{ .compatible = "sharp,gp2ap002a00f" },
 	{ .compatible = "sharp,gp2ap002s00f" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, gp2ap002_of_match);
 
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index aa4c72d4849e1339416688b9d167382b15e08210..830e5ae7f34a75bb1bc4b71debc68f83dc6d612d 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -456,7 +456,7 @@ static const struct platform_device_id hid_als_ids[] = {
 		/* Format: HID-SENSOR-custom_sensor_tag-usage_id_in_hex_lowercase */
 		.name = "HID-SENSOR-LISS-0041",
 	},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, hid_als_ids);
 
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 3a7b48803d50396923094f7709d834e1bac94bed..6143e45a1e7189f228bb41e124b74f62d66f1b1c 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -359,7 +359,7 @@ static const struct platform_device_id hid_prox_ids[] = {
 		/* Format: HID-SENSOR-tag-usage_id_in_hex_lowercase */
 		.name = "HID-SENSOR-LISS-0226",
 	},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, hid_prox_ids);
 
diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index 201eae1c45892b5941265593b0a76caffe8b0c77..1b4c184230489eb8b0de6c43751120d03dc31a06 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -824,7 +824,7 @@ static const struct acpi_device_id isl29018_acpi_match[] = {
 	{"ISL29018", isl29018},
 	{"ISL29023", isl29023},
 	{"ISL29035", isl29035},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, isl29018_acpi_match);
 
@@ -832,7 +832,7 @@ static const struct i2c_device_id isl29018_id[] = {
 	{"isl29018", isl29018},
 	{"isl29023", isl29023},
 	{"isl29035", isl29035},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, isl29018_id);
 
diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 95bfb3ffa519a10261320afd6065822a957c70f8..609ebf0f73134008f7fbfaa1b81a88f9faaa5d51 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -680,7 +680,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(isl29028_pm_ops, isl29028_suspend,
 static const struct i2c_device_id isl29028_id[] = {
 	{ "isl29028" },
 	{ "isl29030" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, isl29028_id);
 
@@ -688,7 +688,7 @@ static const struct of_device_id isl29028_of_match[] = {
 	{ .compatible = "isl,isl29028", }, /* for backward compat., don't use */
 	{ .compatible = "isil,isl29028", },
 	{ .compatible = "isil,isl29030", },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, isl29028_of_match);
 
diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
index e7ba934c8e693d2122bb77b7d862bf6763976329..fa4677c2893133a74f4b83225b945a647a91b0b1 100644
--- a/drivers/iio/light/jsa1212.c
+++ b/drivers/iio/light/jsa1212.c
@@ -424,7 +424,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(jsa1212_pm_ops, jsa1212_suspend,
 
 static const struct acpi_device_id jsa1212_acpi_match[] = {
 	{"JSA1212", 0},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, jsa1212_acpi_match);
 
diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index df664f36090301e21d6e2f92035198e15e018712..ee59bbb8aa09e9d8973bc92e002592dbe527114d 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -717,13 +717,13 @@ static DEFINE_SIMPLE_DEV_PM_OPS(ltr390_pm_ops, ltr390_suspend, ltr390_resume);
 
 static const struct i2c_device_id ltr390_id[] = {
 	{ "ltr390" },
-	{ /* Sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltr390_id);
 
 static const struct of_device_id ltr390_of_table[] = {
 	{ .compatible = "liteon,ltr390" },
-	{ /* Sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ltr390_of_table);
 
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 23fd0713c64b081ad79279adf0e82fca62b3120c..8d8051cf6927c65521171ddbd13871993ee4e6b4 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -541,7 +541,7 @@ static const struct iio_chan_spec_ext_info ltr501_ext_info[] = {
 		.shared = IIO_SEPARATE,
 		.read = ltr501_read_near_level,
 	},
-	{ /* sentinel */ }
+	{ }
 };
 
 static const struct iio_event_spec ltr501_als_event_spec[] = {
@@ -1602,7 +1602,7 @@ static const struct acpi_device_id ltr_acpi_match[] = {
 	{ "LTER0301", ltr301 },
 	/* https://www.catalog.update.microsoft.com/Search.aspx?q=lter0303 */
 	{ "LTER0303", ltr303 },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
 
@@ -1620,7 +1620,7 @@ static const struct of_device_id ltr501_of_match[] = {
 	{ .compatible = "liteon,ltr559", },
 	{ .compatible = "liteon,ltr301", },
 	{ .compatible = "liteon,ltr303", },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ltr501_of_match);
 
diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
index dbec1e7cfeb8636c1204f7b23103b7a8ad1a51ed..61f57a82b8727978a7a8ff6b6ff73a76f20da217 100644
--- a/drivers/iio/light/ltrf216a.c
+++ b/drivers/iio/light/ltrf216a.c
@@ -554,7 +554,7 @@ static const struct ltr_chip_info ltrf216a_chip_info = {
 static const struct i2c_device_id ltrf216a_id[] = {
 	{ "ltr308", .driver_data = (kernel_ulong_t)&ltr308_chip_info },
 	{ "ltrf216a", .driver_data = (kernel_ulong_t)&ltrf216a_chip_info },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
 
@@ -563,7 +563,7 @@ static const struct of_device_id ltrf216a_of_match[] = {
 	{ .compatible = "liteon,ltrf216a", .data = &ltrf216a_chip_info },
 	/* For Valve's Steamdeck device, an ACPI platform using PRP0001 */
 	{ .compatible = "ltr,ltrf216a", .data = &ltrf216a_chip_info },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ltrf216a_of_match);
 
diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index 6cf60151b3d8b5530e71908f629c89bc012becf0..ba4eb82d9bc259b240052efaa0d5442d7e4614c5 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -448,7 +448,7 @@ MODULE_DEVICE_TABLE(i2c, opt4001_id);
 static const struct of_device_id opt4001_of_match[] = {
 	{ .compatible = "ti,opt4001-sot-5x3", .data = &opt4001_sot_5x3_info},
 	{ .compatible = "ti,opt4001-picostar", .data = &opt4001_picostar_info},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, opt4001_of_match);
 
diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index b920bf82c102186ab7954133de28a5b35016eb11..8885852bef22d72262b1b715c9503e2adf2eb94e 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -456,14 +456,14 @@ static const struct dev_pm_ops pa12203001_pm_ops = {
 
 static const struct acpi_device_id pa12203001_acpi_match[] = {
 	{ "TXCPA122", 0 },
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(acpi, pa12203001_acpi_match);
 
 static const struct i2c_device_id pa12203001_id[] = {
 		{ "txcpa122" },
-		{}
+		{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, pa12203001_id);
diff --git a/drivers/iio/light/st_uvis25_i2c.c b/drivers/iio/light/st_uvis25_i2c.c
index f54282476d11d60db7b991c428cd5a2084ede2cb..5d9bb4d9be6316c5a81954a1787d93cd56bda645 100644
--- a/drivers/iio/light/st_uvis25_i2c.c
+++ b/drivers/iio/light/st_uvis25_i2c.c
@@ -41,13 +41,13 @@ static int st_uvis25_i2c_probe(struct i2c_client *client)
 
 static const struct of_device_id st_uvis25_i2c_of_match[] = {
 	{ .compatible = "st,uvis25", },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st_uvis25_i2c_of_match);
 
 static const struct i2c_device_id st_uvis25_i2c_id_table[] = {
 	{ ST_UVIS25_DEV_NAME },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, st_uvis25_i2c_id_table);
 
diff --git a/drivers/iio/light/st_uvis25_spi.c b/drivers/iio/light/st_uvis25_spi.c
index 18edc6a5a4a4fe98a62727e4ec02997abe13a756..a5aad74ce73e8ea7f759b0305f4113958ed27584 100644
--- a/drivers/iio/light/st_uvis25_spi.c
+++ b/drivers/iio/light/st_uvis25_spi.c
@@ -42,13 +42,13 @@ static int st_uvis25_spi_probe(struct spi_device *spi)
 
 static const struct of_device_id st_uvis25_spi_of_match[] = {
 	{ .compatible = "st,uvis25", },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st_uvis25_spi_of_match);
 
 static const struct spi_device_id st_uvis25_spi_id_table[] = {
 	{ ST_UVIS25_DEV_NAME },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, st_uvis25_spi_id_table);
 
diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index b81cc44db43c377ad8a8cc61c4430decb187181d..deada9ba47489eb723120d80931753adb8e26775 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -165,7 +165,7 @@ static const struct iio_chan_spec_ext_info stk3310_ext_info[] = {
 		.shared = IIO_SEPARATE,
 		.read = stk3310_read_near_level,
 	},
-	{ /* sentinel */ }
+	{ }
 };
 
 static const struct iio_chan_spec stk3310_channels[] = {
@@ -703,7 +703,7 @@ static const struct i2c_device_id stk3310_i2c_id[] = {
 	{ "STK3310" },
 	{ "STK3311" },
 	{ "STK3335" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
 
@@ -711,7 +711,7 @@ static const struct acpi_device_id stk3310_acpi_id[] = {
 	{"STK3013", 0},
 	{"STK3310", 0},
 	{"STK3311", 0},
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(acpi, stk3310_acpi_id);
@@ -721,7 +721,7 @@ static const struct of_device_id stk3310_of_match[] = {
 	{ .compatible = "sensortek,stk3310", },
 	{ .compatible = "sensortek,stk3311", },
 	{ .compatible = "sensortek,stk3335", },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stk3310_of_match);
 
diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index f1fe7640fce63bddad57fbe7809ee60bbfd44e1f..f2af1cd7c2d1ffb58b8b80a20540a35c3d621488 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -843,7 +843,7 @@ static const struct i2c_device_id tsl2563_id[] = {
 	{ "tsl2561", 1 },
 	{ "tsl2562", 2 },
 	{ "tsl2563", 3 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tsl2563_id);
 
@@ -852,7 +852,7 @@ static const struct of_device_id tsl2563_of_match[] = {
 	{ .compatible = "amstaos,tsl2561" },
 	{ .compatible = "amstaos,tsl2562" },
 	{ .compatible = "amstaos,tsl2563" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tsl2563_of_match);
 
diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index 02ad11611b9c576afa7e09515ed6fbeb8c4f0db2..fc3b0c4226be876f87115f1e36abaa8a92376a17 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -922,7 +922,7 @@ static const struct i2c_device_id tsl2583_idtable[] = {
 	{ "tsl2580", 0 },
 	{ "tsl2581", 1 },
 	{ "tsl2583", 2 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tsl2583_idtable);
 
@@ -930,7 +930,7 @@ static const struct of_device_id tsl2583_of_match[] = {
 	{ .compatible = "amstaos,tsl2580", },
 	{ .compatible = "amstaos,tsl2581", },
 	{ .compatible = "amstaos,tsl2583", },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tsl2583_of_match);
 
diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index b81ca6f73f92732dc66a9be35c9dbed5088e8da1..08476f193a443f7e513bf342157ff4dce9fc3460 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -1204,7 +1204,7 @@ static int tsl2591_probe(struct i2c_client *client)
 
 static const struct of_device_id tsl2591_of_match[] = {
 	{ .compatible = "amstaos,tsl2591"},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tsl2591_of_match);
 
diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index 349afdcbe30dd0c4c0fbabaa16ff7832e407e8ee..0b171106441ab61dca6bec57867678e36f3c83d7 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -1899,7 +1899,7 @@ static const struct i2c_device_id tsl2772_idtable[] = {
 	{ "tsl2772", tsl2772 },
 	{ "tmd2772", tmd2772 },
 	{ "apds9930", apds9930 },
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, tsl2772_idtable);
@@ -1916,7 +1916,7 @@ static const struct of_device_id tsl2772_of_match[] = {
 	{ .compatible = "amstaos,tsl2772" },
 	{ .compatible = "amstaos,tmd2772" },
 	{ .compatible = "avago,apds9930" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tsl2772_of_match);
 
diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index c83114aed6b23f1d68068105b7c145bedf005b36..61a0957317a1aa7fde67f5911de276efd55653f0 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -949,21 +949,21 @@ static const struct dev_pm_ops us5182d_pm_ops = {
 
 static const struct acpi_device_id us5182d_acpi_match[] = {
 	{ "USD5182", 0 },
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(acpi, us5182d_acpi_match);
 
 static const struct i2c_device_id us5182d_id[] = {
 	{ "usd5182" },
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, us5182d_id);
 
 static const struct of_device_id us5182d_of_match[] = {
 	{ .compatible = "upisemi,usd5182" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, us5182d_of_match);
 
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index d7489bee2dffaf400327da7aa1ef4d1a12657e09..90e7d4421abf20d1b2104c7932e9383e5d43229c 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1745,7 +1745,7 @@ static const struct iio_chan_spec_ext_info vcnl4000_ext_info[] = {
 		.shared = IIO_SEPARATE,
 		.read = vcnl4000_read_near_level,
 	},
-	{ /* sentinel */ }
+	{ }
 };
 
 static const struct iio_event_spec vcnl4000_event_spec[] = {
@@ -2068,7 +2068,7 @@ static const struct of_device_id vcnl_4000_of_match[] = {
 		.compatible = "vishay,vcnl4200",
 		.data = (void *)VCNL4200,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, vcnl_4000_of_match);
 
diff --git a/drivers/iio/light/veml6040.c b/drivers/iio/light/veml6040.c
index 216e271001a850072f2e93e9f133ec32de286f82..71a594b2ec8588046562417f2a84d7114efe71f1 100644
--- a/drivers/iio/light/veml6040.c
+++ b/drivers/iio/light/veml6040.c
@@ -256,13 +256,13 @@ static int veml6040_probe(struct i2c_client *client)
 
 static const struct i2c_device_id veml6040_id_table[] = {
 	{"veml6040"},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, veml6040_id_table);
 
 static const struct of_device_id veml6040_of_match[] = {
 	{.compatible = "vishay,veml6040"},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, veml6040_of_match);
 
diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
index 859891e8f115217819ce1d3ebbc50032745aa63a..edbb4340705435b77a49e4889fe20e58ca12b368 100644
--- a/drivers/iio/light/veml6075.c
+++ b/drivers/iio/light/veml6075.c
@@ -458,7 +458,7 @@ MODULE_DEVICE_TABLE(i2c, veml6075_id);
 
 static const struct of_device_id veml6075_of_match[] = {
 	{ .compatible = "vishay,veml6075" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, veml6075_of_match);
 
diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index 6e2183a4243e55b95840cf2e0f0069b3b6e11502..cc4f2e5404aadef42b749ae1734fd09a173f9cb5 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -745,7 +745,7 @@ static int vl6180_probe(struct i2c_client *client)
 
 static const struct of_device_id vl6180_of_match[] = {
 	{ .compatible = "st,vl6180", },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, vl6180_of_match);
 
diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index 44d8428a69b0543be08c418eaa9fc9189241e6a3..7cc4690b5cdd9b90a0a2a99eb28f5653a504cd0e 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -704,7 +704,7 @@ ak8974_get_mount_matrix(const struct iio_dev *indio_dev,
 
 static const struct iio_chan_spec_ext_info ak8974_ext_info[] = {
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, ak8974_get_mount_matrix),
-	{ },
+	{ }
 };
 
 #define AK8974_AXIS_CHANNEL(axis, index, bits)				\
@@ -1023,14 +1023,14 @@ static const struct i2c_device_id ak8974_id[] = {
 	{ "ami306" },
 	{ "ak8974" },
 	{ "hscdtd008a" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ak8974_id);
 
 static const struct of_device_id ak8974_of_match[] = {
 	{ .compatible = "asahi-kasei,ak8974", },
 	{ .compatible = "alps,hscdtd008a", },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ak8974_of_match);
 
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index ef1363126cc2d4ce2a1dc1ccb916c2ad069544d8..f8393576f463238e7a53d2505b229d7f0b9472fb 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -1107,7 +1107,7 @@ static const struct i2c_device_id ak8975_id[] = {
 	{"ak09912", (kernel_ulong_t)&ak_def_array[AK09912] },
 	{"ak09916", (kernel_ulong_t)&ak_def_array[AK09916] },
 	{"ak09918", (kernel_ulong_t)&ak_def_array[AK09918] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ak8975_id);
 
@@ -1122,7 +1122,7 @@ static const struct of_device_id ak8975_of_match[] = {
 	{ .compatible = "ak09912", .data = &ak_def_array[AK09912] },
 	{ .compatible = "asahi-kasei,ak09916", .data = &ak_def_array[AK09916] },
 	{ .compatible = "asahi-kasei,ak09918", .data = &ak_def_array[AK09918] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ak8975_of_match);
 
diff --git a/drivers/iio/magnetometer/als31300.c b/drivers/iio/magnetometer/als31300.c
index 87b60c4e81fa1c9d8d6e8b083c5bcb605baf8ee9..85eb1428a849408d6c155ba57fe22cb3b487527c 100644
--- a/drivers/iio/magnetometer/als31300.c
+++ b/drivers/iio/magnetometer/als31300.c
@@ -457,7 +457,7 @@ static const struct i2c_device_id als31300_id[] = {
 		.name = "als31300-2000",
 		.driver_data = (kernel_ulong_t)&al31300_variant_2000,
 	},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, als31300_id);
 
@@ -474,7 +474,7 @@ static const struct of_device_id als31300_of_match[] = {
 		.compatible = "allegromicro,als31300-2000",
 		.data = &al31300_variant_2000,
 	},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, als31300_of_match);
 
diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magnetometer/bmc150_magn_i2c.c
index 8cbeda924bdaa343f2a0507032d169a1010c70ea..b110791f688a71d883a77d830203a32b65d57bbe 100644
--- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
+++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
@@ -42,7 +42,7 @@ static const struct i2c_device_id bmc150_magn_i2c_id[] = {
 	{ "bmc150_magn" },
 	{ "bmc156_magn" },
 	{ "bmm150_magn" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bmc150_magn_i2c_id);
 
diff --git a/drivers/iio/magnetometer/bmc150_magn_spi.c b/drivers/iio/magnetometer/bmc150_magn_spi.c
index 2d4b8cba32f1428c6595de44b4e47eb29f60f026..896b1d2807311c57c41fabf68f9a2ec7aa9e0d2d 100644
--- a/drivers/iio/magnetometer/bmc150_magn_spi.c
+++ b/drivers/iio/magnetometer/bmc150_magn_spi.c
@@ -37,7 +37,7 @@ static const struct spi_device_id bmc150_magn_spi_id[] = {
 	{"bmc150_magn", 0},
 	{"bmc156_magn", 0},
 	{"bmm150_magn", 0},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, bmc150_magn_spi_id);
 
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 97ddaa2a03f698e1e2a53356eec3b2cbb496a5af..c673f9323e4762b5c0f150bf020d7c5add1d505c 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -563,7 +563,7 @@ static const struct platform_device_id hid_magn_3d_ids[] = {
 		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
 		.name = "HID-SENSOR-200083",
 	},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, hid_magn_3d_ids);
 
diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
index 657a309e2bd57898d7a15b0a01c1851281515842..b41709959e2b0665a8425efe9b4467e61c371fa0 100644
--- a/drivers/iio/magnetometer/hmc5843_i2c.c
+++ b/drivers/iio/magnetometer/hmc5843_i2c.c
@@ -84,7 +84,7 @@ static const struct of_device_id hmc5843_of_match[] = {
 	{ .compatible = "honeywell,hmc5883", .data = (void *)HMC5883_ID },
 	{ .compatible = "honeywell,hmc5883l", .data = (void *)HMC5883L_ID },
 	{ .compatible = "honeywell,hmc5983", .data = (void *)HMC5983_ID },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, hmc5843_of_match);
 
diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index dd480a4a5f98577242eb6d278758b8093638ccfe..e08a57cd6de264a4f1a3b8b070c7846144694bc7 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -556,13 +556,13 @@ MODULE_DEVICE_TABLE(of, mmc35240_of_match);
 
 static const struct acpi_device_id mmc35240_acpi_match[] = {
 	{"MMC35240", 0},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, mmc35240_acpi_match);
 
 static const struct i2c_device_id mmc35240_id[] = {
 	{ "mmc35240" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mmc35240_id);
 
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index 1672b274768d4d6e9d609c7494d82d89e5d4ebff..ed70e782af5ea78ec553d787ff6981eeb44bceea 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -54,7 +54,7 @@ static const struct of_device_id st_magn_of_match[] = {
 		.compatible = "st,lsm303c-magn",
 		.data = LSM303C_MAGN_DEV_NAME,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st_magn_of_match);
 
@@ -102,7 +102,7 @@ static const struct i2c_device_id st_magn_id_table[] = {
 	{ LSM9DS1_MAGN_DEV_NAME },
 	{ IIS2MDC_MAGN_DEV_NAME },
 	{ LSM303C_MAGN_DEV_NAME },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, st_magn_id_table);
 
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index fe4d0e63133c03c8fff68c37a23dce2ea2ad4e7b..68816362bb95276ad9beecd7ae1d54fed059108a 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -49,7 +49,7 @@ static const struct of_device_id st_magn_of_match[] = {
 		.compatible = "st,lsm303c-magn",
 		.data = LSM303C_MAGN_DEV_NAME,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st_magn_of_match);
 
@@ -94,7 +94,7 @@ static const struct spi_device_id st_magn_id_table[] = {
 	{ LSM9DS1_MAGN_DEV_NAME },
 	{ IIS2MDC_MAGN_DEV_NAME },
 	{ LSM303C_MAGN_DEV_NAME },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, st_magn_id_table);
 
diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
index 4187abe12784d532b6bfbe393f6b1c859c7255a5..2ca5c26f00917426dacb4835fc9684d0710d98c9 100644
--- a/drivers/iio/magnetometer/tmag5273.c
+++ b/drivers/iio/magnetometer/tmag5273.c
@@ -712,13 +712,13 @@ static DEFINE_RUNTIME_DEV_PM_OPS(tmag5273_pm_ops,
 
 static const struct i2c_device_id tmag5273_id[] = {
 	{ "tmag5273" },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tmag5273_id);
 
 static const struct of_device_id tmag5273_of_match[] = {
 	{ .compatible = "ti,tmag5273" },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tmag5273_of_match);
 
diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 28012b20c64fd19e5b31022fe4b23377de022798..46bc64e676b14a2794c69053b1cb82b0b5c44fe6 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -1585,7 +1585,7 @@ static const struct i2c_device_id yas5xx_id[] = {
 	{"yas532", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas532] },
 	{"yas533", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas533] },
 	{"yas537", (kernel_ulong_t)&yas5xx_chip_info_tbl[yas537] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, yas5xx_id);
 
@@ -1594,7 +1594,7 @@ static const struct of_device_id yas5xx_of_match[] = {
 	{ .compatible = "yamaha,yas532", &yas5xx_chip_info_tbl[yas532] },
 	{ .compatible = "yamaha,yas533", &yas5xx_chip_info_tbl[yas533] },
 	{ .compatible = "yamaha,yas537", &yas5xx_chip_info_tbl[yas537] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, yas5xx_of_match);
 
diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index c309d991490c63ba4299f1cda7102f10dcf54982..b742ca9a99d122d7bfdab74967e205da5b05d1ed 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -448,7 +448,7 @@ static int mux_probe(struct platform_device *pdev)
 
 static const struct of_device_id mux_match[] = {
 	{ .compatible = "io-channel-mux" },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mux_match);
 
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 429035b65c657acf5558ed10d289f56512fe2d28..4e23a598a3fb956ab893354507e5fab9385bd371 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -399,7 +399,7 @@ static const struct platform_device_id hid_incl_3d_ids[] = {
 		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
 		.name = "HID-SENSOR-200086",
 	},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, hid_incl_3d_ids);
 
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 96f03988640c3148e7e66abd0ffe786f9b5b3b61..c4b18fd0fa76c17318b262ea9f44ea5c40170298 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -351,7 +351,7 @@ static const struct platform_device_id hid_dev_rot_ids[] = {
 		/* Geomagnetic orientation(AM) sensor */
 		.name = "HID-SENSOR-2000c1",
 	},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, hid_dev_rot_ids);
 
diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index 423bbb8a3b38f27fbc3a8c843504c8381c94a6d6..bff7039690ac33bcc9747add8055023dd5a1f3ab 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -358,7 +358,7 @@ static const struct platform_device_id hid_hinge_ids[] = {
 		/* Format: HID-SENSOR-INT-usage_id_in_hex_lowercase */
 		.name = "HID-SENSOR-INT-020b",
 	},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, hid_hinge_ids);
 
diff --git a/drivers/iio/potentiometer/ad5272.c b/drivers/iio/potentiometer/ad5272.c
index b17941e4c2f7c543e64e4eedde642520e0d3e405..672b1ca3a920c517016142ebab15ed2978502990 100644
--- a/drivers/iio/potentiometer/ad5272.c
+++ b/drivers/iio/potentiometer/ad5272.c
@@ -199,7 +199,7 @@ static const struct of_device_id ad5272_dt_ids[] = {
 	{ .compatible = "adi,ad5272-100", .data = (void *)AD5272_100 },
 	{ .compatible = "adi,ad5274-020", .data = (void *)AD5274_020 },
 	{ .compatible = "adi,ad5274-100", .data = (void *)AD5274_100 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad5272_dt_ids);
 
@@ -209,7 +209,7 @@ static const struct i2c_device_id ad5272_id[] = {
 	{ "ad5272-100", AD5272_100 },
 	{ "ad5274-020", AD5274_020 },
 	{ "ad5274-100", AD5274_100 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad5272_id);
 
diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
index e0526dd0e3cbb02243f271a4ee3ddec2a043776e..5761f69c538ab32f37734fab7dfeb970a7163187 100644
--- a/drivers/iio/potentiometer/ds1803.c
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -231,7 +231,7 @@ static const struct of_device_id ds1803_dt_ids[] = {
 	{ .compatible = "maxim,ds1803-050", .data = &ds1803_cfg[DS1803_050] },
 	{ .compatible = "maxim,ds1803-100", .data = &ds1803_cfg[DS1803_100] },
 	{ .compatible = "maxim,ds3502", .data = &ds1803_cfg[DS3502] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ds1803_dt_ids);
 
@@ -240,7 +240,7 @@ static const struct i2c_device_id ds1803_id[] = {
 	{ "ds1803-050", (kernel_ulong_t)&ds1803_cfg[DS1803_050] },
 	{ "ds1803-100", (kernel_ulong_t)&ds1803_cfg[DS1803_100] },
 	{ "ds3502", (kernel_ulong_t)&ds1803_cfg[DS3502] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ds1803_id);
 
diff --git a/drivers/iio/potentiometer/max5432.c b/drivers/iio/potentiometer/max5432.c
index c8e2481dadb5330fed5ba0eaa5d29121296c4cc2..26390be79d029db0cc057f342de8c090f1f80e53 100644
--- a/drivers/iio/potentiometer/max5432.c
+++ b/drivers/iio/potentiometer/max5432.c
@@ -114,7 +114,7 @@ static const struct of_device_id max5432_dt_ids[] = {
 	{ .compatible = "maxim,max5433", .data = (void *)MAX5432_OHM_100K },
 	{ .compatible = "maxim,max5434", .data = (void *)MAX5432_OHM_50K  },
 	{ .compatible = "maxim,max5435", .data = (void *)MAX5432_OHM_100K },
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, max5432_dt_ids);
 
diff --git a/drivers/iio/potentiometer/max5487.c b/drivers/iio/potentiometer/max5487.c
index 4838d2e72f53def3b388cba135cf62835a6dc89d..3b11b991940b491ac32d0203c3cd98cd516ab871 100644
--- a/drivers/iio/potentiometer/max5487.c
+++ b/drivers/iio/potentiometer/max5487.c
@@ -137,7 +137,7 @@ static const struct acpi_device_id max5487_acpi_match[] = {
 	{ "MAX5487", 10 },
 	{ "MAX5488", 50 },
 	{ "MAX5489", 100 },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, max5487_acpi_match);
 
diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
index 44678d37212616eaa331cf260ed93d7475defb6a..a88bb2231850d81b3630dd36b51ffde06fd50038 100644
--- a/drivers/iio/potentiometer/mcp4018.c
+++ b/drivers/iio/potentiometer/mcp4018.c
@@ -117,7 +117,7 @@ static const struct i2c_device_id mcp4018_id[] = {
 	MCP4018_ID_TABLE("mcp4019-103", MCP4018_103),
 	MCP4018_ID_TABLE("mcp4019-503", MCP4018_503),
 	MCP4018_ID_TABLE("mcp4019-104", MCP4018_104),
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp4018_id);
 
@@ -139,7 +139,7 @@ static const struct of_device_id mcp4018_of_match[] = {
 	MCP4018_COMPATIBLE("microchip,mcp4019-103", MCP4018_103),
 	MCP4018_COMPATIBLE("microchip,mcp4019-503", MCP4018_503),
 	MCP4018_COMPATIBLE("microchip,mcp4019-104", MCP4018_104),
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp4018_of_match);
 
diff --git a/drivers/iio/potentiometer/mcp41010.c b/drivers/iio/potentiometer/mcp41010.c
index 2b73c75402094ba0e3ba18ff6a5ac94b8c507cef..f35fc4a6c55bd92fc54f617126c5c5b6c9245307 100644
--- a/drivers/iio/potentiometer/mcp41010.c
+++ b/drivers/iio/potentiometer/mcp41010.c
@@ -171,7 +171,7 @@ static const struct of_device_id mcp41010_match[] = {
 	{ .compatible = "microchip,mcp42010", .data = &mcp41010_cfg[MCP42010] },
 	{ .compatible = "microchip,mcp42050", .data = &mcp41010_cfg[MCP42050] },
 	{ .compatible = "microchip,mcp42100", .data = &mcp41010_cfg[MCP42100] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp41010_match);
 
@@ -182,7 +182,7 @@ static const struct spi_device_id mcp41010_id[] = {
 	{ "mcp42010", MCP42010 },
 	{ "mcp42050", MCP42050 },
 	{ "mcp42100", MCP42100 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, mcp41010_id);
 
diff --git a/drivers/iio/potentiometer/mcp4131.c b/drivers/iio/potentiometer/mcp4131.c
index 7890c0993ec48e72efba206034451fcc65fb573e..9082b559d02960cc023aa292a2176ea3da0d5d5e 100644
--- a/drivers/iio/potentiometer/mcp4131.c
+++ b/drivers/iio/potentiometer/mcp4131.c
@@ -403,7 +403,7 @@ static const struct of_device_id mcp4131_dt_ids[] = {
 		.data = &mcp4131_cfg[MCP426x_503] },
 	{ .compatible = "microchip,mcp4262-104",
 		.data = &mcp4131_cfg[MCP426x_104] },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp4131_dt_ids);
 
@@ -472,7 +472,7 @@ static const struct spi_device_id mcp4131_id[] = {
 	{ "mcp4262-103", MCP426x_103 },
 	{ "mcp4262-503", MCP426x_503 },
 	{ "mcp4262-104", MCP426x_104 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, mcp4131_id);
 
diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
index f28880ebd7588e5d889bf91ebc0d44a5c311ec76..9912e91ff7b4c176fe0694c16f10e36d51f85ba0 100644
--- a/drivers/iio/potentiometer/mcp4531.c
+++ b/drivers/iio/potentiometer/mcp4531.c
@@ -276,7 +276,7 @@ static const struct i2c_device_id mcp4531_id[] = {
 	MCP4531_ID_TABLE("mcp4662-103", MCP466x_103),
 	MCP4531_ID_TABLE("mcp4662-503", MCP466x_503),
 	MCP4531_ID_TABLE("mcp4662-104", MCP466x_104),
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp4531_id);
 
@@ -350,7 +350,7 @@ static const struct of_device_id mcp4531_of_match[] = {
 	MCP4531_COMPATIBLE("microchip,mcp4662-103", MCP466x_103),
 	MCP4531_COMPATIBLE("microchip,mcp4662-503", MCP466x_503),
 	MCP4531_COMPATIBLE("microchip,mcp4662-104", MCP466x_104),
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp4531_of_match);
 
diff --git a/drivers/iio/potentiometer/tpl0102.c b/drivers/iio/potentiometer/tpl0102.c
index 8923ccb0fc4f793c64e01c5b6c2143255e27ab5c..a42b5773336388d2e56b86d828faeb2948ecb22f 100644
--- a/drivers/iio/potentiometer/tpl0102.c
+++ b/drivers/iio/potentiometer/tpl0102.c
@@ -153,7 +153,7 @@ static const struct i2c_device_id tpl0102_id[] = {
 	{ "cat5140-104", CAT5140_104 },
 	{ "tpl0102-104", TPL0102_104 },
 	{ "tpl0401-103", TPL0401_103 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tpl0102_id);
 
diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index c2c6b2b298675bbae7fda6cf8b4b99b43d0b1f8d..030498d0b7638081ea865d01a6398b608f2f143d 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -400,14 +400,14 @@ static void lmp91000_remove(struct i2c_client *client)
 static const struct of_device_id lmp91000_of_match[] = {
 	{ .compatible = "ti,lmp91000", },
 	{ .compatible = "ti,lmp91002", },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, lmp91000_of_match);
 
 static const struct i2c_device_id lmp91000_id[] = {
 	{ "lmp91000" },
 	{ "lmp91002" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lmp91000_id);
 
diff --git a/drivers/iio/pressure/abp060mg.c b/drivers/iio/pressure/abp060mg.c
index 752a63c06b44c11c1d935732d00ffac41e5ff591..a0d956c3e2543f353ff0c157e01312645653573a 100644
--- a/drivers/iio/pressure/abp060mg.c
+++ b/drivers/iio/pressure/abp060mg.c
@@ -247,7 +247,7 @@ static const struct i2c_device_id abp060mg_id_table[] = {
 	{ "abp015pd", ABP015PD },
 	{ "abp030pd", ABP030PD },
 	{ "abp060pd", ABP060PD },
-	{ /* empty */ },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, abp060mg_id_table);
 
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 868e1b2ec7112add5ec892f8be19e1b148985438..8e459b6c97ff7632be880d4ceb117b251c9cc19c 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -33,7 +33,7 @@ static const struct of_device_id bmp280_of_i2c_match[] = {
 	{ .compatible = "bosch,bme280", .data = &bme280_chip_info },
 	{ .compatible = "bosch,bmp380", .data = &bmp380_chip_info },
 	{ .compatible = "bosch,bmp580", .data = &bmp580_chip_info },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, bmp280_of_i2c_match);
 
@@ -44,7 +44,7 @@ static const struct i2c_device_id bmp280_i2c_id[] = {
 	{"bme280", (kernel_ulong_t)&bme280_chip_info },
 	{"bmp380", (kernel_ulong_t)&bmp380_chip_info },
 	{"bmp580", (kernel_ulong_t)&bmp580_chip_info },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bmp280_i2c_id);
 
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 0e6e27892f99a89380728a0f0f86b9b6b192b343..c4fded3398da53e60d4bc775dba351e31688755f 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -121,7 +121,7 @@ static const struct of_device_id bmp280_of_spi_match[] = {
 	{ .compatible = "bosch,bme280", .data = &bme280_chip_info },
 	{ .compatible = "bosch,bmp380", .data = &bmp380_chip_info },
 	{ .compatible = "bosch,bmp580", .data = &bmp580_chip_info },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, bmp280_of_spi_match);
 
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 2649c2f89e8982320dfa7bfb6340b3809fdeec24..c6b950c596c1b7a4879b2ca96185dd9259c3d2e3 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -192,7 +192,7 @@ static const struct platform_device_id cros_ec_baro_ids[] = {
 	{
 		.name = "cros-ec-baro",
 	},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, cros_ec_baro_ids);
 
diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index e0aa12949cde298422ec481f153d46a2a98c19e0..48afe5c94000b44eb324d7631f3c0db8e3d0079e 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -343,14 +343,14 @@ static int dlh_probe(struct i2c_client *client)
 static const struct of_device_id dlh_of_match[] = {
 	{ .compatible = "asc,dlhl60d" },
 	{ .compatible = "asc,dlhl60g" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dlh_of_match);
 
 static const struct i2c_device_id dlh_id[] = {
 	{ "dlhl60d",    dlhl60d },
 	{ "dlhl60g",    dlhl60g },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, dlh_id);
 
diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index c6f44f0f4d2e630892e44993225484b1ebe68caa..8edaa4d10a70ec01efadbaad616525a81745fe43 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -888,13 +888,13 @@ static int dps310_probe(struct i2c_client *client)
 
 static const struct i2c_device_id dps310_id[] = {
 	{ DPS310_DEV_NAME },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, dps310_id);
 
 static const struct acpi_device_id dps310_acpi_match[] = {
 	{ "IFX3100" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, dps310_acpi_match);
 
diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index f7273d30c5f085dda08aaea521631a777dec860a..bffeddff5e91b89e8d4495beb63e2f1191c76aca 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -339,7 +339,7 @@ static const struct platform_device_id hid_press_ids[] = {
 		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
 		.name = "HID-SENSOR-200031",
 	},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, hid_press_ids);
 
diff --git a/drivers/iio/pressure/hp03.c b/drivers/iio/pressure/hp03.c
index 6f7a16787143ce0896b2b1d07eb73e96768dbd89..cbb4aaf45e2cd208befbb42c988a0f9819fa532b 100644
--- a/drivers/iio/pressure/hp03.c
+++ b/drivers/iio/pressure/hp03.c
@@ -273,7 +273,7 @@ MODULE_DEVICE_TABLE(i2c, hp03_id);
 
 static const struct of_device_id hp03_of_match[] = {
 	{ .compatible = "hoperf,hp03" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, hp03_of_match);
 
diff --git a/drivers/iio/pressure/hp206c.c b/drivers/iio/pressure/hp206c.c
index 44274094193379bdad8647d79aaf7e599484bca0..abe10ccb677061ff482a67fb61720bffc1afec7f 100644
--- a/drivers/iio/pressure/hp206c.c
+++ b/drivers/iio/pressure/hp206c.c
@@ -396,13 +396,13 @@ static int hp206c_probe(struct i2c_client *client)
 
 static const struct i2c_device_id hp206c_id[] = {
 	{"hp206c"},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, hp206c_id);
 
 static const struct acpi_device_id hp206c_acpi_match[] = {
 	{"HOP206C", 0},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, hp206c_acpi_match);
 
diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/hsc030pa_i2c.c
index 7f2398aa815525951818b9f0bab3cc3f442c60ef..a34ef4653f342a3265b3a88d0f7291586a89a0ec 100644
--- a/drivers/iio/pressure/hsc030pa_i2c.c
+++ b/drivers/iio/pressure/hsc030pa_i2c.c
@@ -48,13 +48,13 @@ static int hsc_i2c_probe(struct i2c_client *client)
 
 static const struct of_device_id hsc_i2c_match[] = {
 	{ .compatible = "honeywell,hsc030pa" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, hsc_i2c_match);
 
 static const struct i2c_device_id hsc_i2c_id[] = {
 	{ "hsc030pa" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, hsc_i2c_id);
 
diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressure/hsc030pa_spi.c
index 60768726e9ad82aac86773a5433f5126a64f06c9..5d331b3b6da8eeb2cde2f9d006633b40206532e5 100644
--- a/drivers/iio/pressure/hsc030pa_spi.c
+++ b/drivers/iio/pressure/hsc030pa_spi.c
@@ -35,13 +35,13 @@ static int hsc_spi_probe(struct spi_device *spi)
 
 static const struct of_device_id hsc_spi_match[] = {
 	{ .compatible = "honeywell,hsc030pa" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, hsc_spi_match);
 
 static const struct spi_device_id hsc_spi_id[] = {
 	{ "hsc030pa" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, hsc_spi_id);
 
diff --git a/drivers/iio/pressure/mpl115_spi.c b/drivers/iio/pressure/mpl115_spi.c
index 888cfa6662381e5b8d59d628fb2158bb2504052b..4e1d24beff94987964332ad2b3c543b0b3b8b7bc 100644
--- a/drivers/iio/pressure/mpl115_spi.c
+++ b/drivers/iio/pressure/mpl115_spi.c
@@ -85,7 +85,7 @@ static int mpl115_spi_probe(struct spi_device *spi)
 
 static const struct spi_device_id mpl115_spi_ids[] = {
 	{ "mpl115", 0 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, mpl115_spi_ids);
 
diff --git a/drivers/iio/pressure/mprls0025pa_i2c.c b/drivers/iio/pressure/mprls0025pa_i2c.c
index 48b23a4256ced00f02d41853e6c0eb976124be8c..1a48f8d43d716b28b8fceb8e1a06d63a73a74a86 100644
--- a/drivers/iio/pressure/mprls0025pa_i2c.c
+++ b/drivers/iio/pressure/mprls0025pa_i2c.c
@@ -74,13 +74,13 @@ static int mpr_i2c_probe(struct i2c_client *client)
 
 static const struct of_device_id mpr_i2c_match[] = {
 	{ .compatible = "honeywell,mprls0025pa" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mpr_i2c_match);
 
 static const struct i2c_device_id mpr_i2c_id[] = {
 	{ "mprls0025pa" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mpr_i2c_id);
 
diff --git a/drivers/iio/pressure/mprls0025pa_spi.c b/drivers/iio/pressure/mprls0025pa_spi.c
index 09f724c76d706e3167e0e7e34333cafac6bbd978..d04102f8a4a03567f14839eb8c505373f7c25071 100644
--- a/drivers/iio/pressure/mprls0025pa_spi.c
+++ b/drivers/iio/pressure/mprls0025pa_spi.c
@@ -66,13 +66,13 @@ static int mpr_spi_probe(struct spi_device *spi)
 
 static const struct of_device_id mpr_spi_match[] = {
 	{ .compatible = "honeywell,mprls0025pa" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mpr_spi_match);
 
 static const struct spi_device_id mpr_spi_id[] = {
 	{ "mprls0025pa" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, mpr_spi_id);
 
diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index a1767a17fdce9174878e21f07001098d676937ba..59705a6669798ee5d711cfdd5dffc17317f2789f 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -219,7 +219,7 @@ static const struct i2c_device_id ms5637_id[] = {
 	{"ms5805", (kernel_ulong_t)&ms5805_data },
 	{"ms5837", (kernel_ulong_t)&ms5837_data },
 	{"ms8607-temppressure", (kernel_ulong_t)&ms8607_data },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ms5637_id);
 
@@ -229,7 +229,7 @@ static const struct of_device_id ms5637_of_match[] = {
 	{ .compatible = "meas,ms5805", .data = &ms5805_data },
 	{ .compatible = "meas,ms5837", .data = &ms5837_data },
 	{ .compatible = "meas,ms8607-temppressure", .data = &ms8607_data },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ms5637_of_match);
 
diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
index c48231739f487982e4b2b5f2ab9c58e989885767..c651ead080df69f88466d0a2c7d0d56acde3cdae 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -882,13 +882,13 @@ static int bm1390_probe(struct i2c_client *i2c)
 
 static const struct of_device_id bm1390_of_match[] = {
 	{ .compatible = "rohm,bm1390glv-z" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, bm1390_of_match);
 
 static const struct i2c_device_id bm1390_id[] = {
 	{ "bm1390glv-z", },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bm1390_id);
 
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index b7b66ddc3a7307bda2ee35503c35592de63b29bb..0f50bac1fb4d284247b7f026928cb5df783c0c3a 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -50,13 +50,13 @@ static const struct of_device_id st_press_of_match[] = {
 		.compatible = "st,lps22df",
 		.data = LPS22DF_PRESS_DEV_NAME,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st_press_of_match);
 
 static const struct acpi_device_id st_press_acpi_match[] = {
 	{"SNO9210", LPS22HB},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, st_press_acpi_match);
 
@@ -69,7 +69,7 @@ static const struct i2c_device_id st_press_id_table[] = {
 	{ LPS35HW_PRESS_DEV_NAME, LPS35HW },
 	{ LPS22HH_PRESS_DEV_NAME, LPS22HH },
 	{ LPS22DF_PRESS_DEV_NAME, LPS22DF },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, st_press_id_table);
 
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 1a4bd1a0f78745505cca1c12bf242d80c9770afa..39827e6841ca731aa4c709f1b7f07d6b1092ef91 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -55,7 +55,7 @@ static const struct of_device_id st_press_of_match[] = {
 		.compatible = "st,lps22df",
 		.data = LPS22DF_PRESS_DEV_NAME,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st_press_of_match);
 
@@ -106,7 +106,7 @@ static const struct spi_device_id st_press_id_table[] = {
 	{ "lps25h-press", },
 	{ "lps331ap-press" },
 	{ "lps22hb-press" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, st_press_id_table);
 
diff --git a/drivers/iio/pressure/zpa2326_spi.c b/drivers/iio/pressure/zpa2326_spi.c
index c678f5b96266f37c69fac4af01d4fc58654cf119..8a695b065a5fa40caee128b7eb8afe8485e72659 100644
--- a/drivers/iio/pressure/zpa2326_spi.c
+++ b/drivers/iio/pressure/zpa2326_spi.c
@@ -63,7 +63,7 @@ static void zpa2326_remove_spi(struct spi_device *spi)
 
 static const struct spi_device_id zpa2326_spi_ids[] = {
 	{ "zpa2326", 0 },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, zpa2326_spi_ids);
 
diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index 9d3caf2bef18d9bab32443e6ed12582f925ef64d..d48d7b57287829f67950fc3551f6c8e410eff56a 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -444,13 +444,13 @@ static int as3935_probe(struct spi_device *spi)
 
 static const struct of_device_id as3935_of_match[] = {
 	{ .compatible = "ams,as3935", },
-	{ /* sentinel */ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, as3935_of_match);
 
 static const struct spi_device_id as3935_id[] = {
 	{"as3935", 0},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, as3935_id);
 
diff --git a/drivers/iio/proximity/cros_ec_mkbp_proximity.c b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
index d2ddb7d45ec251d12bac5243671b0af1e3fc64be..1f9de7066ebf5704d2a57726e7baad166196f446 100644
--- a/drivers/iio/proximity/cros_ec_mkbp_proximity.c
+++ b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
@@ -245,7 +245,7 @@ static void cros_ec_mkbp_proximity_remove(struct platform_device *pdev)
 
 static const struct of_device_id cros_ec_mkbp_proximity_of_match[] = {
 	{ .compatible = "google,cros-ec-mkbp-proximity" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, cros_ec_mkbp_proximity_of_match);
 
diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 5be5f4986347502cb8cfc78f1c34914f80997c63..f2037fd99a8d886f6bd780863c8236a919746f7e 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1190,13 +1190,13 @@ static DEFINE_SIMPLE_DEV_PM_OPS(hx9023s_pm_ops, hx9023s_suspend,
 
 static const struct of_device_id hx9023s_of_match[] = {
 	{ .compatible = "tyhx,hx9023s" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, hx9023s_of_match);
 
 static const struct i2c_device_id hx9023s_id[] = {
 	{ "hx9023s" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, hx9023s_id);
 
diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
index b0ffd357401360c10b7e0fc2c3577bf0473b1582..1b1b6dfdfa78aa068cb83976f51e86e305c41d95 100644
--- a/drivers/iio/proximity/irsd200.c
+++ b/drivers/iio/proximity/irsd200.c
@@ -941,7 +941,7 @@ static const struct of_device_id irsd200_of_match[] = {
 	{
 		.compatible = "murata,irsd200",
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, irsd200_of_match);
 
diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index dc66ca9bba6b4676bebaa7f6a7582d9667cfc70a..d1510fe2405088adc0998e28aa9f36e0186fafae 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -481,7 +481,7 @@ static const struct iio_chan_spec_ext_info isl29501_ext_info[] = {
 	_ISL29501_EXT_INFO("calib_phase_temp_b", REG_CALIB_PHASE_TEMP_B),
 	_ISL29501_EXT_INFO("calib_phase_light_a", REG_CALIB_PHASE_LIGHT_A),
 	_ISL29501_EXT_INFO("calib_phase_light_b", REG_CALIB_PHASE_LIGHT_B),
-	{ },
+	{ }
 };
 
 #define ISL29501_DISTANCE_SCAN_INDEX 0
@@ -990,7 +990,7 @@ static int isl29501_probe(struct i2c_client *client)
 
 static const struct i2c_device_id isl29501_id[] = {
 	{ "isl29501" },
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, isl29501_id);
diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
index cfc75d001f20e3186829ca5d0bcce462a5e1257d..24524edae0b4adf9ef0f060605b922eb5e9097a0 100644
--- a/drivers/iio/proximity/mb1232.c
+++ b/drivers/iio/proximity/mb1232.c
@@ -239,7 +239,7 @@ static const struct of_device_id of_mb1232_match[] = {
 	{ .compatible = "maxbotix,mb1242", },
 	{ .compatible = "maxbotix,mb7040", },
 	{ .compatible = "maxbotix,mb7137", },
-	{},
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, of_mb1232_match);
diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
index 2ad69b1509020f32affbf20a7ce4ac1a3f274b17..c5b4e1378b7d1b40db0c851af461fbef2e19e786 100644
--- a/drivers/iio/proximity/ping.c
+++ b/drivers/iio/proximity/ping.c
@@ -268,7 +268,7 @@ static const struct iio_chan_spec ping_chan_spec[] = {
 static const struct of_device_id of_ping_match[] = {
 	{ .compatible = "parallax,ping", .data = &pa_ping_cfg },
 	{ .compatible = "parallax,laserping", .data = &pa_laser_ping_cfg },
-	{},
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, of_ping_match);
diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index 71ad29e441b23773afb18724df53769eea1d1733..b059bac1078bd09211fbee7bbd5ff7f3cb47e153 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -240,7 +240,7 @@ static const struct of_device_id of_srf04_match[] = {
 	{ .compatible = "maxbotix,mb1020", .data = &mb_lv_cfg },
 	{ .compatible = "maxbotix,mb1030", .data = &mb_lv_cfg },
 	{ .compatible = "maxbotix,mb1040", .data = &mb_lv_cfg },
-	{},
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, of_srf04_match);
diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index 86cab113ef3da5c123a4e04c2089ad81f580edb1..940fad6aeaa4b4d714e2cc3c44ba0e1216633397 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -531,7 +531,7 @@ static const struct of_device_id of_srf08_match[] = {
 	{ .compatible = "devantech,srf02", (void *)SRF02 },
 	{ .compatible = "devantech,srf08", (void *)SRF08 },
 	{ .compatible = "devantech,srf10", (void *)SRF10 },
-	{},
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, of_srf08_match);
diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index b60707eba39d05d3ad44dc9789d658ea68379f9d..fb02eac78ed4eb51dc545d4920ca7c08c681dc4c 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -995,21 +995,21 @@ static const struct sx931x_info sx9311_info = {
 static const struct acpi_device_id sx9310_acpi_match[] = {
 	{ "STH9310", (kernel_ulong_t)&sx9310_info },
 	{ "STH9311", (kernel_ulong_t)&sx9311_info },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, sx9310_acpi_match);
 
 static const struct of_device_id sx9310_of_match[] = {
 	{ .compatible = "semtech,sx9310", &sx9310_info },
 	{ .compatible = "semtech,sx9311", &sx9311_info },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, sx9310_of_match);
 
 static const struct i2c_device_id sx9310_id[] = {
 	{ "sx9310", (kernel_ulong_t)&sx9310_info },
 	{ "sx9311", (kernel_ulong_t)&sx9311_info },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sx9310_id);
 
diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 73d972416c01856dd219300b9165e9c60e25dffb..c7b2d03c23bced8539f0014c48e9ce6c426a2b96 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -202,7 +202,7 @@ static const struct iio_chan_spec_ext_info sx9324_channel_ext_info[] = {
 		.shared = IIO_SEPARATE,
 		.read = sx9324_phase_configuration_show,
 	},
-	{}
+	{ }
 };
 
 #define SX9324_CHANNEL(idx)					 \
diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index b5e2855975ee5fa8f4b4e2927f525da0aafeac95..8913da59dc731b0ecef4594ba8674766fde491ca 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -865,7 +865,7 @@ static const struct acpi_gpio_mapping acpi_sx9500_gpios[] = {
 	 * GPIO to be output only. Ask the GPIO core to ignore this limit.
 	 */
 	{ "interrupt-gpios", &interrupt_gpios, 1, ACPI_GPIO_QUIRK_NO_IO_RESTRICTION },
-	{ },
+	{ }
 };
 
 static void sx9500_gpio_probe(struct i2c_client *client,
@@ -1030,7 +1030,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(sx9500_pm_ops, sx9500_suspend, sx9500_resume);
 static const struct acpi_device_id sx9500_acpi_match[] = {
 	{"SSX9500", 0},
 	{"SASX9500", 0},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, sx9500_acpi_match);
 
diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index bb6c9cc88b358de098543df8a0da7d22914c5e47..31e77d9e0c90e503e5e337f1ae7f17587624a785 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -653,7 +653,7 @@ static const struct of_device_id vcnl3020_of_match[] = {
 	{
 		.compatible = "vishay,vcnl3020",
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, vcnl3020_of_match);
 
diff --git a/drivers/iio/resolver/ad2s1200.c b/drivers/iio/resolver/ad2s1200.c
index 9d95241bdf8f2a82cdd94e8fb18b650c8c318ef8..0bc84f12cb341a4c1a30fd2211f46565f8466cc6 100644
--- a/drivers/iio/resolver/ad2s1200.c
+++ b/drivers/iio/resolver/ad2s1200.c
@@ -186,7 +186,7 @@ MODULE_DEVICE_TABLE(of, ad2s1200_of_match);
 static const struct spi_device_id ad2s1200_id[] = {
 	{ "ad2s1200" },
 	{ "ad2s1205" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad2s1200_id);
 
diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2s1210.c
index ab860cedecd14d5f085de38257406348cf93f2bc..80a2f7ebda8f3a4b87ff0fb96a65609933d535b2 100644
--- a/drivers/iio/resolver/ad2s1210.c
+++ b/drivers/iio/resolver/ad2s1210.c
@@ -1597,7 +1597,7 @@ MODULE_DEVICE_TABLE(of, ad2s1210_of_match);
 
 static const struct spi_device_id ad2s1210_id[] = {
 	{ "ad2s1210" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad2s1210_id);
 
diff --git a/drivers/iio/resolver/ad2s90.c b/drivers/iio/resolver/ad2s90.c
index be6836e55376f4c91b46973bd397ef04d6a1a9ac..18f1c905eeacfb75cd6a3a5ee83d641403a5a7de 100644
--- a/drivers/iio/resolver/ad2s90.c
+++ b/drivers/iio/resolver/ad2s90.c
@@ -105,13 +105,13 @@ static int ad2s90_probe(struct spi_device *spi)
 
 static const struct of_device_id ad2s90_of_match[] = {
 	{ .compatible = "adi,ad2s90", },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ad2s90_of_match);
 
 static const struct spi_device_id ad2s90_id[] = {
 	{ "ad2s90" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad2s90_id);
 
diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 692520e1c497bbeda538e217b6a09f43ee26aadc..09f470bb084169be769b9fe30c2df1effddb5ce3 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -272,7 +272,7 @@ static const struct platform_device_id hid_temperature_ids[] = {
 		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
 		.name = "HID-SENSOR-200033",
 	},
-	{ /* sentinel */ }
+	{ }
 };
 MODULE_DEVICE_TABLE(platform, hid_temperature_ids);
 
diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index f8ea2219ab48b31c18d2ff22dcf103fb4d114f09..7dd40d69cce68a6293a42de389153f459b396ae3 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -1664,7 +1664,7 @@ static const struct spi_device_id ltc2983_id_table[] = {
 	{ "ltc2984", (kernel_ulong_t)&ltc2984_chip_info_data },
 	{ "ltc2986", (kernel_ulong_t)&ltc2986_chip_info_data },
 	{ "ltm2985", (kernel_ulong_t)&ltm2985_chip_info_data },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ltc2983_id_table);
 
@@ -1673,7 +1673,7 @@ static const struct of_device_id ltc2983_of_match[] = {
 	{ .compatible = "adi,ltc2984", .data = &ltc2984_chip_info_data },
 	{ .compatible = "adi,ltc2986", .data = &ltc2986_chip_info_data },
 	{ .compatible = "adi,ltm2985", .data = &ltm2985_chip_info_data },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2983_of_match);
 
diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index a13efde76397df74b6c090fdc474ca89883dee3a..0bbbadeed940d24ed1a99bdb49e0d8213b3ece3c 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -265,7 +265,7 @@ static const struct spi_device_id maxim_thermocouple_id[] = {
 	{"max31855t", MAX31855T},
 	{"max31855e", MAX31855E},
 	{"max31855r", MAX31855R},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, maxim_thermocouple_id);
 
diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index c2447860adfd6f4b1a9f4d61e3de301271fe05d9..6e9108d5cf75f3b7a3c45ada1537c446c6853392 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -449,13 +449,13 @@ static int mcp9600_probe(struct i2c_client *client)
 
 static const struct i2c_device_id mcp9600_id[] = {
 	{ "mcp9600" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp9600_id);
 
 static const struct of_device_id mcp9600_of_match[] = {
 	{ .compatible = "microchip,mcp9600" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp9600_of_match);
 
diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
index fd4d389ce1dfec031652d4f7881ec0b72a015998..043283b02c4d78caa9fa6592d1c727a849f51ade 100644
--- a/drivers/iio/temperature/tmp007.c
+++ b/drivers/iio/temperature/tmp007.c
@@ -558,7 +558,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(tmp007_pm_ops, tmp007_suspend, tmp007_resume);
 
 static const struct of_device_id tmp007_of_match[] = {
 	{ .compatible = "ti,tmp007", },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tmp007_of_match);
 
diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index cfaa16f46a3fde699f5d635c691702656eb7ebfa..334bba6fdae6cb87d81d697f265eb5649cd00bb9 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -207,13 +207,13 @@ static int tsys01_i2c_probe(struct i2c_client *client)
 
 static const struct i2c_device_id tsys01_id[] = {
 	{ "tsys01" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tsys01_id);
 
 static const struct of_device_id tsys01_of_match[] = {
 	{ .compatible = "meas,tsys01", },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tsys01_of_match);
 
diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
index ef34b3c58f262b0c41a1f9642a846d14f99d55a1..0cad27205667e9f55d683ae39e1ee01bdc6ea960 100644
--- a/drivers/iio/temperature/tsys02d.c
+++ b/drivers/iio/temperature/tsys02d.c
@@ -169,7 +169,7 @@ static int tsys02d_probe(struct i2c_client *client)
 
 static const struct i2c_device_id tsys02d_id[] = {
 	{ "tsys02d" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tsys02d_id);
 
diff --git a/drivers/iio/test/iio-test-format.c b/drivers/iio/test/iio-test-format.c
index fc67e6b73df7a4efbcbb29c31aa5520f5586e396..872dd8582003f40490fa8dd2454cee0340c4efcc 100644
--- a/drivers/iio/test/iio-test-format.c
+++ b/drivers/iio/test/iio-test-format.c
@@ -257,7 +257,7 @@ static struct kunit_case iio_format_test_cases[] = {
 		KUNIT_CASE(iio_test_iio_format_value_fractional_log2),
 		KUNIT_CASE(iio_test_iio_format_value_multiple),
 		KUNIT_CASE(iio_test_iio_format_value_integer_64),
-		{}
+		{ }
 };
 
 static struct kunit_suite iio_format_test_suite = {
diff --git a/drivers/iio/test/iio-test-gts.c b/drivers/iio/test/iio-test-gts.c
index 1eceec9d477f4c54925e6a14a28a99b882fa32fe..11250bc905c9b041e60f410bce8242bd67e616e9 100644
--- a/drivers/iio/test/iio-test-gts.c
+++ b/drivers/iio/test/iio-test-gts.c
@@ -499,7 +499,7 @@ static struct kunit_case iio_gts_test_cases[] = {
 	KUNIT_CASE(test_iio_find_closest_gain_low),
 	KUNIT_CASE(test_iio_gts_total_gain_to_scale),
 	KUNIT_CASE(test_iio_gts_avail_test),
-	{}
+	{ }
 };
 
 static struct kunit_suite iio_gts_test_suite = {
diff --git a/drivers/iio/test/iio-test-rescale.c b/drivers/iio/test/iio-test-rescale.c
index bbc6a2e1c2c1d036a32aaa7d73a93bc1327f9cc0..ac6942cf1e448a7c28671cdd8506c138ea842edb 100644
--- a/drivers/iio/test/iio-test-rescale.c
+++ b/drivers/iio/test/iio-test-rescale.c
@@ -704,7 +704,7 @@ static void iio_rescale_test_offset(struct kunit *test)
 static struct kunit_case iio_rescale_test_cases[] = {
 	KUNIT_CASE_PARAM(iio_rescale_test_scale, iio_rescale_scale_gen_params),
 	KUNIT_CASE_PARAM(iio_rescale_test_offset, iio_rescale_offset_gen_params),
-	{}
+	{ }
 };
 
 static struct kunit_suite iio_rescale_test_suite = {
diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/trigger/stm32-lptimer-trigger.c
index 3dcc8d2fe093b72cf7b4868fab624c92a32b0ca5..2505ace440b46f29f3f322416c82a32177fea859 100644
--- a/drivers/iio/trigger/stm32-lptimer-trigger.c
+++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
@@ -133,7 +133,7 @@ static int stm32_lptim_trigger_probe(struct platform_device *pdev)
 static const struct of_device_id stm32_lptim_trig_of_match[] = {
 	{ .compatible = "st,stm32-lptimer-trigger", .data = &stm32mp15_lptim_cfg },
 	{ .compatible = "st,stm32mp25-lptimer-trigger", .data = &stm32mp25_lptim_cfg},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stm32_lptim_trig_of_match);
 
diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index e41cb741253b8410cfa6734f7e4c82d220160a97..925b864facca1b61919ed84f9343a1180f51bd00 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -711,7 +711,7 @@ static const struct iio_chan_spec_ext_info stm32_trigger_count_info[] = {
 	IIO_ENUM_AVAILABLE("enable_mode", IIO_SHARED_BY_TYPE, &stm32_enable_mode_enum),
 	IIO_ENUM("trigger_mode", IIO_SEPARATE, &stm32_trigger_mode_enum),
 	IIO_ENUM_AVAILABLE("trigger_mode", IIO_SHARED_BY_TYPE, &stm32_trigger_mode_enum),
-	{}
+	{ }
 };
 
 static const struct iio_chan_spec stm32_trigger_channel = {
@@ -921,7 +921,7 @@ static const struct of_device_id stm32_trig_of_match[] = {
 		.compatible = "st,stm32mp25-timer-trigger",
 		.data = (void *)&stm32mp25_timer_trg_cfg,
 	},
-	{ /* end node */ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stm32_trig_of_match);
 
diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index c1c73308800c50dbb84574df9e645a167e08c6fd..830ff38fda92e42e7c52f054d4ff69cfb2fd1bcd 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -294,7 +294,7 @@ static int adis16203_probe(struct spi_device *spi)
 
 static const struct of_device_id adis16203_of_match[] = {
 	{ .compatible = "adi,adis16203" },
-	{ },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, adis16203_of_match);
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 6c14d7bcdd6750908e9a53302d48df5abb7bdbbf..1368c3ea5d1879e30b905c752e05ea3c9469928a 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -431,7 +431,7 @@ static const struct spi_device_id ad7816_id[] = {
 	{ "ad7816", ID_AD7816 },
 	{ "ad7817", ID_AD7817 },
 	{ "ad7818", ID_AD7818 },
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(spi, ad7816_id);
diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index e6ad088636f63b644715c14ffb92470a63fb8d3a..f45968ef94eaa59382a8cc70721f3cd56834b4e5 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -127,7 +127,7 @@ static const struct of_device_id adt7316_of_match[] = {
 	{ .compatible = "adi,adt7516" },
 	{ .compatible = "adi,adt7517" },
 	{ .compatible = "adi,adt7519" },
-	{ },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, adt7316_of_match);
diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 1bf23384d28bb035de2cfbf09216aa4e9cddce1a..738982e2713fae35a177a35c9e2edfaadd5369fe 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -412,7 +412,7 @@ MODULE_DEVICE_TABLE(of, ad9832_of_match);
 static const struct spi_device_id ad9832_id[] = {
 	{"ad9832", 0},
 	{"ad9835", 0},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad9832_id);
 
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 50413da2aa652b8cf2a33047399bad5450b8a331..0038eb234d40920c77abac2472aa775ba62f0ed6 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -479,7 +479,7 @@ static const struct spi_device_id ad9834_id[] = {
 	{"ad9834", ID_AD9834},
 	{"ad9837", ID_AD9837},
 	{"ad9838", ID_AD9838},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad9834_id);
 
@@ -488,7 +488,7 @@ static const struct of_device_id ad9834_of_match[] = {
 	{.compatible = "adi,ad9834"},
 	{.compatible = "adi,ad9837"},
 	{.compatible = "adi,ad9838"},
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, ad9834_of_match);
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 5aaa43e94c52583f4509e605d78b85e5725302ba..6b3e2319e79140f46939ce69781a9e532e374daf 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -728,7 +728,7 @@ static int ad5933_probe(struct i2c_client *client)
 static const struct i2c_device_id ad5933_id[] = {
 	{ "ad5933" },
 	{ "ad5934" },
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, ad5933_id);
@@ -736,7 +736,7 @@ MODULE_DEVICE_TABLE(i2c, ad5933_id);
 static const struct of_device_id ad5933_of_match[] = {
 	{ .compatible = "adi,ad5933" },
 	{ .compatible = "adi,ad5934" },
-	{ },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, ad5933_of_match);
diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 9ef5ee087eda367ff2c01923802238421bdbf7eb..bc82bb6a7a2a9dbfaf7f8d3857ca6a20d1a78052 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -335,7 +335,7 @@ static const struct option longopts[] = {
 	{ "device-num",		1, 0, 'N' },
 	{ "trigger-name",	1, 0, 't' },
 	{ "trigger-num",	1, 0, 'T' },
-	{ },
+	{ }
 };
 
 int main(int argc, char **argv)

---
base-commit: 1c2409fe38d5c19015d69851d15ba543d1911932
change-id: 20250411-iio-sentinel-normalization-95b781860d37

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


