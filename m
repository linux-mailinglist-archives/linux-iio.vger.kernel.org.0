Return-Path: <linux-iio+bounces-12773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381639DB520
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 10:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9892822CB
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 09:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C0F157493;
	Thu, 28 Nov 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9xfur6D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCFD156238;
	Thu, 28 Nov 2024 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787759; cv=none; b=oDykgXFIqLjp9rhq+qZijByio8sh6upuPDd6HA5EioA6iCW5EbLZU/GP5VlYxbv6zoBVMA77gHBVYJnoM5vWSPucZL1MmkpJD7S+AbflOfqWiOa0UVh6oBkM0rr3WHCXWEWrsSkXgOYd4wTQFS1H7b/49ZKPoRHpW+aH6IYkSBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787759; c=relaxed/simple;
	bh=+FHDG0XHJEgVnEqWKiJLK3AK3kcz3Kq7MaSKJ1PjwDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3qTqbYymj0DFSfyQo48+lIwNPanDEG2GAnRgkCIJlrH4sDFO0PgXlTl77bYX5ziHVgml/yo9QIdSRu3InHsfZNyUXvqH1ha8LThJT+VUXXko073oR6xqleQYanwz2/qP0qgELxRd87KgXctlRlY+GsfMYjPYDAciF5CG4xtbbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9xfur6D; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732787757; x=1764323757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+FHDG0XHJEgVnEqWKiJLK3AK3kcz3Kq7MaSKJ1PjwDg=;
  b=J9xfur6D4f3VZlIbAxSoT73L7jQbWAwPKRALy9+Uc5AEkB0QSde5ixR7
   f+yed2NdeU6VU+3Kn5GOKPP70A8R2pwXpe/tN1SBQdWVwsfCHGu/Hr4kR
   YgxxXCLVpXtYW+TDDB84N3uwItNIOECx1dY6CDb74dwiWHdPoyVzkVuJs
   Asp2jlR6pBaX0mmZp8Lg5OvPweYhIlBcHuTEurNsxcLO9BYzUSAqmEtWc
   NvS2GLfhSKTMqT+yMm2e8lsDuOEEuVhkxMxH92vgexXJ6V+mjNJAapdnf
   2F8GsAYRfo1+dk25Z+QDGCe389Et1zBRMJH3wUXWBcGX2Ah9OnF6yd99Q
   g==;
X-CSE-ConnectionGUID: w2N/hKQzSaS73m+rbogC0Q==
X-CSE-MsgGUID: m6lLKKCIRsiH+Ql+LAPurg==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="32874046"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="32874046"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 01:55:56 -0800
X-CSE-ConnectionGUID: ex1k9ZOPSKClhaKQHSZ54Q==
X-CSE-MsgGUID: t9/QEeeSQTmFOUoOjT6miQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="97283692"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 28 Nov 2024 01:55:54 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGbFW-0009RD-2t;
	Thu, 28 Nov 2024 09:55:50 +0000
Date: Thu, 28 Nov 2024 17:55:28 +0800
From: kernel test robot <lkp@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH 2/2] iio: light: add support for veml6031x00 ALS series
Message-ID: <202411281741.xz7mD4E2-lkp@intel.com>
References: <20241126-veml6031x00-v1-2-4affa62bfefd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126-veml6031x00-v1-2-4affa62bfefd@gmail.com>

Hi Javier,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a61ff7eac77e86de828fe28c4e42b8ae9ec2b195]

url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Carrasco/dt-bindings-iio-light-veml6030-add-veml6031x00-ALS-series/20241128-104104
base:   a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
patch link:    https://lore.kernel.org/r/20241126-veml6031x00-v1-2-4affa62bfefd%40gmail.com
patch subject: [PATCH 2/2] iio: light: add support for veml6031x00 ALS series
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20241128/202411281741.xz7mD4E2-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241128/202411281741.xz7mD4E2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411281741.xz7mD4E2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/light/veml6031x00.c: In function 'veml6031x00_set_scale':
>> drivers/iio/light/veml6031x00.c:422:24: warning: variable 'gain_idx' set but not used [-Wunused-but-set-variable]
     422 |         int new_scale, gain_idx;
         |                        ^~~~~~~~


vim +/gain_idx +422 drivers/iio/light/veml6031x00.c

   418	
   419	static int veml6031x00_set_scale(struct iio_dev *iio, int val, int val2)
   420	{
   421		struct veml6031x00_data *data = iio_priv(iio);
 > 422		int new_scale, gain_idx;
   423	
   424		if (val == 0 && val2 == 125000) {
   425			new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x03) |
   426				VEML6031X00_CONF1_PD_D4;
   427			gain_idx = 0;
   428		} else if (val == 0 && val2 == 165000) {
   429			new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x02) |
   430				VEML6031X00_CONF1_PD_D4;
   431			gain_idx = 1;
   432		} else if (val == 0 && val2 == 250000) {
   433			new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x00) |
   434				VEML6031X00_CONF1_PD_D4;
   435			gain_idx = 2;
   436		} else if (val == 0 && val2 == 500000) {
   437			new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x03);
   438			gain_idx = 3;
   439		} else if (val == 0 && val2 == 660000) {
   440			new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x02);
   441			gain_idx = 4;
   442		} else if (val == 1 && val2 == 0) {
   443			new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x00);
   444			gain_idx = 5;
   445		} else if (val == 2 && val2 == 0) {
   446			new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x01);
   447			gain_idx = 6;
   448		} else {
   449			return -EINVAL;
   450		}
   451	
   452		return regmap_update_bits(data->regmap, VEML6031X00_REG_CONF1,
   453					 VEML6031X00_CONF1_GAIN |
   454					 VEML6031X00_CONF1_PD_D4,
   455					 new_scale);
   456	}
   457	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

