Return-Path: <linux-iio+bounces-9318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF329706C3
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 12:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 456F9B20C76
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 10:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E121509BF;
	Sun,  8 Sep 2024 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJHdM2zq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33A24B5AE;
	Sun,  8 Sep 2024 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725792684; cv=none; b=F6ZGQKdZfOOZelCBzXLVMr32w41+L+YQ4/cqRuAH37xE8Y+vCO6tsn6RI3e/5pTJGYYoh7WBuhgpADQG/j4P5AcSz1tSxdthRk8yggBESjLe8X54qEbHTSefHpU2FxdXK3S2maIajSYslKK3DpmfhCKJAnEkWQFzFw8PvzStBO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725792684; c=relaxed/simple;
	bh=OFfjpZOaBCRy6/aLBKamak0P24a0SfLNSwakEI54tBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HB0rULxC7tuNoFV/e+fOF0WYwAaqzrJYwxoJ1l0N53z6e5r2tliRJF0c0dbfi9onG4HJE7JyxylHUfinYOpWGc0AhdqZpIqiII7M/Sa2A3IJu0emax203vkFIoW9W/cwvoCu28CnOC/KKDICK3wqSxzms8FyU97RcJi0TAheexE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJHdM2zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24619C4CEC3;
	Sun,  8 Sep 2024 10:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725792683;
	bh=OFfjpZOaBCRy6/aLBKamak0P24a0SfLNSwakEI54tBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hJHdM2zqFH63fWYXIquUTb0f4V3VRm+skZXPUnIKkzm6QvX1HkEOjJbLgsaRXo7vz
	 nw9eWghWA4IDMqV7S+ct6ThyPlyDebCc7Ytg7Q+xbCZ3uLHjfL46+CpEACPfoKbaCK
	 ZEUMWRCeETqvX7Qs9P0+A27RLUfDKD5YgnYJM5pDWD1s2MVmdF0QfwmP5RJ+iMuAUL
	 AysPrFc4byah4h1GX0GswsF5b7FqbvVYKAjm1gsonVuMk4KJ+qnlbmtyM3IFNPtT+f
	 mPtPTVv6MRbMPU9mbvaF4eWPgZwLVFjHTVpSLUgabiVCzCV7dmq0nY8KruGdsE0roE
	 S52DTkTq/YCZw==
Date: Sun, 8 Sep 2024 11:51:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: jason liu <jasonliu10041728@gmail.com>
Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
 "lars@metafoo.de" <lars@metafoo.de>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: =?UTF-8?B?5Zue5aSNOg==?= [PATCH] iio/inv_icm42600: add
 inv_icm42600 id_table
Message-ID: <20240908115115.1bf1155d@jic23-huawei>
In-Reply-To: <SI6PR01MB63197238674C8895885420D8F59E2@SI6PR01MB6319.apcprd01.prod.exchangelabs.com>
References: <FR3P281MB175720831E0817C23AD0B1BACE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<20240902113101.3135-1-jasonliu10041728@gmail.com>
	<CAJci1vC9pvdqEpA8sk+uB5jJGn_DKUruXFfY6tbG9mO07YxgHQ@mail.gmail.com>
	<FR3P281MB1757BEA60FF72A44847F1646CE9D2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<SI6PR01MB63197238674C8895885420D8F59E2@SI6PR01MB6319.apcprd01.prod.exchangelabs.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Sep 2024 05:02:59 +0000
jason liu <jasonliu10041728@gmail.com> wrote:

> Hello,
>=20
> I'm glad this patch could help. And I would like to know, how will the pa=
tch to be handled moving forward?
>=20
It is queued up on the IIO tree.  Given timing it's queued for 6.13.
Note that for now that is only pushed out as testing because I will
be rebasing the IIO togreg branch on 6.12-rc1.
One that is done it will appear in linux-next.

It should go upstream and appear in char-misc/char-misc-next
in about 6 weeks.  After that Greg KH will send a pull request during
the 6.13 merge window in about 12 weeks time and it will then hopefully
get merged into Linus' tree before 6.13-rc1=20

