Return-Path: <linux-iio+bounces-15556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EDBA370FC
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 23:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC7216F4B3
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2025 22:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4715B1FCCEF;
	Sat, 15 Feb 2025 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTk4Jsff"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D01189BB5;
	Sat, 15 Feb 2025 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739657624; cv=none; b=gcBcRTbGgrAkBGtgsV4mOV0d4yMZCX2LzIlQvi4bmlA5t48Parle7P9rfvvMdjlAKNkM0L69H3jgYUD3pnJjdHf2cDGIz7W3R9uDRUpMGW0ylUNqmmSWtGA2rb78qI3lOUJa8L07LKWiwCvekS+kV9YpewreMMzOC7FLmg/MDCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739657624; c=relaxed/simple;
	bh=1r417Fv4wbCmlslgcJsjmJDWgb1/N6LDEW+Yz33Fr8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBZHBleCHIzfYX1tT9/cmZedQAph4pjOhs0bKCqQShmBjZYdsAG2zzttTzQUQ5SZd8xzScz1o4rIMVx9RZIcn+mJy3uxgmYFrJ66VKxCp9W5GEleQUqqiolodrWDJ7xQ16gUmiktr4rTRVmYEybR/k/LrrEf6r/ThM4iN0bK/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTk4Jsff; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739657623; x=1771193623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1r417Fv4wbCmlslgcJsjmJDWgb1/N6LDEW+Yz33Fr8c=;
  b=eTk4JsffY48T1aCveFVVKUF91zvcQngO7c2D+FRiYQwPUhruOL9vlrL/
   TxnUcGpddsi2oYDqvE4w4ou7MLzKMHqBQ8hDqTKaMZrEQDx+Lg+x0uO+J
   hQI9VntdjoUBqD8OLREQtANxqjFA2DHN1KQHgGEAzR3mWefLQHZR78nCH
   rVwX2UBZX3okZVjnSTnuu54mKOVoEIS1kPQ6xyOvaf/UlI4/7Y/yHCAaK
   kXzemuctd85CIP48ugcRzqjD8mJsMmfUJOZCClQpNTgFDq4dSvnk4IMUf
   MIaNspjnzGM9K8NlUy3ozYeOM0XfkRlLC37Mxy5ddNHhShOKuWUR6iBpO
   w==;
X-CSE-ConnectionGUID: Wm04jTO/Q/qcYmkMrNGbpQ==
X-CSE-MsgGUID: e6NGyblDRimqZosizy6s0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40305229"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="40305229"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 14:13:42 -0800
X-CSE-ConnectionGUID: DAovtuyVRvOV4qVt/ikIWA==
X-CSE-MsgGUID: GowWOLRRQdyCy/J8bsEbUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118693578"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 15 Feb 2025 14:13:38 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjQPn-001BEZ-2W;
	Sat, 15 Feb 2025 22:13:35 +0000
Date: Sun, 16 Feb 2025 06:13:18 +0800
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
Subject: Re: [PATCH v4 3/6] iio: adc: ad4030: add averaging support
Message-ID: <202502160603.zYl25ISM-lkp@intel.com>
References: <20250214-eblanc-ad4630_v1-v4-3-135dd66cab6a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-eblanc-ad4630_v1-v4-3-135dd66cab6a@baylibre.com>

Hi Esteban,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a64dcfb451e254085a7daee5fe51bf22959d52d3]

url:    https://github.com/intel-lab-lkp/linux/commits/Esteban-Blanc/dt-bindings-iio-adc-add-ADI-ad4030-ad4630-and-ad4632/20250214-202727
base:   a64dcfb451e254085a7daee5fe51bf22959d52d3
patch link:    https://lore.kernel.org/r/20250214-eblanc-ad4630_v1-v4-3-135dd66cab6a%40baylibre.com
patch subject: [PATCH v4 3/6] iio: adc: ad4030: add averaging support
config: parisc-randconfig-r112-20250216 (https://download.01.org/0day-ci/archive/20250216/202502160603.zYl25ISM-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250216/202502160603.zYl25ISM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502160603.zYl25ISM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/adc/ad4030.c:375:27: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct iio_scan_type *scan_type @@     got struct iio_scan_type const * @@
   drivers/iio/adc/ad4030.c:375:27: sparse:     expected struct iio_scan_type *scan_type
   drivers/iio/adc/ad4030.c:375:27: sparse:     got struct iio_scan_type const *
   drivers/iio/adc/ad4030.c: note: in included file (through include/linux/mutex.h, include/linux/notifier.h, include/linux/clk.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +375 drivers/iio/adc/ad4030.c

   365	
   366	static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
   367					 struct iio_chan_spec const *chan,
   368					 int *val,
   369					 int *val2)
   370	{
   371		struct ad4030_state *st = iio_priv(indio_dev);
   372		struct iio_scan_type *scan_type;
   373	
   374		if (chan->differential) {
 > 375			scan_type = iio_get_current_scan_type(indio_dev,
   376							      st->chip->channels);
   377			*val = (st->vref_uv * 2) / MILLI;
   378			*val2 = scan_type->realbits;
   379			return IIO_VAL_FRACTIONAL_LOG2;
   380		}
   381	
   382		*val = st->vref_uv / MILLI;
   383		*val2 = chan->scan_type.realbits;
   384		return IIO_VAL_FRACTIONAL_LOG2;
   385	}
   386	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

