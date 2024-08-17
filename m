Return-Path: <linux-iio+bounces-8515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33849554B9
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 03:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0029E1C21B82
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 01:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BFB53BE;
	Sat, 17 Aug 2024 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7z2quYw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EC63211;
	Sat, 17 Aug 2024 01:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723859789; cv=none; b=O79lrS3nqz0nFdYQ1phhB2QhEXcqyi1503Ak3olHWaTijZJJk0R3wjbB9uzV2wp9LznoxHD5hI2f+/YvsYRdsEyO2PLR0qdmO8uIk8Pk4mvEb77+R0JmfsYPNoRiXNKBrLIK4SOm9xpmdhuxTFsoyDTHDL8Nirx7TAX1Qh5V3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723859789; c=relaxed/simple;
	bh=xF4ou8X8ntZ++7VKf4djCVEPiMuqx1unD6WioySVMdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoq7Zfkq7iC8B73NGotQemx/cdjckpIgwDMQSCiIf8P5oYaaIYmE6JKfcTSZW8mxhk4nzPmpiGKnMTSiPD2UJm4hkIjap9LjLLmGK+G2DNjafA3gGYcTxvexduBe2ezeav2gndv4rDdY9BkOFoXOguNN4uYlQPZC/5s4AnorzDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7z2quYw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723859787; x=1755395787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xF4ou8X8ntZ++7VKf4djCVEPiMuqx1unD6WioySVMdc=;
  b=h7z2quYw5LwQecrRa2pYQ4exfJ0P1CEqAGwX5Pr0Uo8gtcRt64ZKBL/f
   f8dzNlK1tlRWYTPUvUw/zfawv3mbPhJgI7qV0RHaZkU5O/zoJ9k52r6Gk
   P5behUrTZhEQVat6EAr3pWnTjc8yJlZw7wrqYCAsTcdwtCUbqP4tUZzrj
   CskBcl313jz/CpsU1BGZU2py5S9gj/f0om6yz1PISYQYLSIlPBaxcnTFm
   zyYu+PTmSj+3ccZgDP/obPx75LN5dm+MFtT1P8T2yT3HCIg3pKd4MEH5p
   2/el0fjs5udeUyWj/Edr6mmovqL2/hHTH/c0A0AF2obc7g9WTB602U4Bm
   w==;
X-CSE-ConnectionGUID: eopToTX3TJact0vu3TYVZw==
X-CSE-MsgGUID: m4elG0I0QGWH1psW2XmEOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="39681435"
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="39681435"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 18:56:26 -0700
X-CSE-ConnectionGUID: sElGVJL6R/apUCQ+fDw9Mw==
X-CSE-MsgGUID: JmNtofhoR/yAIWW2Qdppgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="59473633"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 Aug 2024 18:56:23 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sf8g1-00076c-1C;
	Sat, 17 Aug 2024 01:56:21 +0000
Date: Sat, 17 Aug 2024 09:56:07 +0800
From: kernel test robot <lkp@intel.com>
To: Jianping.Shen@de.bosch.com, jic23@kernel.org, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dima.fedrau@gmail.com, marcelo.schmitt1@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christian.Lorenz3@de.bosch.com,
	Ulrike.Frauendorf@de.bosch.com, Kai.Dolde@de.bosch.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 2/2] iio: imu: smi240: imu driver
Message-ID: <202408170910.aR1gYef3-lkp@intel.com>
References: <20240815152545.7705-3-Jianping.Shen@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815152545.7705-3-Jianping.Shen@de.bosch.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.11-rc3 next-20240816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jianping-Shen-de-bosch-com/dt-bindings-iio-imu-smi240-devicetree-binding/20240815-234739
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240815152545.7705-3-Jianping.Shen%40de.bosch.com
patch subject: [PATCH v3 2/2] iio: imu: smi240: imu driver
config: x86_64-randconfig-123-20240817 (https://download.01.org/0day-ci/archive/20240817/202408170910.aR1gYef3-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240817/202408170910.aR1gYef3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408170910.aR1gYef3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/imu/smi240/smi240_core.c:207:9: sparse: sparse: dereference of noderef expression
>> drivers/iio/imu/smi240/smi240_core.c:207:9: sparse: sparse: dereference of noderef expression
>> drivers/iio/imu/smi240/smi240_core.c:207:9: sparse: sparse: dereference of noderef expression
--
>> drivers/iio/imu/smi240/smi240_spi.c:69:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] request @@     got int @@
   drivers/iio/imu/smi240/smi240_spi.c:69:17: sparse:     expected restricted __be32 [usertype] request
   drivers/iio/imu/smi240/smi240_spi.c:69:17: sparse:     got int
>> drivers/iio/imu/smi240/smi240_spi.c:70:17: sparse: sparse: invalid assignment: |=
   drivers/iio/imu/smi240/smi240_spi.c:70:17: sparse:    left side has type restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:70:17: sparse:    right side has type int
   drivers/iio/imu/smi240/smi240_spi.c:71:17: sparse: sparse: invalid assignment: |=
   drivers/iio/imu/smi240/smi240_spi.c:71:17: sparse:    left side has type restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:71:17: sparse:    right side has type unsigned long
