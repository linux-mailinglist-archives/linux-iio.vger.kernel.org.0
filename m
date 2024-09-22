Return-Path: <linux-iio+bounces-9695-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D4A97DFE3
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 05:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CBF28160E
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 03:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFD2192B7B;
	Sun, 22 Sep 2024 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lMDbi4AF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A731679CF;
	Sun, 22 Sep 2024 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726975038; cv=none; b=kXthgznpVEXYloUaJE4ZQfvHs1iDuZtdMkaJaDl2bx4gLTXlAmOQBCWB8C+Angahsun5vfcEmHnU1qwfNb+1C67DI3drGh2BvreusXfam4Ga/BUwL3cXFpPUEoVtT8+l+dcXROX6zVdcYO8fvDDxSK//nQ7MdGddsrAG6Bqbi4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726975038; c=relaxed/simple;
	bh=RL7c3BfFavYrTxFcvOsybA+LjAhMOnIVkFh3+k1PszM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6Om2YZw2+B80Ia5zjH6DJnLZzS77RwJgPJ29o81V/7+ixX+9js3FCF49gc5roqeVtSSieDTfFC1MnCEvQZkHDcjjpGIHhX3zhc/V9HQRmNcpRSdNm0k6ONxFNgLpnq50EglYx+/exWHu3YXnw/Nr4X4s47XdCILzdTYInJbqVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lMDbi4AF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726975036; x=1758511036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RL7c3BfFavYrTxFcvOsybA+LjAhMOnIVkFh3+k1PszM=;
  b=lMDbi4AFe15aBd+51lf2us4pRccoVAU1WjwQTczNv3rWJQd1KLxUP0Ry
   Td3/HbkS3ZUrfTE3jxTKCSUjDWnWcz0nLC1jCqaLXx2brg3aIoUtgMKxu
   o1KA/RxgpVX6zeHMcJncBdVj37KaKKVeYApdHT3iFA/FE+rfm5xO+tDiA
   fX8kxSMwlI/y2vsxLtJri9EQ6f9z1cqYSOn+JG3TJYdHrgD7HXp7wwskI
   2VXkIcCaz0yppwWnamjOKs0IgTJztTxeCMW8AMjkkErY+vQg7u/aS31GV
   X6MzGd5MurdtL3Qyk8Vi1bsuOuSjKB/IKaKTtNNc/k9IH+xejyFIK3cFx
   A==;
X-CSE-ConnectionGUID: jUi8Aa/5RMySn3Wx+jpMmw==
X-CSE-MsgGUID: 3mbOhBUsS7uD1esqX+LXdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="36607713"
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="36607713"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 20:17:15 -0700
X-CSE-ConnectionGUID: buI2J/1lQNGrFoyZVHq/jA==
X-CSE-MsgGUID: tqxEPCMrTsqDIvgIoUsH0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,248,1719903600"; 
   d="scan'208";a="94042832"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 21 Sep 2024 20:17:13 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssD5z-000FzQ-0B;
	Sun, 22 Sep 2024 03:17:11 +0000
Date: Sun, 22 Sep 2024 11:17:02 +0800
From: kernel test robot <lkp@intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, mazziesaccount@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: Re: [PATCH v1 1/2] iio: Drop usage of iio_validate_own_trigger()
Message-ID: <202409221122.4BTAc5w1-lkp@intel.com>
References: <20240921181939.392517-2-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240921181939.392517-2-vassilisamir@gmail.com>

Hi Vasileios,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8bea3878a1511bceadc2fbf284b00bcc5a2ef28d]

url:    https://github.com/intel-lab-lkp/linux/commits/Vasileios-Amoiridis/iio-Drop-usage-of-iio_validate_own_trigger/20240922-022124
base:   8bea3878a1511bceadc2fbf284b00bcc5a2ef28d
patch link:    https://lore.kernel.org/r/20240921181939.392517-2-vassilisamir%40gmail.com
patch subject: [PATCH v1 1/2] iio: Drop usage of iio_validate_own_trigger()
config: x86_64-buildonly-randconfig-002-20240922 (https://download.01.org/0day-ci/archive/20240922/202409221122.4BTAc5w1-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240922/202409221122.4BTAc5w1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409221122.4BTAc5w1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/accel/kionix-kx022a.c:876:22: error: incompatible function pointer types initializing 'int (*)(struct iio_dev *, struct iio_trigger *)' with an expression of type 'int (struct iio_trigger *, struct iio_dev *)' [-Wincompatible-function-pointer-types]
     876 |         .validate_trigger       = iio_trigger_validate_own_device,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
--
>> drivers/iio/light/rohm-bu27008.c:1389:22: error: incompatible function pointer types initializing 'int (*)(struct iio_dev *, struct iio_trigger *)' with an expression of type 'int (struct iio_trigger *, struct iio_dev *)' [-Wincompatible-function-pointer-types]
    1389 |         .validate_trigger = iio_trigger_validate_own_device,
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +876 drivers/iio/accel/kionix-kx022a.c

   869	
   870	static const struct iio_info kx022a_info = {
   871		.read_raw = &kx022a_read_raw,
   872		.write_raw = &kx022a_write_raw,
   873		.write_raw_get_fmt = &kx022a_write_raw_get_fmt,
   874		.read_avail = &kx022a_read_avail,
   875	
 > 876		.validate_trigger	= iio_trigger_validate_own_device,
   877		.hwfifo_set_watermark	= kx022a_set_watermark,
   878		.hwfifo_flush_to_buffer	= kx022a_fifo_flush,
   879	};
   880	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

