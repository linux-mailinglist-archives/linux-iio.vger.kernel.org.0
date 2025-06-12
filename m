Return-Path: <linux-iio+bounces-20557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5882CAD7477
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 16:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61583AD4F9
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 14:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28CE1A0BE0;
	Thu, 12 Jun 2025 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJG3ne7l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9486E15278E;
	Thu, 12 Jun 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739709; cv=none; b=YM49JxEt7DfANs9QTPSHAfPkH6Q4qxuFDncpYIWCLR3b8x/Xe3a0rbqFOKcwNjsvXyKLSeurZ13eM+8v4fG6Y2WXpuGyvJ5pnPMo0i5kV/vIgSGjfmRzdoL+plgeolgI4raWwl2fZrXrKSs2ftNGbgv7oeaROm+ofxHAA10GQi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739709; c=relaxed/simple;
	bh=/e5p9osxkx51XqE1aDEoQ2Zc1sIKmHJxGFwG2HbrwZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3uZ5QL/mnn9JEnJw8PTFhQwNbY4y60iZqvDx1ywEalm91ih24UfW5gepxIzR5NfGSnEDOtPMFRVDXoaiD0SPXeXGqSIRTPkVp48v6WflK6C7sS0q9EnIUw2qc5ptuaJIqq1Y8kzKrlEW9/SxKegIxZCuglIeuJS6CgMkG7Atv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJG3ne7l; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749739707; x=1781275707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/e5p9osxkx51XqE1aDEoQ2Zc1sIKmHJxGFwG2HbrwZc=;
  b=HJG3ne7l1yPdaVoVGhE2izVKE6pBT7+j9O1mEKdjZBuv5i4xSGJ7O+mn
   4gCKgRjt5EEjOR8Kp9XUY/qm4J5bFzomU6sDLdGd/FuUwDWXmAi23e8Gv
   VCgqDvVFWFAqWMVrJg82ZIztNAT0saWfDlokNGm46yh/bmg8CqPdeyhYo
   DrcpZgJdg8ODxGhwlBq0v1/tP5ak0BxvH3VQ6LkoQMAtqKnVRdaGvtaXH
   Cwaf1gqkGoTtLyOR3NE71vrWGu7gTcvPpEtnclYXYa38cMk86NR9CX+Ak
   1idyT0OZIxUJHHx/ax02LO3cm+6PwIcaG1eypI+3oJ1bi6fSba7f8IR2c
   g==;
X-CSE-ConnectionGUID: rsFrGFXCTu+Zsn2njnTPNQ==
X-CSE-MsgGUID: 6UCjos3fQGq3grQ4RnJlqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="62575558"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="62575558"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 07:48:26 -0700
X-CSE-ConnectionGUID: Vhjg/c83SbmrpWICjHaNsw==
X-CSE-MsgGUID: 8nxIzQ8OTQGh19CZGtxRng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="170720366"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 Jun 2025 07:48:23 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uPjE5-000BfW-12;
	Thu, 12 Jun 2025 14:48:21 +0000
Date: Thu, 12 Jun 2025 22:48:00 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Ijano <andrew.ijano@gmail.com>, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrew.lopes@alumni.usp.br,
	gustavobastos@usp.br, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, jstephan@baylibre.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: accel: sca3000: use guard(mutex)() for
 handling mutex lock
Message-ID: <202506122259.4MrANF8h-lkp@intel.com>
References: <20250611194648.18133-4-andrew.lopes@alumni.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611194648.18133-4-andrew.lopes@alumni.usp.br>

