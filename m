Return-Path: <linux-iio+bounces-7828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFCE93A56E
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 20:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D314B2269C
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jul 2024 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD881586CB;
	Tue, 23 Jul 2024 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsKZiIKH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1AB155351;
	Tue, 23 Jul 2024 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721758793; cv=none; b=Zz+5mZl8fAmJHjj+TuZTE8LesbrsO16VxwJaP838J9rPOzQLgzUNLZYizlOCXurdGyBH6+UPZPzP0JRBFeLNz3O07eLcN/eEFRfXHpLbGC/kaIe3Lu6wEar6pdFwaIlSgwZEbbnq2/g5UW54MM52vznghNkQx+OLnZa5vsroghQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721758793; c=relaxed/simple;
	bh=37h4Mx2tmdykX5/nhIykgjMyWxpIfLseegeQS0xIZOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuLQtzqmSHvBJJLM5sLJxszr7ZXtsKn4yeeFAoflH1SPAJABGN6WDCWI697RqaJ+SXuIarke0Jhwp0gfQOP83D4OOwiC8uovaNaKdEDrineMknFIkYwsc5UHH1c//O+8BeYPg8AcL4SfI/iGD383uK62UrPdvIrz77rJVsnJEP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsKZiIKH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721758791; x=1753294791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=37h4Mx2tmdykX5/nhIykgjMyWxpIfLseegeQS0xIZOE=;
  b=ZsKZiIKHGxImwbDzrjtrobK5KG9Nv3xa876NX7E3Ytht2vVajr2162YQ
   9+HtxdxyD5nds6x6IutaClJ6Q2Ve/+skEEDhzxv2X87r9Yj5ncPSzETfe
   zdv7l2eE5EqmK29+e7lhKEhG2jvBFGhA6eEJRVfBgbQOmus7Fb/v6+UEV
   yARPVGCIFCNWY5j/UtalOccjT878L0DLc6r3/ZhN6eAQGSgDddkvtIXal
   HcghvKb0RFrpN/0X6X0bkMc46uEGmW+woLW7gNePTZeeg5P8KEO98kVFa
   o5UITo46Dbm81CIEnUu1iyzsTD27TSZccQXBJQapdwFDfhpFronpY3SUu
   Q==;
X-CSE-ConnectionGUID: EEdyIpr3Ri29zivgI8c9dA==
X-CSE-MsgGUID: p+yPl02yTxSPQMCiUT0jWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="30021747"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="30021747"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 11:19:50 -0700
X-CSE-ConnectionGUID: xB4xfjrmQs20ah3K1Y0U0Q==
X-CSE-MsgGUID: V4ESnhyESGiCDMXXiOa0QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="52924501"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 23 Jul 2024 11:19:47 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWK6z-000mF6-0E;
	Tue, 23 Jul 2024 18:19:45 +0000
Date: Wed, 24 Jul 2024 02:18:56 +0800
From: kernel test robot <lkp@intel.com>
To: Matteo Martelli <matteomartelli3@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matteo Martelli <matteomartelli3@gmail.com>
Subject: Re: [PATCH v3 3/3] iio: adc: add support for pac1921
Message-ID: <202407240123.tjObpf49-lkp@intel.com>
References: <20240722-iio-pac1921-v3-3-05dc9916cb33@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722-iio-pac1921-v3-3-05dc9916cb33@gmail.com>

Hi Matteo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1ebab783647a9e3bf357002d5c4ff060c8474a0a]

url:    https://github.com/intel-lab-lkp/linux/commits/Matteo-Martelli/dt-bindings-iio-adc-add-binding-for-pac1921/20240722-183406
base:   1ebab783647a9e3bf357002d5c4ff060c8474a0a
patch link:    https://lore.kernel.org/r/20240722-iio-pac1921-v3-3-05dc9916cb33%40gmail.com
patch subject: [PATCH v3 3/3] iio: adc: add support for pac1921
config: um-randconfig-r051-20240723 (https://download.01.org/0day-ci/archive/20240724/202407240123.tjObpf49-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407240123.tjObpf49-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407240123.tjObpf49-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/adc/pac1921.c:892:2: error: initializer element is not constant
     pac1921_ext_info_scale_avail,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/pac1921.c:892:2: note: (near initialization for 'pac1921_ext_info_voltage[0]')
   drivers/iio/adc/pac1921.c:897:2: error: initializer element is not constant
     pac1921_ext_info_scale_avail,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/pac1921.c:897:2: note: (near initialization for 'pac1921_ext_info_current[0]')
   drivers/iio/adc/pac1921.c:898:2: error: initializer element is not constant
     pac1921_ext_info_rshunt,
     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/adc/pac1921.c:898:2: note: (near initialization for 'pac1921_ext_info_current[1]')


vim +892 drivers/iio/adc/pac1921.c

   890	
   891	static const struct iio_chan_spec_ext_info pac1921_ext_info_voltage[] = {
 > 892		pac1921_ext_info_scale_avail,
   893		{}
   894	};
   895	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

