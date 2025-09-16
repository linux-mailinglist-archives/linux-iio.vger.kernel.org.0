Return-Path: <linux-iio+bounces-24154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AADAAB596E3
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 15:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E26325790
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 13:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20AE2D7DD8;
	Tue, 16 Sep 2025 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R1n2IU22"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E43597C;
	Tue, 16 Sep 2025 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027793; cv=none; b=G6YqfrWAJx82feuVIFRpJHRvbKoJz0CNq/sqVQTa0N62bwjywEOW061b4uhuSNBUe6snI+QTQPTFOrmGhDaSxsUrbYwCFQ8hvQBjGh2MleXO90ykMyteF4Hz03gCGmjtPbhIZ6PWKhOqVNYUKVAg3qCC1RcsdVFUHlC6ihhnCDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027793; c=relaxed/simple;
	bh=9v4NFlbHr1BaFDauYKssUwXgCx6Fm6j15tX7wigDxTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9BTSdCdAiLBaTHzwXQ0k17jOKDxYIXexQw7GOPI41G9X4qW1FpppKjkmHlHfLoy3L6q28aru/hQs9bhxcp1LxFaJKGcth9OyXi5FBVA55yE5us54x31UzAKfQhbH+6WeBaIuCrEw8uY6nv7cIEnm8h9RVmM0unbNd6dI4jRk6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R1n2IU22; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758027792; x=1789563792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9v4NFlbHr1BaFDauYKssUwXgCx6Fm6j15tX7wigDxTg=;
  b=R1n2IU224tDxvXrpnBz0jXLhm8arCPGhgJ8ovHf5xd13ACxShAUkN//r
   jMbHmeudUMqOT3cdWdNWNU+HLS5EN338429EKzr28NWmgkFTKWUpOswiP
   cJYdUIPokBEwEL9Zb5bW8clNRSkuvwxCZNQ1ZCI5Y5OkRa7St5wthElEU
   jd+axcvA1W14mptI42VKatcb70CdYbTWDRibJB55sqhQL6Z6Xu7/qJefn
   Kp7NavmDHTTNVR97lCNpEXjwdaT82HknPz3yr1uYnU2s7KcfDlNMKtkxv
   VHRS5xT/KBxKkpHw95tLfBAy2LYz49M2EeoTTBgetQnXQId9ngdpfqjRI
   Q==;
X-CSE-ConnectionGUID: r6TK7nddQqa2GUj5tAnqNg==
X-CSE-MsgGUID: ZvxE5QZqSPe245oHXzXSVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="70555925"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="70555925"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 06:03:12 -0700
X-CSE-ConnectionGUID: YuEMw8IqT/GSKKZdrNwsMQ==
X-CSE-MsgGUID: rsK8Mvp/TVuHnrBh5uPEsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="178934417"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 06:03:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uyVKr-00000003Wzg-0xbI;
	Tue, 16 Sep 2025 16:03:05 +0300
Date: Tue, 16 Sep 2025 16:03:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: add processed write API
Message-ID: <aMlgCZkP0723mWyO@smile.fi.intel.com>
References: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <20250916-ltm8054-driver-v1-2-fd4e781d33b9@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-ltm8054-driver-v1-2-fd4e781d33b9@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 12:24:07PM +0200, Romain Gantois wrote:
> Add a function to allow IIO consumers to write a processed value to a
> channel.

...

> +static int iio_convert_processed_to_raw_unlocked(struct iio_channel *chan,
> +						 int processed, int *raw,
> +						 unsigned int scale)
> +{
> +	int scale_type, scale_val, scale_val2;
> +	int offset_type, offset_val, offset_val2;
> +	s64 tmp_num, tmp_den;
> +
> +	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
> +				      IIO_CHAN_INFO_SCALE);
> +	if (scale_type >= 0) {
> +		switch (scale_type) {
> +		case IIO_VAL_INT:
> +			tmp_num = processed;
> +			tmp_den = scale_val;
> +			break;
> +		case IIO_VAL_INT_PLUS_MICRO:
> +			tmp_num = (s64)processed * 1000000LL;

If you go with this, in IIO we heavily use units.h and here something like
(s64)MICRO would be appropriate. Similar to the rest of the code where one
or another constant may be used.

> +			if (scale_val2 < 0) {
> +				tmp_den = (s64)scale_val * 1000000LL - (s64)scale_val2;
> +				tmp_den *= -1;
> +			} else {
> +				tmp_den = (s64)scale_val * 1000000LL + (s64)scale_val2;
> +			}
> +
> +			break;
> +		case IIO_VAL_INT_PLUS_NANO:
> +			tmp_num = (s64)processed * 1000000000LL;
> +
> +			if (scale_val2 < 0) {
> +				tmp_den = (s64)scale_val * 1000000000LL - (s64)scale_val2;
> +				tmp_den *= -1;
> +			} else {
> +				tmp_den = (s64)scale_val * 1000000000LL + (s64)scale_val2;
> +			}
> +
> +			break;
> +		case IIO_VAL_FRACTIONAL:
> +			tmp_num = (s64)processed * (s64)scale_val2;
> +			tmp_den = scale_val;
> +			break;
> +		case IIO_VAL_FRACTIONAL_LOG2:
> +			tmp_num = (s64)processed << scale_val2;
> +			tmp_den = scale_val;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		tmp_den *= scale;
> +
> +		*raw = div64_s64(tmp_num, tmp_den);
> +	}
> +
> +	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
> +				       IIO_CHAN_INFO_OFFSET);
> +	if (offset_type >= 0) {
> +		switch (offset_type) {
> +		case IIO_VAL_INT:
> +		case IIO_VAL_INT_PLUS_MICRO:
> +		case IIO_VAL_INT_PLUS_NANO:
> +			break;
> +		case IIO_VAL_FRACTIONAL:
> +			offset_val /= offset_val2;
> +			break;
> +		case IIO_VAL_FRACTIONAL_LOG2:
> +			offset_val >>= offset_val2;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		*raw -= offset_val;
> +	}
> +
> +	return 0;
> +}

...

> +/**
> + * iio_write_channel_processed_scale() - scale and write processed value to a given channel
> + * @chan:		The channel being queried.
> + * @val:		Value to write.
> + * @scale:		Scale factor to apply during the conversion
> + *
> + * Returns an error code or 0.
> + *
> + * This function writes a processed value to a channel. A processed value means
> + * that this value will have the correct unit and not some device internal
> + * representation. If the device does not support writing a processed value, the
> + * function will query the channel's scale and offset and write an appropriately
> + * transformed raw value.
> + */

This needs a run via kernel-doc validator (warning: Missing Return section).
Also note, in accordance with kernel-doc documentation the Return section must
be last in the big description.

-- 
With Best Regards,
Andy Shevchenko



