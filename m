Return-Path: <linux-iio+bounces-25755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8C5C25565
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 14:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B913435152C
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 13:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FBF241679;
	Fri, 31 Oct 2025 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2KmHcmA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06E170814
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918464; cv=none; b=Idzj4Arce7keNQ9AUuSW/UWi7OLaVzrotZTmpeLnB+n6a6RzZ9fKhckrrI08XLwIMY0HWe7b64n0EsBUB4eHO2am0yoPtdKIkCcaAAB3bvFyISG4qUykntLjpmcSJ/QAkyNUSor4moSW5TKPlFR7AI/O7CrVAVdxzVqmmybzNn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918464; c=relaxed/simple;
	bh=xg7MeeG3SZu90qr9TWot3nsHSG/NNxMQvMivIENqK5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfB6uvP56mGvjEuCKFsys6V77bzcnhPnPN62pBXcbWgQxECoF3lG7tSKrM3Lfk/XEevKVmnapSM4L1zLRnNoCy8KX6wyti2DrrWfKODFHLXr3S/Dj7bc+cfv23Hzuu9kU+FsFLwmzeoBwb9G/qBJ+PIvjandq0DX0Uwcd/ErefI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2KmHcmA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761918463; x=1793454463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xg7MeeG3SZu90qr9TWot3nsHSG/NNxMQvMivIENqK5I=;
  b=e2KmHcmAX8vxyQSICCElBAxJUVXARsgqRdZu9p7JMhdk3GMXHxyV+LQ7
   kTCGMsW4uqxOtMCbLZfBRwAGNDz4ML/Oe+euV+w/bVwbAyVbRiruLyxQ+
   QAueWOxRnI/NGGSOflOaeyNe1UtBwakJZzZMefPugQ6xiGsSOTonSrkLA
   qndxIYyrn1uBZeiYbPEDc97t9/+Sclv5nlZHD8F0Ee4UaGnVFErsU/Zzy
   LkdelVvtcmyqjAgl+ZIaeFw2gkDzK828Oy/ZvjT7lQYs8gAdkO+olLvFe
   TRqlV7d+PwDfz6T2moYrB9GDSu3LV2D5JreDL/Ua2j2inltKfUck/m4Ts
   w==;
X-CSE-ConnectionGUID: OrTOx4r/SGqxvqDdk28mVA==
X-CSE-MsgGUID: o2t4q9aiSv2WTGeetfG5WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="63098682"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="63098682"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:47:43 -0700
X-CSE-ConnectionGUID: vY/j3u6DQ2GpwUvLSN2lyw==
X-CSE-MsgGUID: 9SDC8z4fRI206E5So4MUaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="186694565"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.66])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 06:47:41 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vEpTd-00000004HZI-0RZQ;
	Fri, 31 Oct 2025 15:47:37 +0200
Date: Fri, 31 Oct 2025 15:47:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 04/10] iio: dac: ad5446: Move to single chip_info
 structures
Message-ID: <aQS9-NofUjxBoPyu@smile.fi.intel.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
 <20251031-dev-add-ad5542-v3-4-d3541036c0e6@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251031-dev-add-ad5542-v3-4-d3541036c0e6@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 31, 2025 at 12:31:25PM +0000, Nuno Sá via B4 Relay wrote:
> 
> Do not use an array with an enum id kind of thing. Use the more
> maintainable chip_info variable per chip.
> 
> Adapt the probe functions to use the proper helpers (for SPI and I2c).
> Note that in a following patch we'll also add the chip_info variables to
> the of_device_id tables. Hence already use the helpers that internally use
> device_get_match_data().

...

> +static const struct ad5446_chip_info ad5310_chip_info = {
> +	.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 2),
> +	.write = ad5446_write,
> +};
> +
> +static const struct ad5446_chip_info ad5320_chip_info = {
> +	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 0),
> +	.write = ad5446_write,
> +};
> +
> +static const struct ad5446_chip_info ad5444_chip_info = {
> +	.channel = AD5446_CHANNEL(12, 16, 2),
> +	.write = ad5446_write,
> +};
> +
> +static const struct ad5446_chip_info ad5446_chip_info = {
> +	.channel = AD5446_CHANNEL(14, 16, 0),
> +	.write = ad5446_write,
> +};
> +
> +static const struct ad5446_chip_info ad5450_chip_info = {
> +	.channel = AD5446_CHANNEL(8, 16, 6),
> +	.write = ad5446_write,
> +};
> +
> +static const struct ad5446_chip_info ad5451_chip_info = {
> +	.channel = AD5446_CHANNEL(10, 16, 4),
> +	.write = ad5446_write,
> +};
> +
> +static const struct ad5446_chip_info ad5541a_chip_info = {
> +	.channel = AD5446_CHANNEL(16, 16, 0),
> +	.write = ad5446_write,
> +};
> +
> +static const struct ad5446_chip_info ad5512a_chip_info = {
> +	.channel = AD5446_CHANNEL(12, 16, 4),
> +	.write = ad5446_write,
> +};
> +
> +static const struct ad5446_chip_info ad5553_chip_info = {
> +	.channel = AD5446_CHANNEL(14, 16, 0),
> +	.write = ad5446_write,
> +};

> +static const struct ad5446_chip_info ad5600_chip_info = {
> +	.channel = AD5446_CHANNEL(16, 16, 0),
> +	.write = ad5446_write,
> +};

Seems same as ad5541a_chip_info(). Do we need duplicates _now_?

> +static const struct ad5446_chip_info ad5601_chip_info = {
> +	.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 6),
> +	.write = ad5446_write,
> +};
> +
> +static const struct ad5446_chip_info ad5611_chip_info = {
> +	.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 4),
> +	.write = ad5446_write,
> +};
> +
> +static const struct ad5446_chip_info ad5621_chip_info = {
> +	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
> +	.write = ad5446_write,
> +};
> +
> +static const struct ad5446_chip_info ad5641_chip_info = {
> +	.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
> +	.write = ad5446_write,
> +};
> +
> +static const struct ad5446_chip_info ad5620_2500_chip_info = {
> +	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
> +	.int_vref_mv = 2500,
> +	.write = ad5446_write,
> +};
> +
> +static const struct ad5446_chip_info ad5620_1250_chip_info = {
> +	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
> +	.int_vref_mv = 1250,
> +	.write = ad5446_write,
> +};
> +
> +static const struct ad5446_chip_info ad5640_2500_chip_info = {
> +	.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
> +	.int_vref_mv = 2500,
> +	.write = ad5446_write,
> +};
> +
> +static const struct ad5446_chip_info ad5640_1250_chip_info = {
> +	.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
> +	.int_vref_mv = 1250,
> +	.write = ad5446_write,
> +};
> +
> +static const struct ad5446_chip_info ad5660_2500_chip_info = {
> +	.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
> +	.int_vref_mv = 2500,
> +	.write = ad5660_write,
> +};
> +
> +static const struct ad5446_chip_info ad5660_1250_chip_info = {
> +	.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
> +	.int_vref_mv = 1250,
> +	.write = ad5660_write,
> +};
> +
> +static const struct ad5446_chip_info ad5662_chip_info = {
> +	.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
> +	.write = ad5660_write,
>  };

-- 
With Best Regards,
Andy Shevchenko



