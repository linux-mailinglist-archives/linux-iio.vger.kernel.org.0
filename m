Return-Path: <linux-iio+bounces-26844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC44CAABFE
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 19:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 299153058A4B
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 18:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7505E2D063F;
	Sat,  6 Dec 2025 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCZmI1Xg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF662C0277;
	Sat,  6 Dec 2025 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765044782; cv=none; b=aF3989fBM6HEeieNIVVpEFQ2KZLkVeRKDWIvnsXy8j0v/g6j1y5jRhyIc4vdODexDH357PX3TePL0bMhlNRed+4cvjV6XA9HbXNDPuVRpxhZZVMXQ1dd2cHdJLW2q2tCAQ4QcH0s035Qt4XR5CpSQRLLj8DC2rJhP/bXjOG4D/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765044782; c=relaxed/simple;
	bh=kCo7TwIyMLY2ilQAhmmpV3lTsDPNLDcGia+hEOeSTPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pb+8JuTJgM/ZHJcF7EFp5dNpV0KbbQBgiYfkv1Wnz0uvuy2MqPB4KhIymkgqMB5p9506Z7eb0ISe2GNIxnHkd0bmoVjtkjnxWVVgnxlXfqsR/uInUpaT/Fa95QLkA7vzq+7PE8msOKA1vrJlX5NcdZO8X6K4/GnxxKRRSBBmkzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCZmI1Xg; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765044780; x=1796580780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kCo7TwIyMLY2ilQAhmmpV3lTsDPNLDcGia+hEOeSTPo=;
  b=HCZmI1Xg2aWgz82kAfoRnwTDkM5b5yPzf73vgXKYf2I7bC8NiSEWH80N
   qbYUzq60SdZdpS7IC2XW14i1dvfSUioGwXjnIu9dXzequBNVPlkPoUmCy
   HO2iksN9x1pQF5oH40Lqi1wfB1HFtCuDDQhZo7FHtcceAnI8z52vffLCk
   h1ipaF3rKFaeOxySjCqG5OXlbRYJ060HyTTlrTjRD9AtgapojxfTbEBW4
   0hQ3D0YlZKQV0obU07xXSiUv1l0D7b/1s+qiAd1BPR3/ubLhod8/XHF/I
   QZrWB0JrOORIvP42zDyb6osu2nx3Mr5ZOJB7dX8g227UHQ0vdIAmTgNnA
   Q==;
X-CSE-ConnectionGUID: +uPWy7b2RWGrqvleFgIPVg==
X-CSE-MsgGUID: 3sAkXfKrRYi4mQygs735Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11634"; a="89705080"
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="89705080"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 10:12:59 -0800
X-CSE-ConnectionGUID: siryojLKTiibF0Z05mjuMA==
X-CSE-MsgGUID: YozxOX6RQjei05+UdbIPBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="200013896"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 06 Dec 2025 10:12:55 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vRwm4-00000000Iev-1bop;
	Sat, 06 Dec 2025 18:12:52 +0000
Date: Sun, 7 Dec 2025 02:12:30 +0800
From: kernel test robot <lkp@intel.com>
To: Jorge Marques <jorge.marques@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Jorge Marques <jorge.marques@analog.com>
Subject: Re: [PATCH v3 3/9] iio: adc: Add support for ad4062
Message-ID: <202512070145.nkD9ROxx-lkp@intel.com>
References: <20251205-staging-ad4062-v3-3-8761355f9c66@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205-staging-ad4062-v3-3-8761355f9c66@analog.com>

Hi Jorge,

kernel test robot noticed the following build errors:

[auto build test ERROR on f9e05791642810a0cf6237d39fafd6fec5e0b4bb]

url:    https://github.com/intel-lab-lkp/linux/commits/Jorge-Marques/dt-bindings-iio-adc-Add-adi-ad4062/20251206-033708
base:   f9e05791642810a0cf6237d39fafd6fec5e0b4bb
patch link:    https://lore.kernel.org/r/20251205-staging-ad4062-v3-3-8761355f9c66%40analog.com
patch subject: [PATCH v3 3/9] iio: adc: Add support for ad4062
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20251207/202512070145.nkD9ROxx-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251207/202512070145.nkD9ROxx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512070145.nkD9ROxx-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/adc/ad4062.c:762:49: error: initializer element is not a compile-time constant
           I3C_DEVICE(AD4062_I3C_VENDOR, ad4060_chip_info.prod_id, &ad4060_chip_info),
                                         ~~~~~~~~~~~~~~~~~^~~~~~~
   include/linux/i3c/device.h:151:14: note: expanded from macro 'I3C_DEVICE'
                   .part_id = _partid,                                     \
                              ^~~~~~~
   1 error generated.


vim +762 drivers/iio/adc/ad4062.c

   760	
   761	static const struct i3c_device_id ad4062_id_table[] = {
 > 762		I3C_DEVICE(AD4062_I3C_VENDOR, ad4060_chip_info.prod_id, &ad4060_chip_info),
   763		I3C_DEVICE(AD4062_I3C_VENDOR, ad4062_chip_info.prod_id, &ad4062_chip_info),
   764		{ }
   765	};
   766	MODULE_DEVICE_TABLE(i3c, ad4062_id_table);
   767	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

