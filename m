Return-Path: <linux-iio+bounces-24278-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92938B87FDE
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 08:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D33C4639BD
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 06:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B9229BDBC;
	Fri, 19 Sep 2025 06:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+NIu5x0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F3D21FF24;
	Fri, 19 Sep 2025 06:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758263343; cv=none; b=NrwSvKWU/FIeA8T4z64uw2BhWmpfQE1ILJZ2v6/q5DAyIvWUkLY3WPjyRmqFIGACB8n91klIyxiqd7q8Eehk25e5NE962KQZec2OKdhVMHN8AwWYttAMuDcjpFG+62W2OTbWTANntHzXtGo8aqfWryV2I/1EX9HmK6qdXxcHbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758263343; c=relaxed/simple;
	bh=1dA4LqMD015yw3IbVxtUS6ilnL+cRVcNULs8C7ckGjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roIlGlOlf2iugQ5rYqVdZ1DOjOzQ7Chpg5LuSFDc8H2yxRTva7vB89CC5haNvAD4r32ZWZFtX0d8N50m6INR8TlAbOaoe9q2YtRpK/pV5tYJ9mNXm3XYnujoriF3q/arwGcbI6WVd34aE8oeT/WWW8Jp/BFAH9s8HEH0mkfDx1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+NIu5x0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758263341; x=1789799341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1dA4LqMD015yw3IbVxtUS6ilnL+cRVcNULs8C7ckGjM=;
  b=i+NIu5x0ibzSRneEPk7+KQMvCb9Kdlhs3zzkFraXBkbRPqudGa7UFwvw
   nhU2kWMppw0tUqMS6ibz6CT7DEpMoi4xxvOlbAY0QQEBsJ4Sob1nWDgOD
   SF0ZgWHzuRkhx68NgqBZ/t3pMkL1EILtaLRvPFHd7sMqonSDBeskT85Bw
   d36wyI7/NGId92jcxxH1hAQENUK4eXEqHpdF6yAXQa1mc0RRiEwd2IxKx
   hK4YjvrlVLZr+03DMPRGIAC8RVPfARJ/HAB/p1Kdq5aHoE7dUtyeMHFut
   g1IV8ERu/vtXN27sO8XKy1LDaO47HPg1aPtj4I/PVn06Glh34q67xPXe5
   A==;
X-CSE-ConnectionGUID: FdlVjhUpSVqhuH5iuPy0rw==
X-CSE-MsgGUID: XaJMRDX9RTu9Ht5AX7IvHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="63238509"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="63238509"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 23:28:59 -0700
X-CSE-ConnectionGUID: zx6p22r+QaSNoXCTHFyF4g==
X-CSE-MsgGUID: VNIjzq8mSLST2STe4v+vPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="206698556"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 18 Sep 2025 23:28:56 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzUc1-00042B-21;
	Fri, 19 Sep 2025 06:28:53 +0000
Date: Fri, 19 Sep 2025 14:27:55 +0800
From: kernel test robot <lkp@intel.com>
To: victor.duicu@microchip.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, marius.cristea@microchip.com,
	victor.duicu@microchip.com
Subject: Re: [PATCH v5 2/2] iio: temperature: add support for MCP998X
Message-ID: <202509191423.1OvJW2X1-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 671b9b6d7f4fe17a174c410397e72253877ca64e]

url:    https://github.com/intel-lab-lkp/linux/commits/victor-duicu-microchip-com/dt-bindings-iio-temperature-add-support-for-MCP998X/20250918-192457
base:   671b9b6d7f4fe17a174c410397e72253877ca64e
patch link:    https://lore.kernel.org/r/20250918111937.5150-3-victor.duicu%40microchip.com
patch subject: [PATCH v5 2/2] iio: temperature: add support for MCP998X
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20250919/202509191423.1OvJW2X1-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250919/202509191423.1OvJW2X1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509191423.1OvJW2X1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/temperature/mcp9982.c:470:3: error: expected expression
     470 |                 u8 bulk_read[3];
         |                 ^
>> drivers/iio/temperature/mcp9982.c:473:31: error: use of undeclared identifier 'bulk_read'; did you mean 'up_read'?
     473 |                                        &bulk_read, sizeof(bulk_read));
         |                                                           ^~~~~~~~~
         |                                                           up_read
   include/linux/rwsem.h:246:13: note: 'up_read' declared here
     246 | extern void up_read(struct rw_semaphore *sem);
         |             ^
   drivers/iio/temperature/mcp9982.c:473:13: error: use of undeclared identifier 'bulk_read'; did you mean 'up_read'?
     473 |                                        &bulk_read, sizeof(bulk_read));
         |                                         ^~~~~~~~~
         |                                         up_read
   include/linux/rwsem.h:246:13: note: 'up_read' declared here
     246 | extern void up_read(struct rw_semaphore *sem);
         |             ^
   drivers/iio/temperature/mcp9982.c:477:11: error: use of undeclared identifier 'bulk_read'; did you mean 'up_read'?
     477 |                 *val = (bulk_read[1] << 8) + (bulk_read[2]);
         |                         ^~~~~~~~~
         |                         up_read
   include/linux/rwsem.h:246:13: note: 'up_read' declared here
     246 | extern void up_read(struct rw_semaphore *sem);
         |             ^
>> drivers/iio/temperature/mcp9982.c:477:11: error: subscript of pointer to function type 'void (struct rw_semaphore *)'
     477 |                 *val = (bulk_read[1] << 8) + (bulk_read[2]);
         |                         ^~~~~~~~~
   drivers/iio/temperature/mcp9982.c:477:33: error: use of undeclared identifier 'bulk_read'; did you mean 'up_read'?
     477 |                 *val = (bulk_read[1] << 8) + (bulk_read[2]);
         |                                               ^~~~~~~~~
         |                                               up_read
   include/linux/rwsem.h:246:13: note: 'up_read' declared here
     246 | extern void up_read(struct rw_semaphore *sem);
         |             ^
   drivers/iio/temperature/mcp9982.c:477:33: error: subscript of pointer to function type 'void (struct rw_semaphore *)'
     477 |                 *val = (bulk_read[1] << 8) + (bulk_read[2]);
         |                                               ^~~~~~~~~
   drivers/iio/temperature/mcp9982.c:488:3: error: expected expression
     488 |                 unsigned long *src;
         |                 ^
>> drivers/iio/temperature/mcp9982.c:493:4: error: use of undeclared identifier 'src'
     493 |                 *src = tmp_reg;
         |                  ^
   drivers/iio/temperature/mcp9982.c:494:68: error: use of undeclared identifier 'src'
     494 |                 *val = mcp9982_3db_values_map_tbl[priv->sampl_idx][bitmap_weight(src, 2)][0];
         |                                                                                  ^
   drivers/iio/temperature/mcp9982.c:495:69: error: use of undeclared identifier 'src'
     495 |                 *val2 = mcp9982_3db_values_map_tbl[priv->sampl_idx][bitmap_weight(src, 2)][1];
         |                                                                                   ^
   11 errors generated.


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
 > 473					       &bulk_read, sizeof(bulk_read));
   474			if (ret)
   475				return ret;
   476	
 > 477			*val = (bulk_read[1] << 8) + (bulk_read[2]);
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

