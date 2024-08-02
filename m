Return-Path: <linux-iio+bounces-8149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF3A9463AE
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 21:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8591C21381
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 19:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D5A1547ED;
	Fri,  2 Aug 2024 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw6R1P8k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A078515AC4;
	Fri,  2 Aug 2024 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722626572; cv=none; b=BMOKesa0aTMbKFrCzTp0Ie/244tKKjcWhq0UVTgVfVxCAj+aq/q1rHuRpLII/x9jtrFv4IZfsrRQWlys7RwdKHkrmGaPtCR9VSyYO17H3v6ZfrDKJV6KWSr2tHFJQ7ZGccBV1eS1OTyS80BwlJbfh3BYJGFhaezylGlrF07NERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722626572; c=relaxed/simple;
	bh=gZz9yj3GXXaj16bFmuLRWhj9n3hpFccCV2NppllFAJg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qf6DY7MOtT/cFUPLc+54lmR+7xbmIP7td/mbwrm9wZ9ppjWufSutXdPkBJzu2/Qq/ENiKIYHPbc5HeCfx3r5L+DD5fc4ZTURtjjBLriW9ssNAJZxVKX9hGa3peQo1Y8X9EPPbDtWTlzSSkCfAulXLaceIwH610FPd7fvW9CCkl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw6R1P8k; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db1956643bso5321116b6e.3;
        Fri, 02 Aug 2024 12:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722626569; x=1723231369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QvMGvJoG9kOmjhl8+GRwEU8yfqrtre7GVJ2bwQWQCa4=;
        b=Rw6R1P8k6HJyRXJAdCxu3FVSWpSAhOOkT1ZADWEjXfv7iZhj3L2/tjK8wEhtHS6JHb
         NYD8DqPhLveGvAROUHhxgfP95SKJULBJPs/oGMJtncptt5bE1JGfxxjqyDLpT/YVBu8R
         UroVvmuRuaXfnlsdr2wCUVUt+3ffHUihmrEjrLZ7yWpGOB6eAy7eeAJrWayGDEvfCy35
         no1FDbNiwMrGWrYGimfeHuV35f1YPPXmIkVWzDLwkvC+qFOMciVtHY2EUuR7Q+gyOLJp
         Plwi+bi5aVE5A7X7nlXocdMf4WaXoSfWeO5EvFlIsKJjzZTXbyVLCw4As/MrmwAH/wjP
         CR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722626569; x=1723231369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvMGvJoG9kOmjhl8+GRwEU8yfqrtre7GVJ2bwQWQCa4=;
        b=otLsIOdPM3fLducjLJjIBsoSFI5a3h8jtxEEuuXT7660tL149xQeL+2s2IGEmgGza1
         hcMHdv77dr1YmHro4RfdgJkuM/95wpK3K4c1BOy08qv3cJiMV1Qqu5dDqmIfNLBhjgNE
         +VLSfHRw3qXjtU+JugymoMPzVSE4Qw+TQC2tQla/ikz1A7sosYHS2jXBul9v0SKj2kbD
         b60MacbTi2kP8wx6URuhanOy0UpXfR0jtLhH1N0SVjrd0iUr+/+O/BsNw9qjLmcknM83
         ZgvENTd+uvvRNxXKpij8DdaPWqgBZ14kHRv/vQHi5SDImDC5/4ZeriocRSi3KFZiYePo
         NglA==
X-Forwarded-Encrypted: i=1; AJvYcCVlOKrxrrz8PqK3DqwpkTJY9ZkZ0Lk5fre2lqH5Nq+gxOze6ZznWLVG1rAfjHSIwKFpcIJhcxabe2mwp4Yaf/LCAB4yYmJYLD1pNnzdOB2FK7+zE7NkPZkokZ/VODnvYX3rEKkDeQ==
X-Gm-Message-State: AOJu0YyfsN0Cj2gkMamoyWeOuX8cluADKkoRIEeX4Jch5s5cyp9lBtHj
	XmNETiWR9kQXKoOQ5XGJseE6hmoE73iAZK4V8JGY1cDKmDZpEel5
