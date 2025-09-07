Return-Path: <linux-iio+bounces-23848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4EDB47AC1
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 13:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6869317B411
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 11:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD238258EC3;
	Sun,  7 Sep 2025 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iS1cs+pt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D78718FDAB;
	Sun,  7 Sep 2025 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757243821; cv=none; b=kwUZPVWnJ4L1l3vAE1NwRhowzt1XHvisiervQPhlPGT8uyOQv3HZSQ4FnX6hlZIc3NXfmJohbN7lsqzRcw03k5O/XFEtULB5DnCF1XCNru5cpqwDOLr3P0BX5J3jRHR6j260IQSJPieZjapT3zK49lGk9+SDSxWRW0OexXuoxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757243821; c=relaxed/simple;
	bh=HDuRK5OlRlwj4AsSNx4pukLeFXDMrzgkSpXg12TREX0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2iW/Mcp/0+hFK+m5zqItBtN5ZveH5sIXlYFdQzX1LPr7cJh8c7LNzPrwqfJnt2iJQRaiwv/CAB6aHMvpK/OM5w//7w/jNYGEKMo8pSgUhBBqvwdqEXBnSFSNGLBRe1mwL8pA1j/rASibD/elRT6LFe0D31Jqz4SAtSTcn68Z7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iS1cs+pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565BBC4CEF0;
	Sun,  7 Sep 2025 11:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757243820;
	bh=HDuRK5OlRlwj4AsSNx4pukLeFXDMrzgkSpXg12TREX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iS1cs+ptn5hJKyzO9xqJJH1fIgV4srEWubZtAXolxB4jF+zKIUU94ONVPPbSfgzJ8
	 uBMfnOg/Z52m4wQbJap3QvI7GkDP2+mB19sKl4359XJPk5TH6YPdskXPvSfFhqiyrG
	 YMB1gtYRJjaeIflp+f5/K+F/iMupuo7TdgBDFQcmQvoA51yv1LETDHWcPc5TuP9TqQ
	 xhq6qbedurb36hrYoExo0MMudgxwI15ySh2rMf1XBEVy6J5juqkiXtEILoiWa4okPV
	 G3XAkOz83B/KMO2QM+i1o9SEYTYNQPHMIItKkHzWxyb2X3R0Vi+ZmA8Dk+keBXz6bj
	 bV4TaYfCR5JKw==
Date: Sun, 7 Sep 2025 12:16:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Tobias Sperling
 <tobias.sperling@softing.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Esteban Blanc <eblanc@baylibre.com>, Herve Codina
 <herve.codina@bootlin.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, Eason Yang <j2anfernee@gmail.com>, Pop Ioan
 Daniel <pop.ioan-daniel@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
Message-ID: <20250907121647.425fb8d1@jic23-huawei>
In-Reply-To: <796291b5-f61a-4d68-9cbb-ae099dbb93d8@gmail.com>
References: <cover.1756988028.git.mazziesaccount@gmail.com>
	<facc8b9255a754f767807b7e5c79c0eb20c680e4.1756988028.git.mazziesaccount@gmail.com>
	<aLmVzDB4bk-z5d16@smile.fi.intel.com>
	<796291b5-f61a-4d68-9cbb-ae099dbb93d8@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >> +/* ADC channels as named in the data-sheet */
> >> +static const char * const bd79112_chan_names[] = {
> >> +	"AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A", "AGIO4A",	/* 0 - 4 */
> >> +	"AGIO5A", "AGIO6A", "AGIO7A", "AGIO8A", "AGIO9A",	/* 5 - 9 */
> >> +	"AGIO10A", "AGIO11A", "AGIO12A", "AGIO13A", "AGIO14A",	/* 10 - 14 */
> >> +	"AGIO15A", "AGIO0B", "AGIO1B", "AGIO2B", "AGIO3B",	/* 15 - 19 */
> >> +	"AGIO4B", "AGIO5B", "AGIO6B", "AGIO7B", "AGIO8B",	/* 20 - 24 */
> >> +	"AGIO9B", "AGIO10B", "AGIO11B", "AGIO12B", "AGIO13B",	/* 25 - 29 */
> >> +	"AGIO14B", "AGIO15B",					/* 30 - 31 */  
> > 
> > O-o-key, but why not power-of-two per line (esp. taking into account
> > the whole size)? (Whatever, it's not something I would fight for.)  
> 
> I just filled the rows to the maximum width, while keeping the item 
> count same for each row and adding the comment.
> 
> I'm not really sure having 4 items / row, and adding one row more would 
> be much better, but not much worse either. I can do this if you think 
> it's better. (No need to even fight for that).

In this case I'd do it in 4s purely because then the B ones start on
a new line and that looks nicer ;)

> 
> >> +};  
> > 
> > ...
> >   
> >> +	data->vref_mv = ret / 1000;  
> > 
> > Yeah, mV, (MICRO / MILLI) and other things I leave to other people to discuss.  
> 
> Thanks Andy. I've a feeling we were somewhat stuck on this discussion 
> anyways. I suppose it's nice to hear other's opinions if someone else 
> really cares. This was approaching bikeshedding.
> 
I'll just throw a quick comment in here.  

I'm absolutely in favour of the defines as they help in several ways.
- Stop counting 0s when there are lots of them. 
- Provide information on the unit conversion not otherwise visible
  where they happen to be used (often avoids need for local variables etc).
- Consistency across a code base.

In this particular case none apply strongly enough to force the issue.
Even so I'd prefer the units.h macros are used for the consistency reason
but I won't refuse to merge the driver over this.

One of those perfect (to me) being the enemy of good cases.

p.s. Matti, 3 versions in 4 days?  Perhaps slow down a little.

