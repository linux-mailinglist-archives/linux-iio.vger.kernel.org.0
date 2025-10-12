Return-Path: <linux-iio+bounces-25004-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2F8BD096F
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 20:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1CEE4EA66B
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 18:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36732F25EC;
	Sun, 12 Oct 2025 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZ80QzYW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F642EE5FC;
	Sun, 12 Oct 2025 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292627; cv=none; b=so205h6/nLnfifAKluCuo5ViERYZ9hdyYZfePVV48I/3D+hzwPtMLesfIugrL+aIBuLK/j8vYa6khtI6tPcGs34teZhdOvSYmkkoi2j0VlNY5OOV7SWkkKjWwlK2iySdYp99OBenrUGn88geOF+SvhWGlhYiMLUVikVyzgwUm9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292627; c=relaxed/simple;
	bh=VsTOYU7FMvsZmwm9o6Boz5jv/T7U+40AtnR6DJQCb9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3udsWo6TnJXT+F6XcY4NyPnNrGkPjySv8RbTzN8U+nzmQ1QhINyRH7e8rGft4LE5xSjqWa/sQxQaTZDrf4JiTHU9641c9MUmEtXdrEzOkH9fpA616mKWPdI+p1vjNqX4F78HLFWzTqh48YW32m8cMgGdyDlf88MhR7+eBPDPzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZ80QzYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9CDC4CEE7;
	Sun, 12 Oct 2025 18:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760292626;
	bh=VsTOYU7FMvsZmwm9o6Boz5jv/T7U+40AtnR6DJQCb9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gZ80QzYWAJUbiyTSCFHzHf9vn/Q7JQQ2uv0ouIAkJCAmef3l6S5jxau8Da5iyoFGf
	 BkrmfKixqyA1Afq7CQvfqq0iRofq2B0rfyGvZz3a8IPLvRxdxkcxBCnabHLuhjNuhj
	 G/sXQr0w3el0nVzObdMIDAu76tBJqWuWMG15+bb46YEJbUq6P+XOi6zn9chs205jN7
	 b6I1TrV4bCqWv0LunjFfXFu8kQ5NtTsMvccLr79sbMdxLjxvnZUEAOs+GS5l+PEYuo
	 qDHpraX47gP1Y3iqxhO82ZJ0WTO30rwd2DSY+mpPSkptJavQnlIlE1yLFcPDDUYgvk
	 prMIaaRuypTAg==
Date: Sun, 12 Oct 2025 19:10:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/6] iio: adc: ad4080: fix chip identification
Message-ID: <20251012191017.1ad05768@jic23-huawei>
In-Reply-To: <ba68afe4fbe5c895de8a2ce506a69e0c0884eb4e.camel@gmail.com>
References: <20251007111525.25711-1-antoniu.miclaus@analog.com>
	<20251007111525.25711-2-antoniu.miclaus@analog.com>
	<ba68afe4fbe5c895de8a2ce506a69e0c0884eb4e.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 07 Oct 2025 15:41:02 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2025-10-07 at 11:15 +0000, Antoniu Miclaus wrote:
> > Fix AD4080 chip identification by using the correct 16-bit product ID
> > (0x0050) instead of GENMASK(2, 0). Update the chip reading logic to
> > use regmap_bulk_read to read both PRODUCT_ID_L and PRODUCT_ID_H
> > registers and combine them into a 16-bit value.
> >=20
> > The original implementation was incorrectly reading only 3 bits,
> > which would not correctly identify the AD4080 chip.
> >=20
> > Fixes: 6b31ba1811b6 ("iio: adc: ad4080: add driver support")
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > --- =20
>=20
> Small nitpick below that Jonathan might tweak if he thinks it's worth it.
> Anyways,
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

I'll tidy that up.

I'm currently taking a possibly controversial route with this patch.

Given I think we just get a false warning message without it, I'm going
to assume this isn't critical and queue it up for next merge window.
The advantage is I don't have to deal with tracking this patch going upstre=
am
before I can apply the others in the series...

Shout if you'd prefer the harder route that gets this upstream faster.

Jonathan

>=20
> > changes in v3:
> > =C2=A0- use le16_to_cpu to convert the read little-endian value to CPU =
endianness
> > =C2=A0drivers/iio/adc/ad4080.c | 8 +++++---
> > =C2=A01 file changed, 5 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> > index 6e61787ed321..ae5a975a47a5 100644
> > --- a/drivers/iio/adc/ad4080.c
> > +++ b/drivers/iio/adc/ad4080.c
> > @@ -125,7 +125,7 @@
> > =C2=A0
> > =C2=A0/* Miscellaneous Definitions */
> > =C2=A0#define
> > AD4080_SPI_READ						BIT(7)
> > -#define AD4080_CHIP_ID						GENMASK(2, 0)
> > +#define AD4080_CHIP_ID						0x0050
> > =C2=A0
> > =C2=A0#define AD4080_LVDS_CNV_CLK_CNT_MAX				7
> > =C2=A0
> > @@ -445,7 +445,8 @@ static int ad4080_setup(struct iio_dev *indio_dev)
> > =C2=A0{
> > =C2=A0	struct ad4080_state *st =3D iio_priv(indio_dev);
> > =C2=A0	struct device *dev =3D regmap_get_device(st->regmap);
> > -	unsigned int id;
> > +	__le16 id_le;
> > +	u16 id;
> > =C2=A0	int ret;
> > =C2=A0
> > =C2=A0	ret =3D regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
> > @@ -458,10 +459,11 @@ static int ad4080_setup(struct iio_dev *indio_dev)
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > -	ret =3D regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
> > +	ret =3D regmap_bulk_read(st->regmap, AD4080_REG_PRODUCT_ID_L, &id_le,
> > 2); =20
>=20
> sizeof(id_le)
>=20
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > +	id =3D le16_to_cpu(id_le);
> > =C2=A0	if (id !=3D AD4080_CHIP_ID)
> > =C2=A0		dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
> > =C2=A0 =20


