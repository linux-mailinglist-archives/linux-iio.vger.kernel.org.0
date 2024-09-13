Return-Path: <linux-iio+bounces-9523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FC997890D
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 21:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EBA1C2270C
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 19:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2BE1494A3;
	Fri, 13 Sep 2024 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkPfKM2l"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DBA148317;
	Fri, 13 Sep 2024 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726256396; cv=none; b=SoFkJrRKymsZRpDcg3+0W6Xa1o5gWXPdc/Zi96NWcyXFr3SBIPTzFSmI0i4lV404/zklr+p8wxIKgys959NhNLmQsZ8wM8btOIgaGAAwwio6/+uIuJml6ehfK7xnp8c8jw/Ppn5fBUH4pbuUWtqJR3sYtZhOJXdDPZxczQT+2yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726256396; c=relaxed/simple;
	bh=RUEVWgvk6mTpIhbMZyR3ybMcrifXc1NcuV8nvnQ7Z2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCxdK4OLFKC0LK+XisbOKCIj6R5G9DJFAg0R+zDGUOP+dt3qc0nTXaJt3E2A09EwYND+DvaNI8QcI2g5tlD5eJyEAkyL614jGZpkUyPIW8KNBH1+V1IbU0F+JLu3g4/A+Z5a/htxr8ZFmgQtQt0IfrGRc18Y2IiU1CqbHCsHWTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkPfKM2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AF3C4CECC;
	Fri, 13 Sep 2024 19:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726256396;
	bh=RUEVWgvk6mTpIhbMZyR3ybMcrifXc1NcuV8nvnQ7Z2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XkPfKM2lxkNEq4p+g6nAtThYVWFspucb3zEcTqZK0ROXAA8mOSrVtvQLoozYScctH
	 SBTLXvGAh0lKJ5YHPyPyocQi+ovGSmFHemw3x8I+O1ThIiSM2bR/efSkt1QUQvC+UL
	 VHuiUdLcTt18LUH5/ZwYQWiDUAKqLPcGg4CwCY/zjHNDntiY4QSyHffri6UqkZeMkd
	 YilGwuzVXjyDh83cj/j8sUQeB2pIkEyXnf46W6SnRw3YPEpAyMfZvIpNcJFieqMrXj
	 iVlG5hZ6DKPDJhPAsLT4mxbDFpY5VLEjv2z/TI+I1hggUciRsR6Nr/uGfSo24Aq7Ru
	 lNH23BRAfpEGQ==
Date: Fri, 13 Sep 2024 20:39:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Dan Carpenter
 <dan.carpenter@linaro.org>, kernel-janitors@vger.kernel.org,
 lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: pac1921: add missing error return in probe()
Message-ID: <20240913203950.06ed1603@jic23-huawei>
In-Reply-To: <172604712407.3581.15543200034844778072@njaxe.localdomain>
References: <1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain>
	<36b1a47a-7af2-4baf-8188-72f6eed78529@wanadoo.fr>
	<66b5c5df76766_133d37031@njaxe.notmuch>
	<9a98aab5-bb68-4206-9ecf-32fbf6c9c7ef@stanley.mountain>
	<20240810113518.2cbceb66@jic23-huawei>
	<172604712407.3581.15543200034844778072@njaxe.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Sep 2024 11:32:04 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Quoting Jonathan Cameron (2024-08-10 12:35:18)
> > On Fri, 9 Aug 2024 18:18:13 +0300
> > Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >  =20
> > > On Fri, Aug 09, 2024 at 09:31:43AM +0200, Matteo Martelli wrote: =20
> > > > Christophe JAILLET wrote:   =20
> > > > > Le 08/08/2024 =C3=A0 21:28, Dan Carpenter a =C3=A9crit=C2=A0:   =
=20
> > > > > > This error path was intended to return, and not just print an e=
rror.  The
> > > > > > current code will lead to an error pointer dereference.
> > > > > >=20
> > > > > > Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
> > > > > > Signed-off-by: Dan Carpenter <dan.carpenter-QSEj5FYQhm4dnm+yROf=
E0A@public.gmane.org>
> > > > > > ---
> > > > > >   drivers/iio/adc/pac1921.c | 4 ++--
> > > > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac192=
1.c
> > > > > > index d04c6685d780..8200a47bdf21 100644
> > > > > > --- a/drivers/iio/adc/pac1921.c
> > > > > > +++ b/drivers/iio/adc/pac1921.c
> > > > > > @@ -1168,8 +1168,8 @@ static int pac1921_probe(struct i2c_clien=
t *client)
> > > > > >  =20
> > > > > >         priv->regmap =3D devm_regmap_init_i2c(client, &pac1921_=
regmap_config);
> > > > > >         if (IS_ERR(priv->regmap))
> > > > > > -               dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
> > > > > > -                             "Cannot initialize register map\n=
");
> > > > > > +               return dev_err_probe(dev, (int)PTR_ERR(priv->re=
gmap),   =20
> > > > >=20
> > > > > The (int) is unusual.
> > > > >   =20
> > > > The (int) explicit cast is to address Wconversion warnings since de=
v_err_probe
> > > > takes an int as argument.   =20
> > >=20
> > > I don't want to remove the int because it's unrelated, but Christophe=
 is right
> > > that the int is unusual.  We really would want to discourage that. =20
> >=20
> > Applied, but I'd ideally like a follow up patch removing the int and the
> > couple of similar instances from this driver.  Anyone want to spin one?
> >  =20
>=20
> I can spin the patch, but at this point I am wondering whether I should r=
emove all
> the unnecessary explicit casts that I put to address Wconversion
> and Wsign-compare warnings. If that's the general approach to help readab=
ility I
> am totally fine with it.

I think it is probably sensible to do so as mostly we know the value ranges
etc so they don't matter.

Jonathan

>=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
>=20
> Thanks,
> Matteo Martelli


