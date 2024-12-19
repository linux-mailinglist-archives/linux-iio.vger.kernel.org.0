Return-Path: <linux-iio+bounces-13664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D479F80C0
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D996189592A
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F38156F5F;
	Thu, 19 Dec 2024 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCJOPdDf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61521482F2;
	Thu, 19 Dec 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627085; cv=none; b=KQZQcdgpV3BNZUatkA8+b0Q0FkxuAA9+j1yK2VtlMW+TIdaCapsvFt/atDb/8BnUxnQLQKTg376q7Ct+l4c0/oD4FlqugfwQ/ehX+NfXDhm5DGLuaVAv05uxMwK6Rw0AQJ9RNE7ccHenkAJihRuhS1P1L6xEwNjViXGWnuqexvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627085; c=relaxed/simple;
	bh=YjjwN1qDk6h/VHjYVLABU7aPSic8XMjckxIoom6+G94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRO0hOfMjBM4KahJFIMpg27bSDhQ4NrF+YNvMNY2YK0BghqkHzm4Orga7hVXNrwS6C5vfUxfA6Up8nSnSqV7rfl8YGI1SLrFsrIgNuaJnPqqxGl37n3XZgQt0Q7pH8phlqYU2Sc2HZjN8e0iHkFNcT8Q/uuW4Gd5twcDRb/OtcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCJOPdDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8595C4CED4;
	Thu, 19 Dec 2024 16:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734627085;
	bh=YjjwN1qDk6h/VHjYVLABU7aPSic8XMjckxIoom6+G94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PCJOPdDfaWe7rVbYkTysHiOs7NRXBcY2VeqgDtAL0QUhV+SMu0aIM1YYlD122qPP1
	 4kMcZiYCUXoeheRiLpmXKzzaJik9bthzARgw4CIiftqvfDZgmw+AljxF5puonJS8r0
	 YtafNujpGgYtEQo27h+Qq1yLhSitDelw3wC9jnVoyx2ev6P/vkrP33fp51sLPKItmy
	 jXe7ViWECNwBvsHXtsAy0PltAIzwefUEODhDa8c2YVx+sEDBeWFmPmfsQGHyUojurV
	 ZdR2ZMCHPzrXqN0Cuqp8yCvoI23zANgGaPDEw8aHylcfWlBuzqH8S9U3YQYqnGWBKP
	 HYWZGUXIRB/gw==
Date: Thu, 19 Dec 2024 16:51:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Mihail
 Chindris <mihail.chindris@analog.com>, Nuno Sa	 <nuno.sa@analog.com>, David
 Lechner <dlechner@baylibre.com>, Olivier Moysan	
 <olivier.moysan@foss.st.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: [PATCH 4/8] iio: backend: add API for interface configuration
Message-ID: <20241219165115.23717a71@jic23-huawei>
In-Reply-To: <20241219164233.087ff9cb@jic23-huawei>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
	<20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-4-856ff71fc930@baylibre.com>
	<b5a773858a71e6929667fc73b9384908ca3ff313.camel@gmail.com>
	<20241219164233.087ff9cb@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Dec 2024 16:42:33 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 17 Dec 2024 11:13:59 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Mon, 2024-12-16 at 21:36 +0100, Angelo Dureghello wrote: =20
