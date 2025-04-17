Return-Path: <linux-iio+bounces-18212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E064AA9233F
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 19:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2543B5E0E
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 16:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C763A2550B6;
	Thu, 17 Apr 2025 17:00:01 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86641D5CF8;
	Thu, 17 Apr 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909201; cv=none; b=ePpRW9XED0I+ngvqat1REd9+BJheHhYvPdRT58/QfA/ab7AKNXPOha16i6e9EA03ME7RTigfR1IfHihYLdYElSbIhqWnGP4RCafqMIzWV0rpQV9FW0Qgc39vOyT9FXZnw/0CG2B+7nWC7ys/D/cdLxh2XSxlL++RYPhr2OcZIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909201; c=relaxed/simple;
	bh=G3ce7TmoAzipkk+YWHvblWF+GzIYLtfn6pbvWy71+Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKx42VJaikffNMVGvvYCbBbPsBy58Zw1WRsPDUK/jgfl4/6ONib4LAa9ojWcUgTA9TWORSmvfzmfNnqRHEkzgwGjduMEagJ8kQRUfKWLFyBLa0BJpl5jlA9Vrc7I9Jq4VVz/3BJGLNTGzew39sfs9IHszRPceniZEn2h1b3v0w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: qDaNjaHmQo2c1bLp9h017g==
X-CSE-MsgGUID: wPqEdL6XQQOnlmaUxtGLaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="50319332"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="50319332"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 09:59:49 -0700
X-CSE-ConnectionGUID: 7jhBxJh8R6SNFsGSuYbh8A==
X-CSE-MsgGUID: tfqBq1xGRnqHLb9ZbCHoBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="131848343"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 09:59:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u5SaP-0000000DGBC-21Cu;
	Thu, 17 Apr 2025 19:59:37 +0300
Date: Thu, 17 Apr 2025 19:59:37 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 6/8] iio: imu: adis16550: align buffers for timestamp
Message-ID: <aAEzeY_p6a8Pr-zn@smile.fi.intel.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
 <20250417-iio-more-timestamp-alignment-v1-6-eafac1e22318@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-6-eafac1e22318@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 17, 2025 at 11:52:38AM -0500, David Lechner wrote:
> Align the buffers used with iio_push_to_buffers_with_timestamp() to
> ensure the s64 timestamp is aligned to 8 bytes.
> 
>  drivers/iio/accel/bmc150-accel.h | 2 +-
>  drivers/iio/imu/adis16550.c      | 2 +-

Looks like a stray squash of the two independent commits.

...

>  	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
>  	struct mutex mutex;
>  	u8 fifo_mode, watermark;
> -	s16 buffer[8];
> +	s16 buffer[8] __aligned(8);

As for the code, would it be possible to convert to actually use a sturcture
rather than an array?

...

>  	struct iio_poll_func *pf = p;
> -	__be32 data[ADIS16550_MAX_SCAN_DATA];
> +	__be32 data[ADIS16550_MAX_SCAN_DATA] __aligned(8);
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct adis16550 *st = iio_priv(indio_dev);

Ditto.

-- 
With Best Regards,
Andy Shevchenko



