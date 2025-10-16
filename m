Return-Path: <linux-iio+bounces-25123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA4FBE184E
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 07:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E1D42384A
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 05:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217D9FC0A;
	Thu, 16 Oct 2025 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXFWKT0K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D10018FDDB;
	Thu, 16 Oct 2025 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760592741; cv=none; b=T/nhVg87FxcozUGtQ07OQyGxcXPLzvJ0mS1qA4BOwRF873ry1RIaxNfWOGjEiNABV9ZQAcQD9i0qG0jwatWWBwRjM8SMm6650+IxOopSlohEmNKgBWA1TCC1NpC+FqreJgMWRwDfDU3o/yRKNKq6UsJKYIQAb65tFyCgAMF2nkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760592741; c=relaxed/simple;
	bh=TBbpxuU3ACNBQDvKO3TXR8fbPiyLMy+JmMmNGMrbv4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQUK7bf+NHXrtqKxDroyfu6gSGTg0QTCjyRR46f63+iYDk0+xNmN1OjrSm3VnOgqRSTJaXrsImgAsKNVFBl5fLTmNJKFPCm97zWVD3wUBmSkAOtq3ha/QmlaLWVqHKqOtEUdxi1cPJ4fS33k1Z1gPVClhRadyUuxpFFK41FnCWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CXFWKT0K; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760592740; x=1792128740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TBbpxuU3ACNBQDvKO3TXR8fbPiyLMy+JmMmNGMrbv4s=;
  b=CXFWKT0KbLoMdrRGF1xn24bD0ofUtAp1Hg/Ts7C1WXtYMw6PUlDKPj/b
   orWuG21GqiUMSR1gGIa49C0+UDM8Dr51aFLTBsHGStZmMi/bT7DH1feQl
   6vcCClSGNEQwp8hLiIthTBSxn2/nfDAHPCq6xW1dRroZgEtE42TAtpgeW
   hAjSv9coNYWlwRg0T5anG3Aq/TnxI4XLL6ynTum6qPDfb/UGeeTLsuLP1
   HDD0X+4VZpiVKcLilV4RlfPVCvQIUAAgvL7rnkE4Ng7IjifbmtLqUvAyN
   ar1x9iH/hv2EadaK1aNu6oBBDsecI4g4jL1VsPxj0wvV8Sv+XyuEFYU3V
   A==;
X-CSE-ConnectionGUID: l8pe//YERPuKV2U8Xs6zUw==
X-CSE-MsgGUID: 4LzMhXP5Q1C/W4330Eir0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="50342466"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="50342466"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 22:32:20 -0700
X-CSE-ConnectionGUID: zteQvLb8QV249gk9yds1OA==
X-CSE-MsgGUID: uQ4vq3GFRPeFopW52oQmQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; 
   d="scan'208";a="187451974"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 15 Oct 2025 22:32:16 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9Gax-0004Tn-1U;
	Thu, 16 Oct 2025 05:32:12 +0000
Date: Thu, 16 Oct 2025 13:31:14 +0800
From: kernel test robot <lkp@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ariana Lazar <ariana.lazar@microchip.com>
Subject: Re: [PATCH 2/2] iio: adc: adding support for PAC1711
Message-ID: <202510161332.ntymBLFJ-lkp@intel.com>
References: <20251015-pac1711-v1-2-976949e36367@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-pac1711-v1-2-976949e36367@microchip.com>

Hi Ariana,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 19272b37aa4f83ca52bdf9c16d5d81bdd1354494]

url:    https://github.com/intel-lab-lkp/linux/commits/Ariana-Lazar/dt-bindings-iio-adc-adding-support-for-PAC1711/20251016-002337
base:   19272b37aa4f83ca52bdf9c16d5d81bdd1354494
patch link:    https://lore.kernel.org/r/20251015-pac1711-v1-2-976949e36367%40microchip.com
patch subject: [PATCH 2/2] iio: adc: adding support for PAC1711
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20251016/202510161332.ntymBLFJ-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251016/202510161332.ntymBLFJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510161332.ntymBLFJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/pac1711.c:459:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     459 |         if (time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     460 |                         msecs_to_jiffies(PAC1711_MIN_POLLING_TIME_MS))) {
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/jiffies.h:128:2: note: expanded from macro 'time_after'
     128 |         (typecheck(unsigned long, a) && \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     129 |          typecheck(unsigned long, b) && \
         |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     130 |          ((long)((b) - (a)) < 0))
         |          ~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/pac1711.c:473:9: note: uninitialized use occurs here
     473 |         return ret;
         |                ^~~
   drivers/iio/adc/pac1711.c:459:2: note: remove the 'if' if its condition is always true
     459 |         if (time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     460 |                         msecs_to_jiffies(PAC1711_MIN_POLLING_TIME_MS))) {
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/pac1711.c:453:9: note: initialize the variable 'ret' to silence this warning
     453 |         int ret;
         |                ^
         |                 = 0
>> drivers/iio/adc/pac1711.c:1124:29: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
    1124 |                 return dev_err_probe(dev, ret, "shunt-resistor property does not exist\n");
         |                                           ^~~
   drivers/iio/adc/pac1711.c:1116:9: note: initialize the variable 'ret' to silence this warning
    1116 |         int ret, temp;
         |                ^
         |                 = 0
   2 warnings generated.


vim +459 drivers/iio/adc/pac1711.c

   449	
   450	static int pac1711_retrieve_data(struct pac1711_chip_info *info,
   451					 u32 wait_time)
   452	{
   453		int ret;
   454	
   455		/*
   456		 * check if the minimal elapsed time has passed and if so,
   457		 * re-read the chip, otherwise the cached info is just fine
   458		 */
 > 459		if (time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
   460				msecs_to_jiffies(PAC1711_MIN_POLLING_TIME_MS))) {
   461			ret = pac1711_reg_snapshot(info, true, PAC1711_REFRESH_REG_ADDR,
   462						   wait_time);
   463	
   464			/*
   465			 * Re-schedule the work for the read registers timeout
   466			 * (to prevent chip regs saturation)
   467			 */
   468			cancel_delayed_work_sync(&info->work_chip_rfsh);
   469			schedule_delayed_work(&info->work_chip_rfsh,
   470					      msecs_to_jiffies(PAC1711_MAX_RFSH_LIMIT_MS));
   471		}
   472	
   473		return ret;
   474	}
   475	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

