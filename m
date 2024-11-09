Return-Path: <linux-iio+bounces-12076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B119C2D9D
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 14:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2DF1C212E2
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 13:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB693186E2F;
	Sat,  9 Nov 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4f8JEUA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F1E1E4BE;
	Sat,  9 Nov 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731159954; cv=none; b=iCxoL5Upqnbo9EsH1rM1UQrSM8gIVVDRI5+J7X3BqaUUHjJ6C6caMMYeiRFiYjjBqFTeZTc3h/LBVfQh+cH7mzi8XbFJn20B5+ucMk6bx3Up1KZet2qPq9JaGORqd3uBhhuUN+b0WVE8o1iiQGWoHOnHpxUyi9kHoDMKKNa0iB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731159954; c=relaxed/simple;
	bh=51VVdfREui1qZUQyEwq/t/lqxD5LBRLs9fVrDJvafrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6gAQ3ERMnLaetU8JUBsiDCsSDk0iAFo5o0sTz0MmDnj3bik3Bzbko0sfmsJSZhh/Ra2SQnMLKRHQSAwkj/JBu94qejyTdDlnfBsp/CdEmjeKmtpjbDQLXBmitb8Z4Eyoo3Tz5GOfwE/mp7yXB736LW0EXlYyt4ZGpm1+59OiUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4f8JEUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E92C4CECF;
	Sat,  9 Nov 2024 13:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731159954;
	bh=51VVdfREui1qZUQyEwq/t/lqxD5LBRLs9fVrDJvafrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A4f8JEUAeWuSU71MmsGZYkT/3933uq2uKn1TRDxyhUW6KhJiwPQES6RY5KYb8VHUn
	 HI0nYoJPIIh0GZZLiKJ6J5fnBP1MjhEzXW5qBVOIvg+OYQcaDph7KY9qDFa70zt2jC
	 tizdMjMh8W1XtiSPIlVNSKqzf1toqI314YAi0d6PxWqMU3HtCs2b+tZj+8rNnPXihb
	 AOkTx5h76aJr1DIgdZpNYTdse4R1rkS5/eCbtT72KPA6I9mO1qL11xdMMLszG8RYAa
	 y+8+P2Aa5b9p6vBPqn/68Cx0eSF+upb88IwoaMhUu/qBA8bRrBN/cYYiao5Ob0hWdd
	 aMm+LpslldYzA==
Date: Sat, 9 Nov 2024 13:45:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yu-Hsian Yang <j2anfernee@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, avifishman70@gmail.com,
 tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
 yuenn@google.com, benjaminfair@google.com, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com,
 andy@kernel.org, marcelo.schmitt@analog.com, olivier.moysan@foss.st.com,
 mitrutzceclan@gmail.com, matteomartelli3@gmail.com, alisadariana@gmail.com,
 joao.goncalves@toradex.com, marius.cristea@microchip.com,
 mike.looijmans@topic.nl, chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
 yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: add Nuvoton NCT720x ADC driver
Message-ID: <20241109134538.6f09971d@jic23-huawei>
In-Reply-To: <CA+4VgcJSt-LUNtH6TMpk7om+PbO1aQvmt1WHi-cYMxa8p+Um5A@mail.gmail.com>
References: <20241106023916.440767-1-j2anfernee@gmail.com>
	<20241106023916.440767-3-j2anfernee@gmail.com>
	<fd4db31d-4e55-4f0e-a96d-d193c28fd784@kernel.org>
	<CA+4VgcJSt-LUNtH6TMpk7om+PbO1aQvmt1WHi-cYMxa8p+Um5A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Nov 2024 08:41:21 +0800
Yu-Hsian Yang <j2anfernee@gmail.com> wrote:

> Dear Krzysztof Kozlowski,
>=20
> Thank you for your response.
>=20
> Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2024=E5=B9=B411=E6=9C=886=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:41=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On 06/11/2024 03:39, Eason Yang wrote: =20
> > > Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> > >
> > > NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and u=
p to
> > > 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins =
for
> > > independent alarm signals, and the all threshold values could be set =
for
> > > system protection without any timing delay. It also supports reset in=
put
> > > RSTIN# to recover system from a fault condition.
> > >
> > > Currently, only single-edge mode conversion and threshold events supp=
ort.
> > >
> > > Signed-off-by: Eason Yang <j2anfernee@gmail.com> =20
> >
> > ...
> > =20
> > > +
> > > +static int nct720x_probe(struct i2c_client *client)
> > > +{
> > > +     const struct i2c_device_id *id =3D i2c_client_get_device_id(cli=
ent);
> > > +     struct nct720x_chip_info *chip;
> > > +     struct iio_dev *indio_dev;
> > > +     int ret;
> > > +     u32 tmp;
> > > +
> > > +     indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*chip)=
);
> > > +     if (!indio_dev)
> > > +             return -ENOMEM;
> > > +     chip =3D iio_priv(indio_dev);
> > > +
> > > +     if (client->dev.of_node)
> > > +             chip->type =3D (enum nct720x_chips)device_get_match_dat=
a(&client->dev);
> > > +     else
> > > +             chip->type =3D i2c_match_id(nct720x_id, client)->driver=
_data; =20
> >
> > I believe there is a I2C wrapper for above.
> > =20
>=20
> Got it.

Don't pass an enum value as data.  Pass a pointer to a structure that descr=
ibes the particular
variant.  The 0 value which tends to end up in enums is an error for device=
_get_match_data.

>=20
> > > +
> > > +     chip->vin_max =3D (chip->type =3D=3D nct7201) ? NCT7201_VIN_MAX=
 : NCT7202_VIN_MAX;
> > > +
> > > +     ret =3D of_property_read_u32(client->dev.of_node, "read-vin-dat=
a-size", &tmp);
> > > +     if (ret < 0) {
> > > +             pr_err("read-vin-data-size property not found\n"); =20
> >
> > Please use dev_xxx in your driver code. =20
>=20
> Got it.
>=20
> >
> >
> > Best regards,
> > Krzysztof
> > =20


