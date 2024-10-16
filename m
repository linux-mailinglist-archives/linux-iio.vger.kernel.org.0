Return-Path: <linux-iio+bounces-10655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9BC9A056C
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 11:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A234CB249CA
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 09:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A2B205E03;
	Wed, 16 Oct 2024 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ksZDjeMo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CB8204F93;
	Wed, 16 Oct 2024 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070766; cv=none; b=fWbOrr/v527Fhf/V+X8Ddlu9I3bnr6VypPvuYgacz86a3KRZ16TRyTUR7SKgy8dHysNasCdvWAzAn/i8KTdv2i9L/VF1vcXvqHVibOK+ESRHf4sDH8KssquMqzy2cxNhF5YVv770whQpsZRytaO3OzaDbcNNk+EgvGEaFDeRssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070766; c=relaxed/simple;
	bh=qyCXe2hrEH83VZR4dKcRgeax49jUrWrEglhG4Tz7Ujk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZ4my8gdFjyuzUh1kEIH6P+lB+X3vL3kLYRCmPKYV4WxRDoKcIxN+2pQuPbZhmY56uEr5dOYO3nuhjC4PeavRF3oW7tUTLjH09wS97OlftuJqX8CefXf2PVAFxvZMfdNW4Y+BSarLicX457mekr1Mvy0tj8o+liVin7aCrefoY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ksZDjeMo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729070764; x=1760606764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qyCXe2hrEH83VZR4dKcRgeax49jUrWrEglhG4Tz7Ujk=;
  b=ksZDjeMoDffA6gtrdVVH6o4llS+XH404a9bL2FTlNoG4qiqyhk70c/g9
   Ep9z73bzuxRF7GXO9Tw4b+efQB/AbtD5Hrng4yR6DmaPYFknoZwVms30G
   B1RPc5qdASODiwkxz3sBN8cly59XytqJsidg/WKUA4pNC/o6aP1GEOMUs
   v4Gy8kwE1ahNjuFXJU+PfSMfE5zZzK4c8+G32euXbUlFcn0YrIq2OvbWN
   /SFSWee9sshVGABcU8DXwB8r4NBNkIteNhMhT7AFjktbR3GHMx7lPAvxF
   qEed8TcNd+5LqSvCGRicyYbMpNOs8My6InGcAHL/sLCCbeeTXsAEWPdSs
   g==;
X-CSE-ConnectionGUID: tik4OI1fQLqGAHekU9z4ww==
X-CSE-MsgGUID: OruD/VsKT0+wIMmwHI8qcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28708640"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="28708640"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 02:26:04 -0700
X-CSE-ConnectionGUID: 5qc4yB+uQYi8YgDxFCC7zw==
X-CSE-MsgGUID: mKQQVIpGRYaPeF+mDpSpQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="78518811"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 16 Oct 2024 02:26:02 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t10I4-000KgV-0c;
	Wed, 16 Oct 2024 09:26:00 +0000
Date: Wed, 16 Oct 2024 17:25:19 +0800
From: kernel test robot <lkp@intel.com>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	jic23@kernel.org, jmaneyrol@invensense.com, lars@metafoo.de
Cc: oe-kbuild-all@lists.linux.dev,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: Enable Pedometer Functionality
Message-ID: <202410161606.EbqeKmdm-lkp@intel.com>
References: <20241015092035.10482-1-hardevsinh.palaniya@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015092035.10482-1-hardevsinh.palaniya@siliconsignals.io>

Hi Hardevsinh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.12-rc3 next-20241016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hardevsinh-Palaniya/iio-imu-inv_icm42600-Enable-Pedometer-Functionality/20241015-172227
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20241015092035.10482-1-hardevsinh.palaniya%40siliconsignals.io
patch subject: [PATCH] iio: imu: inv_icm42600: Enable Pedometer Functionality
config: i386-randconfig-062-20241016 (https://download.01.org/0day-ci/archive/20241016/202410161606.EbqeKmdm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241016/202410161606.EbqeKmdm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410161606.EbqeKmdm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c:704:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected int @@     got restricted __le16 [addressable] [usertype] steps @@
   drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c:704:21: sparse:     expected int
   drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c:704:21: sparse:     got restricted __le16 [addressable] [usertype] steps

vim +704 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c

   685	
   686	static int inv_icm42600_steps_read_raw(struct iio_dev *indio_dev,
   687	                               struct iio_chan_spec const *chan,
   688	                               int *val, int *val2, long mask)
   689	{
   690	       struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
   691	       __le16 steps;
   692	       int ret;
   693	
   694	       if (mask == IIO_CHAN_INFO_PROCESSED) {
   695	               ret = iio_device_claim_direct_mode(indio_dev);
   696	               if (ret)
   697	                       return ret;
   698	               ret = regmap_bulk_read(st->map, INV_ICM42600_REG_APEX_DATA, &steps, sizeof(steps));
   699	               if (ret)
   700	                       return ret;
   701	               iio_device_release_direct_mode(indio_dev);
   702	               if (ret)
   703	                       return ret;
 > 704	               *val = steps;
   705	               return IIO_VAL_INT;
   706	       }
   707	
   708	       return -EINVAL;
   709	}
   710	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

