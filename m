Return-Path: <linux-iio+bounces-25927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6E6C39771
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 08:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BAD14EEFFE
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 07:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858CF2FB98A;
	Thu,  6 Nov 2025 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tf8iondg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FC92F99B3;
	Thu,  6 Nov 2025 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415655; cv=none; b=IRcBprdm1UVkIV05Y+OU+jVSeSAO/ZsRIIUWnBTJv/e0iFVnyFdjTXCgpbQF7pofbaMxRvvHzuO39KLG2ZKESDHyp4csC1A9BZQ0wnJvD6IO4kmjoABiZm6Li3pI4y5k6pr/vFzOLrBTK04uZyJqpIlwk0w2og822LFB51SC16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415655; c=relaxed/simple;
	bh=wLTcaw1m6btdqc59dnevnaF+89zVaFxE6n2I5MrHVDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr/cHYcfyr9d72SeL23eFkKEtSY0TrVOPZLUWv+PzlHsVzl+LO5/5oOk2F564P6x8sJdJ3BryLSCJHrkIUKjeRdPonelUa0iA324sbzSt8X4KWw6tvf5BHr5BMJua9aYPwiv4oxVD014+QsEJJqUI8JBdGToYB921i+l3taEx3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tf8iondg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762415654; x=1793951654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wLTcaw1m6btdqc59dnevnaF+89zVaFxE6n2I5MrHVDk=;
  b=Tf8iondgAGL6uBUxbG083gdF2TGHlLFdRinItuN16Fm7GJnP5UMSx9+m
   9lOkQGYlmFKGugye5tegMRgj9DrgOQveBTIg/ZcWoTy6zpAUTCih27kYC
   WEZf61bCfgfK4JTyHcX3rjTbnvdEeZHZLbRleGxmGbaOCyZVJ7O97Dx4Q
   mRZmGt5YlnWPfY5mD2rhPai1RhdoT5q7sjekVuz1N47DOy1JnGQgxNf6+
   F49sw8h7bQtsmMM9GXt41hq4vVuqH2b1rTZo8Vuwg0C9123W/0ratxNyD
   fG30/EzCCOAKQlrEYkDyZCDlvLTd28ofY86XA/x6j2Y2Zdkb5FdaYWtRZ
   g==;
X-CSE-ConnectionGUID: xk84Q9lqT0GAbl7xNcPiCQ==
X-CSE-MsgGUID: uikBgEkrTw6T8qBOO3dfLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75661060"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="75661060"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 23:54:12 -0800
X-CSE-ConnectionGUID: 19OIuhVhTpuH4d+3goeaBA==
X-CSE-MsgGUID: GzWa9EeyRnGyWnJMgq+T0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187852599"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 05 Nov 2025 23:54:08 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGuon-000Td2-37;
	Thu, 06 Nov 2025 07:54:05 +0000
Date: Thu, 6 Nov 2025 15:53:18 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, David Jander <david@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v1 2/2] iio: adc: Add TI ADS131M0x ADC driver
Message-ID: <202511061504.VlK7FeXK-lkp@intel.com>
References: <20251105143814.1807444-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105143814.1807444-3-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.18-rc4 next-20251106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/bindings-iio-adc-Add-bindings-for-TI-ADS131M0x-ADCs/20251105-224149
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20251105143814.1807444-3-o.rempel%40pengutronix.de
patch subject: [PATCH v1 2/2] iio: adc: Add TI ADS131M0x ADC driver
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20251106/202511061504.VlK7FeXK-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251106/202511061504.VlK7FeXK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511061504.VlK7FeXK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/adc/ti-ads131m0x.c: In function 'ads131m_tx_frame_unlocked':
   drivers/iio/adc/ti-ads131m0x.c:174:9: error: implicit declaration of function 'put_unaligned_be24' [-Wimplicit-function-declaration]
     174 |         put_unaligned_be24(command << 8, &priv->tx_buffer[0]);
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/ti-ads131m0x.c:163:13: warning: unused variable 'ret' [-Wunused-variable]
     163 |         int ret;
         |             ^~~
   drivers/iio/adc/ti-ads131m0x.c: In function 'ads131m_check_status_crc_err':
   drivers/iio/adc/ti-ads131m0x.c:224:18: error: implicit declaration of function 'get_unaligned_be16' [-Wimplicit-function-declaration]
     224 |         status = get_unaligned_be16(&priv->rx_buffer[0]);
         |                  ^~~~~~~~~~~~~~~~~~
   drivers/iio/adc/ti-ads131m0x.c: In function 'ads131m_adc_read':
   drivers/iio/adc/ti-ads131m0x.c:523:30: error: implicit declaration of function 'get_unaligned_be24' [-Wimplicit-function-declaration]
     523 |         *val = sign_extend32(get_unaligned_be24(buf), 23);
         |                              ^~~~~~~~~~~~~~~~~~


vim +/ret +163 drivers/iio/adc/ti-ads131m0x.c

   149	
   150	/**
   151	 * ads131m_tx_frame_unlocked - Sends a command frame with Input CRC
   152	 * @priv: Device private data structure.
   153	 * @command: The 16-bit command to send (e.g., NULL, RREG, RESET).
   154	 *
   155	 * Assumes the mutex lock is held.
   156	 * This function sends a command in Word 0, and its calculated 16-bit
   157	 * CRC in Word 1, as required when Input CRC is enabled.
   158	 *
   159	 * Return: 0 on success, or a negative error code from spi_sync.
   160	 */
   161	static int ads131m_tx_frame_unlocked(struct ads131m_priv *priv, u32 command)
   162	{
 > 163		int ret;
   164		u16 crc;
   165	
   166		/*
   167		 * Zero the entire TX buffer to send a valid frame.
   168		 */
   169		memset(priv->tx_buffer, 0, ADS131M_FRAME_BSIZE(priv->num_channels));
   170	
   171		/*
   172		 * Word 0: 16-bit command, MSB-aligned in 24-bit word.
   173		 */
   174		put_unaligned_be24(command << 8, &priv->tx_buffer[0]);
   175	
   176		/*
   177		 * Word 1: Input CRC
   178		 * Calculated over the 3 bytes of Word 0.
   179		 */
   180		crc = ads131m_crc_calculate(priv->tx_buffer, 3);
   181		put_unaligned_be24(crc << 8, &priv->tx_buffer[3]);
   182	
   183		return spi_sync(priv->spi, &priv->msg);
   184	}
   185	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

