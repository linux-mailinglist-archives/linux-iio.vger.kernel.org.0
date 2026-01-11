Return-Path: <linux-iio+bounces-27588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 898F9D0EBA3
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5EF0300D168
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 11:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFCF33985B;
	Sun, 11 Jan 2026 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7acq7fa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D86330D36;
	Sun, 11 Jan 2026 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768131678; cv=none; b=HfqZhUFaqxUL5SUyduYS7/QVTod0lqG9q62cJsIWZzFL14YPWoOLYpR6xIeBq5j8AotgtjvZFml2eocew97aOeGo4ZhfvOy/A0AVuLBa4x+/UNOdD6iMPxAc3ZaUWrwy33X6D/hiYM9S8ulbcb3hKl1JmJi80ac9aHQLKpyk8qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768131678; c=relaxed/simple;
	bh=DlhGZ34PxgEL0lip3RdG4vCEntHbEvpG+Lo6qxVHrAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kiPNmmuxx6VFWsrlFV5NwSw1y7ZO1QTwFKuIrGQIYbUHSqO6hUsDiQio7IYpL9dHxRhaKkx0dQdqcteuTfsODdBUv0bldeBma05607mNtNZPkuHvlKh0AZB/PmaQdpHSOXaDt+B4MVFBRiOErTi3IfTKFhBZe9GeKvpA1g2CYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7acq7fa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B58C4CEF7;
	Sun, 11 Jan 2026 11:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768131678;
	bh=DlhGZ34PxgEL0lip3RdG4vCEntHbEvpG+Lo6qxVHrAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i7acq7faC7CsajshD6B79K7xAA1fJQHCbkMYh4hBiSMtpsF4AmJejrBiTpcVUIYO1
	 rz11/z6B7BaS4nmRZi2dxigmaSTAVypPdkTpIXSJDjOb8lxiK5KCe7HNS5B9FDqjJL
	 1+0E/n7YahqZ1ppZKtSSHhf7zQwCkFmRcmEzyiTmLMbGU3YbpSJPvddlw6JA/djmXZ
	 K7J31cZqEp8azxiSOSfn2L7ow4s5yirvUf5kYGdJvTpLsYvuutwQO6q6IBXS1kps1b
	 /8vv8DysdjuL+jCNj13bQc/LZJTfy1JK3RuQ6fDR2SYEndybkkOwEFkMxV7DakNmOR
	 Do7SFQ12DjIdw==
Date: Sun, 11 Jan 2026 11:41:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa  <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, David Lechner  <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
Message-ID: <20260111114109.28b01266@jic23-huawei>
In-Reply-To: <997f9d13f44031170a4518abf23ee6806d526054.camel@gmail.com>
References: <20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
	<20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
	<20251221200014.29af7df8@jic23-huawei>
	<356a75b0-dc3e-4d10-a827-1af3b4ab638f@vaisala.com>
	<997f9d13f44031170a4518abf23ee6806d526054.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 05 Jan 2026 14:57:02 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2026-01-05 at 13:06 +0200, Tomas Melin wrote:
> > Hi,
> >=20
> > On 21/12/2025 22:00, Jonathan Cameron wrote: =20
> > > On Tue, 16 Dec 2025 11:40:06 +0000
> > > Tomas Melin <tomas.melin@vaisala.com> wrote:
> > >  =20
> > > > Not all users can or want to use the device with an iio-backend.
> > > > For these users, let the driver work in standalone mode, not coupled
> > > > to the backend or the services it provides.
> > > >=20
> > > > Signed-off-by: Tomas Melin <tomas.melin@vaisala.com> =20
> > > Hi Tomas,
> > >  =20
> > > > =C2=A0static int ad9467_probe(struct spi_device *spi)
> > > > @@ -1352,21 +1361,25 @@ static int ad9467_probe(struct spi_device *=
spi)
> > > > =C2=A0	indio_dev->channels =3D st->info->channels;
> > > > =C2=A0	indio_dev->num_channels =3D st->info->num_channels;
> > > > =C2=A0
> > > > +	/* Using a backend is optional */ =20
> > >=20
> > > I'll largely defer to Nuno on the backend aspects but I would like a
> > > lot more than a statement that it is optional in this comment.
> > > At least something about where the data goes and what a real system
> > > that didn't provide a backend would look like etc. =20
> >=20
> > Having the backend as optional is about flexibility to incorporate these
> > devices as fits best with the system. The current backend approach is
> > pretty much dictated with how the ADI default backend is implemented.
> > These devices are fully configurable via SPI interface so the backend
> > doesn't necessarily need to be anything fancy or even configurable.
> >=20
> > So there is atleast two use cases that promote the optional iio-backend
> > approach
> > =C2=A0- simple backend that is not configurable, no need for a dedicated
> > driver. The backend (FPGA) sits and waits for data and handles it when
> > it arrives =20
>=20
> Agree on the above. Ideally we could have some dummy backend for the abov=
e but
> it is not really easy/maintainable to have it.

When we say the backend needs no driver, where does the data end up?
Is the idea that it goes into some processing pipeline and sent to
some external path that we have no visibility of? i.e. We configure the
data capture in Linux but never see the data?


>=20
> > -=C2=A0 custom backend not compatible with the adi backend features. For
> > example different approach to calibration, or other model for data
> > channels etc. =20
>=20
> I would argue the above would require a new driver with, perhaps, a new c=
ompatible
> on the frontend side for the needed modifications. Or we could introduce =
some kind
> of "detect backend vendor thing" so that the frontend driver can adapt at=
 runtime
> (though this looks like a "fancier" way of having a new compatible).
>=20
> Ideally we could somehow "detect" backend capabilities but these kind of =
systems are
> so different and usecase specific that, at least for now, I don't see how=
 that could be
> sanely done.

Agreed. If we need to extend things to deal with other styles of FPGA IP or=
 different
feature sets, that is the way to go.  That would require some public implem=
entation
that uses the interface

Jonathan

>=20
> - Nuno S=C3=A1
>=20
> >  =20


