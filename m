Return-Path: <linux-iio+bounces-8646-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED90795939E
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 06:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D601F232EE
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 04:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3256F15C139;
	Wed, 21 Aug 2024 04:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIUbpKmE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526D97602D;
	Wed, 21 Aug 2024 04:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724214131; cv=none; b=j2ILLQyIZopo8PzlBJedCObCurwwywzFxamcL9Tq60LmT/Nfq3sVb8x3+0CQXo4z8W0shMo3acH6mq58BEgO6ieP0HTzOUjn5zDt6mbtzjtJ6NBTpnT9R6jDOAXmeXQ1iBVC5DsfSMZtcpCPnXJJr/8LOYbQGsMuy6w+/L+Y3eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724214131; c=relaxed/simple;
	bh=RLteaZvx78Nb1TJ71MHu/HAeSd6WAnVBBwl8ZzlxdTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u01zM6qwxzxyIHDNDnvTabiXVb/6sPhJPSSNsq7hoVZbTwwq0M1q+7kmKl7goWhQrripAihPHQjHKdpecOH9bDi4nMTFp/Qyj7YXCPHbkNdjcymrdhF9oDuDt3oT+apSUrzhi4OzcX1Nf3aLcRbBAdmf8RuLqii7+eP+NQAmeb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIUbpKmE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724214129; x=1755750129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RLteaZvx78Nb1TJ71MHu/HAeSd6WAnVBBwl8ZzlxdTc=;
  b=nIUbpKmEpf5QaT8YWfg9/FrEWmyPQIacY+ThdDyceXaQdvCDpwsW98i9
   8CgvXMvL5hoe8cSE90KCZKQ+LhadavbeEhVCI41kQCbOg1l8V6dPMBlSd
   Yr6MP030GFwfDwv6x1JAfpfKvccnlXt3NlYSXi7uS1qoAkOT5q0svHbtO
   k4mffrHymCoV2dHWn0e5D0ABMZiuobKoi4F+FSAsCuP1lxoT9Gx1OPt09
   Sx2IkIhNq2JL1Xg3ZQ7ZlA9ywA/yR9W3BS1gHcdIxHPtVto1T5B9j8+l1
   uu2w7y5cNFB2A0D5pbcqaeGD0MFzEPXd8hjrqZ/sDEVSLL6Q9mPV1+/Ki
   g==;
X-CSE-ConnectionGUID: 5uQu//3kTtiDIEqPSHlcqQ==
X-CSE-MsgGUID: rBVXw6wZQD6Jigyg50nilA==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="26307852"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="26307852"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 21:22:09 -0700
X-CSE-ConnectionGUID: 2ZMCorPEQJKUtvK2cp51Kw==
X-CSE-MsgGUID: ERd4brl8QOqPqedHfLL83Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="65164031"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 20 Aug 2024 21:22:06 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgcrE-000At4-1F;
	Wed, 21 Aug 2024 04:22:04 +0000
Date: Wed, 21 Aug 2024 12:21:09 +0800
From: kernel test robot <lkp@intel.com>
To: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 2/4] iio: adc: ad4695: implement calibration support
Message-ID: <202408211207.fmYTjQDK-lkp@intel.com>
References: <20240820-ad4695-gain-offset-v1-2-c8f6e3b47551@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820-ad4695-gain-offset-v1-2-c8f6e3b47551@baylibre.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0f718e10da81446df0909c9939dff2b77e3b4e95]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-adc-ad4695-add-2nd-regmap-for-16-bit-registers/20240821-000102
base:   0f718e10da81446df0909c9939dff2b77e3b4e95
patch link:    https://lore.kernel.org/r/20240820-ad4695-gain-offset-v1-2-c8f6e3b47551%40baylibre.com
patch subject: [PATCH 2/4] iio: adc: ad4695: implement calibration support
config: i386-buildonly-randconfig-002-20240821 (https://download.01.org/0day-ci/archive/20240821/202408211207.fmYTjQDK-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240821/202408211207.fmYTjQDK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408211207.fmYTjQDK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ad4695.c:735:6: warning: unused variable 'ret' [-Wunused-variable]
     735 |         int ret;
         |             ^~~
   1 warning generated.


vim +/ret +735 drivers/iio/adc/ad4695.c

   728	
   729	static int ad4695_write_raw(struct iio_dev *indio_dev,
   730				    struct iio_chan_spec const *chan,
   731				    int val, int val2, long mask)
   732	{
   733		struct ad4695_state *st = iio_priv(indio_dev);
   734		unsigned int reg_val;
 > 735		int ret;
   736	
   737		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
   738			switch (mask) {
   739			case IIO_CHAN_INFO_CALIBSCALE:
   740				switch (chan->type) {
   741				case IIO_VOLTAGE:
   742					if (val < 0 || val2 < 0)
   743						reg_val = 0;
   744					else if (val > 1)
   745						reg_val = U16_MAX;
   746					else
   747						reg_val = (val * (1 << 16) +
   748							   mul_u64_u32_div(val2, 1 << 16,
   749									   MICRO)) / 2;
   750	
   751					return regmap_write(st->regmap16,
   752						AD4695_REG_GAIN_IN(chan->scan_index),
   753						reg_val);
   754				default:
   755					return -EINVAL;
   756				}
   757			case IIO_CHAN_INFO_CALIBBIAS:
   758				switch (chan->type) {
   759				case IIO_VOLTAGE:
   760					if (val2 >= 0 && val > S16_MAX / 4)
   761						reg_val = S16_MAX;
   762					else if ((val2 < 0 ? -val : val) < S16_MIN / 4)
   763						reg_val = S16_MIN;
   764					else if (val2 < 0)
   765						reg_val = clamp_t(int,
   766							-(val * 4 + -val2 * 4 / MICRO),
   767							S16_MIN, S16_MAX);
   768					else if (val < 0)
   769						reg_val = clamp_t(int,
   770							val * 4 - val2 * 4 / MICRO,
   771							S16_MIN, S16_MAX);
   772					else
   773						reg_val = clamp_t(int,
   774							val * 4 + val2 * 4 / MICRO,
   775							S16_MIN, S16_MAX);
   776	
   777					return regmap_write(st->regmap16,
   778						AD4695_REG_OFFSET_IN(chan->scan_index),
   779						reg_val);
   780				default:
   781					return -EINVAL;
   782				}
   783			default:
   784				return -EINVAL;
   785			}
   786		}
   787		unreachable();
   788	}
   789	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

