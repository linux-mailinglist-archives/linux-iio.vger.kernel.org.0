Return-Path: <linux-iio+bounces-24642-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74269BB21D4
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 02:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2707517C4EE
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 00:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F5D4C92;
	Thu,  2 Oct 2025 00:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKVf8hHR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC1234BA2B;
	Thu,  2 Oct 2025 00:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759364048; cv=none; b=ZcUrQVuQAXcIyjMlk4spNLpsRiqujBUN2hHzGfXn423d5/OyI0Y7jRZNNjiGcsm3Prx7Ub7jNazUOI7TdS+1QdKOOW2LzzBl5v18li74q5BTEDQC65e0rWx3ciXzl/XZSBrOW428jmBZGqY0p94yEc8cweVIVhuYNIP28tQJCuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759364048; c=relaxed/simple;
	bh=vgWIWdCzpsu1OacLiuXWyM5m8s3gHqWeC+dd/lMOdy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0MTzfi5i3g08bXmhMPAt+zbRvM2EycJoQv0IFrdXBk1CNUVbsgfmSa4wP04j4kDmJ7ftalakLha0nbIaa2+lxbe4N8IJe0+DRoLMLm8j4KMZQ+QDu61hGAi/+TEweS84G2QibZDvAmzsiHb13LhzNpv9x/dEYTpYkJaSnm/r38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKVf8hHR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759364046; x=1790900046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vgWIWdCzpsu1OacLiuXWyM5m8s3gHqWeC+dd/lMOdy0=;
  b=eKVf8hHRYbQbl2zCElGSncRCfO83PMMg9b9TiFWIzj/zSTJADz6JDIXp
   ZTZ3qyB4JywU7y5iUv5OzLwIp5esFiUcQl5oiGNExuUkKom8uhGWHLtWR
   hKE99bFHDZAznAEndbXUBkARe9waGTob2fsP9ro7yuAlCfzxIY9HFN1b1
   RqBlkXYvsMl39nqnM+5/cy4xCsbOS7GnmiKsfPluhv1NjYFwqzoapVB+M
   ksZoHoKqaC/DizE8p0DMo8bXh12bmpIu5P1GSpKw1ETUNCtG/Li98jhhC
   L3JYf+GBcpjDjNFfTETMMJ/aCetxmemDV9sdqR6nOQJEDgAJXpCV06J/e
   A==;
X-CSE-ConnectionGUID: o7HeK5v3QYqt41TBuWE+EQ==
X-CSE-MsgGUID: XPYR+QHdSU+XRYyb7/17KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="60863845"
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="60863845"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 17:14:06 -0700
X-CSE-ConnectionGUID: 43wHW9ffRLWI24eD0r22Zg==
X-CSE-MsgGUID: N40iFHvQQp+sfTGZ1Njipw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="178867208"
Received: from lkp-server01.sh.intel.com (HELO 2f2a1232a4e4) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 01 Oct 2025 17:14:03 -0700
Received: from kbuild by 2f2a1232a4e4 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v46xM-0003TT-2L;
	Thu, 02 Oct 2025 00:14:00 +0000
Date: Thu, 2 Oct 2025 08:13:40 +0800
From: kernel test robot <lkp@intel.com>
To: victor.duicu@microchip.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, marius.cristea@microchip.com,
	victor.duicu@microchip.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] iio: temperature: add support for MCP998X
Message-ID: <202510020803.3pQv1jeZ-lkp@intel.com>
References: <20250930133131.13797-3-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930133131.13797-3-victor.duicu@microchip.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 561285d048053fec8a3d6d1e3ddc60df11c393a0]

