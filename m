Return-Path: <linux-iio+bounces-24279-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC097B88133
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 09:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B2CE7B94CD
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 06:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A282C236E;
	Fri, 19 Sep 2025 07:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcCqVdwb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D482C11C9;
	Fri, 19 Sep 2025 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265209; cv=none; b=rLJquh/9Q8ekw3XImwykEYRm2N7alKJLbRIebTzkFkgE5gjGPJIbqV60theMtKCVIdXETisrnuRZ3dfq8bvuia9jhfg4EAFXQCXkhys3doxVgRuFOYxshJnT5bDcaEFTBtO1xy5r8IeI3X4A6rRlUArV0YIohEUbYVbNdu3Cx58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265209; c=relaxed/simple;
	bh=UqGM+RJWa+FNtsOV1ZHcikaGRxXWyM7YzEKdq4dZzYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2OldBgaEeUvHyLFtn58UmMgeAeoLb+1UNM5xGUDag5i2CKIL6P6EYJKcH+AwWJppRjCUeJaxUyI7u30vDD4v3ZkEZCvbL8+PVukBtoU5nmjt6L4H4rkIO1PHAvwSh6ueHBp8/YwXLxZl7seh701dI5BWY5ckv1bq8ZonJ9gFks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kcCqVdwb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758265203; x=1789801203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UqGM+RJWa+FNtsOV1ZHcikaGRxXWyM7YzEKdq4dZzYc=;
  b=kcCqVdwbOWRvHwQUcwIhn/DI0JrVHgYiAYXHc0bc9wJ9zjJsN0/uXMOK
   TUWNy1x9mT4KpCQLMLx2FDNjpKGyWivNeURsjHBmFrZyMLp4RKb6q6A8N
   myqUIJeJn9du/Jd5/uXR8iy1U7hxnthbanHR0yW6nVPFd19n5FDkDUEOH
   4oJ5+GWe5L2DkquRYSyswBLHj6hp4JCCQS8YxJbZkI3M39cwUNsv7FxEA
   1WAqChIIDMHPYZsOOEjM+yXgLIVPnv5gxLvgH9aw7KGZ3y2NHq70YMw6K
   BYubU/UFwsXaHHPVjs0gvB67RsuYW/me9ksgGPCp5YEMAv1kMTqQjomV1
   A==;
X-CSE-ConnectionGUID: 0oIZPyjBRFKhNyUxMiSKBA==
X-CSE-MsgGUID: 6bPFD2THTUCEkS5F211dfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60495318"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="60495318"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 00:00:02 -0700
X-CSE-ConnectionGUID: 99zDXPWVQ/OHBOZkT+OlTQ==
X-CSE-MsgGUID: i7cl7rUlTgOOP8Zgcm+NVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="206707511"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 18 Sep 2025 23:59:59 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzV64-00043z-2U;
	Fri, 19 Sep 2025 06:59:56 +0000
Date: Fri, 19 Sep 2025 14:59:52 +0800
From: kernel test robot <lkp@intel.com>
To: victor.duicu@microchip.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	marius.cristea@microchip.com, victor.duicu@microchip.com
Subject: Re: [PATCH v5 2/2] iio: temperature: add support for MCP998X
Message-ID: <202509191411.ej3JBK3f-lkp@intel.com>
References: <20250918111937.5150-3-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918111937.5150-3-victor.duicu@microchip.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 671b9b6d7f4fe17a174c410397e72253877ca64e]

url:    https://github.com/intel-lab-lkp/linux/commits/victor-duicu-microchip-com/dt-bindings-iio-temperature-add-support-for-MCP998X/20250918-192457
base:   671b9b6d7f4fe17a174c410397e72253877ca64e
patch link:    https://lore.kernel.org/r/20250918111937.5150-3-victor.duicu%40microchip.com
patch subject: [PATCH v5 2/2] iio: temperature: add support for MCP998X
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250919/202509191411.ej3JBK3f-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7c861bcedf61607b6c087380ac711eb7ff918ca6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250919/202509191411.ej3JBK3f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509191411.ej3JBK3f-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from <built-in>:3:
   In file included from include/linux/compiler_types.h:171:
   include/linux/compiler-clang.h:28:9: warning: '__SANITIZE_ADDRESS__' macro redefined [-Wmacro-redefined]
      28 | #define __SANITIZE_ADDRESS__
         |         ^
   <built-in>:371:9: note: previous definition is here
     371 | #define __SANITIZE_ADDRESS__ 1
         |         ^
>> drivers/iio/temperature/mcp9982.c:470:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     470 |                 u8 bulk_read[3];
         |                 ^
   drivers/iio/temperature/mcp9982.c:488:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     488 |                 unsigned long *src;
         |                 ^
