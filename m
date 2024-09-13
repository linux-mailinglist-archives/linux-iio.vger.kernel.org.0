Return-Path: <linux-iio+bounces-9524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 415989789EE
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 22:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E8A281D15
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 20:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A392148850;
	Fri, 13 Sep 2024 20:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWNFYvLw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34590B67D;
	Fri, 13 Sep 2024 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726259486; cv=none; b=hLGmELKcnNdvz4YX7PmTgg7jg//5c8uxDxqNTvjsKWPiQgJesSp5kpcC/xSz+QHBo2R1KDK+BSYP69ZDwtST1vWsIZVKX85S8VZGuEeva43O9SQZt/e31MsZoaGRrOrcnJdzfWB67D/Ciy04Ue2MLeGJ8nNCi1AJQbHenVGnSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726259486; c=relaxed/simple;
	bh=Tx5/dZmHNQNXpIuvYmfC/G6hrzVqoftURJxPv5bI6kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rvj6L4pvAFZoRSdv5OM+vKxdCuDuYgzA9otjHRIxP5wVtV1dDKKi8C+0aZYDG0+1x0bsRH+i/fPrC/dgsxps0lZaGe9oZH6yvhyNTryV3t1AbHIruMmEldLX+/m+vnIbOQKYdx4yiV65lggXKwfzO9jnZhmLl/9kdMVEeebewiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWNFYvLw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726259484; x=1757795484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tx5/dZmHNQNXpIuvYmfC/G6hrzVqoftURJxPv5bI6kk=;
  b=TWNFYvLwI74IuXHjfCFlF/64YUQgsOzOguDnQrJTOYUUY5wP7l4NO7AW
   /1YukI6N3KxnPA5WscG/JnKpw+rEhtyfpuIaeqiiufdJKMxRf4gO8fJN1
   pKDpsJbPIcrj/6l6UFQ4YgFiJKsy5vLTvlh2cHF2f+YdHRS8UyfgImJPs
   oxq0DuiJCeSHXGLKGaAH8x8nYDjAeet5H8SZPHV5HUxCDv/pGjV8qB2W6
   u8oZRZk2w9VZTkVB6B/pUYBdelOdplGMU+NGJ7ggQHiC3z+wHi2M6kW7o
   z+wvbqctjmXax5hW1VKGj87l8KWistI1j/wAsw0LVDy7S1bnMe1M5ZQWP
   Q==;
X-CSE-ConnectionGUID: BdOAa7aPQy2zjTQAjnHqAg==
X-CSE-MsgGUID: r4Wa7KjeRXmF7dzoLT2uEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25110863"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="25110863"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 13:31:23 -0700
X-CSE-ConnectionGUID: Yaf97OChSUq8zt1fjh93bw==
X-CSE-MsgGUID: 5M2YQM5/TGGWtgJ6fMjEVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="72556858"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 Sep 2024 13:31:21 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spCwo-0006xw-1u;
	Fri, 13 Sep 2024 20:31:18 +0000
Date: Sat, 14 Sep 2024 04:30:42 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandru Ardelean <aardelean@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jic23@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com,
	gstols@baylibre.com, dlechner@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: Re: [PATCH v6 8/8] iio: adc: ad7606: add support for AD7606C-{16,18}
 parts
Message-ID: <202409140416.KWHXjFSv-lkp@intel.com>
References: <20240913135744.152669-9-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913135744.152669-9-aardelean@baylibre.com>

Hi Alexandru,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on next-20240913]
[cannot apply to linus/master v6.11-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandru-Ardelean/iio-adc-ad7606-add-bits-parameter-to-channels-macros/20240913-220501
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240913135744.152669-9-aardelean%40baylibre.com
patch subject: [PATCH v6 8/8] iio: adc: ad7606: add support for AD7606C-{16,18} parts
config: arm-randconfig-001-20240914 (https://download.01.org/0day-ci/archive/20240914/202409140416.KWHXjFSv-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409140416.KWHXjFSv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409140416.KWHXjFSv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ad7606.c:39:27: warning: 'ad7606_18bit_hw_scale_avail' defined but not used [-Wunused-const-variable=]
      39 | static const unsigned int ad7606_18bit_hw_scale_avail[2] = {
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ad7606_18bit_hw_scale_avail +39 drivers/iio/adc/ad7606.c

    38	
  > 39	static const unsigned int ad7606_18bit_hw_scale_avail[2] = {
    40		38147, 76294
    41	};
    42	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

