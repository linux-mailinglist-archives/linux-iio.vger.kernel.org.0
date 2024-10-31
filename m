Return-Path: <linux-iio+bounces-11715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EB59B8241
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 19:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789E21F234A8
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 18:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BE11C6F6A;
	Thu, 31 Oct 2024 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlFkgtPT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A9E1CCECE;
	Thu, 31 Oct 2024 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397998; cv=none; b=Zqug/QnKUT9/lmnmmaJWBck+tu13C2nK/VsaAxzbdm/1ux+JH3Sfnxwnm2ZhakSmhvrT9cEcV9kAEtR1Taxd9JxjLCkokXBkPZ6hyPCh6b8rTmitv7nNKB+rIX7L0EEEtFwNsj2GBxCw2dCbrq2hTsxqC/xQuOJusqvhzzAqB0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397998; c=relaxed/simple;
	bh=wxOVPQhRYb1iDlKXA4T7AwTmfbZcpiZz8ZtU2fyP62E=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=C+EUvUA0RNiDt/XheDu8cvWP/qCOMlRkA8JYYloeMFcs61XxPBIZo2Ul/jQqIAdjgNmsfBeuPb8gt8cTK1j+Yqh0ltHwT/IEbsCGnVHXjXlXnn8TBBVZWZqG7yXOnfjwCUKzpa6fWY7+s4fyZT7YrmJgfEpC/KjMzlKuBG5AQvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlFkgtPT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4314f38d274so13121355e9.1;
        Thu, 31 Oct 2024 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730397994; x=1731002794; darn=vger.kernel.org;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3lnnC+pFR+QFMKreyZ9bKF9fzIqUa9dKroNneh+ewM=;
        b=NlFkgtPTY0LIpWBwIA702wiNJCIXfUZU/3GzkbMxtYnR/DmaHW1o+6OEsKZURle303
         R3g+4R2kzzLA7mVPYcFoi+gY/GVwsTQsz3as/ms2J/8FIRwErsX0qBn3Gxvm3w8CbdcN
         jd2Y2iyMP7X5xLF++roRc2wT34vBgzQf2kgiVbeIH+bivKuSV7gGdAuGKIB2d/nDZgfo
         +gn+dhQIbPLBf5FWglz96VTwThfTmmNsfs7heMlpFMZv84+geS7z/tFrhE0tDgOcfYpE
         lw8yEGB4KYQAzi/Liqy/RAXMYOf6p2kFFROM9EiOf0OCOUV7NN9FOaezpcuVwc2Yhzi8
         0IRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730397994; x=1731002794;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3lnnC+pFR+QFMKreyZ9bKF9fzIqUa9dKroNneh+ewM=;
        b=H9e7yiZagxUuAm+gyc3t2u8M1reHAEgmnTrfOrcAFlNCXDomFme12B7oEx0mKPlVGA
         6RlXqrpYSk2fbF0ZKzRyyykXd881lbWDdntHgxec2ZszkY/WC9lZNya+91dHtOubNxq6
         uVJaSdP1VfhiYwTc6sPQynhEpCakiqG6jYscElwrfiHpJgSQrTJhYwdFisCQH1glQu0V
         Qcf+72mSWsW/oBDffEdpvYne0VMgH6FOLFb6wZXtLucsY5AnxisqkwYWH14kM13OWJxl
         5kKf0+24faigJMpZxg4MRDeFlEbfz/2Ku0CWAHfzIHnG+bPivON1mOz1cf37clxyA9mq
         rxew==
X-Forwarded-Encrypted: i=1; AJvYcCUBpDTPzgoYcs/F6ig2Tt2mtJ/agMFerZM1YoIgddzUZrRcmVokvQKzeOp3Sqfl5V2c2boR/XkQgB9whQMC@vger.kernel.org, AJvYcCVJmuPJNmgzLZgkKqnoHNuZi8q0l6RAeShVIRfNA+paZZLp6wKCA7bOBivOtvFrV5hLp8M6aAxkQhjrIw==@vger.kernel.org, AJvYcCW3magkIYWIh6rGbP9iRgWKjkSq1xAILuZEA7jrK4nBFR0GaDqfPfDmvLVO2GBQaNTGp+xDVv1X41w=@vger.kernel.org, AJvYcCX2WWuwUowIE38Io7gojpdcnQrfMsBpwz2Zxm0zaVN/cIMO0GL7yJDljrdO3FdQpAWhqDH1G29QX4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg88LMME5p2m5X7iYpzSrRj4XSW1z5GT+Q0wt5Gy3IacGoZReA
	41edPfcBTvkGVIWSFM+/rEZL7GLRh8d8KUiTZI9oACiVvJ7HCZxo
X-Google-Smtp-Source: AGHT+IHF4dqb16+F0GrJw71R8xWPsQC/3CP23zmShE4vP2rt3Ldmjh5Y2W2r8AEs7luO7M/dal47cw==
X-Received: by 2002:a05:600c:3d8a:b0:42b:ac3d:3abc with SMTP id 5b1f17b1804b1-4328327e0bemr7717045e9.24.1730397993475;
        Thu, 31 Oct 2024 11:06:33 -0700 (PDT)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7c38sm2812874f8f.24.2024.10.31.11.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 11:06:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241031143129.0000014e@Huawei.com>