>> drivers/iio/temperature/mcp9982.c:493:4: warning: variable 'src' is uninitialized when used here [-Wuninitialized]
     493 |                 *src = tmp_reg;
         |                  ^~~
   drivers/iio/temperature/mcp9982.c:488:21: note: initialize the variable 'src' to silence this warning
     488 |                 unsigned long *src;
         |                                   ^
         |                                    = NULL
   drivers/iio/temperature/mcp9982.c:741:2: warning: variable 'iio_idx' is uninitialized when used here [-Wuninitialized]
     741 |         iio_idx++;
         |         ^~~~~~~
   drivers/iio/temperature/mcp9982.c:720:30: note: initialize the variable 'iio_idx' to silence this warning
     720 |         unsigned int reg_nr, iio_idx;
         |                                     ^
         |                                      = 0
   5 warnings generated.


vim +470 drivers/iio/temperature/mcp9982.c

   426	
   427	static int mcp9982_read_raw(struct iio_dev *indio_dev,
   428				    struct iio_chan_spec const *chan, int *val,
   429				    int *val2, long mask)
   430	{
   431		unsigned int tmp_reg, reg_status;
   432		struct mcp9982_priv *priv = iio_priv(indio_dev);
   433		int ret;
   434	
   435		if (test_bit(RUN_STATE, &priv->bit_flags)) {
   436			/*
   437			 * When working in Run mode, after modifying a parameter (like sampling
   438			 * frequency) we have to wait a delay before reading the new values.
   439			 * We can't determine when the conversion is done based on the BUSY bit.
   440			 */
   441			if (test_bit(WAIT_BEFORE_READ, &priv->bit_flags)) {
   442				if (!time_after(jiffies, priv->time_limit))
   443					mdelay(jiffies_to_msecs(priv->time_limit - jiffies));
   444				clear_bit(WAIT_BEFORE_READ, &priv->bit_flags);
   445			}
   446		} else {
   447			ret = regmap_write(priv->regmap, MCP9982_ONE_SHOT_ADDR, 1);
   448			if (ret)
   449				return ret;
   450			/*
   451			 * In Standby state after writing in OneShot register wait for
   452			 * the start of conversion and then poll the BUSY bit.
   453			 */
   454			mdelay(125);
   455			ret = regmap_read_poll_timeout(priv->regmap, MCP9982_STATUS_ADDR,
   456						       reg_status, !(reg_status & MCP9982_STATUS_BUSY),
   457						       mcp9982_delay_ms[priv->sampl_idx] * USEC_PER_MSEC,
   458						       0);
   459			if (ret)
   460				return ret;
   461		}
   462		guard(mutex)(&priv->lock);
   463	
   464		switch (mask) {
   465		case IIO_CHAN_INFO_RAW:
   466			/*
   467			 * The Block Read Protocol first returns the number of user readable
   468			 * bytes, held in bulk_read[0], followed by the data.
   469			 */
 > 470			u8 bulk_read[3];
   471	
   472			ret = regmap_bulk_read(priv->regmap, MCP9982_TEMP_MEM_BLOCK_ADDR(chan->channel),
   473					       &bulk_read, sizeof(bulk_read));
   474			if (ret)
   475				return ret;
   476	
   477			*val = (bulk_read[1] << 8) + (bulk_read[2]);
   478			return IIO_VAL_INT;
   479		case IIO_CHAN_INFO_SCALE:
   480			*val = 0;
   481			*val2 = MCP9982_SCALE;
   482			return IIO_VAL_INT_PLUS_NANO;
   483		case IIO_CHAN_INFO_SAMP_FREQ:
   484			*val = mcp9982_conv_rate[priv->sampl_idx][0];
   485			*val2 = mcp9982_conv_rate[priv->sampl_idx][1];
   486			return IIO_VAL_INT_PLUS_MICRO;
   487		case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
   488			unsigned long *src;
   489	
   490			ret = regmap_read(priv->regmap, MCP9982_RUNNING_AVG_ADDR, &tmp_reg);
   491			if (ret)
   492				return ret;
 > 493			*src = tmp_reg;
   494			*val = mcp9982_3db_values_map_tbl[priv->sampl_idx][bitmap_weight(src, 2)][0];
   495			*val2 = mcp9982_3db_values_map_tbl[priv->sampl_idx][bitmap_weight(src, 2)][1];
   496			return IIO_VAL_INT_PLUS_MICRO;
   497		case IIO_CHAN_INFO_OFFSET:
   498			*val = MCP9982_OFFSET;
   499			return IIO_VAL_INT;
   500		default:
   501			return -EINVAL;
   502		}
   503	}
   504	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

