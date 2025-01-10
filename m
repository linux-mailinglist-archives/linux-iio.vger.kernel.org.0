Return-Path: <linux-iio+bounces-14076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C67A08B31
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 10:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C02F188C470
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 09:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FAF20C487;
	Fri, 10 Jan 2025 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLN3yYhg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA620C486;
	Fri, 10 Jan 2025 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500535; cv=none; b=rCekuhAukCFbOlu1aLk72cjfQXWMFBt5Qvkd1cmSncZgkN5wUQwVLYLqyvOQv7QGyRlIsvnyTV2Qbw87hjEIIUBa61uP6FS8i55TRh8smaGOWdfURyIeKJF04f8rDIZS5XBVEerpMGcuKgDZ31pXFZbWhgRCFzIuqhONmvWIu00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500535; c=relaxed/simple;
	bh=yMuEvX/0U7rOLFcEb9brDgo1VAoZ4vuXu+wSia6WGk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BT/iFVjMB4LTbGrXp6gBTMkyE/19CYa2EEM+5oLPy218koZJp2F7+X1mf3dz0Yy+XEzcwsdScNiM2oMhNzoLRJgBul/Nt6L5+mULwWoArwg4NhvMNFv0zA/VlN/72OUeP4xBtmcGR6sePBF3pGuSkPy34IuiMlOrJrYlithnxkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLN3yYhg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736500533; x=1768036533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yMuEvX/0U7rOLFcEb9brDgo1VAoZ4vuXu+wSia6WGk4=;
  b=lLN3yYhgVDTRvnH/1NpzOkPaVTAGAnPtvD4SwT/SozaWfk6X9PFIkIQE
   n4I1jdjFm71GJJPH79nEJbVks9ecKiaBWjPNBizeEUYpsb2puI1Kvf07r
   0fIEpEumLxN8+NePCeAViKL4xByxuxJq7k6iagBIdSY+CMpIYrGZXIbjn
   D82nDQ21xonILNzFdjr/Z+Xoy8XPcxHb3O2LNZOTUeDqiS6T8llGklHp1
   p04jQY/vUFm2J1BkAuFyQzdd3wgz1qYHaTI84F/gXJcWYP/pnvO6g1IKc
   6elazwvbQZcsoe/1c+DGEMv1hBEmUK2BKz4zu7lOmt7guPDjbJZB99+wN
   A==;
X-CSE-ConnectionGUID: u0QaVGddQXeT0bXFcHllmQ==
X-CSE-MsgGUID: w1YqzZmIQIupvBwG7l7wmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="54329484"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="54329484"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 01:15:33 -0800
X-CSE-ConnectionGUID: nXeOA/HsSjCgwUAhzL1AzQ==
X-CSE-MsgGUID: aI6o95PbSoGAda90UPR43Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="103862509"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Jan 2025 01:15:28 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWB70-000IuB-24;
	Fri, 10 Jan 2025 09:15:26 +0000
Date: Fri, 10 Jan 2025 17:14:43 +0800
From: kernel test robot <lkp@intel.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrej.skvortzov@gmail.com,
	neil.armstrong@linaro.org, icenowy@aosc.io, megi@xff.cz,
	danila@jiaxyga.com, javier.carrasco.cruz@gmail.com, and@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, apokusinski01@gmail.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: magnetometer: si7210: add driver for Si7210
Message-ID: <202501101656.F268NchW-lkp@intel.com>
References: <20250108234411.882768-3-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108234411.882768-3-apokusinski01@gmail.com>

