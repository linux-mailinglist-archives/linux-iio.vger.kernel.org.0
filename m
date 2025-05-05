Return-Path: <linux-iio+bounces-19120-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9EDAA990F
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 18:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808E51886D45
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 16:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5A3199FAB;
	Mon,  5 May 2025 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW064QiB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E6586342;
	Mon,  5 May 2025 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462725; cv=none; b=qTJbU4Y0VEFNb1tbDZDa66r7R6Wdb5jly7/ts3y5gn04RFiJlKNHhzwvO5K8petKBTaz8BgCDeGfQLXUUNH3ZP60r27tTqnIauOqSlUALGsM4+Ve/Y07Ixf2TFJBrTaFW6rtNQNesXuPrZefUO1VJCF1uU9/HLNrzZ2KzwHqyu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462725; c=relaxed/simple;
	bh=tiVRsmLJNLwUBFGcvVWRYCFsajScnZZQYzwaxhc6GeM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8ro0MKTVHx4O0tbNKYJfHd6TirVjkuLKQt+Knj3zOXmE3oms0txDE7psSw2tHZzi53xv+bKP8PYjly+PMInCjQndi2JWbcYm+goSyGRHwsUyUdbNr51Z3xB4PkW0Cto67Y4YvcZtJmEurxBClAE6xP2AMDonq7bjMHuccvUP+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW064QiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC05C4CEE4;
	Mon,  5 May 2025 16:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746462724;
	bh=tiVRsmLJNLwUBFGcvVWRYCFsajScnZZQYzwaxhc6GeM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UW064QiBvtoRNqQEFWYsghFhlwiRlSBbuEAjI5INi4UD4golpc1ZzglUQu3cT8FJd
	 IR8+l0IhoKhUdkXizBvCbZ0K2CGGOxyO/jQpebhFsnn6faIxDWKA2wZDi0eESc8zGG
	 a18Uw9AAMvSGn6kpsu9PC4zI7RbMvGYUH0nE78gQHfLB6oxe3AlttfthCIkkB9AeZM
	 bSNoCPWna6Kcn+ZBIY/gcoP8sJ8IQJFqVhZ/tD2GjuVGmt3f6+I5osT+uKKr2dCRbc
	 EVNDxFwnYEA8CzEjYthdTf14l1aXdyx9sMScPUM/Jea4VFNWJCJwjwKkbgxM0jXSiL
	 +3pilCLj0s2rQ==
Date: Mon, 5 May 2025 17:31:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ti-adc128s052: Drop variable vref
Message-ID: <20250505173157.57aa16f9@jic23-huawei>
In-Reply-To: <4085fd58-c92c-406b-842b-ecda2fb3c895@gmail.com>
References: <59106e24332743a7f9eb0b13ad6a2f5595ab485a.1745823530.git.mazziesaccount@gmail.com>
	<CAHp75VcUcrj-BLp9QDsYMDY_SeQS76LDGge5vVqrx-MVwukP0w@mail.gmail.com>
	<4085fd58-c92c-406b-842b-ecda2fb3c895@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Apr 2025 12:45:13 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 28/04/2025 10:08, Andy Shevchenko wrote:
> > On Mon, Apr 28, 2025 at 10:02=E2=80=AFAM Matti Vaittinen
> > <mazziesaccount@gmail.com> wrote: =20
> >>
> >> According to Jonathan, variable reference voltages are very rare. It is
> >> unlikely it is needed, and supporting it makes the code a bit more
> >> complex.
> >>
> >> Simplify the driver and drop the variable vref support. =20
> >=20
> > ...
> >  =20
> >> +       int vref_mv; =20
> >=20
> > vref_mV please. And yes, I know historical and other reasons for them
> > all being small, but let's try to be more scientific in these crazy
> > days. =20
>=20
> Sorry Andy but I see zero reason to use capital letters here. In my=20
> opinion, this is perfectly clear as it is. Capital letters in variables=20
> are ugly (to me) and absolutely not needed to explain the meaning.
>=20
> > ...
> >  =20
> >> +       adc->vref_mv =3D ret / 1000; =20
> >=20
> > MILLI ? =20
>=20
> I suppose using MILLI is Ok. (Although 1000 seems still clear enough to=20
> me. Seeing the amount of zeroes at a glance gets troublesome for me at=20
> 10000).
>=20
> > Or actually a time to introduce MILLIVOLT_PER_VOLT in units.h ? =20

It's logically neither. If we did go that way it's MICROVOLT_PER_MILLIVOLT.
So we move to constants it should be
	adc->vref_mv =3D ret / (MICRO / MILLI);

I'm not seeing that as worthwhile though when people have been particularly
keen on these units.h defines I have argued in favour of similar constructs.

Anyhow on basis of moving forwards and parking this discussion
for the future, I'll apply the patch with just the alignment tweak
David pointed out. =20

Jonathan



>=20
> I really fail to see the benefit. Do you think we should add=20
> MILLIx_PER_x for each unit we can imagine/use?
>=20
> That doesn't really scale or make sense to me. We have MILLI. It does=20
> not really matter if it is volts, amps, ohms or horse heads - it's still=
=20
> 1000. It just gets cumbersome to search the headers to see if we have=20
> some fancy define for unit we have at our hands.
>=20
> And, to repeat myself - for me even the 1000 is still clear as it is.
>=20
> Yours,
> 	-- Matti


