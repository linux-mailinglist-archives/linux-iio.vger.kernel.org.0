Return-Path: <linux-iio+bounces-18340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8F1A944BA
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 18:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8733B16B239
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 16:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5301DF751;
	Sat, 19 Apr 2025 16:39:28 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53147288D2;
	Sat, 19 Apr 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745080768; cv=none; b=mDVx0uZ26enKKKBCpv/cjBSAHkZ/En3mzbYE3mDhacy4CtmVf8lJuC4uuk53oQVQaR+ZCISvG8sYp9GX5qDVr8QbG5pwnPZ80JJipKLVqQzmO+OFKY6gCJ4krZzlsCwdIR1Z4vzaw2MghGpfi9qHFc4l0aQrYGf4cgvDzIIT2Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745080768; c=relaxed/simple;
	bh=qVRHx+fvVVctJLWeVOHjWpiJuvXtO0CJd7eEtH8c3uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otwxztQtiaa1uOfM20LqEkIVXMx90eGipH+qgzJAeUMJ7Bi64gm7byXyjeq5m64d6i1O4hfGLlpt7aA/eiF7nShTythuFAUHkxT7KuO0oGkVwQ+6sdHczz/JdDxw36ifPZbgn3kZaPzJ/Q1VyU/cGSFTOUYpNgYMdZbGY8eqEMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: toUQAvcWS3K6Nhomq8NBfw==
X-CSE-MsgGUID: yTe2NLMtSkWPsu2wU9VSlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="58049322"
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="58049322"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 09:39:27 -0700
X-CSE-ConnectionGUID: OJ+p/KYFS9ujiHuKm0CW5A==
X-CSE-MsgGUID: dPw+N41HSoS1tjbfnY9qvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="136220407"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 09:39:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u6BDu-0000000DrqN-0gQB;
	Sat, 19 Apr 2025 19:39:22 +0300
Date: Sat, 19 Apr 2025 19:39:21 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: pressure: bmp280: use IIO_DECLARE_BUFFER_WITH_TS
Message-ID: <aAPRuUZTWQZr9Y6H@smile.fi.intel.com>
References: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
 <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-4-ee0c62a33a0f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-4-ee0c62a33a0f@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 18, 2025 at 05:58:35PM -0500, David Lechner wrote:
> Use IIO_DECLARE_BUFFER_WITH_TS to declare the buffer that gets used with
> iio_push_to_buffers_with_ts(). This makes the code a bit easier to read
> and understand.
> 
> The data type is changed so that we can drop the casts when the buffer
> is used.

This one is good, with the comment to have it DMA aligned.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



