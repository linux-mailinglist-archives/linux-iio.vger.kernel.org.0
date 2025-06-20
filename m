Return-Path: <linux-iio+bounces-20789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E71AE1129
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jun 2025 04:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9191619E2C64
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jun 2025 02:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F651B81DC;
	Fri, 20 Jun 2025 02:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjsweRWm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A160D1AD3E0;
	Fri, 20 Jun 2025 02:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750387162; cv=none; b=c/RgNmflDzoMW+iF27E8dwa4jAKd3KrhKzGCnRJOzQ8OqiK6ug4QFzkaoRkwESVwi2KmprDLblpOlbiFR4bXxolnxi5BqFl/pqwNUCTSTbJbOPzE0Mf4HCI87990bkW32ePPFdF/ut4OH7OW/bn4fkgPxiMlp0ZxPrs5xyAqgjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750387162; c=relaxed/simple;
	bh=3drL4oHsjY/dEdUwunUtmzdGsZY1x4KQYqNZRtpHoVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaNCNP8wdCwzcdh6XJZ7wlKp8QY62uif2zK8w2eI8HPxTooviyj7If3qWdl72b5nOwfGlsRcLZtuMVPK0bPsYLi2JiqNhPvdB3ZMmf6otiW1WAwrOKjjnVD5y6PshcSIX671FMoCJJjqIDmCEx3Zl22eF9kA9maV2AG9479rFfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjsweRWm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750387160; x=1781923160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3drL4oHsjY/dEdUwunUtmzdGsZY1x4KQYqNZRtpHoVg=;
  b=hjsweRWmDD1S9Ueu0CI5EUhE98IQqTLiBrHC1/A8edOjMQ0/zKm3kaLP
   bOPxqZt4j4hnK1wjtaALXkhTPiIsMlIfY++/5bGxaAhKIB86ZkpqxiRM0
   iFH95vFE32C2+lvNvlg9DWvjeX+cBEo1NaaORDIcw8Xo50u8zcJ8rIa6G
   Xekm4jkW3VckZ5meFmOFweNLfBXCxdtYQBC0XKaSrhhM0yk82pewVTJtw
   BZzucNLrCCUEOao7CMXT6BouUl7jEnrgHOGnYltatkzAnQUd38AjNUbb+
   fB2/myQT7yD+oY2x0t9SCDM7PNS6EUaAxGqBiX9Nn65qgS1XngNhlU43Y
   Q==;
X-CSE-ConnectionGUID: QHJDS2meRR2d+7qwfTyiwg==
X-CSE-MsgGUID: AHZuD7ExR9i0yWOnuXdj0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52724083"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="52724083"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 19:39:19 -0700
X-CSE-ConnectionGUID: aBfS2HT9QGyt9Ikt559Z1g==
X-CSE-MsgGUID: yo3FoJHNQ0aGo0Aoeyp8NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="181810233"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 19 Jun 2025 19:39:15 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSRer-000LJ4-0S;
	Fri, 20 Jun 2025 02:39:13 +0000
Date: Fri, 20 Jun 2025 10:38:58 +0800
From: kernel test robot <lkp@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jic23@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, broonie@kernel.org, lgirdwood@gmail.com,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v6 06/12] iio: adc: ad4170: Add digital filter and sample
 frequency config support
Message-ID: <202506201000.WjqDvyXl-lkp@intel.com>
References: <bc0261373936511a6ae5b25082e36ac5f112f6db.1750258776.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc0261373936511a6ae5b25082e36ac5f112f6db.1750258776.git.marcelo.schmitt@analog.com>

Hi Marcelo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4c6073fec2fee4827fa0dd8a4ab4e6f7bbc05ee6]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Schmitt/dt-bindings-iio-adc-Add-AD4170/20250619-014200
base:   4c6073fec2fee4827fa0dd8a4ab4e6f7bbc05ee6
patch link:    https://lore.kernel.org/r/bc0261373936511a6ae5b25082e36ac5f112f6db.1750258776.git.marcelo.schmitt%40analog.com
patch subject: [PATCH v6 06/12] iio: adc: ad4170: Add digital filter and sample frequency config support
config: microblaze-randconfig-r133-20250620 (https://download.01.org/0day-ci/archive/20250620/202506201000.WjqDvyXl-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250620/202506201000.WjqDvyXl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506201000.WjqDvyXl-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/adc/ad4170.c: In function 'ad4170_read_avail':
>> drivers/iio/adc/ad4170.c:1237:18: warning: array subscript 4294967274 is above array bounds of 'int[3][18][2]' [-Warray-bounds]
      *vals = (int *)st->sps_tbl[f_type];
                     ^~


vim +1237 drivers/iio/adc/ad4170.c

  1219	
  1220	static int ad4170_read_avail(struct iio_dev *indio_dev,
  1221				     struct iio_chan_spec const *chan,
  1222				     const int **vals, int *type, int *length,
  1223				     long info)
  1224	{
  1225		struct ad4170_state *st = iio_priv(indio_dev);
  1226		struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
  1227		enum ad4170_filter_type f_type;
  1228	
  1229		switch (info) {
  1230		case IIO_CHAN_INFO_SCALE:
  1231			*vals = (int *)chan_info->scale_tbl;
  1232			*length = ARRAY_SIZE(chan_info->scale_tbl) * 2;
  1233			*type = IIO_VAL_INT_PLUS_NANO;
  1234			return IIO_AVAIL_LIST;
  1235		case IIO_CHAN_INFO_SAMP_FREQ:
  1236			f_type = ad4170_get_filter_type(indio_dev, chan);
> 1237			*vals = (int *)st->sps_tbl[f_type];
  1238			*type = IIO_VAL_INT_PLUS_MICRO;
  1239			switch (f_type) {
  1240			case AD4170_SINC5_AVG:
  1241			case AD4170_SINC3:
  1242				*length = ARRAY_SIZE(ad4170_sinc3_filt_fs_tbl) * 2;
  1243				return IIO_AVAIL_LIST;
  1244			case AD4170_SINC5:
  1245				*length = ARRAY_SIZE(ad4170_sinc5_filt_fs_tbl) * 2;
  1246				return IIO_AVAIL_LIST;
  1247			default:
  1248				return -EINVAL;
  1249			}
  1250		default:
  1251			return -EINVAL;
  1252		}
  1253	}
  1254	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

