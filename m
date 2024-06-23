Return-Path: <linux-iio+bounces-6754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40727913B8E
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 16:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90470B23664
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 14:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F0D12F5A0;
	Sun, 23 Jun 2024 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR1k53Vz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5C61CD25;
	Sun, 23 Jun 2024 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150980; cv=none; b=XfXpM5rSPnhagN4ZpZYGVhvBA2JWNvxbg6MwKZ8QSW4Ve8cZUiDpQ4EieReWCOotM+5+sOUQXVA1VEeqyxY6RYFhuLKMPqtvEolsjhHWLnqMklvYNg1UPOvtBq5DFrrUbCXR5hrFUIBvV/33sF8THnwsd28yEVc5CR0g3bks4EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150980; c=relaxed/simple;
	bh=1TqNfrjnmIbq4EofHRStq9RfqUuJUuyjhurKwBGs4vg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VdzwgvqaU0vs0pRa3mUIi1eqPqf1nidYrrZhd3x6HRlt1XRmeAekmhrHBLXNBb455qycoRrpqEem4Xyud/U2eRQmxme3TMyjsIIgeKiktCVG5sPlHhI2f1mmd1I9ECW9wOA2hMPPUDUuBRyCiSHi/5r2Mo4gjKloCpulnLSR3Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR1k53Vz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726C3C4AF07;
	Sun, 23 Jun 2024 13:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150979;
	bh=1TqNfrjnmIbq4EofHRStq9RfqUuJUuyjhurKwBGs4vg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CR1k53VzGvgMLc/4z8J37DyBWVVjese3bLmus/09L4IgPzM9brjKQeAzedHwzgnvx
	 ZUKxUEo6KBVgq1NIjl3ot9SrWToAnzPeC2ajzW2gbwPsEcy3FjtEvhTTqKBzihAtKx
	 oV+nBWTmBg3XmCG/RsCFDW0ahTRbWJw41ATcjrLe6bgztoF49oJnxvKvshAu7/p9PD
	 13Nk84O2BzfpfeaXDSe48D6WOFi1a73QMh7ddS9wP+UAigBc/LtZzSOdKtEVKmMOCa
	 9miMCWDOkbAI+NtubaDGc4343APN20WK7hw8T27cF7/NRxmASg+PRco1TQpIe+vBQd
	 ogXhK3nUOVEpg==
Date: Sun, 23 Jun 2024 14:56:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Olivier MOYSAN <olivier.moysan@foss.st.com>, Nuno Sa
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] iio: add enable and disable services to iio backend
 framework
Message-ID: <20240623145614.1639d5a4@jic23-huawei>
In-Reply-To: <1e38d2638a2cc62f8a73c6eaf4fd4f79637dbb47.camel@gmail.com>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
	<20240618160836.945242-3-olivier.moysan@foss.st.com>
	<5b7b8a7132934b77b43ffde0650c68c1dd9a5b7e.camel@gmail.com>
	<8c3de47c-bd72-4560-a43b-5275f2f7a059@foss.st.com>
	<1e38d2638a2cc62f8a73c6eaf4fd4f79637dbb47.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Jun 2024 12:07:47 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2024-06-19 at 17:59 +0200, Olivier MOYSAN wrote:
> > Hi Nuno,
> >=20
> > On 6/19/24 07:21, Nuno S=C3=A1 wrote: =20
> > > On Tue, 2024-06-18 at 18:08 +0200, Olivier Moysan wrote: =20
> > > > Add iio_backend_disable() and iio_backend_enable() APIs to allow
> > > > IIO backend consumer to request backend disabling and enabling.
> > > >=20
> > > > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > > > --- =20
> > >=20
> > > Hi Olivier,
> > >=20
> > > small notes from me...
> > >  =20
> > > > =C2=A0=C2=A0drivers/iio/industrialio-backend.c | 26 +++++++++++++++=
+++++++++++
> > > > =C2=A0=C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> > > > =C2=A0=C2=A02 files changed, 28 insertions(+)
> > > >=20
> > > > diff --git a/drivers/iio/industrialio-backend.c
> > > > b/drivers/iio/industrialio-
> > > > backend.c
> > > > index b950e30018ca..d3db048c086b 100644
> > > > --- a/drivers/iio/industrialio-backend.c
> > > > +++ b/drivers/iio/industrialio-backend.c
> > > > @@ -166,6 +166,32 @@ int devm_iio_backend_enable(struct device *dev,
> > > > struct
> > > > iio_backend *back)
> > > > =C2=A0=C2=A0}
> > > > =C2=A0=C2=A0EXPORT_SYMBOL_NS_GPL(devm_iio_backend_enable, IIO_BACKE=
ND);
> > > > =C2=A0=20
> > > > +/**
> > > > + * iio_backend_enable - Backend enable
> > > > + * @dev: Consumer device for the backend
> > > > + * @back: Backend device
> > > > + *
> > > > + * RETURNS:
> > > > + * 0 on success, negative error number on failure.
> > > > + */
> > > > +int iio_backend_enable(struct device *dev, struct iio_backend *bac=
k)
> > > > +{
> > > > +	return iio_backend_op_call(back, enable);
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_enable, IIO_BACKEND); =20
> > >=20
> > > We do already have devm_iio_backend_enable(). From a correctness stan=
d point
> > > and even
> > > scalability, that API should now call your new iio_backend_enable() i=
nstead
> > > of
> > > directly call iio_backend_op_call(). I guess that change could be in =
this
> > > patch.
> > >  =20
> >=20
> > Sure. I have updated the patch.
> >  =20
> > > > +
> > > > +/**
> > > > + * iio_backend_disable - Backend disable
> > > > + * @dev: Consumer device for the backend
> > > > + * @back: Backend device
> > > > + *
> > > > + */
> > > > +void iio_backend_disable(struct device *dev, struct iio_backend *b=
ack)
> > > > +{
> > > > +	iio_backend_void_op_call(back, disable);
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_disable, IIO_BACKEND);
> > > > + =20
> > >=20
> > > We also have __iio_backend_disable() which is static since all users =
were
> > > using
> > > devm_iio_backend_enable(). I understand that's not suitable for you b=
ut I
> > > would
> > > instead rename the existing function to iio_backend_disable() and exp=
ort it.
> > >  =20
> >=20
> > Just renaming is not sufficient. The reason is that=20
> > devm_add_action_or_reset() require an action with action(void *)=20
> > prototype. So the prototype of iio_backend_disable() has to be changed=
=20
> > to void iio_backend_disable(void *back).
> > I placed the same arguments in enable and disable for symmetry, but *de=
v=20
> > is not required for time being in disable API. So it can make sense to=
=20
> > change iio_backend_disable() prototype.
> > alternatively, we can call __iio_backend_disable() through this API.
> > Please, let me know is you have a preference.
> >  =20
>=20
> Oh, yes, you're right. I would prefer your later option. Call
> __iio_backend_disable() from __iio_backend_disable() with a proper typed
?  That looks like an infinite loop :) =20
> parameter. I also just realized your 'struct device *dev' parameter. I th=
ink it
> can be removed for these APIs. The only reason for it is for
> devm_add_action_or_reset() which we don't need-
>=20
> - Nuno S=C3=A1
> > >  =20
>=20


