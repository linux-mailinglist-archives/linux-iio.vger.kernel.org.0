Return-Path: <linux-iio+bounces-6004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88034900675
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C941C22CED
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 14:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF57919643F;
	Fri,  7 Jun 2024 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="a/gaYwcM"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908491667DE;
	Fri,  7 Jun 2024 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770396; cv=none; b=Ggnn6jFibAqLoPXPz8iMMCEYXvyNLzE9kHNN1uQ9yPu5FRlT0Xvrevzf68Uy3N/TiM5EphJJ/NQNnO63r/Tt+pGnPckZuNhkW1wHdSzY7zrH7aFPE/mj5TxiEKXOggmCi5jCDo9lOXBcSkm69lxQBvUpVgp477LJGoMKARKrkDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770396; c=relaxed/simple;
	bh=HhNF4gEO9wpQcZi+i8Hge7O/z4YF0BVJjH5/9mep+YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXOYZu1rLO2o5yL509pCafY7RjJ5JC/P1hSd0gyRm4lxJdrKymE8H01XL1uL1e472uRENUrtLGoRfwZj7DC4bB0nnKVE4v084JiyWQFKGYyrgdd5P7e/mK2/+ZIcMkviPbVonfgy9HJ2oAfXEdf0XhkEHJeCZl1bYmtINSWl85I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=a/gaYwcM; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id D016947E7E;
	Fri,  7 Jun 2024 14:19:18 +0000 (UTC)
Date: Fri, 7 Jun 2024 10:19:16 -0400
From: Aren <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Ondrej Jirman <megi@xff.cz>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org, phone-devel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Willow Barraco <contact@willowbarraco.fr>
Subject: Re: [PATCH v2 2/6] iio: light: stk3310: Implement vdd supply and
 power it off during suspend
Message-ID: <nkn5emedlkowgjdlqsvssg5ci3lipasbc5aaxn2krd5a6z3af4@fvvp4ysu5rs2>
References: <20240423223309.1468198-2-aren@peacevolution.org>
 <20240423223309.1468198-4-aren@peacevolution.org>
 <20240428175337.61850e2a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428175337.61850e2a@jic23-huawei>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1717769960;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references;
	bh=XAEyN4AkCHtTFKYLX9Yy5JtVjbYzN1yPHYJt3534IMA=;
	b=a/gaYwcMwCH5yEh0swQaVtYVZwoEyr5KOx8OT9hrOGq/WzYIGxag68OcknO+ioNpWPzqrp
	+X0ZhZ+6Ayy4OAseVLcHTZAifciqwFAPQE/uGytxwiMUbCR9bxIRvauaNsb1jnaUQ987R0
	LyF1ukyJzdq4QZ7RUzLNGqVnAlzBfPY=

On Sun, Apr 28, 2024 at 05:53:37PM GMT, Jonathan Cameron wrote:
> On Tue, 23 Apr 2024 18:33:05 -0400
> Aren Moynihan <aren@peacevolution.org> wrote:
> 
> > From: Ondrej Jirman <megi@xff.cz>
> > 
> > VDD power input can be used to completely power off the chip during
> > system suspend. Do so if available.
> > 
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> 
> Suggestions inline.  Key thing is take the whole thing devm_ managed
> and your life gets much easier.  It is mixing the two approaches that
> causes problems and often the best plan is to do everything in probe/remove
> with devm_ calls to do the cleanup for you.

Thank you for writing this up. I've been a bit distracted lately, but
I'm hoping to find some time to implement this in a new revision soon.

 - Aren

