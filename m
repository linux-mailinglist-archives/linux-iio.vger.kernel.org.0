Return-Path: <linux-iio+bounces-11829-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5759B9B9F67
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 12:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3BE1C2145F
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 11:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C539217C9BB;
	Sat,  2 Nov 2024 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ezw7D+uQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEBE140E50;
	Sat,  2 Nov 2024 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730547582; cv=none; b=PBdSBMxNQJaVPJdXuyU306IS0tVNQFLyMqCvv+mztqBLj8/dmAQsn9x0G8psWJ1v0thrsCDgovo8wAgX8tfimwfxtwpiwIPb6hvaPfamG4yb941t1wy8b9HXUXRQpr/BYR61mIFS/cQeAIsNYbTfyPj80nTUveyie0qtSFgE94A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730547582; c=relaxed/simple;
	bh=AMrjIY8dJeUvVWVkGizF8Yx7actymBoa3uQKiOySwbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KR3b6yJAcuOesxMNNcHGPm/tfQRoTKnOGAlgdsBHJwZq9PvNpwBqwl6ecUTxXNShvTQ0rzUBurLM6OZNM8IQN2ezkAr2zrx90LUDWfpOj1fxvLWBQua1ZpOHDIvf3jfdJXjhH0So5OaI4SLoJAHFA1+vEQFYALUfxvwLitKi+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ezw7D+uQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730547581; x=1762083581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AMrjIY8dJeUvVWVkGizF8Yx7actymBoa3uQKiOySwbk=;
  b=Ezw7D+uQWBuQhvvVcQIytkE7IDsnX/PDNjEHMDJgfQj9RtLS/BYYS2rm
   T90GeqYIKj/W+nUcR78J6DHrqa1FypgwF+lwobuNphoptS9AFDGJ34uCm
   gwCDXTBkhrSRGbPVa6ybbrra734SqkRtqrjzK3YXfQ0/jMq3bzhvt+Zm/
   gYc5+sYy4K04ZzPNw0YCI+BjNy8pFz36HSmrndDF6V8d8pXn0Od++XnKT
   Kp20S6IWKJemfwGZUd6hvrrV01H8QmYGyZ6Gklz83P/rbLZfoygeZvJ3b
   WTixpQPaYgnfZxApFWayhJpT+E+bk5JIIr5M/V1/iZ5rX55OouuehpmTp
   g==;
X-CSE-ConnectionGUID: MIqcMlbsQrqkj1xDLoXdZQ==
X-CSE-MsgGUID: w/MScjDsT1urTyYEsDwpng==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="30414481"
X-IronPort-AV: E=Sophos;i="6.11,252,1725346800"; 
   d="scan'208";a="30414481"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 04:39:40 -0700
X-CSE-ConnectionGUID: RlAAphZrTJaTT0VA4y0i8g==
X-CSE-MsgGUID: yH3ycratQoe/iycCHmTR7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,252,1725346800"; 
   d="scan'208";a="114017845"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 02 Nov 2024 04:39:33 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7CTb-000is3-1W;
	Sat, 02 Nov 2024 11:39:31 +0000
