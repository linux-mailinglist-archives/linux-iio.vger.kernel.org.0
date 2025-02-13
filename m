Return-Path: <linux-iio+bounces-15498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E32A7A34C12
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 18:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2351882780
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BAD221575;
	Thu, 13 Feb 2025 17:37:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7B828A2DB;
	Thu, 13 Feb 2025 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468235; cv=none; b=bZcSaQ4As3U6sdxBaLV3Tf54EMhFKizgIoQPL7e1vANShcbW4r5jDMfTLpiZP33YCMDsO6bw6HO4X00xRBg4wBt6iaCjwGIcMqzoq1rxGTwkeIbD+nyuwttQA2Puh+qCMxYVbO607R4Q8b6/1xg33nhqw5tsmUPPzCUJjC3uWR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468235; c=relaxed/simple;
	bh=5iQ5TvzoYRvqsRL1Tb0dA+axEBtrzj3x/DwmaMb9aGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnP/nwfV7AZKoReo0BdId9Ikh7hs6uDno30gndnbepwfahta9uequo6BTQfaVlxe7lJpbweKmm1bY0/zo8l7/PwG5Dp8YKty0Lz8rQ7zZbKaeKucXQtf06Syf482wHEGnQ75J5xsn1p8UyMXzQLpcV1fGViyLs++cWfBcEZbSzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 96v72kWXR2u1Wm5z0Dr5ug==
X-CSE-MsgGUID: /y/UnMw5R8+8wWpc+X+92Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="43022532"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="43022532"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 09:37:13 -0800
X-CSE-ConnectionGUID: rIPp2GcVQOaJ8l+k6WheOQ==
X-CSE-MsgGUID: vglTymb0SMS7zPTNi4/S0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="112955713"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 09:37:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tid93-0000000BEkc-2k0W;
	Thu, 13 Feb 2025 19:37:01 +0200
Date: Thu, 13 Feb 2025 19:37:01 +0200
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-sound@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: (subset) [PATCH v3 00/15] gpiolib: add
 gpiod_multi_set_value_cansleep
Message-ID: <Z64tvc3npT6cQgMV@smile.fi.intel.com>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
 <173935301204.11039.10193374588878813157.b4-ty@linaro.org>
 <801b5364-129f-42e9-bf9a-a90d9eeb4629@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <801b5364-129f-42e9-bf9a-a90d9eeb4629@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 13, 2025 at 11:25:21AM -0600, David Lechner wrote:
> On 2/12/25 3:36 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[...]

> > Applied, thanks!
> > 
> > [06/15] gpio: max3191x: use gpiod_multi_set_value_cansleep
> >         commit: eb2e9c308d2882d9d364af048eb3d8336d41c4bb
> 
> Do you plan to pick up the other patches that have been acked
> as well? It seems like most folks were OK with everything going
> though the gpio tree since the changes are small.

FWIW, I took auxdisplay one via the respective tree.
But please tell me, if you are going to take them all,
I will drop that in my tree.

-- 
With Best Regards,
Andy Shevchenko



