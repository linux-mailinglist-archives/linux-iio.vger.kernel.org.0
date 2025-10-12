Return-Path: <linux-iio+bounces-25008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DB8BD0A3F
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 21:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B9B3B96A2
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 19:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E932F0C58;
	Sun, 12 Oct 2025 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpSA4WNR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1E72D739C;
	Sun, 12 Oct 2025 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760295609; cv=none; b=A+tvr+xs3PMIFZGUSdlaT6w6jftEnaup+ndEWAs9kYcX/QzKgYpopXisZtgBuNCU5Nh1k6s7fHHSwf+FcMxAOrPz2L3nzC8NYIlAE6A73CHkzyFVvLE+u0Z06PAiBIpWeZ7M9zTwfLrT+m37gcGjitDZLKkC8pRxHb23t/sQGLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760295609; c=relaxed/simple;
	bh=rLZnKijd+DOcYff1JEE92Q67KKVKvCeHX9aHfAWCrEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rfkxr/boKKVjrgkQ9hFPEZwOwL2EKUXwAn2IAEhkFSzjYjqA2VbzM3CzUR3RT/FDB3mUtv68Yfs4fPROz9NmPpFqaHICOjpWwQjWxPhGpBXpPHaRUM9Z8PhwAN2DM6DfloBEC1Q2+ib9m7dU6gpxGZBJSS9cNclx7zvt/nu/Fsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpSA4WNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BB7C4CEF1;
	Sun, 12 Oct 2025 19:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760295606;
	bh=rLZnKijd+DOcYff1JEE92Q67KKVKvCeHX9aHfAWCrEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hpSA4WNRXixG7sr9lZG3OE5OVkjtJ1jSZRiZipWP43LvUsz1CFKJZ1zq16WzEWQAI
	 GFFNEaXBSEGznwG46XZAbbaWAtDqXLR83bRCwKkfx26Im73HgT9snQhRjQ2Km9PMhb
	 gz9QrFdTa5dEVe5x5lMfrXT2CBulrClggiWEIMfWAQBfvOQS23jJQwFPnYwZ/5izWD
	 opHnR8xYl436faOgPTXk+ugDnhZc1tAUoawn8+F4iclEe3m/X0XUoU6aQznAHzKlqZ
	 S9HLETsYSd5IVx4nODnnG0YqQXwQGIDOW11Ae07Jji/tDRpwHuj8Yuiqu6WZxcdEvf
	 /jVf6b5TjXCug==
Date: Sun, 12 Oct 2025 19:59:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?=	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Marcelo Schmitt	 <marcelo.schmitt1@gmail.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7280a: fix ad7280_store_balance_timer()
Message-ID: <20251012195956.0b87bb7f@jic23-huawei>
In-Reply-To: <efeeda046354cabd7da93d5afa64417260fa7c82.camel@gmail.com>
References: <20251010-iio-adc-ad7280a-fix-ad7280_store_balance_timer-v1-1-e11746735192@baylibre.com>
	<efeeda046354cabd7da93d5afa64417260fa7c82.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Oct 2025 20:02:44 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2025-10-10 at 10:44 -0500, David Lechner wrote:
> > Use correct argument to iio_str_to_fixpoint() to parse 3 decimal places.
> >=20
> > iio_str_to_fixpoint() has a bit of an unintuitive API where the
> > fract_mult parameter is the multiplier of the first decimal place as if
> > it was already an integer.=C2=A0 So to get 3 decimal places, fract_mult=
 must
> > be 100 rather than 1000.

I'd completely forgotten about that...

> >=20
> > Fixes: 96ccdbc07a74 ("staging:iio:adc:ad7280a: Standardize extended ABI=
 naming")
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied and +CC stable.

>=20
> > =C2=A0drivers/iio/adc/ad7280a.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
> > index
> > dda2986ccda075fbfa04851a1ceac7a186b47537..50a6ff7c8b1c73905fabdef119d41=
204c32b590c
> > 100644
> > --- a/drivers/iio/adc/ad7280a.c
> > +++ b/drivers/iio/adc/ad7280a.c
> > @@ -541,7 +541,7 @@ static ssize_t ad7280_store_balance_timer(struct ii=
o_dev
> > *indio_dev,
> > =C2=A0	int val, val2;
> > =C2=A0	int ret;
> > =C2=A0
> > -	ret =3D iio_str_to_fixpoint(buf, 1000, &val, &val2);
> > +	ret =3D iio_str_to_fixpoint(buf, 100, &val, &val2);
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> >=20
> > ---
> > base-commit: a9682f53c2d1678b93a123cdaa260e955430bc5c
> > change-id: 20251010-iio-adc-ad7280a-fix-ad7280_store_balance_timer-126b=
c5b4ee90
> >=20
> > Best regards, =20
>=20