Hi Andrew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.16-rc1 next-20250612]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Ijano/iio-accel-sca3000-replace-error_ret-labels-by-simple-returns/20250612-034940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250611194648.18133-4-andrew.lopes%40alumni.usp.br
patch subject: [PATCH v5 3/3] iio: accel: sca3000: use guard(mutex)() for handling mutex lock
config: x86_64-randconfig-001-20250612 (https://download.01.org/0day-ci/archive/20250612/202506122259.4MrANF8h-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250612/202506122259.4MrANF8h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506122259.4MrANF8h-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/accel/sca3000.c: In function 'sca3000_write_raw':
>> drivers/iio/accel/sca3000.c:748:13: warning: unused variable 'ret' [-Wunused-variable]
     748 |         int ret;
         |             ^~~
   drivers/iio/accel/sca3000.c: In function 'sca3000_write_event_value':
   drivers/iio/accel/sca3000.c:881:13: warning: unused variable 'ret' [-Wunused-variable]
     881 |         int ret;
         |             ^~~
   drivers/iio/accel/sca3000.c: In function 'sca3000_write_event_config':
   drivers/iio/accel/sca3000.c:1188:13: warning: unused variable 'ret' [-Wunused-variable]
    1188 |         int ret;
         |             ^~~


vim +/ret +748 drivers/iio/accel/sca3000.c

e0f3fc9b47e61b drivers/staging/iio/accel/sca3000_core.c Ico Doornekamp   2016-09-13  742  
e0f3fc9b47e61b drivers/staging/iio/accel/sca3000_core.c Ico Doornekamp   2016-09-13  743  static int sca3000_write_raw(struct iio_dev *indio_dev,
e0f3fc9b47e61b drivers/staging/iio/accel/sca3000_core.c Ico Doornekamp   2016-09-13  744  			     struct iio_chan_spec const *chan,
e0f3fc9b47e61b drivers/staging/iio/accel/sca3000_core.c Ico Doornekamp   2016-09-13  745  			     int val, int val2, long mask)
e0f3fc9b47e61b drivers/staging/iio/accel/sca3000_core.c Ico Doornekamp   2016-09-13  746  {
e0f3fc9b47e61b drivers/staging/iio/accel/sca3000_core.c Ico Doornekamp   2016-09-13  747  	struct sca3000_state *st = iio_priv(indio_dev);
e0f3fc9b47e61b drivers/staging/iio/accel/sca3000_core.c Ico Doornekamp   2016-09-13 @748  	int ret;
e0f3fc9b47e61b drivers/staging/iio/accel/sca3000_core.c Ico Doornekamp   2016-09-13  749  
e0f3fc9b47e61b drivers/staging/iio/accel/sca3000_core.c Ico Doornekamp   2016-09-13  750  	switch (mask) {
e0f3fc9b47e61b drivers/staging/iio/accel/sca3000_core.c Ico Doornekamp   2016-09-13  751  	case IIO_CHAN_INFO_SAMP_FREQ:
e0f3fc9b47e61b drivers/staging/iio/accel/sca3000_core.c Ico Doornekamp   2016-09-13  752  		if (val2)
e0f3fc9b47e61b drivers/staging/iio/accel/sca3000_core.c Ico Doornekamp   2016-09-13  753  			return -EINVAL;
926150211ef327 drivers/iio/accel/sca3000.c              Andrew Ijano     2025-06-11  754  		guard(mutex)(&st->lock);
926150211ef327 drivers/iio/accel/sca3000.c              Andrew Ijano     2025-06-11  755  		return sca3000_write_raw_samp_freq(st, val);
626f971b5b0729 drivers/staging/iio/accel/sca3000.c      Jonathan Cameron 2016-10-08  756  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
626f971b5b0729 drivers/staging/iio/accel/sca3000.c      Jonathan Cameron 2016-10-08  757  		if (val2)
626f971b5b0729 drivers/staging/iio/accel/sca3000.c      Jonathan Cameron 2016-10-08  758  			return -EINVAL;
926150211ef327 drivers/iio/accel/sca3000.c              Andrew Ijano     2025-06-11  759  		guard(mutex)(&st->lock);
926150211ef327 drivers/iio/accel/sca3000.c              Andrew Ijano     2025-06-11  760  		return sca3000_write_3db_freq(st, val);
25888dc51163a5 drivers/staging/iio/accel/sca3000_core.c Jonathan Cameron 2011-05-18  761  	default:
25888dc51163a5 drivers/staging/iio/accel/sca3000_core.c Jonathan Cameron 2011-05-18  762  		return -EINVAL;
25888dc51163a5 drivers/staging/iio/accel/sca3000_core.c Jonathan Cameron 2011-05-18  763  	}
25888dc51163a5 drivers/staging/iio/accel/sca3000_core.c Jonathan Cameron 2011-05-18  764  }
574fb258d63658 drivers/staging/iio/accel/sca3000_core.c Jonathan Cameron 2009-08-18  765  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

