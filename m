Return-Path: <linux-iio+bounces-2721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A082D8594CF
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 06:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2210A1F21FE0
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 05:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7C25221;
	Sun, 18 Feb 2024 05:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="OzI7YS5a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B304C7D
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 05:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708235322; cv=none; b=hYEsLPbYWkGcHaY/6PV7AP8WrcYuMX0tg6/6R0uSirrHHYl5epwXB1kK05vFc2l3hZydwLgIjdySQzo7sPgV+JeJVm8sXZlj/tV4GiH6lVNxA1fojBDYjow7VjVxTt0EZaim1SKK2jZvafNpFRThz1U3iPyeWcP1isOP9Zrs3vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708235322; c=relaxed/simple;
	bh=2G8L9j8Jf4lGwtSfk7Wp5gH1hdFOGkt/0XZUCwaOhWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ugGKw5V5fnrbh4VeSvGoKK8HknngNhKloZ8EjoXKmIXvlGAzr7TSIn2j2xDp0G6NNt0WibjDkAzwH/D/Dq4+uEN55UFsBVE9T9cR1v/cL6NYYs4JGG7W7FM/qbE3NIEMk/NUbVh8x0bEdDyluxxgKhmt/Sy43axqBtPq/y1jvPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=OzI7YS5a; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6da9c834646so3069127b3a.3
        for <linux-iio@vger.kernel.org>; Sat, 17 Feb 2024 21:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1708235319; x=1708840119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YjMuUzABWzpVB4/hbUrhPrwuX/ajVWmWi+DbJFf13M0=;
        b=OzI7YS5aTiRDS3x3kTqSB9ad//bVVtfKGjP2c2ss4JRIE97PMfUlS9xgm0LyoUjqW1
         qCQAZBHIKTfh1GQIO4OcF3GcX5qea6odHNrMiQ9lytQc8MKtJo89v/D9T08LViDHPCLO
         evnRs00DUH36NlL8b4GMzG/Ev031nFP36mjnCeWv4ixRCyB5OGqgwYz3EaA8MTxd4X/C
         WPDc9aJNaqdSJ/yQq34jMTD85RSkMTg6eIpxflQfe/VDRzt0pEKTjfwBN2TMQb5zPffO
         +T/MbeAVMIWE0pP7O0jKw9FQ7AxcDlU7Wrj3ie/VHsmwNr3Gk3KTwJ12U7exLNlZs277
         vtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708235319; x=1708840119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjMuUzABWzpVB4/hbUrhPrwuX/ajVWmWi+DbJFf13M0=;
        b=oYYUHWOIZUiphaDAkfvZm/TpiWa6yNRUFPe5nEoMXfPLxtsCDPc7gE5A1plsvtREkq
         +GjUgOx9DodCOV8gJOUCrI9UrUBlEHYH9BTCl580b6oqbNoVMrIYeQhMRDpTq+2hbW/t
         1OOAhQyA/IhYty9plq96i4nupsHoLzE3GBONlorKUI6i2uGT2lJg/9X2IhyRjBdv5DPr
         tENFIz6x4jQgdUvSF4/xbE1I5FUDjLImVIxFy64bqCNCs+C+jN3rp4d2vETbhfmgZHKt
         B4X8AUCMaspOpR/Ui1G+L7aP1DrLRT3PTfwjTF9j6m99Xsge0wOocO+1OBYutR0LxhJ4
         c3qA==
X-Forwarded-Encrypted: i=1; AJvYcCVaIY9ctnT8pzJPfyiBQ5bwXNmdmsMlbpWIaHk7sWJhQwmA6aMhrkqrOL5ipOOLpEtAz+vKkb1vL/YLPxTWAXk9MNHitGP53Gk5
X-Gm-Message-State: AOJu0YxcannQ8IM8m9j3znZIepNSTLlCUhbEL5DgPMcNQXc5+kjnSnmH
	8BMlc+orTQsXT3lzTbbGYhtXAUsePP5LKTBDcXosX4EHnT9U6wSvnqJ3aLYdSUE=
X-Google-Smtp-Source: AGHT+IEU4jeDZnMCeD157SW3Qb5XpFVVctBrCUr1fUhg9NpkM4WGx8K8P/3ycgzuHGohZung3Hc1/w==
X-Received: by 2002:aa7:8203:0:b0:6e0:3789:1d22 with SMTP id k3-20020aa78203000000b006e037891d22mr8754490pfi.0.1708235319243;
        Sat, 17 Feb 2024 21:48:39 -0800 (PST)
Received: from localhost.localdomain ([180.150.113.62])
        by smtp.gmail.com with ESMTPSA id 32-20020a631260000000b005d3bae243bbsm2394808pgs.4.2024.02.17.21.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 21:48:38 -0800 (PST)
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marex@denx.de>,
	Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/5] Support for Avago APDS9306 Ambient Light Sensor
