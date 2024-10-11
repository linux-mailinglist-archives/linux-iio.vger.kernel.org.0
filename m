Return-Path: <linux-iio+bounces-10443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1B699A0C0
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 12:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D689286257
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 10:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E035B21018E;
	Fri, 11 Oct 2024 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oma2UJwS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F08A20B1F8;
	Fri, 11 Oct 2024 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641114; cv=none; b=E3GuRad+D9a7YINq1t+xnaywHym/31oqZ3sjHvmCLzg9vtlKSltrSdF1dAXIiYTnOKRUm+0/0gBsQCexM0anOP+we+EcMV+1nyFgynxcTYdqIXMl+vnwqgHEkwGtN3Yp7xQPEj6a9WBQzKpD42pHVrv/eICFQwgDaNH5gjj8MW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641114; c=relaxed/simple;
	bh=MXoxiougZXiTgUX469bvtnN8pIBhKWJE5rNRnVjI2g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuD2JvkLWTcgwONL0LQ8WX1GFaRfo0BXDo7p1Lm2yKuxG4A6m99tgJYXEsCzgTgU4MbqhDECt6gS/3dMf99LvZae3yE7uPBs7kAz37l9f3CD3JwYJb7hrIgUid5OnNlYJDjdDoYJ37+EN+BUE6R5eZmP7+qXD8BbaH8QagFwHx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oma2UJwS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728641113; x=1760177113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MXoxiougZXiTgUX469bvtnN8pIBhKWJE5rNRnVjI2g0=;
  b=Oma2UJwSGHJ4HnHfKCCRadghskCpTXKWf7KTXi9ImOr3AUf0FEmHwZGH
   PzLan37V0Qg9klC28Dy4A9t2CyZgr49NYx/HHrxnlFh2OlD059bNIW8qA
   JdjjUXq4cnIJfsQ1Y9cZ57mNsNwXixVNMkKu6pNZh0K2GZtiWbH/s4nXl
   /Yr1ensAF07BEFaKCCs2xS+hqFEQ681KxtGgBsgDP2NSUDdrpt4MnMh6f
   yL694McWyVlQ91f5USM5fcMEwLP42Zysa579DryVI5bArlRXW1DwSXVu/
   /qITPWKpipvEgSiFD47vuwglWmcD/t8X1AncDIUevg/JPFDE/GVFCtuU/
   w==;
X-CSE-ConnectionGUID: JEsDS1AiRAeEYtOMADBVNg==
X-CSE-MsgGUID: TntkUBmlRzeHEpmn3UXyZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="45547252"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="45547252"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:05:12 -0700
X-CSE-ConnectionGUID: pMbrIA4jTu2hDihcSFZaMg==
X-CSE-MsgGUID: X6fo7PMWTyuzleENn1HS0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="76771433"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:05:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szCWB-00000001qsk-0kFj;
	Fri, 11 Oct 2024 13:05:07 +0300
Date: Fri, 11 Oct 2024 13:05:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: vamoirid <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/13] iio: chemical: bme680: add regulators
Message-ID: <Zwj4Unpcq2w7V4eq@smile.fi.intel.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-8-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010210030.33309-8-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 10, 2024 at 11:00:24PM +0200, vamoirid wrote:
> From: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Add support for the regulators described in the dt-binding.

...

> +static const char *const bme680_supply_names[] = {
> +	"vdd", "vddio"

Leave trailing comma.

> +};

...

> +	devm_add_action_or_reset(dev, bme680_regulators_disable, data->supplies);

No error check?! Why?

-- 
With Best Regards,
Andy Shevchenko



