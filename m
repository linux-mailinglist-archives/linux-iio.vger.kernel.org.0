Return-Path: <linux-iio+bounces-11492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 031E89B36B4
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 17:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE9F1F22886
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB261DEFDA;
	Mon, 28 Oct 2024 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="kFVcCIcJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D710C1DE8B3;
	Mon, 28 Oct 2024 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133447; cv=none; b=llTVk+qEzsnvFHA2MQ2kTCqfUwsKrqNiY9R3hLb9CxXBRH98y0Z2nWciep4/eOxb0u2D433uTYCFxbLlTUxUwgzgCO+06wAnHLP0IXb+dZU7DLxOV+GS+CTdKQPxcd6F9en9kRqHjsDE4Zf2tBBV/JF84WOUr/FuzpOR3jSCh90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133447; c=relaxed/simple;
	bh=ObFeJAniS5fEngLmJJFrcIB6eWoaLLkxX0G3X/tyv1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCsernhtIVEQ9Z/eHkXMdvU/YB8Fu/nffHbRrDTn7jXaWZgKGVjeEizQJ1ZSaVzU5Sga34gi03tyLTrioHDKIYaHJgWHp1reT9xP/7tcpoAEktK9l96xlrfxWwgIaW1X51k/ndhrjW9hkQYAyytSejLQwU1glOfRNUeTF4xvZqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=kFVcCIcJ; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id DFFE24C7D9;
	Mon, 28 Oct 2024 16:37:21 +0000 (UTC)
Date: Mon, 28 Oct 2024 12:37:14 -0400
From: Aren Moynihan <aren@peacevolution.org>
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
Subject: Re: [PATCH v3 3/6] iio: light: stk3310: Implement vdd and leda
 supplies
Message-ID: <ggpxs4mlkobdkvqxbzroeogqe2kxlixne7ly4njb5ynnszvvkv@3gusj5w53bbj>
References: <20241028142000.1058149-1-aren@peacevolution.org>
 <20241028142000.1058149-4-aren@peacevolution.org>
 <Zx-h7QUnCKwtu8iC@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx-h7QUnCKwtu8iC@smile.fi.intel.com>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1730133443;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references;
	bh=gdOU4coDgP08ETzmQ6TrRirADJ9U/DUQX3kgQYM7trA=;
	b=kFVcCIcJo6Ek5A4d6Q2vJUHdv6X6HwVgUIczq4fGAc+pf54dMUmDlrVQ6Eke3XInhVXd7E
	PVtfa3b4ITCZ9SQQ/Y/6Os+XfjHE4beWqBE1BJrzfxNZHraO2ZgAak/YNnz/C9L2F1F+ij
	uXKcRDiF/zD1BEXb+ZEbsKob8TH3ZTA=

On Mon, Oct 28, 2024 at 04:38:37PM +0200, Andy Shevchenko wrote:
> On Mon, Oct 28, 2024 at 10:19:57AM -0400, Aren Moynihan wrote:
> > The vdd and leda supplies must be powered on for the chip to function
> > and can be powered off during system suspend.
> > 
> > Co-developed-by: Ondrej Jirman <megi@xff.cz>
> 
> Missing SoB. Please, read Submitting Patches documentation for understanding
> what has to be done here.
> 
> > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> 
> ...
> 
> > Notes:
> >     I'm not sure what the proper way to handle attribution for this patch
> >     is. It was origionally based on a patch by Ondrej Jirman[1], but I have
> >     rewritten a large portion if it. I have included a Co-developed-by tag
> >     to indicate this, but haven't sent him this patch, so I'm not sure what
> >     to do about a Signed-off-by.
> 
> Ah, seems you already aware of this issue. So, either drop Co-developed-by
> (and if you wish you may give a credit in a free form inside commit message)
> or make sure you get his SoB tag.

Alright, thanks for clarifying that.

> >  	mutex_init(&data->lock);
> 
> Somewhere (in the previous patch?) you want to switch to devm_mutex_init().

Good catch, it looks like that was being leaked before this refactor.
Yeah that sounds like the right place, I'll include it in v4.

> > +	ret = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(data->supplies),
> > +				      data->supplies);
> > +	if (ret)
> > +		return dev_err_probe(&client->dev, ret, "get regulators failed\n");
> 
> > +		return dev_err_probe(&client->dev, ret,
> > +				     "regulator enable failed\n");
> 
> > +	ret = devm_add_action_or_reset(&client->dev, stk3310_regulators_disable, data);
> > +	if (ret)
> > +		return dev_err_probe(&client->dev, ret,
> > +				     "failed to register regulator cleanup\n");
> 
> With
> 
> 	struct devuce *dev = &client->dev;
> 
> at the top of the function makes these and more lines neater.
> 
[snip]
> 
> While changing to RCT order here, it seems you have inconsistent approach
> elsewhere (in your own patches!). Please, be consistent with chosen style.

Sounds easy enough to fix, I'll include these in v4.

Thanks taking the time to review
 - Aren

