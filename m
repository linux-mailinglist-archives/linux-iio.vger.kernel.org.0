Return-Path: <linux-iio+bounces-20777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A279ADF557
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 20:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0BCA188B28A
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 18:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293C43085B6;
	Wed, 18 Jun 2025 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQ/X910X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B11B3085BA;
	Wed, 18 Jun 2025 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750269568; cv=none; b=Pil1+dpMX0rQeyl18p3J/ZuM6LFpCft8pMd6Ban3vVmAu+uYIZGYZeHdzj8QqcCMI8PotVWTVRPeQt57RlMv8DI40l/vgBSMd5pVPkFWO/lI+GQoqxqQ1eGdaLrGFkFhD5MWsxxug9dRfvhOTuFscJVdfgwWxaXKRrQqFv6s/HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750269568; c=relaxed/simple;
	bh=VsQ9mjiyc4dnTIlr6g4DfKjP8V0Y85rIOMAAUGcigOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwTGFm82xCQ5prPUI4UdUCVmD6u97Sg8IArm4IHwLKexhqO+jwQ7yVArfnC58U0hg+EcWbbC1cw9DdhbnHHNEMHyOKyQf/FrpvCgM2DLmoPPz6IHa8eJl/Im429IPOF3y68Dz7CIkbJhL9WRWGFxlk3xxLkKaAyiRpKD3tD0Mww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQ/X910X; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750269565; x=1781805565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VsQ9mjiyc4dnTIlr6g4DfKjP8V0Y85rIOMAAUGcigOs=;
  b=JQ/X910XcsAL1KSJ3KZQSO/u4W+jTqWZ30TXsI+zoEQZcxr6hkh+N5jy
   7Soi5lgb494Ea5AY7jeEu+wWyXZQHLWO2ZlpKNXR88+wj1x/KCwZT60nF
   5hndzq1pCMv50sPdr8yOdPKHPT3Ux3HDzYhKrcwG31JUzv8PcA7AOSFlb
   9u5OwvgixAP1wv/jdVMB13cN2FiR31FwQLYFTcney4yMqWXB11i9xLQX3
   lvY/SzdJ2jWoCs8zAj12EYbegIwisSfLdSmS/ZVoA5o7o/Nw6gJDZ3gjA
   unPwJi7L1bSYyFJ1ovDM9eRL21tabH7BA+t3BN6kgb5G2yswbkTFyf/IC
   w==;
X-CSE-ConnectionGUID: nDPhsa4oRK6iKBy7txvr5g==
X-CSE-MsgGUID: 0oQedp24QTCYeOrK8OynyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="51734706"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="51734706"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:59:25 -0700
X-CSE-ConnectionGUID: ulQXaGOQTyCSlh6Kla1M5w==
X-CSE-MsgGUID: 4AskfPP0Rc6Mp7Knk70Z+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="150654595"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:59:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uRx48-00000007okJ-279d;
	Wed, 18 Jun 2025 20:59:16 +0300
Date: Wed, 18 Jun 2025 20:59:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linus.walleij@linaro.org, brgl@bgdev.pl, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v5 02/11] iio: adc: Add basic support for AD4170
Message-ID: <aFL-dLs5EQsde8Cq@smile.fi.intel.com>
References: <48598c0753cccf515addbe85acba3f883ff8f036.1749582679.git.marcelo.schmitt@analog.com>
 <d6ae8122-ff38-4fca-8e02-f27c7ac2ccd8@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6ae8122-ff38-4fca-8e02-f27c7ac2ccd8@suswa.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 18, 2025 at 08:37:53PM +0300, Dan Carpenter wrote:
> Hi Marcelo,
> 
> kernel test robot noticed the following build warnings:
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Schmitt/dt-bindings-iio-adc-Add-AD4170/20250611-101842
> base:   4c6073fec2fee4827fa0dd8a4ab4e6f7bbc05ee6
> patch link:    https://lore.kernel.org/r/48598c0753cccf515addbe85acba3f883ff8f036.1749582679.git.marcelo.schmitt%40analog.com
> patch subject: [PATCH v5 02/11] iio: adc: Add basic support for AD4170
> config: powerpc-randconfig-r072-20250613 (https://download.01.org/0day-ci/archive/20250614/202506140009.GdV0BtKr-lkp@intel.com/config)
> compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202506140009.GdV0BtKr-lkp@intel.com/
> 
> smatch warnings:
> drivers/iio/adc/ad4170.c:1181 ad4170_parse_adc_channel_type() warn: passing zero to 'dev_err_probe'
> 
> vim +/dev_err_probe +1181 drivers/iio/adc/ad4170.c
> 
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1170  static int ad4170_parse_adc_channel_type(struct device *dev,
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1171  					 struct fwnode_handle *child,
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1172  					 struct iio_chan_spec *chan)
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1173  {
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1174  	int ret, ret2;
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1175  	u32 pins[2];
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1176  
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1177  	/* Parse pseudo-differential channel configuration */
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1178  	ret = fwnode_property_read_u32(child, "single-channel", &pins[0]);
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1179  	ret2 = fwnode_property_read_u32(child, "common-mode-channel", &pins[1]);
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1180  	if (!ret && ret2)
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10 @1181  		return dev_err_probe(dev, ret,
>                                                                                           ^^^
> ret is zero, so this returns success.  s/ret/ret2/.
> 
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1182  			"single-ended channels must define common-mode-channel\n");

Instead of ret and ret2 this code should be refactored to use
_preperty_present() beforehands and return an error to the caller if it's
present but failed to be read or not optional at all.

> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1184  	if (!ret && !ret2) {
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1185  		chan->differential = false;
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1186  		chan->channel = pins[0];
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1187  		chan->channel2 = pins[1];
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1188  		return 0;
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1189  	}
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1190  	/* Failed to parse pseudo-diff chan props so try diff chan */
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1191  
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1192  	/* Parse differential channel configuration */
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1193  	ret = fwnode_property_read_u32_array(child, "diff-channels", pins,
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1194  					     ARRAY_SIZE(pins));
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1195  	if (!ret) {
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1196  		chan->differential = true;
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1197  		chan->channel = pins[0];
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1198  		chan->channel2 = pins[1];
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1199  		return 0;
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1200  	}
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1201  	return dev_err_probe(dev, ret,
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1202  		"Channel must define one of diff-channels or single-channel.\n");
> dfefd2b2405829 Ana-Maria Cusco 2025-06-10  1203  }

-- 
With Best Regards,
Andy Shevchenko



