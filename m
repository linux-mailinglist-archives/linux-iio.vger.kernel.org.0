Return-Path: <linux-iio+bounces-14117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FE1A09E62
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 23:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D4D3A2265
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 22:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF635218599;
	Fri, 10 Jan 2025 22:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L998vUzP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A015E2080F6;
	Fri, 10 Jan 2025 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736549508; cv=none; b=k7zmzUrFPwC5w/n3VuvRH/uBZyKkHBeWvxvX/ETuvw42lYDVGJBSpZoy7TjBiTF7j29d0jn+/2yTIhWghDW3QbRLGW9csWBcpEWnnUj0qkwLAfONX38lnlJ+Ol6MVr4Gn3rnbPIQQsOFpFPLM5BnzlBLNnJXTw8iBhwr1mgp8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736549508; c=relaxed/simple;
	bh=HIlURnE0nRCK3UATcsv+lxBjbZaQ9GHcOJpoRbi91lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEkGCX91yC1TNVeCgWsR3zAE5jcW6t93cv/hXDSS/S4P9rt5g0TP1mEAjmBpi/3fv5O3IYIzAPGtU1z4epGsTbLxRHMveTYjlVc2VQPOTHfAeZkkXypdlSn9792wVsN3qo5iR7cPrKQlU2WbyH/GA7Q1zH2kj9rFqTewqX3Tp9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L998vUzP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736549507; x=1768085507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HIlURnE0nRCK3UATcsv+lxBjbZaQ9GHcOJpoRbi91lk=;
  b=L998vUzPrKReaGqDxmplllbashtsRzV7WhYHMku2xFYPCWEqlJ/u+YfI
   7ltm89vBiivp7vUzp9Mzf1dVxVZoVbVTrjYBngKlMpbsGTjPe9x1kGHjl
   VQi044r85XIwcAxfZMribXIemWpc0Ua/FvKrybAQbJbsfOTZ89tkRSdVF
   0PqWbByocdAYxiUUiqlJjQhVwEbk8yFHeabp5PAPlUD9oNA5EWqbbIbrq
   eIxT2ff8ZRWFh+autUh42SXCoyBMAeUBEUyQmotT1vPSpYtVfoi9jWQlb
   +bvqolRMJEd+VoO15E/lQ8TsLg9IS9peJW6S2bsl8lfWN/5w8DlBxvIm4
   g==;
X-CSE-ConnectionGUID: oZ9mY4U5R9GK4ac70MhUJg==
X-CSE-MsgGUID: Q1muRywyQiaS6ql3hLFc8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="62228171"
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="62228171"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 14:51:46 -0800
X-CSE-ConnectionGUID: wtq/LuD/SseJPQf4BgTzaQ==
X-CSE-MsgGUID: 5MIOti9ISqSoK7iJ+S3q3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="108870400"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 10 Jan 2025 14:51:42 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWNqt-000Jr5-1m;
	Fri, 10 Jan 2025 22:51:39 +0000
Date: Sat, 11 Jan 2025 06:51:12 +0800
From: kernel test robot <lkp@intel.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrej.skvortzov@gmail.com,
	neil.armstrong@linaro.org, icenowy@aosc.io, megi@xff.cz,
	danila@jiaxyga.com, javier.carrasco.cruz@gmail.com, and@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, apokusinski01@gmail.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: magnetometer: si7210: add driver for Si7210
Message-ID: <202501110655.qR09D59T-lkp@intel.com>
References: <20250108234411.882768-3-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108234411.882768-3-apokusinski01@gmail.com>

Hi Antoni,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.13-rc6 next-20250110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoni-Pokusinski/dt-bindings-iio-magnetometer-add-binding-for-Si7210/20250109-074641
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250108234411.882768-3-apokusinski01%40gmail.com
patch subject: [PATCH v2 2/2] iio: magnetometer: si7210: add driver for Si7210
config: arc-randconfig-r111-20250111 (https://download.01.org/0day-ci/archive/20250111/202501110655.qR09D59T-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250111/202501110655.qR09D59T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501110655.qR09D59T-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/magnetometer/si7210.c:169:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __be16 [usertype] @@
   drivers/iio/magnetometer/si7210.c:169:16: sparse:     expected unsigned short [usertype] val
   drivers/iio/magnetometer/si7210.c:169:16: sparse:     got restricted __be16 [usertype]
   drivers/iio/magnetometer/si7210.c:169:16: sparse: sparse: cast from restricted __be16
   drivers/iio/magnetometer/si7210.c:169:16: sparse: sparse: cast from restricted __be16
   drivers/iio/magnetometer/si7210.c:189:24: sparse: sparse: restricted __be16 degrades to integer
   drivers/iio/magnetometer/si7210.c:206:23: sparse: sparse: cast to restricted __be16
   drivers/iio/magnetometer/si7210.c:206:23: sparse: sparse: restricted __be16 degrades to integer
   drivers/iio/magnetometer/si7210.c:206:23: sparse: sparse: restricted __be16 degrades to integer

vim +169 drivers/iio/magnetometer/si7210.c

   143	
   144	static int si7210_fetch_measurement(struct si7210_data *data,
   145					    struct iio_chan_spec const *chan,
   146					    __be16 *buf)
   147	{
   148		u8 dspsigsel = chan->type == IIO_MAGN ? 0 : 1;
   149		int ret;
   150	
   151		guard(mutex)(&data->fetch_lock);
   152	
   153		ret = regmap_update_bits(data->regmap, SI7210_REG_DSPSIGSEL,
   154					 SI7210_MASK_DSPSIGSEL, dspsigsel);
   155		if (ret < 0)
   156			return ret;
   157	
   158		ret = regmap_update_bits(data->regmap, SI7210_REG_POWER_CTRL,
   159					 SI7210_MASK_ONEBURST | SI7210_MASK_STOP,
   160					 SI7210_MASK_ONEBURST & ~SI7210_MASK_STOP);
   161		if (ret < 0)
   162			return ret;
   163	
   164		/* Read the contents of the registers containing the result: DSPSIGM, DSPSIGL */
   165		ret = regmap_bulk_read(data->regmap, SI7210_REG_DSPSIGM, buf, 2);
   166		if (ret < 0)
   167			return ret;
   168	
 > 169		*buf = cpu_to_be16(*buf);
   170	
   171		return 0;
   172	}
   173	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

