Return-Path: <linux-iio+bounces-10318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5717A9940A9
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 10:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F093B28AB2F
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 08:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EF720605E;
	Tue,  8 Oct 2024 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhCC+LFz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E03206045;
	Tue,  8 Oct 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372304; cv=none; b=YozWrgZ/IPcfwKq2D5wEebqGdELwZ8pLng7iuyVaCljHB//c284ipTd+be/0abEAiIau1gS1O4wpGNJW5Fl5CYUA+qavBElwKUXQ9txbumeZBNFoPokI0903Ui0fWsu6e0uWOCnWDTmk98fd46cwv0FFAaIN16eqdo4Yv3xSkbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372304; c=relaxed/simple;
	bh=ZXLe9zHq7pTDiZ8GsAjK7HK91GpqFvnUcZ4/9COX4tU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VozqIvlxTwksuBKYrAb60WcD5wa6eC0A3IEWuTtKX0RTOLYyaCVYnuPLmwJ8zmkcERT0j2FeXxUfVQvX4OYHsYSc1CskX/4261XX9MK0ViXHhvEWaVEn5YoXpXK3j4KUyQAPkDaUc8uHF3IM0jac3z/mfzA4dMjdyWd1NGPq5tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhCC+LFz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso70962565e9.2;
        Tue, 08 Oct 2024 00:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728372300; x=1728977100; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cMWWoAUqFrcFH4zXedO1Hb3ZRSMfw9UzKY6slVwevyA=;
        b=JhCC+LFzE15xeX5QwhPUbpXmHpzP9inPIL1INoluISuB2Bq5BoGmWVYCBj7N+z+2EE
         WGXl+of8nrFuiggtXiArkcAFwNKfh1+fC39gX+sd8EULsLjqWOgEqdOzt2GJiNgcEql5
         kxMgZ/anwLTDUJudW1qceq3Hn8N6nvlF9Tb6sgOE4syDJM11XkHqCD+jZQGqzH7DuDmT
         +srsrx3QkjlGCefXSmrFEVPMUMd6dlouzbSQ3enP70zYw1eSApJPOajasTynCDsNNWee
         2aJl6jRoVQVNzbpy2Qy1tsN1QOoOO3NtPFWZuY7MkFA5OUKUVlO+RB+SZJ7Kx7TnEpKW
         PihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728372300; x=1728977100;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMWWoAUqFrcFH4zXedO1Hb3ZRSMfw9UzKY6slVwevyA=;
        b=Q8/Nf5UgKVv0uK80NJ53AXzhKFcNLCNpkC9u8SkVkPmeJgWn4iIVj9O3EcWqeHxAus
         s1xG2cSps5m41MQpSFlGDbJGGfZsPMbUH2HX1700m0cX8BuYFVLB1Xjj7H69PEcYXyg8
         5MkfGPTmoAxpg0fiBPpH/6ZWHZ2OWId8BCdSGQ/mltdbIroU15UtLkQiDsU6urjKC98D
         O2pNoBLoexh4lyZDo8VcCgz53z7KCTtLrpswChnzQNvXL94kUGj2cKc3xHDuRgeXY9gR
         6VgALvyFwHylTY7sZRPtccH7mS+bIe2o+T2BPhGJi0cjnYE7+PbH+yfJDqB3b1hTaldF
         xM5w==
X-Forwarded-Encrypted: i=1; AJvYcCUGBm1a+Qo/NEAad/Dnnb3Ty5OTSeYO0XUH0u9nUvyNplAjmZQeW4H1Sn1hCz+V1rH18wWmlmgwxKQ=@vger.kernel.org, AJvYcCXLu1CLCAT3uQbODVnoO9CT5Z69Vn79wAcmmNE+SFdU5vlAoYysL3tD0SuMYATdl8B/o7BwTzdBFQMcF9k=@vger.kernel.org, AJvYcCXg6D3Ka0AeuCKq/7n/EFfh1B7h8oBK48+0kOljxTU4N0PF/Shn3vBTAgFqO9ttZCRAi2NPJmyLQmMsEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKA7cm+gq6KtNdK6Xy2GaGP0cVAMaY/YVdy0bET94q4xJysYtz
	6gzzPfohAUFp18ufv9ts0Pz9i48u5wYptg+bFV/So8xrGRfsjTdqmNvXviEbjm4=
