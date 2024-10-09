Return-Path: <linux-iio+bounces-10380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB899974E8
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 20:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8FC28219C
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728421E0DD2;
	Wed,  9 Oct 2024 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRIG4NEU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2451DFE0E;
	Wed,  9 Oct 2024 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728498621; cv=none; b=e24tL777A8GJujkQXHmI1erbVbWeRa81D4DwUJ/81gs6oJhah0dE0aZgwWK5ZlQILzWV2C5UyBbgG8hWZI2CEfn1mv8HdSXuusVChj4l0UBACg7SOGa8bIBltnKfE0Z1WVgQrfB7HlaUL1V0wLK5/swxpOKmFLQwJ1x1vfOA92M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728498621; c=relaxed/simple;
	bh=fV7EU45lAXq4+i1jLPEcOk6CQrs1Vqg6gHcGMj/TRUM=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=GPGf4P7qnpuX0Yg/iYpGO+NygE2BhZgszP/bon8RoSX2RaXLGwkKXmiyS3iIJ51BgXTwkHWA/tTbyYK7UPo6yymw6frqgtgkFkP5htN9SrZof4zdd+6U7O8gGzt3qIzX7k/pPcmhqfMNcMUZMox3gBvbIgrxgt3Lan4r1uBDEnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRIG4NEU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-431126967d6so721115e9.0;
        Wed, 09 Oct 2024 11:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728498618; x=1729103418; darn=vger.kernel.org;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fV7EU45lAXq4+i1jLPEcOk6CQrs1Vqg6gHcGMj/TRUM=;
        b=lRIG4NEUhgWSEXC9Hx93hnj5jmm8YEnsK41J9yURp2DRJ7ttxf6QL6m3A/wcNmstGT
         ySlhNYZiB1nWR0y++zf3k2m89S+Uz2kWc0FcM69hGEkKQrll8ihw5ematefioSPJ6bc0
         UAkW2ogPcPC+iNR7ySbYndlrFxQfJUFWHEiJsIGwtAjP1LmwIMdMp9Gy6LCg+zhkreGD
         0mTpAh70/D82tY0LFmNeJA7+n0M3wKOHj36Mc/9V6eheR89DoBFK2zetjKLJNrG6/i0p
         x/CZGoBcByrZkVS4wce/9sZffJqXIFKhMNuSR2UkSI2BxN4ZfvOLOaZTazixqUM/Cs1Y
         5S8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728498618; x=1729103418;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fV7EU45lAXq4+i1jLPEcOk6CQrs1Vqg6gHcGMj/TRUM=;
        b=Hbix9l7FA1thJ5SXXsNvaHgl/6iT19mLKfVpXE8Q11KLH5vX/N73abvBkTErPjmkGP
         IA/QmL2xb0yBV0SWAAomHfFF8Tt9VEmp+R2A0ZW6yCtTJ1hg4a40SWkYx9BB9ZpSMzoH
         iQuMdQkVyT1IjDL1waluoQV7GDBhXCgtD0N/AP6cfQPQVYkCAwhcopKwmjM1Kvhtkxrw
         LL9FUsN+sVk1VEpUIu2hO0E6JxdHPgtz5kK7Bwex3ML5LNwmewUlf+WiCvc5GHn9mlR3
         eyaWwJqk3SRyNq+KthI74wsNXhMc6yQCeWE+NBp6bmQNO4wuFXmoPp3P1tyYobp6jPyp
         lCRw==
X-Forwarded-Encrypted: i=1; AJvYcCUFYQQf62jHT0niDV14Sd0Y0SNNzLwvUZAxsX4roRfxb8sTgw2aPWCIuzhQK0qR8UwTHue4YaocC32k1A==@vger.kernel.org, AJvYcCWmQwaCfWmdaKzCXH8rRYKNIcLzm8+sIOYfEWiKtaQkE2pVSs1lX9qyzxR0T6YMPLWiKFc3OHzuJfA=@vger.kernel.org, AJvYcCXH2iHv6NgvAXlnJZWD5+/d3IzJlyzyp7xROgh6lbsN9iEEet2PB6P49N9owjrmml5KE8hDIYU9fHzThus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7hyfn/GiKDwQU+UK+Lx80LNJFPZsBPvAZu1YfAI8JStqPs+BG
	J9XyA//R+Rr5FeYtWuQeZKrulCQK3pUUHLi94/JwMJaLaYNxNf7NDMremuoi
