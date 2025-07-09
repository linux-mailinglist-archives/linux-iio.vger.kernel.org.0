Return-Path: <linux-iio+bounces-21492-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1620AFEE45
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 17:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6695F1C46F18
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A3D2E9759;
	Wed,  9 Jul 2025 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmCjrHUq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072612E8E16;
	Wed,  9 Jul 2025 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076709; cv=none; b=Vet4Anjfv/T9ozopJ4FR7zLC2Uc3Hac/+fyvjtNlaBUCwt0a+qj6qteq0w88wb3zfKbu0ONs25AU3f1gnlvWiCaPOfoRyRo0MP2uvyOL3IrM1PGyxz4jGeeAr+ZXyf3lF+NYGcst7icOoXdXHL1aAdIrk/Brm2c3TuCgZjJyOz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076709; c=relaxed/simple;
	bh=ho7w5SxBeNjEXamVHI7jhXD1PIS20PhfIy49tdqHxJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQ125vr6ZLt7HNcreHkBRd54Ra1gpAp+gp8oVNHblwd5XtQVdivDLPGada9stUTzupAklB+2aFTmYQCTnEZIG1U+zsmf0+Z8zgGKpMqZSGVxGtcan38jHJx6Lq1PUVQJn7juxAre/lPhgK/JYjqwNgeeLVC+cTpzJLdfD5rNqvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmCjrHUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED873C4CEF4;
	Wed,  9 Jul 2025 15:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076708;
	bh=ho7w5SxBeNjEXamVHI7jhXD1PIS20PhfIy49tdqHxJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GmCjrHUqYGFyS9t4BAnF9t9QuF4JOgJqeMPoUncx0wbCWsj1noG15F5sePGZM3+Ug
	 nVwhlKUoywJpT+ko/1Fh0jffSM3365ZMwtyxJinjduorTHwRYgdBo2AIc8g8ORkWyN
	 r8fwUJOCI4ZHRZFi+zTcBX1+D/hUAXLrhIP06HrHwpaqhO3celj05KB0ZdIUG/vsKi
	 sQuvkzqBTXuwMR1mq15Amiwb+2CF2KSC+HnYdJ7EGsDyCTPpL2uwReWNgDJo73pG9k
	 1vWLjjFftFDLdH3QnWQZmzNWQ7pPVPU21klnJ63Dq0C1tAhrVwICB96aBZqY2HrczY
	 SU3RHCy0B1cEA==
Date: Wed, 9 Jul 2025 16:58:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich 
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= 
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Guillaume Ranquet
  <granquet@baylibre.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7313: fix calibration channel
Message-ID: <20250709165819.1015259e@jic23-huawei>
In-Reply-To: <75b46712867097cbe7a4e7bf070730d5c524149f.camel@gmail.com>
References: <20250708-iio-adc-ad7313-fix-calibration-channel-v1-1-e6174e2c7cbf@baylibre.com>
	<75b46712867097cbe7a4e7bf070730d5c524149f.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 09 Jul 2025 10:33:32 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2025-07-08 at 20:38 -0500, David Lechner wrote:
> > Fix the channel index values passed to ad_sd_calibrate() in
> > ad7173_calibrate_all().
> >=20
> > ad7173_calibrate_all() expects these values to be that of the CHANNELx
> > register assigned to the channel, not the datasheet INPUTx number of the
> > channel. The incorrect values were causing register writes to fail for
> > some channels because they set the WEN bit that must always be 0 for
> > register access and set the R/W bit to read instead of write. For other
> > channels, the channel number was just wrong because the CHANNELx
> > registers are generally assigned in reverse order and so almost never
> > match the INPUTx numbers.
> >=20
> > Fixes: 031bdc8aee01 ("iio: adc: ad7173: add calibration support")
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
Applied to the fixes-togreg branch of iio.git.

> > =C2=A0drivers/iio/adc/ad7173.c | 5 ++---
> > =C2=A01 file changed, 2 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> > index
> > c41bc5b9ac597f57eea6a097cc3a118de7b42210..61749586670d4f0730ca423d6e4c0=
ee1bf19
> > edfa 100644
> > --- a/drivers/iio/adc/ad7173.c
> > +++ b/drivers/iio/adc/ad7173.c
> > @@ -392,13 +392,12 @@ static int ad7173_calibrate_all(struct ad7173_sta=
te *st,
> > struct iio_dev *indio_d
> > =C2=A0		if (indio_dev->channels[i].type !=3D IIO_VOLTAGE)
> > =C2=A0			continue;
> > =C2=A0
> > -		ret =3D ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_ZERO, st- =20
> > >channels[i].ain); =20
> > +		ret =3D ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_INT_ZERO, i);
> > =C2=A0		if (ret < 0)
> > =C2=A0			return ret;
> > =C2=A0
> > =C2=A0		if (st->info->has_internal_fs_calibration) {
> > -			ret =3D ad_sd_calibrate(&st->sd,
> > AD7173_MODE_CAL_INT_FULL,
> > -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->channels[i].ain);
> > +			ret =3D ad_sd_calibrate(&st->sd,
> > AD7173_MODE_CAL_INT_FULL, i);
> > =C2=A0			if (ret < 0)
> > =C2=A0				return ret;
> > =C2=A0		}
> >=20
> > ---
> > base-commit: 2233378a8c606f7f6893d4c16aa6eb6fea027a52
> > change-id: 20250708-iio-adc-ad7313-fix-calibration-channel-198ed65d9b0a
> >=20
> > Best regards, =20


