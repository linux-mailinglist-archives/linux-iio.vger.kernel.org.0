Return-Path: <linux-iio+bounces-15480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366F8A33675
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 04:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F0E3A6DC3
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 03:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A7A2054F2;
	Thu, 13 Feb 2025 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzuV7ZSX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F93B158524;
	Thu, 13 Feb 2025 03:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739418992; cv=none; b=jQEYKdbbXUKLtD6cVOn3DXO8lB/o3JhXHyOEBkB8PMJWqudQPCpeCoyCwhCtvfELdtaEAfF9jO2JY9Ds9+vcmrNcNIGYsg3nUN4t6L3yt6cabv83MEkPQQVqWYDO8wjQ2PYK+hRdI6Wyl5pwjVid15pEnSmlKyEWk5ZLjmuhJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739418992; c=relaxed/simple;
	bh=86TVOzPXfe0Uti/VuE/NXi2zKA0oTxee60/qK9YDvWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rh73mlPYOXwD5nVm36YyY47QEaDsSFQ/2J2e7KFHLIzxjPtHrfZ5mi7lDzLEGgskT6+UUo16lUSAeQWVAL9M9n8kVxZoSpjhQmLkUigCfbQqyTq2YvOU3VVX46estFxZ6QGq4N8774iSGe754tSzkegP8On9JGT7Nwj0iWcJj8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzuV7ZSX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739418991; x=1770954991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=86TVOzPXfe0Uti/VuE/NXi2zKA0oTxee60/qK9YDvWY=;
  b=jzuV7ZSXkFAR+MyoYqD7zVceQD90hW79mlN2JiW7gqBixawR9zWpGt5a
   2KaIQcXx5qoxMGuWr3iZZpj1B6bUp7BaPyMEUeuT8TvA6UZgkBgXkIwxc
   +bBrFUf9QCtHkabnnY7rRmrEhfyfKF6gdL1TLkmGa76ryJeHraSWYjNJl
   pOyFHOkm36VNWwy8XodiMWJVQd+6zEMzxgWp/AeklCSsTLvk2HlRtP7Ju
   XluimtyabmoPzNNCQ/AK6rl3+6YGpRuUBVEz9XpXiWuwfpRG1QEucI22D
   msGHY7uQ+ASJ/oBg9sczfIoj8eZRkoHiV0Xkyk6zKT2IBbSYGMIl5XEoc
   Q==;
X-CSE-ConnectionGUID: Qu5dS8xdRUqIa0+qXeG3ng==
X-CSE-MsgGUID: 96ZvrqdARiqisyStcqDJOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="43875992"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="43875992"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 19:56:30 -0800
X-CSE-ConnectionGUID: /WKVDQ8QTZmIJkKFEpYYTQ==
X-CSE-MsgGUID: SKBb+fb3S/GmRV+qvr8qXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117641992"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 12 Feb 2025 19:56:25 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiQKt-0016UN-0z;
	Thu, 13 Feb 2025 03:56:23 +0000
Date: Thu, 13 Feb 2025 11:55:35 +0800
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
Message-ID: <202502131146.rXrTvgZr-lkp@intel.com>
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
[also build test WARNING on linus/master v6.14-rc2 next-20250212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Robert-Budai/iio-imu-adis-Add-custom-ops-struct/20250212-040235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20250211175706.276987-4-robert.budai%40analog.com
patch subject: [PATCH v7 3/6] iio: imu: adis: Add DIAG_STAT register
config: arc-randconfig-001-20250213 (https://download.01.org/0day-ci/archive/20250213/202502131146.rXrTvgZr-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250213/202502131146.rXrTvgZr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502131146.rXrTvgZr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/imu/adis.c: In function '__adis_check_status':
>> drivers/iio/imu/adis.c:319:42: warning: passing argument 3 of '__adis_read_reg_16' makes pointer from integer without a cast [-Wint-conversion]
     319 |                                          status_16);
         |                                          ^~~~~~~~~
         |                                          |
         |                                          u16 {aka short unsigned int}
   In file included from drivers/iio/imu/adis.c:19:
   include/linux/iio/imu/adis.h:225:43: note: expected 'u16 *' {aka 'short unsigned int *'} but argument is of type 'u16' {aka 'short unsigned int'}
     225 |                                      u16 *val)
         |                                      ~~~~~^~~


vim +/__adis_read_reg_16 +319 drivers/iio/imu/adis.c

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

