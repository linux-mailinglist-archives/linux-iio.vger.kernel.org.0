Return-Path: <linux-iio+bounces-11509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1D29B3980
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 19:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8C9282A1F
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 18:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569A61DFD9A;
	Mon, 28 Oct 2024 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QoyRPetv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C629D1DF266;
	Mon, 28 Oct 2024 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141184; cv=none; b=pkEDIpP+5Tm5yJ5lnNFLBSCwT41IPMZJM0dMK/LkV8Pl77m5hwQFukAosG5oB3inrGHXLoUWPzu/1iVA2tJTtWCGN5FwVHTyz2cY/RVYbyfrw11kANc7QDGazgzqQNjTIFHwN1xPi6zQ64hdzXkJ+FkH55O/MtM3oRPnc7wTgC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141184; c=relaxed/simple;
	bh=Mi2KXKb3PyhUWWozDIY/T8+M7BQ7ph3X6eml81ZMdqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdbaPVk9m1Mq5jFZuATtECyMvOBEtNGe7iC+OiyzcVgnO854avGrEcAyX4rbfZXx4PCPq9eIB8znKrzaJZwv5KTJrHLkC1YM3M1CmEtmqy5zkhK3c13enL5V+VwqeHiLMMtiFzKm4L0xNbPNWiDuN6XPzs8zQtv7XrXkz32jYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QoyRPetv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730141182; x=1761677182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mi2KXKb3PyhUWWozDIY/T8+M7BQ7ph3X6eml81ZMdqQ=;
  b=QoyRPetvQTrtgBKJAXvTpmDzBrPWyAgc2qAb1nApifGUfZsOr4JwO+5U
   XxqPJ72BPz13DavLU4mTufNOkQ8Dk84KYgV2M3WReIUnjdrNtxLC1J+Mc
   DObtlyfYmChfSwR3DZ1IyhVuP5d/9NfYuy0+PfpxMBZBmqPBTNTFstu9+
   yq79fjwSUkX3AfwUk6Z+KiSm2lHb2rRcU6SIadDYkGe3MpdrJudXwyqxQ
   j6Ci9xM5ZuoGu7FNvUcup7LF4c/roFpaKJThaBd8bnrVyPsNZsQ3OXV9x
   KartYrpbzv8j3T60iFi8TiK3c19uXPPl+6Jfk1u506SIBojZCniU1pp9+
   A==;
X-CSE-ConnectionGUID: QRSQ3NEvSZmI4eDTrb39Ow==
X-CSE-MsgGUID: JETdM3qHSjGLYPBnNuLVuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29865608"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="29865608"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 11:46:21 -0700
X-CSE-ConnectionGUID: 67Om+RPEQxel+zdJYLzSaA==
X-CSE-MsgGUID: rsY3TZVoQuugojYixRCiRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="86840968"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 28 Oct 2024 11:46:18 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5Ukp-000clE-1Y;
	Mon, 28 Oct 2024 18:46:15 +0000
Date: Tue, 29 Oct 2024 02:46:03 +0800
From: kernel test robot <lkp@intel.com>
To: ahaslam@baylibre.com, lars@metafoo.de, Michael.Hennerich@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH 4/6] iio: dac: ad5791: Add reset, clr and ldac gpios
Message-ID: <202410290242.TjrDXcKG-lkp@intel.com>
References: <20241028071118.699951-5-ahaslam@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028071118.699951-5-ahaslam@baylibre.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.12-rc5 next-20241028]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ahaslam-baylibre-com/dt-bindings-iio-dac-ad5791-Add-optional-reset-clr-and-ldac-gpios/20241028-151319
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20241028071118.699951-5-ahaslam%40baylibre.com
patch subject: [PATCH 4/6] iio: dac: ad5791: Add reset, clr and ldac gpios
config: parisc-randconfig-r071-20241028 (https://download.01.org/0day-ci/archive/20241029/202410290242.TjrDXcKG-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241029/202410290242.TjrDXcKG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410290242.TjrDXcKG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/dac/ad5791.c:72: warning: Function parameter or struct member 'name' not described in 'ad5791_chip_info'
   drivers/iio/dac/ad5791.c:72: warning: Function parameter or struct member 'channel' not described in 'ad5791_chip_info'
>> drivers/iio/dac/ad5791.c:105: warning: Function parameter or struct member 'gpio_reset' not described in 'ad5791_state'
>> drivers/iio/dac/ad5791.c:105: warning: Function parameter or struct member 'gpio_clear' not described in 'ad5791_state'
>> drivers/iio/dac/ad5791.c:105: warning: Function parameter or struct member 'gpio_ldac' not described in 'ad5791_state'


vim +105 drivers/iio/dac/ad5791.c

20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   73  
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   74  /**
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   75   * struct ad5791_state - driver instance specific data
ff96bf519acdb3 drivers/iio/dac/ad5791.c         Peter Meerwald     2014-12-06   76   * @spi:			spi_device
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   77   * @reg_vdd:		positive supply regulator
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   78   * @reg_vss:		negative supply regulator
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   79   * @chip_info:		chip model specific constants
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   80   * @vref_mv:		actual reference voltage used
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   81   * @vref_neg_mv:	voltage of the negative supply
0071aa300271a4 drivers/iio/dac/ad5791.c         zuoqilin           2021-01-28   82   * @ctrl:		control register cache
3b1c0b129590d7 drivers/iio/dac/ad5791.c         Lee Jones          2020-07-16   83   * @pwr_down_mode:	current power down mode
3b1c0b129590d7 drivers/iio/dac/ad5791.c         Lee Jones          2020-07-16   84   * @pwr_down:		true if device is powered down
3b1c0b129590d7 drivers/iio/dac/ad5791.c         Lee Jones          2020-07-16   85   * @data:		spi transfer buffers
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   86   */
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   87  struct ad5791_state {
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   88  	struct spi_device		*spi;
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   89  	struct regulator		*reg_vdd;
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   90  	struct regulator		*reg_vss;
fcc5d80fd09f4c drivers/iio/dac/ad5791.c         Axel Haslam        2024-10-28   91  	struct gpio_desc		*gpio_reset;
fcc5d80fd09f4c drivers/iio/dac/ad5791.c         Axel Haslam        2024-10-28   92  	struct gpio_desc		*gpio_clear;
fcc5d80fd09f4c drivers/iio/dac/ad5791.c         Axel Haslam        2024-10-28   93  	struct gpio_desc		*gpio_ldac;
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   94  	const struct ad5791_chip_info	*chip_info;
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   95  	unsigned short			vref_mv;
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   96  	unsigned int			vref_neg_mv;
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   97  	unsigned			ctrl;
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   98  	unsigned			pwr_down_mode;
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04   99  	bool				pwr_down;
791bb52a0cd2cc drivers/iio/dac/ad5791.c         Lars-Peter Clausen 2013-11-25  100  
791bb52a0cd2cc drivers/iio/dac/ad5791.c         Lars-Peter Clausen 2013-11-25  101  	union {
791bb52a0cd2cc drivers/iio/dac/ad5791.c         Lars-Peter Clausen 2013-11-25  102  		__be32 d32;
791bb52a0cd2cc drivers/iio/dac/ad5791.c         Lars-Peter Clausen 2013-11-25  103  		u8 d8[4];
b2d5e9de77c877 drivers/iio/dac/ad5791.c         Jonathan Cameron   2022-05-08  104  	} data[3] __aligned(IIO_DMA_MINALIGN);
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04 @105  };
20374d1a36df3e drivers/staging/iio/dac/ad5791.c Lars-Peter Clausen 2012-06-04  106  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

