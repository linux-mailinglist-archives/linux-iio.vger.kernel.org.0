Return-Path: <linux-iio+bounces-8599-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6279D956E45
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 17:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160E6281390
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE03E187879;
	Mon, 19 Aug 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwU7ib2z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2803A176231;
	Mon, 19 Aug 2024 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080074; cv=none; b=fcMCwxNeUs4asWf+uGGyHQTptiTJjjS4sT4iqIF0aRMdkMnA/Omqp4iH2jlGVJK//z3wP/x1+NaZE17+LmdRpBGSHJga6AexsM8FLqJE/VENbY5V+gjbSlPS4yZnBQEwN+pv7yRjO3usG84LyTbtNsnJHJRYU/yrYRHY6Jt5C10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080074; c=relaxed/simple;
	bh=PsSb9lq5VWjaEqxKE/Tf9owkyuT4Q/NptnHcgWMV01M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twOQG3ByfqBU5AEZZexYV15+/KAqwFHGATPu+XLwhA3YjCtttr1+6OGW2XIJKnlTSDJ/bb+wUrePos9pbXaqug6DNgpEZltdaYwCQWJ2EWiVTYWs7JReuFQqgJ+AWQdPsFxmCd/Jr+5b/jWHwSA2hXXtNIFDNel4BYcs+K1oWzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cwU7ib2z; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724080071; x=1755616071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PsSb9lq5VWjaEqxKE/Tf9owkyuT4Q/NptnHcgWMV01M=;
  b=cwU7ib2zd5/pNkZTehwTRUcyKy2nTqYI7HBwlhiSeZnZj6s70aBG5J60
   X3x7bWVHsq+T718bG9+UDCk5+tpAfAGkXlYHbKfMCFcP0cHi9dTVtpHX7
   lQVzh63/0bcAbr09MkbULXrhPLv70Z2bQrVZ3bzWx/HoAxuRs4VPq+yk4
   5NOnsj1kNI4eCkOD4BuPh9i3TlZCJnlCVi2sJM6nJZ758VpR9vnh7gBwl
   wSV+i+5joC37OiBH/NsnYbA0GjCnuBMMUW1J1et3ULoUfh8FH9+OeR19c
   obLvKh9HBaeIADBzi+U41E+aLDRvzDC/DwNF33YxkfOz63pnMuxnzN6sc
   w==;
X-CSE-ConnectionGUID: f2/RYm43TUaw9TySej4oqw==
X-CSE-MsgGUID: Y5cbajTjT3a1v+dcjOTvqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22476578"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="22476578"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 08:07:50 -0700
X-CSE-ConnectionGUID: hCz563YERMGML/DfO+9aZw==
X-CSE-MsgGUID: uh77pYOQSRm/ZFVkuvCdRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="83606348"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 19 Aug 2024 08:07:48 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sg3yz-00096Q-1w;
	Mon, 19 Aug 2024 15:07:45 +0000
Date: Mon, 19 Aug 2024 23:07:19 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandru Ardelean <aardelean@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jic23@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
	michael.hennerich@analog.com, gstols@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: Re: [PATCH 7/7] iio: adc: ad7606: add support for AD7606C-{16,18}
 parts
Message-ID: <202408192209.IrTzVL49-lkp@intel.com>
References: <20240819064721.91494-8-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240819064721.91494-8-aardelean@baylibre.com>

