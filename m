Return-Path: <linux-iio+bounces-25386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88366C02AF1
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 19:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9543F1A07722
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDAE34405D;
	Thu, 23 Oct 2025 17:13:27 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1D02BE04B;
	Thu, 23 Oct 2025 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761239607; cv=none; b=OWW5RU8e8HDovj+WuFERHEEDc01aELxGTYuHWgmpcC7+CO3ko1qFScNr+xnrIYeva6vEuSFmm9Ca047G/P2tsfZLrC5gtROvFKbJ5uK8HZ5nXILtNetBFEyFdHy1Mk/CpJ7C0t9nzY9a3iZ04XYbs3qSSo1lo3yxzKaM914PbTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761239607; c=relaxed/simple;
	bh=43zKZOu5/nxCqS/C0A0/xA0D23J6SoQ/a+NoCWPo3I0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltK7aCSo+Zc3EUUyAf1Q4SxJIjZ6QBZeBYuJ+4MnTY6o2V2JTa8ilzrbwvKt2rZd3ja2Ml033kxIs3o7f6U5hwsp2FD1SdlSQSmbcJIAbtIFPt8MlKSXfWxSCGYEPEuI23/8SEpd7px6bcY+Y7N/r1+bAEZPzoyqmV/vXPsqVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cssyg1241z6L4vD;
	Fri, 24 Oct 2025 01:11:55 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 513E5140279;
	Fri, 24 Oct 2025 01:13:23 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 18:13:22 +0100
Date: Thu, 23 Oct 2025 18:13:21 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
CC: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: dac: ad5456: Add missing DT compatibles
Message-ID: <20251023181321.00001511@huawei.com>
In-Reply-To: <20251023-ad5446-bindings-v2-2-27fab9891e86@analog.com>
References: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
	<20251023-ad5446-bindings-v2-2-27fab9891e86@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 23 Oct 2025 14:01:38 +0300
Nuno S=E1 <nuno.sa@analog.com> wrote:

I'd retitle this to say it's adding explicit DT compatibles

Missing made me thing one or two were missing rather than it relying
on the fallback path to use the i2c_device_id / spi_device_id paths.

I'm not particularly keen on only get the drvdata from those other
tables as that's fragile to the two remaining precisely in sync. Until
we fix that better to not add these tables at all.

The cleanup will need to switch to pointers rather than enum entries
and then use generic fetchers to get those pointers which ever type
of firmware we have.

Not trivial but also fairly mechanical change to make so I don't
feel too mean asking that you do that as part of this patch series.
If nothing else looking at just this series, someone might think a fallback
compatible would be fine given the differences between parts aren't
visible.

Jonathan


> Add missing of_device_id compatibles for the i2c and spi drivers.
>=20
> Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>
> ---
>  drivers/iio/dac/ad5446.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>=20
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index ad304b0fec08..b6967f3b9386 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -445,6 +445,35 @@ static const struct spi_device_id ad5446_spi_ids[] =
=3D {
>  MODULE_DEVICE_TABLE(spi, ad5446_spi_ids);
> =20
>  static const struct of_device_id ad5446_of_ids[] =3D {
> +	{ .compatible =3D "adi,ad5300" },
> +	{ .compatible =3D "adi,ad5310" },
> +	{ .compatible =3D "adi,ad5320" },
> +	{ .compatible =3D "adi,ad5444" },
> +	{ .compatible =3D "adi,ad5446" },
> +	{ .compatible =3D "adi,ad5450" },
> +	{ .compatible =3D "adi,ad5451" },
> +	{ .compatible =3D "adi,ad5452" },
> +	{ .compatible =3D "adi,ad5453" },
> +	{ .compatible =3D "adi,ad5512a" },
> +	{ .compatible =3D "adi,ad5541a" },
> +	{ .compatible =3D "adi,ad5542a" },
> +	{ .compatible =3D "adi,ad5543" },
> +	{ .compatible =3D "adi,ad5553" },
> +	{ .compatible =3D "adi,ad5600" },
> +	{ .compatible =3D "adi,ad5601" },
> +	{ .compatible =3D "adi,ad5611" },
> +	{ .compatible =3D "adi,ad5621" },
> +	{ .compatible =3D "adi,ad5641" },
> +	{ .compatible =3D "adi,ad5620-2500" },
> +	{ .compatible =3D "adi,ad5620-1250" },
> +	{ .compatible =3D "adi,ad5640-2500" },
> +	{ .compatible =3D "adi,ad5640-1250" },
> +	{ .compatible =3D "adi,ad5660-2500" },
> +	{ .compatible =3D "adi,ad5660-1250" },
> +	{ .compatible =3D "adi,ad5662" },
> +	{ .compatible =3D "ti,dac081s101" },
> +	{ .compatible =3D "ti,dac101s101" },
> +	{ .compatible =3D "ti,dac121s101" },
>  	{ .compatible =3D "ti,dac7512" },
>  	{ }
>  };
> @@ -547,9 +576,21 @@ static const struct i2c_device_id ad5446_i2c_ids[] =
=3D {
>  };
>  MODULE_DEVICE_TABLE(i2c, ad5446_i2c_ids);
> =20
> +static const struct of_device_id ad5446_i2c_of_ids[] =3D {
> +	{ .compatible =3D "adi,ad5301" },
> +	{ .compatible =3D "adi,ad5311" },
> +	{ .compatible =3D "adi,ad5321" },
> +	{ .compatible =3D "adi,ad5602" },
> +	{ .compatible =3D "adi,ad5612" },
> +	{ .compatible =3D "adi,ad5622" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(OF, ad5446_i2c_of_ids);
> +
>  static struct i2c_driver ad5446_i2c_driver =3D {
>  	.driver =3D {
>  		   .name =3D "ad5446",
> +		   .of_match_table =3D ad5446_i2c_of_ids,
>  	},
>  	.probe =3D ad5446_i2c_probe,
>  	.id_table =3D ad5446_i2c_ids,
>=20


