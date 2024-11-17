Return-Path: <linux-iio+bounces-12339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7401F9D01C2
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 01:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AF8CB24805
	for <lists+linux-iio@lfdr.de>; Sun, 17 Nov 2024 00:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C32A92D;
	Sun, 17 Nov 2024 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kC5vSboK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18468F58;
	Sun, 17 Nov 2024 00:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731804389; cv=none; b=Q4TGWGDijuhF5/SbZvJ46NPuD5yQzHgATaKIKX0uC4YazRTX44zvxFaCzxBOciun63PgQ4io3KQDRmNLENlk6G+A5slSKFOydpxvLkvhNTugt+itKBisI4A1V0Ia0gTyHJEsVN5r/PEni2DNw9z0+BBBCF1IYjnGHz/O2pbSiKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731804389; c=relaxed/simple;
	bh=PzXGeeIrOWYZEs2yRXxGZGL8FaOkxUAdrGfguYkWM5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvVUFbB2mgOMKKlDdNKCw0DCYlJye/3zxgj6cYVfpGac/xob7eOMOlES2zNGoZvNANPEoPFxXpUJWOBU6u9Yt0U9DlIQ7m7DkQNgZeORyMVss1wa9g4qVZ0Z/KrblXM3NY2oZYU68k5ZRoKHeDDUt3u78nhFcs1WMqdgd6oJ1as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kC5vSboK; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731804388; x=1763340388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PzXGeeIrOWYZEs2yRXxGZGL8FaOkxUAdrGfguYkWM5Y=;
  b=kC5vSboKbQUZEp3N8U4k45h0j+XYJjUO/0tkVEHAU4/uHjncfO9ZnQJ/
   /ZglLRg0qqPEGJkeUFKnEmc1HgoKwwOeDUZNWI9bTMADJZLdnHaL0TRcJ
   rlcBNyA8fF/iYKjvJDdy1ymD5+I/jt/CSPgE/Svjrv5EbzKI7JLtwoSM0
   zgzO+Xuj+lJYLEbKDTHaxtYcxE50ITmH7NQKAopzit1nr8Gw0qVbkRC84
   GhrCiaZAsK+317FmfHY8dTNC/Ttvwyjy9r/Ulwby+DkYe8hEx270n/Ac7
   Om5H+ohQaKG06LZGRXHuNeWpF5FnNpY9EWPLRzY5jmNrG5nFWvSS/h+YT
   Q==;
X-CSE-ConnectionGUID: 1y0NOOuZQZqvp2Nf+23Otw==
X-CSE-MsgGUID: sjyaCh+PQxKTnOFom9DF6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="19393986"
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="19393986"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 16:46:27 -0800
X-CSE-ConnectionGUID: 0LV3cbWDT+6oY7XfbwPSng==
X-CSE-MsgGUID: Y+/tZA4MTXm8TYfHtBtseA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="93724253"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 16 Nov 2024 16:46:25 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCTQk-0001CH-3D;
	Sun, 17 Nov 2024 00:46:22 +0000
Date: Sun, 17 Nov 2024 08:45:30 +0800
From: kernel test robot <lkp@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH 15/22] iio: accel: adxl345: reset the FIFO on error
Message-ID: <202411170855.sbBnXXo4-lkp@intel.com>
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
config: arc-randconfig-r052-20241117 (https://download.01.org/0day-ci/archive/20241117/202411170855.sbBnXXo4-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411170855.sbBnXXo4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411170855.sbBnXXo4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/accel/adxl345_core.c:383:6: warning: no previous prototype for 'adxl345_empty_fifo' [-Wmissing-prototypes]
     383 | void adxl345_empty_fifo(struct adxl34x_state *st)
         |      ^~~~~~~~~~~~~~~~~~


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

