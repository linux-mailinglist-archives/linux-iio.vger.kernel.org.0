Return-Path: <linux-iio+bounces-22570-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A4DB209A6
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 15:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0676E1891C62
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 13:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5120F2D8379;
	Mon, 11 Aug 2025 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tra6V5YM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909112D3A97;
	Mon, 11 Aug 2025 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917741; cv=none; b=ex34lK6bnVUSiRfMXWD73g+J4z6n7wsqcYlMUrolkFxHTsnyfEoUOVri0UQIb+XVxp2LoBOBewEcR4h1zMKjCzYZ85ubJAzA+D6R7wNoTpNIrm7rGpbymagefY0fY0FbdJbis7BKBM9jyAZGSHWCqOVxroSheyv+dXXzrzQDnUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917741; c=relaxed/simple;
	bh=VzHXqC2FOe2KCOSC1mIYSSArknEXZse0xSxw2U8P/cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5cSxXi2wGNY3qo6LNv1AzRz6b1CqqcJdRNOA+HKEOKruK4W/WFyv051D04A3YgBPnAUvjOT3S2VPLZSv8C8/ZABtGmgimVGKQ96jebsBRDS8k5AfkRfflkcR5BoQnWQ3Kp5h+NJ+0+Yk59vcBaIkaG2o/VnlEO2aR2nB/Yq2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tra6V5YM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754917740; x=1786453740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VzHXqC2FOe2KCOSC1mIYSSArknEXZse0xSxw2U8P/cY=;
  b=Tra6V5YMxC3x21GNYLJziXD0Rnf9ljiQ/kSCA9YLNy5M08IXB+XgZQ53
   1O5aBr5gKenHUOvZbbztKC+9w9OgB7IcfQ1iw0Rf4fkUWjE+nRCttpM75
   NYq1viBhF2/0OkinhrlUYbZdX8oVBhNOJNwV16gMT7KJ2fg9Fp598cAF7
   Xqm9SUo6siaWJsX0wVDGF3mVVVqNnQYBUwWyl2mVivRAvGgHtL0pUkWpW
   0qxCSkue8a4zmloMvsZI/JTt6JbhK5NIMly5+QMrYH2cYQgE624u2h3UB
   +0AqW0lbmfldoqFw7udtwhCCxwc7xGVO0PdOBboHjmNEJdAj/spS/h53z
   Q==;
X-CSE-ConnectionGUID: SJOFSmPxR5+Onqc2tk4Ukg==
X-CSE-MsgGUID: 11yP72t1T8yNPg/R3doQJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68248671"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68248671"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 06:08:59 -0700
X-CSE-ConnectionGUID: TlO0PjuDSnS/tPNXZ569Mw==
X-CSE-MsgGUID: gZI7L7K9SmGcZ/GX2cWytw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="189592004"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 06:08:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ulSGj-000000052lp-0ay9;
	Mon, 11 Aug 2025 16:08:53 +0300
Date: Mon, 11 Aug 2025 16:08:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: liziyao@uniontech.com
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yao Zi <ziyao@disroot.org>,
	WangYuli <wangyuli@uniontech.com>, Jun Zhan <zhanjun@uniontech.com>
Subject: Re: [PATCH] iio: imu: bmi270: Match ACPI ID found on newer GPD
 firmware
Message-ID: <aJnrZNCpBYD92-n1@smile.fi.intel.com>
References: <20250730-bmi270-gpd-acpi-v1-1-1ffc85b17266@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730-bmi270-gpd-acpi-v1-1-1ffc85b17266@uniontech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 30, 2025 at 08:56:16PM +0800, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <liziyao@uniontech.com>
> 
> Some GPD devices ship a buggy firmware that describes on-device BMI260
> with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40,
> let's match the correct ID to detect the device. The buggy ID "BMI0160"
> is kept as well to maintain compatibility with older firmwares.

I think I saw this patch already and there was even an (unfinished)
discussion...
https://lore.kernel.org/linux-iio/20250730-bmi270-gpd-acpi-v1-1-1ffc85b17266@uniontech.com/

So, why are you sending the same patch again?

-- 
With Best Regards,
Andy Shevchenko