X-Google-Smtp-Source: AGHT+IErwcMkXCUbwdqNXfeu60hB8B8g+AL32adsrJ19kcSUUOCxEBAYnLqENuoixgoHJaGbZ807+w==
X-Received: by 2002:a05:600c:35c9:b0:42e:8d0d:bc95 with SMTP id 5b1f17b1804b1-42f85a6e147mr126535785e9.6.1728372300355;
        Tue, 08 Oct 2024 00:25:00 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef02:2700:7b7e:80b8:b4bb:6d07? (p200300f6ef0227007b7e80b8b4bb6d07.dip0.t-ipconnect.de. [2003:f6:ef02:2700:7b7e:80b8:b4bb:6d07])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4a371sm116148285e9.42.2024.10.08.00.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:25:00 -0700 (PDT)
Message-ID: <8241b4caf9ebacb116f50bfe1503f325cc576066.camel@gmail.com>
Subject: Re: [PATCH v2 5/7] iio: inkern: copy/release available info from
 producer
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Matteo Martelli <matteomartelli3@gmail.com>, Alisa-Dariana Roman	
 <alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Jonathan
 Cameron	 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich	 <Michael.Hennerich@analog.com>, Paul Cercueil
 <paul@crapouillou.net>, Peter Rosin <peda@axentia.se>, Sebastian Reichel
 <sre@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
Date: Tue, 08 Oct 2024 09:29:14 +0200
In-Reply-To: <172837007815.3337.5869213289160447430@njaxe.localdomain>
References: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
	 <20241007-iio-read-avail-release-v2-5-245002d5869e@gmail.com>
	 <8a5f6f12c2cb6989cef1d09957fc0f6f7a512b26.camel@gmail.com>
	 <172837007815.3337.5869213289160447430@njaxe.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-08 at 08:47 +0200, Matteo Martelli wrote:
> Quoting Nuno S=C3=A1 (2024-10-07 17:15:13)
> > On Mon, 2024-10-07 at 10:37 +0200, Matteo Martelli wrote:
> > > Consumers need to call the read_avail_release_resource after reading =
the
> > > available info. To call the release with info_exists locked, copy the
> > > available info from the producer and immediately call its release
> > > callback. With this change, users of iio_read_avail_channel_raw() and
> > > iio_read_avail_channel_attribute() must free the copied avail info af=
ter
> > > calling them.
> > >=20
> > > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> > > ---
> > > =C2=A0drivers/iio/inkern.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 64 +++++++++++++++++++++++++++++++++------
> > > -----
> > > =C2=A0include/linux/iio/consumer.h |=C2=A0 4 +--
> > > =C2=A02 files changed, 50 insertions(+), 18 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > > index
> > > 7f325b3ed08fae6674245312cf8f57bb151006c0..cc65ef79451e5aa2cea447e1680=
07a44
> > > 7ffc0d91
> > > 100644
> > > --- a/drivers/iio/inkern.c
> > > +++ b/drivers/iio/inkern.c
> > > @@ -760,9 +760,25 @@ static int iio_channel_read_avail(struct iio_cha=
nnel
> > > *chan,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!iio_channel_has_available(chan->c=
hannel, info))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return -EINVAL;
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_info->read_avail)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return iio_info->read_avail(chan->indio_dev, chan->channel,
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0 vals, type, length, info);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_info->read_avail) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 const int *vals_tmp;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 int ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D iio_info->read_avail(chan->indio_dev, chan->channel,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0 &vals_tmp, type, length, info);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (ret < 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *vals =3D kmemdup_array(vals_tmp, *length, sizeof(int),
> > > GFP_KERNEL);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!*vals)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> > > +
> >=20
> > Not a big deal but I would likely prefer to avoid yet another copy. If =
I'm
> > understanding things correctly, I would rather create an inkern wrapper=
 API
