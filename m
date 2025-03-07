Return-Path: <linux-iio+bounces-16518-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB67A567FB
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 13:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A751776C5
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 12:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B9921930B;
	Fri,  7 Mar 2025 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0vT0Kq4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67840215760;
	Fri,  7 Mar 2025 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741351212; cv=none; b=NpeftZzGXrcoEMFCn6Lv7oEvmr2TmknEJh3jGua4RJSvWSaI3SZY2wgNldnSANt/9OnaB2uQxS2f/1o48moplTNqxaZQHf5SZ9JcqCFrKTXbbM+Jr3iZslkSiljmE3hfXhhnxl4f+2j7KeUAr7SNp5jsAORuckSVXxOeAVtcHu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741351212; c=relaxed/simple;
	bh=G5VBh8i8J2WvpCjkRkouehcpWaB8KXAb2HO6V8L2dDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGLlbVbd2T/7UZ8ZURPgp0inq+jW755HBQNI7+BSMdXLYo0EcjphAzZHNchyAjwDNJILTUpIt01vsE7ovQKmkv/eujL4tlNkeddVufeoRxRs7Y83nmRIPv1wQg0q7+gmsKzL+UDxkYGbpTAOmXzritngCbehh2UHPWT7WKWlGJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0vT0Kq4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741351211; x=1772887211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G5VBh8i8J2WvpCjkRkouehcpWaB8KXAb2HO6V8L2dDY=;
  b=d0vT0Kq4/PHjkJQKJYhK85RzhPPG4mCUW3Uhw28hGWvw5Wshh+HFDj+O
   dJRlqw3ajrsEd041yWZfex0kq6FrucD8B0OXWJTPaKFfDzYOoY+JTtVTy
   8Lcc5wZ0x6LnRh1dtzf5o+X5ZF9LPbI0mUAqLy6iXVvMeAhbdOdO6E0Ni
   t0qkqE28X4QOV1qeb/V/9URan9BNCZWH6+V7FJrqnf3TDiGF1UfZXcpMP
   qNTaR9jTXzr9gRW9Z1AyCvLKRMmHMcPRPGBv0pWKK2qcHk35niWU6uSYO
   cmdHj2Q+/z7J1voivHR09TdfirJ0rST0JyuIE8C5r/0r8f2irsWCvCIM4
   w==;
X-CSE-ConnectionGUID: BCLkPKWwS1+cI9JmwPlzsg==
X-CSE-MsgGUID: /P4xNMxDRLqsEaoGX4CUGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41651808"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="41651808"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 04:40:10 -0800
X-CSE-ConnectionGUID: dVzl55soTd23ED5spwyZmw==
X-CSE-MsgGUID: n27M5QajR4efWEVWBq7Miw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119235420"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 07 Mar 2025 04:40:06 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqWzj-0000Tr-2I;
	Fri, 07 Mar 2025 12:40:03 +0000
Date: Fri, 7 Mar 2025 20:39:32 +0800
From: kernel test robot <lkp@intel.com>
To: Jorge Marques <jorge.marques@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	David Lechner <dlechner@baylibre.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Jorge Marques <jorge.marques@analog.com>
Subject: Re: [PATCH 4/4] iio: adc: add support for ad4052
Message-ID: <202503072008.ysqhEBaX-lkp@intel.com>
References: <20250306-iio-driver-ad4052-v1-4-2badad30116c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-iio-driver-ad4052-v1-4-2badad30116c@analog.com>

Hi Jorge,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aac287ec80d71a7ab7e44c936a434625417c3e30]

