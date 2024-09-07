Return-Path: <linux-iio+bounces-9275-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49A9970281
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 15:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 467EAB229B5
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 13:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8A315C14C;
	Sat,  7 Sep 2024 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvLB+n9l"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05759A93D;
	Sat,  7 Sep 2024 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725716921; cv=none; b=DCI7BVVz0r503EsiBauVk5idCDuxfkGol9IXDWn1elUXkFJmmWoBy2o7rjUz7hSt/pjXFbFCiIn4X3Cm4Fskey9DUnUyTlMYqgVnpHOZ8LZXONll14sLU5i2+0aO+iZxdwIBGcz/a0D3PvbeRl3TMyPUHd1o1FSnkxTnlZUp/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725716921; c=relaxed/simple;
	bh=Zyt3PNJkP/33z85Ga9MfiGJgmwNlxe+9MRfDXPZFKcY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUvfSzQs4Yie7lxJmBPNUQ1Lge9OBeFIh2fONWEuox9S1vou07F6OZzzY9mCM3kfCImr+XDx4cSuOgA6Wa7e+ScAq2tOSd9wvnXDAxSiuq5EDN/9eTOaMsGh7GmWQ5qCHKCM91t1f1G0TVN0hehIQEd6Guxu3qnSTquGJG4AZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvLB+n9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B220CC4CEC2;
	Sat,  7 Sep 2024 13:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725716920;
	bh=Zyt3PNJkP/33z85Ga9MfiGJgmwNlxe+9MRfDXPZFKcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nvLB+n9lhDvtCAQ+VQ+dK2fBoEvJ7PAYwDSsgkrTC16kGl3vXf3q+1wmw71HewmUx
	 c+c9PSs4wxxDEd5r4788C7XoFO7PgN+gAm4GYgwZIVv2Ugl33Z9MqfPMRTpKzGyma6
	 ibmm/Kqt3c57LvREloFYXWvwoXME2nD+mFZ/VJJP7/7FcYw92q8cZP9gqGa/dwiMas
	 dnN0kNyH/q+Ad60sQlblXc3NdVjlN1xGwHuwRQznD1fSYj0aH6sIw2vGQ/+lb8r6jN
	 MQ6NcLXAWtIckqYLQPJ8emXtERO1+ScM1o3luFlcx9dBAO1SFThRFvOKqpC9IV2pFE
	 QIDKEl5N8sCJA==
Date: Sat, 7 Sep 2024 14:48:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: jason liu <jasonliu10041728@gmail.com>, "lars@metafoo.de"
 <lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
Message-ID: <20240907144834.0380fed2@jic23-huawei>
In-Reply-To: <FR3P281MB1757BEA60FF72A44847F1646CE9D2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <FR3P281MB175720831E0817C23AD0B1BACE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<20240902113101.3135-1-jasonliu10041728@gmail.com>
	<CAJci1vC9pvdqEpA8sk+uB5jJGn_DKUruXFfY6tbG9mO07YxgHQ@mail.gmail.com>
	<FR3P281MB1757BEA60FF72A44847F1646CE9D2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Sep 2024 09:25:33 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello,
>=20
> looks good for me now, thanks for the patch.
>=20
> Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>=20
Hi Jason,

I've picked this up, but the patch submission has a number of issues
you should be sure to fix in future patches.

1) Patch version is not in the patch title.  I initially picked up a differ=
ent
   version that was in a later thread in my email.
2) Patch title has wrong style - look at other patches for this driver and
   similar.  Should start with iio: imu: inv...
3) Never send a new patch in reply to a previous one.  Whilst that is accep=
ted
   practice in some opensource communities it scales very badly and mostly
   reduces the chance anyone will read your patches as they will be off the
   top of the screen of their most recent emails.
   I have never come across a kernel maintainer asking for this style and
   many including myself actively ask people to not do this.
   Each version should be a new email thread.=20

Anyhow, stuff to watch out for next time.

Applied, but given timing I'm not sure if this will be in my final pull req=
uest
for this kernel cycle or not.


Jonathan


