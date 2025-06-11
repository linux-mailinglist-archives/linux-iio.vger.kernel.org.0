Return-Path: <linux-iio+bounces-20401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C480AD4E6C
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 10:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BCD189CD0C
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 08:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D33221262;
	Wed, 11 Jun 2025 08:31:06 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044C82367B0;
	Wed, 11 Jun 2025 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749630666; cv=none; b=KQe2g0WLKkssVHvXr4R9AWEyRjJq3cMzQrfd+kgZ4/dSNDfu9CmdhSYd14H7f8uqlZvFC+kN8K4TG7+HIqGxZq1GyC81rolOp5pINT0OiC6T6em+VksK22pZ0UOk/dVaNPhn+5puxjhJrzUbH+n/qU6oZwJdjf45GCYhBNU7s08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749630666; c=relaxed/simple;
	bh=DXYIv+tycKjLbFi7q3acp8Gyp8fPNbFB5zSpGO5FcZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxrYnF6xAa1WU8EbdZKQncF8H1VP0o7+o34OO048P36ut1N6sFvPRexHDLDET3cCS2Lc7lWmmrGzKZ1vykL1X3SK1+06yxjLonZANkFqoSYWYyZ/jP1pEXS7lodD9DM+VNXM2iu40AZ5pjKPi//epKL/mJpb6eRUOiqJo6O+rCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: bJKmYaoVQm66gsy+4mK2EA==
X-CSE-MsgGUID: 1HTFPgghS/y4LLPYfapgEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="69196515"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="69196515"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 01:31:05 -0700
X-CSE-ConnectionGUID: sF4xFUWzRrKOlPZNa1B/Fw==
X-CSE-MsgGUID: iU87REBgRH6elOibkqUvLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="151901774"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 01:31:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uPGrI-00000005aMS-316w;
	Wed, 11 Jun 2025 11:30:56 +0300
Date: Wed, 11 Jun 2025 11:30:56 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Da Xue <da@libre.computer>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
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
Message-ID: <aEk-wIJ8FY73NxQG@smile.fi.intel.com>
References: <20250611000516.1383268-1-da@libre.computer>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611000516.1383268-1-da@libre.computer>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jun 10, 2025 at 08:05:15PM -0400, Da Xue wrote:
> Most current controller IP support 64-bit words.

"Most of the current controllers support..."

> Update the mask to u64 from u32.

>  drivers/iio/adc/ad7949.c         | 2 +-
>  drivers/spi/spi-dln2.c           | 2 +-
>  drivers/spi/spi-ingenic.c        | 2 +-
>  drivers/spi/spi-sh-msiof.c       | 2 +-
>  drivers/spi/spi.c                | 4 ++--
>  drivers/staging/greybus/spilib.c | 2 +-
>  include/linux/spi/altera.h       | 2 +-
>  include/linux/spi/spi.h          | 6 +++---

I guess it would be nice to split on per-driver basis, starting from updating
the SPI core. I counted 6 patches in such a case.

-- 
With Best Regards,
Andy Shevchenko



