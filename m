Return-Path: <linux-iio+bounces-19954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C89EAC4478
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 22:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8823172295
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 20:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0342723E325;
	Mon, 26 May 2025 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lpw4mthy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EFE1607AC;
	Mon, 26 May 2025 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748291682; cv=none; b=RnGLZERMOXrukBH6cHHOFVGxUOmBBseUr3e8G/LytfQXUXdBIbWovhhBrhTceKLen1A6baVU6bBnf76cjhWlTyOGXSsm2c2A5KqW78QCSNjjIBr8QhaLj7YMs+VLJuwz6YldV076UPvT0Cc86/joko/mtO34gZDWzfi9cfAceSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748291682; c=relaxed/simple;
	bh=T40zv2BAbAAN5c8Kb2iLFjCSDe/dOZ4P0aid1xJ+yWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPgAHXei+rr3rwaol4cz/LMHdomA0nEgvbzvVRcFih1xqv69ep2r7vDqRTJQcm3k2w4mfUyBtOchcYrbOq9ZXhJbc/yMsNIsr7D0OMFvCwB9dc1pL6nXCo7bFTRBMvOtXAeZ1HU55SaEbVRyxj4x+4ajbs8DK/EXXv5d1tSBhew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lpw4mthy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748291681; x=1779827681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T40zv2BAbAAN5c8Kb2iLFjCSDe/dOZ4P0aid1xJ+yWk=;
  b=Lpw4mthyXX99j6o6Aa9e3Yrhu31IWXlY4YnO5zz++dd3XyWiaeF+7/6O
   towjigPg61CYmbQdGxU6uHoXGIdVeeFWxHkEsplpGqKVWlzb0K4H8604B
   MSynP9HXZdnEdI1acTkInFfvcFJNHph44gtHNhlBU2ZjFDurSWXFC4TMR
   wWTmeF1huTeth+WqGlE7hBSJD1+GgYzoBejD3LgcgmzhrQjGyKIzp72Wm
   y6J1sgvrm3MOMufiZ/MUdSQao5e/+w24CoxqnDbpM5FJovrN0abNQDCaj
   lCbCxQFMoDGSMAj2+PEy3Z0TFWDXxaE2J0a2XDQdfOxjlIBSmjBpLUsCG
   A==;
X-CSE-ConnectionGUID: /LTgkgTqQzerOU38DCNQvw==
X-CSE-MsgGUID: MSYZ78FsR6O5XZAH8RKOnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="54076956"
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; 
   d="scan'208";a="54076956"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 13:34:40 -0700
X-CSE-ConnectionGUID: thHqHVQNTF6ZChP9KB98xw==
X-CSE-MsgGUID: S+67gckpT0q9fyK79kpnpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; 
   d="scan'208";a="147746767"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 26 May 2025 13:34:36 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uJeWn-000ShA-25;
	Mon, 26 May 2025 20:34:33 +0000
Date: Tue, 27 May 2025 04:34:27 +0800
From: kernel test robot <lkp@intel.com>
To: Claudiu <claudiu.beznea@tuxon.dev>, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, len.brown@intel.com,
	pavel@kernel.org, ulf.hansson@linaro.org, jic23@kernel.org,
	daniel.lezcano@linaro.org, dmitry.torokhov@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	bhelgaas@google.com, geert@linux-m68k.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 1/2] PM: domains: Add devres variant for
 dev_pm_domain_attach()
Message-ID: <202505270434.ft8ekK9H-lkp@intel.com>
References: <20250526122054.65532-2-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526122054.65532-2-claudiu.beznea.uj@bp.renesas.com>

Hi Claudiu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v6.15 next-20250526]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Claudiu/PM-domains-Add-devres-variant-for-dev_pm_domain_attach/20250526-202318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250526122054.65532-2-claudiu.beznea.uj%40bp.renesas.com
patch subject: [PATCH v2 1/2] PM: domains: Add devres variant for dev_pm_domain_attach()
config: arm-randconfig-002-20250527 (https://download.01.org/0day-ci/archive/20250527/202505270434.ft8ekK9H-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250527/202505270434.ft8ekK9H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505270434.ft8ekK9H-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/amba/bus.c:15:0:
>> include/linux/pm_domain.h:534:12: warning: 'devm_pm_domain_attach' defined but not used [-Wunused-function]
    static int devm_pm_domain_attach(struct device *dev, bool attach_power_on,
               ^~~~~~~~~~~~~~~~~~~~~


vim +/devm_pm_domain_attach +534 include/linux/pm_domain.h

   533	
 > 534	static int devm_pm_domain_attach(struct device *dev, bool attach_power_on,
   535					 bool detach_power_off)
   536	{
   537		return 0;
   538	}
   539	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

