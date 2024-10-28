Return-Path: <linux-iio+bounces-11498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FCB9B36CD
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 17:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4EE81F228E1
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 16:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357301DEFE0;
	Mon, 28 Oct 2024 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLUX3CBN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0D81DE2DC;
	Mon, 28 Oct 2024 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133582; cv=none; b=Q5PRabqkwqesgvnKqt5SIxIXkYoFSX5wFRk9KsVikmAuK5U7A3j8wvTlwedHQlrGOX02SUTL6430ooSKsepE1dnrOGbpD59V1JX2Jcs3tf4DvfFqzmIgUbCkfAAo9eUV9HXt9tGW8jtpFcWUvIvPoic0OogiaegUushgydxhngU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133582; c=relaxed/simple;
	bh=fiXY0vBhE6jws7H+dL2nxhmyZmqprXYvqHlCr/avfYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBnTQ6jeMqMCxNuCEawM2xzxVxH5rA/NkdGY6LCa3gXaepMoRq2RQyn9XfbYKDcgSmREq6uHdUtcJLJRoktAILtmPYyI4MtVsRFFhnCnxbQwRXB9m91DM24tZnzQfL136cCQfn4vtD0H5gbYs7WVHUSYKCAsQeMuBE4EOXwT2FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLUX3CBN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730133580; x=1761669580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fiXY0vBhE6jws7H+dL2nxhmyZmqprXYvqHlCr/avfYM=;
  b=bLUX3CBNyqIyw25KAWaEJb6N4XuR9tosg0Q18GlNbrpsODh9ixZW/uH7
   nJBEwxJ8xK4fDIywFkz5f75Wexn3iBk3zmSDzL0ZIZhIk4K4x7StbtmH6
   wMeBdvdL/VyzM6Y2o6JBRt569vcFgrr5aGawA93laPkNJQAqty0FdoIJI
   B/xB1uUYqfRGhhSQF2IjeagQOXjjiFd3S8gJYuN3tHl4G5hAlSb2QXmei
   1xVvN4Qhi/eIJ9n1d9ZLVSMkwd5Asya4W5Dp0FDsf+MHtg18tbnn4+8FZ
   eozeHMHDd0TOHQVAHSebvj/tQx8L5iGSnCK54FlYSsRBJa0b8GHEYUA9b
   g==;
X-CSE-ConnectionGUID: 67UzsGSOQ5yIdPkyvbuGnw==
X-CSE-MsgGUID: 9aeZluSfRFS51TnKkomMJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29847735"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29847735"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:39:16 -0700
X-CSE-ConnectionGUID: ChGe4zLBS9qZI1XWNKWzOA==
X-CSE-MsgGUID: sBwlz7ESR2C0kEEeyAkrTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112487136"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 28 Oct 2024 09:39:13 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5Slq-000cdw-21;
	Mon, 28 Oct 2024 16:39:10 +0000
Date: Tue, 29 Oct 2024 00:38:54 +0800
From: kernel test robot <lkp@intel.com>
To: ahaslam@baylibre.com, lars@metafoo.de, Michael.Hennerich@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH 3/6] iio: dac: ad5791: Include chip_info in device match
 tables
Message-ID: <202410282349.YFq0jd85-lkp@intel.com>
References: <20241028071118.699951-4-ahaslam@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028071118.699951-4-ahaslam@baylibre.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.12-rc5 next-20241028]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ahaslam-baylibre-com/dt-bindings-iio-dac-ad5791-Add-optional-reset-clr-and-ldac-gpios/20241028-151319
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20241028071118.699951-4-ahaslam%40baylibre.com
patch subject: [PATCH 3/6] iio: dac: ad5791: Include chip_info in device match tables
config: parisc-randconfig-r071-20241028 (https://download.01.org/0day-ci/archive/20241028/202410282349.YFq0jd85-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241028/202410282349.YFq0jd85-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410282349.YFq0jd85-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/dac/ad5791.c:71: warning: Function parameter or struct member 'name' not described in 'ad5791_chip_info'
>> drivers/iio/dac/ad5791.c:71: warning: Function parameter or struct member 'channel' not described in 'ad5791_chip_info'


vim +71 drivers/iio/dac/ad5791.c

20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04  61  
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04  62  /**
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04  63   * struct ad5791_chip_info - chip specific information
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04  64   * @get_lin_comp:	function pointer to the device specific function
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04  65   */
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04  66  
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04  67  struct ad5791_chip_info {
18e83b303d6e05 drivers/iio/dac/ad5791.c         Axel Haslam        2024-10-28  68  	const char *name;
18e83b303d6e05 drivers/iio/dac/ad5791.c         Axel Haslam        2024-10-28  69  	const struct iio_chan_spec channel;
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04  70  	int (*get_lin_comp)(unsigned int span);
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04 @71  };
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04  72  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

