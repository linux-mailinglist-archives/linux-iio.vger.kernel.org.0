Return-Path: <linux-iio+bounces-22764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37476B27F2E
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 13:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FDAB1CE20AB
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 11:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86AA287243;
	Fri, 15 Aug 2025 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZbo72NX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE2224466C;
	Fri, 15 Aug 2025 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257548; cv=none; b=XMmVmoAE3OQ8m5QhsF/wQYFA1R5WUiFy1jMqTJHXoBBGq7P9q70i+0FEtgqlz00DxYYetxfogKUGv/WmuwJEXojqe0a5k+Wg/pJqnfhKNp7WL0H6Df/ehimJ2VfI3ho0saWuGzz9pPN6nmH7Fb1YO4d0SfVGhaX8QK7u2wBNIsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257548; c=relaxed/simple;
	bh=l2mefawQlsuZdyigHB0Y5oDct27lMf5ynCTq6Z52qlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmnZdsq3whTk6eOIksMnte+gkpOAZpcooOc5V0PoAXEFgRaecWKwad484MPW/ZZVBpyrMMdaaS7NpGNSg5/Zl8omi3TiZwU4sG0IdEVPzwVk2ZW5la+nlZ0CS+4r4G5eqA+ODKRlbAUSrM4SdPpS1KU+iAGL3V7T3tSHFUyTfX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZbo72NX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755257547; x=1786793547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l2mefawQlsuZdyigHB0Y5oDct27lMf5ynCTq6Z52qlE=;
  b=aZbo72NXLgCbVzRZ2/3SMywtCSY5qDKt0LOWFcgSkK7pXj+yF5DRCmZC
   OZ7PQnDaG83Xx3iHqbe/Fb9ePt/qbQpJeHHvFMC8VNZTYWOvBjbfqD28O
   7C8O51F8CzXqdImsWEm1qqyIQP/IdZ455v+YuaDXT/AIfILxG8qR3SD9y
   rHhM7oDwb9ak0jmdwbJty00czQ5dwD99K9NJMxkEK45kfKhah8or3VxCY
   7OOpyLZnrXS/9nPRBKZIkGOsw/qGc452EDyugp9j0u93wbG4M0USQeo7H
   frzw//r3WG4s5hV6QRrD+7bIbaBBgMXmo2az8FcQ7uwHd4YCNaaNuqWz6
   g==;
X-CSE-ConnectionGUID: +vQeLbjoSXu7N5+P6yjLKA==
X-CSE-MsgGUID: m0ds6bi4SOewJd34Afll/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="60206412"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="60206412"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 04:32:26 -0700
X-CSE-ConnectionGUID: HeACYR4lTB6BD+CZwbus5Q==
X-CSE-MsgGUID: YpBAb1a/TCCJ1DUCYTHx/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="190709485"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 15 Aug 2025 04:32:23 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umsfU-000Buw-2p;
	Fri, 15 Aug 2025 11:32:20 +0000
Date: Fri, 15 Aug 2025 19:31:38 +0800
From: kernel test robot <lkp@intel.com>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
Subject: Re: [PATCH v4 6/9] iio: imu: inv_icm45600: add I2C driver for
 inv_icm45600 driver
Message-ID: <202508151941.BweGaEVT-lkp@intel.com>
References: <20250814-add_newport_driver-v4-6-4464b6600972@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814-add_newport_driver-v4-6-4464b6600972@tdk.com>

Hi Remi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on f8f559752d573a051a984adda8d2d1464f92f954]

