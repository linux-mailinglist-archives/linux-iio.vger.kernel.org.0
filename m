Return-Path: <linux-iio+bounces-20002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D12AC7AF2
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 11:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7B04A0C30
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 09:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3BD21C187;
	Thu, 29 May 2025 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHl4OHCJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1C4219302;
	Thu, 29 May 2025 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748510578; cv=none; b=btuOd07/WS+QeJeUG6QtspmaScgCTW8V4dlmsSWhPvhSk0AwiPIKCGA7kwDzUZMqUQPRP/dO8+tJfnW2fE2J3bfopkEN1+z6yExGGNFCAfLUT0wpSea43H/446ujVuvVo2FQJXMu4d3566nK9vqHSiKdMqw+VOs8mY1P0k3XPPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748510578; c=relaxed/simple;
	bh=i3CAwiCoEjbFznMoQgq/hG6fd2mUML8gqX6vftdQ8DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJm+OhHFpRn/4eB1bc5+xioCnSPasKLDgFmjyusvw3c8rwLr8ClSdmw6FYo4UADMZxRSqO9SNbmwQMmOOppgXZCUlrruO7/nYop/Gkue2+Ze+pgDpopvxHbLp3Ryvqmqw+Wvx5FVdM5lnBJmjpxqbMMpVP/itSL4dwEuTMYZPtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dHl4OHCJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748510576; x=1780046576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i3CAwiCoEjbFznMoQgq/hG6fd2mUML8gqX6vftdQ8DM=;
  b=dHl4OHCJt0E+iRoAOfPhRtCeCmII7MubxSpoJd9LmVh15KNXAhM0R4qr
   xrAWPBmeBDS7qyvZcwkPWUCXCdSrRDuuYz4B4Z0bDTTYqg2jqw6AA5d9d
   homDscqP4Mzx3nb8owuchnEe21lllK+B9JcM9i3lMKrt2/+w+qTvRzof+
   3o0oEDQjkjjhz6Hfvc7+vDRiqu0Zg611+O3sU/u6+0MsJqFJf6jA0qY3T
   IfFCi1BTHpJnBPyjSSFgfNNINxrhGT9wawKozUbBkepW5AV+PODYA4Krv
   5s4T1j25L9XnhC3udqI7JWXq42hb3NUhSXLGzTTvOIiqhLaVmQ77Cfsy8
   A==;
X-CSE-ConnectionGUID: /Zb3njGBQJqNeBgMtldxzw==
X-CSE-MsgGUID: grZi7n7YTMWDYH9tGptvBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="54361425"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="54361425"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 02:22:55 -0700
X-CSE-ConnectionGUID: 7upNn49tQPG7cPBFS1RClw==
X-CSE-MsgGUID: dtQC3ucUR0CdobThUdO6iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="143475369"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 29 May 2025 02:22:53 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKZTO-000WWm-2F;
	Thu, 29 May 2025 09:22:50 +0000
Date: Thu, 29 May 2025 17:21:59 +0800
From: kernel test robot <lkp@intel.com>
To: Dharma Balasubiramani <dharma.b@microchip.com>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dharma Balasubiramani <dharma.b@microchip.com>
Subject: Re: [PATCH 2/2] counter: microchip-tcb-capture: Add DMA support for
 TC_RAB register reads
Message-ID: <202505291723.WYIWqmvP-lkp@intel.com>
References: <20250528-mchp-tcb-dma-v1-2-083a41fb7b51@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528-mchp-tcb-dma-v1-2-083a41fb7b51@microchip.com>

Hi Dharma,

kernel test robot noticed the following build warnings:

[auto build test WARNING on fefff2755f2aa4125dce2a1edfe7e545c7c621f2]

url:    https://github.com/intel-lab-lkp/linux/commits/Dharma-Balasubiramani/counter-microchip-tcb-capture-Retrieve-and-map-parent-base-address/20250528-141627
base:   fefff2755f2aa4125dce2a1edfe7e545c7c621f2
patch link:    https://lore.kernel.org/r/20250528-mchp-tcb-dma-v1-2-083a41fb7b51%40microchip.com
patch subject: [PATCH 2/2] counter: microchip-tcb-capture: Add DMA support for TC_RAB register reads
config: arm-randconfig-r121-20250529 (https://download.01.org/0day-ci/archive/20250529/202505291723.WYIWqmvP-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.3.0
reproduce: (https://download.01.org/0day-ci/archive/20250529/202505291723.WYIWqmvP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505291723.WYIWqmvP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/counter/microchip-tcb-capture.c:140:16: sparse: sparse: cast to restricted __le32

vim +140 drivers/counter/microchip-tcb-capture.c

   101	
   102	static int mchp_tc_dma_transfer(struct mchp_tc_data *priv, u32 *val)
   103	{
   104		struct dma_async_tx_descriptor *desc;
   105		struct device *dev = &priv->pdev->dev;
   106		dma_cookie_t cookie;
   107		int ret;
   108	
   109		ret = dmaengine_slave_config(priv->dma.chan, &priv->dma.slave_cfg);
   110		if (ret) {
   111			dev_err(dev, "DMA slave_config failed (%d)\n", ret);
   112			return ret;
   113		}
   114	
   115		desc = dmaengine_prep_dma_memcpy(priv->dma.chan,
   116						 priv->dma.addr,
   117						 priv->dma.slave_cfg.src_addr,
   118						 sizeof(u32),
   119						 DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
   120		if (!desc) {
   121			dev_err(dev, "DMA prep descriptor failed\n");
   122			return -ENOMEM;
   123		}
   124	
   125		cookie = dmaengine_submit(desc);
   126		if (dma_submit_error(cookie)) {
   127			dev_err(dev, "DMA submit error (%d)\n", cookie);
   128			return cookie ?: -EIO;
   129		}
   130	
   131		dma_async_issue_pending(priv->dma.chan);
   132	
   133		ret = dma_sync_wait(priv->dma.chan, cookie);
   134		if (ret) {
   135			dev_err(dev, "DMA transfer timed out (%d)\n", ret);
   136			return ret;
   137		}
   138	
   139		/* Retrieve the 32-bit value the engine just copied */
 > 140		*val = le32_to_cpu(*(u32 *)priv->dma.buf);
   141	
   142		return 0;
   143	}
   144	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

