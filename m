Return-Path: <linux-iio+bounces-10323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E17F994229
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 10:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01DCB290669
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 08:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825321EF0A1;
	Tue,  8 Oct 2024 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cox9mxAv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EA81EF090;
	Tue,  8 Oct 2024 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374605; cv=none; b=CuVwZPA7US2cE2hBfnU2qlyKDAWWCFOqk/X9BQ94IcPOphmm8rZp1nmz3zNbmogL37+pvT+TUvGgAOXpNxFPDL1K+NeCtXf2f5KRHA4mz+XAppLEt8dtv78HKNTUdpSnRwxRyf8+C39r6hpcdHge4GaNP/pdPePk+lsxltlo/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374605; c=relaxed/simple;
	bh=XBMi6rziIMGxbBIyrnL1aK7ZwJ5EsYX95OLjIyHITWA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=nbSEAuKK7i2mzII3EN+N5mdxLi06XNLBi99rbh5DZ4Xzb+mUcQsHthkDHfv3+yYF6HkGu34u4Ra1HvqqMrdBZ5i2QEBZ7fQHAEYleGQUM9UEjm9nk8WYLFCU7XKnUeqswnNOcBF+QQHgK3hutiqJ6rVIIQR+Czrci/wGBVx+LmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cox9mxAv; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso72271741fa.1;
        Tue, 08 Oct 2024 01:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728374601; x=1728979401; darn=vger.kernel.org;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnW9MSupvuroe4ZK+wCOmPw/iLAZXZp4btXrWJnjVXE=;
        b=Cox9mxAvkWJIgnso0fhe0KXT4lc4TzfV7woSOrtt478YExpJd/tY1vD4GLXGEHFO4W
         PU/DABb20U4j+cTKdGON7h9VnRBA1hOIPhmW2SGqVQVZnge18A1RqXeLzg0LXKOswkbD
         YXSYbUKMtJP9wZNXDaHv9VxUfZFVA/JvloFPIeRSQYR3SjdKJjRcLDQMLu+3eLqoRGcY
         TtVVpBYJtrO9jpxpGzx39LsCWVjQzwAN088KeTsxcJUBjF6pn5XTP0OLnz+pyIBwKH8J
         07K9vgdyIurZwIJeHhXvW1oNV8l4R81SIjvXvVAQaUEmlEiD/yjtb4VZKxCsjuBBX/3O
         sGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728374601; x=1728979401;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YnW9MSupvuroe4ZK+wCOmPw/iLAZXZp4btXrWJnjVXE=;
        b=BZGNOGthUSbulBYyxLCzltrclJIMG04GEUjdPWATNAvQVcMHUoMRjjGIQmbhnys84X
         ywqMUVRVs5/xhlS5Zd5eMYTzmY1jRMApSg09MHVFiqmqMQazHJ6BtI+DVAAVPgfVIttk
         hnQ6sIE2qBkr7QD3jnzFk6dJiCR6kBOZkLp2K9dL4lZVFNrEMTD3eIaSHGDW515LLi9P
         OwapAasefBAQjvLg+nKSsd/rIUnFlgcu6nC0Lb3eSdPB4y0I6V3PEQjQeFB8w5aa/4We
         3lGda9pikmKMy2bUKxUcGjj3PrXW+acX0WHaPwHyEMPT7vM9sQLmLaywe+UFmoJ7A8Q/
         GzYg==
X-Forwarded-Encrypted: i=1; AJvYcCVTdr3r5uz63LK61JkcXiijJJvP11t66g5XapP4RCLIniOybg+C88AXyc1fxaZV2Lh00DF+UFlfH/tR6Q==@vger.kernel.org, AJvYcCXmp82igyOfQblcKi34HBr3A2m7FCiK8B836bk/dMnrYRbyNVwgGsUk+kAo0WLzYksVAEr1uJyK1IQ=@vger.kernel.org, AJvYcCXnwHP1ZfT8i1S3Q9aPcK4vAbKy86CKKRKVy8mdHPOTO2l8WfXEG2xmTOGP10ajS85u1N8XaPY3FV8imaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW98q0S2zsTAyC4NRZ4Q/ZuYfYh6TK1hYv1NV0t2NKZZaKewHZ
	rHpXtIXtyanaZcQciI0Syu+F6n55bgEhSo0e8ynM6vTTTsMxYJ23+lX9Nx8Y
