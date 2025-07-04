Return-Path: <linux-iio+bounces-21363-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5EDAF994C
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 18:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E603A564DEF
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 16:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A431922ED;
	Fri,  4 Jul 2025 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFZ/BT63"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5332E3713;
	Fri,  4 Jul 2025 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751647762; cv=none; b=lmt2Ew+VskIueyF4Iy/x2j/2k57UMMTkmkCZvDCySSDazd7iEeX2km9b5R+qOmIkxO5w+IKwIG9crUA9+7/NEL2jgqMqJsNsAY4dDNZsstgigZFothjiFfDKpJ5TCyyfzgde5MG0IO5p2TLsxhm/qd35oKQ1XFncw+bkwT/hvEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751647762; c=relaxed/simple;
	bh=puHH8ECd9Sx/irwJXMzsitFTk8LHZcjscwcNGu8zkdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQyGKtj2vyYiHEvq9Ni5RwcitAfzEj1s7GjI37lGwuPszzBB5w486xFLT6Ajxhuc91ox3un4EJ6BKeqF67Yd0KdWEOWt+BiEH4gTXAqF7ukmkSJBzgKZq/Z7k/wiGJvbbjhkdYReDOf2n0yinMrO3uHL2A8jsU1E2zjhE2bKG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFZ/BT63; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751647761; x=1783183761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=puHH8ECd9Sx/irwJXMzsitFTk8LHZcjscwcNGu8zkdY=;
  b=iFZ/BT630kF1nhbBvR3rSbSaVpMDVPyPrTRsR2Tv6HIDJYv+G6Z6YAs5
   FRS+AeOwp7d6RuQPAB/YbiyECxBLQMxTMGLkQI/ABq5xvRwByeyaefDBG
   IiqEQ/ZquQv/ZNF7zwGYt5oaiY92iQdxE+q3K8kdl8QYvUkyMJtBxy2ms
   fOwGBHuM7SjLts/X4usEfwA4YvBbt4zIBw0tdXLEVvL6suoH5rr/Q7Bvq
   pOj3wM47VsMJmYdoo6yB6nxzXlcdFMU5Qe/a0aa5deamc3ktrgwZX8Wel
   7rHJH8WiVmAkTAGV9Rn5YBZv6ysoZDl+RRa+pCoz5FEVn6H8ZjflMhXBs
   g==;
X-CSE-ConnectionGUID: AyPKRu6qQZSxurKVI+c+zw==
X-CSE-MsgGUID: IaAbDfc6QeStQfiS2biYhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="53906725"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="53906725"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 09:49:20 -0700
X-CSE-ConnectionGUID: hh78nC4/RxamdFREw94QKw==
X-CSE-MsgGUID: j1mvSA1MTJatPNxSE0N18A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="160202579"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 04 Jul 2025 09:49:18 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXjbA-0003vL-02;
	Fri, 04 Jul 2025 16:49:16 +0000
Date: Sat, 5 Jul 2025 00:48:47 +0800
From: kernel test robot <lkp@intel.com>
To: David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH] iio: adc: ad7173: fix num_slots on most chips
Message-ID: <202507050018.iWEJiG04-lkp@intel.com>
References: <20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-v1-1-326c5d113e15@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-v1-1-326c5d113e15@baylibre.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6742eff60460e77158d4f1b233f17e0345c9e66a]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-adc-ad7173-fix-num_slots-on-most-chips/20250704-061744
base:   6742eff60460e77158d4f1b233f17e0345c9e66a
patch link:    https://lore.kernel.org/r/20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-v1-1-326c5d113e15%40baylibre.com
patch subject: [PATCH] iio: adc: ad7173: fix num_slots on most chips
config: x86_64-buildonly-randconfig-004-20250704 (https://download.01.org/0day-ci/archive/20250705/202507050018.iWEJiG04-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250705/202507050018.iWEJiG04-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507050018.iWEJiG04-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/adc/ad7173.c:782:3: error: field designator 'supports_spi_offload' does not refer to any field in type 'const struct ad_sigma_delta_info'
     782 |         .supports_spi_offload = true,
         |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +782 drivers/iio/adc/ad7173.c

   773	
   774	static const struct ad_sigma_delta_info ad7173_sigma_delta_info_16_slots = {
   775		.set_channel = ad7173_set_channel,
   776		.append_status = ad7173_append_status,
   777		.disable_all = ad7173_disable_all,
   778		.disable_one = ad7173_disable_one,
   779		.set_mode = ad7173_set_mode,
   780		.has_registers = true,
   781		.has_named_irqs = true,
 > 782		.supports_spi_offload = true,
   783		.addr_shift = 0,
   784		.read_mask = BIT(6),
   785		.status_ch_mask = GENMASK(3, 0),
   786		.data_reg = AD7173_REG_DATA,
   787		.num_resetclks = 64,
   788		.num_slots = 16,
   789	};
   790	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

