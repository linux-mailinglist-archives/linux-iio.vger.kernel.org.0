Return-Path: <linux-iio+bounces-5571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB018D6D26
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 02:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378541F2289B
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 00:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39D517F6;
	Sat,  1 Jun 2024 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UpxAf4vx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B550CEDC;
	Sat,  1 Jun 2024 00:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717201659; cv=none; b=l1PQjcLuz/8ftiA3HppW76ujN9MtAgLWYepROVGIp1vj/k65bJJix1eD/yrLV0JnY3k9nRFnNcxkDkBKc1hW09z7GDW5taSh/ZecrpiNe5EOfvLTfqTLBTz+pNsW2LD0GrBwB8+FJpoPgcjx3TI0rCidAvjJ3BiIjs9XrjvGKQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717201659; c=relaxed/simple;
	bh=pzkQzkll9BnxvY6yoADX3c1dvUwawuIjZ6ByCbhdF+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6NtPY89KzUDoPRhLqU/OSkk+pWJ0yJT5y1gba7UIVzWkciswPooaQkbGrMdBO1JAKr7/GucGdNtExZNMOnf0+BrJCurhzHMI7M50eAMhCq18IoJWOFfXdCTyNvsadv4QvG356Y3qCKVTXwQQBM4Vku6XV0NhpJ9q3wm3dGe2K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UpxAf4vx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717201657; x=1748737657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pzkQzkll9BnxvY6yoADX3c1dvUwawuIjZ6ByCbhdF+o=;
  b=UpxAf4vxRPcg/VEKmNSYgkGyZx9MGhHRCjgsZUCXoQOQIUKIglDpMnYt
   JKhDzAxJIZxYQuU1IcPxEcTzaTXqm4N1R8Xnj9z5pWmqbT5ar3FnLXaQc
   PqpOo1J8yHyNGuxK0pt6njKqo0tuam7hVSpwT9bp8WwejXrC8Y8N2ttu6
   xQsv7q7fNLh+NR90KJB4vdIKJHS31kk5iG4vu6ZZAXOic/vup+Iqjx4dV
   AhPyQ/3TnPGLQReimkZ9+9IP1MovGFUiRr3kSGGvFenKgd8U37LPAMt8J
   Va2eoLcNpn1id5YnX3IZjIhMvrAurUsljzclpweLrC6vhM7vCg53W/U2q
   A==;
X-CSE-ConnectionGUID: BYs/wzKbS8qsK2BEoEnYSw==
X-CSE-MsgGUID: MaY0U9VGR/u7hs2uJl9OAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="36299249"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="36299249"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 17:27:36 -0700
X-CSE-ConnectionGUID: ZHnSF2voQwq5GZgRwjZgUQ==
X-CSE-MsgGUID: IIS8T1viRr6mGLi6evRQjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="36237179"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 31 May 2024 17:27:33 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDCao-000I23-1E;
	Sat, 01 Jun 2024 00:27:30 +0000
Date: Sat, 1 Jun 2024 08:27:10 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Lars-Peter Clausen <lars@metafoo.de>,
	Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v1 4/4] mfd: lm3533: Remove the driver
Message-ID: <202406010822.oVBEReGC-lkp@intel.com>
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
[cannot apply to lee-backlight/for-backlight-next pavel-leds/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/backlight-lm3533_bl-Remove-the-driver/20240601-011153
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240531170844.1595468-5-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 4/4] mfd: lm3533: Remove the driver
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240601/202406010822.oVBEReGC-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240601/202406010822.oVBEReGC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406010822.oVBEReGC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mfd/lm3533-ctrlbank.c:13:10: fatal error: linux/mfd/lm3533.h: No such file or directory
      13 | #include <linux/mfd/lm3533.h>
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +13 drivers/mfd/lm3533-ctrlbank.c

16c5c023aac862 Johan Hovold 2012-05-03  12  
16c5c023aac862 Johan Hovold 2012-05-03 @13  #include <linux/mfd/lm3533.h>
16c5c023aac862 Johan Hovold 2012-05-03  14  
16c5c023aac862 Johan Hovold 2012-05-03  15  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