url:    https://github.com/intel-lab-lkp/linux/commits/Remi-Buisson-via-B4-Relay/dt-bindings-iio-imu-Add-inv_icm45600/20250814-170722
base:   f8f559752d573a051a984adda8d2d1464f92f954
patch link:    https://lore.kernel.org/r/20250814-add_newport_driver-v4-6-4464b6600972%40tdk.com
patch subject: [PATCH v4 6/9] iio: imu: inv_icm45600: add I2C driver for inv_icm45600 driver
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250815/202508151941.BweGaEVT-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250815/202508151941.BweGaEVT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508151941.BweGaEVT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/imu/inv_icm45600/inv_icm45600_core.c:908:12: warning: result of comparison of constant 32768 with expression of type 's16' (aka 'short') is always false [-Wtautological-constant-out-of-range-compare]
     908 |         if (*temp == INV_ICM45600_DATA_INVALID)
         |             ~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/inv_icm45600/inv_icm45600_core.c:785:12: warning: unused function 'inv_icm45600_suspend' [-Wunused-function]
     785 | static int inv_icm45600_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/inv_icm45600/inv_icm45600_core.c:820:12: warning: unused function 'inv_icm45600_resume' [-Wunused-function]
     820 | static int inv_icm45600_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/inv_icm45600/inv_icm45600_core.c:860:12: warning: unused function 'inv_icm45600_runtime_suspend' [-Wunused-function]
     860 | static int inv_icm45600_runtime_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/imu/inv_icm45600/inv_icm45600_core.c:879:12: warning: unused function 'inv_icm45600_runtime_resume' [-Wunused-function]
     879 | static int inv_icm45600_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   5 warnings generated.


vim +908 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c

8891b99381240f Remi Buisson 2025-08-14  887  
2570c7e48ace35 Remi Buisson 2025-08-14  888  static int _inv_icm45600_temp_read(struct inv_icm45600_state *st, s16 *temp)
2570c7e48ace35 Remi Buisson 2025-08-14  889  {
2570c7e48ace35 Remi Buisson 2025-08-14  890  	struct inv_icm45600_sensor_conf conf = INV_ICM45600_SENSOR_CONF_KEEP_VALUES;
2570c7e48ace35 Remi Buisson 2025-08-14  891  	int ret;
2570c7e48ace35 Remi Buisson 2025-08-14  892  
2570c7e48ace35 Remi Buisson 2025-08-14  893  	/* Make sure a sensor is on. */
2570c7e48ace35 Remi Buisson 2025-08-14  894  	if (st->conf.gyro.mode == INV_ICM45600_SENSOR_MODE_OFF &&
2570c7e48ace35 Remi Buisson 2025-08-14  895  	    st->conf.accel.mode == INV_ICM45600_SENSOR_MODE_OFF) {
2570c7e48ace35 Remi Buisson 2025-08-14  896  		conf.mode = INV_ICM45600_SENSOR_MODE_LOW_POWER;
2570c7e48ace35 Remi Buisson 2025-08-14  897  		ret = inv_icm45600_set_accel_conf(st, &conf, NULL);
2570c7e48ace35 Remi Buisson 2025-08-14  898  		if (ret)
2570c7e48ace35 Remi Buisson 2025-08-14  899  			return ret;
2570c7e48ace35 Remi Buisson 2025-08-14  900  	}
2570c7e48ace35 Remi Buisson 2025-08-14  901  
2570c7e48ace35 Remi Buisson 2025-08-14  902  	ret = regmap_bulk_read(st->map, INV_ICM45600_REG_TEMP_DATA,
2570c7e48ace35 Remi Buisson 2025-08-14  903  				&st->buffer.u16, sizeof(st->buffer.u16));
2570c7e48ace35 Remi Buisson 2025-08-14  904  	if (ret)
2570c7e48ace35 Remi Buisson 2025-08-14  905  		return ret;
2570c7e48ace35 Remi Buisson 2025-08-14  906  
2570c7e48ace35 Remi Buisson 2025-08-14  907  	*temp = (s16)le16_to_cpup(&st->buffer.u16);
2570c7e48ace35 Remi Buisson 2025-08-14 @908  	if (*temp == INV_ICM45600_DATA_INVALID)
2570c7e48ace35 Remi Buisson 2025-08-14  909  		return -EINVAL;
2570c7e48ace35 Remi Buisson 2025-08-14  910  
2570c7e48ace35 Remi Buisson 2025-08-14  911  	return 0;
2570c7e48ace35 Remi Buisson 2025-08-14  912  }
2570c7e48ace35 Remi Buisson 2025-08-14  913  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

