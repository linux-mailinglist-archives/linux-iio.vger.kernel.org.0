Return-Path: <linux-iio+bounces-10530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1EC99B798
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 01:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17AB8B21A45
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 23:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E201865EB;
	Sat, 12 Oct 2024 23:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7pT0aPO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99B317BB6;
	Sat, 12 Oct 2024 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728774562; cv=none; b=g0SXe/SklA1KVFe9udj5D5FGMkHDuUeXfR1pPqUlVRcFgZ+fGLKM9XlaSKGz+qP2mLkqH2o2pgmnZ9I9HrshEekiVU86zbUfH/Y6RcFUaaRLOrA6+7HcVYuF+ZM2+BruiyekiDEG9amiR2cdof8ljHu/Tyb8bQ3jeYc3RDlFFAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728774562; c=relaxed/simple;
	bh=X2G10R/0PxmXYZxFKFmo/9U84W41tyE0fYoLydTGkVE=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=mgQo19UMRBxZFeAQ7Yx4K0W/kPgmPpGaT+qzMtYpEmgxJm6GXtAtLOZnwADYQkgbvMf6dASqPb0tbDp7bi49wK4uQYkftQ2Neq1SmEO4svn5Abw6yVFEYssXpCJAR+lUJs/GQhIsnnLY3NtZ75/LCaCc1COcsingBdNspG/oM+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7pT0aPO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4305724c12eso23127235e9.1;
        Sat, 12 Oct 2024 16:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728774559; x=1729379359; darn=vger.kernel.org;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCUZOy1BInIakzu5sRNEavZXMvkvr+y+Hy3cQ7OeH/Q=;
        b=H7pT0aPOuj0dkWosa0FkykzrDtXYshnPpotH4beMsxp34xGmKYZp8Qq1Q9hMHaruF0
         v+pT512TIH5F1muIW+tJp+oGvB3IRGJXCgocisIvTB7AznbtmF5Dq/dpcR+EGtZcLb97
         0n788+PKBfY/6TdHCIcfmqg0SSGTk83RVADcpwyWSYZxfosg50us4sfATbbj49zJlVeo
         HTMIrxfJGHarFzGvhNg7EFQ+Stxa93xPr2/BpLiw51W1DD4Snf3KC+pHlL7dgevIz7oR
         m23/uMrMukkGwknuUos9enNcTyymWDOHmurBTlirHSE9j7LPER2F5LbrwNKsv4AAKU7k
         Z0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728774559; x=1729379359;
        h=user-agent:message-id:date:to:cc:from:subject:references
         :in-reply-to:content-transfer-encoding:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BCUZOy1BInIakzu5sRNEavZXMvkvr+y+Hy3cQ7OeH/Q=;
        b=Z91NR2xBaunezIOVDisFNlY1Dsg4n4ZJcYjSzn0J7bX9dc20u2TleDHJLBoYK1BeHo
         M9AtEokHVnjMxazkhSlVTKwTiSrN1hmXzAi29slTkrblylKEVGo+grfNQbPEfhf2/lKL
         AnVQ4zfPZYhe/SIW4O0on/3kqzKJdBiAWYMgo+FTYrpRhuYdZLP9tRyiScroGkmDOMM1
         VFqFBELdy5105WuEAy4RJzJ4zyCEFQNTRhVkiok2yx5xmF6I6l0jYJoUm5zTGlbe/11X
         rAfhUbA4FGTpSvxVIhLbQxBE2jc9dv6yl90LZwMAqMd69ybkG3X6/45+i5cFpwhyykwa
         NrUA==
X-Forwarded-Encrypted: i=1; AJvYcCUMtfzOkUEk6fv9ASAabUnXQiNx1g7Y1xeMSLTm1WKhHBxBUk8Nhu0aVU16Y0rn2gCUthGoqAOZTxwqYw==@vger.kernel.org, AJvYcCUWoF3kAzE2rUPf1LV8M52AQ6tlcJkWFfEzzPoB/e0cKJVUUOPahh0QeHZyz9Xlxf9b/WSsvQOlCFU=@vger.kernel.org, AJvYcCWPL6CcNNfQdGPoFVxxv4rRJNKhoyTvC/9PHnR6fxDDY1AI8PqfJJIL9iOMsjH60+4SMeS/r8aZxxw=@vger.kernel.org, AJvYcCXUl5Vtq0t8l+Fk++y+/DyZ8ENaMjD9qfAscWhinB6ttQUUuoDu01cbDenXtrMCg49Wt/8zrHl++Gc6x85Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwQw8jqj5LLUluDpnVpZyQhp50IloMWJAqAwBJjY+2m7lXuwH/0
	qwGIvAUPWLxIso0LkZ2r3FWge9NED2EczT3Tc82CQmr9RpQW8w+Z
