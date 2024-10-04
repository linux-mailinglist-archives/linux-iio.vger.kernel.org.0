Return-Path: <linux-iio+bounces-10165-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435C2991330
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 01:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 832F9B21AD3
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 23:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641611547C8;
	Fri,  4 Oct 2024 23:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S02Ad3Hy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7815381F;
	Fri,  4 Oct 2024 23:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085191; cv=none; b=GnX+XNgJ4qtr3B700I4vE3rV+XdzHJkXiVmnu6n1EjVNf+f+F4XiS0gMajmvsrO1CKorJrTt7cNCU4yMKPU6bBoyFPIKz9kaEH4H481Fe/OL98i+KzMGxJxzw15tHSSLYtQuS4lq3RJrQOfYuVi5OcGZKW/SwD4F7dY1GSb02pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085191; c=relaxed/simple;
	bh=qn/t4LoP2AiEczzxO0xIU1CZNre1jHKaCVdh5Ta1IwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bq7h+9jNrZP0RBOXfS+mzkQoJP9bef3lCuIKJXtlxb2JLwm5ZYv40CJuUmXSCdmjmCUD04x+O9BHV5YyIQVsLiXIUbI+yM+aM+8BanaRRZ0Z1+LlS17kTCGJoOLULAQ2tHsd1jFeQfOez88DGeprXzEWPURJE3pjofIE1Cc8c8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S02Ad3Hy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728085189; x=1759621189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qn/t4LoP2AiEczzxO0xIU1CZNre1jHKaCVdh5Ta1IwM=;
  b=S02Ad3HybkEbGNIHypUY0MsfPDxsg5yPWHwlU+jNNq/uQCpXVNr3mELM
   0Z0rEv/qsrWJoRIPk03g9F/qJDt3V05aAVW6UQUB86w/B/awribe6qf2n
   n2LXlqmoLQLc7QjdQrBd6ozUVxFe/Ap7kN2IoSyBgsaNzIAZAImBm/LGo
   2KkRxgHXi0N2YDY3kwJrI6nH8QOk6RNM/IrZyUiBtTtq2yeHMUPY58AOS
   nvPw/Dm+gFqJbtnu6kQQqf3gMw6VL57k8lsvjuTodPk2yz3GNqZ8TcMGy
   iwtX/NwLuWZOOj0y6zs+2NxZBm/K+GYeUF1SbaK463O0bGHUnG1MWakrb
   w==;
X-CSE-ConnectionGUID: GUu6iSh/R8KnsURd//t0Wg==
X-CSE-MsgGUID: covznv2JTweg/wXPyqcr3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="30204505"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="30204505"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 16:39:49 -0700
X-CSE-ConnectionGUID: 9TBlvmm2T2aq9/ECvRIJIw==
X-CSE-MsgGUID: NqsC5WaFT6ehU/1rYsetKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="74977977"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 04 Oct 2024 16:39:45 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swrtf-0002Kc-12;
	Fri, 04 Oct 2024 23:39:43 +0000
Date: Sat, 5 Oct 2024 07:38:53 +0800
From: kernel test robot <lkp@intel.com>
To: Matteo Martelli <matteomartelli3@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>,
	Paul Cercueil <paul@crapouillou.net>,
	Sebastian Reichel <sre@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-pm@vger.kernel.org,
	Matteo Martelli <matteomartelli3@gmail.com>
Subject: Re: [PATCH 7/7] power: supply: ingenic-battery: free scale buffer
 after use
Message-ID: <202410050737.0PgqTuD1-lkp@intel.com>
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
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20241005/202410050737.0PgqTuD1-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project fef3566a25ff0e34fb87339ba5e13eca17cec00f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410050737.0PgqTuD1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410050737.0PgqTuD1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/power/supply/ingenic-battery.c:120:2: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     120 |         kfree(scale_raw);
         |         ^
   1 error generated.


vim +/kfree +120 drivers/power/supply/ingenic-battery.c

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

