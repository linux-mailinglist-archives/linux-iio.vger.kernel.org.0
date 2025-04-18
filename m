Return-Path: <linux-iio+bounces-18260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4FCA9397F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 17:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A4C8E4C06
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 15:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A382066FF;
	Fri, 18 Apr 2025 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOJcSG1Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF25013A265;
	Fri, 18 Apr 2025 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989530; cv=none; b=LVUoD7CQmziPkYLsd0MY13paCyT4d2W3/u/W8VD4DwL+mch+zhD4/Wn3fF4qMFmM6v71FnHq4P++oPauLhWlXinzpz+F/aWV2/noOqdPQsJyQC6oC/P4lDxPlhgAXpSCwNCGrDM6LkLQBSBpHZ7iuQW4/jZOoGwcoAbWaDRBXp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989530; c=relaxed/simple;
	bh=XglS+o5Edeva5i6kHjjB2Rr2O/LCTDY6vEze98CwMc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQryOAhIYb5Rd03+Tb3zpjO5BnLkYBXuzSkwv0jCb132StNkDvHz44pt6kT62RDd79hryN3mZb+UR38X6if+X1fcIO0b2bcXjNDsosyzNsfcCLsvH+9ld9PeZ/dR6UFfiTd8yIV8q9/R2QgPPmNZEbuJoqOfcwZY1IZB5kER+Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOJcSG1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEC1C4CEE2;
	Fri, 18 Apr 2025 15:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744989530;
	bh=XglS+o5Edeva5i6kHjjB2Rr2O/LCTDY6vEze98CwMc8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AOJcSG1QFr1ePZtdLjwDKd1WP2aeBriV4k2UHBLySKPITOMEUbA5afGQok1glITaL
	 HzVOz0uSFH9s9w+p5J1bguh2CwUET8mpFj3sQ3QBE0zdOLFxgeRk6PrUsA6clPKXGA
	 pu2PPJmlmqtUtb/0juEGnuu1rWebNpwIvIGUPWo9f1F9GXw+RzKSo9UmfchWpuNszH
	 TzOK87dj2fnnZhVyFWI3yC/DfxQcwJ0Adprijj2lrXXS78ckXGoG5LsAV1fUc7f79V
	 gczZySdYA5z1EFPXdgOEtXocV1r1SA3dlQ3n98hi223F5ymsXPqF9fDJJOJEzOPd8K
	 kWjsk3JL3F8mw==
Date: Fri, 18 Apr 2025 16:18:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, kernelmentees@lists.linuxfoundation.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: Correct conditional logic for store mode
Message-ID: <20250418161841.4ba1d05e@jic23-huawei>
In-Reply-To: <CAKUZ0zLiP_w-4xOXfBDdZbm+M8yVYvd+A=M73fnRT_kMyWwk7Q@mail.gmail.com>
References: <20250414154050.469482-1-gshahrouzi@gmail.com>
	<1fb5f1c5e61ce386cb431d48296e952bdd560a6c.camel@gmail.com>
	<CAKUZ0zLiP_w-4xOXfBDdZbm+M8yVYvd+A=M73fnRT_kMyWwk7Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Apr 2025 09:54:00 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> On Tue, Apr 15, 2025 at 5:13=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >
> > On Mon, 2025-04-14 at 11:40 -0400, Gabriel Shahrouzi wrote: =20
> > > The mode setting logic in ad7816_store_mode was reversed due to
> > > incorrect handling of the strcmp return value. strcmp returns 0 on
> > > match, so the `if (strcmp(buf, "full"))` block executed when the
> > > input was not "full".
> > >
> > > This resulted in "full" setting the mode to AD7816_PD (power-down) and
> > > other inputs setting it to AD7816_FULL.
> > >
> > > Fix this by checking it against 0 to correctly check for "full" and
> > > "power-down", mapping them to AD7816_FULL and AD7816_PD respectively.
> > >
> > > Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 device=
s")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > > --- =20
> >
> > LGTM, do you happen to have this device? It would more interesting to m=
ove this
> > driver out of staging :) =20
> Unfortunately, I do not have this device. However, I would still be
> interested in contributing if possible. I was looking over
> https://lore.kernel.org/all/20230716144024.30ded663@jic23-huawei/T/
> where the goal seemed to be to modernize it by replacing the sysfs
> interface with the iio channel. I also looked through the datasheet
> and it seemed to be missing some stuff like a channel that can be
> selected.
> >
> > Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git but amended the patch title
to start wit
staging: iio: adc: ad7816:=20

so people looking at a short log can see what it is touching.

Thanks,

Jonathan

> > =20
> > > Changes since v3:
> > >       - Tag stable@vger.kernel.org instead of an email CC
> > >       - Use the correct version for patch
> > > Changes since v2:
> > >       - Add fixes tag that references commit that introduced the bug.
> > >         - Replace sysfs_streq with strcmp.
> > > ---
> > >  drivers/staging/iio/adc/ad7816.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/iio/adc/ad7816.c
> > > b/drivers/staging/iio/adc/ad7816.c
> > > index 6c14d7bcdd675..081b17f498638 100644
> > > --- a/drivers/staging/iio/adc/ad7816.c
> > > +++ b/drivers/staging/iio/adc/ad7816.c
> > > @@ -136,7 +136,7 @@ static ssize_t ad7816_store_mode(struct device *d=
ev,
> > >       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > >       struct ad7816_chip_info *chip =3D iio_priv(indio_dev);
> > >
> > > -     if (strcmp(buf, "full")) {
> > > +     if (strcmp(buf, "full") =3D=3D 0) {
> > >               gpiod_set_value(chip->rdwr_pin, 1);
> > >               chip->mode =3D AD7816_FULL;
> > >       } else { =20
>=20


