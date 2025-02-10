Return-Path: <linux-iio+bounces-15222-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D6BA2E456
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 07:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E183A4BCE
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 06:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EC61A9B4E;
	Mon, 10 Feb 2025 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpvdNqv9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07CD199237;
	Mon, 10 Feb 2025 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170162; cv=none; b=e8oSo8ivaEo58xlhC1NgQ6TDFf2PpLZx48oe+vWh0RUqSOJYw7V3feUkXpvAcyOuxdc2hzvRQOVYkmVbT6/EtcSuHIKsnwmaNmXOvqEmh767eBNPR5+qtIqjHbYRTS1hDPIANYULPUp6WvgCb6GoKQgdyky+86/1nOb/i8fIN2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170162; c=relaxed/simple;
	bh=MT20+ISjNrsfj+JY6Luwuix13n0+yvZ1ZzVBv1EsCd4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YATOc48gxaDk0X7n/PeJb4rdnwXRuq5lLbRBAhuiI49n0eF1/IJKsG5SOSlQTJSUnxWAqLM9fAYxKyuto6r/YLuwepoedsHr2nCLCwuziPPSI0lQW16AAPXceRrhyScNH9meOARjMtEeAhT7QRmYcYhlTfcFiXPSkXAsH5DPy+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpvdNqv9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739170161; x=1770706161;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MT20+ISjNrsfj+JY6Luwuix13n0+yvZ1ZzVBv1EsCd4=;
  b=kpvdNqv9Fd+1whyAp/aVWUJHrScH/en1Z+YW8nMgasBcRoGPK9RF1sdc
   e76bnh8Houf5kcOVKy/s25bbCUILKJxGHCR9lOzi0+2N2bNeeuBGxyPGa
   3tXT1XPHAbIyWD/Pa+QNFKYtPUdjm3xHZ3W+WRhOd2LQbAeef7aF7EHCn
   R2gvd5kpCn1HMdGxwziyai1se3aM6vefqcOamYQHbnrLZvD96RAketfH/
   30/wWSpAZaGibGYv5oFmIkSkJYCYfR72bdcHW4uPEwP5v99kzH3KgyzK+
   G6/SAx9iqeJeBS+0MM5Of/3L6Km9v6pT9LkmnpJy2PoQbr8vemy+QwcZv
   g==;
X-CSE-ConnectionGUID: x2pQQrB0TOaasgOwTyoVBg==
X-CSE-MsgGUID: knOT/hnySd2JSPuq+HhAgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43499274"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43499274"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 22:49:20 -0800
X-CSE-ConnectionGUID: ihMdF6JZSSKHTujs9K787g==
X-CSE-MsgGUID: zszNhHMBSFCXLDb8sZw9yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="117122370"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 09 Feb 2025 22:49:14 -0800
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
Subject: [PATCH v4 00/20] Split devres APIs to device/devres.h and introduce devm_kmemdup_array()
Date: Mon, 10 Feb 2025 12:18:46 +0530
Message-Id: <20250210064906.2181867-1-raag.jadav@intel.com>
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

The idea behind embedding both work into a single series is to make the review
process easier and reduce conflicts while merging.

Current proposal is to merge initial patches with an immutable tag (volunteered
by Andy) for other subsystems to use. Feel free to share a better alternative.

v2: Use size_mul() for multiplication (Dmitry)
    Update commit message (Dmitry)

v3: Embed devres.h work by Andy
    Add more users of devm_kmemdup_array()
    Update tags and rebase

v4: Use IOMEM_ERR_PTR() to fix sparse warnings (Andy)
    Use source size and make it robust against type changes (Andy)

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
 include/linux/device/devres.h               | 130 ++++++++++++++++++++
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
 sound/soc/intel/avs/boards/rt5682.c         |   3 +-
 sound/soc/meson/axg-tdm-interface.c         |   9 +-
 sound/soc/uniphier/aio-cpu.c                |   8 +-
 28 files changed, 181 insertions(+), 184 deletions(-)
 create mode 100644 include/linux/device/devres.h


base-commit: a1e062ab4a1f19bb0e94093ef90ab9a74f1f7744
-- 
2.34.1


