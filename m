Return-Path: <linux-iio+bounces-10225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E5A991DFD
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 12:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE4C28198E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 10:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8B2174ED0;
	Sun,  6 Oct 2024 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLzspN92"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF62158543;
	Sun,  6 Oct 2024 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728212212; cv=none; b=uGQl5FUmTdoW1vPQiDCA33UkLyfGA1diKY5Y+IM2ERisFwh/+e3IzeqBCLCZO6/oxllkeTbXkZLr1E2feqYmjySs6+AJtlc9GChg/159iIHpgj8wffSO3m+msHRnOTH4Uj/M0p8Xuua526hM6EaGNe3gydtUl+p6tE+iHtrvAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728212212; c=relaxed/simple;
	bh=qeqQuDTxp73Ysl2hFvb6xtPdBPTnnrBOZ9KMn8cAfhw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWyE3C5yNtNWokWxu43rPbwXdpEo8tWXK0ZIzHieEPJTsL/D94iPkBzIOkc27Bg2wrqFH3avzsYclTlIB0fHUWxqpXPYDcbdslAv6EpOQU2OD/L0IK6wB79CrWL6JRinGKKJA/QAmIORtesZaytO4W+d5MaFhx9TP7Ep44HvyXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLzspN92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0452AC4CEC5;
	Sun,  6 Oct 2024 10:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728212212;
	bh=qeqQuDTxp73Ysl2hFvb6xtPdBPTnnrBOZ9KMn8cAfhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LLzspN92YYcTUYoa3GJVaw6f9ucQadl7ooCycfHTwNMbotb+SZhA15E12nVp9QnHi
	 o1sNVRisetiryqFlMK1EkeVADN9vXOd440B+LaKJ6sTa8SpV3vpFuV/8SkKFKNTCqN
	 woa9L8GIZAPRouh5NJBbYfr1Hg6oF8eebE6wUQpn5pNGc1s5cNDeMiHchr7WIULaYL
	 BHEyUPolNweC8PDqeqKZMDLV03QlbvKT3x1CEKESXkgJkwFObXwGyqYHjAYa6trNaX
	 m3LK3wO2pPu18FgbeCJMgR7N2wzhLurKgVWRrlTeZe3ZTQ50OEGGGUY8VOPBWyieao
	 3ZdcM3AwsLRGA==
Date: Sun, 6 Oct 2024 11:56:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>, David Lechner
 <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <krzk+dt@kernel.org>, <robh@kernel.org>, <lars@metafoo.de>,
 <michael.hennerich@analog.com>, <gstols@baylibre.com>
Subject: Re: [PATCH v7 8/8] iio: adc: ad7606: add support for
 AD7606C-{16,18} parts
Message-ID: <20241006115643.7b1fd461@jic23-huawei>
In-Reply-To: <20241004145430.000012f4@Huawei.com>
References: <20240919130444.2100447-1-aardelean@baylibre.com>
	<20240919130444.2100447-9-aardelean@baylibre.com>
	<CA+GgBR_kKYOgPUHM5-LUAZboy6nab1tLvC4TFtzpqkjP+5A8wg@mail.gmail.com>
	<047034ae-135b-4ce9-a407-9b2a00841324@baylibre.com>
	<20241001194114.16e0ffa5@jic23-huawei>
	<CA+GgBR_HTwNT6WKdweuuTZ_t+ZmMXrMkYNK+b3pp4f2MmTWzGw@mail.gmail.com>
	<20241004145430.000012f4@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Oct 2024 14:54:30 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 2 Oct 2024 09:12:09 +0300
> Alexandru Ardelean <aardelean@baylibre.com> wrote:
>=20
> > On Tue, Oct 1, 2024 at 9:41=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote: =20
> > >
> > > On Tue, 1 Oct 2024 08:42:23 -0500
> > > David Lechner <dlechner@baylibre.com> wrote:
> > >   =20
> > > > On 10/1/24 3:26 AM, Alexandru Ardelean wrote:   =20
> > > > > On Thu, Sep 19, 2024 at 4:05=E2=80=AFPM Alexandru Ardelean
> > > > > <aardelean@baylibre.com> wrote:   =20
> > > > >>   =20
> > > >
> > > > ...
> > > >   =20
> > > > >> @@ -153,7 +349,19 @@ static int ad7606_scan_direct(struct iio_de=
v *indio_dev, unsigned int ch,
> > > > >>         if (ret)
> > > > >>                 goto error_ret;
> > > > >>
> > > > >> -       *val =3D sign_extend32(st->data[ch], 15);
> > > > >> +       chan =3D &indio_dev->channels[ch + 1];
> > > > >> +       if (chan->scan_type.sign =3D=3D 'u') {
> > > > >> +               if (storagebits > 16)
> > > > >> +                       *val =3D st->data.buf32[ch];
> > > > >> +               else
> > > > >> +                       *val =3D st->data.buf16[ch];
> > > > >> +               return 0;   =20
> > > > >
> > > > > Arrggh...
> > > > > I messed up here.
> > > > > Guillaume found a bug here, where this should be "goto error_ret"=
 or
> > > > > do an "if ()  {} else {}"
> > > > > How should we do it here?   =20
> > > if / else. Goto an error label when it's not an error would be horrib=
le!   =20
> > > > >
> > > > > Do we send a fix-patch or send a new series?
> > > > >   =20
> > > >
> > > > Since this patch is already applied, just follow up with another
> > > > patch with a Fixes: tag.   =20
> > >
> > > I sometimes tweak these sort of things if I haven't pushed out
> > > as togreg yet (or they are really bad!) but in this case I'm not
> > > 100% sure what the comment is, so I'll just apply a fix on top.
> > >
> > > So David is entirely correct in general but by luck of timing
> > > this time I'll tweak it.
> > >
> > > Please check the result in iio.git/testing
> > > I'll hold off pushing that out as togreg until at least end of
> > > tomorrow.  One more day o   =20
> >=20
> > The "return 0" needs to be removed in the driver.
> >=20
> >         if (chan->scan_type.sign =3D=3D 'u') {
> >                 if (storagebits > 16)
> >                         *val =3D st->data.buf32[ch];
> >                 else
> >                         *val =3D st->data.buf16[ch];
> > -                return 0; =20
> Doh!.   Just goes to show why I shouldn't just edit these things.
> Stupid mistake.  I'll fix when on right machine.
hopefully now done

J
>=20
> Jonathan
>=20
> >         } else {
> >                 if (storagebits > 16)
> >                         *val =3D sign_extend32(st->data.buf32[ch], 17);
> >                 else
> >                         *val =3D sign_extend32(st->data.buf16[ch], 15);
> >         }
> >=20
> >=20
> >  =20
> > >
> > > Jonathan
> > >
> > >   =20
> > > >
> > > >
> > > >   =20
> > >   =20
> >  =20
>=20


