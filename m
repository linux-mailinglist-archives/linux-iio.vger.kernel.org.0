Return-Path: <linux-iio+bounces-8625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0B2957C62
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 06:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8296E284EEC
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 04:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD6153368;
	Tue, 20 Aug 2024 04:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iBrG3K7A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351C02F5E;
	Tue, 20 Aug 2024 04:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724127985; cv=none; b=S39Hg/+GGjl1lE4H3tjBezQ+x6d3CxXp+YMcIACj/Qg7FbLodNsf19zityygV1WREfU6WxNHT3A9lL1DpGEuldknfGaj/ZsHPjd5J7S76n+31Du0o31TMZEY7Q5w8U/Uxy57iuge8ZDMnaEcYIq/34iVIdj/RL1YcEzQJegARnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724127985; c=relaxed/simple;
	bh=EPhEMjY7bJqv3OgXaq6MdbBJoS9xZMpbdW6dSGjRQqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxQ4ti0gkbGNlBYArUZ87jH2locsFnSkVyunEw+8zIQJdiwxrAzSTMa3XfhLjf71jXLoBWo7sge/28Ouhz9KVIrVtFlNyRzC6WtQ5/RKg/jutXjvXuHdeM3POKaFOiZTe4Wz+TIZQ4roJnJkDOYtDLIsuzLyP5ZQ75tkzt5+1cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iBrG3K7A; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724127982; x=1755663982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EPhEMjY7bJqv3OgXaq6MdbBJoS9xZMpbdW6dSGjRQqs=;
  b=iBrG3K7A5D1E/CklMiQ12vUS7a5QE8cGpQ8TxvNnXfZrwt9uwZSVhvw3
   OEWDv50s1idnyfRXGr8yGc7Fu9gQCyznYsEH2YZn18YjNkFn17C8RRaae
   oWu8IUl8/sC0F+lHS5NCEbzSaIFR+81Agug/MPUobtmKEdsM5fc3Uajdz
   MXE/OvMW5RzIx72DrCcr30lV2CUbKhKthaKcd0iPzzZ6Dl2QbE/GRyaLh
   1gCfRCFNWcmrP46jJoFjLf/nSLpF7vci76mbFmYuTVbbGYq8Kfc4aeM5F
   gsnzwX8NpKTA59D/PF8Q3ADMkNK3NtnxuwVVzN+ZhqOXH0bt+BDYDhQkg
   g==;
X-CSE-ConnectionGUID: OKITTNVIQXKCvtCu1q9+PA==
X-CSE-MsgGUID: ZZBWsr05QAaBfy9R7dhq1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22543924"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22543924"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 21:26:21 -0700
X-CSE-ConnectionGUID: 5fcy/7axQQSIx4VehcG9EA==
X-CSE-MsgGUID: fXqC33NVTqWsQaFZeFxYKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60284429"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 19 Aug 2024 21:26:15 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgGRh-0009iQ-1k;
	Tue, 20 Aug 2024 04:26:13 +0000
Date: Tue, 20 Aug 2024 12:25:45 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>, linux-sunxi@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	quentin.schulz@free-electrons.com, mripard@kernel.org,
	tgamblin@baylibre.com, aidanmacdonald.0x0@gmail.com,
	u.kleine-koenig@pengutronix.de, lee@kernel.org, samuel@sholland.org,
	jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	lars@metafoo.de, jic23@kernel.org, jonathan.cameron@huawei.com,
	Chris Morgan <macromorgan@hotmail.com>,
	Philippe Simons <simons.philippe@gmail.com>
Subject: Re: [PATCH V3 14/15] power: supply: axp20x_battery: add support for
 AXP717
Message-ID: <202408201228.Hee4eSYl-lkp@intel.com>
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
config: i386-buildonly-randconfig-005-20240820 (https://download.01.org/0day-ci/archive/20240820/202408201228.Hee4eSYl-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240820/202408201228.Hee4eSYl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408201228.Hee4eSYl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/power/supply/axp20x_battery.c:266:9: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     266 |         *val = FIELD_GET(AXP717_ICC_CHARGER_LIM_MASK, *val) *
         |                ^
   drivers/power/supply/axp20x_battery.c:439:17: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     439 |                 val->intval = FIELD_GET(AXP717_PWR_OP_BATT_PRESENT, reg);
         |                               ^
   2 errors generated.


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

