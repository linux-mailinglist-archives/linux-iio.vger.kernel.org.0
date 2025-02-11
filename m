Return-Path: <linux-iio+bounces-15330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6011DA30768
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 10:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F8316243B
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 09:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE841F2392;
	Tue, 11 Feb 2025 09:42:58 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70141F236B;
	Tue, 11 Feb 2025 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739266978; cv=none; b=Ts7be3aYMhvRWD0p4ba3Fa6GXyH+7rSbk20M44lM+Ev6FbK5sLhy9xs01La8Nj0VjQt6/cUIvarxAt8reFyDyoKL7YZ/sqmGuw4Cd6R79ZgUdagVF8KoMhyB7ah+MTkPhvwmp+nt6UgxCX1t+hH0DxQuq8EviF6fJ/P8vqbc9Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739266978; c=relaxed/simple;
	bh=S+OWZYhmuRFerVGPqqcaVFrGlk+WLVmiJ239vssrjiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uW3vC4ZBL+NxlP8UUBPtD1ihYrkwNL1FQJQf29zhSEjcLQQbXF/H1qgVPs+X+grfEAPXd2xy6hbIebv8xKA9anJtFuKAPbUpnVSe/zm/drtGwYDGXH2+0+D4wgff0wfFn1/2jvm1ui2mDPaZfi6ivkGVW4XP6e9XlUbhU4DCYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: lo5SNZqLRQGrU+UiaS7b4A==
X-CSE-MsgGUID: kz54OLZJTeqAwDMLG1MhGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="50512950"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="50512950"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 01:42:56 -0800
X-CSE-ConnectionGUID: aYZy757oTGGgjCvr/1BDnw==
X-CSE-MsgGUID: 05tIZ9H+StaAmIWpBPA8UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="112427591"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 01:42:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1thmmz-0000000ASai-3bzO;
	Tue, 11 Feb 2025 11:42:45 +0200
Date: Tue, 11 Feb 2025 11:42:45 +0200
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
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
	Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 06/15] gpio: max3191x: use
 gpiod_multi_set_value_cansleep
Message-ID: <Z6sblZMR-D_B_ncX@smile.fi.intel.com>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
 <20250210-gpio-set-array-helper-v3-6-d6a673674da8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-gpio-set-array-helper-v3-6-d6a673674da8@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 10, 2025 at 04:33:32PM -0600, David Lechner wrote:
> Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
> gpiod_set_array_value_cansleep().
> 
> Also add max3191x_ namespace prefix to the driver's helper function
> since we are changing the function signature anyway.

With renamed function looks much better, thanks,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