References: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com> <20241021-iio-read-avail-release-v5-2-b168713fab33@gmail.com> <ZyJHFp6vbQ7deLFs@black.fi.intel.com> <173031260171.39393.109639772708550094@njaxe.localdomain> <20241030203050.5cdf3450@jic23-huawei> <173037398492.12348.265826723028347056@njaxe.localdomain> <20241031143129.0000014e@Huawei.com>
Subject: Re: [PATCH v5 2/5] iio: consumers: copy/release available info from producer to fix race
From: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Alisa-Dariana Roman <alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date: Thu, 31 Oct 2024 19:06:32 +0100
Message-ID: <173039799203.1353.4404042832923090619@njaxe.localdomain>
User-Agent: alot/0.11

Quoting Jonathan Cameron (2024-10-31 15:31:29)
> On Thu, 31 Oct 2024 12:26:24 +0100
> Matteo Martelli <matteomartelli3@gmail.com> wrote:
>=20
> > Quoting Jonathan Cameron (2024-10-30 21:30:50)
> > > On Wed, 30 Oct 2024 19:23:21 +0100
> > > Matteo Martelli <matteomartelli3@gmail.com> wrote:
> > >  =20
> > > > Quoting Andy Shevchenko (2024-10-30 15:47:50) =20
> > > > > On Mon, Oct 21, 2024 at 02:54:15PM +0200, Matteo Martelli wrote: =
  =20
> > > > > > Consumers need to call the producer's read_avail_release_resour=
ce()
> > > > > > callback after reading producer's available info. To avoid a ra=
ce
> > > > > > condition with the producer unregistration, change inkern
> > > > > > iio_channel_read_avail() so that it copies the available info f=
rom the
> > > > > > producer and immediately calls its release callback with info_e=
xists
> > > > > > locked.
> > > > > >=20
> > > > > > Also, modify the users of iio_read_avail_channel_raw() and
> > > > > > iio_read_avail_channel_attribute() to free the copied available=
 buffers
> > > > > > after calling these functions. To let users free the copied buf=
fer with
> > > > > > a cleanup pattern, also add a iio_read_avail_channel_attr_retva=
ls()
> > > > > > consumer helper that is equivalent to iio_read_avail_channel_at=
tribute()
> > > > > > but stores the available values in the returned variable.   =20
> > > > >=20
> > > > > ...
> > > > >    =20
> > > > > > +static void dpot_dac_read_avail_release_res(struct iio_dev *in=
dio_dev,
> > > > > > +                                         struct iio_chan_spec =
const *chan,
> > > > > > +                                         const int *vals, long=
 mask)
> > > > > > +{
> > > > > > +     kfree(vals);
> > > > > > +}
> > > > > > +
> > > > > >  static int dpot_dac_write_raw(struct iio_dev *indio_dev,
> > > > > >                             struct iio_chan_spec const *chan,
> > > > > >                             int val, int val2, long mask)
> > > > > > @@ -125,6 +132,7 @@ static int dpot_dac_write_raw(struct iio_de=
v *indio_dev,
> > > > > >  static const struct iio_info dpot_dac_info =3D {
> > > > > >       .read_raw =3D dpot_dac_read_raw,
> > > > > >       .read_avail =3D dpot_dac_read_avail,
> > > > > > +     .read_avail_release_resource =3D dpot_dac_read_avail_rele=
ase_res,
> > > > > >       .write_raw =3D dpot_dac_write_raw,
> > > > > >  };   =20
> > > > >=20
> > > > > I have a problem with this approach. The issue is that we allocate
> > > > > memory in one place and must clear it in another. This is not well
> > > > > designed thingy in my opinion. I was thinking a bit of the soluti=
on and
> > > > > at least these two comes to my mind:
> > > > >=20
> > > > > 1) having a special callback for .read_avail_with_copy (choose be=
tter
> > > > > name) that will dump the data to the intermediate buffer and clea=
n it
> > > > > after all;
> > > > >=20
> > > > > 2) introduce a new type (or bit there), like IIO_AVAIL_LIST_ALLOC=
.   =20
> > > >=20
> > > > Could you elaborate more about these potential solutions? Maybe wit=
h some
> > > > usage examples?
> > > >=20
> > > > If I get it correctly, in both cases you are suggesting to pass own=
ership
> > > > of the vals buffer to the caller, iio_read_channel_info_avail() in =
this
> > > > case, so that it would take care of freeing the buffer after calling
> > > > iio_format_after_*(). We considered this approach during an initial
> > > > discussion with Jonathan (see read_avail_ext() in [1]), where he su=
ggested
> > > > to let the driver keep the release control through a callback for t=
wo
> > > > reasons:
> > > >=20
> > > > 1) Apparently it's a bad pattern to pass the buffer ownership to th=
e core,
> > > >    maybe Jonathan can elaborate why? The risk I can think of is tha=
t the driver
> > > >    could still keep the buffer copy in its private data after givin=
g it away,
> > > >    resulting in fact in a double ownership. However I think it woul=
d be clear
> > > >    enough in this case that the copy should be handled by the calle=
r, or maybe
> > > >    not? =20
> > > Mostly the lack of desire to have to copy for the 95% of cases where =
it's
> > > not needed and that it prevents any optimization like you mention. =20
> >=20
> > I think the suggestion here is to add an additional .read_avail_with_co=
py()
> > without replacing the original .read_avail(), so all the current driver=
s that
> > use a constant avail list would not be affected. And I think this was t=
he same
> > idea for the additional read_avail_ext() or the additional argument for=
 the
