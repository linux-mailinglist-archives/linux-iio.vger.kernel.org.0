Return-Path: <linux-iio+bounces-15432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 846DCA323E0
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 11:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77B0C7A2C2D
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 10:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC25209F26;
	Wed, 12 Feb 2025 10:50:23 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54A2AF19;
	Wed, 12 Feb 2025 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357423; cv=none; b=m2Oe8Uap/dvKPLxXLMlQBoq4tn9ZKzxIbtwRJUby0HITJ7IryBuD8GyN/qTxvvI7jsX6GhZAZoPRwQYalpeze/825RpTY6J3oqUjxnLYv9RhM9RKp7lyyyd7Y+U52i+wQec+psYcLeZOShxGaXmFqk+xUZWEParoOWuIqhBp/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357423; c=relaxed/simple;
	bh=1+6uIvhAB9bW3H9pqQ9F7mTMMd6PRzOoOQSgWO+EFAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9StG62lFLB0VxCzqoZUUwULTy7OEsQBNbUDzoPRoMKa6xTERGliq2GMnWdxK4PPYTUnTNLmR297+JA8SgHaJl70ik9et/XRizqr39qK/HshnufojtucDA3I57XyQTb1V4Mul12gPKIVnP/p6ZXgLL5mofzVvH0ddJhDZcDBM7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: QMQxOApsQwqOHafWwY/3KA==
X-CSE-MsgGUID: kU90q58IQI2FAP6yrcb6Hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="57541128"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="57541128"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 02:50:19 -0800
X-CSE-ConnectionGUID: s6HKzby/RyGi2+giECZPjQ==
X-CSE-MsgGUID: 9tW04u5vQki9E6S2LjeUXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112767068"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 02:50:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tiAJl-0000000AoB2-1H6I;
	Wed, 12 Feb 2025 12:50:09 +0200
Date: Wed, 12 Feb 2025 12:50:09 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	David Lechner <dlechner@baylibre.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-sound@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [GIT PULL] gpio: immutable tag containing
 gpiod_multi_set_value_cansleep()
Message-ID: <Z6x84R_MOrzZq7jb@smile.fi.intel.com>
References: <20250212094546.11895-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212094546.11895-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 10:45:46AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Hi!
> 
> This concerns the patch series from David Lechner[1].
> 
> I applied the patch adding gpiod_multi_set_value_cansleep() to the GPIO
> tree. Here's an immutable tag that maintainers of all other trees affected
> by this series can pull in so that the entire series can land for v6.15.
> 
> Please pull.

Pulled to auxdisplay, thanks!

-- 
With Best Regards,
Andy Shevchenko



