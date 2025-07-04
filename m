Return-Path: <linux-iio+bounces-21352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFE1AF956D
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 16:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE425A634B
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 14:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F781C8621;
	Fri,  4 Jul 2025 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKgRU8Hc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03F71C84AB;
	Fri,  4 Jul 2025 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751639047; cv=none; b=OfE6D8Ilp8r9l6hThiFP9y6Nodr5lMrESdtOKYO1Qm+PoxAsK0DP4/2O9Bwn1J1GFlhBpoYlLeeVvGeDPsoRr94YNBkNtt7EAX40/GUODqb9aihqfLm0mMvsMl6gE8Tu7WXGZd8XBqUQf+/bIAW9I9G31KSBZrD63+iaOeYKJTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751639047; c=relaxed/simple;
	bh=gqGr7YMNSNGMmPO5TwyjCTxRgNuwtUce0xo5IGee5Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIREuFqk/HdeBpHa8Gf+TlctmsR3JX6zCCHbPg0gJY2VUOFFx8i/jVjs3Y8uco9s0X4csGrvnYirSsBf26BfmY8luAIpmR9KGj4jWUH6oip+eOVkqbF5XMaHhC9GUyyNQVo/TZzLq6k2lSXmuZZUp7bNHK5ktKJ2G9XRs125GwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKgRU8Hc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751639046; x=1783175046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gqGr7YMNSNGMmPO5TwyjCTxRgNuwtUce0xo5IGee5Nc=;
  b=NKgRU8HcQskjes1wfy0m/h6Wj7TlCFjDNOthhB/qfDa/msyUKNY7aQyj
   azJ8wlGS7aJz/zo9WkWv3plUUOnhNrEOQ3uJvhSbZFTWXXK5Cr5PmdvHj
   IZ3rkIvujL8REPUjhrU217xmfRSIDmsxLT4rpgM9Hh+Nm9q+HMfsTCNfq
   oAN6fVRoxdnbuzObYIERjGXBf+UBrC283weDKNHyyMhKDrn3HiI0yucXL
   vL91leTZLrVVLex7cK6O1tNX/Z10ueNZCbVKXD/0WwgNj1Y9HjZ993/I/
   bjHhYEUX0r1F33v6AEbECtdu1QbuUeDyYpKw+fDA2Y/HWgJa0kHBNvujl
   g==;
X-CSE-ConnectionGUID: S2Yd6CuoSh+9MgRlTFXLfQ==
X-CSE-MsgGUID: Ay03D01YR0mGvZPPMFOUSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="53846979"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="53846979"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 07:24:05 -0700
X-CSE-ConnectionGUID: 4S/0i2I+QNCR9MadHUaojw==
X-CSE-MsgGUID: pT61i3k+SwGGxvI3+kg+qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="154078646"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Jul 2025 07:24:02 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXhKZ-0003nH-1p;
	Fri, 04 Jul 2025 14:23:59 +0000
Date: Fri, 4 Jul 2025 22:23:31 +0800
From: kernel test robot <lkp@intel.com>
To: Jianping.Shen@de.bosch.com, jic23@kernel.org, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dima.fedrau@gmail.com, marcelo.schmitt1@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christian.Lorenz3@de.bosch.com,
	Ulrike.Frauendorf@de.bosch.com, Kai.Dolde@de.bosch.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 2/2] iio: imu: smi330: Add driver
Message-ID: <202507042238.UDo16CzT-lkp@intel.com>
References: <20250703153823.806073-3-Jianping.Shen@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703153823.806073-3-Jianping.Shen@de.bosch.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.16-rc4 next-20250704]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jianping-Shen-de-bosch-com/dt-bindings-iio-imu-smi330-Add-binding/20250703-234441
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250703153823.806073-3-Jianping.Shen%40de.bosch.com
patch subject: [PATCH v3 2/2] iio: imu: smi330: Add driver
config: microblaze-randconfig-r073-20250704 (https://download.01.org/0day-ci/archive/20250704/202507042238.UDo16CzT-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250704/202507042238.UDo16CzT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507042238.UDo16CzT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/imu/smi330/smi330_i2c.c: In function 'smi330_regmap_i2c_read':
>> drivers/iio/imu/smi330/smi330_i2c.c:26:11: warning: unused variable 'retry' [-Wunused-variable]
     int ret, retry;
              ^~~~~


vim +/retry +26 drivers/iio/imu/smi330/smi330_i2c.c

    20	
    21	static int smi330_regmap_i2c_read(void *context, const void *reg_buf,
    22					  size_t reg_size, void *val_buf,
    23					  size_t val_size)
    24	{
    25		struct smi330_i2c_priv *priv = context;
  > 26		int ret, retry;
    27	
    28		/*
    29		 * SMI330 I2C read frame:
    30		 * <Slave address[6:0], RnW> <x, Register address[6:0]>
    31		 * <Slave address[6:0], RnW> <Dummy[7:0]> <Dummy[7:0]> <Data_0[7:0]> <Data_1[15:8]>...
    32		 *                                                     <Data_N[7:0]> <Data_N[15:8]>
    33		 * Remark: Slave address is not considered part of the frame in the following definitions
    34		 */
    35		struct i2c_msg msgs[] = {
    36			{
    37				.addr = priv->i2c->addr,
    38				.flags = priv->i2c->flags,
    39				.len = reg_size,
    40				.buf = (u8 *)reg_buf,
    41			},
    42			{
    43				.addr = priv->i2c->addr,
    44				.flags = priv->i2c->flags | I2C_M_RD,
    45				.len = SMI330_NUM_DUMMY_BYTES + val_size,
    46				.buf = priv->rx_buffer,
    47			},
    48		};
    49	
    50		ret = i2c_transfer(priv->i2c->adapter, msgs, ARRAY_SIZE(msgs));
    51		if (ret < 0)
    52			return ret;
    53	
    54		memcpy(val_buf, priv->rx_buffer + SMI330_NUM_DUMMY_BYTES, val_size);
    55	
    56		return 0;
    57	}
    58	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

