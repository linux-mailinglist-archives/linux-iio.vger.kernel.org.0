Return-Path: <linux-iio+bounces-10886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6639A7258
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 20:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3203A1F22350
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 18:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE431FBC87;
	Mon, 21 Oct 2024 18:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPQijWH7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635E41FBC92;
	Mon, 21 Oct 2024 18:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535323; cv=none; b=Zt06zV/FU9PbZ5UTZM+o7tHoPQGjXW0iKIGK1M/uFlm/mxfuITx4dfyZgrymSVMnMh3smVD6c4EtCiCvTyAq6NdCiNWU1dQsDhWnIykSIKq6Os7PQwaNmASyJvgbRHvurBD4KADVqvxwF2HZiLCUTf5PB3GjTWOJ27+Erh0MUsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535323; c=relaxed/simple;
	bh=ptS4hB+9g5tLJ6Y3Ir0ex1ToynFjAmAhdZirQ2dCAcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ou6ioiLjjOWk7pyZmStAfbGdQMuDc5Bf3e7URZk27hQiH8bfPqlHetAJraD69YRtx1lYAcZewvH7Lo92V8hNEQIYyP8haGjb3uIPbpjKSOQUUkXNnHs9jX/r5cJr6hQ9inwSikkCJRVgFO1xY4T2R8wRgusYDOYFTPIIXaJRMmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPQijWH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD1CC4CEC7;
	Mon, 21 Oct 2024 18:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729535323;
	bh=ptS4hB+9g5tLJ6Y3Ir0ex1ToynFjAmAhdZirQ2dCAcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NPQijWH7dtdQfWQ3VINcIBs68dM7uYDwqDcC2DOqmkjAh885TxxLXIXa6K6JXTqIj
	 vLYbM9aSLPVzuqEGu9n47tRZL6yC5W6IuoeQAv3gEtpKVM24dQD2UTQfxIC9iJ72aT
	 iaL92gS8GtScPW0VQ6NHnhn0X3kJSLq6yz/sKf5ri6TVXklasyrOUYB7vbY5NPGHHB
	 DnT/UhfYWB3SqtpQJOY3poCa4WKT4yHrI6EICqV2radISv18EU7dBnPMMqEjuybaTo
	 HwOkckHVkRvA26k2S7SW/moHtwPMsTdWCEWamezYhDASvCdaXc0AndJrHt2jl3a2w2
	 kTT5OjpPZffSg==
Date: Mon, 21 Oct 2024 19:28:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Emil Gedenryd <Emil.Gedenryd@axis.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lars@metafoo.de"
 <lars@metafoo.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Kernel
 <Kernel@axis.com>
Subject: Re: [PATCH v4 2/2] iio: light: opt3001: add support for TI's
 opt3002 light sensor
Message-ID: <20241021192836.1b1fe68d@jic23-huawei>
In-Reply-To: <9e93042237c3c9815d7b1be5ba85be61239b76e8.camel@axis.com>
References: <20241003-add_opt3002-v4-0-c550dc4591b4@axis.com>
	<20241003-add_opt3002-v4-2-c550dc4591b4@axis.com>
	<20241006141624.3fa5bf34@jic23-huawei>
	<b40d22b5bdf487b40207e676d35a0507c47cbb26.camel@axis.com>
	<20241010184742.1747bfe2@jic23-huawei>
	<fab164228b4d567a147cd8d93150e687c6db0c70.camel@axis.com>
	<20241012161040.1506a7a4@jic23-huawei>
	<9e93042237c3c9815d7b1be5ba85be61239b76e8.camel@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Oct 2024 06:18:29 +0000
Emil Gedenryd <Emil.Gedenryd@axis.com> wrote:

