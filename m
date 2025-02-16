Return-Path: <linux-iio+bounces-15559-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E42FA374B4
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 15:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80863ADC7A
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 14:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F12195381;
	Sun, 16 Feb 2025 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4TzT68C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4579218DB2B;
	Sun, 16 Feb 2025 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739716263; cv=none; b=LyuAK0oFVQA5YVAZdOFnDRwgUWI4ARZmGFRJ7tlhGGnTjH7Ghi5muzCDuYR2UkfO6ap3FGE2uN1wDXBt4jbTOZxiU4Uzj38rFu3yTvMORPVMytoprkhHz9YKMdIf3MtQ1KjZGA/ZXJeKiG86ZoofnwhC5OfJkT5Y1lSjO0y0KE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739716263; c=relaxed/simple;
	bh=3olusQxlP2lV5Ne2h6cljoQ1pOoB5XyJHYVk4XIXQUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqR8l4hONmeSTwt3zsoNxvuX28URmLJu3hqocN1XqVhG4QJK1W/DAvibNMpV7lky+wKCAQ5TJ1RL2WwiW7lSdg3dqW/mzDqFI41ltu39WbSOzLi5JKKiB323I2VPeaP33QqWVzz9JNfosU9k+AukUHne/lQCE9eWS7RA+9zr07E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4TzT68C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE32BC4CEDD;
	Sun, 16 Feb 2025 14:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739716262;
	bh=3olusQxlP2lV5Ne2h6cljoQ1pOoB5XyJHYVk4XIXQUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k4TzT68CAkXwVqBa35Yq+TjiwuvYfFJ7jMxhPzLvnZsJUUnWlbBnJnh/3UaF0XiHf
	 qBi/9ZghtKhdxXApECAMTcuut06w8DcTBdudoCyqsaH1YPVcil8Z1JvSz8f4N/k0Xh
	 W9EnQIDcPUyQrhpCGa4DSuug2uHS4Co0G2es6a71Q3Xgbw2tsxmita0Na1zd8up/tc
	 4F0RGFqWAMS4khZirBgBOE0tgzvGK/0jWmoE2zM3O/bF+4YDnWzzC6MGvpCGgma/6c
	 BUgwxS8wfU33Mwq6o7XrrBPzIWCt6stM2gwASiiicuwT1DJrsSuyXr4/+ylPq5OYtm
	 FJ59DJMmYO1Pg==
Date: Sun, 16 Feb 2025 14:30:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Kim Seer Paller
 <kimseer.paller@analog.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio
 <linux-iio@vger.kernel.org>, Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 2/2] gpio: gpio-adg1414: New driver
Message-ID: <20250216143052.6f21ace0@jic23-huawei>
In-Reply-To: <CACRpkda+CDRMYKmjw7kewenkteLhPYb040E4B=ZG6pgdy=65pg@mail.gmail.com>
References: <20250213-for_upstream-v2-0-ec4eff3b3cd5@analog.com>
	<20250213-for_upstream-v2-2-ec4eff3b3cd5@analog.com>
	<CACRpkdZR8X17Bn-i2anqjxf0Gk60V175F7Xfwytkhy7_K+LsSA@mail.gmail.com>
	<880631da17a6d8ed4afe5a8c453fd4f7d0e4fca5.camel@gmail.com>
	<CACRpkda+CDRMYKmjw7kewenkteLhPYb040E4B=ZG6pgdy=65pg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 15 Feb 2025 00:22:20 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> Let's check with Jonathan Cameron (IIO maintainer) on this as well.
> He might have ideas.
>=20
> For reference, the datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/adg14=
14.pdf
>=20
> (By the way: add the datasheet to a special Datasheet: tag in the
> commit please!)
>=20
> On Fri, Feb 14, 2025 at 2:17=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> > On Fri, 2025-02-14 at 00:25 +0100, Linus Walleij wrote: =20
>=20
> > > Now, the kernel does not have switch subsystem I think,
> > > so this is something like a special case, so we might be
> > > compelled to make an exception, if the users will all be in =20
> >
> > Exactly, since we could not find anything, the best fit seemed like the=
 gpio
> > subsystem. I was the one suggesting it since a new subsystem for a simp=
le device
> > like this looked excessive. If we had more devices that would fit such =
a class
> > of devices, maybe it would make more sense to start thinking on such a
> > subsystem?
> > =20
> > > say userspace and make use of this switch for factory lines
> > > or similar. =20
> >
> > Kim should know better again (about usecases) but I would also assume t=
his is
> > for userspace use. =20
>=20
> Actually the GPIO documentation Documentation/driver-api/gpio/using-gpio.=
rst
> even talks about this for userspace use cases:
>=20
> "The userspace ABI is intended for one-off deployments. Examples are prot=
otypes,
> factory lines, maker community projects, workshop specimen, production to=
ols,
> industrial automation, PLC-type use cases, door controllers, in short a p=
iece
> of specialized equipment that is not produced by the numbers, requiring
> operators to have a deep knowledge of the equipment and knows about the
> software-hardware interface to be set up. They should not have a natural =
fit
> to any existing kernel subsystem and not be a good fit for an operating s=
ystem,
> because of not being reusable or abstract enough, or involving a lot of n=
on
> computer hardware related policy."
>=20
> If this is the usecase, like controlling an external switch for such thin=
gs,
> using the GPIO subsystem might actually be reasonable in my opinion,
> (even if the DT bindings end up in their own category).
>=20
> If the switches control stuff related to computer machinery (i.e. integra=
ted
> into a laptop to switch on/off the fans...) then no. So it depends on how
> and where it will be used.

Maybe, treat them as a weird mux? A switch is similar to a mux with only
one connected path.  +CC Peter.=20

Jonathan

>=20
> Yours,
> Linus Walleij


