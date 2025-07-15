Return-Path: <linux-iio+bounces-21668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3146B0552B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 10:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535701C20BAB
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 08:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460082D12E4;
	Tue, 15 Jul 2025 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHFRIPHv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4D822CBEC;
	Tue, 15 Jul 2025 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568899; cv=none; b=dml58p1YPvWZGt9jqNFMKebG+yzV7IXXnTfkoFyCq/Ibz4xoPobNRPYLRFuXmW3d8hlmNHsFJrlbrlW+sP5X/84M8NKiiqXP9ZXjPkNrIRwpDvbla32gKDwvan9FIanz2Ebe37GNPBum3OtRFaRNioHeG4bFThBWkwbm0WfVJxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568899; c=relaxed/simple;
	bh=2+vHupeCvDOSe3a9ueRnyyvrWqFflIDyuvTvIJ3aJbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBOkqXOVPkG2rj305j75oTsdhrBC3U+ymoZpwLECYFdVp98CqKuzy4qTwEFgXSlny3iwVU59+LtashJqdr0Y5YtFmRQ4fcSvnOm1HAMf2BTuwBS2RAVnBRL1ND4diaZWxcxXUiP7tFrzFlWM3JHA6EfsYLGBPqCkrGqYn+8Qx/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHFRIPHv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752568897; x=1784104897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2+vHupeCvDOSe3a9ueRnyyvrWqFflIDyuvTvIJ3aJbY=;
  b=SHFRIPHv926HSyr52fc3LqrdPj7BG4oMyZ106KxjKYzvrtfOvMtppBCc
   xszcvjDXMJ6aT2Ny0SHgxftDTyklDuQO3i41sMu/2LCP4GEzerQHlDcFP
   EoGSDej5X2gpOHdEtO7Hk2m2qGrNabrPMI68Nxe4ADHFT+KUXvN94lD7Z
   7gyXAtuKJOZDyFqyXdx0xsf/niknOzpg4mJdbmY0SRWEGiyeZMdbqBNdo
   +RLY65TfavwDzERgLFnbOi9D1BOXg/38I7hM+XJL31Qw70iJXBdzIJBQP
   Twzez1p6RtkUEo7GVXbs2A9KYyrzOcqmOyf+/2RuIv+swb6lzQjW47gm2
   w==;
X-CSE-ConnectionGUID: m3o3qyC+Qou//DglImWLCg==
X-CSE-MsgGUID: QkaccdRaTheuhSWAVoZKUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58543905"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="58543905"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:41:37 -0700
X-CSE-ConnectionGUID: rKVQKqdeQYOZ6n7Cee0VqA==
X-CSE-MsgGUID: JUNE1Tt6TVaxnsVMvpQNSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157257430"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 01:41:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubbEB-0000000FbHQ-0pJ7;
	Tue, 15 Jul 2025 11:41:31 +0300
Date: Tue, 15 Jul 2025 11:41:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 6/7] hwmon: iio: Add min/max support
Message-ID: <aHYUOs25SrUb4BtD@smile.fi.intel.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-7-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715012023.2050178-7-sean.anderson@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 14, 2025 at 09:20:22PM -0400, Sean Anderson wrote:
> Add support for minimum/maximum attributes. Like the _input attribute,
> we just need to call into the IIO API.

...

> +static ssize_t iio_hwmon_read_event(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
> +	struct iio_hwmon_state *state = dev_get_drvdata(dev);
> +	struct iio_channel *chan = &state->channels[sattr->index];
> +	int ret, result, scale;
> +
> +	scale = iio_hwmon_scale(chan);

> +	if (scale < 0)

This part is definitely missed in the respective description.

> +		return scale;
> +
> +	ret = iio_read_event_processed_scale(chan, IIO_EV_TYPE_THRESH,
> +					     sattr->nr, IIO_EV_INFO_VALUE,
> +					     &result, scale);
> +	if (ret < 0)

Why ' < 0' here?

> +		return ret;
> +
> +	return sprintf(buf, "%d\n", result);

Mustn't be sysfs_emit() ?

> +}

...

> +	ret = iio_write_event_processed_scale(chan, IIO_EV_TYPE_THRESH,
> +					      sattr->nr, IIO_EV_INFO_VALUE,
> +					      val, scale);
> +	if (ret < 0)

< 0 ?

> +		return ret;

...

> +static int add_event_attr(struct device *dev, struct iio_hwmon_state *st,
> +			  int i, enum iio_event_direction dir,
> +			  const char *fmt, ...)

Same comments as per previous patch adding another attribute API.

...

> +	va_start(ap, fmt);
> +	a->dev_attr.attr.name = devm_kvasprintf(dev, GFP_KERNEL, fmt, ap);
> +	va_end(ap);

Can't %pV be used?

-- 
With Best Regards,
Andy Shevchenko



