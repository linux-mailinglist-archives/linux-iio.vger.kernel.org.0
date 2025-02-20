Return-Path: <linux-iio+bounces-15882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB314A3E256
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 18:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8DFF3A6C96
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 17:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28691C1F02;
	Thu, 20 Feb 2025 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1UlwNEi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA9E1B0F33;
	Thu, 20 Feb 2025 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071848; cv=none; b=a/d90Vh96cXvrf89Dwtp1I86Ecnma+lJZ55PkqjT2JVI7Ep1L6xI5wV3gjT5otDTzk1sECPvu1fKAbKMfAxlQqB1UkSMnrBs1GR9xEhl5eQqnwLosLDuYpmSIZ35mtSOck8ISaTrXy0wtbBSBkqY6FzfdcQHJM6pjK5iI3fnivk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071848; c=relaxed/simple;
	bh=7CGSKMHde5rIbG0LCV4dYgFBgSrYGZsf7bUx73BQ6NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q089oG2vFZsIRxxwd0JYAXeynxAp/LZc15mZbjCqar1OJ2JOVRmsQYLdIv58BTIEji5lVNfGQKFeRBcuhlXNwqzbvOuvCevBLzZSKEhnme0rdB3hI18REjGaziIF7r+umP2NbSH+Hl+0qrJ5NJACJioc2yV4cIPTelt7DYCB53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1UlwNEi; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740071847; x=1771607847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7CGSKMHde5rIbG0LCV4dYgFBgSrYGZsf7bUx73BQ6NI=;
  b=m1UlwNEiURLv13OrYuyD7yEvIe7siq1TMLEJW9xTlAtXjEWN3POiidNY
   5LGn21g4l5qoBOcucup+KimAoLYA2Q4JsLRNGMNvuWuuxaOJrRYS2/kvk
   kzJ48/Un6Xslp9cOCTXgeztUx6cz+DF2+3TtJgt0oY4F5T3qYORwse3Xg
   Ed0oj6LWY3ZFO8ZVihwGdh/YQv+9g6QS7oikOKluJKO6VmCb8KGmY+ivS
   SqV6bfTmN/KexWk0/b7BFLoRsa2gY7ejSZsM+wr3m99ArSzmjiOIleKuC
   NLgYb0d9XKjBpNM2nSYbWHDOO+/0PHWNnxjGwImcLM3PceIwDz9KVL6Sa
   w==;
X-CSE-ConnectionGUID: 2Ffmd/pzRKuhaOkOjrwmIg==
X-CSE-MsgGUID: kNP26O+kR5yeF+6Q0YJQtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="66227618"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="66227618"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:17:26 -0800
X-CSE-ConnectionGUID: G3FJM02tRbOugVssdF5ZIg==
X-CSE-MsgGUID: niWiQBFIQH6uYj+yoBl1JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116001418"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 20 Feb 2025 09:17:24 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlAAr-0004Zj-2i;
	Thu, 20 Feb 2025 17:17:21 +0000
Date: Fri, 21 Feb 2025 01:16:32 +0800
From: kernel test robot <lkp@intel.com>
To: Jun Yan <jerrysteve1101@gmail.com>, jic23@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: Re: [PATCH 1/2] iio: gyro: bmg160_spi: add of_match_table
Message-ID: <202502210125.5IaR1YAL-lkp@intel.com>
References: <20250219150254.24664-2-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219150254.24664-2-jerrysteve1101@gmail.com>

Hi Jun,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.14-rc3 next-20250220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jun-Yan/iio-gyro-bmg160_spi-add-of_match_table/20250219-231024
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250219150254.24664-2-jerrysteve1101%40gmail.com
patch subject: [PATCH 1/2] iio: gyro: bmg160_spi: add of_match_table
config: i386-buildonly-randconfig-005-20250220 (https://download.01.org/0day-ci/archive/20250221/202502210125.5IaR1YAL-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250221/202502210125.5IaR1YAL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502210125.5IaR1YAL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/gyro/bmg160_spi.c:57:3: error: member reference base type 'const struct of_device_id[4]' is not a structure or union
      56 |                 .of_match_table = bmg160_of_match
         |                                   ~~~~~~~~~~~~~~~
      57 |                 .pm     = &bmg160_pm_ops,
         |                 ^~~
   1 error generated.


vim +57 drivers/iio/gyro/bmg160_spi.c

c266686477490d Jun Yan                   2025-02-19  52  
b1d125cc623639 Markus Schneider-Pargmann 2015-08-19  53  static struct spi_driver bmg160_spi_driver = {
b1d125cc623639 Markus Schneider-Pargmann 2015-08-19  54  	.driver = {
b1d125cc623639 Markus Schneider-Pargmann 2015-08-19  55  		.name	= "bmg160_spi",
c266686477490d Jun Yan                   2025-02-19  56  		.of_match_table = bmg160_of_match
b1d125cc623639 Markus Schneider-Pargmann 2015-08-19 @57  		.pm	= &bmg160_pm_ops,
b1d125cc623639 Markus Schneider-Pargmann 2015-08-19  58  	},
b1d125cc623639 Markus Schneider-Pargmann 2015-08-19  59  	.probe		= bmg160_spi_probe,
b1d125cc623639 Markus Schneider-Pargmann 2015-08-19  60  	.remove		= bmg160_spi_remove,
b1d125cc623639 Markus Schneider-Pargmann 2015-08-19  61  	.id_table	= bmg160_spi_id,
b1d125cc623639 Markus Schneider-Pargmann 2015-08-19  62  };
b1d125cc623639 Markus Schneider-Pargmann 2015-08-19  63  module_spi_driver(bmg160_spi_driver);
b1d125cc623639 Markus Schneider-Pargmann 2015-08-19  64  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