X-Google-Smtp-Source: AGHT+IFUwBZw9H86LptyFRT7IfNwLH9rkAPglKu+AiZNNJnzwRI3K55kkz9phw4h3TDpjMW+q7RZeg==
X-Received: by 2002:a05:651c:b0b:b0:2fa:f5f9:4194 with SMTP id 38308e7fff4ca-2faf5f94416mr87526161fa.27.1728374600745;
        Tue, 08 Oct 2024 01:03:20 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993c1b353dsm416456266b.35.2024.10.08.01.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 01:03:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8241b4caf9ebacb116f50bfe1503f325cc576066.camel@gmail.com>
References: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com> <20241007-iio-read-avail-release-v2-5-245002d5869e@gmail.com> <8a5f6f12c2cb6989cef1d09957fc0f6f7a512b26.camel@gmail.com> <172837007815.3337.5869213289160447430@njaxe.localdomain> <8241b4caf9ebacb116f50bfe1503f325cc576066.camel@gmail.com>
Subject: Re: [PATCH v2 5/7] iio: inkern: copy/release available info from producer
From: Matteo Martelli <matteomartelli3@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
To: Alisa-Dariana Roman <alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?q?S=C3=A1?= <noname.nuno@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Peter Rosin <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>
Date: Tue, 08 Oct 2024 10:03:19 +0200
Message-ID: <172837459910.12274.5022869861872605261@njaxe.localdomain>
User-Agent: alot/0.11

Quoting Nuno S=C3=A1 (2024-10-08 09:29:14)
> On Tue, 2024-10-08 at 08:47 +0200, Matteo Martelli wrote:
> > Quoting Nuno S=C3=A1 (2024-10-07 17:15:13)
> > > On Mon, 2024-10-07 at 10:37 +0200, Matteo Martelli wrote:
> > > > Consumers need to call the read_avail_release_resource after readin=
g the
> > > > available info. To call the release with info_exists locked, copy t=
he
> > > > available info from the producer and immediately call its release
> > > > callback. With this change, users of iio_read_avail_channel_raw() a=
nd
> > > > iio_read_avail_channel_attribute() must free the copied avail info =
after
> > > > calling them.
> > > >=20
> > > > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> > > > ---
> > > > =C2=A0drivers/iio/inkern.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 64 +++++++++++++++++++++++++++++++++------
> > > > -----
> > > > =C2=A0include/linux/iio/consumer.h |=C2=A0 4 +--
> > > > =C2=A02 files changed, 50 insertions(+), 18 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > > > index
> > > > 7f325b3ed08fae6674245312cf8f57bb151006c0..cc65ef79451e5aa2cea447e16=
8007a44
> > > > 7ffc0d91
> > > > 100644
> > > > --- a/drivers/iio/inkern.c
> > > > +++ b/drivers/iio/inkern.c
> > > > @@ -760,9 +760,25 @@ static int iio_channel_read_avail(struct iio_c=
hannel
> > > > *chan,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!iio_channel_has_available(chan-=
>channel, info))
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return -EINVAL;
> > > > =C2=A0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_info->read_avail)
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return iio_info->read_avail(chan->indio_dev, chan->channel,
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0 vals, type, length, info);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_info->read_avail) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 const int *vals_tmp;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 int ret;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D iio_info->read_avail(chan->indio_dev, chan->channel,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0 &vals_tmp, type, length, info);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (ret < 0)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *vals =3D kmemdup_array(vals_tmp, *length, sizeof(int),
> > > > GFP_KERNEL);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!*vals)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> > > > +
> > >=20
> > > Not a big deal but I would likely prefer to avoid yet another copy. I=
f I'm
> > > understanding things correctly, I would rather create an inkern wrapp=
er API
> > > like=20
> > > iio_channel_read_avail_release_resource() - maybe something with a sm=
aller
> > > name :).
> > > Hence, the lifetime of the data would be only controlled by the produ=
cer of
> > > it. It
> > > would also produce a smaller diff (I think). I just find it a bit con=
fusing
> > > that we
> > > duplicate the data in here and the producer also duplicates it on the=
 -
