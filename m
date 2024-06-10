Return-Path: <linux-iio+bounces-6149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642039022B6
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 15:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B5D1C2113F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 13:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DFF839E3;
	Mon, 10 Jun 2024 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhG/k61N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6013883CDE;
	Mon, 10 Jun 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718026188; cv=none; b=dRfkdBJub/ouxSx3AFgjPSgwVR8oEwnPMRmzdVRpibMSwtum5q0YUd6jc0gShBvM2+Co0o7UGgXImrR4WRkCTSW5AnJC9TH2OCS/oayzLoE22CDW3QLBjy9cAGEJoXWE582LJMAeM8Tv2wJGQG5jt64upr4DNGiflEoE+DbuRrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718026188; c=relaxed/simple;
	bh=PcgO3/CLX7JMznu36bb05DGuLfKp26palcGfsljMnik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rY0ZXgs9AyuiRtwKEQAY8cDXqhMA58AeSFQ6S/tdJBGwDLRgfEm6WWCm1VNJVyR4Eatgkv3CXREFsZFMYYzlesGfSWujEHaw4v8B0x79Cp+oM9ZnDQgksWFjbV5k5qSrge02HmRKovMrmg5gh4ELqK3D1MSpar8mDC+u93p5Cv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhG/k61N; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718026188; x=1749562188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PcgO3/CLX7JMznu36bb05DGuLfKp26palcGfsljMnik=;
  b=WhG/k61N3tPOycCFyZ8uiMCzwuBjETmPjw7ju20noo/ulb3LG0GPr4AS
   FOwZ4ttFr060IVCUbLMcVXK5oYV4163zPYCq1/kXsaK0h0a95eV6kk/w2
   s5yEIxzzA8/MAGH0LQrE7biT0HLlMsiIJtsWCUKQExvtdDK7HbK8KsA8S
   ZBrN+uBJ1RR3jooEInblPmVF9M+vHjZmI6cU5ApUFx6DejJsOJazYVQkC
   LBTIPhkVLseJ9doONsNQmL0adbzW57T4wTUS2+4Bzp/mCbEnjG/lYtJIf
   H5d50QqpgnlM5C3i/cPdha/Kkg2VmFTeQTbq7qdknVgU+CfhsHN4ZcsBs
   Q==;
X-CSE-ConnectionGUID: oXbxT8UXS5a2qJoyxEnN2A==
X-CSE-MsgGUID: jnx+79XrT8SgJIgMFxWWog==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="26086709"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="26086709"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 06:29:46 -0700
X-CSE-ConnectionGUID: jKjsSu80QcKYwy8s0zgt5g==
X-CSE-MsgGUID: uWAI+xcGS0WT2wud6btUtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39151398"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 10 Jun 2024 06:29:39 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGf5d-0002AX-1V;
	Mon, 10 Jun 2024 13:29:37 +0000
Date: Mon, 10 Jun 2024 21:28:39 +0800
From: kernel test robot <lkp@intel.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: bu27034: Add a read only HWARDWAREGAIN
Message-ID: <202406102113.7w2Td20S-lkp@intel.com>
References: <5e88c7b7b0389c6c011f15e05e065791f7561cf5.1718013518.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e88c7b7b0389c6c011f15e05e065791f7561cf5.1718013518.git.mazziesaccount@gmail.com>

Hi Matti,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0]

url:    https://github.com/intel-lab-lkp/linux/commits/Matti-Vaittinen/bu27034-ROHM-BU27034NUC-to-BU27034ANUC/20240610-180426
base:   1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
patch link:    https://lore.kernel.org/r/5e88c7b7b0389c6c011f15e05e065791f7561cf5.1718013518.git.mazziesaccount%40gmail.com
patch subject: [PATCH 2/2] iio: bu27034: Add a read only HWARDWAREGAIN
config: i386-buildonly-randconfig-004-20240610 (https://download.01.org/0day-ci/archive/20240610/202406102113.7w2Td20S-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240610/202406102113.7w2Td20S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406102113.7w2Td20S-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/light/rohm-bu27034.c:1057:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
    1057 |         default:
         |         ^
   drivers/iio/light/rohm-bu27034.c:1057:2: note: insert '__attribute__((fallthrough));' to silence this warning
    1057 |         default:
         |         ^
         |         __attribute__((fallthrough)); 
   drivers/iio/light/rohm-bu27034.c:1057:2: note: insert 'break;' to avoid fall-through
    1057 |         default:
         |         ^
         |         break; 
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for REGMAP_SPI
   Depends on [n]: SPI [=n]
   Selected by [y]:
   - AD9739A [=y] && IIO [=y] && (SPI [=n] || COMPILE_TEST [=y])


vim +1057 drivers/iio/light/rohm-bu27034.c

e52afbd61039e2 Matti Vaittinen 2023-03-31  1042  
d47b9b84292706 Matti Vaittinen 2023-06-13  1043  static int bu27034_write_raw_get_fmt(struct iio_dev *indio_dev,
d47b9b84292706 Matti Vaittinen 2023-06-13  1044  				     struct iio_chan_spec const *chan,
d47b9b84292706 Matti Vaittinen 2023-06-13  1045  				     long mask)
d47b9b84292706 Matti Vaittinen 2023-06-13  1046  {
6196c88810e86d Matti Vaittinen 2024-06-10  1047  	struct bu27034_data *data = iio_priv(indio_dev);
d47b9b84292706 Matti Vaittinen 2023-06-13  1048  
d47b9b84292706 Matti Vaittinen 2023-06-13  1049  	switch (mask) {
d47b9b84292706 Matti Vaittinen 2023-06-13  1050  	case IIO_CHAN_INFO_SCALE:
d47b9b84292706 Matti Vaittinen 2023-06-13  1051  		return IIO_VAL_INT_PLUS_NANO;
d47b9b84292706 Matti Vaittinen 2023-06-13  1052  	case IIO_CHAN_INFO_INT_TIME:
d47b9b84292706 Matti Vaittinen 2023-06-13  1053  		return IIO_VAL_INT_PLUS_MICRO;
6196c88810e86d Matti Vaittinen 2024-06-10  1054  	case IIO_CHAN_INFO_HARDWAREGAIN:
6196c88810e86d Matti Vaittinen 2024-06-10  1055  		dev_dbg(data->dev,
6196c88810e86d Matti Vaittinen 2024-06-10  1056  			"HARDWAREGAIN is read-only, use scale to set\n");
d47b9b84292706 Matti Vaittinen 2023-06-13 @1057  	default:
d47b9b84292706 Matti Vaittinen 2023-06-13  1058  		return -EINVAL;
d47b9b84292706 Matti Vaittinen 2023-06-13  1059  	}
d47b9b84292706 Matti Vaittinen 2023-06-13  1060  }
d47b9b84292706 Matti Vaittinen 2023-06-13  1061  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

