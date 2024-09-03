Return-Path: <linux-iio+bounces-9053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40869690F6
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 03:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78D11C228BD
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 01:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422201C68B0;
	Tue,  3 Sep 2024 01:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i9QWmJ2x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED433308A;
	Tue,  3 Sep 2024 01:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725327215; cv=none; b=rzTzBaEXmkd/iKNHZKeTRFTI+1qP5pwrO3oSFx8v6UOo9J8MafgOwFai+cPHsldubWVVHNGleXepwyQow0ve3+m9F0aPcIs2vDPrgFb3kMW9ZTX5brOEkb0REPFLxLa2tekCQQMasB4tA7EbBfCTrFJiyuWfl47QpFtgrVsFnBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725327215; c=relaxed/simple;
	bh=1yxLTU43j5tMCXj+3ugF/3/zN2UgMs9UprUUFdov/tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/4MyGGjZVYHJ5/a0ifoPdwf5EslGFuExk4OWxM67JXM16BgOtUei02m3KGzQKiLcZZBDvCuBmSfJ99XbVbF+MlBCL3/33GvJlRm+mM8cZxxeeNcKeG45+RncbdlaHL+JS9C9brVBwT+i5US82zygNJbC4tDFmPgvUWl61AzagA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i9QWmJ2x; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725327213; x=1756863213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1yxLTU43j5tMCXj+3ugF/3/zN2UgMs9UprUUFdov/tY=;
  b=i9QWmJ2xgQssYZ+tQr/mEgiO+Emlo/lnOlk7PPaRaSOqJcsgfRFl1sua
   6BsdScQZoQOwPL/Az4YjBYB2eBH/dj4uLaVCwYpqtQDwT3WUwcKdar5/Y
   d9kfjc4ry/iJC03M+Qb0QGqK3v96+RPb7obYbluxPEPd9rcVTZtOvvTc1
   mrIs8Kcm3OpVUCp4g30IMVoXEx47Nu32cPtRiVNlAHq2fEBPIqhWCKRpz
   8VRp/4OTjJ3uIRv57nEtduzNONfD7ID393KhqttWRCJ70QJXKQzAK4S+R
   nOyVLhCQ5g8/aiUsGRLHcY7wp5FvtDrvQQw4laF4dlugryq4O1RUvPAyk
   w==;
X-CSE-ConnectionGUID: icDyUbepTkmF2tEQiuxv6Q==
X-CSE-MsgGUID: FItExvk4QUqB/T2NdlYxgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="46425530"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="46425530"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 18:33:33 -0700
X-CSE-ConnectionGUID: 2+sVUTuQRDmsfpU0jLv+Iw==
X-CSE-MsgGUID: nILQxEBNT9Sxz770qNoPjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="64742979"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 02 Sep 2024 18:33:30 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slIQC-00064Y-19;
	Tue, 03 Sep 2024 01:33:28 +0000
Date: Tue, 3 Sep 2024 09:32:55 +0800
From: kernel test robot <lkp@intel.com>
To: Abhash Jha <abhashkumarjha123@gmail.com>, linux-iio@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	songqiang1304521@gmail.com, jic23@kernel.org, lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: proximity: vl53l0x-i2c: Added continuous
 mode support
Message-ID: <202409030909.1CQBnx22-lkp@intel.com>
References: <20240902122557.129013-3-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902122557.129013-3-abhashkumarjha123@gmail.com>

Hi Abhash,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.11-rc6 next-20240902]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhash-Jha/iio-proximity-vl53l0x-i2c-Added-sensor-ID-check/20240902-204936
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240902122557.129013-3-abhashkumarjha123%40gmail.com
patch subject: [PATCH v2 2/2] iio: proximity: vl53l0x-i2c: Added continuous mode support
config: i386-buildonly-randconfig-005-20240903 (https://download.01.org/0day-ci/archive/20240903/202409030909.1CQBnx22-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240903/202409030909.1CQBnx22-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409030909.1CQBnx22-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/proximity/vl53l0x-i2c.c:104:20: error: call to undeclared function 'get_unaligned_be16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     104 |         data->scan.chan = get_unaligned_be16(&buffer[10]);
         |                           ^
   1 error generated.


vim +/get_unaligned_be16 +104 drivers/iio/proximity/vl53l0x-i2c.c

    87	
    88	static irqreturn_t vl53l0x_trigger_handler(int irq, void *priv)
    89	{
    90		struct iio_poll_func *pf = priv;
    91		struct iio_dev *indio_dev = pf->indio_dev;
    92		struct vl53l0x_data *data = iio_priv(indio_dev);
    93		u8 buffer[12];
    94		int ret;
    95	
    96		ret = i2c_smbus_read_i2c_block_data(data->client,
    97						VL_REG_RESULT_RANGE_STATUS,
    98						sizeof(buffer), buffer);
    99		if (ret < 0)
   100			return ret;
   101		else if (ret != 12)
   102			return -EREMOTEIO;
   103	
 > 104		data->scan.chan = get_unaligned_be16(&buffer[10]);
   105		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
   106						iio_get_time_ns(indio_dev));
   107	
   108		iio_trigger_notify_done(indio_dev->trig);
   109		ret = vl53l0x_clear_irq(data);
   110		if (ret < 0)
   111			return ret;
   112	
   113		return IRQ_HANDLED;
   114	}
   115	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

