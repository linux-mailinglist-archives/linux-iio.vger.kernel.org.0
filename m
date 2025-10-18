Return-Path: <linux-iio+bounces-25233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E889BED3EA
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 18:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1D619A1DBB
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 16:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6D12472A8;
	Sat, 18 Oct 2025 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sy3Aa0Ix"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144A19DF4D
	for <linux-iio@vger.kernel.org>; Sat, 18 Oct 2025 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760805302; cv=none; b=Iri8BsAdb7ZIaFzbTj6NIbKPENb9H/mumtbjMRJgCn2g1p44LcKB8a7idirucW5AOnnU3hR00rfvQEyfClyfl85JDn7/uAHytmo6EuegFmeSOgA8+jVJSqy3uTagcnT8Itl2SiCSbpy/1Dw4lFrWF/8O7d8ylAYGG8MM8zHatLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760805302; c=relaxed/simple;
	bh=bOEHTiEUPVHQq6IbgHO4+7pc864tu/+CTJkIWpyGpSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNDgs1sENNhF+1LxIEtbZYa0iY5vY+Uwgb4R+LBmu5B7lrcP1+V+XEphc6XAjWaMptAqcJqoRZuzkP/7JsKip9dY0zdfI3bZse0dDpwC1atnNiok2YuMi7H6wdzXDaczUbysmOO48i7jnrhKZZGISff7xPz7/0tvnLZubyp4s1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sy3Aa0Ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C265C4CEF8;
	Sat, 18 Oct 2025 16:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760805300;
	bh=bOEHTiEUPVHQq6IbgHO4+7pc864tu/+CTJkIWpyGpSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sy3Aa0Ix6II+c9/8AxuGJ9pzFVd58+wOvC5XBB6Ca5bssMwFvNvHwHhidSM3m5ecJ
	 mNgeXpVejfRBGscjOtEVFmwaFjyVWAVgzollxnt4sNAnaJEoBm6+syMJmggxqiun04
	 yohrlLKXVzB1MOjCkco7MD7b0auStKSkyxEz+CfbqJa9ZNaNG82LGaubUdVHPD3xYl
	 ieD/yj+i3vYj0mvqxRQcPsg3iGGt9Qh2mpwBQFMVrvsAQd1ZrfBaPdyF3llKCNCM4B
	 dRlI1I9xgyWIz7nxhI29JI7YO4r15yPJZxrE5HwSsJoKpHuZrEjuEREYex1kdrTWjA
	 eEdzAB5yGj9Gg==
Date: Sat, 18 Oct 2025 17:34:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: dac: ad5446: Add AD5542 to the spi id table
Message-ID: <20251018173454.3e89e6a9@jic23-huawei>
In-Reply-To: <ed298de2b13040534bb25bd186111f4761d574df.camel@gmail.com>
References: <20251014-dev-add-ad5542-v1-1-cfd197db03a0@analog.com>
	<03b3c597-0576-4468-a23e-cf6a4b7daf86@baylibre.com>
	<ed298de2b13040534bb25bd186111f4761d574df.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Oct 2025 09:08:36 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2025-10-14 at 12:15 -0500, David Lechner wrote:
> > On 10/14/25 11:11 AM, Nuno S=C3=A1 via B4 Relay wrote: =20
> > > From: Michael Hennerich <michael.hennerich@analog.com>
> > >=20
> > > This adds support for the AD5542 single channel Current Source and
> > > Voltage Output DACs.
> > >=20
> > > It is similar to the AD5542A model so just use the same id.
> > >=20
> > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > ---
> > > =C2=A0drivers/iio/dac/ad5446.c | 1 +
> > > =C2=A01 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> > > index ad304b0fec08..6e4103f4afcb 100644
> > > --- a/drivers/iio/dac/ad5446.c
> > > +++ b/drivers/iio/dac/ad5446.c
> > > @@ -422,6 +422,7 @@ static const struct spi_device_id ad5446_spi_ids[=
] =3D {
> > > =C2=A0	{"ad5512a", ID_AD5512A},
> > > =C2=A0	{"ad5541a", ID_AD5541A},
> > > =C2=A0	{"ad5542a", ID_AD5541A}, /* ad5541a and ad5542a are compatible=
 */
> > > +	{"ad5542", ID_AD5541A}, /* ad5541a and ad5542a are compatible */ =20
> >=20
> > Should the comment say ad5542 instead of ad5542a? =20
>=20
> Yes.
>=20
> >  =20
> > > =C2=A0	{"ad5543", ID_AD5541A}, /* ad5541a and ad5543 are compatible */
> > > =C2=A0	{"ad5553", ID_AD5553},
> > > =C2=A0	{"ad5600", ID_AD5600},
> > >=20
> > > ---
> > > base-commit: 4b17a60d1e1c2d9d2ccbd58642f6f4ac2fa364ba
> > > change-id: 20251014-dev-add-ad5542-8c8934de80ee
> > > --
> > >=20
> > > Thanks!
> > > - Nuno S=C3=A1
> > >=20
> > >  =20
> >=20
> > Interesting... no devicetree bindings for these chips? =20
>=20
> This driver is old enough where things were less strict (I guess) and it =
seems
> no one added bindings for this.
Dates back to board file days I think. Relying on the stuff that was added
to bridge that gap by matching stripped part number from compatible against=
 the
i2c_device_id.

If you fancy tidying that up and adding both of_device_id table and a bindi=
ng
doc that would be great.

Thanks,

J
>=20
> - Nuno S=C3=A1


