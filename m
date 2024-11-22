Return-Path: <linux-iio+bounces-12492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219AD9D611A
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 16:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879822824A8
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 15:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A4B152517;
	Fri, 22 Nov 2024 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZot2vJs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2DC12CD88;
	Fri, 22 Nov 2024 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288247; cv=none; b=DFg5A6anZumYwyEsl26Y3F3u95vT+1DyeyMxoFB/r5AZJ/2YqFL8q6G2rRpceDzqYaXJKPy6qhwmUftSXg/lMTqXPazlaPXJ+JKcppxIpkVE11UjvF5jmAr75/aW64uhhQhhwtULtRL/ZEcwjIa+LDT97pKGTd1R7EDwHabiwIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288247; c=relaxed/simple;
	bh=O8W8V2v3ggSNRbf/WtoNsYdZzZHeFWKhWoWdKWTGSXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ax6yFyr0V5CsBbfiraeCuU/n3zAbOoSxNXFQ6CLvEEy/4iB3/Xpq0ETStqQ1JOaMWhrETYNdnX1XUU5ZQJivQ++IVKg3npwTuw8EuFVkMAoZktz3uLBXlyIlh2TEgv463NBnTGhVJ+HMMnc1GOmbby6gXh5U+gSUgdveurJpyYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZot2vJs; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732288245; x=1763824245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O8W8V2v3ggSNRbf/WtoNsYdZzZHeFWKhWoWdKWTGSXM=;
  b=QZot2vJs4lCCR5vKJV2Hn+waowr3Pj6cpy8IXNapPHOCLsyFXxRh80w4
   u+xyL0QYu1aOS3ajNlA0G4xwE6wMz4PCGYEKMWBCdGslJ6gco7FjcVo4b
   fJmdyw04ZXvJk9kAP4n0CttPSok03Ns/Wg2UVp56el1/iMN2/mpnQBmDL
   i8m9qmdt+3nPD4fygJg1amlv5iFM7mAN8bFpAYRywY4fvV6dxFA+k+BlW
   2qeXw+1MolrLfKp+np4maLnZiG8Kie6Gp44Vw+LxbpAE5HfjJGYCSiMU8
   4qN62zdZNyQLZxCptEm9XLt+KLfr1wMSNpu99WkduTaXNXOYbtdbnY1gw
   g==;
X-CSE-ConnectionGUID: wgL+AVNbQAy+dPjevW6fsQ==
X-CSE-MsgGUID: /otq5vtRSV2GI2DmmT9BRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="49963259"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="49963259"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 07:10:44 -0800
X-CSE-ConnectionGUID: SJBTruWmRNS5ScurZDldnw==
X-CSE-MsgGUID: K2W/b0a/RQ+8fyEru8EmRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="121551606"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 22 Nov 2024 07:10:40 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEVIs-00040Z-0f;
	Fri, 22 Nov 2024 15:10:38 +0000
Date: Fri, 22 Nov 2024 23:09:40 +0800
From: kernel test robot <lkp@intel.com>
To: Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
Message-ID: <202411222244.oAiveIHV-lkp@intel.com>
References: <20241119-apds9160-driver-v1-2-fa00675b4ea4@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119-apds9160-driver-v1-2-fa00675b4ea4@dimonoff.com>

Hi Mikael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on adc218676eef25575469234709c2d87185ca223a]

url:    https://github.com/intel-lab-lkp/linux/commits/Mikael-Gonella-Bolduc-via-B4-Relay/dt-bindings-iio-light-Add-APDS9160-binding/20241121-123509
base:   adc218676eef25575469234709c2d87185ca223a
patch link:    https://lore.kernel.org/r/20241119-apds9160-driver-v1-2-fa00675b4ea4%40dimonoff.com
patch subject: [PATCH 2/2] iio: light: Add APDS9160 ALS & Proximity sensor driver
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20241122/202411222244.oAiveIHV-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411222244.oAiveIHV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411222244.oAiveIHV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/light/apds9160.c:3: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This file is part of the APDS9160 sensor driver.
>> drivers/iio/light/apds9160.c:565: warning: Function parameter or struct member 'data' not described in 'apds9160_set_ps_cancellation_level'
>> drivers/iio/light/apds9160.c:565: warning: Function parameter or struct member 'val' not described in 'apds9160_set_ps_cancellation_level'
>> drivers/iio/light/apds9160.c:565: warning: expecting prototype for The PS intelligent cancellation level register allows for an on(). Prototype was for apds9160_set_ps_cancellation_level() instead
   drivers/iio/light/apds9160.c:585: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * This parameter determines the cancellation pulse duration in each of the PWM pulse.
   drivers/iio/light/apds9160.c:609: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Set the proximity sensor led current


vim +3 drivers/iio/light/apds9160.c

   > 3	 * This file is part of the APDS9160 sensor driver.
     4	 * Chip is combined proximity and ambient light sensor.
     5	 * Author: Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>
     6	 */
     7	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