X-Google-Smtp-Source: AGHT+IGgx+MiTpsqn2yGXKbxBn3PS6mtb7EnowJuo/I+N82kA9pYbq/qVULg1YoK6B1lgfwr49X4xQ==
X-Received: by 2002:a05:600c:3acd:b0:426:6379:3b4f with SMTP id 5b1f17b1804b1-43125619c33mr28609125e9.31.1728774558785;
        Sat, 12 Oct 2024 16:09:18 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ff6d3sm77183915e9.12.2024.10.12.16.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 16:09:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241012164732.518f86a5@jic23-huawei>
References: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com> <20241007-iio-read-avail-release-v2-5-245002d5869e@gmail.com> <8a5f6f12c2cb6989cef1d09957fc0f6f7a512b26.camel@gmail.com> <172837007815.3337.5869213289160447430@njaxe.localdomain> <8241b4caf9ebacb116f50bfe1503f325cc576066.camel@gmail.com> <172837459910.12274.5022869861872605261@njaxe.localdomain> <27e0d7b2a70015300047d9388edc87a8ece0c0dc.camel@gmail.com> <172849861528.354008.17477801981314044908@njaxe.localdomain> <20241012164732.518f86a5@jic23-huawei>
Subject: Re: [PATCH v2 5/7] iio: inkern: copy/release available info from producer
From: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?q?S=C3=A1?= <noname.nuno@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Peter Rosin <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Date: Sun, 13 Oct 2024 01:09:16 +0200
Message-ID: <172877455634.1202.4959444122842083990@njaxe.localdomain>
User-Agent: alot/0.11

Quoting Jonathan Cameron (2024-10-12 17:47:32)
> On Wed, 09 Oct 2024 20:30:15 +0200
> Matteo Martelli <matteomartelli3@gmail.com> wrote:
>=20
> > Quoting Nuno S=C3=A1 (2024-10-08 14:37:22)
> > > On Tue, 2024-10-08 at 10:03 +0200, Matteo Martelli wrote: =20
> > > > Quoting Nuno S=C3=A1 (2024-10-08 09:29:14) =20
> > > > > On Tue, 2024-10-08 at 08:47 +0200, Matteo Martelli wrote: =20
> > > > > > Quoting Nuno S=C3=A1 (2024-10-07 17:15:13) =20
> > > > > > > On Mon, 2024-10-07 at 10:37 +0200, Matteo Martelli wrote: =20
> > > > > > > > Consumers need to call the read_avail_release_resource afte=
r reading
> > > > > > > > the
> > > > > > > > available info. To call the release with info_exists locked=
, copy the
> > > > > > > > available info from the producer and immediately call its r=
elease
> > > > > > > > callback. With this change, users of iio_read_avail_channel=
_raw() and
> > > > > > > > iio_read_avail_channel_attribute() must free the copied ava=
il info
> > > > > > > > after
> > > > > > > > calling them.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> > > > > > > > ---
> > > > > > > > =C2=A0drivers/iio/inkern.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 64 +++++++++++++++++++++++++++++++++--
> > > > > > > > ----
> > > > > > > > -----
> > > > > > > > =C2=A0include/linux/iio/consumer.h |=C2=A0 4 +--
> > > > > > > > =C2=A02 files changed, 50 insertions(+), 18 deletions(-)
> > > > > > > >=20
> > > > > > > > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > > > > > > > index
> > > > > > > > 7f325b3ed08fae6674245312cf8f57bb151006c0..cc65ef79451e5aa2c=
ea447e16800
> > > > > > > > 7a44
> > > > > > > > 7ffc0d91
> > > > > > > > 100644
> > > > > > > > --- a/drivers/iio/inkern.c
> > > > > > > > +++ b/drivers/iio/inkern.c
> > > > > > > > @@ -760,9 +760,25 @@ static int iio_channel_read_avail(stru=
ct
> > > > > > > > iio_channel
> > > > > > > > *chan,
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!iio_channel_has_availab=
le(chan->channel, info))
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > > > > > > =C2=A0
> > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_info->read_avail)
> > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return iio_info->read_avail(chan->indio_dev, chan- =20
> > > > > > > > >channel, =20
> > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 vals, type, length, info);
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_info->read_avail) {
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 const int *vals_tmp;
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int ret;
> > > > > > > > +
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D iio_info->read_avail(chan->indio_dev, chan- =20
> > > > > > > > >channel, =20
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0 &vals_tmp, type, length,
> > > > > > > > info);
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret < 0)
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > > > > > > +
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 *vals =3D kmemdup_array(vals_tmp, *length, sizeof(int),
> > > > > > > > GFP_KERNEL);
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (!*vals)
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENO=
MEM;
> > > > > > > > + =20
> > > > > > >=20
> > > > > > > Not a big deal but I would likely prefer to avoid yet another=
 copy. If
