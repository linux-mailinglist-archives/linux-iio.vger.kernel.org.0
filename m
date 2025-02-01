Return-Path: <linux-iio+bounces-14799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDFEA24820
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 11:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A1707A31B2
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 10:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99D5149E1A;
	Sat,  1 Feb 2025 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWa5qUSZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359E140E38;
	Sat,  1 Feb 2025 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738404414; cv=none; b=hOBl9iJPf7mDTTsofKYMnarJ/iNYSwutCEsxBaO/vOZdQizDWdHFw64K6f7WVwB0QwNljSd5hN9Szc3ZIG2vWsY2I/1pQ1NysiC2dUAClYrtVnWJLqwEybaNtz7wv0JZpbdbAq1fG5XWzSnmIbRnqcXyGeUNa4kXycmq3p418mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738404414; c=relaxed/simple;
	bh=luDz7nI8Z256mCk8I1VhfshnLLJ2vZ3M4FOHRZSBCY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDOKdd8VP9v5d8+zq+csz/f0usK0qS6oG2RRiUTSiQ2VMqyuWC8pGDRw/Fp+Owt/m7ypAx3qwOfaFE/EUvraeeL/ecH0ppKLUZysMT63KnPASzyAEg/ysXhDUx54fX1MRfZU6FfNzM8YVTL5wKKQOehyZYmMggKMxiPNt6O44Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWa5qUSZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738404413; x=1769940413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=luDz7nI8Z256mCk8I1VhfshnLLJ2vZ3M4FOHRZSBCY0=;
  b=mWa5qUSZNsVZCaVJYWpS+CdXFitLHa7CfdPRHFdO1EzsfFq/zBlKXOAX
   d7lCK0NawZSA0CVMXxmRq7bjSwNzfC+4r4f6BfqCxS88mdtgZVEQb0FWr
   752FBHhD29ZYT2EybNHrIlGkjdhmjL/CZpO2QNyE72aLFmaqTarGbuzYA
   gg4Ja6/KbkNIgMFdL4M3P9hWfiaWHiMC/SnMTLSLDfvvJCZV/FDz/8pkt
   t9BTpIojR43Px2DELHJmbp4X5ySzYHkFiZ2OqAA5i9niX8v2hMINLzJ/H
   6dHi+gEBLcq4gqsMX5r0ezWSXlWOXil7udO+GP6lTZGOl7F0nT9YpfMC7
   Q==;
X-CSE-ConnectionGUID: KhSR4uSSRYGoMHkL24Lhug==
X-CSE-MsgGUID: 9obNOxFZQRWtofe4m8eh3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="50350373"
X-IronPort-AV: E=Sophos;i="6.13,251,1732608000"; 
   d="scan'208";a="50350373"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2025 02:06:52 -0800
X-CSE-ConnectionGUID: z3vE1xROSnC5BDhYcDTqew==
X-CSE-MsgGUID: 04/zztnwRc6n0ytaPWhdEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,251,1732608000"; 
   d="scan'208";a="110415798"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 01 Feb 2025 02:06:46 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1teAOh-000nzT-1T;
	Sat, 01 Feb 2025 10:06:43 +0000
Date: Sat, 1 Feb 2025 18:06:21 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, rui.zhang@intel.com, lukasz.luba@arm.com,
	lars@metafoo.de, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	cros-qcom-dts-watchers@chromium.org,
	jishnu.prakash@oss.qualcomm.com, quic_skakitap@quicinc.com,
	neil.armstrong@linaro.org
Subject: Re: [PATCH V5 4/5] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Message-ID: <202502011915.MIBVfCtZ-lkp@intel.com>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250201/202502011915.MIBVfCtZ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250201/202502011915.MIBVfCtZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502011915.MIBVfCtZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/adc/qcom-adc5-gen3-common.c: In function 'adc5_gen3_update_dig_param':
>> drivers/iio/adc/qcom-adc5-gen3-common.c:72:18: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
      72 |         *data |= FIELD_PREP(ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK, prop->cal_method);
         |                  ^~~~~~~~~~


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

