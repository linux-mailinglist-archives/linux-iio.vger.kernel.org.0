Return-Path: <linux-iio+bounces-17644-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBA2A7CA5E
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 18:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92433A57C6
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 16:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A27518DB37;
	Sat,  5 Apr 2025 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmhFKTq3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB65218C932;
	Sat,  5 Apr 2025 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743871969; cv=none; b=GL/CIr/j2lHctw7+mZnclP+MSZ5LRrZYqh0JoN8JL6d0SYyUK5uRaDYZC/xT+1iCc6zkuvXUJqaGF45tqY1jRWJcWJh3UR0skbW5lekVB31BjNtX/0hZcEnvMgdNa9pORPiJoy5eShdfDHUR7Zxfi2+CLmYh+xWbNB4G7mTOObw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743871969; c=relaxed/simple;
	bh=r3O4BpTT/ZiR3XrJhquwxnOiMY1jmDNuWmM5GyHaCuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bA2CLLWpI1ynAhSmjcQYTgrngz69saQtb4cR+fJZHLJ7lo09Rx8YaCeVVmVp9SXXItqPZ1zd5AQc9PjQTsE+96P/udvR8KElJ50BFZ6L3xxwuxIj9qUt59t0dSn4+kekbKRuwy2q26/3B/tMSzoWmjSffhQ8Twxts2s9VOPJD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmhFKTq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACB1C4CEE4;
	Sat,  5 Apr 2025 16:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743871968;
	bh=r3O4BpTT/ZiR3XrJhquwxnOiMY1jmDNuWmM5GyHaCuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nmhFKTq39Bze5TMVmQh+w1HU9uFs/GvlceV816CevJJzQAIHa0S8kp6ATOu9fYP1y
	 YlEHl09qStM8wbXFFSbynU8vDKsQMskBjVENCRdpmOHMA16CKZD3DgBGe9g+DBhZNW
	 e3vSGGDUAZsHv47xaV+f2LOUrbzIiPSoSpTdVfMzA5ZL9WIXfDHDiva/W3vrx8pCox
	 zdL+9y0yvBWnl+wRpqVySw3nSOmK/+kTuXG80OWbKogY0SE+y39Q6L1Y21woRT66Z4
	 tnK/qv2CyxKJe+0+3GFDQVTxYC/ozJk4WIq3Dk0nvcuViGbPR5MDd66lGDmL+DX73j
	 05jSLxZkhmO3Q==
Date: Sat, 5 Apr 2025 17:52:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: devnull+david.ixit.cz@kernel.org, clamor95@gmail.com, david@ixit.cz,
 lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 longnoserob@gmail.com
Subject: Re: [PATCH v4 1/5] iio: light: al3010: Improve al3010_init error
 handling with dev_err_probe()
Message-ID: <20250405175235.0b9d2508@jic23-huawei>
In-Reply-To: <eda0d691-93ac-4833-8978-6d39730c4db2@wanadoo.fr>
References: <20250402-al3010-iio-regmap-v4-0-d189bea87261@ixit.cz>
	<20250402-al3010-iio-regmap-v4-1-d189bea87261@ixit.cz>
	<eda0d691-93ac-4833-8978-6d39730c4db2@wanadoo.fr>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Apr 2025 20:01:46 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Le 02/04/2025 =C3=A0 21:33, David Heidelberg via B4 Relay a =C3=A9crit=C2=
=A0:
> > From: David Heidelberg <david-W22tF5X+A20@public.gmane.org>
> >=20
> > Minor code simplifications and improved error reporting.
> >=20
> > Signed-off-by: David Heidelberg <david-W22tF5X+A20@public.gmane.org>
> > ---
> >   drivers/iio/light/al3010.c | 10 ++++------
> >   1 file changed, 4 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
> > index 8c004a9239aef246a8c6f6c3f4acd6b760ee8249..34a29a51c5f9e8aa143d3ba=
195b79a19793e4f88 100644
> > --- a/drivers/iio/light/al3010.c
> > +++ b/drivers/iio/light/al3010.c
> > @@ -92,8 +92,8 @@ static int al3010_init(struct al3010_data *data)
> >   	ret =3D devm_add_action_or_reset(&data->client->dev,
> >   				       al3010_set_pwr_off,
> >   				       data);
> > -	if (ret < 0)
> > -		return ret;
> > +	if (ret)
> > +		return dev_err_probe(&data->client->dev, ret, "failed to add action\=
n"); =20
>=20
> Not sure this new message is needed.
>=20
> The error is unlikely, and kmalloc(), which is used in is=20
> devm_add_action_or_reset(), is already verbose.
Good point. I agree this should stay as a simple return. =20

If nothing else comes up I'll tidy that up whilst applying,

Jonathan

>=20
> CJ
>=20
> >  =20
> >   	ret =3D i2c_smbus_write_byte_data(data->client, AL3010_REG_CONFIG,
> >   					FIELD_PREP(AL3010_GAIN_MASK,
> > @@ -190,10 +190,8 @@ static int al3010_probe(struct i2c_client *client)
> >   	indio_dev->modes =3D INDIO_DIRECT_MODE;
> >  =20
> >   	ret =3D al3010_init(data);
> > -	if (ret < 0) {
> > -		dev_err(dev, "al3010 chip init failed\n");
> > -		return ret;
> > -	}
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to init ALS\n");
> >  =20
> >   	return devm_iio_device_register(dev, indio_dev);
> >   }
> >  =20
>=20