> > like=20
> > iio_channel_read_avail_release_resource() - maybe something with a smal=
ler
> > name :).
> > Hence, the lifetime of the data would be only controlled by the produce=
r of
> > it. It
> > would also produce a smaller diff (I think). I just find it a bit confu=
sing
> > that we
> > duplicate the data in here and the producer also duplicates it on the -
> > >read_avail()
> > call. Another advantage I see is that often the available data is indee=
d
> > const in
> > which case no kmemdup_array() is needed at all.
>=20
>=20
> If I understand correctly your suggestion you would leave the inkern
> iio_channel_read_avail() untouched, then add a new inkern wrapper, someth=
ing
> like iio_channel_read_avail_release_resource(), that would call the produ=
cer's
> read_avail_release_resource(). The consumer would invoke this new wrapper=
 in
> its
> own read_avail_release_resource() avoiding the additional copy. The call =
stack
> would look something like the following:
>=20
> iio_read_channel_info_avail() {
> =C2=A0=C2=A0=C2=A0 consumer->read_avail() {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_read_avail_channel_raw() {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_ch=
annel_read_avail() {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 producer->read_avail() {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmemdup_array();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0 iio_format_list();
>=20
> =C2=A0=C2=A0=C2=A0 consumer->read_avail_release_resource() {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_read_avail_channel_release=
_resource() {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 produc=
er->read_avail_release_resource() {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 kfree();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0 }
> }

Yeah, exactly what came to mind...

>=20
>=20
> I was going with the simpler solution you described, but my concern with =
it
> was
> that the info_exists_lock mutex would be unlocked between a
> iio_channel_read_avail()
> call and its corresponding iio_channel_read_avail_release_resource() call=
.
> To my understanding, this could potentially allow for the device to be
> unregistered between the two calls and result in a memleak of the avail b=
uffer
> allocated by the producer.
>=20
> However, I have been trying to reproduce a similar case by adding a delay
> between the consumer->read_avail() and the
> consumer->read_avail_release_resources(), and by unbinding the driver dur=
ing
> that delay, thus with the info_exists_lock mutex unlocked. In this case t=
he
> driver is not unregistered until the iio_read_channel_info_avail() functi=
on
> completes, likely because of some other lock on the sysfs file after the =
call
> of
> cdev_device_del() in iio_device_unregister().
>=20

Yes, you need to have some sync point at the kernfs level otherwise we coul=
d
always be handling a sysfs attr while the device is being removed under our
feet. But I'm not sure what you're trying to do... IIUC, the problem might =
come
if have:

consumer->read_avail_channel_attribute()
	producer->info_lock()
	producer->read_avail()
		producer->kmalloc()

...
// producer unbound
...
consumer->read_avail_release()
	return -ENODEV;

// producer->kmalloc() never get's freed...

The above is your problem right? And I think it should be a valid one since
between ->read_avail_channel_attribute() and read_avail_release() there's
nothing preventing the producer from being unregistered...

If I'm not missing nothing one solution would be for the producer to do
devm_kmalloc() and devm_kfree() on read_avail() and release_resources() but=
 at
that point I'm not sure it's better than what you have since it's odd enoug=
h for
being missed in reviews...

Anyways, I'm fine with this approach but then I would likely have a comment=
 on
this extra allocation explaining what is being protected with it as it's no=
t
straight to realize the subtle race with the producer being gone between ca=
lls.

> Are there are other cases in which the device could be unregistered betwe=
en
> the
> two calls? If the info_exists_lock mutex is not necessary for this
> read_avail()
> flow then I could switch it to the simpler solution without the additiona=
l
> consumer
> copy, but at that point I would question why the info_exists_lock mutex i=
s
> being
> locked in iio_read_avail_channel_raw().
>=20
> For some additional context see also my previous conversation with Jonath=
an on
> the subject [1]. I followed Jonathan's suggestion to keep the implementat=
ion
> simple by letting the consumer to always copy the producer buffer, but I =
could
> also consider different solutions.
>=20
> Regarding the release function names being too long, I totally agree and =
I
> would also
> shorten the iio_info read_avail_release_resource() callback if that remai=
ns
> clear: something like read_avail_release_res() or just read_avail_release=
()?
>=20
> Link:
> https://lore.kernel.org/linux-iio/20240810105411.705cb225@jic23-huawei/=
=C2=A0[1]
>=20

Yups, I should have checked v1...

- Nuno S=C3=A1
>=20

