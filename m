Return-Path: <linux-iio+bounces-20818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A12BAE2A6A
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 18:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74C01898A7C
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40503221F17;
	Sat, 21 Jun 2025 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7zuMRzv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD6B199BC;
	Sat, 21 Jun 2025 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750525115; cv=none; b=qF0Y8DFdem01N5uBKpYZozbPH1DD/nlmTH9RZFArocmwCsazuGvaPa9EKkI1olVZd+vIICRzrfDkzRtG3wZskPiRvvzPwNTCgY5hL4T844bsT7QodnepoWBkegn29NcEwkZ6dFQDrF0oNkWf3EeazLafsWDCYE19B56ruEqH9RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750525115; c=relaxed/simple;
	bh=pgvEFoHgM1otb7ZNHD/JiN1YKjs47RtPcLXUKBUPcpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q17uA6DrZvPuG2HOJPT6RukCcwggZC0M8dlO0iCETFcdmKxuION2m2Xq2kAPiIcBfOUq8eq7hXMtMUZR1bsItXZ41W5L/tWJieEk25eDUO171vysgVS8hAIvlPeudlZh/Xy1DR/U7Ns5g6/FsxJURkMHxEBUPcPs+I2IcNBdUP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7zuMRzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C23C4CEE7;
	Sat, 21 Jun 2025 16:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750525114;
	bh=pgvEFoHgM1otb7ZNHD/JiN1YKjs47RtPcLXUKBUPcpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h7zuMRzvanUNmYdOYp370APiNwoSXF/pTcQ6UeF+Ag4AlXaN+4GL0wloPCf/yrPl7
	 qstTQfOd4QAMpym73sPrMMlRKJhLUO20E/gEMDjj9cWXNcva4VWRb/OoJxi5cjeo7a
	 WuTqhEC0J40etibBuiUGdZV9Tpgh3BptflnqWA6Z8Th2job7RiYTAlkEppK3Rk7e8S
	 EAgI1Y/+xlJ/x1SyQeYfmXVnTNXP4TvSjXNKhj4UazJA0gyBcOowsCYp0+54fTAKLA
	 EcVG8ZfY+Jl/EhHhOfJAbsNkzvYm5FR/bvxbrtOqJq4MrQIapQVLnwwgzwN9BfcArb
	 nCUdd8I1XwjEg==
Date: Sat, 21 Jun 2025 17:58:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v9 05/11] iio: accel: adxl345: simplify reading the FIFO
Message-ID: <20250621175824.57bb9d9c@jic23-huawei>
In-Reply-To: <CAFXKEHaGk5NZ4dT9xLkAfirn974P9miwjs=5N+PTqJ2x00QOiA@mail.gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
	<20250610215933.84795-6-l.rubusch@gmail.com>
	<20250614144750.1f1a7a0f@jic23-huawei>
	<CAFXKEHaGk5NZ4dT9xLkAfirn974P9miwjs=5N+PTqJ2x00QOiA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Jun 2025 00:14:47 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Hi Jonathan,
>=20
> On Sat, Jun 14, 2025 at 3:47=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Tue, 10 Jun 2025 21:59:27 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Bulk reading from the FIFO can be simplified. Remove unnecessary
> > > variables and simplify reading sets of x-, y- and z-axis measurements.
> > >
> > > This is a refactoring change and should not impact functionality.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  drivers/iio/accel/adxl345_core.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adx=
l345_core.c
> > > index 18c625d323ba..dcfbfe4cac0f 100644
> > > --- a/drivers/iio/accel/adxl345_core.c
> > > +++ b/drivers/iio/accel/adxl345_core.c
> > > @@ -884,15 +884,13 @@ static int adxl345_get_samples(struct adxl345_s=
tate *st)
> > >   */
> > >  static int adxl345_fifo_transfer(struct adxl345_state *st, int sampl=
es)
> > >  {
> > > -     size_t count;
> > >       int i, ret =3D 0;
> > >
> > > -     /* count is the 3x the fifo_buf element size, hence 6B */
> > > -     count =3D sizeof(st->fifo_buf[0]) * ADXL345_DIRS;
> > >       for (i =3D 0; i < samples; i++) {
> > >               /* read 3x 2 byte elements from base address into next =
fifo_buf position */
> > >               ret =3D regmap_bulk_read(st->regmap, ADXL345_REG_XYZ_BA=
SE,
> > > -                                    st->fifo_buf + (i * count / 2), =
count);
> > > +                                    st->fifo_buf + (i * ADXL345_DIRS=
),
> > > +                                    2 * ADXL345_DIRS); =20
> >                                        sizeof(st->fifo_buf[0]) * ADXL34=
5_DIRS);
> >
> > As it's not locally obvious where that 2 comes from. =20
>=20
> Hm, I left the comment some lines above: "read 3x 2 byte elements from
> base address into next fifo_buf position" - so, the 2 comes from the 2
> bytes. 3x because of the 3-axis sensor, so 3 axis times 2 bytes. How
> can I improve it? The patch is just a simplification, removing that
> unnecessary count variable.

 sizeof(st->fifo_buf[0]) * ADXL345_DIRS);

improves it by making it clear where the 2 comes from.
Getting rid of count is good, but that remaining 2 *=20
should be replaced by using sizeof() the buffer element.

The comment would then be unnecessary as we are sizing it directly from
the fifo storage.  Fine to leave it if you like though.

Jonathan


>=20
> > =20
> > >               if (ret)
> > >                       return ret;
> > > =20
> > =20


