Return-Path: <linux-iio+bounces-23556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0527B3D659
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 03:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EAE3B6C07
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 01:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C071B0F19;
	Mon,  1 Sep 2025 01:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CA8XMlFi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23333134AC;
	Mon,  1 Sep 2025 01:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756691174; cv=none; b=uMh4vV3mRELiy6ijFwUSBmAlMdT5Dk81hKJVf8OOEAXKlt7hla3ZZM+jIqM5GqQ+TNXfpaJC/th4uI1MGqJNzA/Lap3excx0GYfPKNSfQFLrrt897YQW86b0f/Vb0b8r0zmsCJEAh0wbb07sEgewb1WC+l5wNEuJU/uoLpE5zYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756691174; c=relaxed/simple;
	bh=RzLdyNU+06UIw3pVzj6lLN2PZ24YjO7bcjxEXmXqMqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSa61IlbooxrQlDb63z8axcIlCn9RAaJmDm9n7iwM+QahFtNt1qeynQ3yaGPDHHVvlDM1LN3txgwxEC5TjphBWTpQO4N6EGRTHHY6AkEEMIUbJ/XiLSi6o2mQ2Mz6/qbyMVRxRouOEJtsb4/9JRrXXnKh1BnTXN8bpXWBed/xkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CA8XMlFi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756691172; x=1788227172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RzLdyNU+06UIw3pVzj6lLN2PZ24YjO7bcjxEXmXqMqM=;
  b=CA8XMlFi/RBK/SC5hhSnGwwa3vV+DC1BzUX4Kl9nBhRn5tnF31o7lP0B
   T7b53iTNv+F3lQB7bYSK5rYe4cJZuqgRGE4DssF5kKF/rFmMEoBVimnIU
   m+y02U9UlZbJe4VCC2oTQlOaaT34bcDhAXw5jwJzW/Vb7pbwBvGwk/e2Q
   IQDnporluPT7XKxlHW89sTFr1V7ro2z8oBoIGKOGGAZDQEWkx5wcYqWw4
   zeDJoR2LQlbycCnBaJIGXcoj6TbdbFhSxHE89r098hD/GjC6ETp0bQd8c
   /LbuP0L4561FKrkh6bOnjix64vXb7Few4spf1r9PWTBUy5s7lrDjqgUza
   w==;
X-CSE-ConnectionGUID: DUtVJNkUQlm56QMexrUhAQ==
X-CSE-MsgGUID: ko3fVM1CSpGtemb+qtB7iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="59034244"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="59034244"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2025 18:46:11 -0700
X-CSE-ConnectionGUID: EVNJIULMQYGFusoItCAZlg==
X-CSE-MsgGUID: /i+qggwiSRS06VOV5df//A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="175203000"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 31 Aug 2025 18:46:09 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ustcT-000011-2A;
	Mon, 01 Sep 2025 01:46:05 +0000
Date: Mon, 1 Sep 2025 09:36:19 +0800
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
Message-ID: <202509010950.z3ZOTLrS-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 8742b2d8935f476449ef37e263bc4da3295c7b58]

url:    https://github.com/intel-lab-lkp/linux/commits/Bharadwaj-Raju/dt-bindings-iio-imu-Add-ICM-20948/20250831-024726
base:   8742b2d8935f476449ef37e263bc4da3295c7b58
patch link:    https://lore.kernel.org/r/20250831-icm20948-v1-3-1fe560a38de4%40gmail.com
patch subject: [PATCH 3/5] iio: imu: icm20948: add support for gyroscope
config: parisc-randconfig-r132-20250901 (https://download.01.org/0day-ci/archive/20250901/202509010950.z3ZOTLrS-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 10.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250901/202509010950.z3ZOTLrS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509010950.z3ZOTLrS-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "__divdi3" [drivers/iio/imu/inv_icm20948/inv-icm20948.ko] undefined!
>> ERROR: modpost: "__moddi3" [drivers/iio/imu/inv_icm20948/inv-icm20948.ko] undefined!
ERROR: modpost: "inv_icm20948_core_probe" [drivers/iio/imu/inv_icm20948/inv-icm20948-i2c.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

