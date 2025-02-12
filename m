Return-Path: <linux-iio+bounces-15393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A77A31EAF
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729CD3A619A
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B32C1FBE9D;
	Wed, 12 Feb 2025 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cszXoyma"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244381DF751;
	Wed, 12 Feb 2025 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341523; cv=none; b=s17t3LzvHS29L//cMbKL0z1K+owPDekH4zXQIUjlXRKXK87MzkMlQlmg/sWOWICVK4YG0pzQUozHliq8vYMiIoiXuSFIFhKhVAZ70+Ofvp7lRR2hLMjSKb7pmffMPx4dkYwpScbY4Rb+7pnkFoiVJkLgLrMvD7Gv/8IVT9WSziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341523; c=relaxed/simple;
	bh=3GczVSezF6lGkia8zxOIs0eEQ/zlXmjuOU3QyuA85dI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Awhw+MquITzQQ8aTKDbMr9vHps2g11VvkyiLgd94dIFayUdRe89VT8ra6onzL7uHput8+5BU+o13sKrBaAkoNPFO8OWTLO6sv2vaW9iw64KrBFMinm4ficsFCTbFqpXrlKUwXOYWTQOodQ3L0AiJGbdWKAGL3FEiasygadPHuU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cszXoyma; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739341521; x=1770877521;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3GczVSezF6lGkia8zxOIs0eEQ/zlXmjuOU3QyuA85dI=;
  b=cszXoymajda8ZkEtFF5YT/nvKik5eusHjEUQmB5vM9LJxUVuqCnIFyJC
   IhnO9mzRXiDAq2NDb31p+WRbfacTRWT3NVQmoMwGLaZNF8vspiijgOlRy
   Pi59M3tnSV//7WXOqupPDym1syyi/K++dUCh8otIKbrKgViiStR7wO/lf
   zm8FZec400/fqSEkJFmnLCwvKdnvwG/tdzWKJWkaDZ/izZUuuT5dZQWyX
   zMwO0S9MwN9Lk8JEWgFYlFEsynUbBKHFy8XPB0iOCdTMZRDrwZ0pl2fGq
   fAreY6EwZUZfq3m2wtZH5gC1TMijQzx0XIxdo2NOEQULem5uZXd8NGDZb
   w==;
X-CSE-ConnectionGUID: KhLnZAcKRoySfMON43uzLw==
X-CSE-MsgGUID: OlAbBpZYTiGTmTUnugbmJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40005141"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="40005141"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:25:20 -0800
X-CSE-ConnectionGUID: JKNa1+JKRrGMelK3GFrn9w==
X-CSE-MsgGUID: Woal9iMTT/ylqywzPRsLMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117811933"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2025 22:25:16 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	dmitry.torokhov@gmail.com,
	jic23@kernel.org,
	przemyslaw.kitszel@intel.com
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v5 00/12] Split devres APIs to device/devres.h and introduce devm_kmemdup_array()
Date: Wed, 12 Feb 2025 11:55:01 +0530
Message-Id: <20250212062513.2254767-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

v5: Move IOMEM_ERR_PTR() to err.h (Andy)
    Reduce distribution to pinctrl/iio/input patches

Andy Shevchenko (2):
  driver core: Split devres APIs to device/devres.h
  iio: imu: st_lsm9ds0: Replace device.h with what is needed

Raag Jadav (10):
  err.h: move IOMEM_ERR_PTR() to err.h
  devres: Introduce devm_kmemdup_array()
  pinctrl: intel: copy communities using devm_kmemdup_array()
  pinctrl: baytrail: copy communities using devm_kmemdup_array()
  pinctrl: cherryview: use devm_kmemdup_array()
  pinctrl: tangier: use devm_kmemdup_array()
  pinctrl: pxa2xx: use devm_kmemdup_array()
  iio: adc: xilinx-xadc-core: use devm_kmemdup_array()
  input: sparse-keymap: use devm_kmemdup_array()
  input: ipaq-micro-keys: use devm_kmemdup_array()

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
 include/linux/device.h                      | 119 +-----------------
 include/linux/device/devres.h               | 129 ++++++++++++++++++++
 include/linux/err.h                         |   3 +
 include/linux/io.h                          |   2 -
 14 files changed, 152 insertions(+), 147 deletions(-)
 create mode 100644 include/linux/device/devres.h


base-commit: 0eee258cdf172763502f142d85e967f27a573be0
-- 
2.34.1


