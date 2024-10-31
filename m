Return-Path: <linux-iio+bounces-11690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794719B79A7
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 12:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5DB1C20CD2
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 11:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2234219AD90;
	Thu, 31 Oct 2024 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd/IPDcH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A3719ABD1;
	Thu, 31 Oct 2024 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373990; cv=none; b=cIG/30W/ryNE+r2YRNAtQr1vdg6H7Reo/NZzXMvL47zFUs9hSRnUoRbnIa7DeBDvTJ7X+se9Ea0M5IthsVXH5acThH1jQllFz+4AyikFxhuejaLipQzxrM1DsrIlKvlMNfHK0ZS+qzxoh8XJoc+QCv0aYL4yH6a2j5Vn/0GKpFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373990; c=relaxed/simple;
	bh=hzudRnhY5g6fYzOL8bxyYrlk3c3jll8mroM69zcnwN8=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=V8MvxKM1NGYoRA4t7blljconWWajBnZfLMKwkRKxCz/q9I0u4tVnbWlW5wqJByVJK3RcSHfHoOxpchKj7yna2oMOzHYP44dmVwL32X8XErJLxRBk1NC9OAdzzPfpWw8tNcN4eNwE45qsK26Xq1Z/xYxOySANse575fnvDSib5X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fd/IPDcH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c9150f9ed4so1154602a12.0;
        Thu, 31 Oct 2024 04:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730373987; x=1730978787; darn=vger.kernel.org;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=du8RsPSSmfKdksX84UQ+FWRuhhilBEXtJldK005aAhw=;
        b=fd/IPDcH6PUzEI5G13DQe1XGk/9ZQKbc7FF9+RFZrAktrag4Ds0BqMnOXaFxoheKsu
         aq11VBVFEyPZLh5Lje/ljryOjTNpCz3T0lIWQZobOM2WBxg2PQEwCttkhLCOcBlRrozY
         +vuq4VfZnhquDxRJHYFwivTmTEeDvwmoG5YIhL9MIQEKtPrwFdjullCF9ylM4Pliir9k
         ysR+l+mJ32mqO0wlu31Itvwnv71vuyfDXujKtAvJgXHowWp9u8Q2dgXlHFlj3yBbr1Tp
         ICSLaeQ2q09D1DvOLah7On4y954kZymoX2ShY0+IEjHBZRq8e9MKvE8o8YXHAtchu/5o
         /gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730373987; x=1730978787;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=du8RsPSSmfKdksX84UQ+FWRuhhilBEXtJldK005aAhw=;
        b=HVtWZfCjaAge98DqdlLbqUzYP2AnQ/bG14T1rmpoUQ90q+Cc/tiLMMubg0/cKN0VPv
         H7nZTCkcOldUPgTtC3OxvFv00Zq3yERxR00x/b9Ur1f/ixDJxJBfbBSYHL//6i7W9fQA
         04sqGsKxu8+3ut6PI3cdyb5mnHlNlnQQlq/7NIe95F2ta3aVUpnaTvl8TZzy/mvEKUcd
         dJjZUjZvW/yun5Pi4xw7gXSu64e+Avqwfgg1pBl4kTK9mWJkCRafybl+SaU1ga2qbS+Q
         HY7iaTMxIbmKmNCy+YgStL/Be644drf/eFhxsLmW5vGDDlbS0jmKIzN2p5vAumNhLgch
         +spg==
X-Forwarded-Encrypted: i=1; AJvYcCVhhbDZycL6lpY08TA6Wca07lwEMMIshav8CklVedQmJbGnVdIhdUrMrYbyzqmA9z6ElsDRgy5eET9ahA==@vger.kernel.org, AJvYcCX+DolMKuR1vC4RQJ8dKEtJ78HT7GL57DK7SCqnODQX0H6pw66DlI63g0IyLmepWMzpBH1LTgMUIZtEIeKa@vger.kernel.org, AJvYcCX0ZEFzukkeQBI2O7x3p2+OdWM3+Gp2aJCaunlWCHTBpvcB0qI7EP9FstFAXsqZ1SdtyKJD4gBDrUM=@vger.kernel.org, AJvYcCXhjIsjjDHm3+E/+bFwRE/fa6ud9ys9vEfNK60j1O1o0uRPIS98jo+olr+AkJ3jS+JvE+ZPdHgNToo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtSzRJ+hi5RcvzhvDkWOrLT4oY9aePzidZ3WTGscJc27ptO3WV
	blDOT+2kvvpmRQIbIYSpMPsuUZ81suvIr65IfpReQ7IfPmlRtEkS
