Return-Path: <linux-iio+bounces-19150-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F035EAA9C4C
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 21:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3727E3A4637
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9509D26F455;
	Mon,  5 May 2025 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Xu+34Rkh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FBD1AA1C4;
	Mon,  5 May 2025 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472342; cv=none; b=QHoNPazmp7OLhl4YeWZF3e7HuPN6TMcT8IaWKUknw1eCfV67yo6KGvleL5vV3P8Td3PcnF67E2AW2Maw/1udw0mcFi9UzikjvypaPwb611sjqHXOTgwop4I//+nGU+LOPF1+9F1qUY8lS3/l9RlEoes41YKgyvR2oTwNLKouvJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472342; c=relaxed/simple;
	bh=/OPNapK5a9EqWjgAwkaREoBGWHHOUEuMwasVwSdqBq0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8E8AZ7adGfMTXEfJ0GgX93pJaRCKYWOOK+pnideSm/urY2e0M6aK99L2HRw6tgQPSQPPvRwqpUYVivvYAm6t8yCrMkoXvtWK3cF+74X+4vt9T219dUsAbcdYNS7e/jX/E0bc0wn6gDcZel6SrX0bmAa6JfCqDvuOWhhtEvc2xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Xu+34Rkh; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1746472330; x=1746731530;
	bh=4yUp66nZbz1hUGe3Po3KsCfVeHTtvoxO0pMNffShCFk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Xu+34RkhVDBgw8Eo0sGeuOr2sQb3l6N6v3IgPD3z5RnYu27/pAUARqxnvy0e7Mh7w
	 XB5/YaeYwp/Vxsq/awUrgIou89ID9nXfiPkB5XbAonAiTf6FAaMNIagH4TExNnaGdX
	 T1gpWRlAsgpf9F16PTpQ6ytxrwG15S6VddW+55v+INyWt7k1gAvMOu69dGqNaf1L9a
	 aWks3kZYD2GPFgFo/uHlW8Ai+ak+MGV9Y9U/+9A4KcbNAtYbbFJORKtLu+T5wHaWDv
	 p/f60Yd8t+FwnxB2yjg/mxEIZskCLynqBAMMisqI87y2G95QrOC565EapOWO6fCGSh
	 6m5HCrGNqBaVA==
Date: Mon, 05 May 2025 19:12:06 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: accel: fxls8962af: Fix temperature calculation
Message-ID: <yvr7n54vmlzvzj3ro2fd5d6r2p6bkyynwmb374wifufixhnkl2@nmhzcge42d7m>
In-Reply-To: <20250505175120.40076227@jic23-huawei>
References: <20250505-fxls-v3-0-8c541bf0205c@geanix.com> <20250505-fxls-v3-1-8c541bf0205c@geanix.com> <20250505175120.40076227@jic23-huawei>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: fee163ae75cc5880a1ca6f196d8c84df46f2b7bb
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025 at 05:51:20PM +0100, Jonathan Cameron wrote:
> On Mon, 05 May 2025 08:20:19 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
>=20
> > According to spec temperature should be returned in milli degrees Celsi=
us.
> > Add in_temp_scale to calculate from Celsius to milli Celsius.
> >
> > Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF=
 accelerometers")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> See below.
>=20
> > ---
> >  drivers/iio/accel/fxls8962af-core.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fx=
ls8962af-core.c
> > index bf1d3923a181798a1c884ee08b62d86ab5aed26f..27165a14a4802bdecd9a89c=
38c6cda294088c5c8 100644
> > --- a/drivers/iio/accel/fxls8962af-core.c
> > +++ b/drivers/iio/accel/fxls8962af-core.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/regmap.h>
> >  #include <linux/types.h>
> > +#include <linux/units.h>
> >
> >  #include <linux/iio/buffer.h>
> >  #include <linux/iio/events.h>
> > @@ -439,8 +440,16 @@ static int fxls8962af_read_raw(struct iio_dev *ind=
io_dev,
> >  =09=09*val =3D FXLS8962AF_TEMP_CENTER_VAL;
> >  =09=09return IIO_VAL_INT;
> >  =09case IIO_CHAN_INFO_SCALE:
> > -=09=09*val =3D 0;
> > -=09=09return fxls8962af_read_full_scale(data, val2);
> > +=09=09switch (chan->type) {
> > +=09=09case IIO_TEMP:
> > +=09=09=09*val =3D 2 * MSEC_PER_SEC;
>=20
> For a temperature?   Andy was referring to that particular units.h
> define for a the delay that happened to be below the code you were changi=
ng
> in v1 not this one!  Here we have MILLIDEGREE_PER_DEGREE defined.
>=20

Oops, sorry :/ Will do a v4

> > +=09=09=09return IIO_VAL_INT;
> > +=09=09case IIO_ACCEL:
> > +=09=09=09*val =3D 0;
> > +=09=09=09return fxls8962af_read_full_scale(data, val2);
> > +=09=09default:
> > +=09=09=09return -EINVAL;
> > +=09=09}
> >  =09case IIO_CHAN_INFO_SAMP_FREQ:
> >  =09=09return fxls8962af_read_samp_freq(data, val, val2);
> >  =09default:
> > @@ -736,6 +745,7 @@ static const struct iio_event_spec fxls8962af_event=
[] =3D {
> >  =09.type =3D IIO_TEMP, \
> >  =09.address =3D FXLS8962AF_TEMP_OUT, \
> >  =09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | \
> > +=09=09=09      BIT(IIO_CHAN_INFO_SCALE) | \
> >  =09=09=09      BIT(IIO_CHAN_INFO_OFFSET),\
> >  =09.scan_index =3D -1, \
> >  =09.scan_type =3D { \
> >
>=20


