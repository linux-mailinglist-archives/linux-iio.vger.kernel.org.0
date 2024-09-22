Return-Path: <linux-iio+bounces-9696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F8E97DFE5
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 05:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B3F1C20A39
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 03:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B01171088;
	Sun, 22 Sep 2024 03:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNKoSZKz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2A18F2CF;
	Sun, 22 Sep 2024 03:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726975697; cv=none; b=hszvMT6SGXpEjZOv5RnrlF/pwZYZOptHnZJOdb/hKNlcfZ6JXlW4IBChnBZb4NP+QOGkngjsmLHPrrpNAfUcAliyBzRqzyeT/92UmDGKW+ppb4otHeYVsHTyM/bUfBbTOtDe4to8loH5nJUr+pbBnvTcQ5p3wPvIA4of4zHVWHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726975697; c=relaxed/simple;
	bh=+G7aSUmwDuUt0p/LDk204kh0s6gbpM/RTwsBV0AMTvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbZH28w6H0S0vUT6fME/CZM/UteamwBP6PM/XXW2jPW9YBWbBVqh/ZHruDewjWlufsElbf7PiQ8icmS7YyfIzh/fJ5b0I5EEzdETQ+1Zt7IbqSGwvBDSv2KAbfrIwUSYambXE7MRsXrlaFp2erGuCWVgyx8udun0G2Z1CEF2iT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNKoSZKz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726975696; x=1758511696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+G7aSUmwDuUt0p/LDk204kh0s6gbpM/RTwsBV0AMTvY=;
  b=NNKoSZKzPueo3V23ftedw8Zij8fYEvk3Jcwao2MJs4TfhhpDlkZzLE8C
   XM7rLl/kfnQYXZ/qfdmUirVWn+OhxW8AwGMACNMHD3YdfL7WcEUkFr78G
   5PKphI9fEQV+Qvq/8Ku5pWFqUvf0W5vacSQ3VgSrJLYQ4h9NB9o19r4zj
   OIQrv+DAPAEEK79FjFgNSF0W7Px5ENsV0MkQow1hjFDKQYZHwN94dsqQN
   eDUpWZ8IU9QsKt+pAHoN0zNkqOZS0LdRD330dcKfzljRAJ5h9MyBlZi2+
   oZ8BuAK693hTmGpgxG3Fgq1RQLMRnp6gZpYiWOE6wHAZLpg5i8KR0fwHZ
   g==;
X-CSE-ConnectionGUID: CmA0le77S0KfmMs34B6B3w==
X-CSE-MsgGUID: HGgXmK+5TRijNAnz4VAaMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="29840788"
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="29840788"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 20:28:15 -0700
X-CSE-ConnectionGUID: br8Nw1GMTEGrzYuSQxpMjw==
X-CSE-MsgGUID: zVSMal4RQymK+3g4hgxP8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="70747358"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 21 Sep 2024 20:28:14 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssDGd-000Fzo-0t;
	Sun, 22 Sep 2024 03:28:11 +0000
Date: Sun, 22 Sep 2024 11:27:22 +0800
From: kernel test robot <lkp@intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, mazziesaccount@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: Re: [PATCH v1 1/2] iio: Drop usage of iio_validate_own_trigger()
Message-ID: <202409221140.AyQ2zQ81-lkp@intel.com>
References: <20240921181939.392517-2-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240921181939.392517-2-vassilisamir@gmail.com>

Hi Vasileios,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8bea3878a1511bceadc2fbf284b00bcc5a2ef28d]

url:    https://github.com/intel-lab-lkp/linux/commits/Vasileios-Amoiridis/iio-Drop-usage-of-iio_validate_own_trigger/20240922-022124
base:   8bea3878a1511bceadc2fbf284b00bcc5a2ef28d
patch link:    https://lore.kernel.org/r/20240921181939.392517-2-vassilisamir%40gmail.com
patch subject: [PATCH v1 1/2] iio: Drop usage of iio_validate_own_trigger()
config: arc-randconfig-002-20240922 (https://download.01.org/0day-ci/archive/20240922/202409221140.AyQ2zQ81-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240922/202409221140.AyQ2zQ81-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409221140.AyQ2zQ81-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/light/rohm-bu27008.c:1389:29: error: initialization of 'int (*)(struct iio_dev *, struct iio_trigger *)' from incompatible pointer type 'int (*)(struct iio_trigger *, struct iio_dev *)' [-Werror=incompatible-pointer-types]
    1389 |         .validate_trigger = iio_trigger_validate_own_device,
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/light/rohm-bu27008.c:1389:29: note: (near initialization for 'bu27008_info.validate_trigger')
   cc1: some warnings being treated as errors
--
>> drivers/iio/accel/kionix-kx022a.c:876:35: error: initialization of 'int (*)(struct iio_dev *, struct iio_trigger *)' from incompatible pointer type 'int (*)(struct iio_trigger *, struct iio_dev *)' [-Werror=incompatible-pointer-types]
     876 |         .validate_trigger       = iio_trigger_validate_own_device,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/accel/kionix-kx022a.c:876:35: note: (near initialization for 'kx022a_info.validate_trigger')
   cc1: some warnings being treated as errors


vim +1389 drivers/iio/light/rohm-bu27008.c

  1382	
  1383	static const struct iio_info bu27008_info = {
  1384		.read_raw = &bu27008_read_raw,
  1385		.write_raw = &bu27008_write_raw,
  1386		.write_raw_get_fmt = &bu27008_write_raw_get_fmt,
  1387		.read_avail = &bu27008_read_avail,
  1388		.update_scan_mode = bu27008_update_scan_mode,
> 1389		.validate_trigger = iio_trigger_validate_own_device,
  1390	};
  1391	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

