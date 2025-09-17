Return-Path: <linux-iio+bounces-24204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79651B7C5DA
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 13:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E62188AEDC
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 09:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD312E8B7A;
	Wed, 17 Sep 2025 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ce2zHK1p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391B225390;
	Wed, 17 Sep 2025 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101488; cv=none; b=igwePJO/fuhBCg2CvbkP0oDiCaJj7DObVL+cSF5yQRTMC4kCFinQAnsntcYcP4Uhlk0kZe9WYyoR4Q32Qa22BYoh1u5vmipFkffX2wRM/eKJN7YQVTwuNHCIkU5hYfSHssoaQTSS31SbjgNcc4qgDvAT00yFOfo+ifiL6T7mcl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101488; c=relaxed/simple;
	bh=4jpzCIoZu50VJNQx/tE5PCeb01WHwNr3Npziju95tg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbaDtIvfe8ffMfLGerbUIGRTRV5KFdsej8AyrqknqblrfMyrjnYYvCbLfFYsIwHFEvJ323VrNso7LFT4mliCcUiBoGBYyXHhwisZHBBhTyaEaSN9FSv178l/nADVyG05XKXGS4TfcAvsOMRKK5f1ewmUbyHweKUJPXoCX4LIVIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ce2zHK1p; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758101485; x=1789637485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4jpzCIoZu50VJNQx/tE5PCeb01WHwNr3Npziju95tg4=;
  b=ce2zHK1pfYl9RuxXZ7x+RRanqYWbOL+orJN09IxVqrP8O7x6C51EegHF
   Wbj/rRjGThrbZ1zZFPdyay1e79fUrBbFR8FuQsDHmgSEw6wzdhAxujccD
   1OxJ+U055Nm8PYuMqoXsTb/7Xkrg40VJfx/roq6O+h6FBXx04zMV5O3pb
   xByua520WklyfRrRdkCIR8n2knUqWo8CmDSOEp5qTidyw+RXykbZKgHI7
   GqmDBwZpWsJuN8RY+b+Av4VA2RrwE4PiGnaT2ncISSdkfrKnqAGjIwg5u
   kPand6CXbUT+43kxxX9WIQwZOBqoFjeExJ9jTuel/dXaHmjwrtSIfP7Ry
   w==;
X-CSE-ConnectionGUID: 7aL0AX91RTSTAemA0tU0NA==
X-CSE-MsgGUID: jcHGQwOoSZm5hzjCZ0qL/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71028308"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="71028308"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 02:31:24 -0700
X-CSE-ConnectionGUID: 5BIt0BKbRI6p0i6AjQZtBg==
X-CSE-MsgGUID: Z8c/mGQ6T5WqQxDzRg37Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="179201709"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 Sep 2025 02:31:19 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uyoVP-0001JX-32;
	Wed, 17 Sep 2025 09:31:15 +0000
Date: Wed, 17 Sep 2025 17:30:26 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	sboyd@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@baylibre.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org,
	casey.connolly@linaro.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 4/7] phy: qualcomm: eusb2-repeater: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <202509171640.JfR2hhcz-lkp@intel.com>
References: <20250916084445.96621-5-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916084445.96621-5-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250915]
[cannot apply to jic23-iio/togreg char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus sre-power-supply/for-next linus/master v6.17-rc6 v6.17-rc5 v6.17-rc4 v6.17-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/spmi-Implement-spmi_subdevice_alloc_and_add-and-devm-variant/20250916-164807
base:   next-20250915
patch link:    https://lore.kernel.org/r/20250916084445.96621-5-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v4 4/7] phy: qualcomm: eusb2-repeater: Migrate to devm_spmi_subdevice_alloc_and_add()
config: i386-buildonly-randconfig-001-20250917 (https://download.01.org/0day-ci/archive/20250917/202509171640.JfR2hhcz-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250917/202509171640.JfR2hhcz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509171640.JfR2hhcz-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/phy/qualcomm/phy-qcom-eusb2-repeater.o: in function `eusb2_repeater_probe':
   phy-qcom-eusb2-repeater.c:(.text+0x315): undefined reference to `devm_spmi_subdevice_alloc_and_add'
   ld: drivers/base/regmap/regmap-spmi.o: in function `regmap_spmi_base_read':
>> regmap-spmi.c:(.text+0x79): undefined reference to `spmi_register_read'
   ld: drivers/base/regmap/regmap-spmi.o: in function `regmap_spmi_base_gather_write':
>> regmap-spmi.c:(.text+0xbe): undefined reference to `spmi_register_zero_write'
>> ld: regmap-spmi.c:(.text+0xe5): undefined reference to `spmi_register_write'
   ld: drivers/base/regmap/regmap-spmi.o: in function `regmap_spmi_ext_read':
>> regmap-spmi.c:(.text+0x1a0): undefined reference to `spmi_ext_register_read'
>> ld: regmap-spmi.c:(.text+0x1c7): undefined reference to `spmi_ext_register_readl'
   ld: drivers/base/regmap/regmap-spmi.o: in function `regmap_spmi_ext_gather_write':
>> regmap-spmi.c:(.text+0x228): undefined reference to `spmi_ext_register_write'
>> ld: regmap-spmi.c:(.text+0x24f): undefined reference to `spmi_ext_register_writel'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for REGMAP_SPMI
   Depends on [m]: SPMI [=m]
   Selected by [y]:
   - PHY_QCOM_EUSB2_REPEATER [=y] && OF [=y] && (ARCH_QCOM || COMPILE_TEST [=y])
   Selected by [m]:
   - HI6421V600_IRQ [=m] && OF [=y] && SPMI [=m] && HAS_IOMEM [=y]
   - PINCTRL_QCOM_SPMI_PMIC [=m] && PINCTRL [=y] && (ARCH_QCOM || COMPILE_TEST [=y]) && OF [=y] && SPMI [=m]
   - QCOM_SPMI_TEMP_ALARM [=m] && THERMAL [=y] && (ARCH_QCOM && OF [=y] || COMPILE_TEST [=y]) && OF [=y] && SPMI [=m] && IIO [=y]
   - MFD_HI6421_SPMI [=m] && HAS_IOMEM [=y] && OF [=y] && SPMI [=m]
   - REGULATOR_MT6315 [=m] && REGULATOR [=y] && SPMI [=m]
   - QCOM_SPMI_ADC5 [=m] && IIO [=y] && SPMI [=m]
   - NVMEM_APPLE_SPMI [=m] && NVMEM [=y] && (ARCH_APPLE || COMPILE_TEST [=y]) && SPMI [=m]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

