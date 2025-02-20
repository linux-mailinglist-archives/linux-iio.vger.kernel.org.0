Return-Path: <linux-iio+bounces-15851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146E7A3DB02
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 14:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3273AA875
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065CD1F78E4;
	Thu, 20 Feb 2025 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHQF2dJL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52B1F7076;
	Thu, 20 Feb 2025 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057103; cv=none; b=N994eOC7Jck5KndSBZi7yrYLvta9x/fmtwXl6oxyDEQPLCeOtS8fV8yWHAe4UrETQGu7k/3/LJA1eFy1YVorY2YB95WMsp0WqGvlVqMaIPGyL6HHy0Et+zvoQiLb9MS5nxJ7wJzLhqJUGFX5aJdPVr83jIBW0TKPUqganVRhKdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057103; c=relaxed/simple;
	bh=G/ltyWRCwiZVtASq85ExfwztX9W9pFoWXJ5fwzitFNc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k0DGDwat0YQqnrPfFDvDgU9/okuCZkj+PBgnbs0NCBJXLof9fkz3TdT/pGCkGtADdd9DPYtiHstqUcYcL+hXB0NeOse9KD7ynm7MlEY7lAl0A5ohThbAEYWNzoEhrJN/e7jmo+ukD6z1VrEe/UMEeXgDnInFziK6u8tdo7TlL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dHQF2dJL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740057103; x=1771593103;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G/ltyWRCwiZVtASq85ExfwztX9W9pFoWXJ5fwzitFNc=;
  b=dHQF2dJL7y7QLSGijzgkmEKajZfJo4kjpruE7cOw09GWxAyMzMvjmv8x
   Yifd1VSU2paJz6DiVFKo/vOmO1iJlAesOw41/uV4afri/OSq/6pgWGYF6
   dkA6Hja0aWQ2lROV3xyIAwq/m6T1GCa+5m3LPmYeGUsgZW4HEsD+hJoH1
   yG3p49g6Rmir+vf09mlz+XhZNR6GQktdktHNUka89+XJoNiYKlVGijtVD
   xeGtZRrtSPKLK5uGrP+yqxVwqjiAJwf5NPuKwmkY8NUPD0/COp0kO9C1W
   sR4I43JbGwN/vQmhIlVKwY40wdYAIyd+onZj8LdwckHfbt8reEtCDA6td
   Q==;
X-CSE-ConnectionGUID: UuIdjK/QSMS65CD0agEw1w==
X-CSE-MsgGUID: WaOUcclAQ8iIrWOpfEFrwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40953930"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40953930"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 05:11:41 -0800
X-CSE-ConnectionGUID: VsNGEXNnS6qv3PXkTUt/ig==
X-CSE-MsgGUID: 4VQ7ug5pQ1e9nQYraTzC0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120261622"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 20 Feb 2025 05:11:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 131A6123; Thu, 20 Feb 2025 15:11:37 +0200 (EET)
Date: Thu, 20 Feb 2025 15:11:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linux pin control <linux-gpio@vger.kernel.org>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [GIT PULL] devres-iio-input-pinctrl-v6.15
Message-ID: <Z7cqCaME4LxTTBn6@black.fi.intel.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel.git tags/devres-iio-input-pinctrl-v6.15

for you to fetch changes up to 9deb15de8ca27cf9cba0d2bac53bbe37c836591b:

  Merge patch series "Split devres APIs to device/devres.h and introduce devm_kmemdup_array()" (2025-02-20 14:59:10 +0200)

----------------------------------------------------------------
devres-iio-input-pinctrl for v6.15

* Split devres APIs to separate header (linux/device/devres.h)
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



