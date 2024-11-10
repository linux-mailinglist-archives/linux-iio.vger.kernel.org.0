Return-Path: <linux-iio+bounces-12106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B009C3474
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 20:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F007E281FAE
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 19:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8EA450EE;
	Sun, 10 Nov 2024 19:52:20 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F283F13B5B3
	for <linux-iio@vger.kernel.org>; Sun, 10 Nov 2024 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731268340; cv=none; b=UEa4kwRlLRTwvUgvPqdbRaZi5i7hy5SX5fisLdtMcBXbFXfHMgQJvnK90kmLcmLjr/KHRoLgu84ZOBjWxlgaUEfC1uF5iCOf8M6BUXRytAppUBuOZ3sHG98/ihM0YMwuQtL2EGznDww4WGuWAzZzLrgpobGkMb1mFqkxGxLnjnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731268340; c=relaxed/simple;
	bh=PgYesiTdPA5OVXXO/NUazx9gOX69ohmxZNRoY8rs0cw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfpyJBQUkP/SGtXSZnWEl22tTlD3Brq1LhIosZZCeM7b2KItdppZHwfVngKoQ1eIH7jFlFlEKqla4EpsyDUN14xfHxoaM5um1tTR5d3AMg8kzzlMW/Akg1QTp2SFyeYa2qSOtZKwHo3CH2jWZfitFOoXUeHkIK6Q1nguSScLdlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-75.elisa-laajakaista.fi [88.113.24.75])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 1eef05fe-9f9d-11ef-9aff-005056bd6ce9;
	Sun, 10 Nov 2024 21:51:07 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 10 Nov 2024 21:51:04 +0200
To: Aren <aren@peacevolution.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <trabarni@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] iio: light: stk3310: handle all remove logic with
 devm callbacks
Message-ID: <ZzEOqC9dAHCRX5a9@surfacebook.localdomain>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-7-aren@peacevolution.org>
 <ZyiGiK6bSd_d0VQ6@smile.fi.intel.com>
 <mlvzaskgxqjfu6yiib2u7m3pczsifsluc4mqnzy6w3xzxblvm6@xrxvvruzftn2>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mlvzaskgxqjfu6yiib2u7m3pczsifsluc4mqnzy6w3xzxblvm6@xrxvvruzftn2>

Sun, Nov 10, 2024 at 01:38:39PM -0500, Aren kirjoitti:
> On Mon, Nov 04, 2024 at 10:32:08AM +0200, Andy Shevchenko wrote:
> > On Sat, Nov 02, 2024 at 03:50:37PM -0400, Aren Moynihan wrote:

...

> > > +	ret = devm_add_action_or_reset(&client->dev, stk3310_set_state_disable, data);
> > 
> > Why not simply 'dev' as in below call?
> 
> I was trying to avoid refactoring the entire function to replace
> &client->dev with dev, I'll add a patch for that to the next revision.

I'm not talking about refactoring, I'm talking only about the lines that you
have touched / added.

> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "failed to register cleanup function\n");

-- 
With Best Regards,
Andy Shevchenko



