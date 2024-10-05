Return-Path: <linux-iio+bounces-10171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 427DE9916B8
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 14:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A271F22C80
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 12:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD63D14C59C;
	Sat,  5 Oct 2024 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xp8EAr3J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A14F9FE;
	Sat,  5 Oct 2024 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728131173; cv=none; b=bQjF6vu47rfTKwqOSXIvXauaaELMVeiVf66BOiqlAUqbwMFL2pmxPvtM36o9ATqy0To6Lr2bKwfVw+XPeSrJpemA8YhO06iBygEUfvPSL9R742bJLVgLeodV85M19v5C0eAgceRABTqIqRhfqedoVou0VJM0Be3WzlA0BWk+RA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728131173; c=relaxed/simple;
	bh=6GIqY6CJQg3RPRjrP6UrBpE7qq2Sehs4/nWlgRKMf2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXSO0KrDSsftooHE11YMVdJ28+4tlGxAdHg4mcuYf0rH1ZTaBiJOV/IWnPpbWBj+5FCVVTjQYAczHph2hT5Xrw+uKOYBo8ZmXHHDEFSQPsLXSgfFGT1SpxqtV96Tw3UJz2DlKjRa/dYOEEdWaxFDESEtgjcn0aBraNkpQXnD5Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xp8EAr3J; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728131170; x=1759667170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6GIqY6CJQg3RPRjrP6UrBpE7qq2Sehs4/nWlgRKMf2g=;
  b=Xp8EAr3JWbrNVxTXy6c3DKRQnjMjqrHsmdrSxdGcwTD/5BefJDulBSIE
   pxdGobj2sR8ncHaTMFNZ00nLSSfzddQzp4gan8QslVUSgyd0uFSOtnlKY
   i65A2RgtRqdocuG8vy6Akl9bxvvL5P4w5I/7rQSMdC/T78jN9aZonhoNm
   tiAapTxpJ7l8QSuvidj7LT4SPeyrvLXR3XuVjwASp0ZPBwfnMBTDvhBJh
   YYWj26zyb/2H9frAdcPGaahohoixf7UIPon7JVBxy4McK5pTgI5bTKXBq
   Ve6Qf02AGFD+WbiYrsQXKdDIxSQ/aEw1dysNFY1pF63rwpTLxGCpl5IoU
   w==;
X-CSE-ConnectionGUID: fsDFe3BRT0K7yeOoWwQS6A==
X-CSE-MsgGUID: M+UwW+sCTKuelbZMLlwRiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27429815"
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="27429815"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 05:26:10 -0700
X-CSE-ConnectionGUID: 3NvcS1eITOiu70+1nsM8GA==
X-CSE-MsgGUID: cBrdKi0USOqnqW3xtZZo/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="98279560"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 05 Oct 2024 05:26:08 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sx3rJ-0002va-2p;
	Sat, 05 Oct 2024 12:26:05 +0000
Date: Sat, 5 Oct 2024 20:25:59 +0800
From: kernel test robot <lkp@intel.com>
To: Abhash Jha <abhashkumarjha123@gmail.com>, linux-iio@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jic23@kernel.org,
	lars@metafoo.de, linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: Re: [PATCH 1/3] iio: light: vl6180: Add configurable
 inter-measurement period support
Message-ID: <202410052012.iy9nXdU8-lkp@intel.com>
References: <20241004150148.14033-2-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004150148.14033-2-abhashkumarjha123@gmail.com>

