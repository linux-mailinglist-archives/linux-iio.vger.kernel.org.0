Return-Path: <linux-iio+bounces-4803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0CA8BBF34
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 06:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC384281F68
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 04:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838111879;
	Sun,  5 May 2024 04:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNPeh+Mb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ABB1869;
	Sun,  5 May 2024 04:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714883830; cv=none; b=ucvAlu1GR5ptnOSm3G7LDJvtyC9hFCSQXkFU3gxUfxxe/U4lvQQnqAiiC+Z4W9FriqobBb/96DJfWqLWxMa8y2xQGTkB7fpAcywGRCem/LOboqMhJO31+fNeLvQNzDms692ow7XXN6srHWGGX2Mi+NX/VUeHtx8LtU0sOgde9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714883830; c=relaxed/simple;
	bh=lg3ZmrqDpgoWH7uchHVbaymLxKfhlI7YH7/bVp1vSis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qv3E150DrISgCz5n6LjvUw92R03kUMQkV4kl4gntNBviqvTxTbSA6z5of9mzROoFesYZrqI4I9Vcp6Ny3hAtpxo68J5ffBJ/86pJXmSrONMYudiXCMI7jawheIgNSftxNNmT7itYFIXWQksFVo405fQpzyaROZxADQJEMl6bY3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNPeh+Mb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714883827; x=1746419827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lg3ZmrqDpgoWH7uchHVbaymLxKfhlI7YH7/bVp1vSis=;
  b=QNPeh+Mb0Qa6Sj3QhReNK009x6iCGZt8XVYZ0dZyj3C++HWPZOh25GjW
   amD0wN3VgEUIGgM2HeYarua3NvWUbEHBpdSifShiE5JND79I+/mQ/Klbo
   8n9M3XqON+pjW3QvT2LDKikM7Gu+oz4FrC/yojcuLB5+mVlFgpvnyA5Yr
   qo70gDQvLVcn+LU6l/FM00FHXTnhqc60Mly0T2O5dsFLNc6EN/wZe7BvF
   T+TBQPyEOtGg0mr4qwCXSl+3cJCfRBe5x6Nilio80p0I1Wfn98X3yhbRO
   Nxm8x7l2tl07hZ51+ZObnXIWnDNT7+4W6Asauuk7vevmjsuE58rqhuTVa
   w==;
X-CSE-ConnectionGUID: kEjTsuCFS5C95sX8ozPFzg==
X-CSE-MsgGUID: K/jjTrQaS12tjv5skmvScQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="21203698"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="21203698"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 21:37:07 -0700
X-CSE-ConnectionGUID: 9IPwF6yjTvyC7RD4dFu7fg==
X-CSE-MsgGUID: ZfK8V6V+TwaMEjJc2DmUuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="59037530"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 May 2024 21:37:04 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s3TcT-000DQi-1v;
	Sun, 05 May 2024 04:37:01 +0000
Date: Sun, 5 May 2024 12:36:58 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <trabarni@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	=?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <trabarni@gmail.com>,
	Danila Tikhonov <danila@jiaxyga.com>
Subject: Re: [PATCH 1/2] iio: imu: bmi160: add support for bmi120
Message-ID: <202405051259.R7WyR8LV-lkp@intel.com>
References: <20240504-bmi120-v1-1-478470a85058@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240504-bmi120-v1-1-478470a85058@gmail.com>

Hi Barnabás,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9221b2819b8a4196eecf5476d66201be60fbcf29]

url:    https://github.com/intel-lab-lkp/linux/commits/Barnab-s-Cz-m-n/iio-imu-bmi160-add-support-for-bmi120/20240504-074802
base:   9221b2819b8a4196eecf5476d66201be60fbcf29
patch link:    https://lore.kernel.org/r/20240504-bmi120-v1-1-478470a85058%40gmail.com
patch subject: [PATCH 1/2] iio: imu: bmi160: add support for bmi120
config: x86_64-randconfig-121-20240505 (https://download.01.org/0day-ci/archive/20240505/202405051259.R7WyR8LV-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240505/202405051259.R7WyR8LV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405051259.R7WyR8LV-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/imu/bmi160/bmi160_core.c:116:10: sparse: sparse: symbol 'bmi_chip_ids' was not declared. Should it be static?

vim +/bmi_chip_ids +116 drivers/iio/imu/bmi160/bmi160_core.c

   115	
 > 116	const u8 bmi_chip_ids[] = {
   117		BMI120_CHIP_ID_VAL,
   118		BMI160_CHIP_ID_VAL,
   119	};
   120	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