I haven't treated this as a fix because it was never there, but
it may make sense to request a backport to stable after it is upstream.

Thanks,

Jonathan

> Thanks.
>=20
> ________________________________
> From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Sent: Thursday, September 5, 2024 5:25 PM
> To: jason liu <jasonliu10041728@gmail.com>
> Cc: jic23@kernel.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de=
>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger=
.kernel.org <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
>=20
> Hello,
>=20
> looks good for me now, thanks for the patch.
>=20
> Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>=20
> Thanks,
> JB
>=20
> ________________________________________
> From: jason liu <jasonliu10041728@gmail.com>
> Sent: Wednesday, September 4, 2024 11:00
> To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Cc: jic23@kernel.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de=
>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger=
.kernel.org <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
>=20
> This Message Is From an Untrusted Sender
> You have not previously corresponded with this sender.
>=20
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
>  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 17 +++++++++++++++++
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c | 17 +++++++++++++++++
>  2 files changed, 34 insertions(+)
>=20
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600_i2c.c
> index ebb31b385881..9e65fef04c39 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> @@ -71,6 +71,22 @@ static int inv_icm42600_probe(struct i2c_client *clien=
t)
>                                        inv_icm42600_i2c_bus_setup);
>  }
>=20
> +/*
> + * device id table is used to identify what device can be
> + * supported by this driver
> + */
> +static const struct i2c_device_id inv_icm42600_id[] =3D {
> +       { "icm42600", INV_CHIP_ICM42600 },
> +       { "icm42602", INV_CHIP_ICM42602 },
> +       { "icm42605", INV_CHIP_ICM42605 },
> +       { "icm42686", INV_CHIP_ICM42686 },
> +       { "icm42622", INV_CHIP_ICM42622 },
> +       { "icm42688", INV_CHIP_ICM42688 },
> +       { "icm42631", INV_CHIP_ICM42631 },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(i2c, inv_icm42600_id);
> +
>  static const struct of_device_id inv_icm42600_of_matches[] =3D {
>         {
>                 .compatible =3D "invensense,icm42600",
> @@ -104,6 +120,7 @@ static struct i2c_driver inv_icm42600_driver =3D {
>                 .of_match_table =3D inv_icm42600_of_matches,
>                 .pm =3D pm_ptr(&inv_icm42600_pm_ops),
>         },
> +       .id_table =3D inv_icm42600_id,
>         .probe =3D inv_icm42600_probe,
>  };
>  module_i2c_driver(inv_icm42600_driver);
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600_spi.c
> index eae5ff7a3cc1..75441b2be174 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> @@ -67,6 +67,22 @@ static int inv_icm42600_probe(struct spi_device *spi)
>                                        inv_icm42600_spi_bus_setup);
>  }
>=20
> +/*
> + * device id table is used to identify what device can be
> + * supported by this driver
> + */
> +static const struct spi_device_id inv_icm42600_id[] =3D {
> +       { "icm42600", INV_CHIP_ICM42600 },
> +       { "icm42602", INV_CHIP_ICM42602 },
> +       { "icm42605", INV_CHIP_ICM42605 },
> +       { "icm42686", INV_CHIP_ICM42686 },
> +       { "icm42622", INV_CHIP_ICM42622 },
> +       { "icm42688", INV_CHIP_ICM42688 },
> +       { "icm42631", INV_CHIP_ICM42631 },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(spi, inv_icm42600_id);
> +
>  static const struct of_device_id inv_icm42600_of_matches[] =3D {
>         {
>                 .compatible =3D "invensense,icm42600",
> @@ -100,6 +116,7 @@ static struct spi_driver inv_icm42600_driver =3D {
>                 .of_match_table =3D inv_icm42600_of_matches,
>                 .pm =3D pm_ptr(&inv_icm42600_pm_ops),
>         },
> +       .id_table =3D inv_icm42600_id,
>         .probe =3D inv_icm42600_probe,
>  };
>  module_spi_driver(inv_icm42600_driver);
> --
> 2.25.1


