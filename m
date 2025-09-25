Return-Path: <linux-iio+bounces-24424-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3511B9CE88
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 02:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D0B422BBD
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 00:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144062D24A9;
	Thu, 25 Sep 2025 00:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Svpr2iTN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CFB287269;
	Thu, 25 Sep 2025 00:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758760551; cv=none; b=uwsLdMABAymaKn404ZygL5HDhbEPsEyD/CtNag+oHJl6BoKRHwgX3hH4mlJFr4pjPAh9VVp0fl/BkkcOxiR1Tgd28MpHyuYhXrCeyGspRdVUgt61YfwMA/7IMb1d1xU3hrR6iEt8hokhdDtCYZ/VOps+ADme61r1h4CLfwbdrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758760551; c=relaxed/simple;
	bh=xA0CjVUfg2LtglRI54aHrjcq9fO/yGSBYFN8nfqQdb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1ztoB3QP11gAdU0yHaLKIk4ogmMtgEc7y+RS4yzJ4BLlKR1V7OsmggTPiJwcWrL/PzvM/PiJyMRSTTdeuTYUpxwQ+RWRe33PWZ5Cfr8oIYOmyfJ52MrNG+dO7dgVgzHssf1zAGA4AX+h37WwO7Nu+dhSBgyrbpo9XmeqWZ4fA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Svpr2iTN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758760550; x=1790296550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xA0CjVUfg2LtglRI54aHrjcq9fO/yGSBYFN8nfqQdb0=;
  b=Svpr2iTN3+iyhCkPtAQG6klaf583hQC0KWfhx8ge3n5v7ihuA5P/KH+0
   xeEr5Y/6jVhzOHmJMpc6G77BYOK3UWnmExFYGJzNv8sxpNV+pXobfVPZ5
   9iQ+mGmxQrio9c8/p7dQVAbTUxw4GH38D3QY+2IJOACAX1T44UGQcUlEQ
   tdRGvOvcOh+CzmP54L4LjRQxNyX1kUbL/Lf4AkR7PPs7nPTdIU0J6X8bR
   VVTygMuQtfOuJ+qKS6rrS1xzu/WQju/QaksxUVbGxIyhZBpcZtvWXksFV
   BdpB6oJn2eeC6iOrWf7Ae8U0jUrstXBDcqOmqwrl+oVWKM25CEwMrlnyP
   w==;
X-CSE-ConnectionGUID: LClpkTrSQRGTIcRlaKr20A==
X-CSE-MsgGUID: tHoemWhCSGiiPNxNbEyzrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="63696448"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="63696448"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 17:35:50 -0700
X-CSE-ConnectionGUID: CPiw2J5+SfWjKZOP9fSuow==
X-CSE-MsgGUID: +hr0XRqiSPu0wGNcEZmXxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="176311003"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 24 Sep 2025 17:35:46 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1ZxX-0004kT-1V;
	Thu, 25 Sep 2025 00:35:43 +0000
Date: Thu, 25 Sep 2025 08:34:47 +0800
From: kernel test robot <lkp@intel.com>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
Subject: Re: [PATCH v6 7/9] iio: imu: inv_icm45600: add SPI driver for
 inv_icm45600 driver
Message-ID: <202509250829.OYI9IbAs-lkp@intel.com>
References: <20250924-add_newport_driver-v6-7-76687b9d8a6e@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-add_newport_driver-v6-7-76687b9d8a6e@tdk.com>

Hi Remi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 411e8b72c181e4f49352c12ced0fd8426eb683aa]

url:    https://github.com/intel-lab-lkp/linux/commits/Remi-Buisson-via-B4-Relay/dt-bindings-iio-imu-Add-inv_icm45600/20250924-172614
base:   411e8b72c181e4f49352c12ced0fd8426eb683aa
patch link:    https://lore.kernel.org/r/20250924-add_newport_driver-v6-7-76687b9d8a6e%40tdk.com
patch subject: [PATCH v6 7/9] iio: imu: inv_icm45600: add SPI driver for inv_icm45600 driver
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20250925/202509250829.OYI9IbAs-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250925/202509250829.OYI9IbAs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509250829.OYI9IbAs-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c:24:5: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      24 |                                 FIELD_PREP(INV_ICM45600_DRIVE_CONFIG0_SPI_MASK,
         |                                 ^
   1 error generated.


vim +/FIELD_PREP +24 drivers/iio/imu/inv_icm45600/inv_icm45600_spi.c

    18	
    19	static int inv_icm45600_spi_bus_setup(struct inv_icm45600_state *st)
    20	{
    21		/* Set slew rates for SPI. */
    22		return regmap_update_bits(st->map, INV_ICM45600_REG_DRIVE_CONFIG0,
    23					INV_ICM45600_DRIVE_CONFIG0_SPI_MASK,
  > 24					FIELD_PREP(INV_ICM45600_DRIVE_CONFIG0_SPI_MASK,
    25						INV_ICM45600_SPI_SLEW_RATE_5NS));
    26	}
    27	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

