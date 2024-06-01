Return-Path: <linux-iio+bounces-5572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 016258D6D80
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 04:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252EC286CB4
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 02:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5DC6FC5;
	Sat,  1 Jun 2024 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYbph24F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7CF80C;
	Sat,  1 Jun 2024 02:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717209163; cv=none; b=ktm81jcmt9YYoo73oYviFFwr3dAvnK+q5D8+oJ/LUn6g+/sBuZrgiCM6skP+AnLbk0kV0nz3Xce/D+Tg/8LTJ77JMOozCc+Dmr21mM31lvakPIyCEErHCEJprO1NQBctiLgez0QfOWcZKmSYNWD/VrfcOLUGnBvufN6B3wEaLoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717209163; c=relaxed/simple;
	bh=DiWSyQtftc8aPwNB1nMgQRYl58NlU2baAGwiCrM3a98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/sjdhYxh8rXLvsGlVBmkmEQDe5hJxUVvq1V4aun0OsWU95ayatYsxQuYuEQQ/hbmiRWTczEInwmemc6FBbFtdrlsYwCRE98Z9YEjxEIEOFWC8HGlMqduCKCsSX7JJ1UbxixnLQf72KdoIl2k0PyyUkhprvCQTxlQ4G9OQmyERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYbph24F; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717209162; x=1748745162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DiWSyQtftc8aPwNB1nMgQRYl58NlU2baAGwiCrM3a98=;
  b=dYbph24F7CRKeR9IRL/dTz/Eo7EHZP595Ad0d+txFSzLWwwweig+IEP2
   zL4m1xKYbDH9Le3jqFNAzTHjy9zb2JjUchaf9AurbLWQF3dFL6g2KqKDf
   hbDgRoLEyEW02KPuGFGGh1H7knudlAWAjjxFxSGWv3gAAFhi4tZqfha8R
   EEnj2IUTJk0e44i9dxF6ktHfxM3cvv220B0wAHt6GgF1X0xpS20vQ5C6m
   IeCFb+av2o19CMhECjBghSohYzmYQYXlqUS1A4zlU9DzM5q71wBreYAgu
   KoCgr5JrZbXSKWnAf5Ump8DZBHhLhmtBTuQMpISi+bZ5666CuMkDbaK10
   A==;
X-CSE-ConnectionGUID: PQCk1JFBReiAUSqI7B76tg==
X-CSE-MsgGUID: jDX+qgZpTPSlWt9wwoEP9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="17616811"
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="17616811"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 19:32:42 -0700
X-CSE-ConnectionGUID: 9b6zvCUFTx2Kd9sWoprvDQ==
X-CSE-MsgGUID: /99hga84RqK3PvkY4gZoNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="59512300"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 31 May 2024 19:32:37 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDEXe-000IAX-2g;
	Sat, 01 Jun 2024 02:32:27 +0000
Date: Sat, 1 Jun 2024 10:31:25 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v1 4/4] mfd: lm3533: Remove the driver
Message-ID: <202406011025.2DhlyP3G-lkp@intel.com>
References: <20240531170844.1595468-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531170844.1595468-5-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on lee-backlight/for-backlight-fixes linus/master v6.10-rc1 next-20240531]
[cannot apply to lee-backlight/for-backlight-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/backlight-lm3533_bl-Remove-the-driver/20240601-011153
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240531170844.1595468-5-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 4/4] mfd: lm3533: Remove the driver
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20240601/202406011025.2DhlyP3G-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240601/202406011025.2DhlyP3G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406011025.2DhlyP3G-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mfd/lm3533-ctrlbank.c:13:10: fatal error: 'linux/mfd/lm3533.h' file not found
      13 | #include <linux/mfd/lm3533.h>
         |          ^~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +13 drivers/mfd/lm3533-ctrlbank.c

16c5c023aac862 Johan Hovold 2012-05-03  12  
16c5c023aac862 Johan Hovold 2012-05-03 @13  #include <linux/mfd/lm3533.h>
16c5c023aac862 Johan Hovold 2012-05-03  14  
16c5c023aac862 Johan Hovold 2012-05-03  15  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

