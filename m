Return-Path: <linux-iio+bounces-20140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F7FACAE50
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 14:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAF73B3BEE
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 12:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE2321ABC3;
	Mon,  2 Jun 2025 12:54:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7BA28EC;
	Mon,  2 Jun 2025 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748868855; cv=none; b=toAp2pdT+8iTWqB948/M7gqF8V7kc3YLvOE1qgwA3DwP2cmto9XIZBuOozkpsHcteKezD1oFU+sZCGBWZ8uhPSm/x4MVGu3cjcHjFy5//KyET9T2a0zrWIV1TUuDmsHmGwOBywb7z46JPUXgFZLxcIAA30GNB06lmGgfToeqgMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748868855; c=relaxed/simple;
	bh=YRYGaPx+7uOKNhMyPefbjb/RygqDqtD7SalQTCBdDyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoZTRWFs6DBcFjO6EmELJkNJKunMhtyW8X6YoRWlddi+fHZEY8HGoMNDToiwFpWKEmuyJbUJ5ghS65Omje5HompD1WB6NXQ9QaxlxVZspnwvWQuIxd2vCdrE8x44xQBeg53ceGjvG/uvKt4pMRmttnmQLqbT7NYzU69tfrq3I7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 4FGtwASaRQeksG88f8tu8g==
X-CSE-MsgGUID: e6Vd7RnFS1ScDnYV6m5ePw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="51021300"
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="51021300"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 05:54:13 -0700
X-CSE-ConnectionGUID: L0ucsw9kRIak06BC12O5cQ==
X-CSE-MsgGUID: dW/WKoP6RvOARHrwxH1q/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="149812288"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 05:54:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uM4g2-00000002qQ3-15wq;
	Mon, 02 Jun 2025 15:54:06 +0300
Date: Mon, 2 Jun 2025 15:54:05 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v4 03/11] iio: adc: ad4170: Add support for calibration
 gain
Message-ID: <aD2e7Zq_qC2pOSEl@smile.fi.intel.com>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
 <a84963e1f17b009ccd752a8033a1f882c23f76f1.1748829860.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a84963e1f17b009ccd752a8033a1f882c23f76f1.1748829860.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 02, 2025 at 08:37:11AM -0300, Marcelo Schmitt wrote:
> Add support for ADC calibration gain configuration.

...

>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			      BIT(IIO_CHAN_INFO_SCALE) |
> -			      BIT(IIO_CHAN_INFO_OFFSET),
> +			      BIT(IIO_CHAN_INFO_OFFSET) |
> +			      BIT(IIO_CHAN_INFO_CALIBSCALE),

If you squeeze the added bit in between the upper lines, the diff will be much
clearer.

-- 
With Best Regards,
Andy Shevchenko



