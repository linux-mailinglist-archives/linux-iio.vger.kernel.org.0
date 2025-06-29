Return-Path: <linux-iio+bounces-21107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F98AECEAC
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 18:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68CD11888B2C
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 16:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9447222F74A;
	Sun, 29 Jun 2025 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAGLxLpj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9FF2BCFB;
	Sun, 29 Jun 2025 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751214505; cv=none; b=cJMbgYe59IvPd1rC4t6AtZnJ8R8nRFDd8AXRsZYf74DKoFeIohrTvBLyCkBdkFYSP9gYEy9Uc3GKbZESB1pgsDjAkT+m1Hp7sDaaNyixiSNxnbMbY2csjdNTWX8TLzv6BWyz2ZWvyF6k6E8qsmbDQOw9JJQCWq2GsDlHRDrzkrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751214505; c=relaxed/simple;
	bh=tQZrK0/4WsZIfn0P7HNo9GIvPluqYxbGPtIgHl8N/8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJGqaR91WbkMz54oERs9qQEc09DLfo64hrbVvAFs1C3ZSvmDn6+gCPWyPDOnezubLzL54sSJqH2JASMFRV4QfhXFtHajbraDGLKizHdwLggGXR3u+4ZvFT03kkGfNyXNmcoA7Ifc0uzme9cdjijz+BxN0NCWzwB+fZqtg7spsg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAGLxLpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E10C4CEEB;
	Sun, 29 Jun 2025 16:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751214504;
	bh=tQZrK0/4WsZIfn0P7HNo9GIvPluqYxbGPtIgHl8N/8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gAGLxLpjfO5gcxbRBIqKKaa3UMIGrHn8g4Thi2NuXj09GZ/CEj04uh/C9dbRJ+rjz
	 HB+qZyql/tgDdKJmpkpNj1PNum6NMET618tklN0Hs7P5xFA9DuYZzinKa+dXFR02pO
	 waSyBPnKRi3VaJAToCLgbpcpBOJBNivrTc9vAsUxW5VzjnnZWAw7RnDtGmqaPPXQ4u
	 1yf27pYFKVDuvwTA2RPJwGgT660AMO9o0BIuGZy3vu8CVnbpcXqfqX7O5AWyZ2QaW+
	 SkS54rYUlqedWxdlCEQBxEn7PZsDXQt9gdk6OfjqtXVQsExiGw+hoabwD2lcN23jds
	 mhpLnuDnaG33A==
Date: Sun, 29 Jun 2025 17:28:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, corbet@lwn.net, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v10 4/7] iio: accel: adxl345: add inactivity feature
Message-ID: <20250629172815.47244e5d@jic23-huawei>
In-Reply-To: <CAHp75VfOKDZRoVWLQoPQPzpN2MceTeN_4OoU0RvxG7_J8OAoMw@mail.gmail.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
	<20250622155010.164451-5-l.rubusch@gmail.com>
	<aFkh-E1dG__p_G4m@smile.fi.intel.com>
	<20250628170839.482a3d63@jic23-huawei>
	<CAFXKEHZ7bNuy+6X4NgPPMOsT3AkSXhacH=3HS33bLTNgYa3PWg@mail.gmail.com>
	<CAHp75VfOKDZRoVWLQoPQPzpN2MceTeN_4OoU0RvxG7_J8OAoMw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 29 Jun 2025 10:30:15 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 29, 2025 at 12:11=E2=80=AFAM Lothar Rubusch <l.rubusch@gmail.=
com> wrote:
> > On Sat, Jun 28, 2025 at 6:08=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote: =20
>=20
> ...
>=20
> > > > > +           axis_ctrl =3D ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN=
 |
> > > > > +                           ADXL345_INACT_Z_EN; =20
> > > >
> > > > Consider
> > > >               axis_ctrl =3D
> > > >                       ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN | ADX=
L345_INACT_Z_EN;
> > > >
> > > > (yes, I see that it's longer than 80, but it might worth doing it f=
or the sake of
> > > >  consistency with the previous suggestion). =20
> > > Hmm. I'd go longer rather than do that just because it looks really u=
gly.
> > >
> > >                 axis_ctrl =3D ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN=
 | ADXL345_INACT_Z_EN;
> > >
> > > I don't care that much as long as long lines are justified by readabi=
lity. Here
> > > I think either Andy's suggestion or the all on one line are justified.
> > >
> > > Tomorrow I may have a different view :(
> > > =20
> >
> > As I=E2=80=99ve seen quite a bit of discussion around this. In fact, us=
ing
> > binary OR here might not even be necessary, since I can define
> > ADXL345_ACT_XYZ_EN and ADXL345_INACT_XYZ_EN directly and OR the fields
> > in the header. If you have no objections, I=E2=80=99ll likely prepare t=
his
> > change for the next version. =20
>=20
> Actually I like your idea. This will be sustainable over style
> preference changes.
>=20
Agreed.
Jonathan

>=20


