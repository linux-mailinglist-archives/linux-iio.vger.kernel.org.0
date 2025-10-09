Return-Path: <linux-iio+bounces-24871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F422CBC94BF
	for <lists+linux-iio@lfdr.de>; Thu, 09 Oct 2025 15:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B959B4E4C2B
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 13:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32CE2E8B7F;
	Thu,  9 Oct 2025 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3uiTcGJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02672E88A7;
	Thu,  9 Oct 2025 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016518; cv=none; b=IWHAxgjH9Ne1jPbzsr0G9BpkzWkzBPKhKJBc7kbQZfzH3IbE1mOSHcVQblKNb0I/PRC2g2JtHdL2nJvyPPEBvch6PTOqvHYNq1G7i41+GLE4+Rb68dwumBbvm3Q9z5J9Rj7htn4hmgxW6KaAfRpVvCwnGeKz7kovmkzL8v0IQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016518; c=relaxed/simple;
	bh=o4bOSB/+LmL3jiEYvJGq1i0H1UJYSLiq5TkwNmGyVWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8tdXLOkg2CO/2hUc7cKD7owZGHIjnmxFcXYe5+vgT1GOJAEqe5RJMpaDa27OuA3ei4C7wSZtAHdOQ2RrRxadyk7cSxRmUhZaR7KHW3y8ldNsC52LA5gTA9/JTePHJSPKHk5mZ8iC2Wjjz10K3PLe55W2I7vZHEfZTD1FQT0o/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3uiTcGJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760016517; x=1791552517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o4bOSB/+LmL3jiEYvJGq1i0H1UJYSLiq5TkwNmGyVWk=;
  b=T3uiTcGJcAaQOliBVSRV5JNnlrYfm72Q3bZ5QGWef/lI6l46n6K2CRS+
   OocezQQzSchi4joHUK1vU34gCZy5QTa9EzNXgVrcm46YY2nxhGopaHyWA
   PpLFtvl1yavNlP22CMrWmNVtQlQ0AsCCnoxlFXiNf+TJsJYir+SXqIivU
   Oc+u4VfD5tFFOf5oy572Ei2fb/Ac6+J7O4f0yfMEVtf/+gePJPdMdh4KT
   dsX5ste2FDgzWErdpNy5XGi35G3Kk6IWKrCAHNG8QguivTTLe4hG6bwHk
   Ls+7ntjGfmT530jH7IBldkDbpzTirY2R/v6O/wpi5Zs4/m/sBmef5zMB7
   A==;
X-CSE-ConnectionGUID: 7EdPjh9vRNeHsYxYglXTyA==
X-CSE-MsgGUID: TaminGw6T5+7cvKWzNXXtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="73569318"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="73569318"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 06:28:36 -0700
X-CSE-ConnectionGUID: 9ig6yzJtTZayI+GRcxyPHw==
X-CSE-MsgGUID: MuHFL17ySmGqK2g9YhC6AA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Oct 2025 06:28:32 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6qh4-0000kF-0e;
	Thu, 09 Oct 2025 13:28:30 +0000
Date: Thu, 9 Oct 2025 21:28:19 +0800
From: kernel test robot <lkp@intel.com>
To: Shrikant Raskar <raskar.shree97@gmail.com>, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, matt@ranostay.sg,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: Re: [PATCH 2/2] iio: health: max30100: Add pulse-width configuration
 via DT
Message-ID: <202510092124.rc01eF4I-lkp@intel.com>
References: <20251004015623.7019-3-raskar.shree97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251004015623.7019-3-raskar.shree97@gmail.com>

Hi Shrikant,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v6.17 next-20251008]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shrikant-Raskar/dt-bindings-iio-max30100-Add-pulse-width-property/20251004-095849
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20251004015623.7019-3-raskar.shree97%40gmail.com
patch subject: [PATCH 2/2] iio: health: max30100: Add pulse-width configuration via DT
config: arm-randconfig-r073-20251004 (https://download.01.org/0day-ci/archive/20251009/202510092124.rc01eF4I-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510092124.rc01eF4I-lkp@intel.com/

smatch warnings:
drivers/iio/health/max30100.c:346 max30100_chip_init() warn: unsigned 'pulse_width' is never less than zero.
drivers/iio/health/max30100.c:346 max30100_chip_init() warn: error code type promoted to positive: 'pulse_width'

vim +/pulse_width +346 drivers/iio/health/max30100.c

   326	
   327	static int max30100_chip_init(struct max30100_data *data)
   328	{
   329		int ret;
   330		unsigned int pulse_us;
   331		unsigned int pulse_width;
   332		struct device *dev = &data->client->dev;
   333	
   334		/* setup LED current settings */
   335		ret = max30100_led_init(data);
   336		if (ret)
   337			return ret;
   338	
   339		/* Get pulse width from DT, default = 1600us */
   340		ret = device_property_read_u32(dev, "maxim,pulse-width", &pulse_us);
   341		if (ret) {
   342			dev_warn(dev, "no pulse-width defined, defaulting to 1600us\n");
   343			pulse_width = MAX30100_REG_SPO2_CONFIG_1600US;
   344		} else {
   345			pulse_width = max30100_get_pulse_width(pulse_us);
 > 346			if (pulse_width < 0) {
   347				dev_err(dev, "invalid pulse-width %u\n", pulse_us);
   348				return pulse_width;
   349			}
   350		}
   351	
   352		/* enable hi-res SPO2 readings at 100Hz */
   353		ret = regmap_write(data->regmap, MAX30100_REG_SPO2_CONFIG,
   354					 MAX30100_REG_SPO2_CONFIG_HI_RES_EN |
   355					 MAX30100_REG_SPO2_CONFIG_100HZ |
   356					 pulse_width);
   357		if (ret)
   358			return ret;
   359	
   360		/* enable SPO2 mode */
   361		ret = regmap_update_bits(data->regmap, MAX30100_REG_MODE_CONFIG,
   362					 MAX30100_REG_MODE_CONFIG_MODE_MASK,
   363					 MAX30100_REG_MODE_CONFIG_MODE_HR_EN |
   364					 MAX30100_REG_MODE_CONFIG_MODE_SPO2_EN);
   365		if (ret)
   366			return ret;
   367	
   368		/* enable FIFO interrupt */
   369		return regmap_update_bits(data->regmap, MAX30100_REG_INT_ENABLE,
   370					 MAX30100_REG_INT_ENABLE_MASK,
   371					 MAX30100_REG_INT_ENABLE_FIFO_EN
   372					 << MAX30100_REG_INT_ENABLE_MASK_SHIFT);
   373	}
   374	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

