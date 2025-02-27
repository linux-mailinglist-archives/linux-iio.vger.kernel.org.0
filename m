Return-Path: <linux-iio+bounces-16154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B98A489C5
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 21:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A41167134
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 20:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3449226FA69;
	Thu, 27 Feb 2025 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fxqR8xdz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375EE1D6182;
	Thu, 27 Feb 2025 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687841; cv=none; b=jUQDUyYTtMSlTjjJxIjpRsrHrLM2u6QAv8rQkRZBgt8ixqLshyNLzRfy8rLLAsiqo4z4FhX8tjT/oGzfxGJ0pd/DrpgyjEwjUR2iN/6mktVI2by3F91Fl7nwrVIz+5MtGuREpUO7nAHR8VWwpjX6+QYO9dBxATeIUrtl+UzGZTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687841; c=relaxed/simple;
	bh=087oTqi7W/0v4LMaQVYrNt/Vn/vLmPYte2/gxXwYs7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/jWpK8nwy5ojKK+keDqp1sfftlP7E9PRLqhiIoajoL2D1ueQI6NdTbQHaf4cWinr9VhhlFooYtYdFmc/RRDe9pZyqD845sOJO/oWXQxHDZi/mPtQtXrbEQHyP5DZkq0tjJpJs5zdYdU2CGTj8ENFhUHwHzUiorNWf2YRzTb7w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fxqR8xdz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740687839; x=1772223839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=087oTqi7W/0v4LMaQVYrNt/Vn/vLmPYte2/gxXwYs7M=;
  b=fxqR8xdzkWROSEDflB/PhDsHRjn3s5ZkE8qGJ9NooWZRK5fxxvuryq5Z
   bOwXoZyrFlCPPbZEAoY1pDFKHi41n/sCdlBk2Sf7m/a4lJKPMNz/IUB6H
   u4c9TZC9Zb9XqCtmd3Gr9BEqGlxFqw4DMPYuyRWMsk+XuDvMrHALc6GHe
   GBgFlkE7C1cu0GZDOHag68RbztzUqJ4+yfX4hiQTkMrwZlEIvkluiinVU
   T3YjAsXlFkFuZfRa4s0OmwqWs+MxSfQCElSWksBt3v4yW1/iEngBvmzPW
   FhIs7OkknQmf5p9Qx0L+FVo4a8B4YUKZrhC4riU8E1aH9Yy6gpgr4cLcx
   g==;
X-CSE-ConnectionGUID: 9pdOPdRiRQK5rb7uJeVJ0g==
X-CSE-MsgGUID: jZWpvrURRUuEZYWAJJS9wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="59136985"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="59136985"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 12:23:58 -0800
X-CSE-ConnectionGUID: YYk+nKDITXqOX//VMMIa2A==
X-CSE-MsgGUID: g4hpkXe2Rc2ezkQwBiZMsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118056318"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 27 Feb 2025 12:23:55 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnkQC-000Dzi-1g;
	Thu, 27 Feb 2025 20:23:52 +0000
Date: Fri, 28 Feb 2025 04:23:44 +0800
From: kernel test robot <lkp@intel.com>
To: Sam Winchenbach <sam.winchenbach@framepointer.org>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, lars@metafoo.de,
	Michael.Hennerich@analog.com, antoniu.miclaus@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, sam.winchenbach@framepointer.org
Subject: Re: [PATCH v4 1/2] iio: filter: admv8818: fix range calculation
Message-ID: <202502280434.DHtcsf7x-lkp@intel.com>
References: <20250225134612.577022-1-sam.winchenbach@framepointer.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225134612.577022-1-sam.winchenbach@framepointer.org>

Hi Sam,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.14-rc4 next-20250227]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sam-Winchenbach/dt-bindings-iio-filter-Add-lpf-hpf-freq-margins/20250225-215003
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250225134612.577022-1-sam.winchenbach%40framepointer.org
patch subject: [PATCH v4 1/2] iio: filter: admv8818: fix range calculation
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20250228/202502280434.DHtcsf7x-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 204dcafec0ecf0db81d420d2de57b02ada6b09ec)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280434.DHtcsf7x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502280434.DHtcsf7x-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iio/filter/admv8818.c:17:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:549:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     549 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:567:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     567 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/iio/filter/admv8818.c:17:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/iio/filter/admv8818.c:17:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:601:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     601 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:616:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     616 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:631:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     631 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:724:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     724 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:737:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     737 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:750:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     750 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:764:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     764 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:778:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     778 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:792:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     792 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/iio/filter/admv8818.c:304:34: error: use of undeclared identifier 'lfp_corner_target'; did you mean 'lpf_corner_target'?
     304 |         ret = __admv8818_lpf_select(st, lfp_corner_target);
         |                                         ^~~~~~~~~~~~~~~~~
         |                                         lpf_corner_target
   drivers/iio/filter/admv8818.c:283:25: note: 'lpf_corner_target' declared here
     283 |         u64 hpf_corner_target, lpf_corner_target;
         |                                ^
   12 warnings and 1 error generated.


vim +304 drivers/iio/filter/admv8818.c

   279	
   280	static int admv8818_rfin_band_select(struct admv8818_state *st)
   281	{
   282		int ret;
   283		u64 hpf_corner_target, lpf_corner_target;
   284	
   285		st->cf_hz = clk_get_rate(st->clkin);
   286	
   287		// Check for underflow
   288		if (st->cf_hz > st->hpf_margin_hz)
   289			hpf_corner_target = st->cf_hz - st->hpf_margin_hz;
   290		else
   291			hpf_corner_target = 0;
   292	
   293		// Check for overflow
   294		lpf_corner_target = st->cf_hz + st->lpf_margin_hz;
   295		if (lpf_corner_target < st->cf_hz)
   296			lpf_corner_target = U64_MAX;
   297	
   298		mutex_lock(&st->lock);
   299	
   300		ret = __admv8818_hpf_select(st, hpf_corner_target);
   301		if (ret)
   302			goto exit;
   303	
 > 304		ret = __admv8818_lpf_select(st, lfp_corner_target);
   305	exit:
   306		mutex_unlock(&st->lock);
   307		return ret;
   308	}
   309	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

