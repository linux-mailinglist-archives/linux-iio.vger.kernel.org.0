Return-Path: <linux-iio+bounces-13661-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB169F8027
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E77EE7A276E
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A220226888;
	Thu, 19 Dec 2024 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD2fKY8V"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB078223E64;
	Thu, 19 Dec 2024 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626564; cv=none; b=EHCUKTT8YzSZT2yO46nV79kK364Nw/u5puicRFgwQ9kNtxxu/D9+/kcQKsx4oKYp2rjw7WDYzrmF7GWn5bl/77HmZQLHPyKiGtkgqg9J5bMwsVchq1YpQqypI5br4bXrVwGPjcYV5xQ8ZCX+AUjvyAQ/fQCt9iigdCfzI96arCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626564; c=relaxed/simple;
	bh=9Ata84f04Ynm8pDvG0Qx7WBtI+QSe4nMBhdFQDGQiik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+Xs/4Yk8hMRdWE7mbT/eWq7QX7MPBAUkS0l6LcyZxAEY/8pFGscxqBg3fR1vQZfnrx0Ua+DBpOHl/NUuGTGL8AkfkcZA8Aj8WZYJfKKuI4IXYijQAFWHj6WzHYjQZ56TzOOrforkj614NZXjhsjzBmZ7blPY7v32gnwcPmdtX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD2fKY8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1621C4CED4;
	Thu, 19 Dec 2024 16:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734626563;
	bh=9Ata84f04Ynm8pDvG0Qx7WBtI+QSe4nMBhdFQDGQiik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UD2fKY8VXXgXhXM+AjAdg0Jga2SQX88p8C/ZRAVAkvwxE+IwkF/X+Bc1e9jEhatWE
	 mGk7XvOK8Xa8jmdXvdBeKHDruNxhNKwE/QNLJK4VRxXkKq3Of+kNCSAPn/jfCboKiR
	 ZK6yT04aZH3vCkkX+wWYrbGEpTmN0K3jYrAt4sM7Os/2lCDnEYakVHUCi4mgUs6SEh
	 7xi9ZHRiIyeqzMJtZHorgPfnBpU97nQEIKkOMcH0376sk5GdFcoSt7WT3q0D24AH8n
	 XCcjRSWbbQFrQCrdRHzQILsl5CUmoP/7NGmd04Ml2aPp9SxfJh0Uz8fhKahq0/tqV1
	 N+4DDbzW6QGOA==
Date: Thu, 19 Dec 2024 16:42:33 +0000
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
Message-ID: <20241219164233.087ff9cb@jic23-huawei>
In-Reply-To: <b5a773858a71e6929667fc73b9384908ca3ff313.camel@gmail.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
	<20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-4-856ff71fc930@baylibre.com>
	<b5a773858a71e6929667fc73b9384908ca3ff313.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Dec 2024 11:13:59 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2024-12-16 at 21:36 +0100, Angelo Dureghello wrote:
> > From: Antoniu Miclaus <antoniu.miclaus@analog.com>
> >=20
> > Add backend support for setting and getting the interface type
> > in use.
> >=20
> > Link:
> > https://lore.kernel.org/linux-iio/20241129153546.63584-1-antoniu.miclau=
s@analog.com/T/#m6d86939078d780512824f1540145aade38b0990b
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> > This patch has been picked up from the Antoniu patchset
> > still not accepted, and extended with the interface setter,
> > fixing also namespace names to be between quotation marks.
> > ---
> > =C2=A0drivers/iio/industrialio-backend.c | 42
> > ++++++++++++++++++++++++++++++++++++++
> > =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 19 +++++++++++++++++
> > =C2=A02 files changed, 61 insertions(+)
> >=20
> > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industria=
lio-
> > backend.c
> > index 363281272035..6edc3e685f6a 100644
> > --- a/drivers/iio/industrialio-backend.c
> > +++ b/drivers/iio/industrialio-backend.c
> > @@ -636,6 +636,48 @@ ssize_t iio_backend_ext_info_set(struct iio_dev
> > *indio_dev, uintptr_t private,
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, "IIO_BACKEND");
> > =C2=A0
> > +/**
> > + * iio_backend_interface_type_get - get the interface type used.
> > + * @back: Backend device
> > + * @type: Interface type
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int iio_backend_interface_type_get(struct iio_backend *back,
> > +				=C2=A0=C2=A0 enum iio_backend_interface_type *type)
> > +{
> > +	int ret;
> > +
> > +	ret =3D iio_backend_op_call(back, interface_type_get, type);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (*type >=3D IIO_BACKEND_INTERFACE_MAX)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, "IIO_BACKEND");
> > +
> > +/**
> > + * iio_backend_interface_type_set - set the interface type used.
> > + * @back: Backend device
> > + * @type: Interface type
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int iio_backend_interface_type_set(struct iio_backend *back,
> > +				=C2=A0=C2=A0 enum iio_backend_interface_type type)
> > +{
> > +	if (type >=3D IIO_BACKEND_INTERFACE_MAX)
> > +		return -EINVAL;
> > +
> > +	return=C2=A0 iio_backend_op_call(back, interface_type_set, type);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_set, "IIO_BACKEND");
> > +
> > =C2=A0/**
> > =C2=A0 * iio_backend_extend_chan_spec - Extend an IIO channel
> > =C2=A0 * @back: Backend device
> > diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> > index 10be00f3b120..2b7221099d8c 100644
> > --- a/include/linux/iio/backend.h
> > +++ b/include/linux/iio/backend.h
> > @@ -70,6 +70,15 @@ enum iio_backend_sample_trigger {
> > =C2=A0	IIO_BACKEND_SAMPLE_TRIGGER_MAX
> > =C2=A0};
> > =C2=A0
> > +enum iio_backend_interface_type {
> > +	IIO_BACKEND_INTERFACE_SERIAL_LVDS,
> > +	IIO_BACKEND_INTERFACE_SERIAL_CMOS, =20
>=20
> The above are apparently not used in the next patch so I would not add th=
em now.
> > +	IIO_BACKEND_INTERFACE_SERIAL_SPI,
> > +	IIO_BACKEND_INTERFACE_SERIAL_DSPI,
> > +	IIO_BACKEND_INTERFACE_SERIAL_QSPI, =20
>=20
> I'll throw my 2 cents but it would be nice to have more feedback on this.=
 I'm
> not completely sure about the xSPI stuff in here. We treated the QSPI as =
a bus
> both for control and data in which we also add child devices. And we've b=
een
> adding specific bus operations/configurations through the 'struct
> ad3552r_hs_platform_data' interface. So, I'm wondering if this should als=
o not
> be set through that interface?

Maybe - kind of hard to tell until we actually have code.
I'd go for kicking them into the long grass for now if they aren't used and
just dropping them from this patch.  If we ever need them,easy to bring back
and then we should have a justification for why!

J


>=20
> LVDS/CMOS still looks slightly different to me...
>=20
> - Nuno S=C3=A1
>=20
>=20
>=20