X-Google-Smtp-Source: AGHT+IGPM1ys92XJWy55iaMc+mkkiiSwTT3VmXdYtDiJ0hU+Inj8aTV0aI+/6k+hyeDL2q/6nruBXQ==
X-Received: by 2002:a05:6402:3481:b0:5c9:2a5a:5f0e with SMTP id 4fb4d7f45d1cf-5cbbf94abacmr14848930a12.28.1730373986367;
        Thu, 31 Oct 2024 04:26:26 -0700 (PDT)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac5cb8fbsm476840a12.0.2024.10.31.04.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 04:26:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241030203050.5cdf3450@jic23-huawei>
References: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com> <20241021-iio-read-avail-release-v5-2-b168713fab33@gmail.com> <ZyJHFp6vbQ7deLFs@black.fi.intel.com> <173031260171.39393.109639772708550094@njaxe.localdomain> <20241030203050.5cdf3450@jic23-huawei>
Subject: Re: [PATCH v5 2/5] iio: consumers: copy/release available info from producer to fix race
From: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Alisa-Dariana Roman <alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Date: Thu, 31 Oct 2024 12:26:24 +0100
Message-ID: <173037398492.12348.265826723028347056@njaxe.localdomain>
User-Agent: alot/0.11

Quoting Jonathan Cameron (2024-10-30 21:30:50)
> On Wed, 30 Oct 2024 19:23:21 +0100
> Matteo Martelli <matteomartelli3@gmail.com> wrote:
>=20
> > Quoting Andy Shevchenko (2024-10-30 15:47:50)
> > > On Mon, Oct 21, 2024 at 02:54:15PM +0200, Matteo Martelli wrote: =20
> > > > Consumers need to call the producer's read_avail_release_resource()
> > > > callback after reading producer's available info. To avoid a race
> > > > condition with the producer unregistration, change inkern
> > > > iio_channel_read_avail() so that it copies the available info from =
the
> > > > producer and immediately calls its release callback with info_exists
> > > > locked.
> > > >=20
> > > > Also, modify the users of iio_read_avail_channel_raw() and
> > > > iio_read_avail_channel_attribute() to free the copied available buf=
fers
> > > > after calling these functions. To let users free the copied buffer =
with
> > > > a cleanup pattern, also add a iio_read_avail_channel_attr_retvals()
> > > > consumer helper that is equivalent to iio_read_avail_channel_attrib=
ute()
> > > > but stores the available values in the returned variable. =20
> > >=20
> > > ...
> > >  =20
> > > > +static void dpot_dac_read_avail_release_res(struct iio_dev *indio_=
dev,
> > > > +                                         struct iio_chan_spec cons=
t *chan,
> > > > +                                         const int *vals, long mas=
k)
> > > > +{
> > > > +     kfree(vals);
> > > > +}
> > > > +
> > > >  static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > > >                             struct iio_chan_spec const *chan,
> > > >                             int val, int val2, long mask)
> > > > @@ -125,6 +132,7 @@ static int dpot_dac_write_raw(struct iio_dev *i=
ndio_dev,
> > > >  static const struct iio_info dpot_dac_info =3D {
> > > >       .read_raw =3D dpot_dac_read_raw,
> > > >       .read_avail =3D dpot_dac_read_avail,
> > > > +     .read_avail_release_resource =3D dpot_dac_read_avail_release_=
res,
> > > >       .write_raw =3D dpot_dac_write_raw,
> > > >  }; =20
> > >=20
> > > I have a problem with this approach. The issue is that we allocate
> > > memory in one place and must clear it in another. This is not well
> > > designed thingy in my opinion. I was thinking a bit of the solution a=
nd
> > > at least these two comes to my mind:
> > >=20
> > > 1) having a special callback for .read_avail_with_copy (choose better
> > > name) that will dump the data to the intermediate buffer and clean it
> > > after all;
> > >=20
> > > 2) introduce a new type (or bit there), like IIO_AVAIL_LIST_ALLOC. =20
> >=20
> > Could you elaborate more about these potential solutions? Maybe with so=
me
> > usage examples?
> >=20
> > If I get it correctly, in both cases you are suggesting to pass ownersh=
ip
> > of the vals buffer to the caller, iio_read_channel_info_avail() in this
> > case, so that it would take care of freeing the buffer after calling
> > iio_format_after_*(). We considered this approach during an initial
> > discussion with Jonathan (see read_avail_ext() in [1]), where he sugges=
ted
> > to let the driver keep the release control through a callback for two
> > reasons:
> >=20
> > 1) Apparently it's a bad pattern to pass the buffer ownership to the co=
re,
> >    maybe Jonathan can elaborate why? The risk I can think of is that th=
e driver
> >    could still keep the buffer copy in its private data after giving it=
 away,
