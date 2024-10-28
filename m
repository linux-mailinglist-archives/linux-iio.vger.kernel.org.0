Return-Path: <linux-iio+bounces-11439-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4493F9B2B87
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 10:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51DC1F21FCC
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 09:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29601D3644;
	Mon, 28 Oct 2024 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2iiNKoX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E504199247;
	Mon, 28 Oct 2024 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730107514; cv=none; b=BMBGaz+EwzG8bO29pphyVd3OkGaISzk27qgazPwFMWPuY9pqVoOZHVn68fcavxDqbUai4ULzT1ulVDePL+5v8AiZwgOqqoNAqScACklBiflCA5uWXLqsGdBzW0pxBG1lx9pDCeM4jMPIYoPOPB+7iP+P3UQXzk5h0OUXA9hme6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730107514; c=relaxed/simple;
	bh=gx2yYIkWM9jtAvPqskr0+UVLgMAwVE0IFBV/L1j3rqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEPJ+WnABcSTRI2r+5zQ3Z11dsITZF76D0O0uMmHL0JBzatEWt1kQGoEipAsJj/vqKCN3/2cywMXpqBe/hZaFXRJqxMRivIIfGoxWbikSk5kEfe9Vom1byx/gggCK8ZWKyzO0JrpNLjykl9ugUOzEfcfWPJIuSFu+hpVnAXyziQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L2iiNKoX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730107513; x=1761643513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gx2yYIkWM9jtAvPqskr0+UVLgMAwVE0IFBV/L1j3rqc=;
  b=L2iiNKoXlPTJ2Ajubu//+ADrA7Kl7LAqGV34UXMGmJrUZAxssYc/+twd
   EUZ4WP+18rTanhH7p8bN4201+ESmZ0BNAYDTCZSYTOQPJfRs2pATG+UoN
   8pG2J6FRN+3Ci6B7jRrFSNr7T0QnnHp1KCUm9WspLE8fX4cZy+a+FekDv
   XVK4PWGEy7/PoffAyYpDNmRzWmfGJKpTxIab3TLNFjsV3K6gyZ3aG8eNB
   EyRhtoBNlg6dLJAUfA06/8e+ruVEAcNfyzl8pkZrSIxTZ3APX/L1NZkPN
   wLFi/P6x4+kwejoOfR34FOD0Sjo5o0Y7Bm3r6Zzjh9TUzVYfz0fI3acZO
   w==;
X-CSE-ConnectionGUID: VMjBm2+VQ++Hwc4ar7z+Lg==
X-CSE-MsgGUID: SeQ7V0gEQSiCPNxA8vt/Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47155742"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47155742"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:25:13 -0700
X-CSE-ConnectionGUID: feGTaYEgRlGEDMqJtZw6sw==
X-CSE-MsgGUID: TOv+Z8rrRhSc5w0Ro7A9dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="86171955"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:25:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t5Lzm-00000007tLO-2twS;
	Mon, 28 Oct 2024 11:25:06 +0200
Date: Mon, 28 Oct 2024 11:25:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Subject: Re: [PATCH v4 1/4] iio: imu: bmi270: Add triggered buffer for Bosch
 BMI270 IMU
Message-ID: <Zx9Ycjnlef1RJfGf@smile.fi.intel.com>
References: <20241027172029.160134-1-justin@justinweiss.com>
 <20241027172029.160134-2-justin@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027172029.160134-2-justin@justinweiss.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Oct 27, 2024 at 10:20:22AM -0700, Justin Weiss wrote:
> Set up a triggered buffer for the accel and angl_vel values.

...

>  	.channel2 = IIO_MOD_##_axis,				\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.scan_index = BMI270_SCAN_ACCEL_##_axis,		\
> +	.scan_type = {						\
> +		.sign = 's',					\
> +		.realbits = 16,					\
> +		.storagebits = 16,				\
> +		.endianness = IIO_LE				\

Leave trailing comma here.

> +	},	                                                \

...

>  	.channel2 = IIO_MOD_##_axis,				\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.scan_index = BMI270_SCAN_GYRO_##_axis,			\
> +	.scan_type = {						\
> +		.sign = 's',					\
> +		.realbits = 16,					\
> +		.storagebits = 16,				\
> +		.endianness = IIO_LE				\

Ditto.

> +	},	                                                \

-- 
With Best Regards,
Andy Shevchenko



