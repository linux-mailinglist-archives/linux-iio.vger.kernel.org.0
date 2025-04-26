Return-Path: <linux-iio+bounces-18712-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A96C0A9DC4E
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 18:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5A917C20D
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA8625D8F8;
	Sat, 26 Apr 2025 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FEuP5p44"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FDE25D218;
	Sat, 26 Apr 2025 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745686165; cv=none; b=W+jhjnHHhJXrsWEJUjj0lKjmM/4GZWz0Z2yKFyeIv0EXXaD8e5am8Kb956M2r5LIx+iTsAmMRw7vIwJDi0Wb+OZ2zvYp0Ajdj3R9APJq1FnCER/S337Ifi6pRKR/iWWK3Rp0dXHAIdSDZVszw6Zdn28Dr/JqkTByqFkuW2JybBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745686165; c=relaxed/simple;
	bh=iS+9leWgXXOZ1k/iOhF8RACB9451MBev3uHFiptRUpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTcygh9SNGOEZhVjEkb2t+GccEEG3YS99PGlDeRzOI97k9U0me2z4qwJ8B12hyZ50GY+Kh7jE7zKfAmSGnKQQTBcmrUfg4kWVrFAAsd0827Np56UeQbjGXzQGLG/uHx2H7Gxu26qbNSYSY+lvTv5xMXcnV4lSkuUz1roC98qxWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FEuP5p44; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745686164; x=1777222164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iS+9leWgXXOZ1k/iOhF8RACB9451MBev3uHFiptRUpE=;
  b=FEuP5p44B/VPMgLr02oGMKTiK0lq4RcsshI+EHBKzRYByg3m6OyFD8KF
   +mFAiEs7iUAKW68egxc0lhqDj37TbHKk77AzB+Xg3I7U8RgahW+698Hdk
   4wb+NmvPoIfv7M+O6sF9xRgCIwlva/+q0vnSlKG9HpkuIPwz7/YeNB/u4
   MboIcSfn+gZWt6MYd+FYUcHxpdVQ5nT2wGg5w6ZgV8rVt/4iDEB6zbgTh
   2NlwtzpFnR0ICcqIDg2x3qVKCJ17XBlVrG4v+ejOmaqwBNVcPCNHvUoRR
   jHFlhYrJbk/qZdbSKcOQxQaKMgKfhPQuVBBUQOfOo+nBrGv5kt6MuctR2
   Q==;
X-CSE-ConnectionGUID: Vwl4EoFXQAGw6x+UQwQTaQ==
X-CSE-MsgGUID: qKk4dhPORdWrmjq2UBGIdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="64854293"
X-IronPort-AV: E=Sophos;i="6.15,241,1739865600"; 
   d="scan'208";a="64854293"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 09:49:22 -0700
X-CSE-ConnectionGUID: Vhk6u4BwTMOfmzbihRx3sw==
X-CSE-MsgGUID: rL7HaxZAT3aThZa2zsdIUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,241,1739865600"; 
   d="scan'208";a="164212011"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Apr 2025 09:49:20 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u8iiL-0005vN-36;
	Sat, 26 Apr 2025 16:49:17 +0000
Date: Sun, 27 Apr 2025 00:48:51 +0800
From: kernel test robot <lkp@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: [PATCH v3 11/11] iio: adc: ad4080: add driver support
Message-ID: <202504270010.w3ZsLDZR-lkp@intel.com>
References: <20250425112538.59792-12-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425112538.59792-12-antoniu.miclaus@analog.com>

Hi Antoniu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.15-rc3 next-20250424]
[cannot apply to jic23-iio/togreg]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoniu-Miclaus/iio-backend-add-support-for-filter-config/20250425-192951
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250425112538.59792-12-antoniu.miclaus%40analog.com
patch subject: [PATCH v3 11/11] iio: adc: ad4080: add driver support
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250427/202504270010.w3ZsLDZR-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250427/202504270010.w3ZsLDZR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504270010.w3ZsLDZR-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in lib/tests/slub_kunit.o
>> WARNING: modpost: module ad4080 uses symbol iio_backend_filter_type_set from namespace IIO_BACKEND, but does not import it.
>> WARNING: modpost: module ad4080 uses symbol iio_backend_data_alignment_enable from namespace IIO_BACKEND, but does not import it.
>> WARNING: modpost: module ad4080 uses symbol iio_backend_sync_status_get from namespace IIO_BACKEND, but does not import it.
>> WARNING: modpost: module ad4080 uses symbol iio_backend_num_lanes_set from namespace IIO_BACKEND, but does not import it.
>> WARNING: modpost: module ad4080 uses symbol devm_iio_backend_get from namespace IIO_BACKEND, but does not import it.
>> WARNING: modpost: module ad4080 uses symbol devm_iio_backend_request_buffer from namespace IIO_BACKEND, but does not import it.
>> WARNING: modpost: module ad4080 uses symbol devm_iio_backend_enable from namespace IIO_BACKEND, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

