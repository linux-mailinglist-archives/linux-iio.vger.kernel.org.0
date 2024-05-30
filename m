Return-Path: <linux-iio+bounces-5515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D5F8D5215
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 21:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08EEAB23012
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 19:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FDB6CDAC;
	Thu, 30 May 2024 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFvLKQHQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CFD6BB2F;
	Thu, 30 May 2024 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717096106; cv=none; b=ploob3XSx6vd33cLPDfjZgaxVwq/fwsCg6Uvd2a7HGtUffpOW+K4C4yCJF5uMwij5QtVCGbYTzWQy/oUNhUTzypfUgvWwtJo3Q29K1uk6S6FrPu5ADw4dLNs9cREM6k90+Ri7eah8FPMKWOp8xE3I865rDA9LtDkpruaO0FoPFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717096106; c=relaxed/simple;
	bh=J9C6kO4Qnm3SIy6qu36uHOXAGQu0iLuift5pleMUPqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaW0JruVTaZ04hFdY6F5Kt5Wx6Bd5hxDGhJCFcEE4MYO5AlAxgvwBjVBEINnTKb8zSd+Y5MXcI7bccs+swraNfDHmA8nWPYvTmtJI6867tHY9ibjW3IMfLLBhMTOW4/jv8I5npDh9QaYV5iS9ZcSqzbpZ2/W5ZpZOYmEtK5OlBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFvLKQHQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717096104; x=1748632104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J9C6kO4Qnm3SIy6qu36uHOXAGQu0iLuift5pleMUPqU=;
  b=oFvLKQHQWvSXs34Yreyq5Xx9nZnHfpCHMDt1TFgLaSe6mBjxCp4GIv9q
   KD+KmBhfFC5ln3Tjw7PFC8ezs6yu0eFVZNBfHrYIyzKL3xnx0DPOukAwy
   ZT8epYZeOcqJri8rWp/o7NYsoH9IgPEKTNOj/OkootxNPz10V8zzDcoH+
   RbKAAZ0EJD4pewEFqS1JGID0CLRHzASRmzzyrBOrJhVXPRvAYF0K3V513
   iS4MpgiaKjZd6jXb/aCL29GNSLXsXnZdObHSruZsGklpLIqDt+uMsDknf
   IQMIvh1jPgq8w31fx16SAfKUeCkD33Cs7xO4LvkUgp9K6X8kiRGQapNWR
   g==;
X-CSE-ConnectionGUID: Lcr0gJD/R6CAnE56sl/Xxg==
X-CSE-MsgGUID: VcZJ4eCVSBScNs2V2DvEyg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="38999084"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="38999084"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 12:08:24 -0700
X-CSE-ConnectionGUID: HlZbjENSRqqfz0oTLSadTA==
X-CSE-MsgGUID: NGvTnQpYSJqbeZHtiFaHhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="67105272"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 30 May 2024 12:08:21 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCl8N-000Fsd-14;
	Thu, 30 May 2024 19:08:19 +0000
Date: Fri, 31 May 2024 03:07:53 +0800
From: kernel test robot <lkp@intel.com>
To: Yasin Lee <yasin.lee.x@outlook.com>, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andy.shevchenko@gmail.com,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, nuno.a@analog.com,
	swboyd@chromium.org, u.kleine-koenig@pengutronix.de,
	yasin.lee.x@gmail.com, yasin.lee.x@outlook.com
Subject: Re: [PATCH v3 2/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor
 driver
Message-ID: <202405310327.5dCrF4gX-lkp@intel.com>
References: <SN7PR12MB81019AB7F38806097F2C8A34A4F22@SN7PR12MB8101.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB81019AB7F38806097F2C8A34A4F22@SN7PR12MB8101.namprd12.prod.outlook.com>

Hi Yasin,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v6.10-rc1 next-20240529]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yasin-Lee/iio-proximity-hx9023s-Add-TYHX-HX9023S-sensor-driver/20240529-170307
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/SN7PR12MB81019AB7F38806097F2C8A34A4F22%40SN7PR12MB8101.namprd12.prod.outlook.com
patch subject: [PATCH v3 2/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor driver
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20240531/202405310327.5dCrF4gX-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240531/202405310327.5dCrF4gX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405310327.5dCrF4gX-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/iio/proximity/hx9023s.o: in function `hx9023s_read_raw':
>> hx9023s.c:(.text+0x1c76): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