url:    https://github.com/intel-lab-lkp/linux/commits/victor-duicu-microchip-com/dt-bindings-iio-temperature-add-support-for-MCP998X/20250930-213443
base:   561285d048053fec8a3d6d1e3ddc60df11c393a0
patch link:    https://lore.kernel.org/r/20250930133131.13797-3-victor.duicu%40microchip.com
patch subject: [PATCH v6 2/2] iio: temperature: add support for MCP998X
config: i386-randconfig-013-20251002 (https://download.01.org/0day-ci/archive/20251002/202510020803.3pQv1jeZ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251002/202510020803.3pQv1jeZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510020803.3pQv1jeZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/temperature/mcp9982.c: In function 'mcp9982_read_raw':
>> drivers/iio/temperature/mcp9982.c:467:24: error: implicit declaration of function 'get_unaligned_be16' [-Werror=implicit-function-declaration]
     467 |                 *val = get_unaligned_be16(bulk_read + 1);
         |                        ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/get_unaligned_be16 +467 drivers/iio/temperature/mcp9982.c

   416	
   417	static int mcp9982_read_raw(struct iio_dev *indio_dev,
   418				    struct iio_chan_spec const *chan, int *val,
   419				    int *val2, long mask)
   420	{
   421		unsigned int tmp_reg, reg_status;
   422		struct mcp9982_priv *priv = iio_priv(indio_dev);
   423		unsigned long *src;
   424		int ret;
   425		u8 bulk_read[3];
   426	
   427		if (priv->run_state) {
   428			/*
   429			 * When working in Run mode, after modifying a parameter (like sampling
   430			 * frequency) we have to wait a delay before reading the new values.
   431			 * We can't determine when the conversion is done based on the BUSY bit.
   432			 */
   433			if (priv->wait_before_read) {
   434				if (!time_after(jiffies, priv->time_limit))
   435					mdelay(jiffies_to_msecs(priv->time_limit - jiffies));
   436				priv->wait_before_read = false;
   437			}
   438		} else {
   439			ret = regmap_write(priv->regmap, MCP9982_ONE_SHOT_ADDR, 1);
   440			if (ret)
   441				return ret;
   442			/*
   443			 * In Standby state after writing in OneShot register wait for
   444			 * the start of conversion and then poll the BUSY bit.
   445			 */
   446			mdelay(125);
   447			ret = regmap_read_poll_timeout(priv->regmap, MCP9982_STATUS_ADDR,
   448						       reg_status, !(reg_status & MCP9982_STATUS_BUSY),
   449						       mcp9982_delay_ms[priv->sampl_idx] * USEC_PER_MSEC,
   450						       0);
   451			if (ret)
   452				return ret;
   453		}
   454		guard(mutex)(&priv->lock);
   455	
   456		switch (mask) {
   457		case IIO_CHAN_INFO_RAW:
   458			/*
   459			 * The Block Read Protocol first returns the number of user readable
   460			 * bytes, held in bulk_read[0], followed by the data.
   461			 */
   462			ret = regmap_bulk_read(priv->regmap, MCP9982_TEMP_MEM_BLOCK_ADDR(chan->channel),
   463					       &bulk_read, sizeof(bulk_read));
   464			if (ret)
   465				return ret;
   466	
 > 467			*val = get_unaligned_be16(bulk_read + 1);
   468	
   469			return IIO_VAL_INT;
   470		case IIO_CHAN_INFO_SCALE:
   471			*val = 0;
   472			*val2 = MCP9982_SCALE;
   473			return IIO_VAL_INT_PLUS_NANO;
   474		case IIO_CHAN_INFO_SAMP_FREQ:
   475			*val = mcp9982_conv_rate[priv->sampl_idx][0];
   476			*val2 = mcp9982_conv_rate[priv->sampl_idx][1];
   477			return IIO_VAL_INT_PLUS_MICRO;
   478		case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
   479			ret = regmap_read(priv->regmap, MCP9982_RUNNING_AVG_ADDR, &tmp_reg);
   480			if (ret)
   481				return ret;
   482			*src = tmp_reg;
   483			*val = mcp9982_3db_values_map_tbl[priv->sampl_idx][bitmap_weight(src, 2)][0];
   484			*val2 = mcp9982_3db_values_map_tbl[priv->sampl_idx][bitmap_weight(src, 2)][1];
   485			return IIO_VAL_INT_PLUS_MICRO;
   486		case IIO_CHAN_INFO_OFFSET:
   487			*val = MCP9982_OFFSET;
   488			return IIO_VAL_INT;
   489		default:
   490			return -EINVAL;
   491		}
   492	}
   493	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

