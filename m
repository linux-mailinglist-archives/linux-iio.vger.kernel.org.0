Return-Path: <linux-iio+bounces-20562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1838DAD774C
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 18:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437E718929B1
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 15:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D822C29C343;
	Thu, 12 Jun 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFQlllvz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E109B29ACF0;
	Thu, 12 Jun 2025 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743559; cv=none; b=NF4DH5lrjLxbNzAegfGklk2CvWxfZRuf80+uO37h1sXjLXEaK5F009o45R+Zz9gjtJsB/pKlfjzWyIMZWYWpYGgIdNVP38o96L15qdVFDyS6jFwaFMwTmbqSascuJwoH9YmC0qiaqmY+yMXwIqZV//cAkujtO3v2x8SF5bMGGc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743559; c=relaxed/simple;
	bh=Updcin2t1tn+PnzGiadb1hLYzbZBbIAKi6D8Vusxwu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwH5mcnAsf+jIxAH/pwNFjcD6t/ANdZH3Pe9k1ubp63XE+OpaCO/jFZI/0X9sX22PKt3YKMtecB2dJkBCxvA0Udn4q4gCVohCBS/egANsALcf/f3oSKV8pS32XQxml+ObWvGcEd9Bjt6ivxM6pL8U1TEwKtWHk8r+q3FnErAy/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFQlllvz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749743558; x=1781279558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Updcin2t1tn+PnzGiadb1hLYzbZBbIAKi6D8Vusxwu0=;
  b=GFQlllvzLdpK8b3fLMXMR3cAuy6lwP4iJ7k/vIrMSm9HcFUQ8LsU05AU
   Xo+siBf5DgChF0VL6Gq3rEAwiWpbgDtm6gKW86mtRVyxeKEueB+6Qgl3n
   Rzo5ojqwiwpdW/Y5d2Y4/eI+n28Z6OeYNZVXD+MY5+9ymKWYfLp7rmcdQ
   b+indV05MUxJLxQ5egGXrJpTNfOJsN5mKD8Ibjm1baw2Gzup1NL8n4Ewl
   JtaqHv3HUIY3oKThgOAD1C5rm2WsTuWlPJKPOgFG/hdgFPkaI14sD0Xqr
   lycH+m7TPRQjTdto2F+HQqYV6kJY1MvPkmbpdiRtoRHvoCcTR+vZRHqmI
   g==;
X-CSE-ConnectionGUID: 8c2oviC6RyOXZrw9y/59nA==
X-CSE-MsgGUID: bTRjB4GHTU+0+39hkwj5fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="63343372"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="63343372"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 08:52:33 -0700
X-CSE-ConnectionGUID: cj9l53x1T66tXFPkscPkWQ==
X-CSE-MsgGUID: U8RpNtwQTySlX56UOkdwOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148465993"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 Jun 2025 08:52:30 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uPkE7-000Bjq-1Y;
	Thu, 12 Jun 2025 15:52:27 +0000
Date: Thu, 12 Jun 2025 23:52:16 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Ijano <andrew.ijano@gmail.com>, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrew.lopes@alumni.usp.br,
	gustavobastos@usp.br, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, jstephan@baylibre.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: accel: sca3000: use guard(mutex)() for
 handling mutex lock
Message-ID: <202506122309.FvJPaMhh-lkp@intel.com>
References: <20250611194648.18133-4-andrew.lopes@alumni.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611194648.18133-4-andrew.lopes@alumni.usp.br>

