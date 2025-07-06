Return-Path: <linux-iio+bounces-21375-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA22AAFA416
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 11:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1957E17BF71
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 09:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6180D1FBE9E;
	Sun,  6 Jul 2025 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qN58nwDG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7351F473C;
	Sun,  6 Jul 2025 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751794926; cv=none; b=hMqjQXvaLmsnJMNsPYQJXC+qIGrPRor83cPY35Q8Hok8UkUgHgQPivJkrvX0WVyftnJKZbOgewe1LHOGLhTRvp3e9HOHphrVDT3q/sWNmaGS2/jYbzeDAfA747nd8W1LfUc6kGHlq269rrV1R6ZcAHH69qjoWl/Otu7FeJbr2NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751794926; c=relaxed/simple;
	bh=RbHFP10ikaccYr68d3kx6SBLaCOvtQEFFYuO8lgKhzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjaPsV2niqY9DdvuwLOUkGQrStbMll04a2TwCTH7nBliGxkzQ9/Brr0ruaTFmCiABGHf2Cxs5+AAmLlnrEp5A1J/2SuVHwuE/9gWWI4YG7OJGlJTVzZJJtB32a2aQx4DFWIu5GWvQXIWOLhD9iOxSv5xK7TOYe7vULDVLDEjTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qN58nwDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C853C4CEED;
	Sun,  6 Jul 2025 09:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751794926;
	bh=RbHFP10ikaccYr68d3kx6SBLaCOvtQEFFYuO8lgKhzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qN58nwDGr2BDRxdFvmVRsHyihUM1lRp5Beeunym6yVN5dHpBO54XybJw3EnjWDwFz
	 14s48dM1b3O1ZBMvMfn9hDizDHbPoq/Z1LGcwfuaOsET1WKAyCee53td4oVnQ77nXI
	 Ri9puilG/Ls1f4Y6/CRtrvdNwH+bOF6gPJ5BwiOmaZxVx9H35bOWoWsdVHSo0/+hgI
	 sS097MXAPI5SC/5T36+dlGUoAVmOCvPNet7BICCnuYbtRChvnY8eR2jZrzGBnG1pZa
	 N7xQUGOn4VaRMQia2G3T43a0VCckVDwVVpGcLmmp5JyhXULCP/2DNi2clGFa8ePcFw
	 ykZTOYIvl8JnA==
Date: Sun, 6 Jul 2025 10:41:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: andrew.lopes@alumni.usp.br, gustavobastos@usp.br, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, jstephan@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] iio: accel: sca3000: use sysfs_emit_at() instead
 of sprintf()
Message-ID: <20250706104159.59e525ee@jic23-huawei>
In-Reply-To: <CANZih_SWg03U1jOn63++A=+_9GkzFhtK7S563hdb2m=tk5SK0A@mail.gmail.com>
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
	<20250618031638.26477-5-andrew.lopes@alumni.usp.br>
	<20250621185824.69a11319@jic23-huawei>
	<CANZih_SWg03U1jOn63++A=+_9GkzFhtK7S563hdb2m=tk5SK0A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 5 Jul 2025 00:45:05 -0300
Andrew Ijano <andrew.ijano@gmail.com> wrote:

> On Sat, Jun 21, 2025 at 2:58=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> > > @@ -423,16 +423,16 @@ sca3000_show_available_3db_freqs(struct device =
*dev,
> > >  {
> > >       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > >       struct sca3000_state *st =3D iio_priv(indio_dev);
> > > -     int len;
> > > +     unsigned int len =3D 0; =20
> >
> > No need to initialize as set on the next line =20
>=20
> That makes sense! I=C2=B4ll change that.
>=20
> > =20
> > >
> > > -     len =3D sprintf(buf, "%d", st->info->measurement_mode_3db_freq);
> > > +     len =3D sysfs_emit_at(buf, len, "%d", st->info->measurement_mod=
e_3db_freq); =20
> >
> > sysfs_emit() when you know you are at the start.
> > =20
> Ok! Thanks.
>=20
> > =20
> > >       if (st->info->option_mode_1)
> > > -             len +=3D sprintf(buf + len, " %d",
> > > +             len +=3D sysfs_emit_at(buf, len, " %d",
> > >                              st->info->option_mode_1_3db_freq); =20
> > Fix alignment.
> > =20
> > >       if (st->info->option_mode_2)
> > > -             len +=3D sprintf(buf + len, " %d",
> > > +             len +=3D sysfs_emit_at(buf, len, " %d",
> > >                              st->info->option_mode_2_3db_freq); =20
> >
> > same here. =20
>=20
> Actually, both cases are aligned. I checked the code and they have the
> same number of tabs, and in this email they have the same number of
> spaces.
> However, since I'm not reading this diff with a monospaced font, for
> me it appears to be different but this is caused by the difference in
> size of "-" and "+".
> Maybe this is why it appears to be different for you too?
Key as in earlier reply is parameters that need to go on an additional line
are not aligned as particular number of tabs, they are aligned to under
the parameters on the first line.

The only normal reason to break with that rule is on particularly long
lines.

Jonathan

>=20
> Thanks,
> Andrew


