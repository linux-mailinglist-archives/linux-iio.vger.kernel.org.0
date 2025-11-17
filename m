Return-Path: <linux-iio+bounces-26268-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F44C64FE3
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 16:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DACC3510FF
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 15:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E31129A9C3;
	Mon, 17 Nov 2025 15:54:13 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCCC27F00A
	for <linux-iio@vger.kernel.org>; Mon, 17 Nov 2025 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763394853; cv=none; b=D34ZKa6Wfb42pecVyqAMLwh87FrEfTwUZZ13nBBEFHE8PLC7Vr2FWhCrsc3OOPTV42F+g9Fs8D5f3Ha65DDxjGQxX7yzMbUhm9QuKLGL2KEslyCBMZitSBieFwOFDOEPBMDOpP5617PCQG+44rjuRpu80v9L6AjxbftXTEqz7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763394853; c=relaxed/simple;
	bh=+PqbbtsFk9FfU75tmtAHHxBjm5dKRSVW+uTfT46N7ZQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bh5qCrC2jPZlht1vrfYXGB4HgXZEVHKcoIGw5X3Qy8FUy099Q7aIl9otALkztUK6rsx2/okq7CK+06FZNUD/A8sa3vWEzi62oEVyDZO/S2ZLJ/rJP+bR/e8n6Jlrfim0/DFBEyrl2dfN+VbpRP/X0BSDdqVTv9kK+4mRauLCZa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d9C2b250WzJ4680;
	Mon, 17 Nov 2025 23:53:27 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 20D3214011A;
	Mon, 17 Nov 2025 23:54:08 +0800 (CST)
Received: from localhost (10.126.172.135) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 17 Nov
 2025 15:54:07 +0000
Date: Mon, 17 Nov 2025 15:54:06 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "=?ISO-8859-1?Q?K=FCbrich,?= Andreas"
	<andreas.kuebrich@spektra-dresden.de>
CC: "'jic23@kernel.org'" <jic23@kernel.org>, "'linux-iio@vger.kernel.org'"
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: ad5686: add AD5695R to ad5686_chip_info_tbl
Message-ID: <20251117155406.000002af@huawei.com>
In-Reply-To: <PAXPR09MB5040DBBE59B2BA98F1108581B4C9A@PAXPR09MB5040.eurprd09.prod.outlook.com>
References: <PAXPR09MB5040DBBE59B2BA98F1108581B4C9A@PAXPR09MB5040.eurprd09.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 17 Nov 2025 12:35:13 +0000
"K=FCbrich," Andreas <andreas.kuebrich@spektra-dresden.de> wrote:

> The chip info for this variant (I2C, four channels, 14 bit, internal refe=
rence)
> seems to have been left out due to oversight, so ad5686_chip_info_tbl[ID_=
AD5695R]
> is all zeroes. Initialisation of an AD5695R still succeeds, but the resul=
ting IIO
> device has no channels and no /dev/iio:device* node.

Hi Andreas,

Thanks. This is another one for a list of reasons not to use an enum and ar=
ray
for these! We used to do that a lot, but current best practice is separate
structures.

Wrap commit descriptions a little shorter (75 chars is typical).  Tooling t=
ends
to end up indenting these for some reason so that convention has been aroun=
d a long
time.

>=20
> Add the missing chip info to the table.
>=20
> Signed-off-by: Andreas K=FCbrich <andreas.kuebrich@spektra-dresden.de>


Please could you provide a fixes tag. (see submitting patches).

Replying to this email is fine rather than sending a new patch.=20

Thanks,

Jonathan

> ---
> I sincerely hope my employer-mandated mail client (Outlook on Windows ...=
 yeah,
> I don't like it either) doesn't mangle the mail format. At least I've fou=
nd the
> setting for disabling removal of line breaks.
>=20
>  drivers/iio/dac/ad5686.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index d9cae9555e..4b18498aa0 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -434,6 +434,12 @@ static const struct ad5686_chip_info ad5686_chip_inf=
o_tbl[] =3D {
>  		.num_channels =3D 4,
>  		.regmap_type =3D AD5686_REGMAP,
>  	},
> +	[ID_AD5695R] =3D {
> +		.channels =3D ad5685r_channels,
> +		.int_vref_mv =3D 2500,
> +		.num_channels =3D 4,
> +		.regmap_type =3D AD5686_REGMAP,
> +	},
>  	[ID_AD5696] =3D {
>  		.channels =3D ad5686_channels,
>  		.num_channels =3D 4,


