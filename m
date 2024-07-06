Return-Path: <linux-iio+bounces-7371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160ED92911F
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 07:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EAE1C2242A
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 05:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0222179BD;
	Sat,  6 Jul 2024 05:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/FXWOz3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BC1847A;
	Sat,  6 Jul 2024 05:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720243054; cv=none; b=thDLesqz4RWpVUASEfdm8LfBy8SqJH95XFlbgyxqZO6oj7jbZgXWKZ1AztSqUA+iKL+6pM2+8D5dbT+z2aAWHlKIKF/++qTukDHgiIcWATQMvOCIlJpFahNN3iLKsmwlskehrKkt3YBnWkrNepyGaffwpE3UyJQZ91yVetBJHB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720243054; c=relaxed/simple;
	bh=RFvdfc5SP26/erCYWy3Bh1P2+7EZnv+hwzsSCZjL4tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9bLVjvlHknfQYtAqH7VPIQjUugJU94r2h/Y8R/dQyxYVFOKVWeiMJ8qwWX39NCjzpyOmqqjvxnT/1blVKicKlbv7xpU+v41/Knu7RvIo8lafE9+CC4ODzUfesm5cZBnvevY1zNgf33ioDXtNIjvMfyCC/W9temgAnNkkTKTQww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/FXWOz3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720243052; x=1751779052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RFvdfc5SP26/erCYWy3Bh1P2+7EZnv+hwzsSCZjL4tM=;
  b=f/FXWOz3aFi+XPpF4fFdjEY1a/SMkoWotMhUJM7p9SXibOLj2AMQ9/CL
   4Q5vbf+erwHjYrKE0wV5aLvgixDt5CRoHHrkYmUkqqxxQHwH/VmTFMBAY
   rQ6jk8kXASaMVUdyp/Rjtsol8cj1yBJ3NJMX4FX5mWE7Nvxbicis8rcvJ
   FAK8qwi+e4of3+mDU7HdDjheDK61t0hAbvYA2wBdEWurrY6HGqH6wS4o7
   LGgumt31TnF2hq3vZz9Fmkem4OP9YnSBoJBPBdm5TrwGZwUZmZv4UhvvK
   RLbz59FLcrtO9u4T8MCx8uHeJKaWFolfd+TLg34BT/Xffk0tir+6PUEtE
   Q==;
X-CSE-ConnectionGUID: D/jfyn4zS3a7AUhv8JA/xw==
X-CSE-MsgGUID: 6/3SWh8xSRCPPDPVcqCNyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28192540"
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="28192540"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 22:17:32 -0700
X-CSE-ConnectionGUID: YVCQsgiNSwWQjpuk1p5tAw==
X-CSE-MsgGUID: CZdNPP4XSZaL+D5Sv3OlhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="51626836"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 05 Jul 2024 22:17:27 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPxnZ-000TLE-11;
	Sat, 06 Jul 2024 05:17:25 +0000
Date: Sat, 6 Jul 2024 13:16:36 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: Re: [PATCH v2 2/3] iio: adc: sophgo-saradc: Add driver for Sophgo
 SARADC
Message-ID: <202407061311.ZEmwMY8m-lkp@intel.com>
References: <20240705-sg2002-adc-v2-2-83428c20a9b2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705-sg2002-adc-v2-2-83428c20a9b2@bootlin.com>

Hi Thomas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d20f6b3d747c36889b7ce75ee369182af3decb6b]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Bonnefille/dt-bindings-iio-adc-sophgo-cv18xx-saradc-yaml-Add-Sophgo-SARADC-binding-documentation/20240706-040736
base:   d20f6b3d747c36889b7ce75ee369182af3decb6b
patch link:    https://lore.kernel.org/r/20240705-sg2002-adc-v2-2-83428c20a9b2%40bootlin.com
patch subject: [PATCH v2 2/3] iio: adc: sophgo-saradc: Add driver for Sophgo SARADC
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240706/202407061311.ZEmwMY8m-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240706/202407061311.ZEmwMY8m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407061311.ZEmwMY8m-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/sophgo-cv18xx-adc.c:85:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
      85 |                 struct cv18xx_adc *saradc = iio_priv(indio_dev);
         |                 ^
   1 warning generated.


vim +85 drivers/iio/adc/sophgo-cv18xx-adc.c

    78	
    79	static int cv18xx_adc_read_raw(struct iio_dev *indio_dev,
    80					  struct iio_chan_spec const *chan,
    81					  int *val, int *val2, long mask)
    82	{
    83		switch (mask) {
    84		case IIO_CHAN_INFO_RAW:
  > 85			struct cv18xx_adc *saradc = iio_priv(indio_dev);
    86			u32 sample;
    87			int ret;
    88	
    89			scoped_guard(mutex, &saradc->lock) {
    90				cv18xx_adc_start_measurement(saradc, chan->scan_index);
    91				ret = cv18xx_adc_wait(saradc);
    92				if (ret < 0)
    93					return ret;
    94	
    95				sample = readl(saradc->regs + CV18XX_ADC_CH_RESULT_REG(chan->scan_index));
    96			}
    97			if (!(sample & CV18XX_ADC_CH_VALID))
    98				return -ENODATA;
    99	
   100			*val = sample & CV18XX_ADC_CH_RESULT;
   101			return IIO_VAL_INT;
   102		case IIO_CHAN_INFO_SCALE:
   103			*val = 3300;
   104			*val2 = 12;
   105			return IIO_VAL_FRACTIONAL_LOG2;
   106		default:
   107			return -EINVAL;
   108		}
   109	}
   110	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

