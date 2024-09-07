Return-Path: <linux-iio+bounces-9313-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E95BC97046F
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 00:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65293B22031
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 22:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E18816A38B;
	Sat,  7 Sep 2024 22:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lB1ZAY35"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00304160884;
	Sat,  7 Sep 2024 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725749495; cv=none; b=o+bgVJMNoJ0m8Dl+P84NDX1H1Uu1C93GpUz1n7iSS5BzAm7OE58SAUzIa0Qkpk8TMQgnMP8RhwVD8idMasGiBgsj/3O/9UTTGH9Ge2UYhty+ucyvQ2PF7AZviF05MyozotRIamIT7P0+Z2MgTlq/cUDuE7B8CKFR9bJSVoh1S2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725749495; c=relaxed/simple;
	bh=do842DqulJJ6dI6EnJSEYjNX4gsqnwlO4RWeiRD9jww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjxDF8H0P2+Qtbg2+NYKe98mnDjArP+Cg6cXaSWv3ir1o3hXNrn8vyD7m7Sti0yq10EiiND1X3HAijIuLnX7Qjn0S0cSvUMMMAINgntjs9+iGlu3oMjcG6vVC4VEGjDtC6niIAeRQ+twHRC4H5jpJrlGlrNt40CEcP0EWGL3/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lB1ZAY35; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725749494; x=1757285494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=do842DqulJJ6dI6EnJSEYjNX4gsqnwlO4RWeiRD9jww=;
  b=lB1ZAY357wCgvfFYXTX2nXGUBxpF1A+hovHCkA5gd9IgmCnfrg0xY72K
   /fc/+6t9uSXOXg/vbJ++FH5v5qRZoNGl5By0VBoTNovIiGucpdOFIk8QL
   J8thWKXDe1vtHb68omy1B5wIy37BYQ5fq0zWDdWTYOH43AKEIDeHNm1Yi
   Eumn4pYR81HPkaNCaHcl1nEWRJKNTVZqyDl7pXzCLlybu7WCN0lJK7V4c
   BsH0p6maNKP0g7+CqWJRghriZ/dnHcN7TEpn4qcbbucO9D2tYg2eKsZ6x
   eCE5nJTpBcY+h+kbhffMFKhkqUCu/FwMdmOoY0+PnbavVB1Ka0UJibOwD
   Q==;
X-CSE-ConnectionGUID: /0t4ybZDRTiRApYG284ePQ==
X-CSE-MsgGUID: ExXxmZSJTOKK8ah6YOudpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="35829793"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="35829793"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 15:51:33 -0700
X-CSE-ConnectionGUID: 8u21cVZpQTWszDXC4sHFxw==
X-CSE-MsgGUID: kD/vSvzLTFyG7uaJTE2dgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="89562848"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 07 Sep 2024 15:51:29 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sn4H9-000D4b-20;
	Sat, 07 Sep 2024 22:51:27 +0000
Date: Sun, 8 Sep 2024 06:50:50 +0800
From: kernel test robot <lkp@intel.com>
To: Trevor Gamblin <tgamblin@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	David Lechner <dlechner@baylibre.com>,
	Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v4 2/3] iio: adc: ad7625: add driver
Message-ID: <202409080658.vblJ5uZm-lkp@intel.com>
References: <20240904-ad7625_r1-v4-2-78bc7dfb2b35@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-ad7625_r1-v4-2-78bc7dfb2b35@baylibre.com>

Hi Trevor,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1ebd3850421749eb44bd040b249bd4db88d35b33]

url:    https://github.com/intel-lab-lkp/linux/commits/Trevor-Gamblin/dt-bindings-iio-adc-add-AD762x-AD796x-ADCs/20240905-031609
base:   1ebd3850421749eb44bd040b249bd4db88d35b33
patch link:    https://lore.kernel.org/r/20240904-ad7625_r1-v4-2-78bc7dfb2b35%40baylibre.com
patch subject: [PATCH v4 2/3] iio: adc: ad7625: add driver
config: arm-randconfig-002-20240908 (https://download.01.org/0day-ci/archive/20240908/202409080658.vblJ5uZm-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 05f5a91d00b02f4369f46d076411c700755ae041)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240908/202409080658.vblJ5uZm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409080658.vblJ5uZm-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_performance.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_userspace.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-aspeed.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-gpio.o
>> ERROR: modpost: "pwm_round_waveform_might_sleep" [drivers/iio/adc/ad7625.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