X-Google-Smtp-Source: AGHT+IHHrZJ/X15ulXJDlfENdo29+8z6YHlW+9JNJ34yEbqrrpXjV9u1f+5sbkO0vnE0zMwgMffb1A==
X-Received: by 2002:a05:600c:3b9f:b0:42c:bd4d:e8ba with SMTP id 5b1f17b1804b1-430ccf0928fmr27996965e9.8.1728498617402;
        Wed, 09 Oct 2024 11:30:17 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf516f7sm27004145e9.21.2024.10.09.11.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 11:30:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <27e0d7b2a70015300047d9388edc87a8ece0c0dc.camel@gmail.com>
References: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com> <20241007-iio-read-avail-release-v2-5-245002d5869e@gmail.com> <8a5f6f12c2cb6989cef1d09957fc0f6f7a512b26.camel@gmail.com> <172837007815.3337.5869213289160447430@njaxe.localdomain> <8241b4caf9ebacb116f50bfe1503f325cc576066.camel@gmail.com> <172837459910.12274.5022869861872605261@njaxe.localdomain> <27e0d7b2a70015300047d9388edc87a8ece0c0dc.camel@gmail.com>
Subject: Re: [PATCH v2 5/7] iio: inkern: copy/release available info from producer
From: Matteo Martelli <matteomartelli3@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
To: Alisa-Dariana Roman <alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?q?S=C3=A1?= <noname.nuno@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Peter Rosin <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>
Date: Wed, 09 Oct 2024 20:30:15 +0200
Message-ID: <172849861528.354008.17477801981314044908@njaxe.localdomain>
User-Agent: alot/0.11

Quoting Nuno S=C3=A1 (2024-10-08 14:37:22)
> On Tue, 2024-10-08 at 10:03 +0200, Matteo Martelli wrote:
> > Quoting Nuno S=C3=A1 (2024-10-08 09:29:14)
> > > On Tue, 2024-10-08 at 08:47 +0200, Matteo Martelli wrote:
> > > > Quoting Nuno S=C3=A1 (2024-10-07 17:15:13)
> > > > > On Mon, 2024-10-07 at 10:37 +0200, Matteo Martelli wrote:
> > > > > > Consumers need to call the read_avail_release_resource after re=
ading
> > > > > > the
> > > > > > available info. To call the release with info_exists locked, co=
py the
> > > > > > available info from the producer and immediately call its relea=
se
> > > > > > callback. With this change, users of iio_read_avail_channel_raw=
() and
> > > > > > iio_read_avail_channel_attribute() must free the copied avail i=
nfo
> > > > > > after
> > > > > > calling them.
> > > > > >=20
> > > > > > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> > > > > > ---
> > > > > > =C2=A0drivers/iio/inkern.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 64 +++++++++++++++++++++++++++++++++--
> > > > > > ----
> > > > > > -----
> > > > > > =C2=A0include/linux/iio/consumer.h |=C2=A0 4 +--
> > > > > > =C2=A02 files changed, 50 insertions(+), 18 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > > > > > index
> > > > > > 7f325b3ed08fae6674245312cf8f57bb151006c0..cc65ef79451e5aa2cea44=
7e16800
> > > > > > 7a44
> > > > > > 7ffc0d91
> > > > > > 100644
> > > > > > --- a/drivers/iio/inkern.c
> > > > > > +++ b/drivers/iio/inkern.c
> > > > > > @@ -760,9 +760,25 @@ static int iio_channel_read_avail(struct
> > > > > > iio_channel
> > > > > > *chan,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!iio_channel_has_available(c=
han->channel, info))
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -EINVAL;
> > > > > > =C2=A0
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_info->read_avail)
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return iio_info->read_avail(chan->indio_dev, chan-
> > > > > > >channel,
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 vals, type, length, info);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_info->read_avail) {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 const int *vals_tmp;
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 int ret;
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ret =3D iio_info->read_avail(chan->indio_dev, chan-
> > > > > > >channel,
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0 &vals_tmp, type, length,
> > > > > > info);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (ret < 0)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > > > > +
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 *vals =3D kmemdup_array(vals_tmp, *length, sizeof(int),
> > > > > > GFP_KERNEL);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (!*vals)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> > > > > > +
> > > > >=20
> > > > > Not a big deal but I would likely prefer to avoid yet another cop=
y. If
> > > > > I'm
> > > > > understanding things correctly, I would rather create an inkern w=
rapper
> > > > > API
> > > > > like=20
> > > > > iio_channel_read_avail_release_resource() - maybe something with a
> > > > > smaller
> > > > > name :).
> > > > > Hence, the lifetime of the data would be only controlled by the p=
roducer
> > > > > of
> > > > > it. It
> > > > > would also produce a smaller diff (I think). I just find it a bit
> > > > > confusing
> > > > > that we
> > > > > duplicate the data in here and the producer also duplicates it on=
 the -
