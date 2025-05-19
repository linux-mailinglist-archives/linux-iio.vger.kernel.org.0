Return-Path: <linux-iio+bounces-19670-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0629EABBD97
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 171C57A79D4
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 12:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B441A27780E;
	Mon, 19 May 2025 12:19:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13009267B9F;
	Mon, 19 May 2025 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657165; cv=none; b=Yh5FLpqHoW21Gehczk4v6l/db1wqD9j8efENyM70CLgCNbRMW/0fGbg5mKnoIJJi0AVuzcFrYLPiDJqrc6YhuvZVnryGM1hUXV1z6wE3ir9AuJPmQdB5AlZuWoGNlegJWNyp1BghTdppIa1BBC0L3T/Non999Zn5HKgQMoGpZec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657165; c=relaxed/simple;
	bh=iADNEAYrNZtJETpUlGNLpdWpRegUl4ENkmhjZSXboto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4nheCMGVTMYppznm1rtGTqu9SmouWwqfEILcYkl1mmbRRfMlcqDse+H5fL1Lb2XkMQsk0fOveDhbiEQga3mueF4tapoX3bHc0Np5/UZxww+GkpXNnvCLQPeFThVQhK+AJqKDQ2p3++ezEZynRX9pPmKG+CQEiVge220hQ4qa08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: p4ymKJWdT7K8J6CeE0n2iA==
X-CSE-MsgGUID: QUiDZi2+RSiYXvqJ7VzBdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49658128"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="49658128"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 05:19:23 -0700
X-CSE-ConnectionGUID: oRZygWbkRhyO/xZ6v1wvDw==
X-CSE-MsgGUID: N08AOnqyTB6Zivp042cW6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139396661"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 05:19:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uGzSg-000000031st-01Ib;
	Mon, 19 May 2025 15:19:18 +0300
Date: Mon, 19 May 2025 15:19:17 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 11/12] iio: accel: adxl313: implement power-save on
 inactivity
Message-ID: <aCshxSTfh88KN6Hx@smile.fi.intel.com>
References: <20250518111321.75226-1-l.rubusch@gmail.com>
 <20250518111321.75226-12-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518111321.75226-12-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, May 18, 2025 at 11:13:20AM +0000, Lothar Rubusch wrote:
> Link activity and inactivity to indicate the internal power-saving state.
> Add auto-sleep to be linked to inactivity.

...

> +	en = en && act_en && inact_en;
> +
> +	return regmap_update_bits(data->regmap,
> +				  ADXL313_REG_POWER_CTL,
> +				  ADXL313_POWER_CTL_INACT_MSK,

> +				  en ? (ADXL313_POWER_CTL_AUTO_SLEEP | ADXL313_POWER_CTL_LINK)
> +					  : 0);

Make it a logical split

				  en ?
				  (ADXL313_POWER_CTL_AUTO_SLEEP | ADXL313_POWER_CTL_LINK) : 0);

-- 
With Best Regards,
Andy Shevchenko



