Return-Path: <linux-iio+bounces-15802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81716A3C66F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 18:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA061895776
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 17:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3A02144D7;
	Wed, 19 Feb 2025 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+JeniPh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332171F461F;
	Wed, 19 Feb 2025 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986999; cv=none; b=HubQI3/m3yuXBIQe8t6R5SMketIomEgEhoORpDZVaBjh/7/YPVfJrlbmYLJ2O7Ys1i+DHFv2oXrch0gT8Ri6z4VxIm4cZQUsGTQ0zP99CyVoS43Nu+l/SqIBa+qFtU7cuLdR2WuU17TpuQJHtLhTePWZkpE09jtUfXoEpJen7ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986999; c=relaxed/simple;
	bh=dVqwsB+tDW/tubytCSFMsupA26ImOk8sdT2JruUEV3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puNgAGl/tQFCyryRpekTM9mEMxg8m2uDcsNuNmQwXTn/rw0IpzbQgBtpWqLGONLD1LGQmihChOzRDSVwhk1Y8DESE2DbLomg30TcDRyCSbfG22zOVs+3/p0JmiRScDQZA+dTig9LiVa2+/dERkFFm55UBHMvb/t/IyLtUYFKWL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f+JeniPh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739986997; x=1771522997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dVqwsB+tDW/tubytCSFMsupA26ImOk8sdT2JruUEV3Y=;
  b=f+JeniPhzzODmwFbCk/ikiCxbnM6XYyWt4LlfomIC+Nky+y87Gz4HVwn
   T1B3qEvkq1M844TpSYN58qrL7nkeR7kzolsAzpmLCbuz/Y3IF1BDvaoIZ
   vcvQk+IiA/KD/yNdrU/m8AFiOfbtrDTBuzOU+z3KgSW3C1mB0fKtFZ1Y/
   PT8URY1Kh77y1b7SHXMcDFmjYpKcZ2HQO5c89NafZ7bPalHN1g4lhcZA5
   mhHvVHQYmrLzJIVQtq1x2AshDNXfX3HhRU6TqPArLC0/ksdlTOvRvzSJX
   L88jc/EIQNw/Ax2FJVixlZeXCqtZPKssvk7zHozlj9uyjSc2rJdX65i0H
   w==;
X-CSE-ConnectionGUID: RwHKtmJ/Th6wQqd8KZ5aQQ==
X-CSE-MsgGUID: PT/c6h9CTNOIDSIWLZn0Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40997507"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40997507"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:43:16 -0800
X-CSE-ConnectionGUID: +OXqpB3PT8iVUOVncg8zuQ==
X-CSE-MsgGUID: kxVG89nZRHyvI85adQqrZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114614079"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 19 Feb 2025 08:04:04 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkmXb-00038M-04;
	Wed, 19 Feb 2025 16:03:29 +0000
Date: Thu, 20 Feb 2025 00:02:51 +0800
From: kernel test robot <lkp@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: lm3533: convert to use OF
Message-ID: <202502192343.twEQ3SSs-lkp@intel.com>
References: <20250218132702.114669-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132702.114669-3-clamor95@gmail.com>

Hi Svyatoslav,

kernel test robot noticed the following build errors:

[auto build test ERROR on lee-mfd/for-mfd-next]
[also build test ERROR on lee-leds/for-leds-next robh/for-next linus/master v6.14-rc3 next-20250219]
[cannot apply to lee-mfd/for-mfd-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Svyatoslav-Ryhel/dt-bindings-mfd-Document-TI-LM3533-MFD/20250218-212857
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20250218132702.114669-3-clamor95%40gmail.com
patch subject: [PATCH v2 2/2] mfd: lm3533: convert to use OF
config: i386-buildonly-randconfig-003-20250219 (https://download.01.org/0day-ci/archive/20250219/202502192343.twEQ3SSs-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250219/202502192343.twEQ3SSs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502192343.twEQ3SSs-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/iio/iio.h:10,
                    from drivers/iio/light/lm3533-als.c:15:
>> drivers/iio/light/lm3533-als.c:921:25: error: 'lm3533_match_table' undeclared here (not in a function); did you mean 'lm3533_als_match_table'?
     921 | MODULE_DEVICE_TABLE(of, lm3533_match_table);
         |                         ^~~~~~~~~~~~~~~~~~
   include/linux/module.h:250:15: note: in definition of macro 'MODULE_DEVICE_TABLE'
     250 | extern typeof(name) __mod_device_table__##type##__##name                \
         |               ^~~~
   include/linux/module.h:250:21: error: '__mod_device_table__of__lm3533_match_table' aliased to undefined symbol 'lm3533_match_table'
     250 | extern typeof(name) __mod_device_table__##type##__##name                \
         |                     ^~~~~~~~~~~~~~~~~~~~
   drivers/iio/light/lm3533-als.c:921:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
     921 | MODULE_DEVICE_TABLE(of, lm3533_match_table);
         | ^~~~~~~~~~~~~~~~~~~


vim +921 drivers/iio/light/lm3533-als.c

   916	
   917	static const struct of_device_id lm3533_als_match_table[] = {
   918		{ .compatible = "ti,lm3533-als" },
   919		{ },
   920	};
 > 921	MODULE_DEVICE_TABLE(of, lm3533_match_table);
   922	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

