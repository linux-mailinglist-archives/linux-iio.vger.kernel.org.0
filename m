Return-Path: <linux-iio+bounces-12103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE5B9C3444
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 19:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B921A281495
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 18:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6C613D25E;
	Sun, 10 Nov 2024 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="Eo8NXdmw"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5913775E;
	Sun, 10 Nov 2024 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731264885; cv=none; b=VJ2204I6yoOfMEGuzC7Y1pkl5yqnn9O3WJrtvwo6Qpkpv25ul+oelVdFhlDo5Xq/7LFtiW2i0zXd9nEcXnRe1ATGeTC0rHW4kyF0WBmfOoBFgPsVoUho6HXL2Wn7SHQd2cOsFQnNx/c8FeUxSQeUcRjn9FEWl4uW7ySaoK+Iots=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731264885; c=relaxed/simple;
	bh=V+eE/t+FzySWFWW/6drfU3OwnnKhqgPc3wtXAEWTS1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSENU/ljid7gFJ7yQgaP3M/uFq9JPBqBBUSWUEEajSeVjTXdQ3QHloCPxRmqbG4CyHcOaiU5MIB+pvdd+zDfgkoqzvr738pMYbmjnrYsbUK4Sw84k4NsQ01M2YZcEeQSJkSUas9CGpSsq52qcajxNKiVmuPNxDJ8Eh8BGGSpN+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=Eo8NXdmw; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 60E3A4C82C;
	Sun, 10 Nov 2024 18:54:41 +0000 (UTC)
Date: Sun, 10 Nov 2024 13:54:39 -0500
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
Subject: Re: [PATCH v4 3/6] iio: light: stk3310: Implement vdd and leda
 supplies
Message-ID: <5t7wdgzq37oiu4knc7o7kkx26k35ueu73r5m7aky747em5faqw@e5scnj6ng5pq>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-9-aren@peacevolution.org>
 <ZyiHXl0mRIvM4Qa0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyiHXl0mRIvM4Qa0@smile.fi.intel.com>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1731264882;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references;
	bh=nzu+fFQ9R2PNTPL2rGE7HX35eqiZ6et7aOyn84A4GMI=;
	b=Eo8NXdmwWsEbOWsTdYpDI6QhJyazSLcdZWHHMOYyDmM6zdPoBbWR23Uk2K1d24I6iIhpU4
	j3LIbq8fC9P8c6D6EO7oOwLADrxCSjgNQCgomPhZCoc3QbeckTar8AbRHjcyghOKyy7iKV
	xH0MbmEgsn8QbhU95YITmrqi19tfVL8=

On Mon, Nov 04, 2024 at 10:35:42AM +0200, Andy Shevchenko wrote:
> On Sat, Nov 02, 2024 at 03:50:39PM -0400, Aren Moynihan wrote:
> > The vdd and leda supplies must be powered on for the chip to function
> > and can be powered off during system suspend.
> > 
> > This was originally based on a patch by Ondrej Jirman[1], but has been
> > rewritten since.
> > 
> > 1: https://codeberg.org/megi/linux/commit/a933aff8b7a0e6e3c9cf1d832dcba07022bbfa82
> 
> Make it a Link tag...
> 
> > 
> 
> ...here
> 
> Link: https://codeberg.org/megi/linux/commit/a933aff8b7a0e6e3c9cf1d832dcba07022bbfa82 [1]

Makes sense

> > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> 
> ...
> 
> > +	ret = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(data->supplies),
> > +				      data->supplies);
> > +	if (ret)
> > +		return dev_err_probe(&client->dev, ret, "get regulators failed\n");
> 
> With previously introduced temporary 'dev' variable these become:
> 
> 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies), data->supplies);
> 	if (ret)
> 		return dev_err_probe(dev, ret, "get regulators failed\n");
> 
> ...
> 
> > +	ret = stk3310_regulators_enable(data);
> > +	if (ret)
> > +		return dev_err_probe(&client->dev, ret,
> > +				     "regulator enable failed\n");
> > +
> > +	ret = devm_add_action_or_reset(&client->dev, stk3310_regulators_disable, data);
> > +	if (ret)
> > +		return dev_err_probe(&client->dev, ret,
> > +				     "failed to register regulator cleanup\n");
> 
> So do these...
> 

Cleaning all of these up

> > +	ret = regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
> 
> Is array_size.h included?

It's not, it looks like it came one of the headers that's already
included. I'll add it explicitly.

Thanks
 - Aren