Hi Andrew,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.16-rc1 next-20250612]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Ijano/iio-accel-sca3000-replace-error_ret-labels-by-simple-returns/20250612-034940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250611194648.18133-4-andrew.lopes%40alumni.usp.br
patch subject: [PATCH v5 3/3] iio: accel: sca3000: use guard(mutex)() for handling mutex lock
config: nios2-randconfig-002-20250612 (https://download.01.org/0day-ci/archive/20250612/202506122309.FvJPaMhh-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250612/202506122309.FvJPaMhh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506122309.FvJPaMhh-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/irqflags.h:17,
                    from include/asm-generic/bitops.h:14,
                    from ./arch/nios2/include/generated/asm/bitops.h:1,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from include/linux/interrupt.h:6,
                    from drivers/iio/accel/sca3000.c:10:
   drivers/iio/accel/sca3000.c: In function 'sca3000_read_raw':
>> include/linux/cleanup.h:258:2: error: a label can only be part of a statement and a declaration is not a statement
     class_##_name##_t var __cleanup(class_##_name##_destructor) = \
     ^~~~~~
   include/linux/cleanup.h:319:2: note: in expansion of macro 'CLASS'
     CLASS(_name, __UNIQUE_ID(guard))
     ^~~~~
   drivers/iio/accel/sca3000.c:699:3: note: in expansion of macro 'guard'
      guard(mutex)(&st->lock);
      ^~~~~
>> include/linux/cleanup.h:258:2: error: a label can only be part of a statement and a declaration is not a statement
     class_##_name##_t var __cleanup(class_##_name##_destructor) = \
     ^~~~~~
   include/linux/cleanup.h:319:2: note: in expansion of macro 'CLASS'
     CLASS(_name, __UNIQUE_ID(guard))
     ^~~~~
   drivers/iio/accel/sca3000.c:731:3: note: in expansion of macro 'guard'
      guard(mutex)(&st->lock);
      ^~~~~
>> include/linux/cleanup.h:258:2: error: a label can only be part of a statement and a declaration is not a statement
     class_##_name##_t var __cleanup(class_##_name##_destructor) = \
     ^~~~~~
   include/linux/cleanup.h:319:2: note: in expansion of macro 'CLASS'
     CLASS(_name, __UNIQUE_ID(guard))
     ^~~~~
   drivers/iio/accel/sca3000.c:735:3: note: in expansion of macro 'guard'
      guard(mutex)(&st->lock);
      ^~~~~
   drivers/iio/accel/sca3000.c: In function 'sca3000_write_raw':
   drivers/iio/accel/sca3000.c:748:6: warning: unused variable 'ret' [-Wunused-variable]
     int ret;
         ^~~
   In file included from include/linux/irqflags.h:17,
                    from include/asm-generic/bitops.h:14,
                    from ./arch/nios2/include/generated/asm/bitops.h:1,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from include/linux/interrupt.h:6,
                    from drivers/iio/accel/sca3000.c:10:
   drivers/iio/accel/sca3000.c: In function 'sca3000_read_event_value':
>> include/linux/cleanup.h:258:2: error: a label can only be part of a statement and a declaration is not a statement
     class_##_name##_t var __cleanup(class_##_name##_destructor) = \
     ^~~~~~
   include/linux/cleanup.h:319:2: note: in expansion of macro 'CLASS'
     CLASS(_name, __UNIQUE_ID(guard))
     ^~~~~
   drivers/iio/accel/sca3000.c:835:3: note: in expansion of macro 'guard'
      guard(mutex)(&st->lock);
      ^~~~~
   drivers/iio/accel/sca3000.c: In function 'sca3000_write_event_value':
   drivers/iio/accel/sca3000.c:881:6: warning: unused variable 'ret' [-Wunused-variable]
     int ret;
         ^~~
   drivers/iio/accel/sca3000.c: In function 'sca3000_write_event_config':
   drivers/iio/accel/sca3000.c:1188:6: warning: unused variable 'ret' [-Wunused-variable]
     int ret;
         ^~~


vim +258 include/linux/cleanup.h

54da6a0924311c Peter Zijlstra 2023-05-26  256  
54da6a0924311c Peter Zijlstra 2023-05-26  257  #define CLASS(_name, var)						\
54da6a0924311c Peter Zijlstra 2023-05-26 @258  	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
54da6a0924311c Peter Zijlstra 2023-05-26  259  		class_##_name##_constructor
54da6a0924311c Peter Zijlstra 2023-05-26  260  
54da6a0924311c Peter Zijlstra 2023-05-26  261  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