> Thanks,
> JB
>=20
> ________________________________________
> From:=C2=A0jason liu <jasonliu10041728@gmail.com>
> Sent:=C2=A0Wednesday, September 4, 2024 11:00
> To:=C2=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Cc:=C2=A0jic23@kernel.org <jic23@kernel.org>; lars@metafoo.de <lars@metaf=
oo.de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel=
@vger.kernel.org <linux-kernel@vger.kernel.org>
> Subject:=C2=A0Re: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
> =C2=A0
> This Message Is From an Untrusted Sender
> You have not previously corresponded with this sender.
> =C2=A0
> Hello, does patch v3 meet the requirements?
>=20
> BR.
>=20
> Jason Liu <jasonliu10041728@gmail.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=882=
=E6=97=A5=E5=91=A8=E4=B8=80 19:31=E5=86=99=E9=81=93=EF=BC=9A
> Add the id_table of inv_icm42600, so the device can probe correctly.
>=20
> Signed-off-by: Jason Liu <jasonliu10041728@gmail.com>
> ---
> V1->V2: fix up the formatting as requested
> ---
> V2->V3: add icm42686 (INV_ICM_42686) and icm42688 (INV_ICM_42688)
> ---
> =C2=A0drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 17 ++++++++++++++=
+++
> =C2=A0drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c | 17 ++++++++++++++=
+++
> =C2=A02 files changed, 34 insertions(+)
>=20
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600_i2c.c
> index ebb31b385881..9e65fef04c39 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> @@ -71,6 +71,22 @@ static int inv_icm42600_probe(struct i2c_client *clien=
t)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inv_icm42=
600_i2c_bus_setup);
> =C2=A0}
>=20
> +/*
> + * device id table is used to identify what device can be
> + * supported by this driver
> + */
> +static const struct i2c_device_id inv_icm42600_id[] =3D {
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ "icm42600", INV_CHIP_ICM42600 },
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ "icm42602", INV_CHIP_ICM42602 },
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ "icm42605", INV_CHIP_ICM42605 },
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ "icm42686", INV_CHIP_ICM42686 },
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ "icm42622", INV_CHIP_ICM42622 },
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ "icm42688", INV_CHIP_ICM42688 },
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ "icm42631", INV_CHIP_ICM42631 },
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0{}
> +};
> +MODULE_DEVICE_TABLE(i2c, inv_icm42600_id);
> +
> =C2=A0static const struct of_device_id inv_icm42600_of_matches[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .compatible =3D "=
invensense,icm42600",
> @@ -104,6 +120,7 @@ static struct i2c_driver inv_icm42600_driver =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .of_match_table =
=3D inv_icm42600_of_matches,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pm =3D pm_ptr(&i=
nv_icm42600_pm_ops),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0.id_table =3D inv_icm42600_id,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 .probe =3D inv_icm42600_probe,
> =C2=A0};
> =C2=A0module_i2c_driver(inv_icm42600_driver);
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600_spi.c
> index eae5ff7a3cc1..75441b2be174 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> @@ -67,6 +67,22 @@ static int inv_icm42600_probe(struct spi_device *spi)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inv_icm42=
600_spi_bus_setup);
> =C2=A0}
>=20
> +/*
> + * device id table is used to identify what device can be
> + * supported by this driver
> + */
> +static const struct spi_device_id inv_icm42600_id[] =3D {
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ "icm42600", INV_CHIP_ICM42600 },
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ "icm42602", INV_CHIP_ICM42602 },
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ "icm42605", INV_CHIP_ICM42605 },
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ "icm42686", INV_CHIP_ICM42686 },
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ "icm42622", INV_CHIP_ICM42622 },
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ "icm42688", INV_CHIP_ICM42688 },
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0{ "icm42631", INV_CHIP_ICM42631 },
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0{}
> +};
> +MODULE_DEVICE_TABLE(spi, inv_icm42600_id);
> +
> =C2=A0static const struct of_device_id inv_icm42600_of_matches[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .compatible =3D "=
invensense,icm42600",
> @@ -100,6 +116,7 @@ static struct spi_driver inv_icm42600_driver =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .of_match_table =
=3D inv_icm42600_of_matches,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pm =3D pm_ptr(&i=
nv_icm42600_pm_ops),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 },
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0.id_table =3D inv_icm42600_id,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 .probe =3D inv_icm42600_probe,
> =C2=A0};
> =C2=A0module_spi_driver(inv_icm42600_driver);
> --
> 2.25.1