> > > > > > > I'm
> > > > > > > understanding things correctly, I would rather create an inke=
rn wrapper
> > > > > > > API
> > > > > > > like=20
> > > > > > > iio_channel_read_avail_release_resource() - maybe something w=
ith a
> > > > > > > smaller
> > > > > > > name :).
> > > > > > > Hence, the lifetime of the data would be only controlled by t=
he producer
> > > > > > > of
> > > > > > > it. It
> > > > > > > would also produce a smaller diff (I think). I just find it a=
 bit
> > > > > > > confusing
> > > > > > > that we
> > > > > > > duplicate the data in here and the producer also duplicates i=
t on the - =20
> > > > > > > > read_avail() =20
> > > > > > > call. Another advantage I see is that often the available dat=
a is indeed
> > > > > > > const in
> > > > > > > which case no kmemdup_array() is needed at all. =20
> > > > > >=20
> > > > > >=20
> > > > > > If I understand correctly your suggestion you would leave the i=
nkern
> > > > > > iio_channel_read_avail() untouched, then add a new inkern wrapp=
er,
> > > > > > something
> > > > > > like iio_channel_read_avail_release_resource(), that would call=
 the
> > > > > > producer's
> > > > > > read_avail_release_resource(). The consumer would invoke this n=
ew wrapper
> > > > > > in
> > > > > > its
> > > > > > own read_avail_release_resource() avoiding the additional copy.=
 The call
