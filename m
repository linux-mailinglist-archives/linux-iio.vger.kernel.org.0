Return-Path: <linux-iio+bounces-10119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B18B9904E9
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 15:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A3F1F22CF0
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 13:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5F5212F15;
	Fri,  4 Oct 2024 13:54:38 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CEA1BC59;
	Fri,  4 Oct 2024 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050078; cv=none; b=Dp+ow6OIDIupPzD2KqUUaRGCF8U2/nNM6EcbC/K/UNBY8OpotMnQsqftcZb+Q5Qj/Rukbmk0HI1xSFoyAKgwA4mLinY33YUzUKF8u2jRQlI/zZ9cD7rTv1amKolpHlsTREIXVEihDAA83OBZvYkvQd/Dmbi5snpefwQ21QAS1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050078; c=relaxed/simple;
	bh=6Zyc5VBb+/KicI9y1i9ewO+fiOtM8228SQyczy9uL9U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DF98CUxg3emRzShQ2Vduvulz/Q4+ZkjVRG2AYawvIQtsNtgQ4aEcTqoK6jNePhXigwW4y7pCHhtbLOQ3ATyCvtRV5by+vAE7ZyssNalos7mcuA3Co+6TC9mCled5EySCAVz5nnLJkhkZEVIyArBRW8alxbt2h8hD1LveFOMvkYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XKqm52z9Qz6HJV3;
	Fri,  4 Oct 2024 21:54:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 061481408F9;
	Fri,  4 Oct 2024 21:54:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Oct
 2024 15:54:32 +0200
Date: Fri, 4 Oct 2024 14:54:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alexandru Ardelean <aardelean@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<krzk+dt@kernel.org>, <robh@kernel.org>, <lars@metafoo.de>,
	<michael.hennerich@analog.com>, <gstols@baylibre.com>
Subject: Re: [PATCH v7 8/8] iio: adc: ad7606: add support for
 AD7606C-{16,18} parts
Message-ID: <20241004145430.000012f4@Huawei.com>
In-Reply-To: <CA+GgBR_HTwNT6WKdweuuTZ_t+ZmMXrMkYNK+b3pp4f2MmTWzGw@mail.gmail.com>
References: <20240919130444.2100447-1-aardelean@baylibre.com>
	<20240919130444.2100447-9-aardelean@baylibre.com>
	<CA+GgBR_kKYOgPUHM5-LUAZboy6nab1tLvC4TFtzpqkjP+5A8wg@mail.gmail.com>
	<047034ae-135b-4ce9-a407-9b2a00841324@baylibre.com>
	<20241001194114.16e0ffa5@jic23-huawei>
	<CA+GgBR_HTwNT6WKdweuuTZ_t+ZmMXrMkYNK+b3pp4f2MmTWzGw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 2 Oct 2024 09:12:09 +0300
Alexandru Ardelean <aardelean@baylibre.com> wrote:

> On Tue, Oct 1, 2024 at 9:41=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Tue, 1 Oct 2024 08:42:23 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> > =20
> > > On 10/1/24 3:26 AM, Alexandru Ardelean wrote: =20
> > > > On Thu, Sep 19, 2024 at 4:05=E2=80=AFPM Alexandru Ardelean
> > > > <aardelean@baylibre.com> wrote: =20
> > > >> =20
> > >
> > > ...
> > > =20
> > > >> @@ -153,7 +349,19 @@ static int ad7606_scan_direct(struct iio_dev =
*indio_dev, unsigned int ch,
> > > >>         if (ret)
> > > >>                 goto error_ret;
> > > >>
> > > >> -       *val =3D sign_extend32(st->data[ch], 15);
> > > >> +       chan =3D &indio_dev->channels[ch + 1];
> > > >> +       if (chan->scan_type.sign =3D=3D 'u') {
> > > >> +               if (storagebits > 16)
> > > >> +                       *val =3D st->data.buf32[ch];
> > > >> +               else
> > > >> +                       *val =3D st->data.buf16[ch];
> > > >> +               return 0; =20
> > > >
> > > > Arrggh...
> > > > I messed up here.
> > > > Guillaume found a bug here, where this should be "goto error_ret" or
> > > > do an "if ()  {} else {}"
> > > > How should we do it here? =20
> > if / else. Goto an error label when it's not an error would be horrible=
! =20
> > > >
> > > > Do we send a fix-patch or send a new series?
> > > > =20
> > >
> > > Since this patch is already applied, just follow up with another
> > > patch with a Fixes: tag. =20
> >
> > I sometimes tweak these sort of things if I haven't pushed out
> > as togreg yet (or they are really bad!) but in this case I'm not
> > 100% sure what the comment is, so I'll just apply a fix on top.
> >
> > So David is entirely correct in general but by luck of timing
> > this time I'll tweak it.
> >
> > Please check the result in iio.git/testing
> > I'll hold off pushing that out as togreg until at least end of
> > tomorrow.  One more day o =20
>=20
> The "return 0" needs to be removed in the driver.
>=20
>         if (chan->scan_type.sign =3D=3D 'u') {
>                 if (storagebits > 16)
>                         *val =3D st->data.buf32[ch];
>                 else
>                         *val =3D st->data.buf16[ch];
> -                return 0;
Doh!.   Just goes to show why I shouldn't just edit these things.
Stupid mistake.  I'll fix when on right machine.

Jonathan

>         } else {
>                 if (storagebits > 16)
>                         *val =3D sign_extend32(st->data.buf32[ch], 17);
>                 else
>                         *val =3D sign_extend32(st->data.buf16[ch], 15);
>         }
>=20
>=20
>=20
> >
> > Jonathan
> >
> > =20
> > >
> > >
> > > =20
> > =20
>=20


