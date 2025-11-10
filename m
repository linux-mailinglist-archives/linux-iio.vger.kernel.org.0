Return-Path: <linux-iio+bounces-26127-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEE5C45E4A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 11:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE6964E9E20
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 10:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25F73016E6;
	Mon, 10 Nov 2025 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZPXmRW/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E4C2F7AAC;
	Mon, 10 Nov 2025 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769913; cv=none; b=l7dShqM8dNtbPJ833oAxJKbNxC2LBOt3RLkNRxooeRRz6zENEta33ZQJSU8pGth9s0GF5ZqsTav1en3uODa4qfzwZ8QI2O/TlSzAjo5MJCmOPhW0CcvchoxKRRgfCmBlJYzIHK4h594tuuGU1nNdGa2QsSvJ+yvqDqK/UDo1bgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769913; c=relaxed/simple;
	bh=e3PCZB+6Yrv72SbD8Y/ik1Ae4wkWt0aagsodthP5aYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a72Epi0EuYKPtpQ4p/C/dguG5ONG4HXZQKVqvaKqHAKgJXVtW2Ol9J8uxv9+gQ2GBXsBOfw4UHjy+M7bE38hZ0XEKAvpQgX9nyX8+OSkPkd8ipsnCE5KRFnS6iDSYI3DSTpZpLVn7CVNrPFwFz6z3f4azO9JcfTP6P1B3J4kF4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZPXmRW/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762769911; x=1794305911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e3PCZB+6Yrv72SbD8Y/ik1Ae4wkWt0aagsodthP5aYs=;
  b=GZPXmRW/l03gPTDZERsgQyx14w5XaPPSl70V9LZO0gQw6Sz47HydI0DS
   lteRxEsdtqbioTqgDEpPcKFFuVPFdDImatxbqORLyONhM1+I6NGV64MmE
   l7nd0C0F8SJaOXhF5qI4mK6ZTNLV4zznC/ixj2OdajnPjnGqKrXbj9t8v
   bBJPDyLxEVNuTyCxmXLtPigFZMxfbufrx/gQ9+fCxgYY9fDncj1c66cmt
   eQbsD9BZ4pOCBelsisWh/j6cQWkSrrtjDFTJDISYwV8rmyJjRSsr7tu73
   BUegtHZXJghA9aURYbN9fyjNeTThrxCbtEPL0qK88d6fL2a2LOAX8c/qN
   A==;
X-CSE-ConnectionGUID: xbgnoV9SRziWxV8oHSKbdA==
X-CSE-MsgGUID: YIIeIn2KSOiB9dqMyvL2TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="82444529"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82444529"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 02:18:31 -0800
X-CSE-ConnectionGUID: MKfpNpLKRFaxc4+bwWKWBg==
X-CSE-MsgGUID: 1oCeGOScS8u/OifLfd+Fjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="187890680"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Nov 2025 02:18:28 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIOyf-0000I3-2A;
	Mon, 10 Nov 2025 10:18:25 +0000
Date: Mon, 10 Nov 2025 18:17:36 +0800
From: kernel test robot <lkp@intel.com>
To: Ajith Anandhan <ajithanandhan0406@gmail.com>, jic23@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajith Anandhan <ajithanandhan0406@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add support for TI ADS1120
Message-ID: <202511101707.NSNVObH4-lkp@intel.com>
References: <20251109141119.561756-3-ajithanandhan0406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109141119.561756-3-ajithanandhan0406@gmail.com>

Hi Ajith,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.18-rc5 next-20251110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ajith-Anandhan/dt-bindings-iio-adc-Add-TI-ADS1120-binding/20251109-221245
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20251109141119.561756-3-ajithanandhan0406%40gmail.com
patch subject: [PATCH v2 2/2] iio: adc: Add support for TI ADS1120
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20251110/202511101707.NSNVObH4-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251110/202511101707.NSNVObH4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511101707.NSNVObH4-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/iio/adc/ti-ads1120.c:347:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     347 |                 guard(mutex)(&st->lock);
         |                 ^
   include/linux/cleanup.h:401:2: note: expanded from macro 'guard'
     401 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:290:2: note: expanded from macro 'CLASS'
     290 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |         ^
   <scratch space>:10:1: note: expanded from here
      10 | class_mutex_t
         | ^
>> drivers/iio/adc/ti-ads1120.c:366:2: error: cannot jump from switch statement to this case label
     366 |         default:
         |         ^
   drivers/iio/adc/ti-ads1120.c:347:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     347 |                 guard(mutex)(&st->lock);
         |                 ^
   include/linux/cleanup.h:401:15: note: expanded from macro 'guard'
     401 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:166:29: note: expanded from macro '__UNIQUE_ID'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:8:1: note: expanded from here
       8 | __UNIQUE_ID_guard560
         | ^
   drivers/iio/adc/ti-ads1120.c:353:2: error: cannot jump from switch statement to this case label
     353 |         case IIO_CHAN_INFO_SCALE:
         |         ^
   drivers/iio/adc/ti-ads1120.c:347:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     347 |                 guard(mutex)(&st->lock);
         |                 ^
   include/linux/cleanup.h:401:15: note: expanded from macro 'guard'
     401 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:166:29: note: expanded from macro '__UNIQUE_ID'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:8:1: note: expanded from here
       8 | __UNIQUE_ID_guard560
         | ^
   drivers/iio/adc/ti-ads1120.c:390:2: error: cannot jump from switch statement to this case label
     390 |         default:
         |         ^
   drivers/iio/adc/ti-ads1120.c:387:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     387 |                 guard(mutex)(&st->lock);
         |                 ^
   include/linux/cleanup.h:401:15: note: expanded from macro 'guard'
     401 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:166:29: note: expanded from macro '__UNIQUE_ID'
     166 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:17:1: note: expanded from here
      17 | __UNIQUE_ID_guard561
         | ^
   1 warning and 3 errors generated.


vim +366 drivers/iio/adc/ti-ads1120.c

   337	
   338	static int ads1120_read_raw(struct iio_dev *indio_dev,
   339				    struct iio_chan_spec const *chan,
   340				    int *val, int *val2, long mask)
   341	{
   342		struct ads1120_state *st = iio_priv(indio_dev);
   343		int ret, gain;
   344	
   345		switch (mask) {
   346		case IIO_CHAN_INFO_RAW:
 > 347			guard(mutex)(&st->lock);
   348			ret = ads1120_read_measurement(st, chan, val);
   349			if (ret)
   350				return ret;
   351			return IIO_VAL_INT;
   352	
   353		case IIO_CHAN_INFO_SCALE:
   354			/*
   355			 * Scale = Vref / (gain * 2^15)
   356			 * Return in format: val / 2^val2
   357			 */
   358			gain = ads1120_get_gain(st);
   359			if (gain < 0)
   360				return gain;
   361	
   362			*val = st->vref_mv;
   363			*val2 = gain * 15;
   364			return IIO_VAL_FRACTIONAL_LOG2;
   365	
 > 366		default:
   367			return -EINVAL;
   368		}
   369	}
   370	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

