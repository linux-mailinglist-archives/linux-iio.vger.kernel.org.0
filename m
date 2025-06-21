Return-Path: <linux-iio+bounces-20808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2D9AE282A
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 10:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF18D3A9C27
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 08:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B5C1E1A16;
	Sat, 21 Jun 2025 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOcAmgTS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4181DE3BA;
	Sat, 21 Jun 2025 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750496195; cv=none; b=Cqta/h3W4gQW4JrK3lhrRsByt6LjdFOamI2uy5TUrd/eT+w/yoZsMUxeNDh9cYGFvS4TdfK/cjtA+EYHqZkAfqEsHmn/GwiO+S8vIgV9ahKYmSCUA/QvRZrltAzd2+8DrRpECyIcm2HFODk1VP2pj4fA3B9HTJUngAL3BGwjR/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750496195; c=relaxed/simple;
	bh=lozJVjeayu4fuBFr7YB8LDGyPpQu/TGuMPYpYyOubJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH0VHptS2mT3JiKrQE3J37/92vEL5QGGzrucI4AeaFBsGbl7fNDpQhhK2fENLJuodMV0Zp2l3UwXwKjOgRvr1xG43uY9NTuu430oR7o8W6ctU6Mog8Iy1FN5qaV5qmBeOZ6mPOMoF6VobUGbu2SpSifuRBTDk8gotJ1TP6x/Vto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOcAmgTS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750496193; x=1782032193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lozJVjeayu4fuBFr7YB8LDGyPpQu/TGuMPYpYyOubJE=;
  b=JOcAmgTSqsuzUHqVkv4Promp7cQ1Y7544qRf+MlVuq1jRdfogr4JGjbS
   JkrYz+5rzhg6ZMnlLGmzApW+veItyQvgeFPhgs2JSPcFggwiQrobo30v3
   AFL6fDSAtPCzNJat4zaGDN7xmxaXCHeNCJHtuDGnmq+BGxR6Rcb5IEXw5
   3YigTbCaQoN4NW5G7hLbuJ4XsDkAXW+294/GtFSQoW3cAbprLiRy8IiU1
   XP6PHyyF369qTLXUwJGYM6oNpGkwdE8n2ZwAffLcx/hph2bFRMczNi0Bm
   qaJg+UHBEu19+9jkQcOgCNEG2PKT24UgOmYlqiePBjepOIT9MVLogongO
   g==;
X-CSE-ConnectionGUID: eP5q64BRSwewEkbfn7xvZw==
X-CSE-MsgGUID: 7Nj52L2aR7m+3LiLzwF3MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="40359655"
X-IronPort-AV: E=Sophos;i="6.16,253,1744095600"; 
   d="scan'208";a="40359655"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2025 01:56:33 -0700
X-CSE-ConnectionGUID: UR9IhsTnQHedEH4bECr6Yg==
X-CSE-MsgGUID: JcJqLz9gSfy5YSgtYqhRzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,253,1744095600"; 
   d="scan'208";a="151256679"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 21 Jun 2025 01:56:29 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSu1T-000MUk-1Q;
	Sat, 21 Jun 2025 08:56:27 +0000
Date: Sat, 21 Jun 2025 16:55:56 +0800
From: kernel test robot <lkp@intel.com>
To: liquancin.mereenamathai@in.bosch.com, linux-iio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, vassilisamir@gmail.com, marcelo.schmitt1@gmail.com,
	javier.carrasco.cruz@gmail.com, Xu.Zhang@cn.bosch.com,
	Maoting.Bian@cn.bosch.com, Liquancin.MereenaMathai@in.bosch.com
Subject: Re: [PATCH v1 1/2] Add the iio driver for bosch pressure sensor
 bmp390. The bmp390 is a pressure sensor module. It will support SPI and I2C
 protocol based on configuration.
Message-ID: <202506211617.KOMMf9eA-lkp@intel.com>
References: <20250620045456.1151-2-liquancin.mereenamathai@in.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620045456.1151-2-liquancin.mereenamathai@in.bosch.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.16-rc2 next-20250620]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/liquancin-mereenamathai-in-bosch-com/Add-the-iio-driver-for-bosch-pressure-sensor-bmp390-The-bmp390-is-a-pressure-sensor-module-It-will-support-SPI-and-I2C-p/20250620-125832
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250620045456.1151-2-liquancin.mereenamathai%40in.bosch.com
patch subject: [PATCH v1 1/2] Add the iio driver for bosch pressure sensor bmp390. The bmp390 is a pressure sensor module. It will support SPI and I2C protocol based on configuration.
config: loongarch-randconfig-r122-20250621 (https://download.01.org/0day-ci/archive/20250621/202506211617.KOMMf9eA-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0
reproduce: (https://download.01.org/0day-ci/archive/20250621/202506211617.KOMMf9eA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506211617.KOMMf9eA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/pressure/bmp390/bmp390_i2c.c:38:16: sparse: sparse: symbol 'iio_i2c_dev' was not declared. Should it be static?
--
>> drivers/iio/pressure/bmp390/bmp390_iio_buffer.c:41:56: sparse: sparse: dereference of noderef expression
>> drivers/iio/pressure/bmp390/bmp390_iio_buffer.c:41:56: sparse: sparse: dereference of noderef expression
   drivers/iio/pressure/bmp390/bmp390_iio_buffer.c:44:40: sparse: sparse: dereference of noderef expression
   drivers/iio/pressure/bmp390/bmp390_iio_buffer.c:44:40: sparse: sparse: dereference of noderef expression
   drivers/iio/pressure/bmp390/bmp390_iio_buffer.c:47:43: sparse: sparse: dereference of noderef expression
   drivers/iio/pressure/bmp390/bmp390_iio_buffer.c:47:43: sparse: sparse: dereference of noderef expression

vim +/iio_i2c_dev +38 drivers/iio/pressure/bmp390/bmp390_i2c.c

    33	
    34	/*********************************************************************/
    35	/* global variables */
    36	/*********************************************************************/
    37	static struct i2c_client *bmp3_i2c_client;
  > 38	struct iio_dev *iio_i2c_dev;
    39	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

