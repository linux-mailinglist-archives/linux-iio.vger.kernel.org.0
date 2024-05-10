Return-Path: <linux-iio+bounces-4925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C978C24E3
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 14:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121D628152B
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 12:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5528B16F82A;
	Fri, 10 May 2024 12:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4gn41EP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6310816D4DF;
	Fri, 10 May 2024 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344212; cv=none; b=V/WauXrw8maerT4rWYN5eUYW2VzQOLGXdiZj4v/oZS1labWcTQmMAfIp0zjX8k1KBDdJT8z3IBdPNIqE9AEjViHjeaNpGafEIYkJl9g7as6AkxBPJfeI9ys0fmJcOeBlKXzgmX78slYQf/eBYb0CY8J38lMXbjqv1pOg8zY9fA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344212; c=relaxed/simple;
	bh=11RXuL0ZvlTdxUPPzXosyvDPvDTezfS8XZOnSQLvLt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzqwOWcgfOKRH60jcgX1qoMUZg8fLI7OuHZgwYzgVicX5eaCjUsArWhsC+WFYlwltpe22MQa1IOcJ0OfQkaMMf7dYMYIsF8VHSOSgEbnj1xKcf2lHoKO3grq+kTaIg4nTeTRNuIiAeoAJ3WbrKkbaUTGSeIhvuPFFOiTdRZ+tZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4gn41EP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715344210; x=1746880210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=11RXuL0ZvlTdxUPPzXosyvDPvDTezfS8XZOnSQLvLt4=;
  b=L4gn41EPOlxE1FizhbvXvGGwJIC6GOANiE4eRanEkMvVhngsy5NFf0YU
   /NqGbyFE+WMbTYP0G+ELywtKgGJFSg/dJxI7x7llLqgyCxEJO3eBpPs3+
   +RNVL/0Kg1StyyJFK+Ko+mtJv+K4YMCMOpOdk/nUweVMOXF1KUAk4iOcz
   hWxLHP7Np1atnfXNiRpjpcTJPclMT2IJPGfsHEVSMIpEEeACGTo7eS7VJ
   kljSa3R5u4l8fk7FAJAZk6y9cK1KYugeGMYQWFtf7rYj0x3eF3rU+fuXA
   +vvUPgaZ+uVgLv0A0YEd4VWUXA8/sqvi+BuInfcxi08SU6WKGeizL6Mtx
   w==;
X-CSE-ConnectionGUID: 5VSJy6z5Rmi/Fh3UZCajug==
X-CSE-MsgGUID: wRT4T2BDS4SjNetqmDzoPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="28832847"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="28832847"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 05:30:09 -0700
X-CSE-ConnectionGUID: Tnc5xe9LSFCkD0JD2WoBrQ==
X-CSE-MsgGUID: o/Q84inkQwWuL3RmWgHJ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="60771038"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 May 2024 05:30:07 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5PO0-00068Y-2g;
	Fri, 10 May 2024 12:30:04 +0000
Date: Fri, 10 May 2024 20:29:14 +0800
From: kernel test robot <lkp@intel.com>
To: Yasin Lee <yasin.lee.x@outlook.com>, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lars@metafoo.de, swboyd@chromium.org,
	nuno.a@analog.com, andy.shevchenko@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, yasin.lee.x@gmail.com,
	yasin.lee.x@outlook.com
Subject: Re: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor
 driver
Message-ID: <202405102039.QdXzki1Z-lkp@intel.com>
References: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>

Hi Yasin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.9-rc7 next-20240510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yasin-Lee/iio-proximity-hx9031as-Add-TYHX-HX9031AS-HX9023S-sensor-driver/20240510-173839
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/SN7PR12MB8101EDFA7F91A59761095A28A4E72%40SN7PR12MB8101.namprd12.prod.outlook.com
patch subject: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor driver
reproduce: (https://download.01.org/0day-ci/archive/20240510/202405102039.QdXzki1Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405102039.QdXzki1Z-lkp@intel.com/

versioncheck warnings: (new ones prefixed by >>)
   INFO PATH=/opt/cross/rustc-1.76.0-bindgen-0.65.1/cargo/bin:/opt/cross/clang-18/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 3h /usr/bin/make KCFLAGS= -Wtautological-compare -Wno-error=return-type -Wreturn-type -Wcast-function-type -funsigned-char -Wundef -fstrict-flex-arrays=3 -Wformat-overflow -Wformat-truncation -Wenum-conversion W=1 --keep-going LLVM=1 -j32 ARCH=x86_64 versioncheck
   find ./* \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o \
   	-name '*.[hcS]' -type f -print | sort \
   	| xargs perl -w ./scripts/checkversion.pl
   ./drivers/accessibility/speakup/genmap.c: 13 linux/version.h not needed.
   ./drivers/accessibility/speakup/makemapdata.c: 13 linux/version.h not needed.
>> ./drivers/iio/proximity/hx9031as.c: 16 linux/version.h not needed.
   ./drivers/staging/media/atomisp/include/linux/atomisp.h: 23 linux/version.h not needed.
   ./samples/bpf/spintest.bpf.c: 8 linux/version.h not needed.
   ./samples/trace_events/trace_custom_sched.c: 11 linux/version.h not needed.
   ./sound/soc/codecs/cs42l42.c: 14 linux/version.h not needed.
   ./tools/lib/bpf/bpf_helpers.h: 410: need linux/version.h
   ./tools/testing/selftests/bpf/progs/dev_cgroup.c: 9 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/netcnt_prog.c: 3 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_map_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_send_signal_kern.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_spin_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_tcp_estats.c: 37 linux/version.h not needed.
   ./tools/testing/selftests/wireguard/qemu/init.c: 27 linux/version.h not needed.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

