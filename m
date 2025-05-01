Return-Path: <linux-iio+bounces-18949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EDAAA6456
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 21:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059B59A87A7
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 19:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7C32367C5;
	Thu,  1 May 2025 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3VGFk5X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ADD235047;
	Thu,  1 May 2025 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746129030; cv=none; b=X1YexFui4b9fmJtIJogqsJ9rhFcGnrTRsz4tleIrfN8n94zVMZ7UJt03AYN9Q+Cj8r73VkmXkbEXBoujz9YqkX9+C3r15s6d4fFEOBzb+Uf9b3GEGipML7XGrhbxl4HeOhruC40zwELy2hgwvQiMMtJ+53Dd6LrUXfigZhSvvZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746129030; c=relaxed/simple;
	bh=9RoNPI+kBpr/xIAzqLITkYQ3U2KM3NrSldLJ4O4+PC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohl20UZUBo84Cj7cYz5OASbEn/us+e5y3qWMd8Fb0CWpVgdhfvQ1a675Vm6WX3GMHUD+GsS/I0dXwzS7r+JXzXKU2PeDEBPJvGlBRfsNZKVf80OfjN9kzmiGzPuagsp+tvi63LTd6LBHUITJFXltrCYZ4y8o53n3682RmurRS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3VGFk5X; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746129029; x=1777665029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9RoNPI+kBpr/xIAzqLITkYQ3U2KM3NrSldLJ4O4+PC0=;
  b=J3VGFk5X91dyWAJa1SNFli5UjrxPV0Z1VG23XMUkptlKvgF3T4yn5pCx
   JWiQDXMj41AJcnliTLiY1pw4jVrMon5rKhKE+oaNgyX+dXp2P5FdOSJAP
   ETio0VFCMJ0RyRn1TPPX8nrewIMOtMcaO9fhQ8H9RxYpL4qN56OKe7ugU
   JQJI2+a+N9FYuJSYXLjdAJCFdqI1vb9sFLJEdv2g68/deCCgj3c2CZhkh
   AuCAK5H6+wg56XNJOwcSROr5ymkZs9ztbrJL6G0r5sOO/yFEV7gSEd2Xj
   WXkUJ6DAYYBp9SSLAZjWx57rc8O9pwu6NX/Zs7f2R3/gqPAhKjg0FZJzL
   w==;
X-CSE-ConnectionGUID: bhxExtwWSYee8HrKZ5NbqA==
X-CSE-MsgGUID: GMTgRhpBRB6ZrDpAdYRDmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="47901150"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="47901150"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 12:50:28 -0700
X-CSE-ConnectionGUID: iDbJK2u9SF6NDYMBjGFTjQ==
X-CSE-MsgGUID: LdBwbA50RUKCYfaMFrpm5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="139276610"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 01 May 2025 12:50:24 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uAZvK-0004M7-28;
	Thu, 01 May 2025 19:50:22 +0000
Date: Fri, 2 May 2025 03:50:15 +0800
From: kernel test robot <lkp@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jic23@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 7/7] iio: adc: ad4170: Add support for weigh scale and
 RTD sensors
Message-ID: <202505020345.iJUIBTwt-lkp@intel.com>
References: <3687a9e0a479aef9736ad557b341ed2e7d4f5756.1745841276.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3687a9e0a479aef9736ad557b341ed2e7d4f5756.1745841276.git.marcelo.schmitt@analog.com>

Hi Marcelo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1c2409fe38d5c19015d69851d15ba543d1911932]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Schmitt/dt-bindings-iio-adc-Add-AD4170/20250428-222010
base:   1c2409fe38d5c19015d69851d15ba543d1911932
patch link:    https://lore.kernel.org/r/3687a9e0a479aef9736ad557b341ed2e7d4f5756.1745841276.git.marcelo.schmitt%40analog.com
patch subject: [PATCH v2 7/7] iio: adc: ad4170: Add support for weigh scale and RTD sensors
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20250502/202505020345.iJUIBTwt-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250502/202505020345.iJUIBTwt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505020345.iJUIBTwt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/adc/ad4170.c: In function 'ad4170_setup_current_src.isra':
>> drivers/iio/adc/ad4170.c:1881:29: warning: 'current_src' is used uninitialized [-Wuninitialized]
    1881 |                 current_src |= FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_PIN_MSK, pin);
         |                             ^~
   drivers/iio/adc/ad4170.c:1875:22: note: 'current_src' was declared here
    1875 |         unsigned int current_src, i, j;
         |                      ^~~~~~~~~~~


vim +/current_src +1881 drivers/iio/adc/ad4170.c

  1869	
  1870	static int ad4170_setup_current_src(struct ad4170_state *st,
  1871					    struct fwnode_handle *child,
  1872					    struct ad4170_setup *setup, u32 *exc_pins,
  1873					    int num_exc_pins, int exc_cur, bool ac_excited)
  1874	{
  1875		unsigned int current_src, i, j;
  1876		int ret;
  1877	
  1878		for (i = 0; i < num_exc_pins; i++) {
  1879			unsigned int pin = exc_pins[i];
  1880	
> 1881			current_src |= FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_PIN_MSK, pin);
  1882			current_src |= FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_VAL_MSK, exc_cur);
  1883	
  1884			for (j = 0; j < AD4170_NUM_CURRENT_SRC; j++) {
  1885				/*
  1886				 * Excitation current chopping is configured in pairs.
  1887				 * If current chopping configured and the first end of
  1888				 * the current source pair has already been assigned,
  1889				 * skip to the next pair of output currents.
  1890				 */
  1891				if (ac_excited && j % 2 != 0)
  1892					continue;
  1893	
  1894				if (st->cur_src_pins[j] == AD4170_CURRENT_SRC_DISABLED) {
  1895					st->cur_src_pins[j] = pin;
  1896					break;
  1897				}
  1898			}
  1899			if (j == AD4170_NUM_CURRENT_SRC)
  1900				return dev_err_probe(&st->spi->dev, -EINVAL,
  1901						     "Failed to setup IOUT at pin %u\n",
  1902						     pin);
  1903	
  1904			ret = regmap_write(st->regmap, AD4170_CURRENT_SRC_REG(j),
  1905					   current_src);
  1906			if (ret)
  1907				return ret;
  1908		}
  1909	
  1910		if (ac_excited && num_exc_pins > 1) {
  1911			unsigned int exc_cur_pair;
  1912	
  1913			if (st->cur_src_pins[0] == exc_pins[0])
  1914				exc_cur_pair = 1;
  1915			else
  1916				exc_cur_pair = 2;
  1917	
  1918			/*
  1919			 * Configure excitation currents chopping.
  1920			 * Chop two pairs if using four excitation currents.
  1921			 */
  1922			setup->misc |= FIELD_PREP(AD4170_MISC_CHOP_IEXC_MSK,
  1923						  num_exc_pins == 2 ? exc_cur_pair : 3);
  1924		}
  1925	
  1926		return 0;
  1927	}
  1928	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