url:    https://github.com/intel-lab-lkp/linux/commits/Jorge-Marques/iio-code-mark-iio_dev-as-const-in-iio_buffer_enabled/20250306-220719
base:   aac287ec80d71a7ab7e44c936a434625417c3e30
patch link:    https://lore.kernel.org/r/20250306-iio-driver-ad4052-v1-4-2badad30116c%40analog.com
patch subject: [PATCH 4/4] iio: adc: add support for ad4052
config: powerpc-randconfig-r132-20250307 (https://download.01.org/0day-ci/archive/20250307/202503072008.ysqhEBaX-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250307/202503072008.ysqhEBaX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503072008.ysqhEBaX-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/adc/ad4052.c:357:31: sparse: sparse: symbol 'ad4050_chip_info' was not declared. Should it be static?
>> drivers/iio/adc/ad4052.c:366:31: sparse: sparse: symbol 'ad4052_chip_info' was not declared. Should it be static?
>> drivers/iio/adc/ad4052.c:375:31: sparse: sparse: symbol 'ad4056_chip_info' was not declared. Should it be static?
>> drivers/iio/adc/ad4052.c:384:31: sparse: sparse: symbol 'ad4058_chip_info' was not declared. Should it be static?
>> drivers/iio/adc/ad4052.c:711:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected int @@     got restricted __be16 [usertype] d16 @@
   drivers/iio/adc/ad4052.c:711:22: sparse:     expected int
   drivers/iio/adc/ad4052.c:711:22: sparse:     got restricted __be16 [usertype] d16
>> drivers/iio/adc/ad4052.c:715:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected int @@     got restricted __be32 [usertype] d32 @@
   drivers/iio/adc/ad4052.c:715:22: sparse:     expected int
   drivers/iio/adc/ad4052.c:715:22: sparse:     got restricted __be32 [usertype] d32
   drivers/iio/adc/ad4052.c:912:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected int @@     got restricted __be32 [usertype] d32 @@
   drivers/iio/adc/ad4052.c:912:22: sparse:     expected int
   drivers/iio/adc/ad4052.c:912:22: sparse:     got restricted __be32 [usertype] d32
>> drivers/iio/adc/ad4052.c:958:33: sparse: sparse: bad assignment (>>=) to restricted __be16
   drivers/iio/adc/ad4052.c:251:12: sparse: sparse: context imbalance in 'ad4052_iio_device_claim_direct' - different lock contexts for basic block
   drivers/iio/adc/ad4052.c:277:9: sparse: sparse: context imbalance in 'ad4052_sample_rate_get' - unexpected unlock
   drivers/iio/adc/ad4052.c:294:9: sparse: sparse: context imbalance in 'ad4052_sample_rate_set' - unexpected unlock
   drivers/iio/adc/ad4052.c:780:34: sparse: sparse: context imbalance in 'ad4052_read_raw' - unexpected unlock
   drivers/iio/adc/ad4052.c:805:34: sparse: sparse: context imbalance in 'ad4052_write_raw' - unexpected unlock
   drivers/iio/adc/ad4052.c:820:9: sparse: sparse: context imbalance in 'ad4052_read_event_config' - unexpected unlock
   drivers/iio/adc/ad4052.c:903:42: sparse: sparse: context imbalance in 'ad4052_read_event_value' - unexpected unlock
   drivers/iio/adc/ad4052.c:971:34: sparse: sparse: context imbalance in 'ad4052_write_event_value' - unexpected unlock
   drivers/iio/adc/ad4052.c:1055:34: sparse: sparse: context imbalance in 'ad4052_debugfs_reg_access' - unexpected unlock

vim +/ad4050_chip_info +357 drivers/iio/adc/ad4052.c

   356	
 > 357	const struct ad4052_chip_info ad4050_chip_info = {
   358		.name = "ad4050",
   359		.channels = { AD4052_CHAN(12, AD4052_2MSPS) },
   360		.offload_channels = { AD4052_OFFLOAD_CHAN(12, AD4052_2MSPS) },
   361		.prod_id = 0x70,
   362		.max_avg = AD4050_MAX_AVG,
   363		.grade = AD4052_2MSPS,
   364	};
   365	
 > 366	const struct ad4052_chip_info ad4052_chip_info = {
   367		.name = "ad4052",
   368		.channels = { AD4052_CHAN(16, AD4052_2MSPS) },
   369		.offload_channels = { AD4052_OFFLOAD_CHAN(16, AD4052_2MSPS) },
   370		.prod_id = 0x72,
   371		.max_avg = AD4052_MAX_AVG,
   372		.grade = AD4052_2MSPS,
   373	};
   374	
 > 375	const struct ad4052_chip_info ad4056_chip_info = {
   376		.name = "ad4056",
   377		.channels = { AD4052_CHAN(12, AD4052_500KSPS) },
   378		.offload_channels = { AD4052_OFFLOAD_CHAN(12, AD4052_500KSPS) },
   379		.prod_id = 0x70,
   380		.max_avg = AD4050_MAX_AVG,
   381		.grade = AD4052_500KSPS,
   382	};
   383	
 > 384	const struct ad4052_chip_info ad4058_chip_info = {
   385		.name = "ad4058",
   386		.channels = { AD4052_CHAN(16, AD4052_500KSPS) },
   387		.offload_channels = { AD4052_OFFLOAD_CHAN(16, AD4052_500KSPS) },
   388		.prod_id = 0x72,
   389		.max_avg = AD4052_MAX_AVG,
   390		.grade = AD4052_500KSPS,
   391	};
   392	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

