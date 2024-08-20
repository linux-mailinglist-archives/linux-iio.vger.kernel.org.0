Return-Path: <linux-iio+bounces-8627-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B50957CCD
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 07:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A832839CD
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 05:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DFA1442F2;
	Tue, 20 Aug 2024 05:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSopL9aC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9EE136672;
	Tue, 20 Aug 2024 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724132245; cv=none; b=KhI8E+G4Kpb7sAFo8r2L2NfjKSSKFzxAL80y02IxJ4Gr65d0ECE3HMBhwjpjhdKDnor9oLSleOh6AqgY1KeAxprAjUR0qZef3Y/ZY9Y8r5fMrbabjFkjah7vrVmwFY1rJqpOHQwPKqyMqBrCCE8iC4ZD0sketckHUHDiEXSLYnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724132245; c=relaxed/simple;
	bh=UTDilvLJBoUy3712767wYi1ysEYam3UQ+yO9j2wCBkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQBU7ou/kCtOXxqg1Aumsf+lGlnjYz+i3cXkTr96ylfGTXZwmwE44tLWOtQ3KRzeL5Ze/tdxHhxSaQlV84nVEX55NH1r4YbreprrgrBAgsHYm543/JfSpktNVHt2UlS5uVDXmm+tdwiqXSo0HXT7KryxJOlsu7Mk45uLGL5IHQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSopL9aC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724132244; x=1755668244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTDilvLJBoUy3712767wYi1ysEYam3UQ+yO9j2wCBkE=;
  b=OSopL9aCFIGgn6sVWZtjdpeGNFkDeQJM93oUZ2x02tkSJTSu5hELQ9SF
   MUpPzuZuIJ2kMYqIestiHIlUMN7b+xj7pjN/ItJvtQmH5cT8QxMPBtnCQ
   p/y/fiiMpTLW9wD5YVAs1yiweUNU8ZwBa7vhANcMJEl5YNi16OYOrjNpx
   hVqJ77dKDFI+uXPT7VYOFmfe3KvVJbdVvCRL3qa/UgZY8OSBlTNLVDTbT
   /LFBHA+n7qlKd/Mu39BR77MEI7J8/F2V1HLbjPcCyReMAbmPadzZq6o6/
   YYOkfdi3rW+ZX+HO2mk/fLGPfGY9FqAuZmyYVwa18KHXqMKSptYGUHsnc
   w==;
X-CSE-ConnectionGUID: dC2a9wiuQFCc2569mQ65ZA==
X-CSE-MsgGUID: muN1eP99QwaCziufa35HtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26162045"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="26162045"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 22:37:23 -0700
X-CSE-ConnectionGUID: Y3sTV+jFQUSBHDv1P9yb9w==
X-CSE-MsgGUID: EyUAhAZNSVWeIzdqbHBRAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60756700"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 19 Aug 2024 22:37:18 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgHYR-0009lQ-26;
	Tue, 20 Aug 2024 05:37:15 +0000
Date: Tue, 20 Aug 2024 13:37:02 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>, linux-sunxi@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, quentin.schulz@free-electrons.com,
	mripard@kernel.org, tgamblin@baylibre.com,
	aidanmacdonald.0x0@gmail.com, u.kleine-koenig@pengutronix.de,
	lee@kernel.org, samuel@sholland.org, jernej.skrabec@gmail.com,
	sre@kernel.org, wens@csie.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
	jic23@kernel.org, jonathan.cameron@huawei.com,
	Chris Morgan <macromorgan@hotmail.com>,
	Philippe Simons <simons.philippe@gmail.com>
Subject: Re: [PATCH V3 14/15] power: supply: axp20x_battery: add support for
 AXP717
Message-ID: <202408201232.lgLOd5Nu-lkp@intel.com>
References: <20240819164619.556309-15-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819164619.556309-15-macroalpha82@gmail.com>

Hi Chris,

kernel test robot noticed the following build errors:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on jic23-iio/togreg lee-mfd/for-mfd-next linus/master v6.11-rc4 next-20240819]
[cannot apply to lee-mfd/for-mfd-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Morgan/iio-adc-axp20x_adc-Add-adc_en1-and-adc_en1-to-axp_data/20240820-005144
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20240819164619.556309-15-macroalpha82%40gmail.com
patch subject: [PATCH V3 14/15] power: supply: axp20x_battery: add support for AXP717
config: arc-randconfig-001-20240820 (https://download.01.org/0day-ci/archive/20240820/202408201232.lgLOd5Nu-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240820/202408201232.lgLOd5Nu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408201232.lgLOd5Nu-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/power/supply/axp20x_battery.c: In function 'axp717_get_constant_charge_current':
>> drivers/power/supply/axp20x_battery.c:266:16: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     266 |         *val = FIELD_GET(AXP717_ICC_CHARGER_LIM_MASK, *val) *
         |                ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_GET +266 drivers/power/supply/axp20x_battery.c

   256	
   257	static int axp717_get_constant_charge_current(struct axp20x_batt_ps *axp,
   258						      int *val)
   259	{
   260		int ret;
   261	
   262		ret = regmap_read(axp->regmap, AXP717_ICC_CHG_SET, val);
   263		if (ret)
   264			return ret;
   265	
 > 266		*val = FIELD_GET(AXP717_ICC_CHARGER_LIM_MASK, *val) *
   267			axp->data->ccc_scale;
   268	
   269		return 0;
   270	}
   271	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

