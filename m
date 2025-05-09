Return-Path: <linux-iio+bounces-19379-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF36AB1276
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 13:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827BA4A6404
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 11:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C802128FFF2;
	Fri,  9 May 2025 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0pp0+mq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B5428FFD9;
	Fri,  9 May 2025 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791173; cv=none; b=JV/pusjSo2aodJMDCY0ygiJoVX+Rt1ivU4Q/kirmQ79RIPuN8GNE8RxdtXE0rlIc07DBHqhwZEaU7kP2W9jrIHQr8kLYJdx49cOg1GxgChND6ETm0CyyxP+xNg212b8eCYF6vB+rkdP3ONrJsJQf3mdWkUIzN0P4EWekurCyjlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791173; c=relaxed/simple;
	bh=SQkxBRiOnv36QIXTxodgUMy2H7LsOL+7k7SNq2aq4AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3QxvE3phjxX/dDrxolhaPQf9yM/KCR7vLh5/6EtHK6b7tdmgC+HLYOtPFftvZIzlbp1MVhC2xmssvyVATsM1/N1Z4pCoHPt2N6ZdEggQwZOFPu+6OC9y100XevQDqbKTBeufo+ZQ+GdfThiVpG3Bg0nleOm4z23xfaq9gNWxEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0pp0+mq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746791172; x=1778327172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SQkxBRiOnv36QIXTxodgUMy2H7LsOL+7k7SNq2aq4AA=;
  b=B0pp0+mqumq49Z72cQmahfiBvCMkxhK/hNo6FF/3O8VEPfcMnrrrTmHL
   bl+V4dVE6mJGHSDY4sFFs3WA2kBMxuyJ87pdkYbvXQ4iLUxckehCah/e8
   2kHXhiRkgGvSiwmdeG57buTCZkDUumhCWMhxcNsvI1PSOElVST6i3JuVo
   kiIup89OxRF9SnvJXlJUlnpz+S3Uwrs4EGXHuxJ4lKJSA4iupI9Mfh8F5
   z0yLBKdPnibk73IjwS4YZ2FY8v2f6q7Ef/SI3ShTb+tgv61hlxzHdMfZr
   LxZe4cgSprkexNehBqz+B5DIqyG3kG7Ve59mtrdC86DYDEKRANQBWAT/t
   g==;
X-CSE-ConnectionGUID: zf+DzwbSSt+KRmzjh64gbw==
X-CSE-MsgGUID: ibWD3MAXQJqwiJpWxsqvsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48774461"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="48774461"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 04:46:12 -0700
X-CSE-ConnectionGUID: tSopib0KRZm1vWrW42CKjw==
X-CSE-MsgGUID: hEhG9rRhT3+uXvkH80Z+bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="141816422"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 09 May 2025 04:46:07 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDMB2-000C1r-1U;
	Fri, 09 May 2025 11:46:04 +0000
Date: Fri, 9 May 2025 19:45:31 +0800
From: kernel test robot <lkp@intel.com>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 4/4] iio: adc: ad7405: add ad7405 driver
Message-ID: <202505091958.k0P7xNyC-lkp@intel.com>
References: <20250508123107.3797042-5-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508123107.3797042-5-pop.ioan-daniel@analog.com>

Hi Pop,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.15-rc5 next-20250508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pop-Ioan-Daniel/iio-backend-update-iio_backend_oversampling_ratio_set/20250508-203339
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250508123107.3797042-5-pop.ioan-daniel%40analog.com
patch subject: [PATCH v2 4/4] iio: adc: ad7405: add ad7405 driver
config: m68k-randconfig-r123-20250509 (https://download.01.org/0day-ci/archive/20250509/202505091958.k0P7xNyC-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.3.0
reproduce: (https://download.01.org/0day-ci/archive/20250509/202505091958.k0P7xNyC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505091958.k0P7xNyC-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/adc/ad7405.c:19:20: sparse: sparse: symbol 'ad7405_dec_rates' was not declared. Should it be static?

vim +/ad7405_dec_rates +19 drivers/iio/adc/ad7405.c

    18	
  > 19	const unsigned int ad7405_dec_rates[] = {
    20		4096, 2048, 1024, 512, 256, 128, 64, 32,
    21	};
    22	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

