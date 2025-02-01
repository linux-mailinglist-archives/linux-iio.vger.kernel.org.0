Return-Path: <linux-iio+bounces-14851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E7A24C29
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 00:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63671635ED
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 23:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADB71CEE8C;
	Sat,  1 Feb 2025 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X944o5e9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1A31CAA71;
	Sat,  1 Feb 2025 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738453054; cv=none; b=Q7oX8hvNX7OvUJyiOIo4BE4uKgV88rS8FQztKROZAoio7A78hcd5uhe+fjrjTCpK2AYMVsZg04+oRKGqySpmdqS0RyakYlZrBhGHxBu4Cvo2NZ9+Hc4hRrIJRyJ8nOLdJi5JYvdx/lY/9lAaAem0jQUBCPW1uI176vlwQst/VtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738453054; c=relaxed/simple;
	bh=VniUty94QaFSvir46bJwxI1Xq3DeV+IIZnzat/jKmTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAccUhzZcMPYYx6srKa4XRNPxJX1R5KZepdcU0cN5co+8klrnCMFSdaissXBCBLLQypNBMDHlluHT5liQ3KfIHkCSG8S7mah+OSj+Bkm9tUigpJZEAqdVW1iDnpw76EDyRv3SETT1Ar0T+ia9326CLxxOC/gKNCu9DYJU5MXs9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X944o5e9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738453052; x=1769989052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VniUty94QaFSvir46bJwxI1Xq3DeV+IIZnzat/jKmTQ=;
  b=X944o5e9RKJPEO7C7+Kkuz0r1nWpBbH/eAtp8ye9ElSIDCvcI117wY/0
   9tAgyt/9FiwEXzk/FCYn9qfVEbMGQsN0B3PJMzL/b1kV2/V96pBUH1YMI
   kMUBz+l86VCtx3aabT7vxfqLteYzvKPTKDbFrL/H+j5T1yUT+EgsJXpjP
   8hmJM3NcRIja1PUPDd3NY1goFg8xbqmsr+VSD6GrHKr1oOTQyamOw7ZpE
   nRm45B+HyuI37Cne2qrsRqLUr6Ggw5U1cg9hGA0Ftb6tCDuQKk6aC7nTj
   ebbQBivSrjBN+L4oNmAl0vOZILd1TI6IL4aFYYnQra5+/nXKx5uNR/uvu
   A==;
X-CSE-ConnectionGUID: t/X8mKtLRQuoiHy4QosGOQ==
X-CSE-MsgGUID: Hn/8c1VaRxO9iSbshGmBaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11333"; a="41817797"
X-IronPort-AV: E=Sophos;i="6.13,252,1732608000"; 
   d="scan'208";a="41817797"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2025 15:37:31 -0800
X-CSE-ConnectionGUID: UhFc5lhwTheiX5AfnWEEcQ==
X-CSE-MsgGUID: DDSgqk4YRIe/h/gpgI7ZGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="114932082"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 01 Feb 2025 15:37:24 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1teN3B-000p1L-3C;
	Sat, 01 Feb 2025 23:37:21 +0000
Date: Sun, 2 Feb 2025 07:36:35 +0800
From: kernel test robot <lkp@intel.com>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	agross@kernel.org, andersson@kernel.org,
	dmitry.baryshkov@linaro.org, konradybcio@kernel.org,
	daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
	thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
	subbaraman.narayanamurthy@oss.qualcomm.com,
	david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
	quic_kamalw@quicinc.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	rui.zhang@intel.com, lukasz.luba@arm.com, lars@metafoo.de,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
	jishnu.prakash@oss.qualcomm.com, quic_skakitap@quicinc.com,
	neil.armstrong@linaro.org
Subject: Re: [PATCH V5 4/5] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Message-ID: <202502020700.dqk9AzTu-lkp@intel.com>
References: <20250131183242.3653595-5-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131183242.3653595-5-jishnu.prakash@oss.qualcomm.com>

Hi Jishnu,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5ffa57f6eecefababb8cbe327222ef171943b183]

url:    https://github.com/intel-lab-lkp/linux/commits/Jishnu-Prakash/dt-bindings-iio-adc-Move-QCOM-ADC-bindings-to-iio-adc-folder/20250201-023723
base:   5ffa57f6eecefababb8cbe327222ef171943b183
patch link:    https://lore.kernel.org/r/20250131183242.3653595-5-jishnu.prakash%40oss.qualcomm.com
patch subject: [PATCH V5 4/5] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20250202/202502020700.dqk9AzTu-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250202/202502020700.dqk9AzTu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502020700.dqk9AzTu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/adc/qcom-adc5-gen3-common.c:72:11: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      72 |         *data |= FIELD_PREP(ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK, prop->cal_method);
         |                  ^
   1 error generated.


vim +/FIELD_PREP +72 drivers/iio/adc/qcom-adc5-gen3-common.c

    67	
    68	void adc5_gen3_update_dig_param(struct adc5_channel_common_prop *prop, u8 *data)
    69	{
    70		/* Update calibration select and decimation ratio select */
    71		*data &= ~(ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK | ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK);
  > 72		*data |= FIELD_PREP(ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK, prop->cal_method);
    73		*data |= FIELD_PREP(ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK, prop->decimation);
    74	}
    75	EXPORT_SYMBOL(adc5_gen3_update_dig_param);
    76	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

