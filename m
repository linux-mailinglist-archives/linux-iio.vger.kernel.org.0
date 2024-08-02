Return-Path: <linux-iio+bounces-8148-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F8E946253
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 19:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255911C21283
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 17:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7111537AA;
	Fri,  2 Aug 2024 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GgfzWLEb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5231C1537A2;
	Fri,  2 Aug 2024 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619007; cv=none; b=VWfhjqpsckhBJhfhiuZtKNgOaPNEUKZwVJ6NPa1ULXKfCopqi1HBxjclasMCImh+TpU8/Vy2GpJjCZVAG0kdV2lXO5p+LfAO8liRhurV8w8+NE3/1VG7zY+eLrFRQgNn6l6IFygjMVXRWJ6fbbztx3O3LAVG+VpXvaOcJE7AB08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619007; c=relaxed/simple;
	bh=ZUOc7CWyI4910KClz9Lm32M6Ey/iLMCOiX6v14u+r2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jO0PUbggXXiMe3PwyV5xBHNfJyYR5xcNZj17g5ubo3iBJcF/yWjDVjf8ct6j3Z7/bvfAlH8YHKHKwrUP7PZpAQOTrvr0voSK6xpSVz5NHpV0n6IqiEwdFeZMKkxZWOrsqcEXPHZ8NgTPr9uP6Cw41SSq7ClxJs3N8MNu4aUIWB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GgfzWLEb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722619006; x=1754155006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZUOc7CWyI4910KClz9Lm32M6Ey/iLMCOiX6v14u+r2A=;
  b=GgfzWLEbwTFKgQVne6KHX8td9vmKmkyvssINiyGB6TQXSZkSmeQpKsxn
   9qb0Au4bIs5pe1eELIRi5WK/zD4qhNvSpNqwrxpw5Rzmhdx2Oj72gyPeq
   21DKivZRTCn+gQgkh3sOL3ISA8awlxMHqyJ6Gb6lwJJsau0+jaipTtbpa
   l6IPyp/RavOePpH42sxdZxaTYJ+rbZK9BdE2Lxsij4K/4kNamIgdJLziu
   up1tZYuicO3AFr/caUpZlcS66X6oNXO7enMGX8dOI6Eo4Q2y/YvWOfeKa
   wgBCiMgia8R1HJ5a69EeQQpT9JOVhCFcYO3Bb9PEKKsipvzsRiKb9/SPv
   g==;
X-CSE-ConnectionGUID: fmCl3UbKQLim0oYJ82TGZw==
X-CSE-MsgGUID: foyLHTmiRVGQW6K4NBPFew==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="31276353"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="31276353"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 10:16:46 -0700
X-CSE-ConnectionGUID: 9rwt5JNVT3Ss468ZZCy/jg==
X-CSE-MsgGUID: PUZFLnh4R7aulr4u7P/kTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="55351116"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 Aug 2024 10:16:42 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZvtQ-000xBD-1p;
	Fri, 02 Aug 2024 17:16:40 +0000
Date: Sat, 3 Aug 2024 01:16:39 +0800
From: kernel test robot <lkp@intel.com>
To: wangshuaijie@awinic.com, jic23@kernel.org, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	waqar.hameed@axis.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, wangshuaijie@awinic.com,
	liweilei@awinic.com, kangjiajun@awinic.com
Subject: Re: [PATCH V5 2/2] iio: proximity: aw9610x: Add support for aw9610x
 proximity sensor
Message-ID: <202408030003.NYT1R5AU-lkp@intel.com>
References: <20240726061312.1371450-3-wangshuaijie@awinic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726061312.1371450-3-wangshuaijie@awinic.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1722389b0d863056d78287a120a1d6cadb8d4f7b]

url:    https://github.com/intel-lab-lkp/linux/commits/wangshuaijie-awinic-com/dt-bindings-iio-aw9610x-Add-bindings-for-aw9610x-sensor/20240726-141450
base:   1722389b0d863056d78287a120a1d6cadb8d4f7b
patch link:    https://lore.kernel.org/r/20240726061312.1371450-3-wangshuaijie%40awinic.com
patch subject: [PATCH V5 2/2] iio: proximity: aw9610x: Add support for aw9610x proximity sensor
config: alpha-randconfig-r053-20240802 (https://download.01.org/0day-ci/archive/20240803/202408030003.NYT1R5AU-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240803/202408030003.NYT1R5AU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408030003.NYT1R5AU-lkp@intel.com/

All errors (new ones prefixed by >>):

   alpha-linux-ld: drivers/iio/proximity/aw9610x.o: in function `aw9610x_ps_notify_callback':
>> (.text+0x5b4): undefined reference to `power_supply_get_property'
>> alpha-linux-ld: (.text+0x5c8): undefined reference to `power_supply_get_property'
   alpha-linux-ld: drivers/iio/proximity/aw9610x.o: in function `aw9610x_i2c_probe':
>> (.text+0x870): undefined reference to `power_supply_unreg_notifier'
>> alpha-linux-ld: (.text+0x878): undefined reference to `power_supply_unreg_notifier'
>> alpha-linux-ld: (.text+0xb4c): undefined reference to `power_supply_reg_notifier'
   alpha-linux-ld: (.text+0xb98): undefined reference to `power_supply_reg_notifier'
   alpha-linux-ld: (.text+0xbac): undefined reference to `power_supply_unreg_notifier'
   alpha-linux-ld: (.text+0xbb8): undefined reference to `power_supply_unreg_notifier'
   alpha-linux-ld: drivers/iio/proximity/aw9610x.o: in function `aw9610x_i2c_remove':
   (.text+0xc18): undefined reference to `power_supply_unreg_notifier'
   alpha-linux-ld: (.text+0xc20): undefined reference to `power_supply_unreg_notifier'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