Hi Abhash,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.12-rc1 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhash-Jha/iio-light-vl6180-Add-configurable-inter-measurement-period-support/20241004-230433
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20241004150148.14033-2-abhashkumarjha123%40gmail.com
patch subject: [PATCH 1/3] iio: light: vl6180: Add configurable inter-measurement period support
config: x86_64-buildonly-randconfig-001-20241005 (https://download.01.org/0day-ci/archive/20241005/202410052012.iy9nXdU8-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410052012.iy9nXdU8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410052012.iy9nXdU8-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/iio/light/vl6180.c:461:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     461 |                 guard(mutex)(&data->lock);
         |                 ^
   include/linux/cleanup.h:167:2: note: expanded from macro 'guard'
     167 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:122:2: note: expanded from macro 'CLASS'
     122 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |         ^
   <scratch space>:101:1: note: expanded from here
     101 | class_mutex_t
         | ^
>> drivers/iio/light/vl6180.c:477:2: error: cannot jump from switch statement to this case label
     477 |         default:
         |         ^
   drivers/iio/light/vl6180.c:461:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     461 |                 guard(mutex)(&data->lock);
         |                 ^
   include/linux/cleanup.h:167:15: note: expanded from macro 'guard'
     167 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:189:29: note: expanded from macro '__UNIQUE_ID'
     189 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:99:1: note: expanded from here
      99 | __UNIQUE_ID_guard385
         | ^
   1 warning and 1 error generated.


vim +477 drivers/iio/light/vl6180.c

006f437eee8f94 Abhash Jha            2024-10-04  442  
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19  443  static int vl6180_write_raw(struct iio_dev *indio_dev,
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19  444  			     struct iio_chan_spec const *chan,
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19  445  			     int val, int val2, long mask)
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19  446  {
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19  447  	struct vl6180_data *data = iio_priv(indio_dev);
006f437eee8f94 Abhash Jha            2024-10-04  448  	unsigned int reg_val;
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19  449  
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19  450  	switch (mask) {
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19  451  	case IIO_CHAN_INFO_INT_TIME:
1e2ed3d0d27d80 Stefan Brüns          2017-09-24  452  		return vl6180_set_it(data, val, val2);
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19  453  
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19  454  	case IIO_CHAN_INFO_HARDWAREGAIN:
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19  455  		if (chan->type != IIO_LIGHT)
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19  456  			return -EINVAL;
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19  457  
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19  458  		return vl6180_set_als_gain(data, val, val2);
006f437eee8f94 Abhash Jha            2024-10-04  459  
006f437eee8f94 Abhash Jha            2024-10-04  460  	case IIO_CHAN_INFO_SAMP_FREQ:
006f437eee8f94 Abhash Jha            2024-10-04 @461  		guard(mutex)(&data->lock);
006f437eee8f94 Abhash Jha            2024-10-04  462  		switch (chan->type) {
006f437eee8f94 Abhash Jha            2024-10-04  463  		case IIO_DISTANCE:
006f437eee8f94 Abhash Jha            2024-10-04  464  			data->range_meas_rate = val;
006f437eee8f94 Abhash Jha            2024-10-04  465  			reg_val = vl6180_meas_reg_val_from_ms(val);
006f437eee8f94 Abhash Jha            2024-10-04  466  			return vl6180_write_byte(data->client, VL6180_RANGE_INTER_MEAS_TIME, reg_val);
006f437eee8f94 Abhash Jha            2024-10-04  467  
006f437eee8f94 Abhash Jha            2024-10-04  468  		case IIO_LIGHT:
006f437eee8f94 Abhash Jha            2024-10-04  469  			data->als_meas_rate = val;
006f437eee8f94 Abhash Jha            2024-10-04  470  			reg_val = vl6180_meas_reg_val_from_ms(val);
006f437eee8f94 Abhash Jha            2024-10-04  471  			return vl6180_write_byte(data->client, VL6180_ALS_INTER_MEAS_TIME, reg_val);
006f437eee8f94 Abhash Jha            2024-10-04  472  
006f437eee8f94 Abhash Jha            2024-10-04  473  		default:
006f437eee8f94 Abhash Jha            2024-10-04  474  			return -EINVAL;
006f437eee8f94 Abhash Jha            2024-10-04  475  		}
006f437eee8f94 Abhash Jha            2024-10-04  476  
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19 @477  	default:
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19  478  		return -EINVAL;
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19  479  	}
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19  480  }
5e7f47e495ad36 Manivannan Sadhasivam 2017-03-19  481  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

