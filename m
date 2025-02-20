Return-Path: <linux-iio+bounces-15877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 875C3A3E063
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 17:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5267D3B1932
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 16:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38841FFC78;
	Thu, 20 Feb 2025 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNlekTg7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934621DF265;
	Thu, 20 Feb 2025 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068308; cv=none; b=CZIasIHr7wutXH5ivN6Za0kGg71ozj+q5Mzpii4JkyhjlXgkL5QRU9ZbOSp6rS8z0vZAfDtcOG0wdhZ+Fc4tgIJ6xd+YGkNV/FFX9bS5BJAJGeioYy2s9OgASsgxWcD7UEgQyJuniP9YNPPzltEu3RJTYcTlkP0NBV4ENfBmUPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068308; c=relaxed/simple;
	bh=9RlNbYnLFzVjYgxQyd9KBfI9XCJfe/tCHW00K82XgB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1jIcgyOHaTZHMqxegMdWefN1Sb3Up534prgLAA1DDBxYV+wXowFWNdRpQjlKU4CvdoCbclJK4n3GsAJTRE/McgjbavR0JN2eHc6nwUSwRZA0RYzWfICLr6AwMnKW6iR8pRmCBIxnuJBdLpVNiEaRqcFG39MisTVBOKoL5Cd8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNlekTg7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740068307; x=1771604307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9RlNbYnLFzVjYgxQyd9KBfI9XCJfe/tCHW00K82XgB4=;
  b=VNlekTg75J0qAfGXfCvz0vp9dqZZQvGYx1+ARWw+GevfDx2ZXEEsqZnY
   EP12CT5KYU2m5qe/J5UdIeollr3MxqD8LeOG46/PH5IlfUSQv1TT5bNTR
   oN1bDImQ7RLyF2Wt4+7LndeRXNa5rtyqrnQfWe6DeM1CqnB0co3wmKq/B
   /rufj10FsJRtDmVRPq4jy/wkk8gWpU1aBcjP++YIz7VNKE6hAK2LTJXaR
   wLsxEJ6u4j9zZzcyzZauVn4+Xu1botvPUdM5oxzgpK4C4w7g2pPzllIq0
   rM2mkWK0OWKRhgpbL4pakdx4bF+W7dYCVlJ7mOj4miR39qMoy08g/L31b
   g==;
X-CSE-ConnectionGUID: PgqEARegRjyuSKZrIoJggA==
X-CSE-MsgGUID: aXyg0+ITTbWTTroNejoE6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="63329824"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="63329824"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:18:26 -0800
X-CSE-ConnectionGUID: MUBFVS80SV+FEOQ9rn5jww==
X-CSE-MsgGUID: 0PpoekXBQF2IG16mnDk74Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="138294951"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 20 Feb 2025 08:18:21 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tl9Fj-0004UJ-01;
	Thu, 20 Feb 2025 16:18:19 +0000
Date: Fri, 21 Feb 2025 00:17:33 +0800
From: kernel test robot <lkp@intel.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 7/9] iio: adc: sun20i-gpadc: Use adc-helpers
Message-ID: <202502210037.162FN3PM-lkp@intel.com>
References: <21b9af362b64a1d9c2a13cc46242dd6955996c46.1739967040.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21b9af362b64a1d9c2a13cc46242dd6955996c46.1739967040.git.mazziesaccount@gmail.com>

Hi Matti,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5bc55a333a2f7316b58edc7573e8e893f7acb532]

url:    https://github.com/intel-lab-lkp/linux/commits/Matti-Vaittinen/dt-bindings-ROHM-BD79124-ADC-GPO/20250219-203748
base:   5bc55a333a2f7316b58edc7573e8e893f7acb532
patch link:    https://lore.kernel.org/r/21b9af362b64a1d9c2a13cc46242dd6955996c46.1739967040.git.mazziesaccount%40gmail.com
patch subject: [PATCH v3 7/9] iio: adc: sun20i-gpadc: Use adc-helpers
config: i386-buildonly-randconfig-002-20250220 (https://download.01.org/0day-ci/archive/20250221/202502210037.162FN3PM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250221/202502210037.162FN3PM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502210037.162FN3PM-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "devm_iio_adc_device_alloc_chaninfo" [drivers/iio/adc/sun20i-gpadc-iio.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

