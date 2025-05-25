Return-Path: <linux-iio+bounces-19898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC99AAC3514
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 16:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C131894AD9
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D481F4639;
	Sun, 25 May 2025 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/V/2DRW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB221F461A;
	Sun, 25 May 2025 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748182351; cv=none; b=iV1vCz52zUSuDe7CdkTpmGrrYg2X+ovKxO95QcuahImZQFB0VsrnCkEckgPrr4mJiNSXgY7E08xZvZ8NqxTXE781GHCS2tjlke52LOf1Ct8BFhe4zNn1yvRMggcQjdAtDihaXH/x+VPPebjZaCQL44c44DQv0RvWQWArO7lYXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748182351; c=relaxed/simple;
	bh=kPN3UcRxki4Ab6sEdocvWIgwDoML00lMYJuo4suTPrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQotU9SLFiIPbe4cAHeq7D9Tm4QRroGOFUhNTw4zFwHgBcKjXvtTyu40tMBrb7+CYQC9vLIzXA+K3cFbTQ76pxj8siLmQDPC1LLxnJjvizTJCcLNrmCN7GbKNhgAmsgoJqT/ATYN4uZJqqSFTM//AF71JjVVH4G5+72pI/CiPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/V/2DRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1B0C4CEEA;
	Sun, 25 May 2025 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748182350;
	bh=kPN3UcRxki4Ab6sEdocvWIgwDoML00lMYJuo4suTPrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U/V/2DRWls8vSBtLtgc/u+OkusmnBfOJYptO+J93vZd/g6S5jZMngTVbYJnznyTNV
	 hUu3RD4cVcQUhHFyzvlxtT4vrauwBd9SYl6je3JDTnunBIB17HTNHVKC4Anog24C7H
	 tLW/ot1pvKHyB0WLxWI5BYoxe1XZyfsKZgN4tIBGVD0DtmU2ovKdFHBLJGM9dzBRBu
	 O7MKb8EEDjjz+o5piwzUGsIzHskmDvTKM5cUsgnWXUbnl2Y6bqz3PQGfXpCVvr8FtC
	 zLXoeo+UNwGP60AYKms5QEs9QY7orWtGNgq1yRkkvM1a2crhOvlfzdyqsHIJoVDgO1
	 rpnByPsHavbjg==
Date: Sun, 25 May 2025 15:12:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad4080: extend check for data lanes num
Message-ID: <20250525151223.2f290fda@jic23-huawei>
In-Reply-To: <8b24ec167ebef4947eb9fe122d546ea8410bc6c2.camel@gmail.com>
References: <20250520110101.29478-1-antoniu.miclaus@analog.com>
	<20250520110101.29478-2-antoniu.miclaus@analog.com>
	<8b24ec167ebef4947eb9fe122d546ea8410bc6c2.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 May 2025 15:09:25 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2025-05-20 at 14:01 +0300, Antoniu Miclaus wrote:
> > Extend the check for st->num_lanes to ensure it is not greater
> > than 2, preventing invalid configurations.
> >=20
> > The AD4080 only supports up to 2 data lanes.
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
This is fine. I'll pick it up once I have a fixes tag for patch 1.
Send a v2 with that in place and picking up
Nuno's tags.

Thanks,

Jonathan

>=20
> > =C2=A0drivers/iio/adc/ad4080.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> > index c36eb41d738a..6e61787ed321 100644
> > --- a/drivers/iio/adc/ad4080.c
> > +++ b/drivers/iio/adc/ad4080.c
> > @@ -516,7 +516,7 @@ static int ad4080_properties_parse(struct ad4080_st=
ate
> > *st)
> > =C2=A0
> > =C2=A0	st->num_lanes =3D 1;
> > =C2=A0	device_property_read_u32(dev, "adi,num-lanes", &st->num_lanes);
> > -	if (!st->num_lanes)
> > +	if (!st->num_lanes || st->num_lanes > 2)
> > =C2=A0		return dev_err_probe(dev, -EINVAL,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid 'adi,num-lanes' value: %u",
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 st->num_lanes); =20


