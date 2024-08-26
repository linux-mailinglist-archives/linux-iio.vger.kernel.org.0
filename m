Return-Path: <linux-iio+bounces-8789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3245195EE63
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 12:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09781F2279D
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 10:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74F8146D6D;
	Mon, 26 Aug 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hP0vZXH9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837E313B59E;
	Mon, 26 Aug 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667662; cv=none; b=KM05TizIN6mBOZwybaNpi5AH1jbpRaFOFdjxDEtHPNlTbm2Mj0gn8jqf04xixH3HJYFtD3vrZwVgnf7b82taX7NV8bkIXm7mHC7u9xSAkrhowH0K/POCrJKbQ/dy4YIHtTMhKpKJo5DNmR7uvd7k7m3XfZ2GcG51iLFo20JiKNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667662; c=relaxed/simple;
	bh=9ZyvvWc+MtqHVJhq+sPB68b5/mA0ga0XIBp4cTKBisQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CizQ0VWnaInfk9JwmsPX4tMsIxPAf866+zpdZuztrS4qOuRTDMl7w78d4cPaE80EIEc8UV/1L3gi+4iMXJBPNyzYvH9GNAWkCkg5uhiNSeOkLCPX+9ykvd4pALUrWeOiH41YW6z3U5+Tbj41twL5pylOYnJ8klkYzW8m9LosRaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hP0vZXH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34708C58123;
	Mon, 26 Aug 2024 10:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724667662;
	bh=9ZyvvWc+MtqHVJhq+sPB68b5/mA0ga0XIBp4cTKBisQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hP0vZXH9UFfbDCma1plRy+wY0DsWxH7x6g4HIrDQlE9sK8m1aouszxowMczf9PyNJ
	 rU0ds4e2ZM0cZsF9c9+vEz+frIsd2AnCx0UkDKVxgNjSE3qH2obPhSvcsrRJlYy+66
	 HGFMGV3SS6uuuBh5hwQInE6oa7k8+9XuBBZmLR6oZB0ByRe4Jvf3e4/0j/pzNoCV5M
	 Em8h2v3k6uMP3ZFKb1RxBooKAwvbqLAvOBJUvn0kIEj9JSdYGxuTDS3TT8wag6UHEg
	 8hQNDbgVlijq4AaUPWNEM4GeJ5NvjoQuy8rxMxN5yroj6C7elkUZPPr8Q+IcewGRyf
	 SLI7rOl2ceEhw==
Date: Mon, 26 Aug 2024 11:20:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jason Liu <jasonliu10041728@gmail.com>, "lars@metafoo.de"
 <lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
Message-ID: <20240826111858.7824a811@jic23-huawei>
In-Reply-To: <FR3P281MB1757A595F22A1F9AE50B76B1CE8B2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240825063938.56319-1-jasonliu10041728@gmail.com>
	<FR3P281MB1757A595F22A1F9AE50B76B1CE8B2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Aug 2024 08:22:11 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello,
>=20
> I was believing that id tables weren't required anymore when using of tab=
les.
>=20
> Jonathan,
> can you help on this subject?
>=20
> If we have to add id tables, then we need to add all supported chips (mis=
sing here icm42686 and icm42688).

There were some oddities around autoloading for some busses a while
back but I can't find the reference.

+CC Mark + Wolfram for input.
Do we currently need i2c_device_id and spi_device_id tables for
autoprobing on DT only platforms?

A few minor comments inline.




>=20
> Thanks,
> JB
>=20
> ________________________________________
> From:=C2=A0Jason Liu <jasonliu10041728@gmail.com>
> Sent:=C2=A0Sunday, August 25, 2024 08:39
> To:=C2=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Cc:=C2=A0jic23@kernel.org <jic23@kernel.org>; lars@metafoo.de <lars@metaf=
oo.de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel=
@vger.kernel.org <linux-kernel@vger.kernel.org>; Jason Liu <jasonliu1004172=
8@gmail.com>
> Subject:=C2=A0[PATCH] iio/inv_icm42600: add inv_icm42600 id_table
> =C2=A0
> This Message Is From an Untrusted Sender
> You have not previously corresponded with this sender.
> =C2=A0
> Add the id_table of inv_icm42600, so the device can probe correctly.
>=20
> Signed-off-by: Jason Liu <jasonliu10041728@gmail.com>
> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 15 +++++++++++++++
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c | 15 +++++++++++++++
>  2 files changed, 30 insertions(+)
>=20
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600_i2c.c
> index ebb31b385881..8cc550b8cfc3 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> @@ -71,6 +71,20 @@ static int inv_icm42600_probe(struct i2c_client *clien=
t)
>  				       inv_icm42600_i2c_bus_setup);
>  }
> =20
> +/*
> + * device id table is used to identify what device can be
> + * supported by this driver
> + */
> +static const struct i2c_device_id inv_icm42600_id[] =3D {
> +	{"icm42600", INV_CHIP_ICM42600},
Spaces after { and before }
> +	{"icm42602", INV_CHIP_ICM42602},
> +	{"icm42605", INV_CHIP_ICM42605},
> +	{"icm42622", INV_CHIP_ICM42622},
> +	{"icm42631", INV_CHIP_ICM42631},
> +	{}
{ }

I'm trying to standardize this in IIO.

> +};
> +MODULE_DEVICE_TABLE(i2c, inv_icm42600_id);
> +
>  static const struct of_device_id inv_icm42600_of_matches[] =3D {
>  	{
>  		.compatible =3D "invensense,icm42600",
> @@ -104,6 +118,7 @@ static struct i2c_driver inv_icm42600_driver =3D {
>  		.of_match_table =3D inv_icm42600_of_matches,
>  		.pm =3D pm_ptr(&inv_icm42600_pm_ops),
>  	},
> +	.id_table =3D inv_icm42600_id,
>  	.probe =3D inv_icm42600_probe,
>  };
>  module_i2c_driver(inv_icm42600_driver);
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600_spi.c
> index eae5ff7a3cc1..5fe078ddc8a1 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> @@ -67,6 +67,20 @@ static int inv_icm42600_probe(struct spi_device *spi)
>  				       inv_icm42600_spi_bus_setup);
>  }
> =20
> +/*
> + * device id table is used to identify what device can be
> + * supported by this driver
> + */
> +static const struct spi_device_id inv_icm42600_id[] =3D {
> +	{"icm42600", INV_CHIP_ICM42600},
> +	{"icm42602", INV_CHIP_ICM42602},
> +	{"icm42605", INV_CHIP_ICM42605},
> +	{"icm42622", INV_CHIP_ICM42622},
> +	{"icm42631", INV_CHIP_ICM42631},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, inv_icm42600_id);
> +
>  static const struct of_device_id inv_icm42600_of_matches[] =3D {
>  	{
>  		.compatible =3D "invensense,icm42600",
> @@ -100,6 +114,7 @@ static struct spi_driver inv_icm42600_driver =3D {
>  		.of_match_table =3D inv_icm42600_of_matches,
>  		.pm =3D pm_ptr(&inv_icm42600_pm_ops),
>  	},
> +	.id_table =3D inv_icm42600_id,
>  	.probe =3D inv_icm42600_probe,
>  };
>  module_spi_driver(inv_icm42600_driver);


