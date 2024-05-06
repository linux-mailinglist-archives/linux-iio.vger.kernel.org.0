Return-Path: <linux-iio+bounces-4841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5C98BCF5E
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 15:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C95E1B21792
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 13:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BDE7FBBE;
	Mon,  6 May 2024 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuIm0fZ0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DA27BAE7;
	Mon,  6 May 2024 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715003191; cv=none; b=RGiOs07D1ejRi9tjE0DiodPwomHmUgwyjPHiJoAg55jMqLI8LRKmiXnwgN9tqsxxOOtpF8MtP2HbqgurhDN73kLVFUSh20B0s5BfaTrXP2yuAG0AbqsypPJhBHllEys6XDf4i4UQ3AEyneMHpQa0jSoDKEeBcDUaj4nkMr2a5/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715003191; c=relaxed/simple;
	bh=aESUy15wVYlJIj9vHepc1l3+tvAKYbDk97F0MtsZ6dk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ms58mh7spdz0MC/6HcqWOiAsOgEbLJR3Wjn4yu5YFU5nnodx3jsV1wiz+JGUhhhR/7ec/ZpkdF1BlcciELcg1k8u2CWvYxUhMKsM69iGugukG7i9XdJaBd3BajbDQ0ORIOVmbD2YRGBsEamBkkWV/KntqnwL9kh190DGtTeyDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuIm0fZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D55C116B1;
	Mon,  6 May 2024 13:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715003191;
	bh=aESUy15wVYlJIj9vHepc1l3+tvAKYbDk97F0MtsZ6dk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JuIm0fZ0nXElSVYXr8rO4iw6hhRoGATQjZMfP033Bd4k6RDcQAkFUXOfAlOMf5jp6
	 tUo2PmBR+NjehyLKu4TPq7VuxCKOlpFCb+myJ7UZZRKYxhunaF1bCjBDhZDEsGA2cv
	 WN27Pyo20yVVAM5m2AacrZTA2wU9Pr0iyEH3h0oo/HWiac7taH+/qaYLko3Ga7MAWs
	 oRP1IiKTb7PlwswNZlVbiSNh0D3ytUmE47n0n9Fe1LuI0lWilnqar+thwm4GYGS68o
	 5HIfd0ySi3dQfZPXJBZ0o7aOdDzBvLFZw7aaw5O1jJ3BDLFSXiAOngxton0jAa7Ceg
	 902onoWDjYhrA==
Date: Mon, 6 May 2024 14:46:16 +0100
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
Message-ID: <20240506144616.0b90664b@jic23-huawei>
In-Reply-To: <a04d8015ea1606ce1eca86f7eaaa85a1c1b46d7a.camel@gmail.com>
References: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
	<20240501-adding-new-ad738x-driver-v6-10-3c0741154728@baylibre.com>
	<a04d8015ea1606ce1eca86f7eaaa85a1c1b46d7a.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 06 May 2024 10:55:46 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2024-05-01 at 16:55 +0200, Julien Stephan wrote:
> > ad738x chips are able to use an additional 2 bits of resolution when
> > using oversampling. The 14-bits chips can have up to 16 bits of
> > resolution and the 16-bits chips can have up to 18 bits of resolution.
> >=20
> > In order to dynamically allow to enable/disable the resolution boost
> > feature, we have to set iio realbits/storagebits to the maximum per chi=
ps.
> > This means that for iio, data will always be on the higher resolution
> > available, and to cope with that we adjust the iio scale and iio offset
> > depending on the resolution boost status.
> >=20
> > The available scales can be displayed using the regular _scale_available
> > attributes and can be set by writing the regular _scale attribute.
> > The available scales depend on the oversampling status.
> >=20
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> >=20
> > ---
> >=20
> > In order to support the resolution boost (additional 2 bits of resoluti=
on)
> > we need to set realbits/storagebits to the maximum value i.e :
> > =C2=A0 - realbits =3D 16 + 2 =3D 18, and storagebits =3D 32 for 16-bits=
 chips
> > =C2=A0 - realbits =3D 14 + 2 =3D 16, and storagebits =3D 16 for 14-bits=
 chips
> >=20
> > For 14-bits chips this does not have a major impact, but this
> > has the drawback of forcing 16-bits chip users to always use 32-bits
> > words in buffers even if they are not using oversampling and resolution
> > boost. Is there a better way of implementing this? For example
> > implementing dynamic scan_type?
> >  =20
>=20
> Yeah, I don't think it's that bad in this case. But maybe dynamic scan ty=
pes is
> something we may need at some point yes (or IOW that I would like to see =
supported
> :)). We do some ADCs (eg: ad4630) where we use questionably use FW proper=
ties to set
> a specific operating mode exactly because we have a different data layout=
 (scan
> elements) depending on the mode.

Yeah. Fixed scan modes were somewhat of a bad design decision a long time b=
ack.
However, the big advantage is that it got people to think hard about whethe=
r it is
worth supporting low precision modes. For slow devices it very rarely is and
forcing people to make a decision and the advantage we never supported
low precision on those parts.

Having said that there are good reasons for dynamic resolution changing
(the main one being the storage case you have here) so I'd be happy to
see some patches adding it. It might be easier than I've always thought
to bolt on.

This and inkernel event consumers have been the two significant features
where I keep expecting it to happen, but every time people decide they real=
ly
don't care enough to make them work :(

> =20
> > Another issue is the location of the timestamps. I understood the need
> > for ts to be consistent between chips, but right now I do not have a
> > better solution.. I was thinking of maybe adding the timestamps at the
> > beginning? That would imply to change the iio_chan_spec struct and maybe
> > add a iio_push_to_buffers_with_timestamp_first() wrapper function? Is
> > that an option?

You have lost me on this one.  Why does the timestamp need to be in a consi=
stent
location?  We have lots of drivers where it moves about between different
chips they support, or indeed what channels are currently turned on.

I haven't actually looked at the latest code yet, so maybe it will become
obvious!

Jonathan



