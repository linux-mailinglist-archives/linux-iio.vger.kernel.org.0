Return-Path: <linux-iio+bounces-15993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0C6A41A81
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 11:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 024197A1568
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 10:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EB224CED2;
	Mon, 24 Feb 2025 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZwVtRh9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3859A24A07D;
	Mon, 24 Feb 2025 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392109; cv=none; b=uiUXWw0PPcnT8LlwACuhV6QGnvXH1VX0Kz2IhI68J+gTBV0SOWKddluxywIgsC3VKq198mVVz0qxIciNhiEIjIib3WI/6o32C731UKvT/zhtwhHO68CcAyHoy4o8AwzZnXUAuGEIFOB12QfZnQZwhmf/DWzC/rJrRm8J6y+Rx7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392109; c=relaxed/simple;
	bh=X7vkQQ4F5+cSqqlRkpsILI26dm79sHFn/mANLNxxotY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nTBaNpF1fRqtIg50nX9q0ejWCgD/QJK5qRO4qSNK1wP1ly6u2FSB5JW6QejWSfxRGWGcRUrGtGrfbgAgw/kwr5Y7AgaloUpNHUKe0Sp1naUh7pXmMPSIj9LEiKiRAGHsGdVenX2I4woYmKo3WC2KGqcjDr7qbLWV0D4PqqnBUlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZwVtRh9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740392107; x=1771928107;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X7vkQQ4F5+cSqqlRkpsILI26dm79sHFn/mANLNxxotY=;
  b=PZwVtRh9DcXTsiuOQAi6AcSZElDLzgrBOPPeXWsEnpvl3A3sZ9fghoDC
   JHzOBuGvoj1reow8/TmHcjk8JORk3AJLFM5L2fEyz0tmtPBpce2UoaqiL
   k9PBO0aWWc7rbeBqlxX6tC470Drdb23Fetq90brDb7kHSBz+VJnxP08Xf
   6rQMdZxhQdPxVkk8HmoFpv4HdhfQcGmXupPCMcSmJ2tsHaaTQVpE8+2X2
   nr1b8oWCblIZqmjomxjuZmD7OEyQbm7ghMQIE6SH9GAU9t4WHj4S2nxti
   zlulD76JuYIndM2L0IEx7G+z8dG8ir0biqmAUvZbMhImYn5+PZjnro7sx
   Q==;
X-CSE-ConnectionGUID: tOxFqhTVSuKZwxfSpg2jbQ==
X-CSE-MsgGUID: xPKBFpnzTwCcZkPy9DLWhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="41155833"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41155833"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:15:06 -0800
X-CSE-ConnectionGUID: xf1hhCLjQuy7RYUzkPiaEw==
X-CSE-MsgGUID: C8bHB0NJQtGlmboAve8UyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="121101900"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 24 Feb 2025 02:15:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4B211172; Mon, 24 Feb 2025 12:15:03 +0200 (EET)
Date: Mon, 24 Feb 2025 12:15:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linux pin control <linux-gpio@vger.kernel.org>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [GIT PULL] ib-devres-iio-input-pinctrl-v6.15
Message-ID: <Z7xGpz3Q4Zj6YHx7@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

Hi Linux kernel maintainers,

Here is an immutable tag of the "Split devres APIs to device/devres.h and
introduce devm_kmemdup_array()" series [1], please pull if needed.

Link: https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com [1]

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel.git tags/ib-devres-iio-input-pinctrl-v6.15

for you to fetch changes up to 1f4c7f3b3afa90e10903234c86d5bd168c5f23b3:

  Merge patch series "Split devres APIs to device/devres.h and introduce devm_kmemdup_array()" (2025-02-24 12:08:53 +0200)

----------------------------------------------------------------
ib-devres-iio-input-pinctrl for v6.15

* Split devres APIs to a separate header (linux/device/devres.h)
* Move IOMEM_ERR_PTR() to err.h to avoid unneeded loops
* Introduce devm_kmemdup_array()
* Use devm_kmemdup_array() in input, IIO, and pinctrl subsystems

The following is an automated git shortlog grouped by driver:

baytrail:
 -  copy communities using devm_kmemdup_array()

cherryview:
 -  use devm_kmemdup_array()

devres:
 -  Introduce devm_kmemdup_array()

driver core:
 -  Split devres APIs to device/devres.h

err.h:
 -  move IOMEM_ERR_PTR() to err.h

iio:
 -  adc: xilinx-xadc-core: use devm_kmemdup_array()
 -  imu: st_lsm9ds0: Replace device.h with what is needed

input:
 -  ipaq-micro-keys: use devm_kmemdup_array()
 -  sparse-keymap: use devm_kmemdup_array()

intel:
 -  copy communities using devm_kmemdup_array()

Merge patch series "Split devres APIs to device/devres.h and introduce devm_kmemdup_array()":
 - Merge patch series "Split devres APIs to device/devres.h and introduce devm_kmemdup_array()"

pxa2xx:
 -  use devm_kmemdup_array()

tangier:
 -  use devm_kmemdup_array()

----------------------------------------------------------------
Andy Shevchenko (3):
      driver core: Split devres APIs to device/devres.h
      iio: imu: st_lsm9ds0: Replace device.h with what is needed
      Merge patch series "Split devres APIs to device/devres.h and introduce devm_kmemdup_array()"

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
 include/linux/device.h                      | 119 +------------------------
 include/linux/device/devres.h               | 129 ++++++++++++++++++++++++++++
 include/linux/err.h                         |   3 +
 include/linux/io.h                          |   2 -
 14 files changed, 152 insertions(+), 147 deletions(-)
 create mode 100644 include/linux/device/devres.h

-- 
With Best Regards,
Andy Shevchenko



