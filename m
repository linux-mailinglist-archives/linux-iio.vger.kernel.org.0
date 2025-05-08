Return-Path: <linux-iio+bounces-19346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AE0AB0395
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 21:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125491BA65F9
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2167728A41F;
	Thu,  8 May 2025 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/brE2Lj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D151F28A3F7;
	Thu,  8 May 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746732180; cv=none; b=PeFJOR/96n06ERs8dIKzkKLTn0/4RWG78cOn3fT5wFHBvvfdezy1Ce27Qupk19BB+qXOn8BhqBnybVuWG13sdq7M/2TzVLpcDrS2nUh+F8Zu6E2PddPPiIyAKda3SwhLB7NPWYFA3PFTxiMHANOqANn271D1Pxjad5KauGeUIBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746732180; c=relaxed/simple;
	bh=xEaOglGjVeCloM0OIEpvOv5K7KMz0eFWIGXfKpdktRk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSoMfZdNopVmrYuq010wYg8+qu3jjhpDH1cVzc0U78L+9QysdanhRpasxpJTr87MEfGJhtRe8cHy4Qf/9SlJvQ2FoWarxV2t9lndahkxqYanvDExUJv6hUXkf4Ik4e9nLLmtgbNHdNFbYvqh8adi+SXZPr649hObPd3Gk5MLzrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/brE2Lj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7034AC4CEE7;
	Thu,  8 May 2025 19:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746732180;
	bh=xEaOglGjVeCloM0OIEpvOv5K7KMz0eFWIGXfKpdktRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t/brE2LjR26L8JHvEKa+bMC0bvu9C7qkQK59zU7KeYi5eEiY07s+rr15CyGaw332P
	 Jdd2Y4AF3TELjYc0dSeOgEjM9pPxTKpVWShcZOt0MRPrP5rD2AV/RrPemZlOrYmWtV
	 GmY+uFRI2zihmcLWJZgGTQi4iHK0HJA53dgrB+ZnbzYmt1GyXCuwZj9O3k4h7Yt59T
	 CVKfdp6ZvwrbHrwLStLtv/fyUbDgBesfzhI8za4Twkn/qTYvADewFOIRq6oDZDGlOr
	 +xI3TJYuqtofWL5oUSmC1zooE0NFmOWOom4sjUa5gxZOUqpUmnTf3FmFapPNxwTrSh
	 LyrfRgYMFS6UQ==
Date: Thu, 8 May 2025 20:22:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] iio: bmp280: zero-init buffer
Message-ID: <20250508202253.1b1b9e50@jic23-huawei>
In-Reply-To: <4dad5856ae822e2f6dc5786846e4347668434863.camel@gmail.com>
References: <20250506-iio-pressure-bmp280-zero-init-buffer-v1-1-0935c31558ac@baylibre.com>
	<4dad5856ae822e2f6dc5786846e4347668434863.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 07 May 2025 07:24:52 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2025-05-06 at 13:49 -0500, David Lechner wrote:
> > Zero-initialize the buffer used with iio_push_to_buffers_with_ts(). The
> > struct used for the buffer has holes in it, so we need to make sure that
> > the holes are zeroed out rather than containing uninitialized data from
> > the stack.
> >=20
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/linux-iio/aBoBR5D1UMjsSUfZ@stanley.moun=
tain/
> > Fixes: 4e6c3c4801a6 ("iio: pressure: bmp280: drop sensor_data array")
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> > The patch this fixes is currently in iio/togreg, so no need for stable
> > backport, etc.
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the togreg branch of iio.git etc etc.

Thanks
>=20
> > =C2=A0drivers/iio/pressure/bmp280-core.c | 3 +++
> > =C2=A01 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/=
bmp280-
> > core.c
> > index
> > 5728cc18cced223284a2c41dc6dec6f47169c797..f37f20776c89173b0b2a8e28be0ef=
9aa30ceea53
> > 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -1237,6 +1237,9 @@ static irqreturn_t bme280_trigger_handler(int irq=
, void *p)
> > =C2=A0	} buffer;
> > =C2=A0	int ret;
> > =C2=A0
> > +	/* Don't leak uninitialized stack to userspace. */
> > +	memset(&buffer, 0, sizeof(buffer));
> > +
> > =C2=A0	guard(mutex)(&data->lock);
> > =C2=A0
> > =C2=A0	/* Burst read data registers */
> >=20
> > ---
> > base-commit: 7a175d9667b21b2495913ec7496a6c20aa7a4a89
> > change-id: 20250506-iio-pressure-bmp280-zero-init-buffer-942dd4f48719
> >=20
> > Best regards, =20
>=20


