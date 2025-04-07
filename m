Return-Path: <linux-iio+bounces-17743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE541A7D973
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 11:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5219D17244E
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 09:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ACA234964;
	Mon,  7 Apr 2025 09:16:41 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DF9230278
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017401; cv=none; b=kvt1MQmT5fzeh4GMWlz2PQt0dPsJbiou/byjEFqhwISWpsf/MWUz1910JkUzO37GtSGoWeEFnYiL4GTsqvzSZfQ7xC033SgVWPVEKmJUfdSETsNdUAUXz98KQIaRx9NFAS7ociMg1Ug23SZyx+Ha5Mm3k0l9HvQrk4MrzFGaR3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017401; c=relaxed/simple;
	bh=F2eDvCscZfvFOYcfJ1GPVBtaGm4agbYTMsPymPzbR9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfPpn74Y5JRm6TFE7YWTG296DZmEHiEI/2nkvHNtXsrMNoGe5pq//fAYsVQXaIh+YLRprMQ6NYjlsFOJEmJEZYbCvvM0MecmQcKnYsnWQprZgtDxONWkxzGLImiWjZ4HQO6DYUO0Z8mVtVV47H4qsxKwEdvZw11mdkMKy6GcOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: EkWHD9cqTbKNGWxmbziEsA==
X-CSE-MsgGUID: Bcx66JrZTWmXf/fm3LO/aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="45560852"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="45560852"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:16:39 -0700
X-CSE-ConnectionGUID: mzrpLOcrQtSs0/0HFmDbqA==
X-CSE-MsgGUID: GoMUZ2U1QJ+LrpgrNG8+Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="165093679"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:16:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u1iao-0000000A12u-2Od7;
	Mon, 07 Apr 2025 12:16:34 +0300
Date: Mon, 7 Apr 2025 12:16:34 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 02/20] iio: adc: ad7768-1: Fix insufficient alignment
 of timestamp.
Message-ID: <Z_OX8irfjEHjdTTs@smile.fi.intel.com>
References: <20250406172001.2167607-1-jic23@kernel.org>
 <20250406172001.2167607-3-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406172001.2167607-3-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Apr 06, 2025 at 06:19:43PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> On architectures where an s64 is not 64 bit aligned, this may

64-bit

> result insufficient alignment of the timestamp and the structure
> being too small. Use aligned_s64 to force the alignment.

-- 
With Best Regards,
Andy Shevchenko