Date: Sat, 2 Nov 2024 19:39:05 +0800
From: kernel test robot <lkp@intel.com>
To: Jishnu Prakash <quic_jprakash@quicinc.com>, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
	dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org,
	daniel.lezcano@linaro.org, sboyd@kernel.org,
	quic_subbaram@quicinc.com, quic_collinsd@quicinc.com,
	quic_amelende@quicinc.com, quic_kamalw@quicinc.com,
	amitk@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lee@kernel.org, rafael@kernel.org,
	rui.zhang@intel.com, lukasz.luba@arm.com, lars@metafoo.de,
	quic_skakitap@quicinc.com, neil.armstrong@linaro.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
	Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: Re: [PATCH V4 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
Message-ID: <202411021924.bHINpnCr-lkp@intel.com>
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
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20241102/202411021924.bHINpnCr-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411021924.bHINpnCr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411021924.bHINpnCr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:599,
                    from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:99,
                    from include/linux/bug.h:5,
                    from include/linux/fortify-string.h:6,
                    from include/linux/string.h:390,
                    from arch/x86/include/asm/page_32.h:18,
                    from arch/x86/include/asm/page.h:14,
                    from arch/x86/include/asm/processor.h:20,
                    from include/linux/sched.h:13,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/auxiliary_bus.h:11,
                    from include/linux/iio/adc/qcom-adc5-gen3-common.h:12,
                    from drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c:7:
   drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c: In function 'adctm5_gen3_isr':
>> drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c:103:31: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'u8 *' {aka 'unsigned char *'} [-Wformat=]
     103 |         dev_dbg(adc_tm5->dev, "Interrupt status:%#x, TM status:%#x, high:%#x, low:%#x\n",
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:224:29: note: in definition of macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:273:9: note: in expansion of macro '_dynamic_func_call'
     273 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:9: note: in expansion of macro 'dynamic_dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:30: note: in expansion of macro 'dev_fmt'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c:103:9: note: in expansion of macro 'dev_dbg'
     103 |         dev_dbg(adc_tm5->dev, "Interrupt status:%#x, TM status:%#x, high:%#x, low:%#x\n",
         |         ^~~~~~~
   drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c:103:66: note: format string is defined here
     103 |         dev_dbg(adc_tm5->dev, "Interrupt status:%#x, TM status:%#x, high:%#x, low:%#x\n",
         |                                                                ~~^
         |                                                                  |
         |                                                                  unsigned int
         |                                                                %#hhn
--
>> drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c:22: warning: Cannot understand  * @adc_tm: indicates if the channel is used for TM measurements.
    on line 22 - I thought it was a doc line


vim +103 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c

   > 7	#include <linux/iio/adc/qcom-adc5-gen3-common.h>
     8	#include <linux/iio/consumer.h>
     9	#include <linux/interrupt.h>
    10	#include <linux/module.h>
    11	#include <linux/of.h>
    12	#include <linux/platform_device.h>
    13	#include <linux/regmap.h>
    14	#include <linux/thermal.h>
    15	#include <linux/unaligned.h>
    16	
    17	#include "../thermal_hwmon.h"
    18	
    19	struct adc_tm5_gen3_chip;
    20	
    21	/**
  > 22	 * @adc_tm: indicates if the channel is used for TM measurements.
    23	 * @tm_chan_index: TM channel number used (ranging from 1-7).
    24	 * @timer: time period of recurring TM measurement.
    25	 * @tzd: pointer to thermal device corresponding to TM channel.
    26	 * @high_thr_en: TM high threshold crossing detection enabled.
    27	 * @low_thr_en: TM low threshold crossing detection enabled.
    28	 * @last_temp: last temperature that caused threshold violation,
    29	 *	or a thermal TM channel.
    30	 * @last_temp_set: indicates if last_temp is stored.
    31	 */
    32	
    33	struct adc_tm5_gen3_channel_props {
    34		struct device			*dev;
    35		unsigned int			timer;
    36		unsigned int			tm_chan_index;
    37		unsigned int			sdam_index;
    38		struct adc5_channel_common_prop common_props;
    39		bool			high_thr_en;
    40		bool			low_thr_en;
    41		bool			meas_en;
    42		struct adc_tm5_gen3_chip	*chip;
    43		struct thermal_zone_device *tzd;
    44		int				last_temp;
    45		bool				last_temp_set;
    46	};
    47	
    48	struct adc_tm5_gen3_chip {
    49		struct adc5_device_data	*dev_data;
    50		struct adc_tm5_gen3_channel_props	*chan_props;
    51		unsigned int		nchannels;
    52		struct device		*dev;
    53		struct work_struct		tm_handler_work;
    54	};
    55	
    56	static int get_sdam_from_irq(struct adc_tm5_gen3_chip *adc_tm5, int irq)
    57	{
    58		int i;
    59	
    60		for (i = 0; i < adc_tm5->dev_data->num_sdams; i++) {
    61			if (adc_tm5->dev_data->base[i].irq == irq)
    62				return i;
    63		}
    64		return -ENOENT;
    65	}
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
 > 103		dev_dbg(adc_tm5->dev, "Interrupt status:%#x, TM status:%#x, high:%#x, low:%#x\n",
   104			status, tm_status, tm_status[0], tm_status[1]);
   105	
   106		return IRQ_HANDLED;
   107	}
   108	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

