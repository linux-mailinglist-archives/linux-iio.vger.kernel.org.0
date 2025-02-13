Return-Path: <linux-iio+bounces-15509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AA7A351BE
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 23:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D171888D15
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 22:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CEA2753F2;
	Thu, 13 Feb 2025 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mw+QsdMs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DAA2753E4;
	Thu, 13 Feb 2025 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487525; cv=none; b=BAmbrXCT9htpCbDC2LdL880dwmC9P5jCpvmDo+ipGyq4BTdPdBTsqRQCgOE60pUo57ZJcU2CBlnLJuQ1NV7UvpCO3HUwRQoAhvkNqt+rkeOU365eh4Nr55ke6SoN7kXWkDrwZWD0GfcgDcqY8AXYwxfTX21xGf+xNk1UYwDce2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487525; c=relaxed/simple;
	bh=JVrIfR2b7Zw5tphgm7dmRrPq3bFn2dAIdtlGx9/51vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S34cffam5fP5tYhCo9M7kMnljzC2LIWaU/aEwFuah1p2xeBNleRhAyJPW6NTx8iq0Oz8i97FJOZArXLP/ORI+p8yOxF9tfj3PhDMyQXt1xDUTgbQesCEbGlWsIIYW5R702JPkafMsPKR9rFqguLkGEjlo2qAVuIHyM4PBbF59rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mw+QsdMs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739487524; x=1771023524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JVrIfR2b7Zw5tphgm7dmRrPq3bFn2dAIdtlGx9/51vk=;
  b=Mw+QsdMshJosyrmllhx7VeZt0nppm/FBiQfBL9BLL/sV+EMPSdtTuJPF
   i7+7QHwwKmqQOHKjEHDlVQZuyjJKuIqSwz/lu8EjKYxgPR1DojySv5Lta
   UCUzVrW6zn6LgSKQFFv37kimIbLNVKecvxIOlZQ2lyyvzbcAjnyFgU+0J
   PdfpI8fqlILOopvZb9rTRB+fWO10JBjaO4KIK9km5MOJjEokXxO0FO2cV
   GVCmzjl89qrJw6KJXy1yHNgxVVwfOsFoXGd5Conn6VEBH4gPPX8Z3mgw6
   B4jrTVfnlD824nOvGLrhMNuvjEn+OCiQ+hk0BNYLIhYEUQ8/oPJ4qlSdU
   A==;
X-CSE-ConnectionGUID: f41P3VHkR0CTg37QB5w64g==
X-CSE-MsgGUID: IZZFlNMBQA6gweqJZUlo0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40340106"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40340106"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:58:43 -0800
X-CSE-ConnectionGUID: Vo36sgjRSCusd9Bp7qRkhA==
X-CSE-MsgGUID: KBz5hXtISISEmI5lrNKflA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113774073"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Feb 2025 14:58:40 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiiAH-0018nP-25;
	Thu, 13 Feb 2025 22:58:37 +0000
Date: Fri, 14 Feb 2025 06:57:52 +0800
From: kernel test robot <lkp@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Jonathan Santos <Jonathan.Santos@analog.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jonath4nns@gmail.com,
	marcelo.schmitt1@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH RESEND v3 11/17] iio: adc: ad7768-1: add regulator to
 control VCM output
Message-ID: <202502140626.PzhgxFMq-lkp@intel.com>
References: <3552833157f252f3b6813f0042059e858c90d53a.1739368121.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3552833157f252f3b6813f0042059e858c90d53a.1739368121.git.Jonathan.Santos@analog.com>

Hi Jonathan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5de07b8a24cf44cdb78adeab790704bf577c2c1d]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Santos/iio-adc-ad7768-1-Fix-conversion-result-sign/20250213-022329
base:   5de07b8a24cf44cdb78adeab790704bf577c2c1d
patch link:    https://lore.kernel.org/r/3552833157f252f3b6813f0042059e858c90d53a.1739368121.git.Jonathan.Santos%40analog.com
patch subject: [PATCH RESEND v3 11/17] iio: adc: ad7768-1: add regulator to control VCM output
config: loongarch-randconfig-002-20250214 (https://download.01.org/0day-ci/archive/20250214/202502140626.PzhgxFMq-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250214/202502140626.PzhgxFMq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502140626.PzhgxFMq-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "rdev_get_drvdata" [drivers/iio/adc/ad7768-1.ko] undefined!
>> ERROR: modpost: "devm_regulator_register" [drivers/iio/adc/ad7768-1.ko] undefined!
>> ERROR: modpost: "regulator_list_voltage_table" [drivers/iio/adc/ad7768-1.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

