Return-Path: <linux-iio+bounces-17005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D4EA66B14
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 08:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643363BAE5D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 07:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFF71E5211;
	Tue, 18 Mar 2025 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBLvAm1f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C1A1B85D1;
	Tue, 18 Mar 2025 07:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742281601; cv=none; b=Ag21KYEaKqpqK9/dFHP6n8kyK4Bbf0dhugUceAskzsveYWW50WqOyXwmX2Zk/ofDwzL8tVoXM3FargIVZf+i135EiFnih63Yfz0mRXMNjNEid4wre0qzdfhfysMnGSk4xWuNhbZd5kebLka8hI6E/SR81AdawMZLfIltWK/7rQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742281601; c=relaxed/simple;
	bh=zxqH3xeUbDQOKP/oSRJqCK2Og1nSrTKOo8t1/XelZSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYhr36Gh424gEci3OKUuPoAzdhyTwQbJdXRtgqYJnhDiE6IW7K3iPP4HKn78fV0IhDJjdapvnM1KUYdpAfk+ICdCAQuieoirveXIqctnDPDfcfPLWiC2gzdbeGjXB2lEi8YJw5VyYGQwfObLFAKopkmuQac7hoY3na1ZH12+HYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBLvAm1f; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742281600; x=1773817600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zxqH3xeUbDQOKP/oSRJqCK2Og1nSrTKOo8t1/XelZSc=;
  b=FBLvAm1f8HtQ95r47iH9soe4Dt3ZveiuyMvC2SVboTUu65BbCJIjm34I
   xwqXPxumRg3SKgcbTM68jolIgVAqwLgmDYaN3/dcRWjOHepgZd4ziQssE
   5tgJbNKpjIePXugZUi66kBy7ZWnD39ByWEYKnm7Mp5CEwcZKpqHR2VNHE
   OLE1aB63IiDWZYxnWeCfoa/wfB4LqKyZn9KWz2xZc+DRIooF5BVqLL9iC
   PC0v3GxNv2vERw1A8L1IP8jxm3RVYp3Cgi2z/bjHg5i3vpohj0H0aC3hc
   pkSQFpA5DDxGV7rXaOex7K0+BqmGCidswPyq7omGkbF8S+tp1XpgOZIqo
   w==;
X-CSE-ConnectionGUID: 5+JIyEVlRtmhTxXIccyekQ==
X-CSE-MsgGUID: coZDMVDXQsimmrrqsB9IBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43574139"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="43574139"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 00:06:39 -0700
X-CSE-ConnectionGUID: 2KW5WRaCT8O5mE4K6gyaAw==
X-CSE-MsgGUID: Flmk+8nlQN+om6CToQQJBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="127274825"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 18 Mar 2025 00:06:37 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuR22-000DUq-1U;
	Tue, 18 Mar 2025 07:06:34 +0000
Date: Tue, 18 Mar 2025 15:05:53 +0800
From: kernel test robot <lkp@intel.com>
To: marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
	robh@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, krzk+dt@kernel.org, conor+dt@kernel.org,
	oskar.andero@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	marius.cristea@microchip.com
Subject: Re: [PATCH v2 2/2] iio: adc: adding support for PAC194X
Message-ID: <202503181451.vybqC7U2-lkp@intel.com>
References: <20250317090803.30003-3-marius.cristea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317090803.30003-3-marius.cristea@microchip.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 577a66e2e634f712384c57a98f504c44ea4b47da]

