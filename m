Return-Path: <linux-iio+bounces-19768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE9FABF13E
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 12:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EEDC7ABCE3
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 10:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D1925B695;
	Wed, 21 May 2025 10:16:19 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03CC25A2C7;
	Wed, 21 May 2025 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822579; cv=none; b=EeW9mjueRlJVpFefOUhvLxpnNfID+z4gIKw6z128Z5oU8ItR39XbuZ/e9wUasgEskQdPU+/g3orRmjWvs8IUGfV3vbDO7mFw62I/QvLgi5249JlNMwqkfunNDemH0iAdz4ODY2tOCCT7MPYDCdIlUkgLQ2PjTGFaiHq1ds1qClY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822579; c=relaxed/simple;
	bh=6T1QUc/amUE5rsNgEE10e/znSfETAyKzzFtKKUT26m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nt+qgXFpuhtGqO4xlIiNSDK5Cpai9I1qUaY3wnSgzTSLGWWJrk2hYAkDiC/yoLcxhDjQZx1UzYpd3v7kYQ29Q09vAZLmnxyLSSKJ4kNWzIhB0wvZK49VQExEeeCHhSa0gYxx4gN+yYKiZSSbD9fmP/Bwjnf0hvlWbaFbdvnY5oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 2ow+Ga8wT1eXx7zNMU8Auw==
X-CSE-MsgGUID: HBFHxumzSmuthN6rNTvMhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49667007"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="49667007"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 03:16:06 -0700
X-CSE-ConnectionGUID: BXhdV1A+QI2fjeweGsmcRA==
X-CSE-MsgGUID: rNvr0/6OSvCAuxoonGGq5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="140937255"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 03:16:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uHgUS-00000003aGi-1Na8;
	Wed, 21 May 2025 13:16:00 +0300
Date: Wed, 21 May 2025 13:16:00 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/12] iio: accel: adxl313: add FIFO watermark
Message-ID: <aC2n4OuzzcMTxudT@smile.fi.intel.com>
References: <20250520225007.10990-1-l.rubusch@gmail.com>
 <20250520225007.10990-9-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520225007.10990-9-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 20, 2025 at 10:50:03PM +0000, Lothar Rubusch wrote:
> Add FIFO watermark configuration and evaluation. Let a watermark to be
> configured. Evaluate the interrupt accordingly. Read out the FIFO content
> and push the values to the IIO channel.

...

> +	const unsigned int fifo_mask = 0x1f, watermark_mask  = 0x02;

Seems you have some (wrong) setting in the text editor?
One space too many again...

...

> +static int adxl313_fifo_push(struct iio_dev *indio_dev, int samples)
> +{
> +	struct adxl313_data *data = iio_priv(indio_dev);
> +	int i, ret;

Why is 'i' signed?

> +	if (samples <= 0)

What is the semantics of the negative samples? Is it an error code? Why not?
I believe it's ignored again from my previous review.

> +		return -EINVAL;
> +
> +	ret = adxl313_fifo_transfer(data, samples);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i  < ADXL313_NUM_AXIS * samples; i += ADXL313_NUM_AXIS)

Ouch, one space too many, *again*!

> +		iio_push_to_buffers(indio_dev, &data->fifo_buf[i]);
> +
> +	return 0;
> +}

...

> +static int adxl313_push_event(struct iio_dev *indio_dev, int int_stat)
> +{
> +	struct adxl313_data *data =  iio_priv(indio_dev);
> +	int samples;
> +	int ret = -ENOENT;
> +
> +	if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
> +		samples = adxl313_get_samples(data);
> +		if (samples < 0)
> +			return -EINVAL;
> +
> +		ret = adxl313_fifo_push(indio_dev, samples);
> +	}
> +
> +	return ret;
> +}

...and again... If you are going to ignore most of the comments, do not expect
your patches to be applied. I'm stopping here.

...

Also note, try to avoid sending a new version until the review is settled down
on a previous round.

...

With this being said, I stopped here. Take your time (you have now a few weeks)
and carefully address / discuss all mentioned pieces of the code in both review
rounds.

-- 
With Best Regards,
Andy Shevchenko



