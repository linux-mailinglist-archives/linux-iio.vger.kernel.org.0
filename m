Return-Path: <linux-iio+bounces-13085-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DE59E3927
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 12:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6816B282E8A
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 11:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E691B4F2B;
	Wed,  4 Dec 2024 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iflUeQfy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAFC1B3952;
	Wed,  4 Dec 2024 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312694; cv=none; b=bxdvbcSUE+GXrr3B435vlM1Q7jtNKkVNlfNZumXIz14e8AkfwWhsUM4+i0oZl5AD+IQv2asAUAMu3xug6kr+k4uUO5PtSEbltsKXnL/NDN3nrD7xxOV+z5z3Phh+C7DdNHILslmnBHKTNHfUelyMRrVnWxpMg0NVpg6dbbOXOdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312694; c=relaxed/simple;
	bh=pHwngGRAb/vPrnt8FnpBqAiQofRnngsM9ULIkXyMQ/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8UWDJ8c0axB6caT38oGVUkmFuPYh6o3BA30ZpRcHDKgOewwVfmqcpOgJm1KmbRMcOrFQ1z70RoVl3H3eFxQcmTd/VbvTCnvASlZ6Rk+4Wn62dOj1N3R6I32khx6zw5v3712kFDr7v9iNdZWcN7oHDXKR7rfzQsDDaTMwXDFiOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iflUeQfy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733312693; x=1764848693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pHwngGRAb/vPrnt8FnpBqAiQofRnngsM9ULIkXyMQ/k=;
  b=iflUeQfyw8cys5xytdwWBZN9HQhzKSOIpSNZo6VJP4TvenXaKjcPnNqh
   O6QbJf1rEifWALVjQxF++cRpP7l0ixl28fK461QyxWxqB8sYaB0CWYued
   ueMPTTgr2ZZpInT2DRlVSpXSt1fH+pKibYAu9TwI9DTNnFmxj2dF5Oeu3
   8of749y/UUrJOMNdc1Tz3yv6TWRBCVJGXhGcdS4bPdzN2E0I8uLbIcQra
   +wluKpoYcMIn/vXGH7bYp0WyeFaDt0NG9Dd3+t0qNKhAQfA+scfmN1WDf
   4jVDWezhFrltDAvk6gZtilNJqqb5hwhe6+uB/uaJu/Lz8mkAe4/YJ1XE/
   A==;
X-CSE-ConnectionGUID: gpwxvSsZQsu1ySRJS0aRBQ==
X-CSE-MsgGUID: mH1P7UdMRVieHcEp2GhzMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44966378"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44966378"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 03:44:51 -0800
X-CSE-ConnectionGUID: HDlhMaCOTWywTgMaKE+3LA==
X-CSE-MsgGUID: jQRd2aMvS7iD2XB5yQMDDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="124670341"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 04 Dec 2024 03:44:48 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tInoE-0002yV-0R;
	Wed, 04 Dec 2024 11:44:46 +0000
Date: Wed, 4 Dec 2024 19:43:57 +0800
From: kernel test robot <lkp@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	eraretuya@gmail.com, l.rubusch@gmail.com
Subject: Re: [PATCH v3 10/10] iio: accel: adxl345: add kfifo with watermark
Message-ID: <202412041901.a986bAPP-lkp@intel.com>
References: <20241203205241.48077-11-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203205241.48077-11-l.rubusch@gmail.com>

Hi Lothar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.13-rc1 next-20241203]
[cannot apply to jic23-iio/togreg v6.13-rc1 v6.12 v6.12-rc7 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lothar-Rubusch/iio-accel-adxl345-fix-comment-on-probe/20241204-121629
base:   linus/master
patch link:    https://lore.kernel.org/r/20241203205241.48077-11-l.rubusch%40gmail.com
patch subject: [PATCH v3 10/10] iio: accel: adxl345: add kfifo with watermark
config: i386-buildonly-randconfig-004 (https://download.01.org/0day-ci/archive/20241204/202412041901.a986bAPP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041901.a986bAPP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412041901.a986bAPP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/accel/adxl345_core.c:434: warning: expecting prototype for irqreturn_t adxl345_event_handler()(). Prototype was for adxl345_event_handler() instead


vim +434 drivers/iio/accel/adxl345_core.c

   425	
   426	/**
   427	 * irqreturn_t adxl345_event_handler() - Handle events of the ADXL345.
   428	 * @irq: The irq being handled.
   429	 * @p: The struct iio_device pointer for the device.
   430	 *
   431	 * Return: The interrupt was handled.
   432	 */
   433	static irqreturn_t adxl345_event_handler(int irq, void *p)
 > 434	{
   435		struct iio_dev *indio_dev = p;
   436		struct adxl345_state *st = iio_priv(indio_dev);
   437		u8 int_stat;
   438		int samples;
   439	
   440		int_stat = adxl345_get_status(st);
   441		if (int_stat < 0)
   442			return IRQ_NONE;
   443	
   444		if (int_stat == 0x0)
   445			goto err;
   446	
   447		if (int_stat & ADXL345_INT_OVERRUN)
   448			goto err;
   449	
   450		if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK)) {
   451			samples = adxl345_get_samples(st);
   452			if (samples < 0)
   453				goto err;
   454	
   455			if (adxl345_fifo_push(indio_dev, samples) < 0)
   456				goto err;
   457	
   458		}
   459		return IRQ_HANDLED;
   460	
   461	err:
   462		adxl345_fifo_reset(st);
   463	
   464		return IRQ_HANDLED;
   465	}
   466	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

