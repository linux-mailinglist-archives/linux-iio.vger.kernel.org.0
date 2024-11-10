Return-Path: <linux-iio+bounces-12105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F2B9C3458
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 20:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67B9DB21267
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 19:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1798D1448DF;
	Sun, 10 Nov 2024 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="ZSnKUv8x"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2B21369AA;
	Sun, 10 Nov 2024 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731266166; cv=none; b=hPavBXiHkYuip17UB72n/LIcSdM8amQ2tC6nEDM889KtdjDD56mlrKfXZvk7R98dJ4sczsjonqFpy7p6X/jsmp1f/WDAUnbjDozoS2ipoRUUW741+0a4LogeIG2hYsPszP1pHccdYBLGH56sVQS8BgX0+cv33mFU6HDEXG9Vdcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731266166; c=relaxed/simple;
	bh=r1ses3pgqHWBJxnHulBow7vskulmB/8AsMq1uBXXlrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmjRVHvlQS+LWDl/Tr8/ixn6dpApZotHXxCbWZ7BwmJVfFyEkKHWBYnJV9x1zYykxqD3pRuFi3BGG7fzj05/TZhNQhYyRsS2ohED/onr8+yS9ybsCZzvBbPe15ruxegraN/ipTKxXQRPEuvJkG95Xby+Qhy0d2dWOnuoDl2A54A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=ZSnKUv8x; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id C40554C82C;
	Sun, 10 Nov 2024 19:16:02 +0000 (UTC)
Date: Sun, 10 Nov 2024 14:16:00 -0500
From: Aren <aren@peacevolution.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Kaustabh Chakraborty <kauschluss@disroot.org>, =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>, 
	Ondrej Jirman <megi@xff.cz>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] iio: light: stk3310: log error if reading the
 chip id fails
Message-ID: <jwk6xutstzr2whki2y52rpm6tgx26hswq24lqwyy7fdjeyyq6x@gn5pghxezbc6>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-13-aren@peacevolution.org>
 <ZyiIp6t53FN9ssyV@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyiIp6t53FN9ssyV@smile.fi.intel.com>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1731266163;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references;
	bh=eEZbdTzEYXuLwbBpuMXGMeDEFhAzoB1psOB+/X4Brc0=;
	b=ZSnKUv8xaun5sbvhBWZ2JSwkOP+AghP5j3wKuOTusj7T9J1oAvEw2rvL+ZWE2dfEo54pm5
	Dm9MxoL7j0wrj7VCrRAhKXDSKdtG5Mc2GcjJeoSnaKIHj7lAh81QFpB0ZLzku0t8nydRDW
	aPcf8pYQG4YX1cF48Qx/WxXA+ALdh2c=

On Mon, Nov 04, 2024 at 10:41:11AM +0200, Andy Shevchenko wrote:
> On Sat, Nov 02, 2024 at 03:50:43PM -0400, Aren Moynihan wrote:
> > If the chip isn't powered, this call is likely to return an error.
> > Without a log here the driver will silently fail to probe. Potential
> > errors include ENXIO (when the chip isn't powered) and ETIMEDOUT (when
> > the i2c bus isn't powered).
> > 
> > This function is only called from stk3310_probe, and this condition
> > should return an error, which fits what dev_err_probe is designed for.
> 
> ...
> 
> > +		return dev_err_probe(dev, ret, "failed to read chip id\n");
> 
> Please, make sure you have consistent style in the messages. Most of what
> I have seen use period at the end. This one doesn't.

All but two log messages in this driver don't have a period at the end.
I'll correct those two in the next revision.

 - Aren

