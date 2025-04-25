Return-Path: <linux-iio+bounces-18623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72E9A9C09F
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 10:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D655A4A5C
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 08:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D38231A3F;
	Fri, 25 Apr 2025 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8byq8RA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD38D1E1C1A;
	Fri, 25 Apr 2025 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569029; cv=none; b=Jrkkgh46qgfJKqKwge3dZKm4/1z66SUAjSEe6Fm0zWjhj/ow6+uz2AQSHSTpcPS9wMtj1AYW2dC1KL+5a6ViNgP8kaQxWWn4Y77EBSlL08qiJPSiYfoKIBzY468VjJFdnoKpy2jbwEGprFTUt/kWb9fJvOseZSVNutEaS4GPJ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569029; c=relaxed/simple;
	bh=l93aW+hnno0yviT9MaFsDASYUSa9NmcxK1YOv6d8EaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nk6DMMAnRubNxZluVdLiXKHIYjTDzRAAjotkV6Az/fvmorsFDYcSyPOt/V3nub2u70S5LW5NAfB15Y3IrGmanoPIxibSksSmOpHo2j5wTz+wUQmz8MEf+gguKmhDYSWQoY8B+m7mEwG6hJjk5KXSQS5OONqrHUVCj0U/qgIDY3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8byq8RA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DADCC4CEE4;
	Fri, 25 Apr 2025 08:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745569029;
	bh=l93aW+hnno0yviT9MaFsDASYUSa9NmcxK1YOv6d8EaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S8byq8RAhFEWJpSrQrKkEzCruFZuIOr8WVkXYfEEbPpsRunNEusHq4W2zsOjCqLgI
	 eM+N2xzMFdprvQdPBxloCQ4fNTYciABbYycCi2EyRr5QyZKGiGo8d+dv26AkOXdG3H
	 Z4Z7OQt4g9iSptvtxaExVKJWWSdgkos6NA9NnZGeP2FWFRUMygxjkuKZpuJg349ue7
	 fs8x4JlkK6Zt5Ctq8AVcQDhmRmE3xrVuy+v4ueYISa4moCB3S/F71ICEV8w6NpN3dk
	 4PSlVW7HSAPvFVUnSMeFD/6He+QsCs0LrqkeFzdqbjXTJtg9obDjblFdNE+XTJTXTN
	 FEzfsByP8W39A==
Date: Fri, 25 Apr 2025 09:16:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 2/3] staging: iio: ad9832: Refactor powerdown control
Message-ID: <20250425091659.71bf143f@jic23-huawei>
In-Reply-To: <CAKUZ0zKXg4KLpHPLtpkywPLp8+xxwAMSpNAgUmP34pfVZDv7Aw@mail.gmail.com>
References: <20250420175419.889544-1-gshahrouzi@gmail.com>
	<20250420175419.889544-3-gshahrouzi@gmail.com>
	<20250421123728.1564039d@jic23-huawei>
	<CAKUZ0zKXg4KLpHPLtpkywPLp8+xxwAMSpNAgUmP34pfVZDv7Aw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Apr 2025 18:25:51 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> On Mon, Apr 21, 2025 at 7:37=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Sun, 20 Apr 2025 13:54:18 -0400
> > Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:
> > =20
> > > Replace custom implementation with out_altvoltage_powerdown ABI. The
> > > attribute's logic is inverted (1 now enables powerdown) to match the
> > > standard. Modernize driver by using the standard IIO interface.
> > >
> > > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > > ---
> > >  drivers/staging/iio/frequency/ad9832.c | 44 ++++++++++++++++++------=
--
> > >  1 file changed, 30 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging=
/iio/frequency/ad9832.c
> > > index 0872ff4ec4896..a8fc20379efed 100644
> > > --- a/drivers/staging/iio/frequency/ad9832.c
> > > +++ b/drivers/staging/iio/frequency/ad9832.c
> > > @@ -167,6 +167,34 @@ static int ad9832_write_phase(struct ad9832_stat=
e *st,
> > >       return spi_sync(st->spi, &st->phase_msg);
> > >  }
> > >
> > > +static ssize_t ad9832_write_powerdown(struct device *dev, struct dev=
ice_attribute *attr,
> > > +                                   const char *buf, size_t len)
> > > +{
> > > +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > > +     struct ad9832_state *st =3D iio_priv(indio_dev);
> > > +     int ret;
> > > +     unsigned long val;
> > > +
> > > +     ret =3D kstrtoul(buf, 10, &val);
> > > +     if (ret)
> > > +             goto error_ret;
> > > +
> > > +     mutex_lock(&st->lock); =20
> >
> > Look at how guard(mutex)(&st->lock);
> > can be used in this driver to simplify things considerably. =20
> Noted, added into new version.
> > May make sense to do that before introducing this new code. =20
> Not sure whether to have made it its own patch or not. I grouped it
> together with the new code since it also uses locking.
For new code it is fine to do it at the same time.

If there are other places it makes sense in the driver, separate
patch covering all those.

Jonathan

