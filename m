Return-Path: <linux-iio+bounces-7758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF8593821E
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 18:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42839281D79
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B3CDDB2;
	Sat, 20 Jul 2024 16:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pe623QCp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B583CBA;
	Sat, 20 Jul 2024 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721493039; cv=none; b=LTKuYF3S76F+84n5E9L7vNlyW/LNkI2d7Lgld91lDPxjdEXgPiN3VjMSv7TvQ+c3MZpfr/gkMuwERGf6b8d9fA004P6VLTStDlFNiOSrJ9DksAXrED6sv3CXEvaiWhNzai2x16MJNgPigDMSNB8mU8/zYIMcJtRDcTKpXFPseYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721493039; c=relaxed/simple;
	bh=fvpYkxi1ntd+aTGST8kdeMSZbhGgpKYv7jp1PIdP2hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNjkPNTpmfnF3ymAVnLwxj+atIzoQ0eifZd+KN0Vw3JJISl+3qoWju9wMNV4opBfEEYxIjw1rKfWNgoiF74Wl3NnX71mM3nPY25p8WoHj0YXj/csUnyyjQZbl2pNOGWcokxepNA8vCkiamHEUdP17JuvwTpOm+8xX1uaPtWHKS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pe623QCp; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721493036; x=1753029036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fvpYkxi1ntd+aTGST8kdeMSZbhGgpKYv7jp1PIdP2hk=;
  b=Pe623QCpWsLjXQW7ZE0TH2+pzRII6hGsNxipQapIWaWhw3kYf+5fWKbO
   EYOjKKfL5afhayf18QYzGQ9xt45onuwjiQywqye4CIpagPVAeGhgwPc1V
   utSY7LpfDQLQAu3X2jPSvmPyGzyidldHoteWPO2zJjAdOHrYi+fITK6JW
   XSJAjNyKTEjy0Zi2ctk2dzkplXAG7IYTBItXihWLEVYTrSt1UZINP9A/5
   5Bc+nuj18A7YM9gUXlGyILt6Db+1TgKho9LXCiS4YI+CV9wy0itVe/v3X
   IrPe5d9jYG3Gc1nNOsv0ljaqt0jUf7WvGLtSpLe3AMIFFe/r0hyg1HssO
   Q==;
X-CSE-ConnectionGUID: /v54POi0Tj++WpGsVWPTJw==
X-CSE-MsgGUID: 6mz4lvRVQkCC9utv7Ekfjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11139"; a="19230244"
X-IronPort-AV: E=Sophos;i="6.09,224,1716274800"; 
   d="scan'208";a="19230244"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2024 09:30:35 -0700
X-CSE-ConnectionGUID: c984HY8SQOWs3zCyXaZU1g==
X-CSE-MsgGUID: nrV7dPO2QQq0PPr7trxqMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,224,1716274800"; 
   d="scan'208";a="56261899"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 20 Jul 2024 09:30:34 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sVCyd-000jQ3-04;
	Sat, 20 Jul 2024 16:30:31 +0000
Date: Sun, 21 Jul 2024 00:30:12 +0800
From: kernel test robot <lkp@intel.com>
To: marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
	robh+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	marius.cristea@microchip.com
Subject: Re: [PATCH v1 2/2] iio: adc: adding support for PAC194X
Message-ID: <202407210028.rJXFbiBg-lkp@intel.com>
References: <20240719173855.53261-3-marius.cristea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719173855.53261-3-marius.cristea@microchip.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.10 next-20240719]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/marius-cristea-microchip-com/dt-bindings-iio-adc-adding-support-for-PAC194X/20240720-014249
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240719173855.53261-3-marius.cristea%40microchip.com
patch subject: [PATCH v1 2/2] iio: adc: adding support for PAC194X
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240721/202407210028.rJXFbiBg-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240721/202407210028.rJXFbiBg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407210028.rJXFbiBg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/adc/pac1944.c: In function 'pac1944_prep_custom_attributes':
>> drivers/iio/adc/pac1944.c:2048:23: warning: variable 'idx' set but not used [-Wunused-but-set-variable]
    2048 |         int ch, i, j, idx;
         |                       ^~~


