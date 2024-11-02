Return-Path: <linux-iio+bounces-11828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A00D9B9F27
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 12:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AADB282433
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 11:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D6A17166E;
	Sat,  2 Nov 2024 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0VQGHw3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BC212C54B;
	Sat,  2 Nov 2024 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730545662; cv=none; b=aYcgGn/cG6GZTTiRJF1L3ysnO087vkI4or5GR3fxsGggbQ0w7As09JrRXrGiWO/t9ceJvd05YZsPpSz5+Y7XCk2TOIiZJgFtGPl/ixiGw+XdG3aUKc7Mt9pYgItyRwsZBHMDC5rZohaeeyKLMOKQuqnq83pDZft/jmI5OXR1UFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730545662; c=relaxed/simple;
	bh=9ZIwMTx83KVmqWIu1wek6r3QEi6RmpiNxWoe9lrdARk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtUTDhWM4+kesnSIldVh8xT+fx1s9AkltUE9llnSngczqedhlzq2pN8FxSzIiF0eOQfGsFfNkaodLvM1xvZQGhVttUN/TaZUilQALSrxLtFKLUs6c++V3MAYfjcuUkABsCwhpeKAd6nHfvezcE32FsT5xp2xmGvUe9DjKlFsMx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0VQGHw3; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730545660; x=1762081660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ZIwMTx83KVmqWIu1wek6r3QEi6RmpiNxWoe9lrdARk=;
  b=k0VQGHw3/KzPldjryXF5dTq92kK7LXxO4nblO/qefaOjPCp4eqz1u79i
   /cio7gzmTFpeb7EpOxNo4Hoskb6doqx3MsczYtFnqnMibfJV8i0/fErA5
   ewG6QJR+1Z9zxHy2uhrjPYzHcryu1l7q/ylbA9Uz9/5KVg7XzBsSDV0Pj
   hdNW6EjUgQSDfdHWZTb1mmK/NZAL+ByO8bJ6UjzmGBV2AWM2RrHXZ81m4
   AQiLPOYwxxkl2GaXIwlHGJP3CbtVgz+1ruY/g8D8V5eLetrpwTSax6zRe
   PNIYGqud/gZeAPizojb2RpOvfm+UMXoGS4WsVdybqPxagN7O+rEyKCd01
   A==;
X-CSE-ConnectionGUID: kOuSZuqxRQy0ghIh/UZEBw==
X-CSE-MsgGUID: cIwvoidHQveq2K4sQqH6Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30068276"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30068276"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 04:07:39 -0700
X-CSE-ConnectionGUID: WOImKpq2SKWJm1JerZUJpw==
X-CSE-MsgGUID: MO4WhWXYQPmXKdrM96qcqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,252,1725346800"; 
   d="scan'208";a="83115070"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 Nov 2024 04:07:32 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7Byc-000ipN-0l;
	Sat, 02 Nov 2024 11:07:30 +0000
Date: Sat, 2 Nov 2024 19:07:19 +0800
From: kernel test robot <lkp@intel.com>
To: Jishnu Prakash <quic_jprakash@quicinc.com>, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
	dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org,
	daniel.lezcano@linaro.org, sboyd@kernel.org,
	quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
	quic_amelende@quicinc.com, quic_kamalw@quicinc.com,
	amitk@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, lee@kernel.org,
	rafael@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
	lars@metafoo.de, quic_skakitap@quicinc.com,
	neil.armstrong@linaro.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	cros-qcom-dts-watchers@chromium.org,
	Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: Re: [PATCH V4 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
Message-ID: <202411021848.djIzD89X-lkp@intel.com>
References: <20241030185854.4015348-5-quic_jprakash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030185854.4015348-5-quic_jprakash@quicinc.com>

Hi Jishnu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6fb2fa9805c501d9ade047fc511961f3273cdcb5]

url:    https://github.com/intel-lab-lkp/linux/commits/Jishnu-Prakash/dt-bindings-iio-adc-Move-QCOM-ADC-bindings-to-iio-adc-folder/20241031-030237
base:   6fb2fa9805c501d9ade047fc511961f3273cdcb5
patch link:    https://lore.kernel.org/r/20241030185854.4015348-5-quic_jprakash%40quicinc.com
patch subject: [PATCH V4 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC thermal monitoring
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241102/202411021848.djIzD89X-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411021848.djIzD89X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411021848.djIzD89X-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c:104:11: warning: format specifies type 'unsigned int' but the argument has type 'u8 *' (aka 'unsigned char *') [-Wformat]
     103 |         dev_dbg(adc_tm5->dev, "Interrupt status:%#x, TM status:%#x, high:%#x, low:%#x\n",
         |                                                                ~~~
         |                                                                %s
     104 |                 status, tm_status, tm_status[0], tm_status[1]);
         |                         ^~~~~~~~~
   include/linux/dev_printk.h:165:39: note: expanded from macro 'dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                      ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:274:19: note: expanded from macro 'dynamic_dev_dbg'
     274 |                            dev, fmt, ##__VA_ARGS__)
         |                                 ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   1 warning generated.


vim +104 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c

    66	
    67	static irqreturn_t adctm5_gen3_isr(int irq, void *dev_id)
    68	{
    69		struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
    70		u8 status, tm_status[2], val;
    71		int ret, sdam_num;
    72	
    73		sdam_num = get_sdam_from_irq(adc_tm5, irq);
    74		if (sdam_num < 0) {
    75			dev_err(adc_tm5->dev, "adc irq %d not associated with an sdam\n", irq);
    76			return IRQ_HANDLED;
    77		}
    78	
    79		ret = adc5_gen3_read(adc_tm5->dev_data, sdam_num, ADC5_GEN3_STATUS1, &status, 1);
    80		if (ret) {
    81			dev_err(adc_tm5->dev, "adc read status1 failed with %d\n", ret);
    82			return IRQ_HANDLED;
    83		}
    84	
    85		if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
    86			dev_err_ratelimited(adc_tm5->dev, "Unexpected conversion fault, status:%#x\n",
    87					    status);
    88			val = ADC5_GEN3_CONV_ERR_CLR_REQ;
    89			adc5_gen3_status_clear(adc_tm5->dev_data, sdam_num, ADC5_GEN3_CONV_ERR_CLR, &val,
    90					       1);
    91			return IRQ_HANDLED;
    92		}
    93	
    94		ret = adc5_gen3_read(adc_tm5->dev_data, sdam_num, ADC5_GEN3_TM_HIGH_STS, tm_status, 2);
    95		if (ret) {
    96			dev_err(adc_tm5->dev, "adc read TM status failed with %d\n", ret);
    97			return IRQ_HANDLED;
    98		}
    99	
   100		if (tm_status[0] || tm_status[1])
   101			schedule_work(&adc_tm5->tm_handler_work);
   102	
   103		dev_dbg(adc_tm5->dev, "Interrupt status:%#x, TM status:%#x, high:%#x, low:%#x\n",
 > 104			status, tm_status, tm_status[0], tm_status[1]);
   105	
   106		return IRQ_HANDLED;
   107	}
   108	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

