Return-Path: <linux-iio+bounces-10673-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F4B9A19CF
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 06:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D29B210CF
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 04:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADA614AD2D;
	Thu, 17 Oct 2024 04:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C70H4M8W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D6921E3C1;
	Thu, 17 Oct 2024 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140244; cv=none; b=sUN65ihQLnP9KVSxqkEb63BKsYrpyErQYjMIMaSKAIrSK4YcKbezfNjFMRV7skHAp/X+xTNbkgCRhU9f3QTvXknKB7kafmagKj6xQboJg6I4gjHBOzrI6HGls3L8tdVaTZOHQK+KFtNbEdqtKR/fLgoPpM9+r0zjbCAd788RUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140244; c=relaxed/simple;
	bh=11YArkhZQS4c8MQnbYUnU5KYPuWA3mgk5RTZHB/jkR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyWqQ51t03g1Lrj4/psmIx2TpdNltnLZCBal3ywpuqW0mQTJIhMuKmq+U5EHUg8ZMn/sWIp54ZiGdMCR4OfebkBtpj6d5iswntD4wDUEVrAjZkMHVb8YRME69jOa0Sj7cK9qZZck4MBoBroEtQc8IJjv1ApLTGR39o/mq7U1cAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C70H4M8W; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729140240; x=1760676240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=11YArkhZQS4c8MQnbYUnU5KYPuWA3mgk5RTZHB/jkR0=;
  b=C70H4M8Wiv7JA0SEM65j8wBwo2ExBPmHHQeIDMDWnIlozhFBVvRQfjs+
   HVug1zGLJmVn0LsZxxZm5AnEViFMD2Q5LbMq3F5VRSW9LFdH6tX08djvO
   5Je3WQMMIj5khDHG9osdjzCnrNuEe47MahHdMA8Iu+5E2MSMMD/XQhaMJ
   1pi29FwJfczsrKejJugvKvT/dtI8ir4b9P8D+gNos49BdJjwqEK8cWGn2
   37YqkB94R0WU071lVs3ahxTftEJUPCQcVn6mzI4zWNlmkPQLutl4SzSNC
   BOS6vGhtSIAHUSZ08ZiiQVe4PjwkB7CN/90xQXrnspsh3TU1qoFF0sc1h
   A==;
X-CSE-ConnectionGUID: Y51geHx5QVWysjeGMffP0g==
X-CSE-MsgGUID: JJOjcyqBSWGo/6uzqbUYBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="32538601"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="32538601"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 21:44:00 -0700
X-CSE-ConnectionGUID: RaXAfCgKTmeFaoCq0c1HyA==
X-CSE-MsgGUID: JgNiXR5kQXGN1ipyHrpcEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78585172"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 16 Oct 2024 21:43:56 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1IMc-000Ljj-17;
	Thu, 17 Oct 2024 04:43:54 +0000
Date: Thu, 17 Oct 2024 12:43:49 +0800
From: kernel test robot <lkp@intel.com>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	rickard.andersson@axis.com, kernel@axis.com,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>
Subject: Re: [PATCH v3 2/2] iio: light: Add support for TI OPT4060 color
 sensor
Message-ID: <202410171258.CFrNPzC1-lkp@intel.com>
References: <20241015143713.2017626-3-perdaniel.olsson@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015143713.2017626-3-perdaniel.olsson@axis.com>

Hi Per-Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on eca631b8fe808748d7585059c4307005ca5c5820]

url:    https://github.com/intel-lab-lkp/linux/commits/Per-Daniel-Olsson/dt-bindings-iio-light-Document-TI-OPT4060-RGBW-sensor/20241015-224128
base:   eca631b8fe808748d7585059c4307005ca5c5820
patch link:    https://lore.kernel.org/r/20241015143713.2017626-3-perdaniel.olsson%40axis.com
patch subject: [PATCH v3 2/2] iio: light: Add support for TI OPT4060 color sensor
config: powerpc64-randconfig-r063-20241017 (https://download.01.org/0day-ci/archive/20241017/202410171258.CFrNPzC1-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241017/202410171258.CFrNPzC1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410171258.CFrNPzC1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/light/opt4060.c:836:2: warning: label at end of compound statement is a C2x extension [-Wc2x-extensions]
     836 |         }
         |         ^
   1 warning generated.


vim +836 drivers/iio/light/opt4060.c

   807	
   808	static int opt4060_write_event(struct iio_dev *indio_dev,
   809				       const struct iio_chan_spec *chan,
   810				       enum iio_event_type type,
   811				       enum iio_event_direction dir,
   812				       enum iio_event_info info,
   813				       int val, int val2)
   814	{
   815		struct opt4060_chip *chip = iio_priv(indio_dev);
   816	
   817		switch (info) {
   818		case IIO_EV_INFO_VALUE:
   819			if (chan->type == IIO_INTENSITY && type == IIO_EV_TYPE_THRESH) {
   820				u32 th_lo, th_hi;
   821	
   822				if (opt4060_get_thresholds(chip, &th_lo, &th_hi))
   823					return -EFAULT;
   824				if (dir == IIO_EV_DIR_FALLING)
   825					th_lo = val;
   826				else if (dir == IIO_EV_DIR_RISING)
   827					th_hi = val;
   828				if (opt4060_set_thresholds(chip, th_lo, th_hi))
   829					return -EFAULT;
   830				return 0;
   831			}
   832			break;
   833		case IIO_EV_INFO_PERIOD:
   834			return opt4060_write_ev_period(chip, val, val2);
   835		default:
 > 836		}
   837		return -EINVAL;
   838	}
   839	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

