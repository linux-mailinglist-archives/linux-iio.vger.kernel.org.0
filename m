Return-Path: <linux-iio+bounces-16336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C242A4DEF9
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F9D3A8D66
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 13:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242872040A8;
	Tue,  4 Mar 2025 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urBNGoIe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18CD202974;
	Tue,  4 Mar 2025 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094038; cv=none; b=AJ/QWbbf3eAfFXQ1exj/9vtbyFKP2zRFCJ0PGMe8Iu23TaLRuJySr1rjSSW30cjFGQHVez/6NYtawcfMA9kXQCwqBebMZZDlQNw02AFyHv0h8p4w3HXilhB8Sw461HVUE98i7cVyM+xqyufUobk/WK9I5QDICMjZI1yKa9loCgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094038; c=relaxed/simple;
	bh=ko8x7nXq9/vzwLbMrAAmg57HdZ0vk6zRRFPCu6remI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/dbG4kyjP2Oq3iflr3+FotBt8LLbJifHTkCbyClgr4aM370jPP3gVXJFDl8P2TcxDI6BOlXXuwITcc2OzRYoer0LQSIE2mLb55QcLimxN2YD/lY17e0nxj0OB3aXoj0eht/bod00AkmH8Zp5n4qwWns5tLkjqrfGiVTyX+ocP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urBNGoIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E0EC4CEE5;
	Tue,  4 Mar 2025 13:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741094038;
	bh=ko8x7nXq9/vzwLbMrAAmg57HdZ0vk6zRRFPCu6remI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=urBNGoIeWygwRfnI73T1Zq1iOYee7M/qtQZnV7h9r9eRmVI5G/1KTGjq5y5qz4NEr
	 9fL8YJUhIg6yxaezJ5V2QQpXY1DUb9tIG+SY20zeXiUjZbrLHDwDQqA3RfIsGYc3wp
	 pJ8mjltULVmHR4M495kkEXMb8zTkMKnwp+FitIBBR31MoJfPyWkfP8CCOL6CzDNITX
	 nkbB/DlVUSpA9GVFzDyb3AnX8Iut++XZVW/wI6RzSxdPpzdvd0lrNrzIREr45WCMKu
	 mXzaKGQ8xHHM4UIZl58gTeaag+jpGQM85wWmJdGyih7YDJUkNoXdN+pEaVrEWXs4Bg
	 0jiFWmOa9bgew==
Date: Tue, 4 Mar 2025 13:13:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Antoniu Miclaus 
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich  <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] iio: adc: ad4851: Fix signedness bug in
 ad4851_calibrate()
Message-ID: <20250304131344.65211155@jic23-huawei>
In-Reply-To: <5fa78e957fc85fa134cea5fa68b21b56c6173a44.camel@gmail.com>
References: <f5e260e9-d7a8-4dae-b7ea-f1bbb1760e60@stanley.mountain>
	<5fa78e957fc85fa134cea5fa68b21b56c6173a44.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Feb 2025 13:24:20 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2025-02-28 at 12:36 +0300, Dan Carpenter wrote:
> > The "c" variable is used to store error codes from ad4851_find_opt()
> > so it has to be signed for the error handling to work.=C2=A0 Change it
> > to type int.
> >=20
> > Fixes: 6250803fe2ec ("iio: adc: ad4851: add ad485x driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Julia + 0-day / coccinelle caught this one as well but seeing as you
were both first to report and you sent me a patch I'll just apply this one.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

>=20
> > Btw, in ad4851_write_raw() there are some checks for negative but
> > the multiplication could still wrap and turn negative so we might want =
to
> > add an upper bounds as well:
> >=20
> > =C2=A0=C2=A0=C2=A0 drivers/iio/adc/ad4851.c:826 ad4851_write_raw()
> > =C2=A0=C2=A0=C2=A0 warn: potential integer overflow from user 'val * st=
->osr'
> >=20
> > =C2=A0drivers/iio/adc/ad4851.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
> > index 1ad37084355e..98ebc853db79 100644
> > --- a/drivers/iio/adc/ad4851.c
> > +++ b/drivers/iio/adc/ad4851.c
> > @@ -492,11 +492,11 @@ static int ad4851_find_opt(const unsigned long *f=
ield,
> > unsigned int start,
> > =C2=A0static int ad4851_calibrate(struct iio_dev *indio_dev)
> > =C2=A0{
> > =C2=A0	struct ad4851_state *st =3D iio_priv(indio_dev);
> > -	unsigned int opt_delay, num_lanes, delay, i, s, c;
> > +	unsigned int opt_delay, num_lanes, delay, i, s;
> > =C2=A0	enum iio_backend_interface_type interface_type;
> > =C2=A0	DECLARE_BITMAP(pn_status, AD4851_MAX_LANES * AD4851_MAX_IODELAY);
> > =C2=A0	bool status;
> > -	int ret;
> > +	int c, ret;
> > =C2=A0
> > =C2=A0	ret =3D iio_backend_interface_type_get(st->back, &interface_type=
);
> > =C2=A0	if (ret) =20
>=20
>=20


