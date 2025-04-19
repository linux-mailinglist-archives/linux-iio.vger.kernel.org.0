Return-Path: <linux-iio+bounces-18334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAA1A9448B
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 18:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2438517C572
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 16:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7841DEFFC;
	Sat, 19 Apr 2025 16:18:47 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303EC1DED78;
	Sat, 19 Apr 2025 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745079527; cv=none; b=RjHRoAzk39d1AMyUGj7uWCmKwgl96Xy52b86utqqSe4DtnZ55OxbPmLpD56CbzvBf/4KUAuLrbS7u2zWid5xI7nrDGeKKyJ2SmP4eD3JOogzJd7MSHVCj5VubGD7Vx0HsXULpAiliNMXTsiJuOJT/fTICfYjK5N5VIm0yEpQWRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745079527; c=relaxed/simple;
	bh=3AUDxRjqXiN5/iBzAlsmWSy3p+UK1OTbGeJN1GZjWy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIN7DCGFE7YizAQeOFYPm0EVjjTNu+7jgdcAnECznGsLfIAAkEtwZjm/XV4uV73Ky7JYi915ptTN3pzzCwb5pUcaV960Oa5V55yoXEIb98UF54IWbozfNjI2vmGix2us7FHb7kuZxbkznKsJPMzvq0G/z2Zn1AgiHPN15/0xRC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: jqJ3XHkLSJSVJ3PEhnLvlw==
X-CSE-MsgGUID: lSmXqZ7FTM2eFCGe8z4wFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="64213345"
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="64213345"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 09:18:45 -0700
X-CSE-ConnectionGUID: +UjQRgYSTUS70BtplKaDBg==
X-CSE-MsgGUID: mT5x0cdkSm+T0TwY5bJXbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="132239215"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 09:18:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u6Ats-0000000DrYN-0HwA;
	Sat, 19 Apr 2025 19:18:40 +0300
Date: Sat, 19 Apr 2025 19:18:39 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: orientation: hid-sensor-rotation: remove
 unnecessary alignment
Message-ID: <aAPM3yhLn_aEkrlH@smile.fi.intel.com>
References: <20250418-iio-orientation-hid-sensor-rotation-remove-alignment-v1-1-6da68eae7ecf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418-iio-orientation-hid-sensor-rotation-remove-alignment-v1-1-6da68eae7ecf@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 18, 2025 at 03:08:53PM -0500, David Lechner wrote:
> Remove __aligned(16) in the scan data struct in the hid-sensor-rotation
> driver. There is nothing in the code that requires this alignment.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