X-Google-Smtp-Source: AGHT+IE97Nhw575gDhtEqYkjlJLadE6szPpld+kIQm5cznFCVLtAkB1/xcfs0mJhHPLUrFXlBjqmiw==
X-Received: by 2002:a05:6808:bc6:b0:3da:a48b:d1e6 with SMTP id 5614622812f47-3db5580a11amr6332227b6e.16.1722626569544;
        Fri, 02 Aug 2024 12:22:49 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db563b7065sm584592b6e.46.2024.08.02.12.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:22:49 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	quentin.schulz@free-electrons.com,
	mripard@kernel.org,
	tgamblin@baylibre.com,
	aidanmacdonald.0x0@gmail.com,
	u.kleine-koenig@pengutronix.de,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	sre@kernel.org,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 00/15] Add Battery and USB Supply for AXP717
Date: Fri,  2 Aug 2024 14:20:11 -0500
Message-Id: <20240802192026.446344-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for monitoring the USB charger and battery charger on the
AXP717 PMIC. This required some driver refactoring of the axp20x USB
and battery charger as the AXP717 is somewhat different but can still
benefit from some common elements.

Note that as of now the charging current now value may be incorrect as
the scale and offsets were not documented in the datasheet. I suspect
the scale is 1 and the offset is somewhere around 450mA though.

Changes from V1:
 - Refactored against mainline to remove BOOST pre-requisite.
 - Corrected commit subjects for DT bindings.
 - Split refactoring and AXP717 support into different patches.
 - Added IRQ for VBUS over voltage. There appears to be a bug
   with the VBUS fault IRQ because it is assigned IRQ num 0.
 - Corrected battery driver to report POWER_SUPPLY_PROP_VOLTAGE_MIN
   and POWER_SUPPLY_PROP_VOLTAGE_MAX instead of *_DESIGN.

Chris Morgan (15):
  iio: adc: axp20x_adc: Add adc_en1 and adc_en1 to axp_data
  power: supply: axp20x_battery: Remove design from min and max voltage
  power: supply: axp20x_battery: Make iio and battery config per device
  power: supply: axp20x_usb_power: Make VBUS and IIO config per device
  dt-bindings: power: supply: axp20x: Add input-current-limit-microamp
  power: supply: axp20x_usb_power: add input-current-limit-microamp
  dt-bindings: power: supply: axp20x-battery: Add monitored-battery
  dt-bindings: iio: adc: Add AXP717 compatible
  dt-bindings: power: supply: axp20x: Add AXP717 compatible
  dt-bindings: power: supply: axp20x: Add AXP717 compatible
  mfd: axp20x: Add ADC, BAT, and USB cells for AXP717
  iio: adc: axp20x_adc: add support for AXP717 ADC
  power: supply: axp20x_usb_power: Add support for AXP717
  power: supply: axp20x_battery: add support for AXP717
  arm64: dts: allwinner: h700: Add charger for Anbernic RG35XX

 .../bindings/iio/adc/x-powers,axp209-adc.yaml |  12 +
 .../x-powers,axp20x-battery-power-supply.yaml |   7 +
 .../x-powers,axp20x-usb-power-supply.yaml     |   6 +
 .../sun50i-h700-anbernic-rg35xx-2024.dts      |  21 +
 drivers/iio/adc/axp20x_adc.c                  | 182 +++++-
 drivers/mfd/axp20x.c                          |  25 +-
 drivers/power/supply/axp20x_battery.c         | 597 ++++++++++++++++--
 drivers/power/supply/axp20x_usb_power.c       | 353 ++++++++++-
 include/linux/mfd/axp20x.h                    |  27 +
 9 files changed, 1132 insertions(+), 98 deletions(-)

-- 
2.34.1


