Return-Path: <linux-iio+bounces-11524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 916109B3BFE
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 21:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5700E285EAE
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 20:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A561DFE1C;
	Mon, 28 Oct 2024 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMIV7ouo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC49148300;
	Mon, 28 Oct 2024 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147930; cv=none; b=Tc70MdybFNtnloEmIR3AeLLO0dteUGtDQHmoez16ke8OzK7jS7f+dJXzQfdRG4N4EQrlwEc1eRFSBsFuQPJGJWJm0xdNK9K/xXhqgKfHIgo13sYetxkS7wiB5JcrQv5tzG8AMQrAE+GzHyskSkIWquMLD1JB/csTZXL+PdNzjdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147930; c=relaxed/simple;
	bh=m3PZAoWfta+ZnN37Ke0OPKpW1qTjsH1pXd/rg1xGge8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qt0yXYBIg4X0qiX0Pp5dlHtsfL/U4sgrLRjhbRuFewfk9wAYSncIQ/ZKTBhcCrRGhJ8d3L/6WgN/t1XXnUff1NgxpNnsxHexNCMGsW19GQlzyk/i+Kh9quYK4IMmjztkElbJfAtBgpXFDEQ1qFggGYgFiUjJ0F4x6d4d0414wOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMIV7ouo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99932C4CEC3;
	Mon, 28 Oct 2024 20:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147930;
	bh=m3PZAoWfta+ZnN37Ke0OPKpW1qTjsH1pXd/rg1xGge8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oMIV7ouoNxO1A4ULnqqb+zD3y3ho0clS8GBIBs9qHMH/dskaNgIq+bZz1RhmTW+DE
	 SdERiwUKLf/JmJS73kqRx3/PkieSIliCACITTT85+ZwQcUoI1m4mnZR2cD4eGCc3O5
	 DnKK7yMH+cuPax9jnFOtaF0Loz/0flFGLZJWwepSNIQAT8Cg7Kmr4liSyVojS5UznI
	 3JHumZdHCyFHX/xpTUN6XW06BesrhaH7FMdfjfSl3K4hMRUump6ly9ZSFMU54gRSiV
	 HJO6jwiYGeUjG9em0maWV5mqGxa0K2xPhFnz5ulbFyTuX2kLo1eg1TnyrnoTAmZnnb
	 wz3rU2IKfHlCA==
Date: Mon, 28 Oct 2024 20:38:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Aren Moynihan <aren@peacevolution.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Kaustabh Chakraborty <kauschluss@disroot.org>,
 =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>, Ondrej Jirman
 <megi@xff.cz>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, Dragan
 Simic <dsimic@manjaro.org>, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: light: stk3310: Implement vdd and leda
 supplies
Message-ID: <20241028203839.65debe2b@jic23-huawei>
In-Reply-To: <ggpxs4mlkobdkvqxbzroeogqe2kxlixne7ly4njb5ynnszvvkv@3gusj5w53bbj>
References: <20241028142000.1058149-1-aren@peacevolution.org>
	<20241028142000.1058149-4-aren@peacevolution.org>
	<Zx-h7QUnCKwtu8iC@smile.fi.intel.com>
	<ggpxs4mlkobdkvqxbzroeogqe2kxlixne7ly4njb5ynnszvvkv@3gusj5w53bbj>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 12:37:14 -0400
Aren Moynihan <aren@peacevolution.org> wrote:

> On Mon, Oct 28, 2024 at 04:38:37PM +0200, Andy Shevchenko wrote:
> > On Mon, Oct 28, 2024 at 10:19:57AM -0400, Aren Moynihan wrote:  
> > > The vdd and leda supplies must be powered on for the chip to function
> > > and can be powered off during system suspend.
> > > 
> > > Co-developed-by: Ondrej Jirman <megi@xff.cz>  
> > 
> > Missing SoB. Please, read Submitting Patches documentation for understanding
> > what has to be done here.
> >   
> > > Signed-off-by: Aren Moynihan <aren@peacevolution.org>  
> > 
> > ...
> >   
> > > Notes:
> > >     I'm not sure what the proper way to handle attribution for this patch
> > >     is. It was origionally based on a patch by Ondrej Jirman[1], but I have
> > >     rewritten a large portion if it. I have included a Co-developed-by tag
> > >     to indicate this, but haven't sent him this patch, so I'm not sure what
> > >     to do about a Signed-off-by.  
> > 
> > Ah, seems you already aware of this issue. So, either drop Co-developed-by
> > (and if you wish you may give a credit in a free form inside commit message)
> > or make sure you get his SoB tag.  
> 
> Alright, thanks for clarifying that.
> 
> > >  	mutex_init(&data->lock);  
> > 
> > Somewhere (in the previous patch?) you want to switch to devm_mutex_init().  
> 
> Good catch, it looks like that was being leaked before this refactor.
> Yeah that sounds like the right place, I'll include it in v4.
Not really on the leaking.  Take a look at the cleanup for devm_mutex_init().
It's debug only and not all that useful in most cases.

However, it is good to not assume that now we have a devm_mutex_init()
available that is easy to use.

> 
> > > +	ret = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(data->supplies),
> > > +				      data->supplies);
> > > +	if (ret)
> > > +		return dev_err_probe(&client->dev, ret, "get regulators failed\n");  
> >   
> > > +		return dev_err_probe(&client->dev, ret,
> > > +				     "regulator enable failed\n");  
> >   
> > > +	ret = devm_add_action_or_reset(&client->dev, stk3310_regulators_disable, data);
> > > +	if (ret)
> > > +		return dev_err_probe(&client->dev, ret,
> > > +				     "failed to register regulator cleanup\n");  
> > 
> > With
> > 
> > 	struct devuce *dev = &client->dev;
> > 
> > at the top of the function makes these and more lines neater.
> >   
> [snip]
> > 
> > While changing to RCT order here, it seems you have inconsistent approach
> > elsewhere (in your own patches!). Please, be consistent with chosen style.  
> 
> Sounds easy enough to fix, I'll include these in v4.
> 
> Thanks taking the time to review
>  - Aren


