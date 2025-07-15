Return-Path: <linux-iio+bounces-21694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5219DB0640E
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 18:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C675811EF
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 16:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F3B257452;
	Tue, 15 Jul 2025 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SyBoEuAo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2AF22E3F0;
	Tue, 15 Jul 2025 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596058; cv=none; b=n5tjjKA1DJe3hwVYsW1W6ggDsvgEPhWX3XNyAhr+o60bZ91pyss6zfFUXfZJUVu2+c5JxaMHl/38Jaa1D9h9Ze/EgCWXoabca1fsP9mk4kb+QF0Eb0VoIYxQxFCpAAkAeZZWrRkbL3JUmPmhilis90H/stRvX6r0gegPt4oMBy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596058; c=relaxed/simple;
	bh=c/uHX5dNSLCv40QvGTh68kxFNXhn1inqbbQG/CLL6/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beZNg/WSjQJxnpIcr/tT20yzgSMpMun0iMh6ag/5W0EKSK0DYsbDK3n7MorsSqNrvI65/Kv9xYk5dB4ZUZkwSNNvKwIQk6NBHNOPt+byMF/Wv9MHeiR+HaPwYdRvAgZ3dnRKWqIuakriTqWuO6AQc4wYync1/rM4REXZP5cerdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SyBoEuAo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752596056; x=1784132056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c/uHX5dNSLCv40QvGTh68kxFNXhn1inqbbQG/CLL6/E=;
  b=SyBoEuAo3S450xuuoIzNoxkoqbbiXVCI0G4kT0oHHknSq+ZHVRmtzhG1
   MH8RxB+C+R1LTP2GIYT/irXOTT6AQCclnR7wp2xqfdWrLEjajulcYLzhX
   t2t7+O+IrcCdOqmaQiwqcV/8nR9BwnR+asDe5cxLoBzBUl4oQ29YGt78Y
   sOn9waFMj52hRXv6HcjCRfZHTXs/g0nGngw+0flbf+RtcM2RO74PR5H+4
   ah0xuCpouhg+FF9yFWaQMIDthmtIkx7VqDcvvaHD6fUQEQWjcHe1i1GSS
   cfGN92xAveygkRY6lCYJELj0XVhvUyAHr7o/61I+38/oUXxWZTgJC1mLO
   g==;
X-CSE-ConnectionGUID: PMuI3iRQSxiqEVOGnH1EKg==
X-CSE-MsgGUID: Dcs0F1W7Q7OpU8LEk4yLjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="57433583"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="57433583"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 09:14:16 -0700
X-CSE-ConnectionGUID: 2XikLn99QieeIZZx1LAO9Q==
X-CSE-MsgGUID: ajXpIngUTg6t9OjHuWOQnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157989128"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 15 Jul 2025 09:14:13 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubiIE-000BJP-2O;
	Tue, 15 Jul 2025 16:14:10 +0000
Date: Wed, 16 Jul 2025 00:13:49 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH 7/7] hwmon: iio: Add alarm support
Message-ID: <202507152309.wBE1wHwM-lkp@intel.com>
References: <20250715012023.2050178-8-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715012023.2050178-8-sean.anderson@linux.dev>

Hi Sean,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on groeck-staging/hwmon-next akpm-mm/mm-nonmm-unstable linus/master v6.16-rc6 next-20250715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Anderson/math64-Add-div64_s64_rem/20250715-092337
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250715012023.2050178-8-sean.anderson%40linux.dev
patch subject: [PATCH 7/7] hwmon: iio: Add alarm support
config: i386-buildonly-randconfig-001-20250715 (https://download.01.org/0day-ci/archive/20250715/202507152309.wBE1wHwM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250715/202507152309.wBE1wHwM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507152309.wBE1wHwM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/hwmon/iio_hwmon.c:99 function parameter 'chan' not described in 'iio_event_id'
>> Warning: drivers/hwmon/iio_hwmon.c:99 Excess function parameter 'channel' description in 'iio_event_id'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

