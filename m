Return-Path: <linux-iio+bounces-27260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBB6CD310C
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 15:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 641743020377
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 14:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EC82D12EB;
	Sat, 20 Dec 2025 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bG3hIOAD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65A32BE03D;
	Sat, 20 Dec 2025 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766241318; cv=none; b=oMk+tOylS/icWy3Q/49/XGqTWaqJt99ahy3/tCrfy0lApcPzK0emMywqoAWb17kadgEuFVQLzrRDAb01CTjEUfY9wFr10yysLofNyGngR1+ywAyyCNewNM1BK60xkvwmy89S++IsxGfrEIxpGf3loBZn1RNH8fmqRKD+Nf5sLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766241318; c=relaxed/simple;
	bh=WM/il7ZMre39u/faJj3qK3pSI2dS3NEYI7+2+0W3exQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qs+OVkT6t+ci8w+hXVGOUMvg3Zc46kcilAoHdscKeaDzf2u5LCauQYWdeUHyBq7urlu2IG3aOJILHu+7tz+dyNdatJDb9mzDCFyfage+4lEQLG10RThav3iQj3DjY27NjXi1d4H7fDHZtyJpi5tcGyN2rqjWdTWEtjK7Ez1YMn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bG3hIOAD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766241316; x=1797777316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WM/il7ZMre39u/faJj3qK3pSI2dS3NEYI7+2+0W3exQ=;
  b=bG3hIOADrpOC4IL9gXFLmMBQKZNbJN6vRgMv/N333lDYVd7mEWOkV9PQ
   fphfMzP5DflhdynNymosWJLbhDsET9qI2UVtwoCUee+C4Shn9Ck25RG7D
   ahNCM4YbD1kkJf6QM4nIHMsrEwEkTUGU2vZI1yA/MQ0WN40jKjh5muIBO
   ehYdeLm4WcL+EKSpNyKWs2nYBSsA7H95Pvd6+MXx0c1a79+upv/eo9O7h
   THG5cjD2nPsMm35mUKI3LBi9wvGdJdlKy2wZP0KsWffJBCxUn0PQC6qO4
   WxOkMnsX+79+PnyveEDcXOeRz/0idfmSD78KYTBNQPSxGMFcWd4018lG7
   g==;
X-CSE-ConnectionGUID: JuwzuW1iTtaerHy33/I0aw==
X-CSE-MsgGUID: 3bGk3LNqS+2Il6aF3+oJFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="85760169"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="85760169"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 06:35:12 -0800
X-CSE-ConnectionGUID: hWrhJhBLT62i1i8dmPvNBw==
X-CSE-MsgGUID: 2kf2E3v1ThCIfiZO94rSYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="236526229"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Dec 2025 06:35:07 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWy2z-000000004eL-0Zah;
	Sat, 20 Dec 2025 14:35:05 +0000
Date: Sat, 20 Dec 2025 22:34:47 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-iio@vger.kernel.org,
	joshua.yeong@starfivetech.com, devicetree@vger.kernel.org,
	linux@roeck-us.net, Frank Li <Frank.Li@nxp.com>,
	Carlos Song <carlos.song@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v12 2/2] iio: magnetometer: Add mmc5633 sensor
Message-ID: <202512202141.aAwyC19D-lkp@intel.com>
References: <20251215-i3c_ddr-v12-2-1ae31225b4d9@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215-i3c_ddr-v12-2-1ae31225b4d9@nxp.com>

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8f0b4cce4481fb22653697cced8d0d04027cb1e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dt-bindings-trivial-devices-add-MEMSIC-3-axis-magnetometer/20251216-010451
base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
patch link:    https://lore.kernel.org/r/20251215-i3c_ddr-v12-2-1ae31225b4d9%40nxp.com
patch subject: [PATCH v12 2/2] iio: magnetometer: Add mmc5633 sensor
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20251220/202512202141.aAwyC19D-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202141.aAwyC19D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512202141.aAwyC19D-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/magnetometer/mmc5633.c:362:2: error: cannot jump from switch statement to this case label
     362 |         default:
         |         ^
   drivers/iio/magnetometer/mmc5633.c:357:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     357 |                 guard(mutex)(&data->mutex);
         |                 ^
   include/linux/cleanup.h:414:15: note: expanded from macro 'guard'
     414 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:168:2: note: expanded from macro '__UNIQUE_ID'
     168 |         __PASTE(__UNIQUE_ID_,                                   \
         |         ^
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:9:1: note: expanded from here
       9 | __UNIQUE_ID_guard_966
         | ^
   1 error generated.


vim +362 drivers/iio/magnetometer/mmc5633.c

   343	
   344	static int mmc5633_write_raw(struct iio_dev *indio_dev,
   345				     struct iio_chan_spec const *chan, int val,
   346				     int val2, long mask)
   347	{
   348		struct mmc5633_data *data = iio_priv(indio_dev);
   349		int ret;
   350	
   351		switch (mask) {
   352		case IIO_CHAN_INFO_SAMP_FREQ:
   353			ret = mmc5633_get_samp_freq_index(data, val, val2);
   354			if (ret < 0)
   355				return ret;
   356	
   357			guard(mutex)(&data->mutex);
   358	
   359			return regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
   360						  MMC5633_CTRL1_BW_MASK,
   361						  FIELD_PREP(MMC5633_CTRL1_BW_MASK, ret));
 > 362		default:
   363			return -EINVAL;
   364		}
   365	}
   366	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

