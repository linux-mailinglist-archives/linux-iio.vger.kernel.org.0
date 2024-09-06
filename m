Return-Path: <linux-iio+bounces-9256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C93096FD6C
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 23:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E671F293C6
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 21:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BC0159571;
	Fri,  6 Sep 2024 21:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ti3Zt129"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD6B1586C8;
	Fri,  6 Sep 2024 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725658383; cv=none; b=NJUgEdIkOZz4cBlloi1vp1n53Osvf0Deo7sUpc/XJPAGMVf4xTL+leh9qgKpj3of6ufu+g1iXh5WLYCjFVFTIPdh/l8OVESAGktS1PEM+/WdaECpgJH1DswrtLfojK9yKK8zeU4Mfh+fxKdWPhxRasfS3BalV7oarexOX4kTV7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725658383; c=relaxed/simple;
	bh=yk7jDSXoYMEFlecMrN6Gvifr3ubzAVcFiHCdMz8wE+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWX761b4hGo4k1GBSkoro6mBgaPLUbaPctTx4QtAsjlQfKa/shvl1elUXxIqxsvl/44OtsBnUWfS1hmKuMBlUL0dxyWsqfveTAIIP1gWo69p6HkcL0QuIiutUsSr1e5nw3uf2/l4P4Zh3Le7gwa7/75SOTVAerqi9vPmL3IoQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ti3Zt129; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725658382; x=1757194382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yk7jDSXoYMEFlecMrN6Gvifr3ubzAVcFiHCdMz8wE+g=;
  b=Ti3Zt129ICIraj9Ah8VzjeCK+vFG0lkJ3wzd9Hzv0iSSGy0vAQMsiBiq
   6DDWtalPQZxxWHz1JW+ilBiugFgzzmhRVkfuG/j0UrC687wFXGf9Sjnjt
   Hs3Nxfgym/6ju4x5CesiWNP0E8XDWl6Q3J3h7sEPT7lg4E2vqvKMVdOE7
   EIS8I4xgC1tlk8uBmrhSbuYPWZ8c29f44l5QercpQZhbStuMQgaddveLA
   Qa3rcUo6hqW8KP0ht/86HjGwKOxjE6lKxq/86DnzNkx0poak/LbI404kN
   pVohMgy2N3gwwj0tiW3d9WVdhVaMWOXqzbcQIOtDyBYRjlQEwQrvyZFiw
   w==;
X-CSE-ConnectionGUID: W7o7MBgwQaKEZNAR4q2ifg==
X-CSE-MsgGUID: no5hwR0LQ1mQecpn/FnzFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="24295246"
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="24295246"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 14:33:02 -0700
X-CSE-ConnectionGUID: LiCxS02BSiWxEySkjhdZNw==
X-CSE-MsgGUID: 070hv0L6SyuFFre0c2YfuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="66618472"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 06 Sep 2024 14:32:59 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smgZc-000BkJ-1p;
	Fri, 06 Sep 2024 21:32:56 +0000
Date: Sat, 7 Sep 2024 05:32:26 +0800
From: kernel test robot <lkp@intel.com>
To: Emil Gedenryd <emil.gedenryd@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andreas Dannenberg <dannenberg@ti.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Emil Gedenryd <emil.gedenryd@axis.com>,
	kernel@axis.com
Subject: Re: [PATCH 2/3] iio: light: opt3001: add support for TI's opt3002
 light sensor
Message-ID: <202409070539.HDm71PcK-lkp@intel.com>
References: <20240905-add_opt3002-v1-2-a5ae21b924fb@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-add_opt3002-v1-2-a5ae21b924fb@axis.com>

Hi Emil,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5be63fc19fcaa4c236b307420483578a56986a37]

url:    https://github.com/intel-lab-lkp/linux/commits/Emil-Gedenryd/iio-light-opt3001-add-missing-full-scale-range-value/20240905-182748
base:   5be63fc19fcaa4c236b307420483578a56986a37
patch link:    https://lore.kernel.org/r/20240905-add_opt3002-v1-2-a5ae21b924fb%40axis.com
patch subject: [PATCH 2/3] iio: light: opt3001: add support for TI's opt3002 light sensor
config: arm-randconfig-004-20240907 (https://download.01.org/0day-ci/archive/20240907/202409070539.HDm71PcK-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409070539.HDm71PcK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409070539.HDm71PcK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/light/opt3001.c:313:29: error: initializer element is not a compile-time constant
                   .type = opt3001_chip_info.chan_type,
                           ~~~~~~~~~~~~~~~~~~^~~~~~~~~
   drivers/iio/light/opt3001.c:324:29: error: initializer element is not a compile-time constant
                   .type = opt3002_chip_info.chan_type,
                           ~~~~~~~~~~~~~~~~~~^~~~~~~~~
   2 errors generated.


vim +313 drivers/iio/light/opt3001.c

   310	
   311	static const struct iio_chan_spec opt3001_channels[] = {
   312		{
 > 313			.type = opt3001_chip_info.chan_type,
   314			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
   315					BIT(IIO_CHAN_INFO_INT_TIME),
   316			.event_spec = opt3001_event_spec,
   317			.num_event_specs = ARRAY_SIZE(opt3001_event_spec),
   318		},
   319		IIO_CHAN_SOFT_TIMESTAMP(1),
   320	};
   321	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