> >    resulting in fact in a double ownership. However I think it would be=
 clear
> >    enough in this case that the copy should be handled by the caller, o=
r maybe
> >    not?
> Mostly the lack of desire to have to copy for the 95% of cases where it's
> not needed and that it prevents any optimization like you mention.

I think the suggestion here is to add an additional .read_avail_with_copy()
without replacing the original .read_avail(), so all the current drivers th=
at
use a constant avail list would not be affected. And I think this was the s=
ame
idea for the additional read_avail_ext() or the additional argument for the
read_avail() we were considering in [1]. So I would think that
iio_read_channel_info_avail() would do something like the following:

    if (indio_dev->info->read_avail_with_copy)
        indio_dev->info->read_avail_with_copy(vals);
    else
        indio_dev->info->read_avail(vals);

    ...
    iio_format_avail_list(vals);
    ...

    if (indio_dev->info->read_avail_with_copy)
        kfree(vals);

And the drivers would choose whether to define the read_avail or the
read_avail_with_copy.

What I was referring to is that, back then, you mentioned you would have
preferred to avoid passing ownership of the buffer around:

> That's a corner case we should think about closing. Would require an indi=
cator
> to read_avail that the buffer it has been passed is a snapshot that it sh=
ould
> free on completion of the string building.  I don't like passing ownership
> of data around like that, but it is fiddly to do anything else given
> any simple double buffering is subject to race conditions.

I guess there is some other reason other than avoiding the copy when not
necessary, since by introducing an additional function or argument or return
type, most of the unnecessary copies would already be avoided right?

Anyway any of this solutions would still prevent the potential optimization=
s of
point 2). It's worth mentioning that those kind of optimizations are curren=
tly
not adopted by any driver.

>=20
> Jonathan
> >=20
> > 2) Some driver might want to avoid allocating a new copy of a big table=
 if
> >    the race does not occur (e.g. with additional checks on buffer access
> >    code) and thus wouldn't call a free() in the release callback.
> >=20
> > >=20
> > > In any case it looks fragile and not scalable. I propose to drop this
> > > and think again. =20
> >=20
> > I see your concerns, I am open to reconsider this in case we come up wi=
th
> > better solution after addressing the points above.
> >=20
> > > Yes, yes, I'm fully aware about the problem you are trying to solve a=
nd
> > > agree on the report, I think this solution is not good enough.
> > >=20
> > > --=20
> > > With Best Regards,
> > > Andy Shevchenko
> > >  =20
> >=20
> > [1]: https://lore.kernel.org/linux-iio/20240729211100.0d602d6e@jic23-hu=
awei/
> >=20
> > Best regards,
> > Matteo Martelli
>=20

I hope I've brought a little more clarity to the discussion by providing so=
me
history instead of making it more confusing.

Best regards,
Matteo Martelli

