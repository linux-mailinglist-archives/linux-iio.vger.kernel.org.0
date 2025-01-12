Return-Path: <linux-iio+bounces-14242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BB7A0AADF
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546C0188567D
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77901BBBEB;
	Sun, 12 Jan 2025 16:31:06 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2243C1B4F04
	for <linux-iio@vger.kernel.org>; Sun, 12 Jan 2025 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736699466; cv=none; b=hZ/FT06CckKd42apAyy6MMcCXXUZ7ltwxSHWqqIITFzi/XQ/qhTbyERuy/l8yZ/qW+WirOG9Telnyab1o7bzmlSX1OHEdTqdnfPId/y/nwo9ox/7FK6lrt1U54x2LRhhVEazmryWNsdao6nvPVk5AqM7qSMx/nYJUw7z1CGQ2iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736699466; c=relaxed/simple;
	bh=+ZSLQBehxiuq4WTHU5FsPgpMbl3uMrfckw7hl78oB7w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgCTPkoajKlGFbDK3lOARQKhOhlxDelsCT+pUIm8wwTc2pHlL9KVJQXbpfrwbf/WZAJ/jDa4whQLgOD4QvLyYK1oFScxrxGCuIzZmh/YdB1oL9vF560KaJERdyFYHfPd5S0RXfVxrrBchjgAD1Bf+ft87mxSlYa4ijw3qVY//ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 9c4d8e33-d102-11ef-9cd8-005056bd6ce9;
	Sun, 12 Jan 2025 18:31:01 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 12 Jan 2025 18:31:01 +0200
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 3/5] iio: adc: ad7380: do not store osr in private
 data structure
Message-ID: <Z4PuRW-9NTSGARTj@surfacebook.localdomain>
References: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
 <20250108-ad7380-add-alert-support-v4-3-1751802471ba@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108-ad7380-add-alert-support-v4-3-1751802471ba@baylibre.com>

Wed, Jan 08, 2025 at 01:49:35PM +0100, Julien Stephan kirjoitti:
> Since regmap cache is now enabled, we don't need to store the
> oversampling ratio in the private data structure.

...

> +/**
> + * ad7380_regval_to_osr - convert OSR register value to ratio
> + * @regval: register value to check
> + *
> + * Returns: the ratio corresponding to the OSR register. If regval is not in
> + * bound, return 1 (oversampling disabled)


> + *

Redundant blank line.

> + */

-- 
With Best Regards,
Andy Shevchenko



