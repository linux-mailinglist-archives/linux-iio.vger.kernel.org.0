Return-Path: <linux-iio+bounces-12342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB2B9D0490
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 16:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69E7D1F21675
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 15:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACED31D9A78;
	Sun, 17 Nov 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqVMyXXs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9694A937;
	Sun, 17 Nov 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731858650; cv=none; b=VbY07Hytkic0cYfvJAVKUvKP6E9Dpx7VhHieYkqSZ8bbk+OMru41DFw0HJ0bURkEFfJYv6ZZTL3j3cKWq0fErfKUSiN0HTBEUdSSeuG6osRfGeOAkBZDkCdspiph6t46CdeuZkaDfMqpyn/22giNtgY8/VRMGQHXop7XzUxoSk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731858650; c=relaxed/simple;
	bh=rTKP8/CP011uFuzkCTsKOQIZpgMpakze64ZAd9/JTvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP2wANH50qR/xHwGxMP16SHiBH6VP+NIXubSxokoBF8KXOm3IVLe5LK0CU+I+XuREPpurZefF7kdUqdlOpiIy0W338zzXZXEFbjvlYh0BpJNSi42u27qYP+T8gV8wXqO7AknfKCQYshS+6GdTvSAQ28DzVRMZqKlQZNyKgMebPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqVMyXXs; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731858649; x=1763394649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rTKP8/CP011uFuzkCTsKOQIZpgMpakze64ZAd9/JTvw=;
  b=IqVMyXXssopLMPjNVoCNwyiwi0dPM6rqAunDbV0YFRjje6IgHHcCYGz2
   AXqGhRPJXLHoIOk9kjCwOQ3+qd9+vJnjCxFPWi3rbglRnAhhZoJMqnE4p
   n3PP8guqxUxsuSwyDGdq990hwzxDoLOfRhg2xV0C/5qd2D1aASsyU91NN
   J6VweX3ZUAedS7/PPeznF/FeOCYliuabOMpGlVOrvzsdhpgJwZCjII9WD
   JbKbiXX0gVkCjRa6TAs37g6GDF/n4nf5o/l+qXvXoIeP6pyrxNdBXY8JJ
   2zJvsN7vPktvFFYzCy3kxqEej1k7mFh1+Gyej8L4zVHbohqriXEk9/2Go
   Q==;
X-CSE-ConnectionGUID: HEqo1eELT7OLFcrl99qbyw==
X-CSE-MsgGUID: LAKloXoKQy6iEn69fu7Adg==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="42337547"
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="42337547"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 07:50:48 -0800
X-CSE-ConnectionGUID: JLjQqwncTrin7ITpXJlGpQ==
X-CSE-MsgGUID: k2gpTkHVTUOxK73LXVDuVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="89432164"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Nov 2024 07:50:46 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tChXv-0001pl-2c;
	Sun, 17 Nov 2024 15:50:43 +0000
Date: Sun, 17 Nov 2024 23:49:59 +0800
From: kernel test robot <lkp@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH 15/22] iio: accel: adxl345: reset the FIFO on error
Message-ID: <202411172311.p8Krv6kq-lkp@intel.com>
References: <20241114231002.98595-16-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114231002.98595-16-l.rubusch@gmail.com>

Hi Lothar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.12-rc7 next-20241115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lothar-Rubusch/iio-accel-adxl345-fix-comment-on-probe/20241115-190245
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20241114231002.98595-16-l.rubusch%40gmail.com
patch subject: [PATCH 15/22] iio: accel: adxl345: reset the FIFO on error
config: x86_64-randconfig-121-20241117 (https://download.01.org/0day-ci/archive/20241117/202411172311.p8Krv6kq-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411172311.p8Krv6kq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411172311.p8Krv6kq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/accel/adxl345_core.c:383:6: sparse: sparse: symbol 'adxl345_empty_fifo' was not declared. Should it be static?

vim +/adxl345_empty_fifo +383 drivers/iio/accel/adxl345_core.c

   376	
   377	/**
   378	 * Empty the fifo. This is needed also in case of overflow or error handling.
   379	 * Read out all remaining elements and reset the fifo_entries counter.
   380	 *
   381	 * @st: The instance to the state object of the sensor.
   382	 */
 > 383	void adxl345_empty_fifo(struct adxl34x_state *st)
   384	{
   385		int regval;
   386		int fifo_entries;
   387	
   388		/* In case the HW is not "clean" just read out remaining elements */
   389		adxl345_get_fifo_entries(st, &fifo_entries);
   390		if (fifo_entries > 0)
   391			adxl345_read_fifo_elements(st, fifo_entries);
   392	
   393		/* Reset the INT_SOURCE register by reading the register */
   394		regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
   395	}
   396	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

