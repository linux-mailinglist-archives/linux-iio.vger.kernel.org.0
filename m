Return-Path: <linux-iio+bounces-22348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0873B1C9C9
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 18:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA8962425F
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 16:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B772429A323;
	Wed,  6 Aug 2025 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0DoNjOK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADA842A9D;
	Wed,  6 Aug 2025 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497679; cv=none; b=QZSZVrYzBwYHDg+rZUwG1jTcdpPaaY7n8kshFG8n4iPahLQeLOIWwVtMjKZ2jXej6vSv45yN67QlB2D0Mw0ZhX/TSE0eC6GYB+s/cd+CrQ/YdgFcXApAFA0CY1UuwAwdSnAjWOl7M/qFIdldF34bHqel79hed72qhVO2VWB+ueo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497679; c=relaxed/simple;
	bh=bU/IJC15T0oubCQnc0y9FdLufr5bu1Qr58RvQity39Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxVJBx95RG98hEeMblFd9INq4ZVKceA5Vt/UG+LnQxB6EUWltnfncVonBICzQeS1sjsqL7unSRr0gfqw1ROOO/6ioyYp0EzmaGG+wUlTS885/82RjMbvTOVpnasgK6Kxpbu+i6jUUIab0Xq9MwhncCGZ8JCtHllqNYBxIn/p0Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0DoNjOK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754497678; x=1786033678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bU/IJC15T0oubCQnc0y9FdLufr5bu1Qr58RvQity39Y=;
  b=e0DoNjOKxaAhxmIloQUntWRBgPfQcBTziAsOTLoUzWzsKRzfzg7ud7o2
   v1gyGXjyfeTHgBCrClWCIkn8ZMhS6FJ1vShE5aFTpslmM+PizE8nXLuub
   DVeAS1cxUi5UZWYEKC41WXMzggg2EIxYuJY8/dotHbAnOppOE+iYqT8F1
   hHZlGKXRIBViaxOiGVSIkbgp89L56EWioBWCfiwUPx1mpnPK1rN3cjXXM
   ZE7+Xq61gHinLs897e595Elyl0a99sMLR10ghI3z3vPfe3y7NgScNsXwR
   V8P7QoLHgHgLnxIJPBmuKVfv+lHfDKu/ozaAGTc4iY46L0wdx8uqxVgir
   g==;
X-CSE-ConnectionGUID: J90PYadfRyqEw8FA7qO99Q==
X-CSE-MsgGUID: x8qssiYERLGZBSp9dxHgkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60660106"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="60660106"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 09:27:57 -0700
X-CSE-ConnectionGUID: Mkl9LS57SSmGlzCvOPYSeg==
X-CSE-MsgGUID: VImDhv19Rl+8lAy48kuPeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="165158265"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 06 Aug 2025 09:27:53 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ujgzX-0001sA-1N;
	Wed, 06 Aug 2025 16:27:51 +0000
Date: Thu, 7 Aug 2025 00:27:39 +0800
From: kernel test robot <lkp@intel.com>
To: Dixit Parmar <dixitparmar19@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Dixit Parmar <dixitparmar19@gmail.com>
Subject: Re: [PATCH v2 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <202508070051.wZvtQr6x-lkp@intel.com>
References: <20250802-tlv493d-sensor-v6_16-rc5-v2-1-e867df86ad93@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250802-tlv493d-sensor-v6_16-rc5-v2-1-e867df86ad93@gmail.com>

Hi Dixit,

kernel test robot noticed the following build errors:

[auto build test ERROR on d7b8f8e20813f0179d8ef519541a3527e7661d3a]

url:    https://github.com/intel-lab-lkp/linux/commits/Dixit-Parmar/iio-magnetometer-add-support-for-Infineon-TLV493D-3D-Magentic-sensor/20250802-144615
base:   d7b8f8e20813f0179d8ef519541a3527e7661d3a
patch link:    https://lore.kernel.org/r/20250802-tlv493d-sensor-v6_16-rc5-v2-1-e867df86ad93%40gmail.com
patch subject: [PATCH v2 1/2] iio: magnetometer: add support for Infineon TLV493D 3D Magentic sensor
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20250807/202508070051.wZvtQr6x-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250807/202508070051.wZvtQr6x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508070051.wZvtQr6x-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kasan-checks.h:5,
                    from include/asm-generic/rwonce.h:26,
                    from ./arch/x86/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:390,
                    from include/linux/build_bug.h:5,
                    from include/linux/bits.h:32,
                    from drivers/iio/magnetometer/tlv493d.c:8:
>> include/linux/stddef.h:8:14: error: positional initialization of field in 'struct' declared with 'designated_init' attribute [-Werror=designated-init]
       8 | #define NULL ((void *)0)
         |              ^
   drivers/iio/magnetometer/tlv493d.c:438:64: note: in expansion of macro 'NULL'
     438 | static const struct iio_buffer_setup_ops tlv493d_setup_ops = { NULL };
         |                                                                ^~~~
   include/linux/stddef.h:8:14: note: (near initialization for 'tlv493d_setup_ops')
       8 | #define NULL ((void *)0)
         |              ^
   drivers/iio/magnetometer/tlv493d.c:438:64: note: in expansion of macro 'NULL'
     438 | static const struct iio_buffer_setup_ops tlv493d_setup_ops = { NULL };
         |                                                                ^~~~
   cc1: some warnings being treated as errors


vim +8 include/linux/stddef.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  6  
^1da177e4c3f41 Linus Torvalds   2005-04-16  7  #undef NULL
^1da177e4c3f41 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
6e218287432472 Richard Knutsson 2006-09-30  9  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

