Return-Path: <linux-iio+bounces-19454-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63A0AB3245
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 10:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92AF93B2C47
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB4925A2CA;
	Mon, 12 May 2025 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdhqRSLm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0E2D528;
	Mon, 12 May 2025 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039958; cv=none; b=EeGEraPhsdgtfGwUNzQ9yzb7yFcY8+A+kt6Dn12XJVy+//nZlX7RlQVcRCGwDheIinIdP6+rZ5cT7SUha8LhIfSnNN0jFzE6hL/E5UW+sMZAXBf0eMGfupLWIkC6cRatv+QcwP2tUjUi/7ZNV2j04Vw5LVQ1qbSc03ZcQnlWNpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039958; c=relaxed/simple;
	bh=H1s87CSwZ2JKJjfemnNKhnv6ZQTwa3//EJnPKiI7jPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTkf+nMkwS0L7ihT4ttQ3aSRUV3FzORIOcP0OuY24zCH3mzpkqPrSH+85zmc9c+QdVImS9zbe+TKrix1e+iaySrTpaS9PfC8L7KZCOQv9nUiLQAEwDbNNmLNIZf4BwBIziQyAKV4EisgRGH8R4Wz4BXOul18bBVxZbazUl8D+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdhqRSLm; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747039956; x=1778575956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H1s87CSwZ2JKJjfemnNKhnv6ZQTwa3//EJnPKiI7jPM=;
  b=FdhqRSLmMctCwVVcvrirrCRyg61R8QWFNhuhIT3Z3JTdnVs0Ihf2bQzd
   nzYPWoxFWl6wdVqiuQsHIqhSuHcg2UrOK/micS3RubRYVDGWlmIVzQGAh
   6kEMth72jMhgynMC8ObPbgyJOJ1TZXu0V2foRPbSBV0MfPiVrO0qWESjf
   HuJs9HetqVmJnnxEOYN36qxNTtxP0LZFLEiVATTKE3FP0x1fn/5GeGOLF
   QdeHEjMkzJfVRx4f50N0dSnaAJ9UbZ+eWL3v0rf02sWDAuf0R6gtm4pL4
   9sk4kx5dXPhBVQT5bun/PUn+w/93GjjoN19DRX+k4XJQtE3Uzv8wHm02U
   w==;
X-CSE-ConnectionGUID: TJ5vvtZPTd6YzJxNEAFTsw==
X-CSE-MsgGUID: qXj23FOdR4O3d6MmJdMDlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="74219939"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="74219939"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 01:52:34 -0700
X-CSE-ConnectionGUID: lSP2aQAaTKq/jGuImn83yQ==
X-CSE-MsgGUID: gWcEeBw/RLOViuN8lAk1Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="142514708"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 01:52:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uEOtd-00000000rom-3jbw;
	Mon, 12 May 2025 11:52:25 +0300
Date: Mon, 12 May 2025 11:52:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Eason Yang <j2anfernee@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com, alisadariana@gmail.com,
	gstols@baylibre.com, olivier.moysan@foss.st.com,
	tgamblin@baylibre.com, antoniu.miclaus@analog.com,
	eblanc@baylibre.com, stefan.popa@analog.com,
	angelogioacchino.delregno@collabora.com, marcelo.schmitt@analog.com,
	tobias.sperling@softing.com, chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com, yhyang2@nuvoton.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/2] iio: adc: add support for Nuvoton NCT7201
Message-ID: <aCG2yfmg-tSq95ur@smile.fi.intel.com>
References: <20250512083156.3300006-1-j2anfernee@gmail.com>
 <20250512083156.3300006-3-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512083156.3300006-3-j2anfernee@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 12, 2025 at 04:31:56PM +0800, Eason Yang wrote:
> Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> 
> NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up
> to 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins
> for independent alarm signals, and all the threshold values could be set
> for system protection without any timing delay. It also supports reset
> input RSTIN# to recover system from a fault condition.
> 
> Currently, only single-edge mode conversion and threshold events are
> supported.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



