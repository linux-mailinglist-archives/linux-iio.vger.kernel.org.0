Return-Path: <linux-iio+bounces-10672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9A09A197B
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 05:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D261C217D8
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 03:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7513D13AD29;
	Thu, 17 Oct 2024 03:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WzTR+aRh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D0D2D05E;
	Thu, 17 Oct 2024 03:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729137060; cv=none; b=kMpa5Fl2kmUzp0t9kc/fYW3ciqYQhc6UQ/Z3SYwhu/vWk1N3EsduKjPHinDnB2LJIxaOb+iEc+NSgsRlGX91zYaJCcclFXqGGNQBWtUbtOzW1flcW9ZfbKChR0SxPJXbOb6z4UcfIFf39ITqUZ7DlyuoxC0EtZ0MHEWuRB757Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729137060; c=relaxed/simple;
	bh=L0UjiYZmFtvS99X6G53pstC3l3BtzZhh4ldH4u/KynQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpZ99rYUvkwqXv90QDbIFNRxXpEOW75WopeEM4k94f4MDw0T+rwGvpuBOp/yGEowA18vY1GZvAALW9L0P3pIgKUuCVPWfMVdSJjzSE89f391mUaVxM8PnyWh6caHjIdGiPljjCh9xHGyNDfMKtjLUW9XrwgN+rzlrsOvArmxJqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WzTR+aRh; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729137058; x=1760673058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L0UjiYZmFtvS99X6G53pstC3l3BtzZhh4ldH4u/KynQ=;
  b=WzTR+aRhtfveO1W9jeJo2LxilTMFLX6JwdbFHSAdBKNBQI/WLoZSo4e/
   7SmrE7O/21JTaE/2DumusUma28l3Hq3ObQ+QKkmZ6lZWpYomqfS0I9Qx+
   5dFPOMHuk4lnLiy0xNrupmZEADJMpFyUjSqPW5s8s9yi0Yq3LydFXOjZL
   Goi7u4oUYflw0UF5M9pAc0JmumdHkoAsLG5MK2d58tae3gVldoy9Kz33Q
   43Awg4Ftl+BYg6GvtJKBfvdsPm1OtfgoaV89YPOz1EInlm1NxorgVeI/d
   gNU326EcHcMIOmPbKcSG4iIPey64g1sVo1rZV0PJLcjMbaFLZl5oK9J8/
   g==;
X-CSE-ConnectionGUID: amFCRoDTRxKiPH4wcvB+Ew==
X-CSE-MsgGUID: d1IduJ2yRO2/7tBm9GIKwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28395952"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28395952"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 20:50:58 -0700
X-CSE-ConnectionGUID: 0rgLyo/pSU+Z9IW6mKtaqw==
X-CSE-MsgGUID: zrb50m4RR5mKHvyHvZ1U+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="82967404"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 16 Oct 2024 20:50:55 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1HXI-000Lhd-3A;
	Thu, 17 Oct 2024 03:50:52 +0000
Date: Thu, 17 Oct 2024 11:50:14 +0800
From: kernel test robot <lkp@intel.com>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	rickard.andersson@axis.com, kernel@axis.com,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: Re: [PATCH v3 2/2] iio: light: Add support for TI OPT4060 color
 sensor
Message-ID: <202410171139.5QhZ0EZG-lkp@intel.com>
References: <20241015143713.2017626-3-perdaniel.olsson@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015143713.2017626-3-perdaniel.olsson@axis.com>

Hi Per-Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on eca631b8fe808748d7585059c4307005ca5c5820]

url:    https://github.com/intel-lab-lkp/linux/commits/Per-Daniel-Olsson/dt-bindings-iio-light-Document-TI-OPT4060-RGBW-sensor/20241015-224128
base:   eca631b8fe808748d7585059c4307005ca5c5820
patch link:    https://lore.kernel.org/r/20241015143713.2017626-3-perdaniel.olsson%40axis.com
patch subject: [PATCH v3 2/2] iio: light: Add support for TI OPT4060 color sensor
config: x86_64-randconfig-121-20241017 (https://download.01.org/0day-ci/archive/20241017/202410171139.5QhZ0EZG-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241017/202410171139.5QhZ0EZG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410171139.5QhZ0EZG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/light/opt4060.c:836:9: sparse: sparse: statement expected after case label

vim +836 drivers/iio/light/opt4060.c

   807	
   808	static int opt4060_write_event(struct iio_dev *indio_dev,
   809				       const struct iio_chan_spec *chan,
   810				       enum iio_event_type type,
   811				       enum iio_event_direction dir,
   812				       enum iio_event_info info,
   813				       int val, int val2)
   814	{
   815		struct opt4060_chip *chip = iio_priv(indio_dev);
   816	
   817		switch (info) {
   818		case IIO_EV_INFO_VALUE:
   819			if (chan->type == IIO_INTENSITY && type == IIO_EV_TYPE_THRESH) {
   820				u32 th_lo, th_hi;
   821	
   822				if (opt4060_get_thresholds(chip, &th_lo, &th_hi))
   823					return -EFAULT;
   824				if (dir == IIO_EV_DIR_FALLING)
   825					th_lo = val;
   826				else if (dir == IIO_EV_DIR_RISING)
   827					th_hi = val;
   828				if (opt4060_set_thresholds(chip, th_lo, th_hi))
   829					return -EFAULT;
   830				return 0;
   831			}
   832			break;
   833		case IIO_EV_INFO_PERIOD:
   834			return opt4060_write_ev_period(chip, val, val2);
   835		default:
 > 836		}
   837		return -EINVAL;
   838	}
   839	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

