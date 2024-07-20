Return-Path: <linux-iio+bounces-7719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8951938084
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 11:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FBC9B21412
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 09:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3B17641D;
	Sat, 20 Jul 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZmB1/Im"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B74474079
	for <linux-iio@vger.kernel.org>; Sat, 20 Jul 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721468601; cv=none; b=oRAM0GB7IuTiEdvLMy7ssvCYG9vSMqc4/LaySesfK6Hf7JvNPtXxcrY9DB7hY9oonkHmMIvhEB21WlUj5Mx5dygZHBu91oY1ElR+ksgLb1s+B7bJrBYDv1JszPzN9ydnQ8FJZRfdbkl0K0QoploPWwQhsz9wecCmnxk9mYp8mAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721468601; c=relaxed/simple;
	bh=kHWzPvwqOvUbu9jKJY/m/3hFJctbiN3vhijQHmfgDwI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCuo4F6R3TbrIMNstcTQBHgD/5x6GfyscZpCkmY++mUbD9HA6+6UZr1oOeFXnBCux0JceM8WWrbicDXbffKsHUUGxDTM8gqvaSnLTUyZ+6Fw7Y3u81aMZ+Z4cMaxWvy4jKJMKObJy+a87FdZy40AYUF1B45Z+cSsAYs+e0Mf8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZmB1/Im; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872ECC2BD10;
	Sat, 20 Jul 2024 09:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721468601;
	bh=kHWzPvwqOvUbu9jKJY/m/3hFJctbiN3vhijQHmfgDwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dZmB1/ImK8Wj3LjAXEu3QtMD/gzxNfUFFl67q2Y3PJwwcwf1PRfbpHiRuqg3F5MyY
	 7xkfaK2GknZOfPm9iy81wteTnMYMqsKxhijB9NRUXrDGTQY1VpWHZeoKRKtrLL6UiH
	 RO8qZDk6SQAOWNO7QYDTxbq7d0DmBVs6FJ2dIgPyFio73WS7+KUHSywbFjgrOL9wzI
	 82ebyxqErhZACdaYQG2sPgSU+Zt1jaOiMiEkR6itocZZMZ98D9EVrU2g0SyAKD/hwe
	 nS8e942y0OTNpgXem2P4TZ65wSyNOAwRcWtKCrDTgD+cSGT/JZwEdnerS6csoZjQ3U
	 nYBGV0uMgGqVw==
Date: Sat, 20 Jul 2024 10:43:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 3/9] iio: backend: add debugFs interface
Message-ID: <20240720104315.52dcc2ec@jic23-huawei>
In-Reply-To: <5a26783c2167310237936d80affe61b43ea84022.camel@gmail.com>
References: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
	<20240709-dev-iio-backend-add-debugfs-v1-3-fb4b8f2373c7@analog.com>
	<20240716191443.397c1278@jic23-huawei>
	<5a26783c2167310237936d80affe61b43ea84022.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jul 2024 16:32:33 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2024-07-16 at 19:14 +0100, Jonathan Cameron wrote:
> > On Tue, 9 Jul 2024 13:14:30 +0200
> > Nuno Sa <nuno.sa@analog.com> wrote:
> >  =20
> > > This adds a basic debugfs interface for backends. Two new ops are bei=
ng
> > > added:
> > >=20
> > > =C2=A0* debugfs_reg_access: Analogous to the core IIO one but for bac=
kend
> > > =C2=A0=C2=A0 devices.
> > > =C2=A0* debugfs_print_chan_status: One useful usecase for this one is=
 for
> > > =C2=A0=C2=A0 testing test tones in a digital interface and "ask" the =
backend to
> > > =C2=A0=C2=A0 dump more details on why a test tone might have errors.
> > >=20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com> =20
> > Debugfs deserved docs as well as sysfs.
> > Same place in Documentation/ABI/
> >=20
> > Obviously we've neglected this in the past, but nice to do it right
> > nor new stuff.
> >  =20
>=20
> I see. So you mean adding debugfs-iio?

Probably debugfs-iio-backend for this stuff, though we should have
a more general doc as well.

>=20
> There's one thing I'm not sure though... I'm contemplating the case where=
 one device
> may have multiple backends in which case I'm doing:
>=20
> back->name =3D name;
>=20
> where name comes from FW (DT usually). That obviously means the interface=
 won't be
> always consistent which I guess it's not a real problem for debugfs?
>=20
> How would the interface look in the file? Something like?
>=20
> /sys/kernel/debug/iio/iio:deviceX/<backend_name>_direct_reg_access

That's fine - fairly common sort of thing to see in debugfs.

>=20
> Or should we think in a more reliable naming? One option that came to min=
d is
>=20
> /sys/kernel/debug/iio/iio:deviceX/backendY_direct_reg_access
If you were doing this it might be better as a directory.
e.g. backendY/direct_reg_access
>=20
> where Y would be the corresponding index in io-backend-names.
>=20
> One thing not optimal with the above would be identifying the actual back=
end device.
> It would then maybe make sense having a 'backend_name' interface which I =
think is
> likely too much just for this?
It kind of depends on your expected usecase.  These are in debugfs so there
is an assumption they aren't a 'normal operation' thing.  So if they
are going to typically be poked by a user, then complex file names are fine.
If it's going to be scripted, then stable names something like
backendY/name
backendY/direct_reg_access etc
would be easier to use.

I'm not bothered as much about consistency of this debug interface as I wou=
ld
be about sysfs, so up to you (or other reviewers) for which you prefer.

Jonathan

>=20
> - Nuno S=C3=A1
>=20
>=20


