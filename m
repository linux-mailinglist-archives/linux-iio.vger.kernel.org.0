Return-Path: <linux-iio+bounces-4845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D578BD011
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 16:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2AA1C22545
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 14:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6602813DB88;
	Mon,  6 May 2024 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCGhf7iC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207FC13CF8F;
	Mon,  6 May 2024 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005251; cv=none; b=j2M+joX0lSd3u5TYR7TaED90JEtEFwYEV5f+BgkPL6b45cKUYqBuIVqjFmYCzEPDSI/TSxwzfs34XpDDvS0TbqmRaW1DOY4noa5sCbkzs4q+QztTYA9z3G3l0XVd/KcPP6K1BN1oKcl0tqn1+swhGNdpl997mGjcSzoU77rGggY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005251; c=relaxed/simple;
	bh=v35O4MOv00OkD5Eak0/TAE7hgCKO/FarPLabAISIafg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+tCc8Bkv1d5feRVJFfRvn7H/KVhz9KIK1l7Canu46q+bAyheD4TrrQujAQRq83FkTDN14H0G4aihqjMe2MMe0vzMEwSPif5ExfUnh8ejC4JqPO/CX30asNXVDPpVyrkBj1dufVvchaN8Fqt0RVefsK+i+hiQeGVPFPY5758+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCGhf7iC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91D5C4AF66;
	Mon,  6 May 2024 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715005250;
	bh=v35O4MOv00OkD5Eak0/TAE7hgCKO/FarPLabAISIafg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CCGhf7iCvrvdO1ATf+Hxvn2NyWfeqH0aIGOcAknXZEOSrM8DVYC33/kmMwu3Bsrbb
	 M41McHzwU9v75DbupsIzscvoHNrg8AZ31GjhSraOptdgRK1OjsQbqJ/5iDvgwqtQ6D
	 m6SUsoS2S0tTJP/bFqMY2v+l4df54sD4OoGYJJ2EvK2OaUzL0Ufs0QcVGuQ7T5xXTJ
	 JjJ/orAMCuHo1X1IgrzL3JmZRRqbvAqBMy53rXkWlPEe0oULCmuyvElgETpM+HTbqE
	 CKQuStfTfjutV9VirdqFiIrE7X+F9JqviRCEmRlZ0wG7QU1HUAy9m7FeIAAQ/wvJS8
	 3rexaZSozQ1nw==
Date: Mon, 6 May 2024 15:20:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v6 10/10] iio: adc: ad7380: add support for
 resolution boost
Message-ID: <20240506152022.58794348@jic23-huawei>
In-Reply-To: <20240506144616.0b90664b@jic23-huawei>
References: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
	<20240501-adding-new-ad738x-driver-v6-10-3c0741154728@baylibre.com>
	<a04d8015ea1606ce1eca86f7eaaa85a1c1b46d7a.camel@gmail.com>
	<20240506144616.0b90664b@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 6 May 2024 14:46:16 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 06 May 2024 10:55:46 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Wed, 2024-05-01 at 16:55 +0200, Julien Stephan wrote: =20
> > > ad738x chips are able to use an additional 2 bits of resolution when
> > > using oversampling. The 14-bits chips can have up to 16 bits of
> > > resolution and the 16-bits chips can have up to 18 bits of resolution.
> > >=20
> > > In order to dynamically allow to enable/disable the resolution boost
> > > feature, we have to set iio realbits/storagebits to the maximum per c=
hips.
> > > This means that for iio, data will always be on the higher resolution
> > > available, and to cope with that we adjust the iio scale and iio offs=
et
> > > depending on the resolution boost status.
> > >=20
> > > The available scales can be displayed using the regular _scale_availa=
ble
> > > attributes and can be set by writing the regular _scale attribute.
> > > The available scales depend on the oversampling status.
> > >=20
> > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > >=20
> > > ---
> > >=20
> > > In order to support the resolution boost (additional 2 bits of resolu=
tion)
> > > we need to set realbits/storagebits to the maximum value i.e :
> > > =C2=A0 - realbits =3D 16 + 2 =3D 18, and storagebits =3D 32 for 16-bi=
ts chips
> > > =C2=A0 - realbits =3D 14 + 2 =3D 16, and storagebits =3D 16 for 14-bi=
ts chips
> > >=20
> > > For 14-bits chips this does not have a major impact, but this
> > > has the drawback of forcing 16-bits chip users to always use 32-bits
> > > words in buffers even if they are not using oversampling and resoluti=
on
> > > boost. Is there a better way of implementing this? For example
> > > implementing dynamic scan_type?
> > >    =20
> >=20
> > Yeah, I don't think it's that bad in this case. But maybe dynamic scan =
types is
> > something we may need at some point yes (or IOW that I would like to se=
e supported
> > :)). We do some ADCs (eg: ad4630) where we use questionably use FW prop=
erties to set
> > a specific operating mode exactly because we have a different data layo=
ut (scan
> > elements) depending on the mode. =20
>=20
> Yeah. Fixed scan modes were somewhat of a bad design decision a long time=
 back.
> However, the big advantage is that it got people to think hard about whet=
her it is
> worth supporting low precision modes. For slow devices it very rarely is =
and
> forcing people to make a decision and the advantage we never supported
> low precision on those parts.
>=20
> Having said that there are good reasons for dynamic resolution changing
> (the main one being the storage case you have here) so I'd be happy to
> see some patches adding it. It might be easier than I've always thought
> to bolt on.
>=20
> This and inkernel event consumers have been the two significant features
> where I keep expecting it to happen, but every time people decide they re=
ally
> don't care enough to make them work :(
>=20
> >   =20
> > > Another issue is the location of the timestamps. I understood the need
> > > for ts to be consistent between chips, but right now I do not have a
> > > better solution.. I was thinking of maybe adding the timestamps at the
> > > beginning? That would imply to change the iio_chan_spec struct and ma=
ybe
> > > add a iio_push_to_buffers_with_timestamp_first() wrapper function? Is
> > > that an option? =20
>=20
> You have lost me on this one.  Why does the timestamp need to be in a con=
sistent
> location?  We have lots of drivers where it moves about between different
> chips they support, or indeed what channels are currently turned on.
Maybe I now understand this?
The concern is the structure used for the iio_push_to_buffers_with_timestam=
p()
That doesn't need to be a structure and if you look at drivers where it isn=
't
the most common reason is because the timestamp needs to be able to move ar=
ound.

So do something similar here.

Jonathan

>=20
> I haven't actually looked at the latest code yet, so maybe it will become
> obvious!
>=20
> Jonathan
>=20
>=20
>=20


