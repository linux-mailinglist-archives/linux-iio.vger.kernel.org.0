Return-Path: <linux-iio+bounces-24715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B84BB8EAA
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 16:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2943189D42A
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B4321C9F4;
	Sat,  4 Oct 2025 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TD+nJktW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6235F1CEAC2;
	Sat,  4 Oct 2025 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759587778; cv=none; b=NbfKHIEoHIqCcuExjw2wAKDAkrcns24AtuWoW8mG9oU3eNpq52xPxaTbBIfv8sUEQenskJYPXJPXWiYW7OAv4Ixl1usG5sbdVbyx9ERVcCc1A2JNZgVQSZ2MK+aGtkjIT9QuXJ5CFhrj6F/SfP7/hDEtv0W+RB5svTT+h4zfEqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759587778; c=relaxed/simple;
	bh=Ykj/QzqagXSCHVyL+LX/ShUGuN8G2LZiLhlNW8hbKmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEWtkBXHL5CqtDz8Tlv4l5jSwEPEUuXIXDnPAJxOKsrEFih0noDEuftJUZR2TJQtyvbh+DITb9sJtYxIejeXr7Pl7WzvCp51aruCcn418eRsH3HHUwi+pOU5CQimGSTB/q9LjU6rD7acX+JdavYz7h/Xgg0m8TODXzaemUf2rtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TD+nJktW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A066C4CEF1;
	Sat,  4 Oct 2025 14:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759587778;
	bh=Ykj/QzqagXSCHVyL+LX/ShUGuN8G2LZiLhlNW8hbKmk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TD+nJktWVfu1vCw6/X+MbGpHZHGTYp7Kyqlr67ngMRU73cWCfzHb7kSFbkjDEGp7O
	 WInnC+c91g128puiKY6THQZP5l8sywdW89I5RbSW2hB8hUhQA9raqER8QCCnjpohoK
	 i2tJD9CVmn8Q3Nlin76Y6VZwmN5GD18+NijYvH5XkPWs+zO0Uom7ZyxFtJaCSfZTks
	 PUZX2hkFD9hrsETHqgPJTuhU1L01DLh9vD9etWailBINTLfmIIxjOM8XUrte0ucCAQ
	 jd2mg96E+7BXL30FImo7EqklwcVhvNXfsXQCf8EMWIdmaM/Cw+RVPf8EtHkPIk/JMg
	 CM8Q0uMJRUbSQ==
Date: Sat, 4 Oct 2025 15:22:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iio: adc: ad4080: fix chip identification
Message-ID: <20251004152249.18116842@jic23-huawei>
In-Reply-To: <3c959b42a01d3af75fdf536fc3e3289a076953c3.camel@gmail.com>
References: <20250930103229.28696-1-antoniu.miclaus@analog.com>
	<3c959b42a01d3af75fdf536fc3e3289a076953c3.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Sep 2025 13:35:46 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> Hi Antoniu,
>=20
> I think that for a series like this you should include a cover letter...
Yup. Then I'd be replying to that rather than here!

>=20
> On Tue, 2025-09-30 at 10:32 +0000, Antoniu Miclaus wrote:
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
> > ---
> > changes in v2:
> > =C2=A0- add the chip id handling into a separate commit.
> > =C2=A0- use regmap_bulk_read.
> > =C2=A0drivers/iio/adc/ad4080.c | 5 +++--
> > =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> > index 6e61787ed321..b80560aebe2d 100644
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
> > @@ -458,10 +458,11 @@ static int ad4080_setup(struct iio_dev *indio_dev)
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > -	ret =3D regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
> > +	ret =3D regmap_bulk_read(st->regmap, AD4080_REG_PRODUCT_ID_L, &id, 2);
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > +	id =3D get_unaligned_le16(&id); =20
>=20
> Being id an 'unsigned int' I'm not really sure the above will work on big=
 endian
> machines as we should only populate the 2 MSB, right? But independent of =
that,
> id is only being used in here so I would use proper __le16 (and u16) and
> le16_to_cpu().
>=20
Spot on.  Types are a mess here and will trigger issues if sparse is pointed
at this code (and possibly other compiler related warnings).

The series otherwise looks good to me. You could probably have added all th=
e DT
changes in one patch and all the devices support in another (rather than 2 =
of each)
but that's not important enough to change now.

So I'll pick the whole thing up on v3 once this type issue is resolved.

thanks,

Jonathan

> - Nuno S=C3=A1
>=20
> > =C2=A0	if (id !=3D AD4080_CHIP_ID)
> > =C2=A0		dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
> > =C2=A0 =20


