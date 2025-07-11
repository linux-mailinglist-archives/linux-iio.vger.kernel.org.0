Return-Path: <linux-iio+bounces-21575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8E2B02209
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 18:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02414A4A44
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 16:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23FE2EF289;
	Fri, 11 Jul 2025 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnCh/mrq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1617017A2EB;
	Fri, 11 Jul 2025 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252080; cv=none; b=Yq9gTotkqExCNvD9Skq/Nz37FhsVSh5igJ73F5KS+K5ZUFDD3Xxl5uEPwB3tviky0bOmY6ojGwzDKT8IKZrLJ6HcM46o9tEggpAJNPJD/wBYLeSWA+C/9k7w0tkIbIXYg21Uu/dGNAWnsbEgGcSWS4NLHn0KT9aBTXdoYsEejMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252080; c=relaxed/simple;
	bh=8kydQt2ygMjXzniEw5vV9D8q+lxtwQSx5VEjcx4nSVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtWjf96/1bnIZIvIb41HkXS6FEnHrM5AjfnoVG+2blDdQ6qszVTQ5eu0BKxmHWOAIoqrpeUfmeLHKNhWT6O8uIqJc+W+MEF/DibVScwDbqOLazN0rdqAYccVEzbGG/nHq/1S6XQUZy1CcmXLO+RZXZuMaEkQjoPg7vfbrJm1lJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnCh/mrq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752252080; x=1783788080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8kydQt2ygMjXzniEw5vV9D8q+lxtwQSx5VEjcx4nSVY=;
  b=ZnCh/mrqV03v2MPKRPsigl2wppajIlzmSvljg8ElLLJX+Btd/fHIK/DP
   w9wUSxTmZHWxeQy7jbZHSV1xTm8+7OGAD1I5RWQDm86sYFbLlrmICUYaw
   5Pfss36UbBGy3HRlkP3VzndV/2haisRkNF+eFEO+95WJ5FOjIjD8pFcLm
   M+xRq7wtJ36Y9mDwtQRmipMaH0D9tMYF1349ca9Wqdn0I0tbFVuLNUqhz
   lanIZpEJwnuTtPYcT1jacg6i1b8oKZc5G29k0QuK6DeniDBVnYshsOAQ7
   iMipV7TygpE1yokPSgv6odA6h6tT2bGwckRwmzD7+iNMq1PBlTOo1b+5O
   A==;
X-CSE-ConnectionGUID: +OZ2Xt5eQRuEBRqK+s88TQ==
X-CSE-MsgGUID: PfDJZGXtSyO1EpryzPL4PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="77096042"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="77096042"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:41:13 -0700
X-CSE-ConnectionGUID: K0dk7m6yQXqKPB0/9iXeEA==
X-CSE-MsgGUID: CHhhCQzSTwGuSmoqvZ/Lrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="161977387"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:41:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uaGo7-0000000EaJz-3roP;
	Fri, 11 Jul 2025 19:41:07 +0300
Date: Fri, 11 Jul 2025 19:41:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: maxim_thermocouple: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS()
Message-ID: <aHE-o5_TvGtUyHoI@smile.fi.intel.com>
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711-iio-use-more-iio_declare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 11, 2025 at 10:33:55AM -0500, David Lechner wrote:
> Use IIO_DECLARE_DMA_BUFFER_WITH_TS() to declare the buffer used for
> scan data. There was not any documentation explaining the buffer layout
> previously, and this makes it self-documenting. The element type is
> also changed to __be16 to match the format of the data read from the
> device. This way, the count argument to IIO_DECLARE_DMA_BUFFER_WITH_TS()
> is just the number of channels rather than needing to calculate the
> number of bytes required.

...

> +#include <asm/byteorder.h>

Hmm... I see nothing about this change in the commit message.

-- 
With Best Regards,
Andy Shevchenko



