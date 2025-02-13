Return-Path: <linux-iio+bounces-15496-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD2DA34BBD
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 18:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A8B1883367
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 17:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC0E2045BD;
	Thu, 13 Feb 2025 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vk7L3TjG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61551FFC41;
	Thu, 13 Feb 2025 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467307; cv=none; b=lXirWpBeDS/5RAd/gcPH20naTvHb3NsSc5UeWAGJfY9pXMFZ5O6l95ohgsJndt0hyRkIaG/7aQF98fhe4rhTt947qYXB2vDlWznLXjf++n7WnD4+38FPUCQbaCIF24KBiRCwydHYttUYkXC1LiSQtmF+ObHBey6niEx6iaQzyB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467307; c=relaxed/simple;
	bh=7b3tiR515nbHuXH37JXwcZMGqsx2+CI2oXw9UOzBwG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFEfBxKic0ua/J2AaE2Eg1Cqwck2h/YEr+Sqctkky6+t1bChJCoqUlVnrSSFiHV65fmf24zDe1G/0fnDtUfNsoOQECz+04tAJaLBgFmEGJnffRx0lYeRgoNdgv4pxQ3JGT5yr+tJ2GuHF0rQ9MTXpSrTOVompCsW0ql7s0+in+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vk7L3TjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7115C4CEE4;
	Thu, 13 Feb 2025 17:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739467306;
	bh=7b3tiR515nbHuXH37JXwcZMGqsx2+CI2oXw9UOzBwG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vk7L3TjGgvDZ88rkKo1f+7cCCKr0k6im7o74QLsJCXW6TM38Au1PTj9Waf+TipLFk
	 ZCNxToozxFogVFdPl+7mmVT6aG4LuOJ9RDRSWSJzH2iICpi6INUZ2Brh9jiYnS4XOx
	 /hfTZh/Xxqkvaq9PoAWGcb9igOvi490Usrq7/Q8Dv31LpYTwPe1d7AhEzcSvEPNOoV
	 r5Izw7978sB/1+oF6EIw8696Q4PnqaCrfQZ/DdLupB3aaXOt8i2dgkGEowJakO7Uqx
	 Tj8B/1Aqu0QGbzguohO1KXyovh9b+yIp82VyRV6HYX09ihDXHBP6Qi7YnGKaKgUFU8
	 /EqeW0kKHZWUQ==
Date: Thu, 13 Feb 2025 22:51:42 +0530
From: Vinod Koul <vkoul@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
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
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 14/15] phy: mapphone-mdm6600: use
 gpiod_multi_set_value_cansleep
Message-ID: <Z64qJjamqN+9GG+P@vaman>
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
 <20250210-gpio-set-array-helper-v3-14-d6a673674da8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-gpio-set-array-helper-v3-14-d6a673674da8@baylibre.com>

On 10-02-25, 16:33, David Lechner wrote:
> Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
> gpiod_set_array_value_cansleep().
> 
> ddata->cmd_gpios->ndescs is validated to be equal to
> PHY_MDM6600_NR_CMD_LINES during driver probe, so it will have the same
> value as the previously hard-coded argument.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