> > > From: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > >=20
> > > Add backend support for setting and getting the interface type
> > > in use.
> > >=20
> > > Link:
> > > https://lore.kernel.org/linux-iio/20241129153546.63584-1-antoniu.micl=
aus@analog.com/T/#m6d86939078d780512824f1540145aade38b0990b
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > ---
> > > This patch has been picked up from the Antoniu patchset
> > > still not accepted, and extended with the interface setter,
> > > fixing also namespace names to be between quotation marks.
> > > ---
> > > =C2=A0drivers/iio/industrialio-backend.c | 42
> > > ++++++++++++++++++++++++++++++++++++++
> > > =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 19 +++++++++++++++++
> > > =C2=A02 files changed, 61 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industr=
ialio-
> > > backend.c
> > > index 363281272035..6edc3e685f6a 100644
> > > --- a/drivers/iio/industrialio-backend.c
> > > +++ b/drivers/iio/industrialio-backend.c
> > > @@ -636,6 +636,48 @@ ssize_t iio_backend_ext_info_set(struct iio_dev
> > > *indio_dev, uintptr_t private,
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, "IIO_BACKEND");
> > > =C2=A0
> > > +/**
> > > + * iio_backend_interface_type_get - get the interface type used.
> > > + * @back: Backend device
> > > + * @type: Interface type
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int iio_backend_interface_type_get(struct iio_backend *back,
> > > +				=C2=A0=C2=A0 enum iio_backend_interface_type *type)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret =3D iio_backend_op_call(back, interface_type_get, type);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (*type >=3D IIO_BACKEND_INTERFACE_MAX)
> > > +		return -EINVAL;
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, "IIO_BACKEND");
> > > +
> > > +/**
> > > + * iio_backend_interface_type_set - set the interface type used.
> > > + * @back: Backend device
> > > + * @type: Interface type
> > > + *
> > > + * RETURNS:
> > > + * 0 on success, negative error number on failure.
> > > + */
> > > +int iio_backend_interface_type_set(struct iio_backend *back,
> > > +				=C2=A0=C2=A0 enum iio_backend_interface_type type)
> > > +{
> > > +	if (type >=3D IIO_BACKEND_INTERFACE_MAX)
> > > +		return -EINVAL;
> > > +
> > > +	return=C2=A0 iio_backend_op_call(back, interface_type_set, type);
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_set, "IIO_BACKEND");
> > > +
> > > =C2=A0/**
> > > =C2=A0 * iio_backend_extend_chan_spec - Extend an IIO channel
> > > =C2=A0 * @back: Backend device
> > > diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> > > index 10be00f3b120..2b7221099d8c 100644
> > > --- a/include/linux/iio/backend.h
> > > +++ b/include/linux/iio/backend.h
> > > @@ -70,6 +70,15 @@ enum iio_backend_sample_trigger {
> > > =C2=A0	IIO_BACKEND_SAMPLE_TRIGGER_MAX
> > > =C2=A0};
> > > =C2=A0
> > > +enum iio_backend_interface_type {
> > > +	IIO_BACKEND_INTERFACE_SERIAL_LVDS,
> > > +	IIO_BACKEND_INTERFACE_SERIAL_CMOS,   =20
> >=20
> > The above are apparently not used in the next patch so I would not add =
them now. =20
> > > +	IIO_BACKEND_INTERFACE_SERIAL_SPI,
> > > +	IIO_BACKEND_INTERFACE_SERIAL_DSPI,
> > > +	IIO_BACKEND_INTERFACE_SERIAL_QSPI,   =20
> >=20
> > I'll throw my 2 cents but it would be nice to have more feedback on thi=
s. I'm
> > not completely sure about the xSPI stuff in here. We treated the QSPI a=
s a bus
> > both for control and data in which we also add child devices. And we've=
 been
> > adding specific bus operations/configurations through the 'struct
> > ad3552r_hs_platform_data' interface. So, I'm wondering if this should a=
lso not
> > be set through that interface? =20
>=20
> Maybe - kind of hard to tell until we actually have code.
> I'd go for kicking them into the long grass for now if they aren't used a=
nd
> just dropping them from this patch.  If we ever need them,easy to bring b=
ack
> and then we should have a justification for why!

oops. Misread. Obviously Nuno was saying the ones above aren't used, not the
SPI ones...  I don't feel strongly either way on setting these via
this generic interface, or via the other path.

Jonathan

>=20
> J
>=20
>=20
> >=20
> > LVDS/CMOS still looks slightly different to me...
> >=20
> > - Nuno S=C3=A1
> >=20
> >=20
> >  =20
>=20
>=20


