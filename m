Return-Path: <linux-iio+bounces-16517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D7EA5677D
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 13:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE37B3A89BC
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 12:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F57218ADA;
	Fri,  7 Mar 2025 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SrupaYid"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325E217F31;
	Fri,  7 Mar 2025 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741349210; cv=none; b=oMjiA+Blnc8g2Zob7ju4FHGh0mtVPw6qvhr6IrC6lW3Sk3hY618rg+wjvAenkAe5wiG4LU40P2U/zvzh9loBky64CMkNFWdyUlRCXFWE0YINWh4YudMLr+x9SpOLHBa3/QBmwF2SfvZNzKBdHglXDxu9io+kkUaz/VrWD1PPkEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741349210; c=relaxed/simple;
	bh=HAZxAV0kKIr9bNaLTZEMnA90XTslNhxbETGdPtCuEfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQoyj0YfblpY57mYQdLw6x50Y123BYe5wGuHj3sRWgfXuosU0kKIPwSbD1ztEqxvnFvFBvPpTXH3DRcdf2MPgxWrmdLxF5RcOSrFIz3mPZZXpa+n4HIzv8IrmnhtNhllapauk0G6KFW5W7dKC5LTvo3jeJoWHww2d5DetDwBsjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SrupaYid; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741349209; x=1772885209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HAZxAV0kKIr9bNaLTZEMnA90XTslNhxbETGdPtCuEfw=;
  b=SrupaYid32EOijizWGImvTGAil7fAMLTxugHFXXJstj7ocXYRt6CoQlK
   YKUdZvIpbiSUKYpM+bSlvedQxLFf804slw1iABMx6TMaboofLIoz4NNh6
   iitMJhzGYINWs+iiTL/N0bveTSUSUT0P6yXiv+OkWjes8Q0TwXHt0geiD
   +T+Vmy1WQV2Obft6lXqax+0DHt2HroRVi1je8aGrcQ7P5Zu1cL2fGQq8F
   zN9P7tEaxJM0DjbnufitiERqiB/J2neduS5im4VNAxchcroUJOUkMtOXk
   FYdxAz+Gdd3k4cJk0ex0OSA3YUnMwO4YynrleRNjr+iCwCC+SkDWcf7Pp
   A==;
X-CSE-ConnectionGUID: o8jTK5DMTLOywUdz40Uebg==
X-CSE-MsgGUID: +nqj0MBlT/S6zcYMeR6Mpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42250770"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42250770"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 04:06:47 -0800
X-CSE-ConnectionGUID: twvlSRkKRhmqSqbU0yMTOg==
X-CSE-MsgGUID: oi1X6wwIS/28+ISkReyDMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119476456"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 07 Mar 2025 04:06:45 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqWTS-0000Qp-0N;
	Fri, 07 Mar 2025 12:06:42 +0000
Date: Fri, 7 Mar 2025 20:06:23 +0800
From: kernel test robot <lkp@intel.com>
To: Jorge Marques <jorge.marques@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	David Lechner <dlechner@baylibre.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Jorge Marques <jorge.marques@analog.com>
Subject: Re: [PATCH 4/4] iio: adc: add support for ad4052
Message-ID: <202503071916.STHJTSlp-lkp@intel.com>
References: <20250306-iio-driver-ad4052-v1-4-2badad30116c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-iio-driver-ad4052-v1-4-2badad30116c@analog.com>

Hi Jorge,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aac287ec80d71a7ab7e44c936a434625417c3e30]

url:    https://github.com/intel-lab-lkp/linux/commits/Jorge-Marques/iio-code-mark-iio_dev-as-const-in-iio_buffer_enabled/20250306-220719
base:   aac287ec80d71a7ab7e44c936a434625417c3e30
patch link:    https://lore.kernel.org/r/20250306-iio-driver-ad4052-v1-4-2badad30116c%40analog.com
patch subject: [PATCH 4/4] iio: adc: add support for ad4052
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250307/202503071916.STHJTSlp-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503071916.STHJTSlp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503071916.STHJTSlp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ad4052.c:239:18: warning: 'ad4052_sample_rate_avail' defined but not used [-Wunused-const-variable=]
     239 | static const int ad4052_sample_rate_avail[] = {
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/ad4052.c:214:41: warning: 'ad4052_regmap_wr_table' defined but not used [-Wunused-const-variable=]
     214 | static const struct regmap_access_table ad4052_regmap_wr_table = {
         |                                         ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/ad4052.c:201:41: warning: 'ad4052_regmap_rd_table' defined but not used [-Wunused-const-variable=]
     201 | static const struct regmap_access_table ad4052_regmap_rd_table = {
         |                                         ^~~~~~~~~~~~~~~~~~~~~~


vim +/ad4052_sample_rate_avail +239 drivers/iio/adc/ad4052.c

   200	
 > 201	static const struct regmap_access_table ad4052_regmap_rd_table = {
   202		.yes_ranges = ad4052_regmap_rd_ranges,
   203		.n_yes_ranges = ARRAY_SIZE(ad4052_regmap_rd_ranges),
   204	};
   205	
   206	static const struct regmap_range ad4052_regmap_wr_ranges[] = {
   207		regmap_reg_range(AD4052_REG_INTERFACE_CONFIG_A, AD4052_REG_DEVICE_CONFIG),
   208		regmap_reg_range(AD4052_REG_SCRATCH_PAD, AD4052_REG_SCRATCH_PAD),
   209		regmap_reg_range(AD4052_REG_STREAM_MODE, AD4052_REG_INTERFACE_STATUS),
   210		regmap_reg_range(AD4052_REG_MODE_SET, AD4052_REG_MON_VAL),
   211		regmap_reg_range(AD4052_REG_FUSE_CRC, AD4052_REG_DEVICE_STATUS),
   212	};
   213	
 > 214	static const struct regmap_access_table ad4052_regmap_wr_table = {
   215		.yes_ranges = ad4052_regmap_wr_ranges,
   216		.n_yes_ranges = ARRAY_SIZE(ad4052_regmap_wr_ranges),
   217	};
   218	
   219	static const struct iio_event_spec ad4052_events[] = {
   220		{
   221			.type = IIO_EV_TYPE_THRESH,
   222			.dir = IIO_EV_DIR_EITHER,
   223			.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE)
   224		},
   225		{
   226			.type = IIO_EV_TYPE_THRESH,
   227			.dir = IIO_EV_DIR_RISING,
   228			.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
   229					      BIT(IIO_EV_INFO_HYSTERESIS)
   230		},
   231		{
   232			.type = IIO_EV_TYPE_THRESH,
   233			.dir = IIO_EV_DIR_FALLING,
   234			.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
   235					      BIT(IIO_EV_INFO_HYSTERESIS)
   236		}
   237	};
   238	
 > 239	static const int ad4052_sample_rate_avail[] = {
   240		2000000, 1000000, 300000, 100000, 33300,
   241		10000, 3000, 500, 333, 250, 200,
   242		166, 140, 125, 111
   243	};
   244	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

