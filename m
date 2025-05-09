Return-Path: <linux-iio+bounces-19404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BA9AB2023
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 00:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4290E7B7F11
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 22:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC882638BF;
	Fri,  9 May 2025 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCG8HuXP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5AE22AE7E;
	Fri,  9 May 2025 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746831554; cv=none; b=TWi79BZHahVJAaG6jkTEY7vk7vWiQJimVM5or3PQ+inIf833ijgb1h50kb+K91ah4qHIfinRD7WzjUeN6x42lA5VHJtSAPvnLKm9WRLuzogrHvhKOl8iRLg4/6l1Fly3ifnrbgs3TUm+PNvt0ILJ/Q0gFrz4lWLMwg9JKtngTm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746831554; c=relaxed/simple;
	bh=6bTn5T9aJ1dG/QcSe0PfmEmuTX2zmPTsXHFZ/Ckvu4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4/HOq7SzZxbhwOd+rhKro7hhl/IeCJE9tu/ZiYHlK8K1PYpURJYyhZBY17AKtltYZ1KSr9ssSXsAOkYdvr0BlT23yx5YJYSMrXgAMC4F/t9FnOPBB7aXFAQkfx8rEYhz7EiWJfhLUfjkAsUN1IyQ+YY+sUWTqS910HeqVUJPbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCG8HuXP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746831550; x=1778367550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6bTn5T9aJ1dG/QcSe0PfmEmuTX2zmPTsXHFZ/Ckvu4s=;
  b=BCG8HuXPXOeqx7pfOSOLJuwHs2CnMEHGjUB53Gu2soToC8HAOL/2ZGfu
   LN3A51m0Mhk1LSZqbBHmMZFTSE8hEIKdQFREU4t+wk9HfSYIPgTLbH70a
   GNGH4j64FagedBSCW44wygQe8XjKAG149B0PK6/V4NMgLmqlAZen72oKM
   rcbQ57Rzb2wtFQX1ZVi66kMwpPqwudUC2qtaT7BYME906Ey10qdbC/5WB
   pktI5S500SyhJjgsdpKZwO/FrzSV5XQMDmhMYNpZN7yVg+2PvNP7PsNoc
   aeC/S7SzrMOSG0pJ+2YeOJw/4oWejRIrcohp4Jg+auAzhBLO83MWJmgLo
   g==;
X-CSE-ConnectionGUID: X46/+JxYQIycECRufFgfqA==
X-CSE-MsgGUID: Fn2Kzkz+QmSXGaYt91ibjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="60078282"
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="60078282"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 15:59:10 -0700
X-CSE-ConnectionGUID: r6YHvPDuShS0AB1W6ENsDw==
X-CSE-MsgGUID: 2JJVb3O3TP6jueuAMyjwGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="137693712"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 09 May 2025 15:59:07 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDWgK-000CYR-3B;
	Fri, 09 May 2025 22:59:04 +0000
Date: Sat, 10 May 2025 06:58:21 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Ijano <andrew.ijano@gmail.com>, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrew.lopes@alumni.usp.br,
	gustavobastos@usp.br, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, jstephan@baylibre.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: accel: sca3000: replace usages of internal read
 data helpers by spi helpers
Message-ID: <202505100631.nlBOlbYm-lkp@intel.com>
References: <20250509013931.47524-1-andrew.lopes@alumni.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509013931.47524-1-andrew.lopes@alumni.usp.br>

Hi Andrew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.15-rc5 next-20250509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrew-Ijano/iio-accel-sca3000-replace-usages-of-internal-read-data-helpers-by-spi-helpers/20250509-094127
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250509013931.47524-1-andrew.lopes%40alumni.usp.br
patch subject: [PATCH v3] iio: accel: sca3000: replace usages of internal read data helpers by spi helpers
config: i386-randconfig-r123-20250510 (https://download.01.org/0day-ci/archive/20250510/202505100631.nlBOlbYm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250510/202505100631.nlBOlbYm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505100631.nlBOlbYm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/accel/sca3000.c:745:46: sparse: sparse: cast to restricted __be16
   drivers/iio/accel/sca3000.c:756:33: sparse: sparse: cast to restricted __be16

vim +745 drivers/iio/accel/sca3000.c

   720	
   721	static int sca3000_read_raw(struct iio_dev *indio_dev,
   722				    struct iio_chan_spec const *chan,
   723				    int *val,
   724				    int *val2,
   725				    long mask)
   726	{
   727		struct sca3000_state *st = iio_priv(indio_dev);
   728		int ret;
   729		u8 address;
   730	
   731		switch (mask) {
   732		case IIO_CHAN_INFO_RAW:
   733			mutex_lock(&st->lock);
   734			if (chan->type == IIO_ACCEL) {
   735				if (st->mo_det_use_count) {
   736					mutex_unlock(&st->lock);
   737					return -EBUSY;
   738				}
   739				address = sca3000_addresses[chan->address][0];
   740				ret = spi_w8r16(st->us, SCA3000_READ_REG(address));
   741				if (ret < 0) {
   742					mutex_unlock(&st->lock);
   743					return ret;
   744				}
 > 745				*val = sign_extend32(be16_to_cpu((__be16) ret) >>
   746						     chan->scan_type.shift,
   747						     chan->scan_type.realbits - 1);
   748			} else {
   749				/* get the temperature when available */
   750				ret = spi_w8r16(st->us,
   751							SCA3000_READ_REG(SCA3000_REG_TEMP_MSB_ADDR));
   752				if (ret < 0) {
   753					mutex_unlock(&st->lock);
   754					return ret;
   755				}
   756				*val = (be16_to_cpu((__be16) ret) >>
   757					chan->scan_type.shift) &
   758					GENMASK(chan->scan_type.realbits - 1, 0);
   759			}
   760			mutex_unlock(&st->lock);
   761			return IIO_VAL_INT;
   762		case IIO_CHAN_INFO_SCALE:
   763			*val = 0;
   764			if (chan->type == IIO_ACCEL)
   765				*val2 = st->info->scale;
   766			else /* temperature */
   767				*val2 = 555556;
   768			return IIO_VAL_INT_PLUS_MICRO;
   769		case IIO_CHAN_INFO_OFFSET:
   770			*val = -214;
   771			*val2 = 600000;
   772			return IIO_VAL_INT_PLUS_MICRO;
   773		case IIO_CHAN_INFO_SAMP_FREQ:
   774			mutex_lock(&st->lock);
   775			ret = sca3000_read_raw_samp_freq(st, val);
   776			mutex_unlock(&st->lock);
   777			return ret ? ret : IIO_VAL_INT;
   778		case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
   779			mutex_lock(&st->lock);
   780			ret = sca3000_read_3db_freq(st, val);
   781			mutex_unlock(&st->lock);
   782			return ret;
   783		default:
   784			return -EINVAL;
   785		}
   786	}
   787	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

