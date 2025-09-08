Return-Path: <linux-iio+bounces-23890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C700B49A8F
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 22:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB17B4E197E
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 20:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405FA2D77F5;
	Mon,  8 Sep 2025 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmoG4NDV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE55219A86;
	Mon,  8 Sep 2025 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361771; cv=none; b=DGk6+rtB2tnNTUptQgqVqv/iCinvakaD/gFM7Ip3kaATA4DdrjvkEXjLMtoaFGTJDu8zp3P88t1JLd7kgVe6c2HzxCxTL7EXxefGw5TxTLQqhNeDxSqd3oJyxCvxu0XqxXcP5ia9UzsLilwGUulqDQK6S/WxLEF1IFaiEVmUQtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361771; c=relaxed/simple;
	bh=7DOP+7F2mn8xBOqn8zohU2fZyfjzOo/Gx5CGf4Zo840=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtCdMbpa1WXufa36w+xGaDI1CsTRp3gd0clmci+/GYHzWgDw6twXS6HD+6syyAgUQ95GrrZAi+We8ou9NNHi5V04AFxywagouCnphAS6UczWQK6mUbJTevLJo+oMcnZWcJmN2C8uVuJ3ZpNc+f4YjqO7lCmOqDWLvu8FYOD9GOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lmoG4NDV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757361770; x=1788897770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7DOP+7F2mn8xBOqn8zohU2fZyfjzOo/Gx5CGf4Zo840=;
  b=lmoG4NDVMASl9qE8zxnFNv6a1IJOwXy5NCznU6Z27oiu7b+jEoTsu9yj
   uHMF9yV+ph+7eg6gvKUPxy6RBKrx2Mf4XVa/pC4N3DWCy98l8ZiL/Pd67
   3ZJlSZfeL67ROiBTvFSoOjX2BAOnTohhnsnWLRXFg0w/rMsVn6/Uluo6I
   3+XwgOUiOSyvVRylBMmtFv/yuI+IvnPa4rojfOFdnSjZE8UA/hQRuERGw
   pE1ciglhqrkxO+/DNa566K5V/vlpXlTn8SuQgqBdsmAwBXntVd4T6vVSf
   xcw+rqU8+7ti2Y7/2O1ugjVrBCi+VJPFe1GZLg25ZgIQFlnY+uYBWMSDW
   w==;
X-CSE-ConnectionGUID: R7Jl1lYcR4ueYfDElaDt8Q==
X-CSE-MsgGUID: K6NgrqwTQWWj0XoDma5RFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70732129"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="70732129"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 13:02:46 -0700
X-CSE-ConnectionGUID: /Sl2FUhRQ4KOZTq0Jxxl6w==
X-CSE-MsgGUID: gTr/fpAHT8e/neTJAB80kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="172759587"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 08 Sep 2025 13:02:41 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uvi4U-00047f-0u;
	Mon, 08 Sep 2025 20:02:38 +0000
Date: Tue, 9 Sep 2025 04:01:53 +0800
From: kernel test robot <lkp@intel.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Hans de Goede <hansg@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
Message-ID: <202509090302.DzgxdNbE-lkp@intel.com>
References: <3cc1faffcb4f71f0755b6192f193acecd36bea67.1757053456.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cc1faffcb4f71f0755b6192f193acecd36bea67.1757053456.git.mazziesaccount@gmail.com>

Hi Matti,

kernel test robot noticed the following build errors:

[auto build test ERROR on d1487b0b78720b86ec2a2ac7acc683ec90627e5b]

url:    https://github.com/intel-lab-lkp/linux/commits/Matti-Vaittinen/dt-bindings-iio-adc-ROHM-BD79112-ADC-GPIO/20250905-144454
base:   d1487b0b78720b86ec2a2ac7acc683ec90627e5b
patch link:    https://lore.kernel.org/r/3cc1faffcb4f71f0755b6192f193acecd36bea67.1757053456.git.mazziesaccount%40gmail.com
patch subject: [PATCH v3 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
config: i386-randconfig-r133-20250908 (https://download.01.org/0day-ci/archive/20250909/202509090302.DzgxdNbE-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250909/202509090302.DzgxdNbE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509090302.DzgxdNbE-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "spi_sync" [drivers/base/regmap/regmap-spi.ko] undefined!
>> ERROR: modpost: "spi_async" [drivers/base/regmap/regmap-spi.ko] undefined!
>> ERROR: modpost: "spi_write_then_read" [drivers/base/regmap/regmap-spi.ko] undefined!
>> ERROR: modpost: "__spi_register_driver" [drivers/iio/adc/rohm-bd79112.ko] undefined!
>> ERROR: modpost: "spi_sync" [drivers/iio/adc/rohm-bd79112.ko] undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for REGMAP_SPI
   Depends on [n]: SPI [=n]
   Selected by [m]:
   - ROHM_BD79112 [=m] && IIO [=m] && I2C [=y] && GPIOLIB [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

