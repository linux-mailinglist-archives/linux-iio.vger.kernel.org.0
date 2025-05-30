Return-Path: <linux-iio+bounces-20053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5B7AC9532
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 19:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCD918987F8
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 17:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F20B27602C;
	Fri, 30 May 2025 17:48:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679B62750E5;
	Fri, 30 May 2025 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627305; cv=none; b=h7xvjPHXk2KiztMPh6PLvbwmI+vTKVvJuwzLeLxJAc9jZGmmPTWim554yeekHOE0TFtfWZyGoV1p8Gpo7TqJsVATw10BnWqvp8pqSlJuQmygbmasdCRUmBeRLpcQ5Uf0FrfwYzNRKoElOiYWM29CWhomZxn/Qzh+5uQrEbEbGXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627305; c=relaxed/simple;
	bh=HLmoRR9KlIZ8piArreFCVFLQ4zV2DBK/8NZj4sG2M5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZ9n3DEcEWEBrsUYc0hIrBNJJEBrdAvdeKEyV0tGWEamR0ErOtH3Ur7+/fVIMEJT2ijKC750ENJGgg3ro1F/5gaqa0DTgD69D53qROUeU3MWfnxy6+O2rMRhm2XY4kafYkTMT966oJ0SuJ356LRlY93D9YBsbebtXkLBTFtl0ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: LfXK2lsqQliMp6lXSaAswQ==
X-CSE-MsgGUID: kXwmtcGrQiqHD6VnL9Qmdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="73258660"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="73258660"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 10:48:23 -0700
X-CSE-ConnectionGUID: tVOOSeadQmOnJ/ryHd9eaA==
X-CSE-MsgGUID: eMHCR7kpSySDj6/J1Wt9OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="148725215"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 10:48:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uL3q3-000000024Yk-05lj;
	Fri, 30 May 2025 20:48:15 +0300
Date: Fri, 30 May 2025 20:48:14 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com,
	rafael@kernel.org, djrscally@gmail.com
Subject: Re: [PATCH v9 01/12] device property: add
 fwnode_find_reference_args()
Message-ID: <aDnvXkwDSh_RCd7K@smile.fi.intel.com>
References: <cover.1748447035.git.Jonathan.Santos@analog.com>
 <55924e747e4891ae75288343d9f3ad2361174bd2.1748447035.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55924e747e4891ae75288343d9f3ad2361174bd2.1748447035.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 29, 2025 at 07:48:17PM -0300, Jonathan Santos wrote:
> Similarly to fwnode_find_reference(), find and return a named reference
> to a fwnode handle, including its arguments. This wrapper facilitates
> cleanup handling and improves readability.

In principle I'm okay with the code, but I probably missed how this new API is
being used (in terms of a need of those arguments to be retrieved).

-- 
With Best Regards,
Andy Shevchenko