> > read_avail() we were considering in [1]. So I would think that
> > iio_read_channel_info_avail() would do something like the following:
> >=20
> >     if (indio_dev->info->read_avail_with_copy)
> >         indio_dev->info->read_avail_with_copy(vals);
> >     else
> >         indio_dev->info->read_avail(vals);
> >=20
> >     ...
> >     iio_format_avail_list(vals);
> >     ...
> >=20
> >     if (indio_dev->info->read_avail_with_copy)
> >         kfree(vals);
>=20
> Ok, sure that would work, but...
>=20
> I don't really see this as being much less fragile than
> the existing solution + in cases that we do have where
> only some available are not const we will have to copy them
> all.
>=20
> If anything it's more complex than making it a driver problem
> to provide the release call however it wants to do it.
> =20
>=20
> >=20
> > And the drivers would choose whether to define the read_avail or the
> > read_avail_with_copy.
> >=20
> > What I was referring to is that, back then, you mentioned you would have
> > preferred to avoid passing ownership of the buffer around:
> >=20
> > > That's a corner case we should think about closing. Would require an =
indicator
> > > to read_avail that the buffer it has been passed is a snapshot that i=
t should
> > > free on completion of the string building.  I don't like passing owne=
rship
> > > of data around like that, but it is fiddly to do anything else given
> > > any simple double buffering is subject to race conditions. =20
> >=20
> > I guess there is some other reason other than avoiding the copy when not
> > necessary, since by introducing an additional function or argument or r=
eturn
> > type, most of the unnecessary copies would already be avoided right?
>=20
> It's not a strong reason beyond limiting scope of clever design +
> the key bit my mind is that the above is not substantially simpler and
> reduces our flexibility.
>=20
> >=20
> > Anyway any of this solutions would still prevent the potential optimiza=
tions of
> > point 2). It's worth mentioning that those kind of optimizations are cu=
rrently
> > not adopted by any driver.
>=20
> That one indeed not, but mixing dynamic and non dynamic is something
> you do in your pac1921 patch.

Good point! I didn't think about it, or more likely I forgot, that with an
additional read_avail_with_copy() used as in the example you cannot mix dyn=
amic
and non dynamic available lists, thus those drivers that need at least one
dynamic available list would always copy all of them as they need to rely to
the read_avail_with_copy(). I guess this could be worked around with an
additional return argument for the read_avail() or an additional type like =
the
IIO_AVAIL_LIST_ALLOC suggested by Andy to signal the caller it needs to free
the list after use. However, I think they would introduce a more invasive
change in the current API compared to an additional optional callback, so I
agree that the current release callback is still a better option.

>=20
> Jonathan
>=20
>=20
> >=20
> > >=20
> > > Jonathan =20
> > > >=20
> > > > 2) Some driver might want to avoid allocating a new copy of a big t=
able if
> > > >    the race does not occur (e.g. with additional checks on buffer a=
ccess
> > > >    code) and thus wouldn't call a free() in the release callback.
> > > >  =20
> > > > >=20
> > > > > In any case it looks fragile and not scalable. I propose to drop =
this
> > > > > and think again.   =20
> > > >=20
> > > > I see your concerns, I am open to reconsider this in case we come u=
p with
> > > > better solution after addressing the points above.
> > > >  =20
> > > > > Yes, yes, I'm fully aware about the problem you are trying to sol=
ve and
> > > > > agree on the report, I think this solution is not good enough.
> > > > >=20
> > > > > --=20
> > > > > With Best Regards,
> > > > > Andy Shevchenko
> > > > >    =20
> > > >=20
> > > > [1]: https://lore.kernel.org/linux-iio/20240729211100.0d602d6e@jic2=
3-huawei/
> > > >=20
> > > > Best regards,
> > > > Matteo Martelli =20
> > >  =20
> >=20
> > I hope I've brought a little more clarity to the discussion by providin=
g some
> > history instead of making it more confusing.
>=20
> Sure, the code example in particular is useful.
>=20
> Jonathan
>=20
> >=20
> > Best regards,
> > Matteo Martelli
> >=20
> >=20
>=20
Best regards,
Matteo Martelli