> > > >read_avail()
> > > call. Another advantage I see is that often the available data is ind=
eed
> > > const in
> > > which case no kmemdup_array() is needed at all.
> >=20
> >=20
> > If I understand correctly your suggestion you would leave the inkern
> > iio_channel_read_avail() untouched, then add a new inkern wrapper, some=
thing
> > like iio_channel_read_avail_release_resource(), that would call the pro=
ducer's
> > read_avail_release_resource(). The consumer would invoke this new wrapp=
er in
> > its
> > own read_avail_release_resource() avoiding the additional copy. The cal=
l stack
> > would look something like the following:
> >=20
> > iio_read_channel_info_avail() {
> > =C2=A0=C2=A0=C2=A0 consumer->read_avail() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_read_avail_channel_raw()=
 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_=
channel_read_avail() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 producer->read_avail() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmemdup_array();
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0 }
> >=20
> > =C2=A0=C2=A0=C2=A0 iio_format_list();
> >=20
> > =C2=A0=C2=A0=C2=A0 consumer->read_avail_release_resource() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_read_avail_channel_relea=
se_resource() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prod=
ucer->read_avail_release_resource() {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 kfree();
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0 }
> > }
>=20
> Yeah, exactly what came to mind...
>=20
> >=20
> >=20
> > I was going with the simpler solution you described, but my concern wit=
h it
> > was
> > that the info_exists_lock mutex would be unlocked between a
> > iio_channel_read_avail()
> > call and its corresponding iio_channel_read_avail_release_resource() ca=
ll.
> > To my understanding, this could potentially allow for the device to be
> > unregistered between the two calls and result in a memleak of the avail=
 buffer
> > allocated by the producer.
> >=20
> > However, I have been trying to reproduce a similar case by adding a del=
ay
> > between the consumer->read_avail() and the
> > consumer->read_avail_release_resources(), and by unbinding the driver d=
uring
> > that delay, thus with the info_exists_lock mutex unlocked. In this case=
 the
> > driver is not unregistered until the iio_read_channel_info_avail() func=
tion
> > completes, likely because of some other lock on the sysfs file after th=
e call
> > of
> > cdev_device_del() in iio_device_unregister().
> >=20
>=20
> Yes, you need to have some sync point at the kernfs level otherwise we co=
uld
> always be handling a sysfs attr while the device is being removed under o=
ur
> feet. But I'm not sure what you're trying to do... IIUC, the problem migh=
t come
> if have:
>=20
> consumer->read_avail_channel_attribute()
>         producer->info_lock()
>         producer->read_avail()
>                 producer->kmalloc()
>=20
> ...
> // producer unbound
> ...
> consumer->read_avail_release()
>         return -ENODEV;
>=20
> // producer->kmalloc() never get's freed...
>=20
> The above is your problem right? And I think it should be a valid one sin=
ce
> between ->read_avail_channel_attribute() and read_avail_release() there's
> nothing preventing the producer from being unregistered...

Yes, that's the problem.

>=20
> If I'm not missing nothing one solution would be for the producer to do
> devm_kmalloc() and devm_kfree() on read_avail() and release_resources() b=
ut at
> that point I'm not sure it's better than what you have since it's odd eno=
ugh for
> being missed in reviews...

I honestly didn't think of this and it would in fact prevent the
additional copy. But I agree that it could be missed in new drivers,
maybe a comment in the iio_info read_avail_release_resource() callback
declaration would help?

>=20
> Anyways, I'm fine with this approach but then I would likely have a comme=
nt on
> this extra allocation explaining what is being protected with it as it's =
not
> straight to realize the subtle race with the producer being gone between =
calls.
>=20
> > Are there are other cases in which the device could be unregistered bet=
ween
> > the
> > two calls? If the info_exists_lock mutex is not necessary for this
> > read_avail()
> > flow then I could switch it to the simpler solution without the additio=
nal
> > consumer
> > copy, but at that point I would question why the info_exists_lock mutex=
 is
> > being
> > locked in iio_read_avail_channel_raw().
> >=20
> > For some additional context see also my previous conversation with Jona=
than on
> > the subject [1]. I followed Jonathan's suggestion to keep the implement=
ation
> > simple by letting the consumer to always copy the producer buffer, but =
I could
> > also consider different solutions.
> >=20
> > Regarding the release function names being too long, I totally agree an=
d I
> > would also
> > shorten the iio_info read_avail_release_resource() callback if that rem=
ains
> > clear: something like read_avail_release_res() or just read_avail_relea=
se()?
> >=20
> > Link:
> > https://lore.kernel.org/linux-iio/20240810105411.705cb225@jic23-huawei/=
=C2=A0[1]
> >=20
>=20
> Yups, I should have checked v1...

Just to clarify, that link is not the v1 of this patch set but a
previous conversation during the pac1921 driver implementation.

>=20
> - Nuno S=C3=A1

Thanks,
Matteo Martelli

