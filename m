Return-Path: <linux-iio+bounces-5073-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7388C7DDD
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 22:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ADDDB21E41
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 20:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21517157E73;
	Thu, 16 May 2024 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zb9xwuvp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF3D156F2D;
	Thu, 16 May 2024 20:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715893093; cv=none; b=jEYIhO9NiPdPCvsdLfXXl0MSMSzrqs16161TC+yDi3KOB5FUoV/Us7HuOMCFi8sgHX3AQzXa0YvotTrHXG7RN8PCPWIVSqVavdM+biMaRp7IlwHZeHi17Rl9/9sOLISjlF9+hZqVc31IHSXQjc6IdtMycwuT0EoPLAmOxb3ay9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715893093; c=relaxed/simple;
	bh=GgjtcSqmQYA23xjNtcHKpl6Tkpxfd4PdMb/OKYmoTcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SO6m8ii53HEWMf3hVbgVfZ40B0f4CnBRfKitarLkgOJzJFQks3h6mDaeE9Ftk0aSjszUZJC7AJcjwQpebdZsv9Xf+n0EDROgPBhFBBWL70B4oocwsdQaQm1kJmKtRWEiPSxQAfIkLAePY8gCxsboajfTz7xEXAx8T1p8MU8u6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zb9xwuvp; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715893093; x=1747429093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GgjtcSqmQYA23xjNtcHKpl6Tkpxfd4PdMb/OKYmoTcQ=;
  b=Zb9xwuvpHylA4j3VcCn0HcR7Mx1IjSq/RtswOa3lWAR9YlZsoxxyHAM7
   V1geFrJ90WvnavxaoCjX+PgwaZD88AFWgLicAJ+U3D4qr0f13q3pgtzct
   Jq69BxJTRKsFWjboAezEUYje3/Oljsw967+KCGa/3nGjINGAqUAyjY/W9
   skJSQJor6CFl9ggXhAoYtAM6Trl5k+IIvwcIp1iEqw0sbUDGwCGbI+fV5
   9gUYcCSlLtLce1UdNlXLcPlNRZX7R7zSvVc4mFXdf1EJH5pv9sJJRD6FT
   FIttL5k8vWatERKN5oIA7xk1l+fzhKr/Mi/F3ojvBD5qZIMq6lWDuYsDT
   g==;
X-CSE-ConnectionGUID: QpKSK7CSSAGLlvOmpW1DtA==
X-CSE-MsgGUID: Uif6/vGYRPW1vqKvXdD4Xg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11890980"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="11890980"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 13:58:12 -0700
X-CSE-ConnectionGUID: K/Z4Yk8xQfOSo9mRNlLAuA==
X-CSE-MsgGUID: 48mx8Y62QhOtQ+OJhwlFmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="31687976"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 16 May 2024 13:58:09 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7iAw-000Emw-2e;
	Thu, 16 May 2024 20:58:06 +0000
Date: Fri, 17 May 2024 04:57:54 +0800
From: kernel test robot <lkp@intel.com>
To: Yasin Lee <yasin.lee.x@outlook.com>, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andy.shevchenko@gmail.com,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, nuno.a@analog.com,
	swboyd@chromium.org, u.kleine-koenig@pengutronix.de,
	yasin.lee.x@gmail.com, yasin.lee.x@outlook.com
Subject: Re: [PATCH v1 1/2] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S
 sensor driver
Message-ID: <202405170416.dC1DFrGn-lkp@intel.com>
References: <SN7PR12MB810161203706CD288923AB1DA4E32@SN7PR12MB8101.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN7PR12MB810161203706CD288923AB1DA4E32@SN7PR12MB8101.namprd12.prod.outlook.com>

Hi Yasin,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v6.9 next-20240516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yasin-Lee/dt-bindings-iio-proximity-Add-hx9031as-binding/20240515-083021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/SN7PR12MB810161203706CD288923AB1DA4E32%40SN7PR12MB8101.namprd12.prod.outlook.com
patch subject: [PATCH v1 1/2] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor driver
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20240517/202405170416.dC1DFrGn-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240517/202405170416.dC1DFrGn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405170416.dC1DFrGn-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/iio/proximity/hx9031as.o: in function `hx9031as_write_raw':
>> hx9031as.c:(.text+0x316): undefined reference to `__udivdi3'
   m68k-linux-ld: drivers/iio/proximity/hx9031as.o: in function `hx9031as_read_raw':
   hx9031as.c:(.text+0x16da): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

