Return-Path: <linux-iio+bounces-14870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB8CA25393
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE717163F76
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 08:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F051FAC40;
	Mon,  3 Feb 2025 08:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxTO87lw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0244D599;
	Mon,  3 Feb 2025 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570141; cv=none; b=W2XqHLEsgIZ6vdd5RtHA2SuefQMexp2PkH/IF5TW+OmHVF27cU2mq0pBP1isQ+t/ijYRu6m30sIz1DEq1i+vZXB08y0IMjgUzPgJN5sY9v5yLcpBBMO5dANlEXZYnUMFErpDtSqOKQ0+FlRzx3/O3ofCV6BmBcoe6kfDkSiUYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570141; c=relaxed/simple;
	bh=aaR9pZjiwfhbPrOCIRNo0C+Bcdbjnp4XI+XCgztJ7KM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XvRxcuDDD1pxChpmv8Kuvs3ckL8OMy+fveAASAmCAClP07AoCR54He0UiHd0EyUwE91PLku+MG8ce9Jwwog46qVE6c4wR3GQcoOY2ex2ZONjZTKE8PEtHrKFoG2CoSoTZU3YL6YmBmmYgah8LBEgl/2BP2BDrNu9oaFJ1K+dGOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxTO87lw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738570140; x=1770106140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aaR9pZjiwfhbPrOCIRNo0C+Bcdbjnp4XI+XCgztJ7KM=;
  b=bxTO87lw+K+oe2XSohvjrDm2zVURZxEQTiU7Xvbfh0YuToiFMetHAVA+
   reAT01ZNsN6ZEeelacw/79w8wxenagbS7fRFzjhNMpCcaM7CcIyjtkzKJ
   Ud3BxMecSReL9GK1dpwEQEKfcQBgBU4cKsaPrX9heR/A8rT4e6RgFe1yb
   xjTOJp43LR2Ncj4mjZXdpmuoiNWuIy8guFSXsXSDGZRXWsmRBs6kfriDo
   tXuLGhaysjxarWFdtHl3k9bkPYdpr5lMI5jlvC8IsZl5AE3VpmK0oQC4/
   c3XOCNOOTv4ANrsRovV3FOUYnC7+NcyGvJzIQ10mlOIt+IzFpYRB8D/N8
   w==;
X-CSE-ConnectionGUID: dPEcL7BXRwyn/I8B4f2UaQ==
X-CSE-MsgGUID: DDG5c2H0SMKj8jRYSCV4dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="49654053"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="49654053"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 00:08:59 -0800
X-CSE-ConnectionGUID: zgeYX7/CS4eVImfPqjhaDg==
X-CSE-MsgGUID: laeUjj0uQnu8wPOKim7bpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110788405"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 00:08:55 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	sre@kernel.org,
	jic23@kernel.org,
	przemyslaw.kitszel@intel.com
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 00/20] Split devres APIs to device/devres.h and introduce devm_kmemdup_array()
Date: Mon,  3 Feb 2025 13:38:42 +0530
Message-Id: <20250203080902.1864382-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series

1. Splits device/devres.h for the users that are only interested in devres APIs.
   Original work by Andy Shevchenko:
   https://lore.kernel.org/r/20241203195340.855879-1-andriy.shevchenko@linux.intel.com

2. Introduces a more robust and cleaner devm_kmemdup_array() helper and uses it
   across drivers.

The idea behind embedding both work into a single series is to reduce conflicts
and dependencies while merging.

v2: Use size_mul() for multiplication (Dmitry)
    Update commit message (Dmitry)

v3: Embed devres.h work by Andy
    Add more users of devm_kmemdup_array()
    Update tags and rebase

Andy Shevchenko (2):
  driver core: Split devres APIs to device/devres.h
  iio: imu: st_lsm9ds0: Replace device.h with what is needed

Raag Jadav (18):
  devres: Introduce devm_kmemdup_array()
  pinctrl: intel: copy communities using devm_kmemdup_array()
  pinctrl: baytrail: copy communities using devm_kmemdup_array()
  pinctrl: cherryview: use devm_kmemdup_array()
  pinctrl: tangier: use devm_kmemdup_array()
  pinctrl: pxa2xx: use devm_kmemdup_array()
  input: sparse-keymap: use devm_kmemdup_array()
  input: ipaq-micro-keys: use devm_kmemdup_array()
  regulator: devres: use devm_kmemdup_array()
  regulator: cros-ec: use devm_kmemdup_array()
  power: supply: sc27xx: use devm_kmemdup_array()
  iio: adc: xilinx-xadc-core: use devm_kmemdup_array()
  ASoC: Intel: avs: use devm_kmemdup_array()
  ASoC: hdac_hdmi: use devm_kmemdup_array()
  ASoC: tlv320dac33: use devm_kmemdup_array()
  ASoC: uda1380: use devm_kmemdup_array()
  ASoC: meson: axg-tdm-interface: use devm_kmemdup_array()
  ASoC: uniphier: use devm_kmemdup_array()

 drivers/iio/adc/xilinx-xadc-core.c          |   4 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c |   2 +-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c |   2 +-
 drivers/input/keyboard/ipaq-micro-keys.c    |   5 +-
 drivers/input/sparse-keymap.c               |   3 +-
 drivers/pinctrl/intel/pinctrl-baytrail.c    |   6 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c  |   5 +-
 drivers/pinctrl/intel/pinctrl-intel.c       |   6 +-
 drivers/pinctrl/intel/pinctrl-tangier.c     |   5 +-
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c        |   8 +-
 drivers/power/supply/sc27xx_fuel_gauge.c    |   5 +-
 drivers/regulator/cros-ec-regulator.c       |   4 +-
 drivers/regulator/devres.c                  |   5 +-
 include/linux/device.h                      | 119 +-----------------
 include/linux/device/devres.h               | 129 ++++++++++++++++++++
 sound/soc/codecs/hdac_hdmi.c                |   3 +-
 sound/soc/codecs/tlv320dac33.c              |   6 +-
 sound/soc/codecs/uda1380.c                  |   6 +-
 sound/soc/intel/avs/boards/da7219.c         |   3 +-
 sound/soc/intel/avs/boards/es8336.c         |   3 +-
 sound/soc/intel/avs/boards/nau8825.c        |   3 +-
 sound/soc/intel/avs/boards/rt274.c          |   3 +-
 sound/soc/intel/avs/boards/rt286.c          |   3 +-
 sound/soc/intel/avs/boards/rt298.c          |   3 +-
 sound/soc/intel/avs/boards/rt5663.c         |   3 +-
 sound/soc/intel/avs/boards/rt5682.c         |   2 +-
 sound/soc/meson/axg-tdm-interface.c         |   9 +-
 sound/soc/uniphier/aio-cpu.c                |   8 +-
 28 files changed, 179 insertions(+), 184 deletions(-)
 create mode 100644 include/linux/device/devres.h


base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.34.1


