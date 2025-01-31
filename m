Return-Path: <linux-iio+bounces-14746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEDCA23969
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 06:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6B33A2E4A
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 05:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3B418C31;
	Fri, 31 Jan 2025 05:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jio8Oefr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59013BC02;
	Fri, 31 Jan 2025 05:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738302085; cv=none; b=TxCSElyLx8hkY7xhOod0XYPtdeQeNZYFs9nkZwDKcHWkjuzaQmatftADBA7qpwRMZ+kXqrV25XB9HstTSgOrT+307yL5V+dSH6EliQWWwqhRqAWHur5zMKkQh8blaDKxonc8OKK5Xt2Y+H8EdCPNwgf280Jeez9okrcBnnEHmJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738302085; c=relaxed/simple;
	bh=qXMcWjH+3cpit/FfKPh/jnxx5BYQTfRj2UQPGxwTDFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHzTorsDjm7QiqyQlYHxI/ePcgkpTZ3DwgkzQQ2xsMJqHYbLlc1CTerT9dp+vrMxTf1JXc9Jf1RbXAp/j6A6Xkm3Lnxu+kGPcVrD9LaMcJDuCQMb5KvGJLAOLrVJDn0SrASOboIzs+hb8h0+aG8bViSiJBmeItfIdJj9RPv8TUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jio8Oefr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738302085; x=1769838085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qXMcWjH+3cpit/FfKPh/jnxx5BYQTfRj2UQPGxwTDFI=;
  b=Jio8OefrApODqX0GHz6bf9xckFEDoP+j20F3hfXTWu2dzF+wCCX1Rhgc
   b9wzW6EZB6XmT1WHx5yAAeZGMljNyo7VmfFkZ8CgaphTG2gH88yFLnNUV
   yyzHdtYr2zOksAEPwGbIYxH0gmm6ZXj8pQWoxVoBoS4IG9154qWXqhYSc
   J5X27oVMIT4XJcHIl5iBimEsJOvhe69q27nAUe8LW9vtwSqsbX8YgR+Nr
   yVRnpe0plo0MBtYaeTzZXppOER62mHhjOwJP4AwcCiUywJmqDNcgZQpl/
   E6tUWEzz/7xKPl7hcnJHfNwZ4olOjRRxlDcA+d2m/YABGQ0AyHzlAw/sa
   g==;
X-CSE-ConnectionGUID: +lP1ChXhQ9mlVi1jEpN7RQ==
X-CSE-MsgGUID: 2Hu1ER+vRwaU1gNmTEBGJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="38109179"
X-IronPort-AV: E=Sophos;i="6.13,247,1732608000"; 
   d="scan'208";a="38109179"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 21:41:24 -0800
X-CSE-ConnectionGUID: +32zaFenQSiHjb7F2YrE7Q==
X-CSE-MsgGUID: xZlVOI4TSwyvaVkcgVjStA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="146721630"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 30 Jan 2025 21:41:19 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tdjmH-000m2N-20;
	Fri, 31 Jan 2025 05:41:17 +0000
Date: Fri, 31 Jan 2025 13:40:43 +0800
From: kernel test robot <lkp@intel.com>
To: Esteban Blanc <eblanc@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Esteban Blanc <eblanc@baylibre.com>
Subject: Re: [PATCH v3 2/6] iio: adc: ad4030: add driver for ad4030-24
Message-ID: <202501311345.Oh77Bhyw-lkp@intel.com>
References: <20250130-eblanc-ad4630_v1-v3-2-052e8c2d897d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130-eblanc-ad4630_v1-v3-2-052e8c2d897d@baylibre.com>

Hi Esteban,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ffd294d346d185b70e28b1a28abe367bbfe53c04]

url:    https://github.com/intel-lab-lkp/linux/commits/Esteban-Blanc/dt-bindings-iio-adc-add-ADI-ad4030-ad4630-and-ad4632/20250130-191153
base:   ffd294d346d185b70e28b1a28abe367bbfe53c04
patch link:    https://lore.kernel.org/r/20250130-eblanc-ad4630_v1-v3-2-052e8c2d897d%40baylibre.com
patch subject: [PATCH v3 2/6] iio: adc: ad4030: add driver for ad4030-24
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250131/202501311345.Oh77Bhyw-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250131/202501311345.Oh77Bhyw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501311345.Oh77Bhyw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/adc/ad4030.c: In function 'ad4030_buffer_preenable':
>> drivers/iio/adc/ad4030.c:715:30: warning: unused variable 'st' [-Wunused-variable]
     715 |         struct ad4030_state *st = iio_priv(indio_dev);
         |                              ^~


vim +/st +715 drivers/iio/adc/ad4030.c

   712	
   713	static int ad4030_buffer_preenable(struct iio_dev *indio_dev)
   714	{
 > 715		struct ad4030_state *st = iio_priv(indio_dev);
   716		int ret;
   717	
   718		ret = ad4030_set_mode(indio_dev, *indio_dev->active_scan_mask);
   719		if (ret)
   720			return ret;
   721	
   722		return 0;
   723	}
   724	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

