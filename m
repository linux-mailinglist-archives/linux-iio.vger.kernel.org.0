Return-Path: <linux-iio+bounces-20436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1F8AD5957
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1C4176EFE
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 14:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2C428C2AF;
	Wed, 11 Jun 2025 14:55:07 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CCD27E7C6;
	Wed, 11 Jun 2025 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653707; cv=none; b=NQW5hli3qAe1+6SM655WWEyE1AaJEW879LjybDb9LoyP8vCe3w9eXJSTfvXOXrUj9CehyUWWnGUBdCTFQg15gCnwV9SXQk4A2Qmsc3pPXT5tWrfMmZnA+553LVAFHBqsz7q+rl9PvXzY8URnaEsumNQ7B3EKrST/0BCWvFBS4SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653707; c=relaxed/simple;
	bh=0KC4yqdkujIUPoyqphhU6iGCrXeEaZzbmhgH+87sGCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtwBxcTeHOIJTQKask1PSzpj9Zz3vmJAWKcmefDZdSDemSs6tXpeI1SOLmfho8Lx5HAHS2B6lFQ4uF1dCGz24/WQlZWwG3/xoRuNx+KyKH0eYyU/GGN8OEr6h+zsUl9B9MeQzeBWTN1TN44Pb46Ms+38SEBm/V27AzCaU3h/oLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: /e7wQRrpSWG9F1l39ZQ9/Q==
X-CSE-MsgGUID: UVJfOOrZSJ+pkfsX4Skh3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="54429393"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="54429393"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 07:55:05 -0700
X-CSE-ConnectionGUID: vqbFfTXEQEu4h3Ec0c21Sg==
X-CSE-MsgGUID: rvT/XKEGTyCiWsaCj2P5Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="152212151"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 07:55:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uPMqv-00000005g14-3eZq;
	Wed, 11 Jun 2025 17:54:57 +0300
Date: Wed, 11 Jun 2025 17:54:57 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Da Xue <da@libre.computer>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Subject: Re: [RFC] spi: expand bits_per_word_mask to 64 bits
Message-ID: <aEmYwVx73rrgNfN9@smile.fi.intel.com>
References: <20250611000516.1383268-1-da@libre.computer>
 <71b66cbb-ab2f-44e3-926f-9ae4bcb3aadc@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71b66cbb-ab2f-44e3-926f-9ae4bcb3aadc@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 11, 2025 at 09:16:06AM -0500, David Lechner wrote:
> On 6/10/25 7:05 PM, Da Xue wrote:

...

> > struct gb_spilib {

> > -	u32			bits_per_word_mask;
> > +	u64			bits_per_word_mask;
> 
> This is assigned by:
> 
> 	spi->bits_per_word_mask = le32_to_cpu(response.bits_per_word_mask);
> 
> in gb_spi_get_master_config(), so changing to u64 doesn't have any
> effect and should likely be omitted to avoid confusion.
> 
> (The response struct is defined by a communication protocol and can't be
> changed, otherwise it would break the communications.)

Perhaps the name of the field should be different to avoid appearance of
the similar changes in the future (esp. if this series in general makes
the upstream)?

-- 
With Best Regards,
Andy Shevchenko



