Return-Path: <linux-iio+bounces-8215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DBF946A6F
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 17:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C80281A74
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 15:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F15153800;
	Sat,  3 Aug 2024 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uK5sIQvc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7013BAE4;
	Sat,  3 Aug 2024 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722700091; cv=none; b=bMHusqMHGiHal2+UFV83ygMxeIlyMm0foDAZmRqV0trbZ+miqAWRbQyy5E74rnPKmU16ycNYDiD/0nYb7UOoYVU/76aH+ukVTGV9yi8xOv4IDbGUiLCqbVB5L/Jn+ErcOx1MFaNT0+fgQ0rPQMxx6clStlpDEd5NLpolvO5vd44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722700091; c=relaxed/simple;
	bh=DAclLAdadIcv5GbKdMwU03XIRinbvL5u0SJFNzJ02qE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCGtcbl78GLY4jD8q8XkV+/QyLOOFGI3/xZJdk61+olwr12N43+k4P1mQt4rmHXTLtW6e/ZNjcmA58TN/4RDlZ8vFAuQMIF7ZDxAAEZKx0CSyXHIXHb1R427EldgooHCulqOhSNzy7JIS9ocXUZOe6TJA3BMxnlhvbzUPMsKFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uK5sIQvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555FAC116B1;
	Sat,  3 Aug 2024 15:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722700091;
	bh=DAclLAdadIcv5GbKdMwU03XIRinbvL5u0SJFNzJ02qE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uK5sIQvcwJx1/JLdOtwx7ILXbmWW3Tr8EPd5WdlibpipEIkIqWSy6FvFCzzVcBIfx
	 R9g/6beoLPJfpRUS8qs0gtwHgaWfMMx+vJaNOTK0oxpbY3cNZZS4kxP/pUQUJ2OaJD
	 L63DPvQc+P0YrkBD1KNhrt700dMqx2/WIJHeFrVRixC6fcQd6PcqLLIUN+5Dij0k4n
	 0tLQ+s1EZm60wvB9ZSlBFpMEQuQHP/TgCU5y3797EJeJn5GCE5tXd2qdQuFsIT3PRK
	 Kr7zwaAN8YnTr94fM9ruY0KADYcMdAVspjNle24oiB/CP3V6j8tErvSMCAej0UfbZt
	 2lxpV7CVXyt3A==
Date: Sat, 3 Aug 2024 16:48:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iio: adc: ads1119: Fix IRQ flags
Message-ID: <20240803164805.6929a84d@jic23-huawei>
In-Reply-To: <20240803121252.GA6207@francesco-nb>
References: <20240731140657.88265-1-francesco@dolcini.it>
	<20240731142016.6immldd7i4y7v2iw@joaog-nb>
	<20240803122127.221da36f@jic23-huawei>
	<20240803121252.GA6207@francesco-nb>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 3 Aug 2024 14:12:52 +0200
Francesco Dolcini <francesco@dolcini.it> wrote:

> Hello Jonathan,
>=20
> On Sat, Aug 03, 2024 at 12:21:27PM +0100, Jonathan Cameron wrote:
> > On Wed, 31 Jul 2024 11:20:16 -0300
> > Jo=C3=A3o Paulo Gon=C3=A7alves <jpaulo.silvagoncalves@gmail.com> wrote:
> >  =20
> > > On Wed, Jul 31, 2024 at 04:06:57PM +0200, Francesco Dolcini wrote: =20
> > > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > >=20
> > > > Remove IRQF_TRIGGER_FALLING flag from irq request, this should come=
 from
> > > > the platform firmware and should not be hard-coded into the driver.
> > > >=20
> > > > Add IRQF_ONESHOT flag to the irq request, the interrupt should not =
be
> > > > re-activated in interrupt context, it should be done only after the
> > > > device irq handler run.
> > > >   =20
> > >=20
> > > Reviwed-by: Jo=C3=A3o Paulo Gon=C3=A7alves <jpaulo.silvagoncalves@gma=
il.com> =20
> >=20
> > For the direction, there is a risk that we will break someone who
> > has a firmware that isn't setting this correctly. =20
>=20
> > I don't mind doing that if we have another board that needs control
> > (and is setting it appropriately) though.  Is that true here, or is
> > this just cleanup?
> >=20
> > If it's cleanup we tend to leave these alone (but not introduce them
> > into new code!) =20
>=20
> The driver was just introduced by me in v6.11, I assume that the only
> user is a board that is not yet available in the upstream Linux kernel
> (we gonna send the DT soon), with that said I am relatively confident we
> are not going to break any user.

ah! I'd missed the timeline detail completely.  Too many drivers and they
all have similar names :)

>=20
> The reason for sending this patch is that we just stumbled across
> a different driver that was hard-coding the IRQ flags and it was not work=
ing
> for our hardware, at that moment I realized that the decision on the just
> added ti-ads1119 was not the best one.
>=20
> The idea of this patch is to clean this up _before_ any user is
> affected.
>=20
Excellent.  Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan


> Francesco
>=20


