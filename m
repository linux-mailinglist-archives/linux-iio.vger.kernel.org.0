Return-Path: <linux-iio+bounces-15646-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22244A3838C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 13:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A82172D63
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 12:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A652721ADCE;
	Mon, 17 Feb 2025 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="La7ElSxU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660B62F5B
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797071; cv=none; b=BdMaVKv0kcm+KBryhJng2D86/rNdERhcgbYAkXgnwY4ZmTSrbTR4qV/TWs1bGjfwrrNgu+6zvfiJYPqybq5t9O7XkyPHNKULweAchwUuzPClg92dvzpndzJ7nEwnBWj+lFfdH3w22mEDH7A0hgcQ2OgWMaPijGt6ngsYHACyHUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797071; c=relaxed/simple;
	bh=1jSKaJ4FgoQrsyBryW3LAvxYogbTYwI6kLTs3GSkpnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dba2OeRjNZsWpL8vTbHfwOkmBOkRgakg25hevJ5h4h3+DkLnT0Om6mmj3DPv52B3YgfwxEbAG48xi31MWM3b5m5tf35gfH5SCNhO5Pw3Wmqg+DHYuBRmTH78xtRbNex5Sa7FDfJ+CxXrafTzOn3NasOwBYbxboZgJuGjw2G9ljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=La7ElSxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A851C4CED1;
	Mon, 17 Feb 2025 12:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739797070;
	bh=1jSKaJ4FgoQrsyBryW3LAvxYogbTYwI6kLTs3GSkpnM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=La7ElSxURc/qUYu5+67mCvDaXnXQk4/GxpLDTc9hdtvM6dlZ4xxTcoDgui2OwCE0y
	 br6FoK/SkuIUjtuajN7dTPMAGx3CcKge4vvGW/Ymi1XXarN28ReS6v6GTBgNLNm2e8
	 Lvrd2iNAEU7s0d5JxhjrlKrR0eUlQllC0D+rs8gcMYeemyhAxzuX89HrZaqFuqCYNr
	 n2GVNCLhBj14ObRihBFgCNsKGRcwK+J0/Ss01MmKncB3EKorYkj85JoJjhS+7k5Eiq
	 Ky4av+oTKm9SuEA8U9DYKGt9PV2fjReaeqzE2cnP15wRq14wY6tj3HNqXRelp5/Fox
	 izFJLWk2y+fEQ==
Date: Mon, 17 Feb 2025 12:57:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: linux-iio@vger.kernel.org, Mudit Sharma <muditsharma.info@gmail.com>,
 Julien Stephan	 <jstephan@baylibre.com>, Mariel Tinaco
 <Mariel.Tinaco@analog.com>, Angelo Dureghello <adureghello@baylibre.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Nuno Sa	 <nuno.sa@analog.com>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=	
 <joao.goncalves@toradex.com>, ChiYuan Huang <cy_huang@richtek.com>, Ramona
 Alexandra Nechita <ramona.nechita@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Guillaume Stols	 <gstols@baylibre.com>, David
 Lechner <dlechner@baylibre.com>, Cosmin Tanislav	 <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Gwendal Grignou
 <gwendal@chromium.org>, Antoni Pokusinski <apokusinski01@gmail.com>, Tomasz
 Duszynski	 <tomasz.duszynski@octakon.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 01/27] iio: core: Rework claim and release of direct
 mode to work with sparse.
Message-ID: <20250217125740.65139187@jic23-huawei>
In-Reply-To: <c11d55efa6bb145aba7cd7141031b7aa45027a76.camel@gmail.com>
References: <20250209180624.701140-1-jic23@kernel.org>
	<20250209180624.701140-2-jic23@kernel.org>
	<c11d55efa6bb145aba7cd7141031b7aa45027a76.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Feb 2025 10:38:11 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sun, 2025-02-09 at 18:05 +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Initial thought was to do something similar to __cond_lock()
> >=20
> > 	do_iio_device_claim_direct_mode(iio_dev) ? : ({ __acquire(iio_dev);
> > 0; })
> > + Appropriate static inline iio_device_release_direct_mode()
> >=20
> > However with that, sparse generates false positives. E.g.
> >=20
> > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:1811:17: warning: context
> > imbalance in 'st_lsm6dsx_read_raw' - unexpected unlock
> >=20
> > So instead, this patch rethinks the return type and makes it more
> > 'conditional lock like' (which is part of what is going on under the ho=
od
> > anyway) and return a boolean - true for successfully acquired, false for
> > did not acquire.
> >=20
> > To allow a migration path given the rework is now non trivial, take a l=
eaf
> > out of the naming of the conditional guard we currently have for IIO
> > device direct mode and drop the _mode postfix from the new functions gi=
ving
> > iio_device_claim_direct() and iio_device_release_direct()
> >=20
> > Whilst the kernel supports __cond_acquires() upstream sparse does not
> > yet do so.=C2=A0 Hence rely on sparse expanding a static inline wrapper
> > to explicitly see whether __acquire() is called.
> >=20
> > Note that even with the solution here, sparse sometimes gives false
> > positives. However in the few cases seen they were complex code
> > structures that benefited from simplification anyway.
> >=20
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > v2: include linux/compiler_types.h (David) =20
>=20
> UhU, I'm not seeing it?
>=20
Fixed up.  Thanks!
> > --- =20
>=20
> With the above,
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
> > =C2=A0include/linux/iio/iio.h | 25 +++++++++++++++++++++++++
> > =C2=A01 file changed, 25 insertions(+)
> >=20
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 56161e02f002..fe33835b19cf 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -662,6 +662,31 @@ int iio_push_event(struct iio_dev *indio_dev, u64
> > ev_code, s64 timestamp);
> > =C2=A0int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
> > =C2=A0void iio_device_release_direct_mode(struct iio_dev *indio_dev);
> > =C2=A0
> > +/*
> > + * Helper functions that allow claim and release of direct mode
> > + * in a fashion that doesn't generate many false positives from sparse.
> > + * Note this must remain static inline in the header so that sparse
> > + * can see the __acquire() marking. Revisit when sparse supports
> > + * __cond_acquires()
> > + */
> > +static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
> > +{
> > +	int ret =3D iio_device_claim_direct_mode(indio_dev);
> > +
> > +	if (ret)
> > +		return false;
> > +
> > +	__acquire(iio_dev);
> > +
> > +	return true;
> > +}
> > +
> > +static inline void iio_device_release_direct(struct iio_dev *indio_dev)
> > +{
> > +	iio_device_release_direct_mode(indio_dev);
> > +	__release(indio_dev);
> > +}
> > +
> > =C2=A0/*
> > =C2=A0 * This autocleanup logic is normally used via
> > =C2=A0 * iio_device_claim_direct_scoped(). =20
>=20


