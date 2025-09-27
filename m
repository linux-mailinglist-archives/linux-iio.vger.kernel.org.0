Return-Path: <linux-iio+bounces-24481-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E52BA5F72
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 15:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339093ABF39
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C162E1C69;
	Sat, 27 Sep 2025 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BdoWsCMb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F22E1757;
	Sat, 27 Sep 2025 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758978014; cv=none; b=XvTTQuRUA5pjLQlHtbFcDQD0UAelFo7yCy66iNYz91Rc7VbwLJqyTs7MfxEkQd50SqfPs8hCyjsC5p2y6UgX0ssjEG8fJfj3iPT5hfVixTkLGRSdtSNCYwU1+GOCqd5FFzkGED32ntusEqrdmdWrqm8fwXw3xsZMuKYCQIuZn1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758978014; c=relaxed/simple;
	bh=jzebUf+63bj5rtU4hJayjc7X3+u2ceh7LqvGb8ptNi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNHb3WBdl0sCxdEpjQ7uPvq+aXCwCPP7TNRTN8w8tMymOT5cMIkgmxK/3U4mTdkM0azYsf5TVu2fHKj7gXOv650P3z9KVZ0cF2eadzCN3VqqbVD1lvbtrW9Oh+UAoX4Q5s+CnS0/s257QlVsEgED2913Sl2+vbBlJs2S+p3dGqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BdoWsCMb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758978012; x=1790514012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jzebUf+63bj5rtU4hJayjc7X3+u2ceh7LqvGb8ptNi0=;
  b=BdoWsCMbtQkMPtvcEx6g07cNXQ0vaveUEkBbFjJ6o2EGXHdrLZB183D+
   47Io1RVyqCABEe5adnakqjuAKNFBQWXYA/YMriwcCq+U7IxppJvDOFwhP
   uqBblZP5ewdwJGxL62dHU631CnLfSMBQ1SvxY+mMJDrSOP7nfuS1ooI/p
   HKWJ4BrCmSCUAxorFEb/0rLU5hM8mqXJiat1BdUHSFGaT4TqamkkPrRtW
   a7ONfGltk+y+gyyecVf7z6s77YP+qV+JQ1hwju5Axk2ynlxItJbgtBWO6
   JYeb4n1i3hPdehPOcKuewCME+Pl2D8jR2FR8eimg5DFi2D1fvwOQJjY2f
   A==;
X-CSE-ConnectionGUID: 6DVpSIKcRJaUycPHCj04nw==
X-CSE-MsgGUID: mEJCOK/fShiWyy8nXJxmug==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61246388"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61246388"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2025 06:00:11 -0700
X-CSE-ConnectionGUID: anys7G8eR6S+RNK3Vl14fw==
X-CSE-MsgGUID: RdLCaiYJQKe1fcc5HgT3TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,297,1751266800"; 
   d="scan'208";a="183108925"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 27 Sep 2025 06:00:07 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2UWy-00074F-33;
	Sat, 27 Sep 2025 13:00:04 +0000
Date: Sat, 27 Sep 2025 20:59:36 +0800
From: kernel test robot <lkp@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jic23@kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, marcelo.schmitt1@gmail.com,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v3 6/8] iio: adc: ad4030: Add SPI offload support
Message-ID: <202509272028.0zLNiR5w-lkp@intel.com>
References: <0028720d2cb21898ef044458065ac8a0bc829588.1758916484.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0028720d2cb21898ef044458065ac8a0bc829588.1758916484.git.marcelo.schmitt@analog.com>

