Return-Path: <linux-iio+bounces-8400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A78994DC52
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 12:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89807B21AE9
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 10:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF102157A48;
	Sat, 10 Aug 2024 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR2rs4p7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F16155A32;
	Sat, 10 Aug 2024 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723286126; cv=none; b=ccqMEcNX1z7uHn2hb/RgplbQOofHtGrvUgRx0goienMryDt2SZph9QI+wYOobisWdgizLrlH2X1TKae/jyxa4Z2IREKp7mRaUSLwv384598kBLH5yibcncgHHKTcU2y3RfPJsrzeLjhQhMv79JX9LI4Mmqk+d/p+zzgnD3lT8oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723286126; c=relaxed/simple;
	bh=ZnGSufR7s2y1R0aQ0nDt624omjlslN8ADPJg5cctc50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sn81EktwxIbwCXUxVBS3IOkvbKVetIxxKpi052CyJ6YQohLLGOsGXZHXrxKVlhn/NV84sovo5pLvRry38oHuJy+bSXADzfMzM3caFTKm47wVAXDanqvOcuM7BfwboPkl0VVnDcrDyTa1zmx9U3e6XelbWY0w42gXo6ZxlgTYOMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR2rs4p7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53041C32781;
	Sat, 10 Aug 2024 10:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723286125;
	bh=ZnGSufR7s2y1R0aQ0nDt624omjlslN8ADPJg5cctc50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JR2rs4p7/9Vyb3rJnUhMyiKeHKLx9G2zdgJyJYXGFMFeRhZ87TeO2+zqHP2EnCG+U
	 PA3wGZtNkZ5n2HjS2TsTkq2/Gxsr59W/WmUamkaEEVBUIhEL+gp/zDQqHk1Bj1wdtW
	 eKkHEnoSCbWScBkWLwKDLxql1cPRokrMJyUeAxHlOINMwjjG/FzglJ2YSJAh9fns6E
	 Ymu7uZacU5Jp0D0UxjfITnDdtotrgJ9BNfsOMEQeptQYDhtfHJD9a/0nAqiPVE+aTP
	 hrVU74nej3PjWbHyychcNtLg7/A8nEsS/UPN9tj8LQzPUpojSlWKCGgfQ4ovGnlChV
	 Vmw7SBsMQplCw==
Date: Sat, 10 Aug 2024 11:35:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Matteo Martelli <matteomartelli3@gmail.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, kernel-janitors@vger.kernel.org,
 lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: pac1921: add missing error return in probe()
Message-ID: <20240810113518.2cbceb66@jic23-huawei>
In-Reply-To: <9a98aab5-bb68-4206-9ecf-32fbf6c9c7ef@stanley.mountain>
References: <1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain>
	<36b1a47a-7af2-4baf-8188-72f6eed78529@wanadoo.fr>
	<66b5c5df76766_133d37031@njaxe.notmuch>
	<9a98aab5-bb68-4206-9ecf-32fbf6c9c7ef@stanley.mountain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Aug 2024 18:18:13 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Fri, Aug 09, 2024 at 09:31:43AM +0200, Matteo Martelli wrote:
> > Christophe JAILLET wrote: =20
> > > Le 08/08/2024 =C3=A0 21:28, Dan Carpenter a =C3=A9crit=C2=A0: =20
> > > > This error path was intended to return, and not just print an error=
.  The
> > > > current code will lead to an error pointer dereference.
> > > >=20
> > > > Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter-QSEj5FYQhm4dnm+yROfE0A@=
public.gmane.org>
> > > > ---
> > > >   drivers/iio/adc/pac1921.c | 4 ++--
> > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> > > > index d04c6685d780..8200a47bdf21 100644
> > > > --- a/drivers/iio/adc/pac1921.c
> > > > +++ b/drivers/iio/adc/pac1921.c
> > > > @@ -1168,8 +1168,8 @@ static int pac1921_probe(struct i2c_client *c=
lient)
> > > >  =20
> > > >   	priv->regmap =3D devm_regmap_init_i2c(client, &pac1921_regmap_co=
nfig);
> > > >   	if (IS_ERR(priv->regmap))
> > > > -		dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
> > > > -			      "Cannot initialize register map\n");
> > > > +		return dev_err_probe(dev, (int)PTR_ERR(priv->regmap), =20
> > >=20
> > > The (int) is unusual.
> > > =20
> > The (int) explicit cast is to address Wconversion warnings since dev_er=
r_probe
> > takes an int as argument. =20
>=20
> I don't want to remove the int because it's unrelated, but Christophe is =
right
> that the int is unusual.  We really would want to discourage that.

Applied, but I'd ideally like a follow up patch removing the int and the
couple of similar instances from this driver.  Anyone want to spin one?

Thanks,

Jonathan

>=20
> regards,
> dan carpenter
>=20


