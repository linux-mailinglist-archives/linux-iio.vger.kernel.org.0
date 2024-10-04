Return-Path: <linux-iio+bounces-10163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD1E9911DE
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 23:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BCDE1F23FCB
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 21:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E3D1B4F1D;
	Fri,  4 Oct 2024 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QEmpZJ78"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294AB1AE00E;
	Fri,  4 Oct 2024 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728078948; cv=none; b=JqLW3ibGqXp/GyBCN0LsaVurX/aCkiwah/X1I61y+wwf1XXsvZE02QsULTOKi1h8NcWz36wcZfpNuZchYGxxXu/rpqGwBUe+a18jG+/zoGr2Y87IeURKfG9bkQk+2t65ZVipPryxzxhXeojd26+zN7M4Qhlxy6/oOlizWUGIPIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728078948; c=relaxed/simple;
	bh=BpScfyaXtguykCyLfRMZlJO/4CWI6IRgWrwXuzufp1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2/BAqdP0A0gxFyr04/HkX3a0hXUvjnLr3HMg0pAmW/mygtTJtQZiguLLOZzAQv3SwyDDQvBtRdrbAydgcxsgo3fhmnvcnCF9/qQyqz83T0Y8SZ+LGBr0ki4oJCJDt2H6bSOYBGfxYOBfN1/YkRtK8FG+KuFl4RiDnXxmW3c38c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QEmpZJ78; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728078947; x=1759614947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BpScfyaXtguykCyLfRMZlJO/4CWI6IRgWrwXuzufp1A=;
  b=QEmpZJ78zDscJGZXovttvXY+S5XFG4LaXOQlgtTb/W/z/cOieXI9kBDq
   bdpmGzOofBpeXtGqCbSh94xhH+I7X3Lo908V2dUvIgVmGat7FHM86mDP7
   T41BwDOSzmyPaDw8h7rGI/TIRg1KcUPOUvmfFBGBEvX9HDVGiBJ/q5iRr
   uE6sP+4fAmW8OGA+/y0eyWsAIvmvLGK7LOVkLrX3vFyBa7qvdFy8GN005
   eSZQ268FZgKG8+Ioa2cTwZmfE09auxnCoJ55+jsoIBgxBTtlrYe5fbbMc
   wgmk1kXRqRkVdR5sPLYNyC6QkMwhvVFpnuXxksJAq2NWY+RZxZvJic3O8
   g==;
X-CSE-ConnectionGUID: PMOfkH9XQ/6W2C8gzdKgpg==
X-CSE-MsgGUID: A8usB7y6QfCwfTaEk4phIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="37971046"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="37971046"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 14:55:46 -0700
X-CSE-ConnectionGUID: 00plaSr1RDiS95nW/2XneQ==
X-CSE-MsgGUID: 3wd4ccD5TKWDpB869++Y/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="78814829"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 04 Oct 2024 14:55:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swqGy-0002G2-3D;
	Fri, 04 Oct 2024 21:55:40 +0000
Date: Sat, 5 Oct 2024 05:55:20 +0800
From: kernel test robot <lkp@intel.com>
To: Matteo Martelli <matteomartelli3@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>,
	Paul Cercueil <paul@crapouillou.net>,
	Sebastian Reichel <sre@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Matteo Martelli <matteomartelli3@gmail.com>
Subject: Re: [PATCH 7/7] power: supply: ingenic-battery: free scale buffer
 after use
Message-ID: <202410050547.Pybj1FLp-lkp@intel.com>
References: <20241003-iio-read-avail-release-v1-7-c70cc7d9c2e0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003-iio-read-avail-release-v1-7-c70cc7d9c2e0@gmail.com>

Hi Matteo,

kernel test robot noticed the following build errors:

[auto build test ERROR on fec496684388685647652ab4213454fbabdab099]

url:    https://github.com/intel-lab-lkp/linux/commits/Matteo-Martelli/iio-core-add-read_avail_release_resource-callback-to-fix-race/20241004-013654
base:   fec496684388685647652ab4213454fbabdab099
patch link:    https://lore.kernel.org/r/20241003-iio-read-avail-release-v1-7-c70cc7d9c2e0%40gmail.com
patch subject: [PATCH 7/7] power: supply: ingenic-battery: free scale buffer after use
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241005/202410050547.Pybj1FLp-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410050547.Pybj1FLp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410050547.Pybj1FLp-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/power/supply/ingenic-battery.c: In function 'ingenic_battery_set_scale':
>> drivers/power/supply/ingenic-battery.c:120:9: error: implicit declaration of function 'kfree'; did you mean 'kvfree'? [-Wimplicit-function-declaration]
     120 |         kfree(scale_raw);
         |         ^~~~~
         |         kvfree


vim +120 drivers/power/supply/ingenic-battery.c

    59	
    60	/* Set the most appropriate IIO channel voltage reference scale
    61	 * based on the battery's max voltage.
    62	 */
    63	static int ingenic_battery_set_scale(struct ingenic_battery *bat)
    64	{
    65		const int *scale_raw;
    66		int scale_len, scale_type, best_idx = -1, best_mV, max_raw, i, ret;
    67		u64 max_mV;
    68	
    69		ret = iio_read_max_channel_raw(bat->channel, &max_raw);
    70		if (ret) {
    71			dev_err(bat->dev, "Unable to read max raw channel value\n");
    72			return ret;
    73		}
    74	
    75		ret = iio_read_avail_channel_attribute(bat->channel, &scale_raw,
    76						       &scale_type, &scale_len,
    77						       IIO_CHAN_INFO_SCALE);
    78		if (ret < 0) {
    79			dev_err(bat->dev, "Unable to read channel avail scale\n");
    80			return ret;
    81		}
    82		if (ret != IIO_AVAIL_LIST || scale_type != IIO_VAL_FRACTIONAL_LOG2) {
    83			ret = -EINVAL;
    84			goto out;
    85		}
    86	
    87		max_mV = bat->info->voltage_max_design_uv / 1000;
    88	
    89		for (i = 0; i < scale_len; i += 2) {
    90			u64 scale_mV = (max_raw * scale_raw[i]) >> scale_raw[i + 1];
    91	
    92			if (scale_mV < max_mV)
    93				continue;
    94	
    95			if (best_idx >= 0 && scale_mV > best_mV)
    96				continue;
    97	
    98			best_mV = scale_mV;
    99			best_idx = i;
   100		}
   101	
   102		if (best_idx < 0) {
   103			dev_err(bat->dev, "Unable to find matching voltage scale\n");
   104			ret = -EINVAL;
   105			goto out;
   106		}
   107	
   108		/* Only set scale if there is more than one (fractional) entry */
   109		if (scale_len > 2) {
   110			ret = iio_write_channel_attribute(bat->channel,
   111							  scale_raw[best_idx],
   112							  scale_raw[best_idx + 1],
   113							  IIO_CHAN_INFO_SCALE);
   114			if (ret)
   115				goto out;
   116		}
   117	
   118		ret = 0;
   119	out:
 > 120		kfree(scale_raw);
   121		return ret;
   122	}
   123	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