Hi Marcelo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 561285d048053fec8a3d6d1e3ddc60df11c393a0]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcelo-Schmitt/dt-bindings-iio-adc-adi-ad4030-Reference-spi-peripheral-props/20250927-044546
base:   561285d048053fec8a3d6d1e3ddc60df11c393a0
patch link:    https://lore.kernel.org/r/0028720d2cb21898ef044458065ac8a0bc829588.1758916484.git.marcelo.schmitt%40analog.com
patch subject: [PATCH v3 6/8] iio: adc: ad4030: Add SPI offload support
config: i386-randconfig-014-20250927 (https://download.01.org/0day-ci/archive/20250927/202509272028.0zLNiR5w-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250927/202509272028.0zLNiR5w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509272028.0zLNiR5w-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/spi/spi-offload-trigger-pwm.c: In function 'spi_offload_trigger_pwm_validate':
>> drivers/spi/spi-offload-trigger-pwm.c:55:15: error: implicit declaration of function 'pwm_round_waveform_might_sleep' [-Wimplicit-function-declaration]
      55 |         ret = pwm_round_waveform_might_sleep(st->pwm, &wf);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-offload-trigger-pwm.c: In function 'spi_offload_trigger_pwm_enable':
>> drivers/spi/spi-offload-trigger-pwm.c:81:16: error: implicit declaration of function 'pwm_set_waveform_might_sleep' [-Wimplicit-function-declaration]
      81 |         return pwm_set_waveform_might_sleep(st->pwm, &wf, false);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi-offload-trigger-pwm.c: In function 'spi_offload_trigger_pwm_disable':
>> drivers/spi/spi-offload-trigger-pwm.c:90:15: error: implicit declaration of function 'pwm_get_waveform_might_sleep' [-Wimplicit-function-declaration]
      90 |         ret = pwm_get_waveform_might_sleep(st->pwm, &wf);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SPI_OFFLOAD_TRIGGER_PWM
   Depends on [n]: SPI [=y] && SPI_OFFLOAD [=y] && PWM [=n]
   Selected by [y]:
   - AD4030 [=y] && IIO [=y] && SPI [=y] && GPIOLIB [=y]


vim +/pwm_round_waveform_might_sleep +55 drivers/spi/spi-offload-trigger-pwm.c

ebb398ae1e052c David Lechner 2025-02-07   36  
ebb398ae1e052c David Lechner 2025-02-07   37  static int spi_offload_trigger_pwm_validate(struct spi_offload_trigger *trigger,
ebb398ae1e052c David Lechner 2025-02-07   38  					    struct spi_offload_trigger_config *config)
ebb398ae1e052c David Lechner 2025-02-07   39  {
ebb398ae1e052c David Lechner 2025-02-07   40  	struct spi_offload_trigger_pwm_state *st = spi_offload_trigger_get_priv(trigger);
ebb398ae1e052c David Lechner 2025-02-07   41  	struct spi_offload_trigger_periodic *periodic = &config->periodic;
ebb398ae1e052c David Lechner 2025-02-07   42  	struct pwm_waveform wf = { };
ebb398ae1e052c David Lechner 2025-02-07   43  	int ret;
ebb398ae1e052c David Lechner 2025-02-07   44  
ebb398ae1e052c David Lechner 2025-02-07   45  	if (config->type != SPI_OFFLOAD_TRIGGER_PERIODIC)
ebb398ae1e052c David Lechner 2025-02-07   46  		return -EINVAL;
ebb398ae1e052c David Lechner 2025-02-07   47  
ebb398ae1e052c David Lechner 2025-02-07   48  	if (!periodic->frequency_hz)
ebb398ae1e052c David Lechner 2025-02-07   49  		return -EINVAL;
ebb398ae1e052c David Lechner 2025-02-07   50  
ebb398ae1e052c David Lechner 2025-02-07   51  	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
ebb398ae1e052c David Lechner 2025-02-07   52  	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
ebb398ae1e052c David Lechner 2025-02-07   53  	wf.duty_length_ns = wf.period_length_ns / 2;
ebb398ae1e052c David Lechner 2025-02-07   54  
ebb398ae1e052c David Lechner 2025-02-07  @55  	ret = pwm_round_waveform_might_sleep(st->pwm, &wf);
ebb398ae1e052c David Lechner 2025-02-07   56  	if (ret < 0)
ebb398ae1e052c David Lechner 2025-02-07   57  		return ret;
ebb398ae1e052c David Lechner 2025-02-07   58  
ebb398ae1e052c David Lechner 2025-02-07   59  	periodic->frequency_hz = DIV_ROUND_UP_ULL(NSEC_PER_SEC, wf.period_length_ns);
ebb398ae1e052c David Lechner 2025-02-07   60  
ebb398ae1e052c David Lechner 2025-02-07   61  	return 0;
ebb398ae1e052c David Lechner 2025-02-07   62  }
ebb398ae1e052c David Lechner 2025-02-07   63  
ebb398ae1e052c David Lechner 2025-02-07   64  static int spi_offload_trigger_pwm_enable(struct spi_offload_trigger *trigger,
ebb398ae1e052c David Lechner 2025-02-07   65  					  struct spi_offload_trigger_config *config)
ebb398ae1e052c David Lechner 2025-02-07   66  {
ebb398ae1e052c David Lechner 2025-02-07   67  	struct spi_offload_trigger_pwm_state *st = spi_offload_trigger_get_priv(trigger);
ebb398ae1e052c David Lechner 2025-02-07   68  	struct spi_offload_trigger_periodic *periodic = &config->periodic;
ebb398ae1e052c David Lechner 2025-02-07   69  	struct pwm_waveform wf = { };
ebb398ae1e052c David Lechner 2025-02-07   70  
ebb398ae1e052c David Lechner 2025-02-07   71  	if (config->type != SPI_OFFLOAD_TRIGGER_PERIODIC)
ebb398ae1e052c David Lechner 2025-02-07   72  		return -EINVAL;
ebb398ae1e052c David Lechner 2025-02-07   73  
ebb398ae1e052c David Lechner 2025-02-07   74  	if (!periodic->frequency_hz)
ebb398ae1e052c David Lechner 2025-02-07   75  		return -EINVAL;
ebb398ae1e052c David Lechner 2025-02-07   76  
ebb398ae1e052c David Lechner 2025-02-07   77  	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
ebb398ae1e052c David Lechner 2025-02-07   78  	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
ebb398ae1e052c David Lechner 2025-02-07   79  	wf.duty_length_ns = wf.period_length_ns / 2;
ebb398ae1e052c David Lechner 2025-02-07   80  
ebb398ae1e052c David Lechner 2025-02-07  @81  	return pwm_set_waveform_might_sleep(st->pwm, &wf, false);
ebb398ae1e052c David Lechner 2025-02-07   82  }
ebb398ae1e052c David Lechner 2025-02-07   83  
ebb398ae1e052c David Lechner 2025-02-07   84  static void spi_offload_trigger_pwm_disable(struct spi_offload_trigger *trigger)
ebb398ae1e052c David Lechner 2025-02-07   85  {
ebb398ae1e052c David Lechner 2025-02-07   86  	struct spi_offload_trigger_pwm_state *st = spi_offload_trigger_get_priv(trigger);
ebb398ae1e052c David Lechner 2025-02-07   87  	struct pwm_waveform wf;
ebb398ae1e052c David Lechner 2025-02-07   88  	int ret;
ebb398ae1e052c David Lechner 2025-02-07   89  
ebb398ae1e052c David Lechner 2025-02-07  @90  	ret = pwm_get_waveform_might_sleep(st->pwm, &wf);
ebb398ae1e052c David Lechner 2025-02-07   91  	if (ret < 0) {
ebb398ae1e052c David Lechner 2025-02-07   92  		dev_err(st->dev, "failed to get waveform: %d\n", ret);
ebb398ae1e052c David Lechner 2025-02-07   93  		return;
ebb398ae1e052c David Lechner 2025-02-07   94  	}
ebb398ae1e052c David Lechner 2025-02-07   95  
ebb398ae1e052c David Lechner 2025-02-07   96  	wf.duty_length_ns = 0;
ebb398ae1e052c David Lechner 2025-02-07   97  
ebb398ae1e052c David Lechner 2025-02-07   98  	ret = pwm_set_waveform_might_sleep(st->pwm, &wf, false);
ebb398ae1e052c David Lechner 2025-02-07   99  	if (ret < 0)
ebb398ae1e052c David Lechner 2025-02-07  100  		dev_err(st->dev, "failed to disable PWM: %d\n", ret);
ebb398ae1e052c David Lechner 2025-02-07  101  }
ebb398ae1e052c David Lechner 2025-02-07  102  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

