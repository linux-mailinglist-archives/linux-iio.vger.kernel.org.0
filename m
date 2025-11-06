Return-Path: <linux-iio+bounces-25933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9C4C3A8A1
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 12:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649541A44EDA
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 11:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F2430DEAC;
	Thu,  6 Nov 2025 11:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OeSnCLSe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7442F2E6100;
	Thu,  6 Nov 2025 11:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428167; cv=none; b=lHZXM8/sqCGqVylAhreOslC8Yrh/7Q1rp3A/p7mC+Z4AYX831X4b6qOIKib/z4LdJqbzrLUfv5jg+aTcgs7IDoMFRzgn8/Rua38tHe6NDTBGSLUAVRn71Jau79sfh7HFCXEhQgHRwHQeaMwB4VPEdOkAbgDBM2r4M3PY06pLBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428167; c=relaxed/simple;
	bh=zkwHK3b5vMwLHOx0l0YkcW7ODlRQaOEWOWExDCsjsas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ni/+UzOcg96svJ5IufhCuLTMPwKm10/LGY4hd8OzsBWg3sH+qXwd3C+cChtoXYBpqnaCeZCgojHuPdjEkjStibuOgccZEphFUsTVsF2g2BOxSM0BdOgXHi8q7t2anHmU2LLxg2fwpYncaJTTwfKLlJOh1iTkOc4eA0hiSsCE0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OeSnCLSe; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762428165; x=1793964165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zkwHK3b5vMwLHOx0l0YkcW7ODlRQaOEWOWExDCsjsas=;
  b=OeSnCLSeZz+/o7gs3Ba4bVFjPAKr/+poyIK0Sshp+4qvPgSy0BmLVHnf
   AuerIfiz8Fp/ecZb7SaonxSSGb8Mk9vlrgNT3Ca0IKZU2OysSf51I6L0j
   qKIyHI6Ce9hKIbPB6PgAZgHtUNqIcPF9ZBamigT9C0/GYUWGWI7FNziuT
   xzW0o2J3ZeQcUi4/v24V1zp0AFMTEghP82EAP0AF2ylispKQZ12mlMCmf
   5ytV69aAQCWxOma3q5eM0ew96p2yyGk8c0pP9dXoCbDvb7riJbUnZuGU4
   hiAwumDk0zMS8DWzQ0Deu3/dwrCgxODyfh8dEG5FA+e05zfhbDxhqHSg9
   w==;
X-CSE-ConnectionGUID: /cWk8qZCTKO4o3XzMfpVpQ==
X-CSE-MsgGUID: lYA2zf3TRCymHNywxiR5Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="68211078"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="68211078"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 03:22:45 -0800
X-CSE-ConnectionGUID: 2jKHIrhtQOKyMIc9ItT3Cw==
X-CSE-MsgGUID: ZsbU2kt0QZWbIj/4sSZBwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187021979"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 06 Nov 2025 03:22:41 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGy4Y-000Tpe-0C;
	Thu, 06 Nov 2025 11:22:35 +0000
Date: Thu, 6 Nov 2025 19:21:44 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	David Jander <david@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v1 2/2] iio: adc: Add TI ADS131M0x ADC driver
Message-ID: <202511061850.kYeqflcU-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.18-rc4 next-20251106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/bindings-iio-adc-Add-bindings-for-TI-ADS131M0x-ADCs/20251105-224149
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20251105143814.1807444-3-o.rempel%40pengutronix.de
patch subject: [PATCH v1 2/2] iio: adc: Add TI ADS131M0x ADC driver
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20251106/202511061850.kYeqflcU-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251106/202511061850.kYeqflcU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511061850.kYeqflcU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/adc/ti-ads131m0x.c:174:2: error: call to undeclared function 'put_unaligned_be24'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     174 |         put_unaligned_be24(command << 8, &priv->tx_buffer[0]);
         |         ^
   drivers/iio/adc/ti-ads131m0x.c:163:6: warning: unused variable 'ret' [-Wunused-variable]
     163 |         int ret;
         |             ^~~