>> drivers/iio/imu/smi240/smi240_spi.c:72:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] data @@     got restricted __be32 [usertype] request @@
   drivers/iio/imu/smi240/smi240_spi.c:72:32: sparse:     expected unsigned int [usertype] data
   drivers/iio/imu/smi240/smi240_spi.c:72:32: sparse:     got restricted __be32 [usertype] request
   drivers/iio/imu/smi240/smi240_spi.c:72:17: sparse: sparse: invalid assignment: |=
   drivers/iio/imu/smi240/smi240_spi.c:72:17: sparse:    left side has type restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:72:17: sparse:    right side has type unsigned char
>> drivers/iio/imu/smi240/smi240_spi.c:73:19: sparse: sparse: cast from restricted __be32
>> drivers/iio/imu/smi240/smi240_spi.c:89:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [addressable] [usertype] response @@     got unsigned int [usertype] @@
   drivers/iio/imu/smi240/smi240_spi.c:89:18: sparse:     expected restricted __be32 [addressable] [usertype] response
   drivers/iio/imu/smi240/smi240_spi.c:89:18: sparse:     got unsigned int [usertype]
>> drivers/iio/imu/smi240/smi240_spi.c:91:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] data @@     got restricted __be32 [addressable] [usertype] response @@
   drivers/iio/imu/smi240/smi240_spi.c:91:42: sparse:     expected unsigned int [usertype] data
   drivers/iio/imu/smi240/smi240_spi.c:91:42: sparse:     got restricted __be32 [addressable] [usertype] response
>> drivers/iio/imu/smi240/smi240_spi.c:94:20: sparse: sparse: cast to restricted __be32
>> drivers/iio/imu/smi240/smi240_spi.c:94:20: sparse: sparse: restricted __be32 degrades to integer
>> drivers/iio/imu/smi240/smi240_spi.c:94:20: sparse: sparse: restricted __be32 degrades to integer
>> drivers/iio/imu/smi240/smi240_spi.c:94:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [addressable] [usertype] response @@     got unsigned long @@
   drivers/iio/imu/smi240/smi240_spi.c:94:18: sparse:     expected restricted __be32 [addressable] [usertype] response
   drivers/iio/imu/smi240/smi240_spi.c:94:18: sparse:     got unsigned long
   drivers/iio/imu/smi240/smi240_spi.c:108:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] request @@     got int @@
   drivers/iio/imu/smi240/smi240_spi.c:108:17: sparse:     expected restricted __be32 [usertype] request
   drivers/iio/imu/smi240/smi240_spi.c:108:17: sparse:     got int
   drivers/iio/imu/smi240/smi240_spi.c:109:17: sparse: sparse: invalid assignment: |=
   drivers/iio/imu/smi240/smi240_spi.c:109:17: sparse:    left side has type restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:109:17: sparse:    right side has type int
   drivers/iio/imu/smi240/smi240_spi.c:110:17: sparse: sparse: invalid assignment: |=
   drivers/iio/imu/smi240/smi240_spi.c:110:17: sparse:    left side has type restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:110:17: sparse:    right side has type unsigned long
   drivers/iio/imu/smi240/smi240_spi.c:111:17: sparse: sparse: invalid assignment: |=
   drivers/iio/imu/smi240/smi240_spi.c:111:17: sparse:    left side has type restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:111:17: sparse:    right side has type unsigned long
   drivers/iio/imu/smi240/smi240_spi.c:112:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] data @@     got restricted __be32 [usertype] request @@
   drivers/iio/imu/smi240/smi240_spi.c:112:32: sparse:     expected unsigned int [usertype] data
   drivers/iio/imu/smi240/smi240_spi.c:112:32: sparse:     got restricted __be32 [usertype] request
   drivers/iio/imu/smi240/smi240_spi.c:112:17: sparse: sparse: invalid assignment: |=
   drivers/iio/imu/smi240/smi240_spi.c:112:17: sparse:    left side has type restricted __be32
   drivers/iio/imu/smi240/smi240_spi.c:112:17: sparse:    right side has type unsigned char
   drivers/iio/imu/smi240/smi240_spi.c:113:19: sparse: sparse: cast from restricted __be32

vim +207 drivers/iio/imu/smi240/smi240_core.c

   197	
   198	static irqreturn_t smi240_trigger_handler(int irq, void *p)
   199	{
   200		struct iio_poll_func *pf = p;
   201		struct iio_dev *indio_dev = pf->indio_dev;
   202		struct smi240_data *data = iio_priv(indio_dev);
   203		int ret, sample, chan, i = 0;
   204	
   205		data->capture = SMI240_CAPTURE_ON;
   206	
 > 207		for_each_set_bit(chan, indio_dev->active_scan_mask,
   208				 indio_dev->masklength) {
   209			ret = regmap_read(data->regmap,
   210					  SMI240_DATA_CAP_FIRST_REG + chan, &sample);
   211			data->capture = SMI240_CAPTURE_OFF;
   212			if (ret)
   213				break;
   214			data->buf[i++] = sample;
   215		}
   216	
   217		if (ret == 0)
   218			iio_push_to_buffers_with_timestamp(indio_dev, data->buf,
   219							   pf->timestamp);
   220	
   221		iio_trigger_notify_done(indio_dev->trig);
   222		return IRQ_HANDLED;
   223	}
   224	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

