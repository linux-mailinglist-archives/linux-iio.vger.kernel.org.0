Return-Path: <linux-iio+bounces-12341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5BC9D0246
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 08:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459CC1F23910
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 07:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF2769D31;
	Sun, 17 Nov 2024 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CciDX/37"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F6D3EA76;
	Sun, 17 Nov 2024 07:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731827592; cv=none; b=gBVKggI602JgPp5NQaIgQudtItD1TXFmzZDpPclxakKmeLlpMKcU+l2H+kv/mo4oqnCvZvSwrsMFCOyqqr/YrC0CgdltvhO8MDrDVNipJq05VL+olR8Q+XtnO9Dt3vw+aONi1CPndQ79iYNrx4/j//mnN8BoA8Bz8TUUXVEqNe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731827592; c=relaxed/simple;
	bh=rQBcQbykMk0tLp5YALUMbtDcDwg04OCFBS3BiDb9kO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrlHLUHQ0Fu/XmGP/SPWzf0mVWtavuFy6eIouhZttftuUq/K4saR8qXJmacPq7LphI6HmW40zEYKkw4BftwETIlPn7ofoVj9YEihT5mc+/Kb7Ek0KbZMvfV2BLHtD57RLEKTCqgEog/rWDVyX5A9hTiTjvgYyanBQXnX/Zz6fWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CciDX/37; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731827591; x=1763363591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rQBcQbykMk0tLp5YALUMbtDcDwg04OCFBS3BiDb9kO0=;
  b=CciDX/37ZAd9vXwTy9un8oMpqA182hVArqZyUaKmcaJG1TBTrpnIkjbI
   6LUtU+t3GMQ06LLEawlUNsRAhiEecbSdpBMTBiAQuWQBcLQqGjSzIhOPS
   cjvhJAnlBRbFyG5VmeSuZ7nfl/KAKtKj22WTFH4VP/xEg0q8gC7fr+vub
   Z7lABEds1fdYmHT+efLecmm0gfvoAhhXNtgo/xkcDxzyfzyG4Z589Sbt4
   G4jxBeTFk2S6eqPRpQ1Kf1ZJZMRbznSOb4ESlC3fifjGX0FnUuAtGYyO3
   U26vHSttEWIBgyl13G3lHOHB1kesgDWPIfebM04ZPXmu+MJa3WjV8bgCR
   A==;
X-CSE-ConnectionGUID: gECYEcolQfC4MiPgf99dMw==
X-CSE-MsgGUID: iSYbzjF4S5SdTzeHVxtTXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="31638519"
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="31638519"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 23:13:09 -0800
X-CSE-ConnectionGUID: e9FA9D5hTrurc79A9hOCaQ==
X-CSE-MsgGUID: wFdtOkIkQ1ay5u/4R5VxXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,161,1728975600"; 
   d="scan'208";a="89094162"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 16 Nov 2024 23:13:07 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCZSx-0001cP-34;
	Sun, 17 Nov 2024 07:13:03 +0000
Date: Sun, 17 Nov 2024 15:12:52 +0800
From: kernel test robot <lkp@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH 15/22] iio: accel: adxl345: reset the FIFO on error
Message-ID: <202411171552.BWbWLHpL-lkp@intel.com>
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
config: arm-randconfig-002-20241117 (https://download.01.org/0day-ci/archive/20241117/202411171552.BWbWLHpL-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411171552.BWbWLHpL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411171552.BWbWLHpL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/accel/adxl345_core.c:383:6: warning: no previous prototype for function 'adxl345_empty_fifo' [-Wmissing-prototypes]
     383 | void adxl345_empty_fifo(struct adxl34x_state *st)
         |      ^
   drivers/iio/accel/adxl345_core.c:383:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     383 | void adxl345_empty_fifo(struct adxl34x_state *st)
         | ^
         | static 
   1 warning generated.


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