vim +/idx +2048 drivers/iio/adc/pac1944.c

  2044	
  2045	static int pac1944_prep_custom_attributes(struct pac1944_chip_info *info,
  2046						  struct iio_dev *indio_dev)
  2047	{
> 2048		int ch, i, j, idx;
  2049		int active_channels_count = 0;
  2050		struct attribute **pac1944_custom_attrs, **tmp_attr;
  2051		struct attribute_group *pac1944_group;
  2052		int custom_attr_cnt;
  2053		struct i2c_client *client = info->client;
  2054	
  2055		for (i = 0 ; i < info->phys_channels; i++)
  2056			if (info->active_channels[i])
  2057				active_channels_count++;
  2058	
  2059		pac1944_group = devm_kzalloc(&client->dev, sizeof(*pac1944_group), GFP_KERNEL);
  2060		if (!pac1944_group)
  2061			return -ENOMEM;
  2062	
  2063		/*
  2064		 * Attributes for channel X:
  2065		 *	- in_shunt_value_X
  2066		 *	- in_oc_limit_nsamples
  2067		 *	- in_uc_limit_nsamples
  2068		 *	- in_op_limit_nsamples
  2069		 *	- in_ov_limit_nsamples
  2070		 *	- in_uv_limit_nsamples
  2071		 *	- one of pair attributes:
  2072		 *		- in_power_accX_raw and in_power_accX_scale
  2073		 *		- in_current_accX_raw and in_current_accX_scale
  2074		 *		- in_voltage_accX_raw and in_voltage_accX_scale
  2075		 * Shared attributes:
  2076		 *	- in_acc_fullness
  2077		 *	- in_alert_enable
  2078		 *	- in_slow_alert1
  2079		 *	- gpio_alert2
  2080		 *	- out_alert_status
  2081		 * NULL
  2082		 */
  2083		custom_attr_cnt = PAC1944_COMMON_DEVATTR * active_channels_count;
  2084		custom_attr_cnt += PAC1944_ACC_DEVATTR * active_channels_count;
  2085		custom_attr_cnt += PAC1944_SHARED_DEVATTRS_COUNT;
  2086	
  2087		pac1944_custom_attrs = devm_kzalloc(&client->dev, custom_attr_cnt *
  2088						    sizeof(*pac1944_group) + 1, GFP_KERNEL);
  2089		if (!pac1944_custom_attrs)
  2090			return -ENOMEM;
  2091	
  2092		j = 0;
  2093		for (ch = 0 ; ch < info->phys_channels; ch++) {
  2094			if (!info->active_channels[ch])
  2095				continue;
  2096	
  2097			for (i = 0; i < PAC1944_COMMON_DEVATTR; i++)
  2098				pac1944_custom_attrs[j++] =
  2099					pac1944_all_attrs[PAC1944_COMMON_DEVATTR * ch + i];
  2100	
  2101			idx = ch;
  2102			switch (info->chip_reg_data.accumulation_mode[ch]) {
  2103			case PAC1944_ACCMODE_VPOWER:
  2104				tmp_attr = pac1944_power_acc_attr;
  2105				break;
  2106			case PAC1944_ACCMODE_VSENSE:
  2107				tmp_attr = pac1944_current_acc_attr;
  2108				break;
  2109			case PAC1944_ACCMODE_VBUS:
  2110				tmp_attr = pac1944_voltage_acc_attr;
  2111				break;
  2112			default:
  2113				return -EINVAL;
  2114			}
  2115	
  2116			pac1944_custom_attrs[j++] = tmp_attr[ch];
  2117			pac1944_custom_attrs[j++] = pac1944_power_acc_attr[PAC1944_MAX_CH + ch];
  2118			pac1944_custom_attrs[j++] = pac1944_power_acc_attr[2 * PAC1944_MAX_CH + ch];
  2119		}
  2120	
  2121		for (i = 0; i < PAC1944_SHARED_DEVATTRS_COUNT; i++)
  2122			pac1944_custom_attrs[j++] =
  2123				pac1944_all_attrs[PAC1944_COMMON_DEVATTR * PAC1944_MAX_CH + i];
  2124	
  2125		pac1944_group->attrs = pac1944_custom_attrs;
  2126		info->iio_info.attrs = pac1944_group;
  2127	
  2128		return 0;
  2129	}
  2130	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

