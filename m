Return-Path: <linux-iio+bounces-23555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 489B1B3D5BA
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 01:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FA327A8969
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 23:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC07256C71;
	Sun, 31 Aug 2025 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMY/R9O9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0A814AA9;
	Sun, 31 Aug 2025 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756681820; cv=none; b=FRJyEBp7at/ALLM1DObMr3bfISLdlI9sI4fVH1Z71QCExPxD6ZNtoueXY4BDASKl4B8mwDsY72j/Hh8yXMeo6l2V4OOdzCtL+c/O6e6kiH/xON7TG8td3LWWT5O6f0E1b6qcSlhHwi6bUUd6IxFGys0u7d8G9PQGkkio/KWPA/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756681820; c=relaxed/simple;
	bh=JHxfvkrM73Us6LupwzXgxuKeYqfKxIOsGkL5/+zL4bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dst89IwoGJHASqcy+7wgwUMw+lRTpF2gpA9Bkn3/XBY1ZsWMRBz7ImCzBD2pLpWf4hQbE5vdMt0q3/5Y9W1fegSUUU0jD8EVH/BmMFdmoa74MP8QrTd7PBGFFKpELRKyZMXjibM5I3s8sOl39+TASB6u90EXHD/W6uP+oBR/uBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMY/R9O9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756681819; x=1788217819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JHxfvkrM73Us6LupwzXgxuKeYqfKxIOsGkL5/+zL4bk=;
  b=hMY/R9O91ExABuptuNS2KZ5DBte4BqdhJpCEH5Sl+flk/WZPtfBT8wJT
   j/G1wmXOKn5jw4VOlp75yAeNeM82w2Hxj73f/0zNnBQpsBUpYzJqWZFOA
   H7qaDShnWEZ1A2juF6FvNq9RMjS/ISbbwxs8u+/Bp0f4CwcsrolftF6bq
   rdAPzpOcGkt4zXdRELwx7UegdARduGxbWtfAP/2VDVlugokNd3rhsc5U+
   nisJ+G4B/XsRlxS853inUsGIK02F6HrkU3PlWC28ZJcjSbWBJ7kGuEK6t
   tpb2eE7wz/35joeWsorP76Dpr+uicq8n0x8HgLQOD8DsnkgjbdB/Mb7CY
   w==;
X-CSE-ConnectionGUID: qPJMToe4T4yuVY9EcTmdyw==
X-CSE-MsgGUID: 7ZnYMk8bT6G7BaIT3t49yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="59030221"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="59030221"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 16:10:18 -0700
X-CSE-ConnectionGUID: h4h1AFO5StiB55Nb2vzFQA==
X-CSE-MsgGUID: 5mTPMZo7RNay6oWvGeIHcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="170129257"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 31 Aug 2025 16:10:15 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1usrBT-000WP9-0k;
	Sun, 31 Aug 2025 23:10:09 +0000
Date: Mon, 1 Sep 2025 07:09:45 +0800
From: kernel test robot <lkp@intel.com>
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	shuah@kernel.org, linux-kernel-mentees@lists.linux.dev,
	Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Subject: Re: [PATCH 3/5] iio: imu: icm20948: add support for gyroscope
Message-ID: <202509010654.5oiN6YTZ-lkp@intel.com>
References: <20250831-icm20948-v1-3-1fe560a38de4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831-icm20948-v1-3-1fe560a38de4@gmail.com>

Hi Bharadwaj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8742b2d8935f476449ef37e263bc4da3295c7b58]

url:    https://github.com/intel-lab-lkp/linux/commits/Bharadwaj-Raju/dt-bindings-iio-imu-Add-ICM-20948/20250831-024726
base:   8742b2d8935f476449ef37e263bc4da3295c7b58
patch link:    https://lore.kernel.org/r/20250831-icm20948-v1-3-1fe560a38de4%40gmail.com
patch subject: [PATCH 3/5] iio: imu: icm20948: add support for gyroscope
config: arm-randconfig-r123-20250901 (https://download.01.org/0day-ci/archive/20250901/202509010654.5oiN6YTZ-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project ac23f7465eedd0dd565ffb201f573e7a69695fa3)
reproduce: (https://download.01.org/0day-ci/archive/20250901/202509010654.5oiN6YTZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509010654.5oiN6YTZ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c:21:12: sparse: sparse: Initializer entry defined twice
   drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c:24:12: sparse:   also defined here

vim +21 drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c

    11	
    12	/* IIO int + nano format */
    13	static const int inv_icm20948_gyro_scale[] = {
    14		/* 250 dps == 0.000133158 rad/s per LSB */
    15		[2 * INV_ICM20948_GYRO_FS_250] = 0,
    16		[2 * INV_ICM20948_GYRO_FS_250 + 1] = 133158,
    17		/* 500 dps == 0.000266316 rad/s per LSB */
    18		[2 * INV_ICM20948_GYRO_FS_500] = 0,
    19		[2 * INV_ICM20948_GYRO_FS_500 + 1] = 266316,
    20		/* 1000 dps == 0.000532632 rad/s per LSB */
  > 21		[2 * INV_ICM20948_GYRO_FS_1000] = 0,
    22		[2 * INV_ICM20948_GYRO_FS_1000 + 1] = 532632,
    23		/* 2000 dps == 0.001065264 rad/s per LSB */
    24		[2 * INV_ICM20948_GYRO_FS_1000] = 0,
    25		[2 * INV_ICM20948_GYRO_FS_1000 + 1] = 1065264,
    26	};
    27	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

