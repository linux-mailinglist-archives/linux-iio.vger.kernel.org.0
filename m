Return-Path: <linux-iio+bounces-15611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE353A37716
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 20:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2B4C7A175E
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 19:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F0F1A238E;
	Sun, 16 Feb 2025 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEY7xmFB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E04119ABC2;
	Sun, 16 Feb 2025 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739732990; cv=none; b=HXAGnvzzlQkPPYHIjSVkawnSpIEyuGDXyOqBqSn9FTnbtWVfBkygB2HqX7XKQVRB293b3J4mAS0UdA20ppVcQLK6JVI6mmj+HBZUaHgT3GHKNYlTD5lu/UzTQoobn+cmpi7PFBeTwEOfaRBVtYiKO6N5fkp1kbLKA2Ua1w/+lBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739732990; c=relaxed/simple;
	bh=43PE+ybG5ai0fUI2JHrGDr+HV775T2akdlm+svW1kak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoLshK6352PacgfLIGZyeaxpCiENCYTWE78Hh0XnUKl1k7MlTt6YXjrZzguY3dHIdE0rTStmK+q98ZKnehg+6eD4eAeEy6rVrIuUNQkdViWNx9G00iljQ0qzoRJWzs1ejIbbM6eChj2cnpFcoNFnXxvp1BfBU10+kpHB2yEDxUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VEY7xmFB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739732989; x=1771268989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=43PE+ybG5ai0fUI2JHrGDr+HV775T2akdlm+svW1kak=;
  b=VEY7xmFBWWf7LK0QwAlykE6fB13KxHNb6Nghasvap70CD8ys6ar8FDKV
   2lqmw0QYiIUGZaIlIyWH5qbE3IhH1DE29G6DJFu92tHmWUN/En2fbXqLm
   F3TMNYd3c2apCycrdE6RlP/iCxRKE0sbckmXJDMZwHb9rme3jKMqA2x7P
   4QcbHGN2QCBRa34u/V0PkVTtZy/cAhcz3RBYDzv+iOqOMT6ymvmWxedE+
   R9l7hAUM8JD5cJvoVJeotg4B2vatCMPA9PyuqfLKY0wGSj8In1RhzRjRX
   +njLMUMKLfnfSAeD2w0CxytMBRIFSeJAPhorFMHlWYr60IS/Dc48ZZBIN
   w==;
X-CSE-ConnectionGUID: mC0xVXLCS1OaXdKV1S3KAQ==
X-CSE-MsgGUID: J77sd33ES4ySkRkSaB1+1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="65773639"
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="65773639"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 11:09:48 -0800
X-CSE-ConnectionGUID: njlfmQXoREanvy8Syb5NEQ==
X-CSE-MsgGUID: 1GY4+8dWSIqT3AFVwTJAUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="113811061"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 Feb 2025 11:09:43 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjk1M-001CAl-2r;
	Sun, 16 Feb 2025 19:09:40 +0000
Date: Mon, 17 Feb 2025 03:09:36 +0800
From: kernel test robot <lkp@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Heidelberg <david@ixit.cz>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: light: Add support for AL3000a illuminance
 sensor
Message-ID: <202502170243.eNwe0AL0-lkp@intel.com>
References: <20250216162721.124834-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216162721.124834-3-clamor95@gmail.com>

Hi Svyatoslav,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.14-rc2 next-20250214]
[cannot apply to jic23-iio/togreg]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Svyatoslav-Ryhel/dt-bindings-iio-light-al3010-add-al3000a-support/20250217-002927
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250216162721.124834-3-clamor95%40gmail.com
patch subject: [PATCH v3 2/3] iio: light: Add support for AL3000a illuminance sensor
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250217/202502170243.eNwe0AL0-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250217/202502170243.eNwe0AL0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502170243.eNwe0AL0-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from drivers/iio/light/al3000a.c:4:
>> drivers/iio/light/al3000a.c:202:26: error: 'al3010_id' undeclared here (not in a function); did you mean 'al3000a_id'?
     202 | MODULE_DEVICE_TABLE(i2c, al3010_id);
         |                          ^~~~~~~~~
   include/linux/module.h:250:15: note: in definition of macro 'MODULE_DEVICE_TABLE'
     250 | extern typeof(name) __mod_device_table__##type##__##name                \
         |               ^~~~
>> include/linux/module.h:250:21: error: '__mod_device_table__i2c__al3010_id' aliased to undefined symbol 'al3010_id'
     250 | extern typeof(name) __mod_device_table__##type##__##name                \
         |                     ^~~~~~~~~~~~~~~~~~~~
   drivers/iio/light/al3000a.c:202:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
     202 | MODULE_DEVICE_TABLE(i2c, al3010_id);
         | ^~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from al3000a.c:4:
   al3000a.c:202:26: error: 'al3010_id' undeclared here (not in a function); did you mean 'al3000a_id'?
     202 | MODULE_DEVICE_TABLE(i2c, al3010_id);
         |                          ^~~~~~~~~
   include/linux/module.h:250:15: note: in definition of macro 'MODULE_DEVICE_TABLE'
     250 | extern typeof(name) __mod_device_table__##type##__##name                \
         |               ^~~~
>> include/linux/module.h:250:21: error: '__mod_device_table__i2c__al3010_id' aliased to undefined symbol 'al3010_id'
     250 | extern typeof(name) __mod_device_table__##type##__##name                \
         |                     ^~~~~~~~~~~~~~~~~~~~
   al3000a.c:202:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
     202 | MODULE_DEVICE_TABLE(i2c, al3010_id);
         | ^~~~~~~~~~~~~~~~~~~


vim +202 drivers/iio/light/al3000a.c

   197	
   198	static const struct i2c_device_id al3000a_id[] = {
   199		{"al3000a", },
   200		{}
   201	};
 > 202	MODULE_DEVICE_TABLE(i2c, al3010_id);
   203	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

