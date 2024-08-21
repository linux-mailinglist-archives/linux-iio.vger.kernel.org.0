Return-Path: <linux-iio+bounces-8664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659AA95A737
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 23:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5F42836AB
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 21:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28CB17B4EB;
	Wed, 21 Aug 2024 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLSzE0ke"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036B217BB08;
	Wed, 21 Aug 2024 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277451; cv=none; b=e3gLy63jGkeV5xQhbviXVfJb44LMLsDXvDTq8kOWgHakgEjdmZKnxEifTOYUv8E+cNZna+YcPCqvsnBq8ymTnsMqc8dLzFfRylUf1s2XKXpS2jBVeTl0qvQ3ZJwCd0T0uCqtTqfS6D7v6sEK7G+GSpeLOTW4a0CuQDyxB0SvYu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277451; c=relaxed/simple;
	bh=DF+6ztCHnueO2fFvYCDJnNILxxWQTXSnam8WP7wX6DA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XdKue9NCj8O4Mo1sHtnCPBoC21t3KXVk24SHH9spGIKnUdZKhDs6BA51ZRPosSJ9+LbSSx7UrDYCR95PRIebXlNqKTdDLqJoAe4UtGvuIQW9HM3ioYfRRp9rXE7WJ4HOFvpHS3p47gk28QLOLRUi3EGEGOLNBv99A3pX84+9aI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLSzE0ke; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3dc16d00ba6so92443b6e.0;
        Wed, 21 Aug 2024 14:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724277449; x=1724882249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ipbjvqWXvqQumm5VIkPHpXVLhtH/jP49GHIISjFlUrc=;
        b=FLSzE0keaCfNrRdeZ9pfiAC3YJxJ5zrwMWajxBh03rD1mQwZySNxT4lVYFIkEllaY8
         oQV2X+VFXovIE3ph6b13WKTLFCDtXt35I0uoM+4JFTIZ5p7DhJ8kdaQVg6ANR8+8eRZO
         IETUzzUO4iS1GBMJNVB2xwuYbXFh6fsIrl7vBcIh4zFTGLFr8qtAvkfNCSqv15g+ad4V
         FYveOVjBYlsVmYRu3tAL9hiECn/X4z4JryEXIkTh0vwoZfmUOALpNi39DCYLCAa3Ck7p
         6WPna1qX/Y1+Bfn+DsMp/lb1S1NbXbIW27IhpCJ6C3Niy7GrPUuVMHtc0oAQoceAsTNP
         1IEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277449; x=1724882249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipbjvqWXvqQumm5VIkPHpXVLhtH/jP49GHIISjFlUrc=;
        b=izSxcXxa8bMKjiXf+Z/GSg8IwWc+tN8KPcjNW+NZNB9mq5m2ibwvB/KjwropqSVZat
         pJltEGP/hgKLXQ7MVRoiKtHtE8XSNEycfa31NTwxY/0wLvhmZ3n/rhNnd1Dh0q84esNU
         otQnuk3fi/hwoRi0jdzNPOpB3Qod7DMmldk89C51JLfxopZe4SXpP5hy8x8cZV8F5u9v
         99qonl2A7G0uYrCCpnIicsdj+IQiZ6Tm2YtgvFriOcSlF6i00YP8wWbEUe7bKzHkyKqP
         v+DW23KrE1X3GW2sflPSk7aqn+BDESJihZvweTi7Hoyr6hGJ54akpeLi0qzpa1gtujcB
         NFOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbMz1gw7wzlvwbXwQy+zOcoyMyOdhJlOZdPp68zQN6W+BOKDl4cE813vto7urnqIw4Ojiw8ZC4bWLx@vger.kernel.org, AJvYcCVpQFMMeMPVxagDlCmKM8vHUHEPXDqi0svLowlAHakPA8rIyN4ZmiZc08cuAjEu2R4XW0N247YFTIHj@vger.kernel.org
X-Gm-Message-State: AOJu0YwfK5tY/sDYcoTyartbfQC50/5vhleS3AFGDjPROVg7dgEVsqwT
	49nIAw5XfRfwSix6Wy68yAK9LUDI33M1nNCzm+CZ0bmUD2dYE/ICchUoyQ==
X-Google-Smtp-Source: AGHT+IGxf0cuHBjy0JYk5Bv3rXMuAB9YU9MSytP3soFOCKx+/dalE+sypyFQjmXlf1pjlVYXtYy/lw==
X-Received: by 2002:a05:6808:f15:b0:3d9:ad9d:622f with SMTP id 5614622812f47-3de1951632bmr4259723b6e.27.1724277448797;
        Wed, 21 Aug 2024 14:57:28 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:81a9:2325:e0f7:7376])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de225555b6sm47070b6e.17.2024.08.21.14.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:57:28 -0700 (PDT)
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
	jonathan.cameron@huawei.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 00/15] Add Battery and USB Supply for AXP717
Date: Wed, 21 Aug 2024 16:54:41 -0500
Message-Id: <20240821215456.962564-1-macroalpha82@gmail.com>
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

Changes from V3:
 - Remove accidental AXP717_BOOST regulator in header file, as it is
   not part of this patch series.
 - Add an absolute min/max constraint for input-current-limit-microamp
   in device tree documentation.
 - Correct an issue found by kernel test robot <lkp@intel.com> by
   explicitly adding linux/bitfield.h include. Details here:
   https://lore.kernel.org/oe-kbuild-all/202408201228.Hee4eSYl-lkp@intel.com/

Changes from V2:
 - Added constraints for input-current-limit-microamp constraints for
   x-powers,axp20x-usb-power-supply.yaml.
 - Used FIELD_GET() and removed unnecessary -EINVAL per comments from
   Jonathan Cameron.

Changes from V1:
 - Refactored against mainline to remove BOOST pre-requisite.
 - Corrected commit subjects for DT bindings.
 - Split refactoring and AXP717 support into different patches.
 - Added IRQ for VBUS over voltage. There appears to be a bug
   with the VBUS fault IRQ because it is assigned IRQ num 0.
 - Corrected battery driver to report POWER_SUPPLY_PROP_VOLTAGE_MIN
   and POWER_SUPPLY_PROP_VOLTAGE_MAX instead of *_DESIGN.


Chris Morgan (15):
  iio: adc: axp20x_adc: Add adc_en1 and adc_en2 to axp_data
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
 .../x-powers,axp20x-usb-power-supply.yaml     |  72 ++-
 .../sun50i-h700-anbernic-rg35xx-2024.dts      |  21 +
 drivers/iio/adc/axp20x_adc.c                  | 182 +++++-
 drivers/mfd/axp20x.c                          |  25 +-
 drivers/power/supply/axp20x_battery.c         | 591 ++++++++++++++++--
 drivers/power/supply/axp20x_usb_power.c       | 353 ++++++++++-
 include/linux/mfd/axp20x.h                    |  26 +
 9 files changed, 1188 insertions(+), 101 deletions(-)

-- 
2.34.1


