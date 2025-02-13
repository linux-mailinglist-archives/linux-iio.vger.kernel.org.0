Return-Path: <linux-iio+bounces-15482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9F8A33765
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 06:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EFE07A3A08
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 05:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E930206F0E;
	Thu, 13 Feb 2025 05:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHyYfqwR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4D986325;
	Thu, 13 Feb 2025 05:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739425308; cv=none; b=lMtneVRX55SI7/SYaRwsX5PzvATcDovR6tGTZuBloEPLrinmszof0i0lqNDeTR8/DqHXluyu8DAKrwOBZtoUQJMbd3mCJOuXSt1ftzJW5A2u+bebwxLFRnQzNl0MWK3jdJ3Q/Jg8HwIyNDt8I9xtw2vRfmD+N9t6Dj2J3BittSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739425308; c=relaxed/simple;
	bh=oqgEfI6+fwiW7tM2TZxu+ARiHQNbyOwzxrIpsof5wjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iF2I69B2UqaD+shy8n8a3bGW2YBF49ro9g2qutBa8RyH8SldgPVVWgxGAVvvI87ar8GTkay7l7hhXGABo84iur0f00zs0F6regsdwhVGFrPVJ+/5sn6uSe+VxCyi4bKSO6ciWPzyEDR3RMyZwu/IRhGdqcL9NZ/c6C6dOe8IEDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHyYfqwR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739425306; x=1770961306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oqgEfI6+fwiW7tM2TZxu+ARiHQNbyOwzxrIpsof5wjg=;
  b=WHyYfqwRpmfblXgEWxSPTGh27qsoWyC+e34s4KM2gG2so/+9DtSC53b3
   vq6qa0Hd/HHwyJtmvBAQn5l7XKDRGVDwJaE4mVsUABvZ/XI9juS0vf+81
   Wb5PI5eRSjfCOmo2SD5LgXoenKnEoTUEHb3Vtjm/49zTXaBEIwWtpexqC
   GBWtZdM15xC1HIKHR3bclqLA6ucgmMqOsuZmpwESE6c68Jf/6yRDbopGN
   m2AU5WmzTgdNB4UGuQOS9D2hYiSJVeljbG1Lx7hgeKkYwUWuVOMzcSq33
   QFmKuMZOTqur4+jgHiYtj78oOLwWdmXLfJA3J3XmPvkRIMVIk8UQkizjt
   w==;
X-CSE-ConnectionGUID: ggfIn0unRT6m6oxF7xmLpw==
X-CSE-MsgGUID: SgZeTyc6RhyBN1ZHD0+VOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="40236586"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40236586"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 21:41:45 -0800
X-CSE-ConnectionGUID: yPMmWeO3S/ic5Kih1MRnsQ==
X-CSE-MsgGUID: LkV5tS47Tz6JXL+GZIx16Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112884446"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 12 Feb 2025 21:41:38 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiRyi-0016Zr-0V;
	Thu, 13 Feb 2025 05:41:36 +0000
Date: Thu, 13 Feb 2025 13:40:40 +0800
From: kernel test robot <lkp@intel.com>
To: Robert Budai <robert.budai@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v7 3/6] iio: imu: adis: Add DIAG_STAT register
Message-ID: <202502131358.EsqgzVi7-lkp@intel.com>
References: <20250211175706.276987-4-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211175706.276987-4-robert.budai@analog.com>

Hi Robert,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.14-rc2 next-20250212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Robert-Budai/iio-imu-adis-Add-custom-ops-struct/20250212-040235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250211175706.276987-4-robert.budai%40analog.com
patch subject: [PATCH v7 3/6] iio: imu: adis: Add DIAG_STAT register
config: i386-buildonly-randconfig-002-20250213 (https://download.01.org/0day-ci/archive/20250213/202502131358.EsqgzVi7-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250213/202502131358.EsqgzVi7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502131358.EsqgzVi7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/imu/adis.c:319:7: error: incompatible integer to pointer conversion passing 'u16' (aka 'unsigned short') to parameter of type 'u16 *' (aka 'unsigned short *'); take the address with & [-Wint-conversion]
     319 |                                          status_16);
         |                                          ^~~~~~~~~
         |                                          &
   include/linux/iio/imu/adis.h:225:15: note: passing argument to parameter 'val' here
     225 |                                      u16 *val)
         |                                           ^
   1 error generated.


vim +319 drivers/iio/imu/adis.c

   298	
   299	/**
   300	 * __adis_check_status() - Check the device for error conditions (unlocked)
   301	 * @adis: The adis device
   302	 *
   303	 * Returns 0 on success, a negative error code otherwise
   304	 */
   305	int __adis_check_status(struct adis *adis)
   306	{
   307		unsigned int status;
   308		int diag_stat_bits;
   309		u16 status_16;
   310		int ret;
   311		int i;
   312	
   313		if (adis->data->diag_stat_size)
   314			ret = adis->ops->read(adis, adis->data->diag_stat_reg, &status,
   315					      adis->data->diag_stat_size);
   316		else
   317		{
   318			ret = __adis_read_reg_16(adis, adis->data->diag_stat_reg,
 > 319						 status_16);
   320			status = status_16;
   321		}
   322		if (ret)
   323			return ret;
   324	
   325		status &= adis->data->status_error_mask;
   326	
   327		if (status == 0)
   328			return 0;
   329	
   330		diag_stat_bits = BITS_PER_BYTE * (adis->data->diag_stat_size ?
   331						  adis->data->diag_stat_size : 2);
   332	
   333		for (i = 0; i < diag_stat_bits; ++i) {
   334			if (status & BIT(i)) {
   335				dev_err(&adis->spi->dev, "%s.\n",
   336					adis->data->status_error_msgs[i]);
   337			}
   338		}
   339	
   340		return -EIO;
   341	}
   342	EXPORT_SYMBOL_NS_GPL(__adis_check_status, "IIO_ADISLIB");
   343	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

