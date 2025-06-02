Return-Path: <linux-iio+bounces-20152-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B43F6ACB669
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 17:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243B61944E1D
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 15:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF06238D54;
	Mon,  2 Jun 2025 14:59:09 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1E0238174;
	Mon,  2 Jun 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876349; cv=none; b=OjO23n7Ld9QvRK/BXNkMOGeRUt/mgEq6sg0ttPys9w+08lW2DV4U1UL/Okcv0O3vTYYhTjzyO2bDCTT6nKhLwAjvxBQICX/kkKkbNch3LqETNClUYotLeBbHka+0i99qk0nJylai9WbT2YCDBmatFN7wqZEbYoc9oF2fI5bCH8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876349; c=relaxed/simple;
	bh=U76p8J/dP1FRLW1OHfizZCnhk6f8RLVJiirARJ5Ua3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsLW2ElVxcoJk4ZUGa47sVM2+xOMJ473GGBZeIPzK9gRiJUAQaKyEgeS2YSOBpspwDPs5u94WAU5QAMMzVCkHwwVPxLObdbgEk6WrcQQhHYoaIXm4rDdd4A7nbMVnLuOA2WLnWJoZQ4L+nCWCHGhVd5uwlrqCvipeFbG+HaV1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: gaUjNlcFQ8u550OaGhL61Q==
X-CSE-MsgGUID: m3UexrM0S2GT/Ri+ML6VUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="38512399"
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="38512399"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 07:59:07 -0700
X-CSE-ConnectionGUID: 8Dyvj7vwSx+NQ2Hya0Mppw==
X-CSE-MsgGUID: hr82fmzXR2uwYsMY4XUFiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="149563320"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 07:59:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uM6ct-00000002sDm-0isY;
	Mon, 02 Jun 2025 17:58:59 +0300
Date: Mon, 2 Jun 2025 17:58:58 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Herve Codina <herve.codina@bootlin.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] iio: backend: update
 iio_backend_oversampling_ratio_set
Message-ID: <aD28MuVP8MgvKMmt@smile.fi.intel.com>
References: <20250602134349.1930891-1-pop.ioan-daniel@analog.com>
 <20250602134349.1930891-3-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602134349.1930891-3-pop.ioan-daniel@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 02, 2025 at 04:43:40PM +0300, Pop Ioan Daniel wrote:
> Add chan parameter to iio_backend_oversampling_ratio_set() to allow
> for contexts where the channel must be specified. Modify all
> existing users.

...

> static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,

>  		if (ret)
>  			return ret;
>  	}

> -

Why do you remove this blank line? To me these two blocks do not look toughly
coupled.

> -	ret = iio_backend_oversampling_ratio_set(st->back, osr);
> +	/* Channel is ignored by the backend being used here */
> +	ret = iio_backend_oversampling_ratio_set(st->back, 0, osr);
>  	if (ret)
>  		return ret;

-- 
With Best Regards,
Andy Shevchenko