Hi Antoni,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.13-rc6 next-20250110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoni-Pokusinski/dt-bindings-iio-magnetometer-add-binding-for-Si7210/20250109-074641
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250108234411.882768-3-apokusinski01%40gmail.com
patch subject: [PATCH v2 2/2] iio: magnetometer: si7210: add driver for Si7210
config: openrisc-randconfig-r123-20250110 (https://download.01.org/0day-ci/archive/20250110/202501101656.F268NchW-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250110/202501101656.F268NchW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501101656.F268NchW-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/magnetometer/si7210.c:169:16: sparse: sparse: cast from restricted __be16
>> drivers/iio/magnetometer/si7210.c:189:24: sparse: sparse: restricted __be16 degrades to integer
>> drivers/iio/magnetometer/si7210.c:206:23: sparse: sparse: cast to restricted __be16
   drivers/iio/magnetometer/si7210.c:206:23: sparse: sparse: restricted __be16 degrades to integer
   drivers/iio/magnetometer/si7210.c:206:23: sparse: sparse: restricted __be16 degrades to integer

vim +169 drivers/iio/magnetometer/si7210.c

   143	
   144	static int si7210_fetch_measurement(struct si7210_data *data,
   145					    struct iio_chan_spec const *chan,
   146					    __be16 *buf)
   147	{
   148		u8 dspsigsel = chan->type == IIO_MAGN ? 0 : 1;
   149		int ret;
   150	
   151		guard(mutex)(&data->fetch_lock);
   152	
   153		ret = regmap_update_bits(data->regmap, SI7210_REG_DSPSIGSEL,
   154					 SI7210_MASK_DSPSIGSEL, dspsigsel);
   155		if (ret < 0)
   156			return ret;
   157	
   158		ret = regmap_update_bits(data->regmap, SI7210_REG_POWER_CTRL,
   159					 SI7210_MASK_ONEBURST | SI7210_MASK_STOP,
   160					 SI7210_MASK_ONEBURST & ~SI7210_MASK_STOP);
   161		if (ret < 0)
   162			return ret;
   163	
   164		/* Read the contents of the registers containing the result: DSPSIGM, DSPSIGL */
   165		ret = regmap_bulk_read(data->regmap, SI7210_REG_DSPSIGM, buf, 2);
   166		if (ret < 0)
   167			return ret;
   168	
 > 169		*buf = cpu_to_be16(*buf);
   170	
   171		return 0;
   172	}
   173	
   174	static int si7210_read_raw(struct iio_dev *indio_dev,
   175				   struct iio_chan_spec const *chan,
   176				   int *val, int *val2, long mask)
   177	{
   178		struct si7210_data *data = iio_priv(indio_dev);
   179		long long tmp;
   180		__be16 dspsig;
   181		int ret;
   182	
   183		switch (mask) {
   184		case IIO_CHAN_INFO_RAW:
   185			ret = si7210_fetch_measurement(data, chan, &dspsig);
   186			if (ret < 0)
   187				return ret;
   188	
 > 189			*val = dspsig & GENMASK(14, 0);
   190			return IIO_VAL_INT;
   191		case IIO_CHAN_INFO_SCALE:
   192			*val = 0;
   193			if (data->curr_scale == 20)
   194				*val2 = 1250;
   195			else /* data->curr_scale == 200 */
   196				*val2 = 12500;
   197			return IIO_VAL_INT_PLUS_MICRO;
   198		case IIO_CHAN_INFO_OFFSET:
   199			*val = -16384;
   200			return IIO_VAL_INT;
   201		case IIO_CHAN_INFO_PROCESSED:
   202			ret = si7210_fetch_measurement(data, chan, &dspsig);
   203			if (ret < 0)
   204				return ret;
   205	
 > 206			tmp = FIELD_GET(GENMASK(14, 3), dspsig);
   207			tmp = (div_s64(-383 * tmp * tmp, 100) + (160940 * tmp - 279800000));
   208			tmp = (1 + (data->temp_gain >> 11)) * tmp + 62500 * data->temp_offset;
   209	
   210			ret = regulator_get_voltage(data->vdd);
   211			if (ret < 0)
   212				return ret;
   213	
   214			tmp -= 222 * div_s64(ret, 1000);
   215	
   216			*val = div_s64(tmp, 1000);
   217	
   218			return IIO_VAL_INT;
   219		default:
   220			return -EINVAL;
   221		}
   222	}
   223	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

