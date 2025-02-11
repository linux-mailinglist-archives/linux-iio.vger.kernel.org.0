Return-Path: <linux-iio+bounces-15329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA88A3075F
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 10:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D157A2566
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 09:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC87A1F153A;
	Tue, 11 Feb 2025 09:41:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF8E1F12F8;
	Tue, 11 Feb 2025 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739266876; cv=none; b=XTBrjzBg4Qt4MVuRUee9OGVfdvnWRZn/mtuUVvU2dvLq8gHnkr/HhzmpSZMfDTqjI6XFw1ltzaLp317BNsPbbWwPYp+tZ7vDMtobZbCNs2zf0KSrcYH+qGjRSZJ9TU1wL3l0akpcOvSvM6jyXS9pBfI8GH+rKmHXUvAyq8yy7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739266876; c=relaxed/simple;
	bh=IkAWydMGs1r5rb0BA93bcr9XHfndvLruvy5SdIueU3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X75kak0Nz9T7ddrFJLGi2H52EPUtzRPEUahPfjvwczfO/zhjJnTOfC2eUWiqxot/9+88vszbiQ95tvJ97SdxXrPFcG0W2CXXf5gw8yggPkPDRbLFbFnx6m+j95IH97+ChOn6Gnl3kL/dLhpN04SHMaCbXv0RCE0g1M36JsP/y7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: izygP/I+T8W8FPtZp56Vmg==
X-CSE-MsgGUID: F4+jS7SXTxSxelIc1J6FJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="50510266"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="50510266"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 01:41:10 -0800
X-CSE-ConnectionGUID: M4q0L3FITbuvBztdQMvbJg==
X-CSE-MsgGUID: Cg7Uozc6SoWKjkvUHvaTwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143364716"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 01:41:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1thmlH-0000000ASZ3-2ikX;
	Tue, 11 Feb 2025 11:40:59 +0200
Date: Tue, 11 Feb 2025 11:40:59 +0200
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
Subject: Re: [PATCH v3 05/15] bus: ts-nbus: use bitmap_get_value8()
Message-ID: <Z6sbK96JEBpWoFWy@smile.fi.intel.com>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
 <20250210-gpio-set-array-helper-v3-5-d6a673674da8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-gpio-set-array-helper-v3-5-d6a673674da8@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 10, 2025 at 04:33:31PM -0600, David Lechner wrote:
> Use bitmap_get_value8() instead of accessing the bitmap directly.
> 
> Accessing the bitmap directly is not considered good practice. We now
> have a helper function that can be used instead, so let's use it.

Thank you, LGTM (one minor thing you may address,
or keep it as in the current variant of the patch),

Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

> +#include <linux/bitmap.h>
>  #include <linux/bitops.h>

bitmap.h implies bitops.h

-- 
With Best Regards,
Andy Shevchenko



