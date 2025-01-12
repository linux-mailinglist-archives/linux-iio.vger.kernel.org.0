Return-Path: <linux-iio+bounces-14155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5807DA0A72E
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 05:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9B1166AFD
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 04:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6B84B5AE;
	Sun, 12 Jan 2025 04:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/iSl+FC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D2EEC3;
	Sun, 12 Jan 2025 04:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736655649; cv=none; b=f6dMkHYIaRu3rdChA/WFkOEX/AznRtAGHRV9dQQbQBaGx5v9oYPd5FpQsHinlB3rxxXom0hSDFYL37sf56en6H73xcmMiM/ACnBZ+VNIkzETgaHLjgH1trZpUj1GS6SK/V0UOYI5Q9kKNsTTvZA59IotVWBGR1lqluxfX7dD79U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736655649; c=relaxed/simple;
	bh=PsXlJXwMTiylzvvaJJ5glc9HgqWL/RFU5UJO4hTG0I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+hanZJ/3/9wUHqW2SrOpAdvNz0hpOd7CIH2JJa5kFK4lLsLzFejwOebAtR6HHnpB2vRcXqXXz2N9Odw4VYxRsnhED4c0pSQy/J/H7JAcZea5i4ceMj+jAkg7xIMcESa45DztO8hhNKUdlvPlgeYyS9Jm56bS0JE5cYQSVZi6Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/iSl+FC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736655647; x=1768191647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PsXlJXwMTiylzvvaJJ5glc9HgqWL/RFU5UJO4hTG0I4=;
  b=W/iSl+FCGSvkbuBLpylBsifZM/KHSLgNcojawXWjlQjbntpZAOre1GNE
   pk6Z/HTYi/4WmOWtaZVaXMxZ+kAeZaGLruonkHogx1YkaiQ5+N1RsvSN0
   7YiEIJ7A6SAnzmgeus6v0Ggvqb2TAZk7IGOxhc855zsnnzrriGpYbp/8o
   D7SSDDj2wD5dqDRdMxtRZRxD70kdoRfpLgj7wjaJBR0C5gXCUDAQqKYA7
   gstxkSHAMViR6wu4lZ++Flcgz8V0pTvgBNwz7+uH5/+iFALynssNwHkWK
   StQ1zHSe/NRLWi8Amo+Xumu5gPArTA+YhffNCJkfIj9a6HJcH0qiXtWCU
   w==;
X-CSE-ConnectionGUID: d5pXEnbgSMaWzxCJBHPx6Q==
X-CSE-MsgGUID: G7SeGpWSRZmSbgFEJNiP4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11312"; a="40848698"
X-IronPort-AV: E=Sophos;i="6.12,308,1728975600"; 
   d="scan'208";a="40848698"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 20:20:47 -0800
X-CSE-ConnectionGUID: sn4n80bVT1u2NrlKa7XqSw==
X-CSE-MsgGUID: zbElPrt2SViwkc8TIZ7Q5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,308,1728975600"; 
   d="scan'208";a="103908282"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Jan 2025 20:20:43 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWpSr-000LZH-1C;
	Sun, 12 Jan 2025 04:20:41 +0000
Date: Sun, 12 Jan 2025 12:20:17 +0800
From: kernel test robot <lkp@intel.com>
To: Robert Budai <robert.budai@analog.com>, Nuno Sa <nuno.sa@analog.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Lanzano <lanzano.alex@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4 5/6] iio: imu: adis16550: add adis16550 support
Message-ID: <202501121221.84e3uKFl-lkp@intel.com>
References: <20250110074254.38966-6-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110074254.38966-6-robert.budai@analog.com>

Hi Robert,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.13-rc6 next-20250110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Robert-Budai/iio-imu-adis-Add-custom-ops-struct/20250110-154645
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250110074254.38966-6-robert.budai%40analog.com
patch subject: [PATCH v4 5/6] iio: imu: adis16550: add adis16550 support
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20250112/202501121221.84e3uKFl-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250112/202501121221.84e3uKFl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501121221.84e3uKFl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/imu/adis16550.c:1202:18: error: expected ';' after top level declarator
    1202 | MODULE_IMPORT_NS(IIO_ADISLIB);
         |                  ^
   1 error generated.


vim +1202 drivers/iio/imu/adis16550.c

  1196	
  1197	MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
  1198	MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
  1199	MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
  1200	MODULE_DESCRIPTION("Analog Devices ADIS16550 IMU driver");
  1201	MODULE_LICENSE("GPL");
> 1202	MODULE_IMPORT_NS(IIO_ADISLIB);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

