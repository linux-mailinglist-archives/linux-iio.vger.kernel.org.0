Return-Path: <linux-iio+bounces-5736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 152AF8FAE76
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 11:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FB7286EA4
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 09:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86FE14430C;
	Tue,  4 Jun 2024 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZ/d6+Zf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9FB143C6F;
	Tue,  4 Jun 2024 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492308; cv=none; b=DsssOr7VN8TeKABJJpywagEJ94vYMMzjyzjbyH1CslTirOMaXnRy/Q8mDlwdrTwBQUyPMBj/6FjCDF1scWIGTc3QwkwNFVPciaFJE8Y2evCHgvbjZrziW51+Hyfu9P0GVN90XikeBLixubUdsH/RtaJ7jFwwDeJIHhLfcU7vg5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492308; c=relaxed/simple;
	bh=ImJhbNsrIco+qebnToiezXtyMfSwI41zKI18NzCQA3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KS+BymIXs6rynMfG+Zs6QeisCJ8YoPRk3i1vdyLO+O2MPW1LxPMD7f1ostyg0tRdOJHKev/XoTngWCDWHXRWOUde9M42KKWac2yrvwVhgUgGYpxP9ChdRw39oQynyqKZHUKQ4IOkyQJSaGHP+GjNL2k6PJnAtT5d8T5WWejtCXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZ/d6+Zf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717492307; x=1749028307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ImJhbNsrIco+qebnToiezXtyMfSwI41zKI18NzCQA3A=;
  b=kZ/d6+ZfxrE5VP8Vymde6mxBJYlXIP0c3RKwijGsq/jcN4DqJXicb4+d
   xRE0/emWGyH2j9Hz7pwKV3ojWLsdy4RchHXmwDAO07yCuZMa2pFvXQfue
   w03XCJiZ0oYZ3CxX60XqehDpDVrZpliBmWAVQbbnv0wtTkfT7+puIK1jM
   j18PSEI18lL5ECfUoEMYzNL2ytS400E+6E7/vg+cRL/Um1V8n/Rh5ntVz
   vUQdeRiNEZj44UvSJG6o2o5Sk0h3psjIv2IarvXT7VcYG305OLS3PsuHI
   WLYcCnq/MlEWU8pNuaYWkdv/95py6FjTij/QckQy6DpUUwByskM3aLnV/
   Q==;
X-CSE-ConnectionGUID: 3rGwVxPCT8iffda50Lbf3g==
X-CSE-MsgGUID: 2ZEx3e0xTMO4b4Z3nwIXJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17854993"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="17854993"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 02:11:45 -0700
X-CSE-ConnectionGUID: UTy3s7lEQtCIAKPlMIJ4mw==
X-CSE-MsgGUID: xOhWAYg1T8Kfg7RJFjH19g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37299303"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 04 Jun 2024 02:11:41 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEQCg-000MzT-1r;
	Tue, 04 Jun 2024 09:11:38 +0000
Date: Tue, 4 Jun 2024 17:10:52 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Hewitt <christianshewitt@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] iio: adc: meson: add support for the GXLX SoC
Message-ID: <202406041751.elQWr6cj-lkp@intel.com>
References: <20240604055431.3313961-2-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604055431.3313961-2-christianshewitt@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v6.10-rc2 next-20240604]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Hewitt/iio-adc-meson-add-support-for-the-GXLX-SoC/20240604-135606
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240604055431.3313961-2-christianshewitt%40gmail.com
patch subject: [PATCH 2/2] iio: adc: meson: add support for the GXLX SoC
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240604/202406041751.elQWr6cj-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240604/202406041751.elQWr6cj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406041751.elQWr6cj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/adc/meson_saradc.c:1262:18: error: use of undeclared identifier 'VREF_VOLTAGE_1V8'
           .vref_voltage = VREF_VOLTAGE_1V8,
                           ^
   1 error generated.


vim +/VREF_VOLTAGE_1V8 +1262 drivers/iio/adc/meson_saradc.c

  1255	
  1256	static const struct meson_sar_adc_param meson_sar_adc_gxlx_param = {
  1257		.has_bl30_integration = true,
  1258		.clock_rate = 1200000,
  1259		.regmap_config = &meson_sar_adc_regmap_config_gxbb,
  1260		.resolution = 12,
  1261		.disable_ring_counter = 1,
> 1262		.vref_voltage = VREF_VOLTAGE_1V8,
  1263		.cmv_select = true,
  1264		.mpll_clock_bits = true,
  1265	};
  1266	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