Hi Alexandru,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[cannot apply to linus/master v6.11-rc4 next-20240819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandru-Ardelean/iio-adc-ad7606-add-bits-parameter-to-channels-macros/20240819-145028
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240819064721.91494-8-aardelean%40baylibre.com
patch subject: [PATCH 7/7] iio: adc: ad7606: add support for AD7606C-{16,18} parts
config: i386-buildonly-randconfig-001-20240819 (https://download.01.org/0day-ci/archive/20240819/202408192209.IrTzVL49-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240819/202408192209.IrTzVL49-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408192209.IrTzVL49-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ad7606.c:796:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     796 |         int ret, ch;
         |             ^
   1 warning generated.


vim +/ret +796 drivers/iio/adc/ad7606.c

94168a5789874a Alexandru Ardelean 2024-08-19  790  
94168a5789874a Alexandru Ardelean 2024-08-19  791  static int ad7606_sw_mode_setup(struct iio_dev *indio_dev, unsigned int id)
b5d2c422286d62 Alexandru Ardelean 2024-08-19  792  {
36b63bb57295f7 Alexandru Ardelean 2024-08-19  793  	unsigned int num_channels = indio_dev->num_channels - 1;
b5d2c422286d62 Alexandru Ardelean 2024-08-19  794  	struct ad7606_state *st = iio_priv(indio_dev);
09d11fa081ef17 Alexandru Ardelean 2024-08-19  795  	unsigned int *scale_avail_show, num_scales_avail_show;
09d11fa081ef17 Alexandru Ardelean 2024-08-19 @796  	int ret, ch;
b5d2c422286d62 Alexandru Ardelean 2024-08-19  797  
b5d2c422286d62 Alexandru Ardelean 2024-08-19  798  	if (!st->bops->sw_mode_config)
b5d2c422286d62 Alexandru Ardelean 2024-08-19  799  		return 0;
b5d2c422286d62 Alexandru Ardelean 2024-08-19  800  
b5d2c422286d62 Alexandru Ardelean 2024-08-19  801  	st->sw_mode_en = device_property_present(st->dev, "adi,sw-mode");
b5d2c422286d62 Alexandru Ardelean 2024-08-19  802  	if (!st->sw_mode_en)
b5d2c422286d62 Alexandru Ardelean 2024-08-19  803  		return 0;
b5d2c422286d62 Alexandru Ardelean 2024-08-19  804  
09d11fa081ef17 Alexandru Ardelean 2024-08-19  805  	indio_dev->info = &ad7606_info_sw_mode;
b5d2c422286d62 Alexandru Ardelean 2024-08-19  806  
94168a5789874a Alexandru Ardelean 2024-08-19  807  	switch (id) {
94168a5789874a Alexandru Ardelean 2024-08-19  808  	case ID_AD7606C_18:
94168a5789874a Alexandru Ardelean 2024-08-19  809  		num_scales_avail_show = num_channels;
94168a5789874a Alexandru Ardelean 2024-08-19  810  		ret = ad7606c_sw_mode_setup_channels(indio_dev,
94168a5789874a Alexandru Ardelean 2024-08-19  811  						     ad7606c_18_chan_setup);
94168a5789874a Alexandru Ardelean 2024-08-19  812  		break;
94168a5789874a Alexandru Ardelean 2024-08-19  813  	case ID_AD7606C_16:
94168a5789874a Alexandru Ardelean 2024-08-19  814  		num_scales_avail_show = num_channels;
94168a5789874a Alexandru Ardelean 2024-08-19  815  		ret = ad7606c_sw_mode_setup_channels(indio_dev,
94168a5789874a Alexandru Ardelean 2024-08-19  816  						     ad7606c_16_chan_setup);
94168a5789874a Alexandru Ardelean 2024-08-19  817  		break;
94168a5789874a Alexandru Ardelean 2024-08-19  818  	default:
94168a5789874a Alexandru Ardelean 2024-08-19  819  		num_scales_avail_show = 1;
94168a5789874a Alexandru Ardelean 2024-08-19  820  
b5d2c422286d62 Alexandru Ardelean 2024-08-19  821  		/* Scale of 0.076293 is only available in sw mode */
b5d2c422286d62 Alexandru Ardelean 2024-08-19  822  		/* After reset, in software mode, ±10 V is set by default */
36b63bb57295f7 Alexandru Ardelean 2024-08-19  823  		for (ch = 0; ch < num_channels; ch++) {
36b63bb57295f7 Alexandru Ardelean 2024-08-19  824  			struct ad7606_chan_scale *cs = &st->chan_scales[ch];
36b63bb57295f7 Alexandru Ardelean 2024-08-19  825  
36b63bb57295f7 Alexandru Ardelean 2024-08-19  826  			cs->scale_avail = ad7616_sw_scale_avail;
36b63bb57295f7 Alexandru Ardelean 2024-08-19  827  			cs->num_scales = ARRAY_SIZE(ad7616_sw_scale_avail);
36b63bb57295f7 Alexandru Ardelean 2024-08-19  828  			cs->range = 2;
36b63bb57295f7 Alexandru Ardelean 2024-08-19  829  		}
b5d2c422286d62 Alexandru Ardelean 2024-08-19  830  
09d11fa081ef17 Alexandru Ardelean 2024-08-19  831  		ret = st->bops->sw_mode_config(indio_dev);
94168a5789874a Alexandru Ardelean 2024-08-19  832  		break;
94168a5789874a Alexandru Ardelean 2024-08-19  833  	}
09d11fa081ef17 Alexandru Ardelean 2024-08-19  834  
09d11fa081ef17 Alexandru Ardelean 2024-08-19  835  	for (ch = 0; ch < num_channels; ch++) {
09d11fa081ef17 Alexandru Ardelean 2024-08-19  836  		struct ad7606_chan_scale *cs;
09d11fa081ef17 Alexandru Ardelean 2024-08-19  837  		int i;
09d11fa081ef17 Alexandru Ardelean 2024-08-19  838  
09d11fa081ef17 Alexandru Ardelean 2024-08-19  839  		/* AD7606C supports different scales per channel */
09d11fa081ef17 Alexandru Ardelean 2024-08-19  840  		cs = &st->chan_scales[ch];
09d11fa081ef17 Alexandru Ardelean 2024-08-19  841  
09d11fa081ef17 Alexandru Ardelean 2024-08-19  842  		if (num_scales_avail_show == 1 && ch > 0) {
09d11fa081ef17 Alexandru Ardelean 2024-08-19  843  			cs->scale_avail_show = scale_avail_show;
09d11fa081ef17 Alexandru Ardelean 2024-08-19  844  			continue;
09d11fa081ef17 Alexandru Ardelean 2024-08-19  845  		}
09d11fa081ef17 Alexandru Ardelean 2024-08-19  846  
09d11fa081ef17 Alexandru Ardelean 2024-08-19  847  		scale_avail_show = devm_kcalloc(st->dev, cs->num_scales * 2,
09d11fa081ef17 Alexandru Ardelean 2024-08-19  848  						sizeof(*scale_avail_show),
09d11fa081ef17 Alexandru Ardelean 2024-08-19  849  						GFP_KERNEL);
09d11fa081ef17 Alexandru Ardelean 2024-08-19  850  		if (!scale_avail_show)
09d11fa081ef17 Alexandru Ardelean 2024-08-19  851  			return -ENOMEM;
09d11fa081ef17 Alexandru Ardelean 2024-08-19  852  
09d11fa081ef17 Alexandru Ardelean 2024-08-19  853  		/* Generate a scale_avail list for showing to userspace */
09d11fa081ef17 Alexandru Ardelean 2024-08-19  854  		for (i = 0; i < cs->num_scales; i++) {
09d11fa081ef17 Alexandru Ardelean 2024-08-19  855  			scale_avail_show[i * 2] = 0;
09d11fa081ef17 Alexandru Ardelean 2024-08-19  856  			scale_avail_show[i * 2 + 1] = cs->scale_avail[i];
09d11fa081ef17 Alexandru Ardelean 2024-08-19  857  		}
09d11fa081ef17 Alexandru Ardelean 2024-08-19  858  
09d11fa081ef17 Alexandru Ardelean 2024-08-19  859  		cs->scale_avail_show = scale_avail_show;
09d11fa081ef17 Alexandru Ardelean 2024-08-19  860  	}
09d11fa081ef17 Alexandru Ardelean 2024-08-19  861  
09d11fa081ef17 Alexandru Ardelean 2024-08-19  862  	return 0;
b5d2c422286d62 Alexandru Ardelean 2024-08-19  863  }
b5d2c422286d62 Alexandru Ardelean 2024-08-19  864  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

