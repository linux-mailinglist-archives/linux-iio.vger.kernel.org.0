Return-Path: <linux-iio+bounces-18525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A66A973BA
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 19:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC04400F8E
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 17:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A1A28541C;
	Tue, 22 Apr 2025 17:39:58 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E7E1D5CEA;
	Tue, 22 Apr 2025 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343598; cv=none; b=lOQa5B1pp5qjdYFV7w3tPL//uxm+087nOZZkTcz7IccB0jKAtjfazDwoGNoqW59yC4TxbLHg5VM0nIuH/aewRrEJJVkcPKI7FAcBByVFhLUSMnCAmIy8jff+KPixnhpZgK/t4idDv5XkRQlm05vzI4/+PT7EzJI41L4Uyi5ruF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343598; c=relaxed/simple;
	bh=ISxSKKIa8EAlBomVCdUrDutWyKsrFuzFJxYPtPbNT/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwjZ1UXiu00mSZZj6tHk+vrtVJ2GvwZH1X0bpfL7Fv9wlUeLKlhlTmBghtMpofMKzuLt6YBWQaLCUpcMbj2WGPA4huF5CuQ2EvVbRHFm0bYLsvXnL25sQFo9tjAA9iwTUL402RYgT3W6FmCxtmDt+yoqmEYP+aDpOJv+Mgi07HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: Qir6DKd4T7auYjQLsBoCGQ==
X-CSE-MsgGUID: K1OKJxvzTrKVOa0yJEIZaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="64444987"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="64444987"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 10:39:56 -0700
X-CSE-ConnectionGUID: SVs67TxxT16G88MMSk09rA==
X-CSE-MsgGUID: pUqEj53aT2SqXgSxZCVM2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="163043491"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 10:39:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u7Hb4-0000000EneY-2iuI;
	Tue, 22 Apr 2025 20:39:50 +0300
Date: Tue, 22 Apr 2025 20:39:50 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v5 3/4] iio: chemical: add support for winsen MHZ19B CO2
 sensor
Message-ID: <aAfUZuujO0FUkJEG@smile.fi.intel.com>
References: <20250422155302.669960-1-gye976@gmail.com>
 <20250422155302.669960-4-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422155302.669960-4-gye976@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 23, 2025 at 12:53:01AM +0900, Gyeyoung Baek wrote:
> Add support for winsen MHZ19B CO2 sensor.

Winsen (name capitalisation)?

...

> +static ssize_t calibration_forced_value_store(struct device *dev,
> +					      struct device_attribute *attr,
> +					      const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	u16 ppm;
> +	int cmd, ret;
> +
> +	ret = kstrtou16(buf, 0, &ppm);
> +	if (ret)
> +		return ret;
> +
> +	if (ppm) {
> +		if (!in_range(ppm, 1000, 4001)) {
> +			dev_dbg(&indio_dev->dev,
> +				"span point ppm should be between 1000 and 5000 inclusive.");
> +			return -EINVAL;
> +		}

I proposed to define the _MIN and _MAX constants for the range and use them in
the parameters. Any objection?

> +		cmd = MHZ19B_SPAN_POINT_CMD;
> +	} else {
> +		cmd = MHZ19B_ZERO_POINT_CMD;
> +	}
> +
> +	ret = mhz19b_serdev_cmd(indio_dev, cmd, ppm);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
> +}

Otherwise LGTM, thanks!

-- 
With Best Regards,
Andy Shevchenko



