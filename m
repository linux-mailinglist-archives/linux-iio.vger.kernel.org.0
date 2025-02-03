Return-Path: <linux-iio+bounces-14898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B19EA25669
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 10:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5F81888BE3
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C66200B8B;
	Mon,  3 Feb 2025 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REoksRi2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026A0200110;
	Mon,  3 Feb 2025 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738576491; cv=none; b=fg8GY7B6Ua7Q4Niiu6pkJ4pK9hGL9MBi9cPDOfSq9G2W/CDOAsqYJ7TvN3+/tgQXuLY19RyVYS0YiWy13V4EZicpDr6OMonFX17HYzCpwpQhGHJOOPAD1y3MjqEslbdSwBZ4gw88ZSIm9Ar6OA5Jx4mlNYp+XHK1dCvT8hXmKGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738576491; c=relaxed/simple;
	bh=KJnOkYtT1ER85ByY/bbuxKI0+JwWGZWTTEdR1gu+f4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paQykiBeqtAhv0Ktb3axPXnfcY68M/eeih0CftZRmnsbF7anWRkTj5CLDrjG0bAVdNWKpDREaJVWwMgDAJQ6r/S5eM5/a1AcPXFJhTE6IrrdZzSbDbjfWfFeIwwtJtfIziJf7nvWy+7iJ0snWYc9gSwS91hPTnxFpR6yRy76Kog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REoksRi2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738576491; x=1770112491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KJnOkYtT1ER85ByY/bbuxKI0+JwWGZWTTEdR1gu+f4I=;
  b=REoksRi2VbTERBJt9riuR1JG/rpMeZLDVi0BhNpLGgWPqeWmcSFvGfg1
   SrpTqSFPbB1IrGdBmTktYF9IiSCPRvKgpvMpUTMLMqAlYP2Q46km0kOBb
   6YoM44hJnKYGAl1GkkBme6qgSR/yAHQgHjC9Usn7gxNIiQt0CSE90om2z
   o4ui6CbazQKmEDMtUam2kysrECEBX2n0hWebDiYEb1M2OxPN44SEUtf+t
   4QPfmc/hXg+1VPZPv26qrQhin1+AFYv1ixx0NPHcyeEGclaGKQy4YX+6x
   07K/F/Qp41S/401RzsjwYKpnq+CZxJ7c2QxxlgQ/CcTvAfd4xDajnEosX
   g==;
X-CSE-ConnectionGUID: nbiInCkGRE6o+z7K6wuvWQ==
X-CSE-MsgGUID: cfZQXkwmTVuRc07HbXteOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="39091490"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="39091490"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 01:54:50 -0800
X-CSE-ConnectionGUID: YPRhewxmQXyiWi36uMVMJA==
X-CSE-MsgGUID: 1FrmQi9ZRGWHzcUxM2kYPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110819325"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 01:54:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tetAA-00000007n3q-2OgN;
	Mon, 03 Feb 2025 11:54:42 +0200
Date: Mon, 3 Feb 2025 11:54:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
	jic23@kernel.org, przemyslaw.kitszel@intel.com,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 14/20] iio: adc: xilinx-xadc-core: use
 devm_kmemdup_array()
Message-ID: <Z6CSYn7ZDVNELIIv@smile.fi.intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
 <20250203080902.1864382-15-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203080902.1864382-15-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 03, 2025 at 01:38:56PM +0530, Raag Jadav wrote:
> Convert to use devm_kmemdup_array() which is more robust.

...

> -	channels = devm_kmemdup(dev, channel_templates,
> -				sizeof(channels[0]) * max_channels, GFP_KERNEL);
> +	channels = devm_kmemdup_array(dev, channel_templates, max_channels,
> +				      sizeof(channels[0]), GFP_KERNEL);

I would use more regular sizeof(*channels)

>  	if (!channels)
>  		return -ENOMEM;

P.S. For all sizeof() replacements the changes would probably need the updated
commit messages.

-- 
With Best Regards,
Andy Shevchenko



