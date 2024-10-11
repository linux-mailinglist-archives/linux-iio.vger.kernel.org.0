Return-Path: <linux-iio+bounces-10450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E951A99A205
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 12:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BECD28133D
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 10:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73C4212646;
	Fri, 11 Oct 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DR4dyFr1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCB319F110;
	Fri, 11 Oct 2024 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644011; cv=none; b=dzAMTWBjtMyDDf64LWbeS9bQFtnD4NXbvnHNZixcVmXRZDpYJkUqZhUoZnGHoyUsUXv/ZLqTsvUrGOxKa8v3Sw+P4eeW/53RPKt45pZp9ecsIUT4SwlYNzUgCJYOZyTb2ZNe1etepX4Z3ubyDBe6yvSpY80YUmpIMut583Q8c2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644011; c=relaxed/simple;
	bh=NYNd9OfIuCbrYYoLUEbZNO/rqyiZW+zgAsaJ8SpxLcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/A4BQaDV9zvqWvOwQvCKX9F7olztMqerL/RCEjZJGrBJH2t2a7pMHbznSNR9Lossf+PWoD4QW8IPvK7ryTwSSmtxb7UbK/mt289vL7ACzYIjfgvxkNeaWShysUGPiMxNZ9NbpLxYHUgZLngq4T/BxonLRNuKXk3r9HevHZ7Doc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DR4dyFr1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728644010; x=1760180010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NYNd9OfIuCbrYYoLUEbZNO/rqyiZW+zgAsaJ8SpxLcY=;
  b=DR4dyFr1UXHlldBsx29WOZ1hSN0luIRBk8nkR4DF7IjVGHpskMkiz50d
   NK9MITPnKetBzrbkr6bN+0V2f6MRa8YRIiSDipsreZacG+I1tZhbhm4b3
   9eQy7Oc+rjDY/Lz8WHqPHbE3xpKNaoRjNwu7AgDqaCLJ8wIKBGYkfEkGS
   cbgmMnBp1mD0kSCsjWctSmxTgfTC9Qm1R5udE6SFX2rQKef7KH0wGwmvU
   dayGCQrKPOL7ZQIgnS8DSRUBGwcFTzZlFPkeJpQjH7b9oSDIQD/J+VDo3
   +vy4tguRTdY/I1BQvk0J54zN0U2LrpZmnMfVJe/Rfk8hQqXfm26Knj2UE
   Q==;
X-CSE-ConnectionGUID: rNV52/vJQpibEafltZNqGw==
X-CSE-MsgGUID: e0WNBGRsQRKr8Xsq81UBfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="39167983"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="39167983"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:53:29 -0700
X-CSE-ConnectionGUID: dmOtC1YnSmq7NF49WTQdRQ==
X-CSE-MsgGUID: OjZo3MXmRA+qBzoUSG5bZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="107729525"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:53:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szDGr-00000001riR-2E3Z;
	Fri, 11 Oct 2024 13:53:21 +0300
Date: Fri, 11 Oct 2024 13:53:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v8 1/4] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <ZwkDoSeXA1T4VD0L@smile.fi.intel.com>
References: <20241007194945.66192-2-vassilisamir@gmail.com>
 <202410111221.YIeXHxOv-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410111221.YIeXHxOv-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 11, 2024 at 12:32:12PM +0800, kernel test robot wrote:
> Hi Vasileios,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 96be67caa0f0420d4128cb67f07bbd7a6f49e03a]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Vasileios-Amoiridis/iio-pressure-bmp280-Use-sleep-and-forced-mode-for-oneshot-captures/20241008-035238
> base:   96be67caa0f0420d4128cb67f07bbd7a6f49e03a
> patch link:    https://lore.kernel.org/r/20241007194945.66192-2-vassilisamir%40gmail.com
> patch subject: [PATCH v8 1/4] iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
> config: i386-randconfig-006-20241011 (https://download.01.org/0day-ci/archive/20241011/202410111221.YIeXHxOv-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241011/202410111221.YIeXHxOv-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410111221.YIeXHxOv-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/iio/pressure/bmp280-core.c:1051:3: warning: variable 'meas_time_us' is uninitialized when used here [-Wuninitialized]
>     1051 |                 meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
>          |                 ^~~~~~~~~~~~
>    drivers/iio/pressure/bmp280-core.c:1046:32: note: initialize the variable 'meas_time_us' to silence this warning
>     1046 |         unsigned int reg, meas_time_us;
>          |                                       ^
>          |                                        = 0
>    drivers/iio/pressure/bmp280-core.c:2452:2: warning: variable 'offset' is uninitialized when used here [-Wuninitialized]
>     2452 |         offset += sizeof(s32);
>          |         ^~~~~~
>    drivers/iio/pressure/bmp280-core.c:2437:17: note: initialize the variable 'offset' to silence this warning
>     2437 |         int ret, offset;
>          |                        ^
>          |                         = 0

Rarely, but looks like this suggestion is okay, rather I would do it as 'else'
branch and convert '+=' in the 'if' part to be '='.

-- 
With Best Regards,
Andy Shevchenko



