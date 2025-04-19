Return-Path: <linux-iio+bounces-18339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EB7A944B8
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 18:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A2C3BB4FA
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5331DF75C;
	Sat, 19 Apr 2025 16:38:38 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D21DE8AD;
	Sat, 19 Apr 2025 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745080718; cv=none; b=tO8DKtnKLjYvRH/3tuCNKcO16Qqj/l2JIzZsl0r4jS0OYb8+ovxQpxixBjjB6fcHgjk21dB+8vcOMUILW9TyZo0oizIABXNRJR/3bfqlc1wt+08E+Yo3eK+pU92/MpanwqS0o7K8ldGNX4D7bCTDnxjc73Tyr/E32uQzTssOinI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745080718; c=relaxed/simple;
	bh=O/j+gQWmz0a1us1EXCQNyP26wNLShgFqPYItEsMHs1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tN9QNQtMQSP3h6Gwz7w/p+KuJNugVtB2EWXnSawXXcnVPSGj6S+sKtuOAQ6YYDH2xKoFWUyoQTUQEu33T6NhQYK/0LUPYPqLKCxhser7pBun2er1ZCAQAdjf1hDaNidqUNQq8Auv+fg4j9+9swGHQMxgl7SaJzzfrE9eiKCyoMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 8XQkogKRSha8PipEnNYjPA==
X-CSE-MsgGUID: KB2ktOQnTbe7T8N55IieOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="64086407"
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="64086407"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 09:38:36 -0700
X-CSE-ConnectionGUID: HP+GvsW5QXqbXGENvexwCA==
X-CSE-MsgGUID: zcGtAcCsS32MXFImlpL0zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="132330410"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 09:38:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u6BD5-0000000Drpp-2vDU;
	Sat, 19 Apr 2025 19:38:31 +0300
Date: Sat, 19 Apr 2025 19:38:31 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: adc: ad7380: use IIO_DECLARE_BUFFER_WITH_TS
Message-ID: <aAPRh7f0M9fA3U5a@smile.fi.intel.com>
References: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
 <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-3-ee0c62a33a0f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-3-ee0c62a33a0f@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 18, 2025 at 05:58:34PM -0500, David Lechner wrote:
> Use IIO_DECLARE_BUFFER_WITH_TS to declare the buffer that gets used with
> iio_push_to_buffers_with_ts(). This makes the code a bit easier to read
> and understand.

...

> -	u8 scan_data[ALIGN(MAX_NUM_CHANNELS * sizeof(u32), sizeof(s64))
> -			   + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
> +	IIO_DECLARE_BUFFER_WITH_TS(u8, scan_data, MAX_NUM_CHANNELS * sizeof(u32))
> +		__aligned(IIO_DMA_MINALIGN);

Why u8 and not u32?

-- 
With Best Regards,
Andy Shevchenko