url:    https://github.com/intel-lab-lkp/linux/commits/marius-cristea-microchip-com/dt-bindings-iio-adc-adding-support-for-PAC194X/20250317-171150
base:   577a66e2e634f712384c57a98f504c44ea4b47da
patch link:    https://lore.kernel.org/r/20250317090803.30003-3-marius.cristea%40microchip.com
patch subject: [PATCH v2 2/2] iio: adc: adding support for PAC194X
config: sparc-randconfig-r073-20250318 (https://download.01.org/0day-ci/archive/20250318/202503181451.vybqC7U2-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250318/202503181451.vybqC7U2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503181451.vybqC7U2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/pac1944.c:614: warning: Function parameter or struct member 'active_channels_mask' not described in 'pac1944_chip_info'


vim +614 drivers/iio/adc/pac1944.c

   546	
   547	/**
   548	 * struct pac1944_chip_info - chip configuration
   549	 * @channels: array of values, true means that channel is active
   550	 * @iio_info: pointer to iio_info structure
   551	 * @client: a pointer to the i2c client associated with the device
   552	 * @lock: lock to prevent concurrent reads/writes
   553	 * @work_chip_rfsh: chip refresh workqueue implementation
   554	 * @phys_channels: number of physical channels for the device
   555	 * @active_channels: array of values, true means that channel is active
   556	 * @chip_variant: stores the type of the device
   557	 * @chip_revision: store the silicon revision version of the device
   558	 * @shunts: array of values, shunt resistor values
   559	 * @chip_reg_data: pointer to structure, containing data from the device registers
   560	 * @sample_rate_value: sampling frequency
   561	 * @labels: array of string, name of each channel
   562	 * @is_pac195x_family: true if device is part of the PAC195x family
   563	 * @sampling_mode: sampling mode used by the device
   564	 * @num_enabled_channels: count of how many chip channels are currently enabled
   565	 * @slow_alert1: snapshot of slow/alert register
   566	 * @gpio_alert2: snapshot of gpio/alert register
   567	 * @acc_fullness: snapshot of accumulator fullness limit register
   568	 * @overcurrent: array of values, overcurrent limit
   569	 * @undercurrent: array of values, undercurrent limit
   570	 * @overpower: array of values, overpower limit
   571	 * @overvoltage:  array of values, overvoltage limit
   572	 * @undervoltage: array of values, undervoltage limit
   573	 * @oc_limit_nsamples: number of consecutive samples exceeding the overcurrent limit
   574	 * @uc_limit_nsamples: number of consecutive samples exceeding the undercurrent limit
   575	 * @op_limit_nsamples: number of consecutive samples exceeding the overpower limit
   576	 * @ov_limit_nsamples: number of consecutive samples exceeding the overvoltage limit
   577	 * @uv_limit_nsamples: number of consecutive samples exceeding the undervoltage limit
   578	 * @alert_enable: snapshot of alert enable register
   579	 * @enable_acc: array of values, true means that accumulation channel is measured
   580	 */
   581	struct pac1944_chip_info {
   582		const struct iio_chan_spec  *channels;
   583		struct iio_info		iio_info;
   584		struct i2c_client	*client;
   585		struct mutex		lock; /* lock to prevent concurrent reads/writes */
   586		struct delayed_work	work_chip_rfsh;
   587		u8		phys_channels;
   588		bool		active_channels[PAC1944_MAX_CH];
   589		unsigned long	active_channels_mask;
   590		u8		chip_variant;
   591		u8		chip_revision;
   592		u32		shunts[PAC1944_MAX_CH];
   593		struct reg_data chip_reg_data;
   594		s32		sample_rate_value;
   595		char		*labels[PAC1944_MAX_CH];
   596		bool		is_pac195x_family;
   597		u8		sampling_mode;
   598		u8		num_enabled_channels;
   599		u32		slow_alert1;
   600		u32		gpio_alert2;
   601		u16		acc_fullness;
   602		u16		overcurrent[PAC1944_MAX_CH];
   603		u16		undercurrent[PAC1944_MAX_CH];
   604		u32		overpower[PAC1944_MAX_CH];
   605		u16		overvoltage[PAC1944_MAX_CH];
   606		u16		undervoltage[PAC1944_MAX_CH];
   607		u8		oc_limit_nsamples[PAC1944_MAX_CH];
   608		u8		uc_limit_nsamples[PAC1944_MAX_CH];
   609		u8		op_limit_nsamples[PAC1944_MAX_CH];
   610		u8		ov_limit_nsamples[PAC1944_MAX_CH];
   611		u8		uv_limit_nsamples[PAC1944_MAX_CH];
   612		u32		alert_enable;
   613		bool		enable_acc[PAC1944_MAX_CH];
 > 614	};
   615	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