Date: Sun, 18 Feb 2024 16:18:21 +1030
Message-Id: <20240218054826.2881-1-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for Avago APDS9306 Ambient Light Sensor.

Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
It has two channels - ALS and CLEAR. The ALS (Ambient Light Sensor)
channel approximates the response of the human-eye providing direct
read out where the output count is proportional to ambient light levels.
It is internally temperature compensated and rejects 50Hz and 60Hz flicker
caused by artificial light sources. Hardware interrupt configuration is
optional. It is a low power device with 20 bit resolution and has 
configurable adaptive interrupt mode and interrupt persistence mode.
The device also features inbuilt hardware gain, multiple integration time
selection options and sampling frequency selection options.

This driver also uses the IIO GTS (Gain Time Scale) Helpers Namespace for 
Scales, Gains and Integration time implementation.

Link: https://docs.broadcom.com/doc/AV02-4755EN

v6 -> v7:
 - Made comments to struct part_id_gts_multiplier as kernel doc
 - Removed static_asserts for array sizes
 - Moved regmap_field from driver private data structure and removed
   regfield_ prefix to reduce names
 - Used "struct apds9306_regfields *rf = &data->rf" in the respective
   functions to reduce names
 - Removed apds9306_runtime_power_on() and apds9306_runtime_power_off()
   functions in favour of using the runtime_pm calls directly from
   calling functions.
 - Fixed indentations
   https://lore.kernel.org/all/ZcOZX8mWTozC2EAc@smile.fi.intel.com/#r

v6 -> v7 Bindings:
 - Updated commit message
 - Removed wrong patch dependency statement from commit messages
 - Updates tags
   https://lore.kernel.org/all/20240206-gambling-tricycle-510794e20ca8@spud/

v5 -> v6:
 - Changes as per review
 - Update kernel doc for private data
 - Change IIO Event Spec definitions
 - Update guard mutex lock implementation
 - Add pm_runtime_get()
 - Update styling
   Link: https://lore.kernel.org/all/20240204134056.5dc64e8b@jic23-huawei/
 
v5 -> v6 Bindings:
 - Write proper commit messages
 - Add vdd-supply in a separate commit
 - Add Interrupt macro in a separate commit
   Link: https://lore.kernel.org/all/1d0a80a6-dba5-4db8-a7a8-73d4ffe7a37e@linaro.org/

v2 -> v5:
 - Bumped up the version:
   RFC->v0->v1->v2->v3 (Earlier scheme)
   v1->v2->v3->v4->v5 (Scheme after review) (Current scheme)
   Link: https://lore.kernel.org/all/20231028143631.2545f93e@jic23-huawei/

 - Added separate patch to merge schemas for APDS9300 and APDS9906. Added
   APDS9306 support on top of that.
   Link: https://lore.kernel.org/lkml/4e785d2e-d310-4592-a75a-13549938dcef@linaro.org/
   Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/

 - Removed scale attribute for Intensity channel:
   Link: https://lore.kernel.org/all/20231204095108.22f89718@jic23-huawei/

 - Dropped caching of hardware gain, repeat rate and integration time and
   updated code as per earlier reviews.
   Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/

 - Added descriptive commit messages
 - Fixed wrongly formatted commit messages
 - Added changelog in right positions

 - Link to v2: 
   https://lore.kernel.org/lkml/20231027074545.6055-3-subhajit.ghosh@tweaklogic.com/

v2 -> v5 Bindings:
 - Removed 'required' for Interrupts and 'oneOf' for compatibility strings
   as per below reviews:
   Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/
   Link: https://lore.kernel.org/lkml/22e9e5e9-d26a-46e9-8986-5062bbfd72ec@linaro.org/

 - Implemented changes as per previous reviews:
   Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/
   Link: https://lore.kernel.org/lkml/22e9e5e9-d26a-46e9-8986-5062bbfd72ec@linaro.org/

Subhajit Ghosh (5):
  dt-bindings: iio: light: Merge APDS9300 and APDS9960 schemas
  dt-bindings: iio: light: adps9300: Add missing vdd-supply
  dt-bindings: iio: light: adps9300: Update interrupt definitions
  dt-bindings: iio: light: Avago APDS9306
  iio: light: Add support for APDS9306 Light Sensor

 .../bindings/iio/light/avago,apds9300.yaml    |   20 +-
 .../bindings/iio/light/avago,apds9960.yaml    |   44 -
 drivers/iio/light/Kconfig                     |   12 +
 drivers/iio/light/Makefile                    |    1 +
 drivers/iio/light/apds9306.c                  | 1336 +++++++++++++++++
 5 files changed, 1364 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
 create mode 100644 drivers/iio/light/apds9306.c


base-commit: c1ca10ceffbb289ed02feaf005bc9ee6095b4507
-- 
2.34.1