>> drivers/iio/adc/ti-ads131m0x.c:224:11: error: call to undeclared function 'get_unaligned_be16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     224 |         status = get_unaligned_be16(&priv->rx_buffer[0]);
         |                  ^
   drivers/iio/adc/ti-ads131m0x.c:271:2: error: call to undeclared function 'put_unaligned_be24'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     271 |         put_unaligned_be24(command << 8, &priv->tx_buffer[0]);
         |         ^
   drivers/iio/adc/ti-ads131m0x.c:304:13: error: call to undeclared function 'get_unaligned_be16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     304 |         response = get_unaligned_be16(&priv->rx_buffer[0]);
         |                    ^
   drivers/iio/adc/ti-ads131m0x.c:376:9: error: call to undeclared function 'get_unaligned_be16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     376 |         *val = get_unaligned_be16(&priv->rx_buffer[0]);
         |                ^
   drivers/iio/adc/ti-ads131m0x.c:461:17: error: call to undeclared function 'get_unaligned_be16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     461 |         received_crc = get_unaligned_be16(&priv->rx_buffer[data_len]);
         |                        ^
   drivers/iio/adc/ti-ads131m0x.c:505:11: error: call to undeclared function 'get_unaligned_be16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     505 |         status = get_unaligned_be16(&priv->rx_buffer[0]);
         |                  ^
>> drivers/iio/adc/ti-ads131m0x.c:523:23: error: call to undeclared function 'get_unaligned_be24'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     523 |         *val = sign_extend32(get_unaligned_be24(buf), 23);
         |                              ^
   drivers/iio/adc/ti-ads131m0x.c:706:13: error: call to undeclared function 'get_unaligned_be16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     706 |         response = get_unaligned_be16(&priv->rx_buffer[0]);
         |                    ^
   1 warning and 9 errors generated.


vim +/put_unaligned_be24 +174 drivers/iio/adc/ti-ads131m0x.c

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
   163		int ret;
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
 > 174		put_unaligned_be24(command << 8, &priv->tx_buffer[0]);
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
   186	/**
   187	 * ads131m_rx_frame_unlocked - Receives a full SPI data frame.
   188	 * @priv: Device private data structure.
   189	 *
   190	 * This function sends a NULL command (with its CRC) to clock out a
   191	 * full SPI frame from the device (e.g., response + channel data + CRC).
   192	 *
   193	 * Assumes the mutex lock is held.
   194	 *
   195	 * Return: 0 on success, or a negative error code from spi_sync.
   196	 */
   197	static int ads131m_rx_frame_unlocked(struct ads131m_priv *priv)
   198	{
   199		return ads131m_tx_frame_unlocked(priv, ADS131M_CMD_NULL);
   200	}
   201	
   202	/**
   203	 * ads131m_check_status_crc_err - Checks for an Input CRC error.
   204	 * @priv: Device private data structure.
   205	 *
   206	 * Sends a NULL command to fetch the STATUS register and checks the
   207	 * CRC_ERR bit. This is used to verify the integrity of the previous
   208	 * command (like RREG or WREG).
   209	 *
   210	 * Context: This function assumes the mutex 'lock' is held.
   211	 * Return: 0 on success, -EIO if CRC_ERR bit is set.
   212	 */
   213	static int ads131m_check_status_crc_err(struct ads131m_priv *priv)
   214	{
   215		int ret;
   216		u16 status;
   217	
   218		ret = ads131m_rx_frame_unlocked(priv);
   219		if (ret < 0) {
   220			dev_err(&priv->spi->dev, "SPI error on STATUS read for CRC check\n");
   221			return ret;
   222		}
   223	
 > 224		status = get_unaligned_be16(&priv->rx_buffer[0]);
   225		if (status & ADS131M_STATUS_CRC_ERR) {
   226			dev_err(&priv->spi->dev, "Previous input CRC error, STATUS=0x%04x\n",
   227				status);
   228			return -EIO;
   229		}
   230	
   231		return 0;
   232	}
   233	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