> On Sat, 2024-10-12 at 16:10 +0100, Jonathan Cameron wrote:
> > On Fri, 11 Oct 2024 07:12:05 +0000
> > Emil Gedenryd <Emil.Gedenryd@axis.com> wrote:
> >  =20
> > > On Thu, 2024-10-10 at 18:47 +0100, Jonathan Cameron wrote: =20
> > > > On Mon, 7 Oct 2024 07:19:06 +0000
> > > > Emil Gedenryd <Emil.Gedenryd@axis.com> wrote:
> > > >    =20
> > > > > On Sun, 2024-10-06 at 14:16 +0100, Jonathan Cameron wrote:   =20
> > > > > > On Thu, 3 Oct 2024 14:22:17 +0200
> > > > > > Emil Gedenryd <emil.gedenryd@axis.com> wrote:     =20
> > > > > > >=20
> > > > > > > +struct opt3001_chip_info {
> > > > > > > +	const struct iio_chan_spec (*channels)[2];
> > > > > > > +	enum iio_chan_type chan_type;
> > > > > > > +	int num_channels;
> > > > > > > +
> > > > > > > +	const struct opt3001_scale (*scales)[12];     =20
> > > > > > This doesn't compile for me as one of the two options only
> > > > > > has 11 entries.  You could either force them to be 12
> > > > > > entries each or use a pointer without the size and
> > > > > > add a num_scales entry in here.
> > > > > >=20
> > > > > > Jonathan     =20
> > > > >=20
> > > > > Hi Jonathan,
> > > > >=20
> > > > > Are you building on top of the patch that was accepted in earlier=
 versions of this
> > > > > patch set? That patch adds the twelfth missing scale value for th=
e opt3001.
> > > > > See:=C2=A0https://lore.kernel.org/all/20240916-add_opt3002-v3-1-9=
84b190cd68c@axis.com/
> > > > >=20
> > > > > Should I have added some tag to highlight the dependency for this=
 version of the
> > > > > patch set?   =20
> > > > Ah.  Yes, I was half asleep.
> > > > They are going via different branches (slow and fast) so I'll have =
to
> > > > sit on this series until after that fix is in the upstream for the =
togreg
> > > > branch of iio.git.
> > > >=20
> > > > If I seem to have lost it after that is the case feel free to give =
me a poke.
> > > >=20
> > > > Jonathan
> > > >    =20
> > > Hi,
> > >=20
> > > No worries. Just to clarify, do you mean sit on it as that you will c=
ontinue reviewing
> > > the code after the fix is in upstream, or should I consider this patc=
h to be approved? =20
> > Assuming not other review comes in, I consider this ready to go. =20
>=20
> Great, thank you!
>=20
> > >=20
> > > Also, do you have an approximation of what time frame we're talking a=
bout? =20
> > 2 weeks most likely.
> >=20
> > I've just sent Greg KH a pull request with the fix in it. He will hopef=
ully
> > pick that up and then send a pull request on to Linus.  Then we wait fo=
r the
> > next rc after that at which point Greg will probably pull it into char-=
misc-next or
> > I can always merge it into my togreg branch once it is in a release can=
didate of
> > Linus' tree.
> >=20
> > In parallel with that I'll probably do a pull request for what is alrea=
dy in the
> > togreg tree to get a lot of stuff in char-misc-next for the next cycle.=
 That makes
> > the history a little cleaner as I can fast forward my tree and end up w=
ith
> > whatever is in char-misc-next (hopefully including this).
> >=20
> > Anyhow, a bit of tree juggling for me, but we have plenty of time as rc=
3 will probably
> > be out tomorrow and it normally goes to rc7 at one rc a week =20
>=20
> Thank you for the information and for the help during the review process =
for this patch.
> Best regards,
> Emil

Applied to the togreg branch of iio.git and pushed out initially as testing=
 to
let the build bots see if they can find anything we missed.

I'll push it out for linux-next to pick up in a few days.

Jonathan

> >=20
> > Thanks,
> >=20
> > Jonathan =20
> > > Best Regards,
> > > Emil=20
> > >  =20
> >  =20
>=20