> > > > > > read_avail()
> > > > > call. Another advantage I see is that often the available data is=
 indeed
> > > > > const in
> > > > > which case no kmemdup_array() is needed at all.
> > > >=20
> > > >=20
> > > > If I understand correctly your suggestion you would leave the inkern
> > > > iio_channel_read_avail() untouched, then add a new inkern wrapper,
> > > > something
> > > > like iio_channel_read_avail_release_resource(), that would call the
> > > > producer's
> > > > read_avail_release_resource(). The consumer would invoke this new w=
rapper
> > > > in
> > > > its
> > > > own read_avail_release_resource() avoiding the additional copy. The=
 call
> > > > stack
> > > > would look something like the following:
> > > >=20
> > > > iio_read_channel_info_avail() {
> > > > =C2=A0=C2=A0=C2=A0 consumer->read_avail() {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_read_avail_channel_r=
aw() {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
iio_channel_read_avail() {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 producer->read_avail() {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmemdup_array();
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > =C2=A0=C2=A0=C2=A0 }
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 iio_format_list();
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 consumer->read_avail_release_resource() {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_read_avail_channel_r=
elease_resource() {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
producer->read_avail_release_resource() {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 kfree();
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > =C2=A0=C2=A0=C2=A0 }
> > > > }
> > >=20
> > > Yeah, exactly what came to mind...
> > >=20
> > > >=20
> > > >=20
> > > > I was going with the simpler solution you described, but my concern=
 with
> > > > it
> > > > was
> > > > that the info_exists_lock mutex would be unlocked between a
> > > > iio_channel_read_avail()
> > > > call and its corresponding iio_channel_read_avail_release_resource(=
) call.
> > > > To my understanding, this could potentially allow for the device to=
 be
> > > > unregistered between the two calls and result in a memleak of the a=
vail
> > > > buffer
> > > > allocated by the producer.
> > > >=20
> > > > However, I have been trying to reproduce a similar case by adding a=
 delay
> > > > between the consumer->read_avail() and the
> > > > consumer->read_avail_release_resources(), and by unbinding the driv=
er
> > > > during
> > > > that delay, thus with the info_exists_lock mutex unlocked. In this =
case
> > > > the
> > > > driver is not unregistered until the iio_read_channel_info_avail()
> > > > function
> > > > completes, likely because of some other lock on the sysfs file afte=
r the
> > > > call
> > > > of
> > > > cdev_device_del() in iio_device_unregister().
> > > >=20
> > >=20
> > > Yes, you need to have some sync point at the kernfs level otherwise w=
e could
> > > always be handling a sysfs attr while the device is being removed und=
er our
> > > feet. But I'm not sure what you're trying to do... IIUC, the problem =
might
> > > come
> > > if have:
> > >=20
> > > consumer->read_avail_channel_attribute()
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 producer->info_lock()
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 producer->read_avail()
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 producer->kmalloc()
> > >=20
> > > ...
> > > // producer unbound
> > > ...
> > > consumer->read_avail_release()
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
> > >=20
> > > // producer->kmalloc() never get's freed...
> > >=20
> > > The above is your problem right? And I think it should be a valid one=
 since
> > > between ->read_avail_channel_attribute() and read_avail_release() the=
re's
> > > nothing preventing the producer from being unregistered...
> >=20
> > Yes, that's the problem.
> >=20
> > >=20
> > > If I'm not missing nothing one solution would be for the producer to =
do
> > > devm_kmalloc() and devm_kfree() on read_avail() and release_resources=
() but
> > > at
> > > that point I'm not sure it's better than what you have since it's odd=
 enough
> > > for
> > > being missed in reviews...
> >=20
> > I honestly didn't think of this and it would in fact prevent the
> > additional copy. But I agree that it could be missed in new drivers,
> > maybe a comment in the iio_info read_avail_release_resource() callback
> > declaration would help?
> > >=20
> At this point I would say whatever you or Jonathan prefer :)
>=20

I run some quick tests with this approach and haven't found any issue so
far. I would personally switch to this approach as it would be much
simpler and easier to understand, and since the avail lists are const
for most of the current drivers I would not expect many new drivers
needing a dynamic available list. However, I will wait Jonathan feedback
first.

About the release wrapper name: even though "release_resource" looks a
common suffix for this kind of pattern,
iio_read_avail_channel_release_resource() seems in fact extremely long
and I would go for something like iio_read_avail_channel_release(). At
that point I would also shorten the iio_info release function name for
consistency, like read_avail_release_resource() =3D> read_avail_release().
I hope such names would be clear enough though. Any feedback on this?

> - Nuno S=C3=A1

Thanks,
Matteo Martelli

