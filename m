Return-Path: <linux-iio+bounces-21836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DDEB0CA6C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 20:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BD11600D6
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 18:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADBE2E1746;
	Mon, 21 Jul 2025 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAOXBHQU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FEB2E0924;
	Mon, 21 Jul 2025 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122491; cv=none; b=IGflyg1ucqWhZEQCaN6Kd0jCiIx449tPhfEJ0DmjBKsadLrYaSYOHrArGGPvOn/f1ywF0blil+v89dmi6+ozigQGaN8UoYJVU8dSU2AypUvF2Ngscfu/VmQ857MJswT9Qsno6EvyBd1+o6nOmgqcejZS7+69sFcGKtanMy6bNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122491; c=relaxed/simple;
	bh=UTzS2RxGqJmq8w5RvId10WeNvFeCpoCyyyvV61HPfmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrUzTGvHoaISDP3qP0PH4sYmVGBaIYr0tGnS1xLKwPFVKNFQtAS8PTOOWEFEZgkppPmyesvWNiB9Ou+AxI+EkhZ5tTiYI0wvuOljlAT1Tpfj8f5YfWqEb1TY8VuXKbBgLQmzH+629w09xzRm7DD/uFDFQO/kS+IbwCiNDzxF4CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAOXBHQU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753122489; x=1784658489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTzS2RxGqJmq8w5RvId10WeNvFeCpoCyyyvV61HPfmA=;
  b=TAOXBHQUC854b+XlD/SHhwg+OMkIGJORi2cm5/yig3kOr5mjYB0DRn9K
   Lg2hDW46VnOm8VcTfg/9E1+u25mcnmMclEQqLAg3n1dCJiHK0XtPzs5f+
   ai48muyJL4u2QKekeCTzlzYYYbGoQOUwSlJnUqXWpzh9C7Gk7D/52MteA
   5goL3OoFXqs0er58DUdH5yRSe/9nn7cIvDCFica77Xf3EENnUPrmk+HBl
   I4E8/ch8Ckz8QfZyys/t+G6UyiEjXauKXLMsdGIcdYE+cdZO8H0kP1pUw
   JlD1fgiEOYBea40ILEYLRSXyiDI5IcMm27sDl3QUQXJSGUCKb+w9orHlI
   g==;
X-CSE-ConnectionGUID: rcchmKLFS/6RyMzBdBU/Mg==
X-CSE-MsgGUID: UCEvZyNgShak0AA9IPdlpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="65915322"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="65915322"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 11:28:08 -0700
X-CSE-ConnectionGUID: d7zoVHWXQViN4D8+s1Ga0w==
X-CSE-MsgGUID: Ffn1JglIQtagiH8+sp4tqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="195988638"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 21 Jul 2025 11:28:04 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udvF3-000H4D-1x;
	Mon, 21 Jul 2025 18:28:01 +0000
Date: Tue, 22 Jul 2025 02:27:21 +0800
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
	linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org
Subject: Re: [PATCH v1 4/7] phy: qualcomm: eusb2-repeater: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <202507220236.c4472GGM-lkp@intel.com>
References: <20250721075525.29636-5-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721075525.29636-5-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250718]
[cannot apply to jic23-iio/togreg sre-power-supply/for-next char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.16-rc7 v6.16-rc6 v6.16-rc5 v6.16-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/spmi-Implement-spmi_subdevice_alloc_and_add-and-devm-variant/20250721-155809
base:   next-20250718
patch link:    https://lore.kernel.org/r/20250721075525.29636-5-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v1 4/7] phy: qualcomm: eusb2-repeater: Migrate to devm_spmi_subdevice_alloc_and_add()
config: sparc-randconfig-002-20250721 (https://download.01.org/0day-ci/archive/20250722/202507220236.c4472GGM-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250722/202507220236.c4472GGM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507220236.c4472GGM-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "devm_spmi_subdevice_alloc_and_add" [drivers/phy/qualcomm/phy-qcom-eusb2-repeater.ko] undefined!
>> ERROR: modpost: "__devm_regmap_init_spmi_ext" [drivers/phy/qualcomm/phy-qcom-eusb2-repeater.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