> > > > > > stack
> > > > > > would look something like the following:
> > > > > >=20
> > > > > > iio_read_channel_info_avail() {
>=20
> Here you are talking about the core code that produces a string.
> But you've done that in reply to v5 which is about inkern interfaces
> that don't work in strings...
>=20
>=20
>=20
> > > > > > =C2=A0=C2=A0=C2=A0 consumer->read_avail() {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_read_avail_chann=
el_raw() {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 iio_channel_read_avail() {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 producer->read_avail() {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmemdup_array();
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > =C2=A0=C2=A0=C2=A0 }
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0 iio_format_list();
> That's effectively making the safe copy that is handed back to the
> caller. So this is fine.
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0 consumer->read_avail_release_resource() {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_read_avail_chann=
el_release_resource() {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 producer->read_avail_release_resource() {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree();
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > =C2=A0=C2=A0=C2=A0 }
> > > > > > } =20
> > > > >=20
> > > > > Yeah, exactly what came to mind...
>=20
> I'm very confused what scope of comments here is. Maybe the easiest thing=
 is to send the code.
>=20

The function call graph example and the related comments above were just
to show the full flow of a read_avail() call on a consumer driver in
case an inkern release_resource() wrapper was used instead of an
additional consumer copy. This just to confirm that I was on the same
page as what Nuno suggested.

>=20
> > > > >  =20
> > > > > >=20
> > > > > >=20
> > > > > > I was going with the simpler solution you described, but my con=
cern with
> > > > > > it
> > > > > > was
> > > > > > that the info_exists_lock mutex would be unlocked between a
> > > > > > iio_channel_read_avail()
> > > > > > call and its corresponding iio_channel_read_avail_release_resou=
rce() call.
> > > > > > To my understanding, this could potentially allow for the devic=
e to be
> > > > > > unregistered between the two calls and result in a memleak of t=
he avail
> > > > > > buffer
> > > > > > allocated by the producer.
>=20
> Yes. That's why we have to free the produced copy under the exist_lock
> (and take yet another copy).
>=20
> > > > > >=20
> > > > > > However, I have been trying to reproduce a similar case by addi=
ng a delay
> > > > > > between the consumer->read_avail() and the
> > > > > > consumer->read_avail_release_resources(), and by unbinding the =
driver
> > > > > > during
> > > > > > that delay, thus with the info_exists_lock mutex unlocked. In t=
his case
> > > > > > the
> > > > > > driver is not unregistered until the iio_read_channel_info_avai=
l()
> > > > > > function
> > > > > > completes, likely because of some other lock on the sysfs file =
after the
> > > > > > call
> > > > > > of
> > > > > > cdev_device_del() in iio_device_unregister().
> > > > > >  =20
> > > > >=20
> > > > > Yes, you need to have some sync point at the kernfs level otherwi=
se we could
> > > > > always be handling a sysfs attr while the device is being removed=
 under our
> > > > > feet. But I'm not sure what you're trying to do... IIUC, the prob=
lem might
> > > > > come
> > > > > if have:
> > > > >=20
> > > > > consumer->read_avail_channel_attribute()
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 producer->info_lock()
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 producer->read_avail()
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 producer->kmalloc()
> > > > >=20
> > > > > ...
> > > > > // producer unbound
> > > > > ...
> > > > > consumer->read_avail_release()
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
> > > > >=20
> > > > > // producer->kmalloc() never get's freed...
> > > > >=20
> > > > > The above is your problem right? And I think it should be a valid=
 one since
> > > > > between ->read_avail_channel_attribute() and read_avail_release()=
 there's
> > > > > nothing preventing the producer from being unregistered... =20
> > > >=20
> > > > Yes, that's the problem.
> > > >  =20
> > > > >=20
> > > > > If I'm not missing nothing one solution would be for the producer=
 to do
> > > > > devm_kmalloc() and devm_kfree() on read_avail() and release_resou=
rces() but
> > > > > at
> > > > > that point I'm not sure it's better than what you have since it's=
 odd enough
> > > > > for
> > > > > being missed in reviews... =20
>=20
> If it's an allocation to keep a copy for an active consumer then that is =
nasty
> as the lifetime is completely untidied.  Effectively you are garbage coll=
ecting.
>=20
> > > >=20
> > > > I honestly didn't think of this and it would in fact prevent the
> > > > additional copy. But I agree that it could be missed in new drivers,
> > > > maybe a comment in the iio_info read_avail_release_resource() callb=
ack
> > > > declaration would help? =20
> > > > >  =20
> > > At this point I would say whatever you or Jonathan prefer :)
> > >  =20
> >=20
> > I run some quick tests with this approach and haven't found any issue so
> > far.=20
>=20
> I can't see what is preventing the race you describe where the
> release callback is swept out by a driver unbind of the provider.
> So unless we can show that is safe I don't see a way to avoid a consumer =
copy.
>=20
> Long shot, Lars-Peter I think you fixed up most of the previous races in =
this
> code, don't suppose you remember how it works?
>=20
> > I would personally switch to this approach as it would be much
> > simpler and easier to understand, and since the avail lists are const
> > for most of the current drivers I would not expect many new drivers
> > needing a dynamic available list. However, I will wait Jonathan feedback
> > first.
> The idea here is almost no one actually makes a copy in the producer.
> The consumer copy is a necessity to my thinking because we are effectively
> passing the ownership of the data.  Unfortunately we have no idea how
> the producer would free it so we need to create our own copy.
>=20

You are indeed right. During the last comment reviews I focused on the
fact that using a devm_kfree() in the producer's read_avail_release()
would prevent the memleak but I completely missed that it would not
prevent the race condition: without the consumer copy, the consumer or
core code could still try to access a freed buffer after the producer
driver gets unregistered.

Thus I will keep this patch with the consumer copy as it is. I am soon
going to send a next version of this patch series to address the other
findings during this version.

> Key here is this a very rare operation.   No one polls available
> data at high frequency, it's a read once kind of thing typically.
> + these are normally really short lists in the cases we actually use
> (so far I 'think' they have always been the 3 value range form, not
>  a list of potential values).
>=20
> Jonathan
>=20
>=20

Thanks,
Matteo Martelli

