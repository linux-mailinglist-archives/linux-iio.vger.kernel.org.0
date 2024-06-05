Return-Path: <linux-iio+bounces-5809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7268FC525
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 09:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36021F25E9B
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 07:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AB818FDD0;
	Wed,  5 Jun 2024 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8OOAZNe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CF318FDB2;
	Wed,  5 Jun 2024 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573974; cv=none; b=BbjAXLrPoetyXiqM5Rj5Y1zHGOKGpRq/o6Q861/lkXa674GPtuiSrxWFpKQ3+RrVbl8ryqlrDXNRMekzHWkdIXVrxp/v/JiTeun3PqHSVCZHk3DVKLEXiTtdUvkcKRmgDs8gnsSInQoNFKNbf1cOL1UH6O8h052HVPVLhZ3B/HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573974; c=relaxed/simple;
	bh=KXkHFTvA4lOgG3pg/FBDDKuVPwHLIbPjM+awDwG4e30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBC/XiYH3ApXTx4F/vLnhxO2ayK+O1sdNGt+S7BKVV0yI2yjowJm9F3Ik9b5bCHazY7TuH26kyX2gA5JSDq9l57aNkPxhXfmG3hO19XKMTTURSxxClX1CtI0t5qTaknTkMkq9MxRf+3JmAJg3tlSPQR5859vq0WY5gZ4W0+fyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8OOAZNe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717573973; x=1749109973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KXkHFTvA4lOgG3pg/FBDDKuVPwHLIbPjM+awDwG4e30=;
  b=W8OOAZNeCAGpJZxU3gzjogl5MmVoRHEoJQJKSX/683Km461LuqmeggEk
   5kFO8kVNP9BaRJQj73NhkSug/B5l9I1tgL+ZQEOqjXUCGg1d2QsCQzwlp
   QHQgj0Mh5x17CemhDIoYsbDGfORda/XclvCP7Lj+g3GRYE0d4KC8gbDSt
   pcF2JzcuU54d5ryII6hHHI3M3uKomuil3TTM+8aSSg3c7Mxt6XGW+Ze+q
   1NeYSLg/sPCk6oVyT6pp6jIX8sdlge+90HBivEzfHUSnIVT6WpBdxSobG
   qjOpH7FC0SfuEinJriWBhYPOKDftzKT+n1qCVlKOdWNPy8RjjdDi0TLsx
   A==;
X-CSE-ConnectionGUID: mivbCTQRR/mOmEkep8L8Yg==
X-CSE-MsgGUID: AzhisaTYR/au4inJHwNS0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14380828"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14380828"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 00:52:52 -0700
X-CSE-ConnectionGUID: NA5hmVSrQjmJkHBy/IUV3g==
X-CSE-MsgGUID: gpswSGQ5RFK3VsV9fv9eNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="42450715"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 05 Jun 2024 00:52:49 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sElRu-00015G-1K;
	Wed, 05 Jun 2024 07:52:46 +0000
Date: Wed, 5 Jun 2024 15:51:51 +0800
From: kernel test robot <lkp@intel.com>
To: Mudit Sharma <muditsharma.info@gmail.com>, ivan.orlov0322@gmail.com,
	jic23@kernel.org, lars@metafoo.de, krzk+dt@kernel.org,
	conor+dt@kernel.org, robh@kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Mudit Sharma <muditsharma.info@gmail.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: light: ROHM BH1745 colour sensor
Message-ID: <202406051506.orRmnC3s-lkp@intel.com>
References: <20240603162122.165943-2-muditsharma.info@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603162122.165943-2-muditsharma.info@gmail.com>

Hi Mudit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.10-rc2 next-20240605]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mudit-Sharma/iio-light-ROHM-BH1745-colour-sensor/20240604-002405
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240603162122.165943-2-muditsharma.info%40gmail.com
patch subject: [PATCH v2 2/3] iio: light: ROHM BH1745 colour sensor
config: csky-randconfig-r112-20240605 (https://download.01.org/0day-ci/archive/20240605/202406051506.orRmnC3s-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240605/202406051506.orRmnC3s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406051506.orRmnC3s-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/light/bh1745.c:99:3: sparse: sparse: symbol 'bh1745_int_source' was not declared. Should it be static?
>> drivers/iio/light/bh1745.c:105:3: sparse: sparse: symbol 'bh1745_gain' was not declared. Should it be static?
>> drivers/iio/light/bh1745.c:114:3: sparse: sparse: symbol 'bh1745_measurement_time' was not declared. Should it be static?
>> drivers/iio/light/bh1745.c:121:3: sparse: sparse: symbol 'bh1745_presistence_value' was not declared. Should it be static?

vim +/bh1745_int_source +99 drivers/iio/light/bh1745.c

    93	
    94	enum {
    95		BH1745_INT_SOURCE_RED,
    96		BH1745_INT_SOURCE_GREEN,
    97		BH1745_INT_SOURCE_BLUE,
    98		BH1745_INT_SOURCE_CLEAR,
  > 99	} bh1745_int_source;
   100	
   101	enum {
   102		BH1745_ADC_GAIN_1X,
   103		BH1745_ADC_GAIN_2X,
   104		BH1745_ADC_GAIN_16X,
 > 105	} bh1745_gain;
   106	
   107	enum {
   108		BH1745_MEASUREMENT_TIME_160MS,
   109		BH1745_MEASUREMENT_TIME_320MS,
   110		BH1745_MEASUREMENT_TIME_640MS,
   111		BH1745_MEASUREMENT_TIME_1280MS,
   112		BH1745_MEASUREMENT_TIME_2560MS,
   113		BH1745_MEASUREMENT_TIME_5120MS,
 > 114	} bh1745_measurement_time;
   115	
   116	enum {
   117		BH1745_PRESISTENCE_UPDATE_TOGGLE,
   118		BH1745_PRESISTENCE_UPDATE_EACH_MEASUREMENT,
   119		BH1745_PRESISTENCE_UPDATE_FOUR_MEASUREMENT,
   120		BH1745_PRESISTENCE_UPDATE_EIGHT_MEASUREMENT,
 > 121	} bh1745_presistence_value;
   122	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

