Return-Path: <linux-iio+bounces-15501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B74A34C97
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 18:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36BE1624F6
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A417524166F;
	Thu, 13 Feb 2025 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nL7iWe8L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359E23A9BF;
	Thu, 13 Feb 2025 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469495; cv=none; b=G4475mm8US+cyKyMrM261TxiwrH1cNUkfFiEBlwtywTg/09PkNq9yZrFwoFRsHJn3oawRDctUmseq2oqEmLLD7fNATMaSZsr1iMcMk/d4KNzIVguXoPs7zfP2kTCpEWUyLT4FhjXUav9K6dJrWfZlgGvWYbamBfVEcKUB9t9Itk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469495; c=relaxed/simple;
	bh=xWOXLkZUDipVXkBEWn6lKA+dhIt25ilw4tSep9BV2AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iF5XwEfEQtoEXdfHW9Qot9GpFxvjTue+56M/kQU7D/QdyrvAjqjVgpGPUaQwkCrJSmYKTR0mqcQlrRS+ABy2vXOlWdk0aSy8q9NEs8bqeZHSnaNuvBjSi3jQIJDXIWR9s1KBe1wg0P22XT16d7sVhUFJGD3/VQ4N2pBKPgV3Fww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nL7iWe8L; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739469494; x=1771005494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xWOXLkZUDipVXkBEWn6lKA+dhIt25ilw4tSep9BV2AI=;
  b=nL7iWe8LRuaaE9XtsEcgHVtkJqusZwn078EcJfVJ1ID0soWE8WODa1du
   9N/sHArAJdd1KLeVrHkSVoTA9MO870iIGOgvrxcBdCk7lHiBLgY7U/VMq
   Cz8f8jRZpYXbDcpJtedBIZahWbcsERPBLqHVtQDp6Sj0qjziO8eqnFQ9j
   VH4OcLRO7uFH65/NsEXo0x8x9hC4I+RVR4V/HZw2fBYGn6vuvzZfghqQa
   AWAZGHQNoe+m5hz7QdLvSTFDcndqQwD4c/Ys8ZwV/yhBouowydsNRf2t1
   YMa4kg89l/IqwY0tqzLuvxcLvNZ01qEJVIjKnD8J0wGiLA31CymLIOeu6
   A==;
X-CSE-ConnectionGUID: 4S1JRYt2TK6htlOC44dRpA==
X-CSE-MsgGUID: LWXmXoRXSSWwfnjClGvfXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40066666"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="40066666"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 09:58:13 -0800
X-CSE-ConnectionGUID: xIa7/2r4Ru+OWWqzhiIL+w==
X-CSE-MsgGUID: FRsG1AacQQO4aUWK4apTMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="118223746"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Feb 2025 09:58:08 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tidTS-0018XD-0N;
	Thu, 13 Feb 2025 17:58:06 +0000
Date: Fri, 14 Feb 2025 01:57:30 +0800
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
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v7 3/6] iio: imu: adis: Add DIAG_STAT register
Message-ID: <202502140107.SF1UwFxM-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.14-rc2 next-20250213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Robert-Budai/iio-imu-adis-Add-custom-ops-struct/20250212-040235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250211175706.276987-4-robert.budai%40analog.com
patch subject: [PATCH v7 3/6] iio: imu: adis: Add DIAG_STAT register
config: arc-randconfig-r112-20250213 (https://download.01.org/0day-ci/archive/20250214/202502140107.SF1UwFxM-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250214/202502140107.SF1UwFxM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502140107.SF1UwFxM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/imu/adis.c:319:42: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned short [usertype] *val @@     got unsigned short [usertype] status_16 @@
   drivers/iio/imu/adis.c:319:42: sparse:     expected unsigned short [usertype] *val
   drivers/iio/imu/adis.c:319:42: sparse:     got unsigned short [usertype] status_16
>> drivers/iio/imu/adis.c:319:42: sparse: sparse: non size-preserving integer to pointer cast

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

