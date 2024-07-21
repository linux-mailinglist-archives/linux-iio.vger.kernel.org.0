Return-Path: <linux-iio+bounces-7765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A117938364
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 07:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5C31F21660
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2024 05:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E6946B5;
	Sun, 21 Jul 2024 05:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jTfLlca5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45FD3FE4;
	Sun, 21 Jul 2024 05:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721539751; cv=none; b=uaX1p1rO84CL8hpNWKkLkZ2EwHYyS6tv/GwE8h9JR6khliJhOuvHMFNgM/cKw/sQmAvxvpbReTQ1AFPdO/d3oPC2wG8ZFROKGwAJBMJY3gH2gkof92qDZcUxkKOECSDxawBy0E8DHBVqAB8B030/e5yjSrHZsbjIgVC5M+aL6ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721539751; c=relaxed/simple;
	bh=DsqyEfIisDMSYLziYw0NB5TjXMJqLhfaN1hqRQ20XnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gY2f3hC4GgPyfz/k00PPW+qlolcJC1cFm4z9anUinTc4Isel3+se8YChPsSLxB9STmIPUKsUIgXjPfpfscXK6A+Sh6Ghlb4qFTFb+Qa3x/wk2cFclwsM0w0LUzOtCVvYUwjigdwrvA1JyyvRx1vLoTu90BKJmYEAttcB2xKJIZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jTfLlca5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721539749; x=1753075749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DsqyEfIisDMSYLziYw0NB5TjXMJqLhfaN1hqRQ20XnM=;
  b=jTfLlca5zDy7CNKn6NiZgxt7IJ1NtNdZID+ETQw/YVbI7n5t7XF/Au6b
   N1VHGVC0WhCurpl573m3bFvXnVrAc1dToF0GUYbzYBdmybK7HB1DlKOg5
   gbx4krnWCL1xStCyhsDyZUkHaF3iIfcppqEU+tzD1k2aTeNLJQPErdMNd
   sEANTiayeP5H5m7GWi3RIIW6EOjOjvpWza1NSmyuVloF0dhQIBpX1b76Y
   twBjdMbTJDP7GHnvOHSOFGFUbhvb/Mqi6QPDea+olWhzEY+kS2VziQVi7
   QEjyrwVcA/Tt/MjOwXiekuScNeYGt8XL7/cWuonroTrFB48N7dBmtxl+l
   w==;
X-CSE-ConnectionGUID: wS/Jj4nnRYO/OLQuydT4UA==
X-CSE-MsgGUID: lHaXVgbSToS9pXw/fAZvrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11139"; a="18995681"
X-IronPort-AV: E=Sophos;i="6.09,225,1716274800"; 
   d="scan'208";a="18995681"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2024 22:29:08 -0700
X-CSE-ConnectionGUID: nOsJWBO+Se6uW4pf31zEpg==
X-CSE-MsgGUID: w8er+ICMShG6y2/H5bsnkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,225,1716274800"; 
   d="scan'208";a="56649120"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 20 Jul 2024 22:29:06 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sVP83-000jxW-26;
	Sun, 21 Jul 2024 05:29:03 +0000
Date: Sun, 21 Jul 2024 13:28:16 +0800
From: kernel test robot <lkp@intel.com>
To: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: humidity: Add support for ENS210
Message-ID: <202407211229.nP7WkSo5-lkp@intel.com>
References: <20240719-ens21x-v4-2-6044e48a376a@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719-ens21x-v4-2-6044e48a376a@thegoodpenguin.co.uk>

Hi Joshua,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1ebab783647a9e3bf357002d5c4ff060c8474a0a]

url:    https://github.com/intel-lab-lkp/linux/commits/Joshua-Felmeden/dt-bindings-iio-humidity-add-ENS210-sensor-family/20240719-210648
base:   1ebab783647a9e3bf357002d5c4ff060c8474a0a
patch link:    https://lore.kernel.org/r/20240719-ens21x-v4-2-6044e48a376a%40thegoodpenguin.co.uk
patch subject: [PATCH v4 2/2] iio: humidity: Add support for ENS210
config: x86_64-randconfig-122-20240721 (https://download.01.org/0day-ci/archive/20240721/202407211229.nP7WkSo5-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240721/202407211229.nP7WkSo5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407211229.nP7WkSo5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/humidity/ens210.c:88:26: sparse: sparse: restricted __be32 degrades to integer
>> drivers/iio/humidity/ens210.c:88:53: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __be32 [usertype] val_be @@     got unsigned int @@
   drivers/iio/humidity/ens210.c:88:53: sparse:     expected restricted __be32 [usertype] val_be
   drivers/iio/humidity/ens210.c:88:53: sparse:     got unsigned int

vim +88 drivers/iio/humidity/ens210.c

    84	
    85	/* calculate 17-bit crc7 */
    86	static u8 ens210_crc7(u32 val)
    87	{
  > 88		__be32 val_be = (cpu_to_be32(val & 0x1ffff) >> 0x8);
    89	
    90		return crc7_be(0xde, (u8 *)&val_be, 3) >> 1;
    91	}
    92	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

