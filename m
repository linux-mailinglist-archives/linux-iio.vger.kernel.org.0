Return-Path: <linux-iio+bounces-5711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B398D8D8A91
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 21:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F979284081
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 19:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED0413A876;
	Mon,  3 Jun 2024 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GU2WgC73"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CF020ED;
	Mon,  3 Jun 2024 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444514; cv=none; b=k+4uP8emU9N5ffHj2Xq5VAZ0zxu2gyQyOqoM8Ul4L52JU0amevB2U1cto8hVZEYv5N/05Dwyt+AE0xWSC3n3ylzcayiOthBkTDDquL/tR49wtkCLucGX5cz6axX6DgrK2tluM4qv05fYv52AbYcztBrg7z01YbVOTQp1mQ5bdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444514; c=relaxed/simple;
	bh=1fIiUaMhINY/BVkZO99M6/eSuzyKLzaI9qYzq+ht54o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIinmGBQXVpwwYHiRn9UEB49UPgoxoSV2gXBsHIIPHjjtlSknN6uGAsHEKa//DjC7glPhxapviQGXtAMOUh094slL5xql3oqm9jPkkwLAv4JPWcyUs1mU39Rkeh0WSuCs7X3D34+/FPuVXYvKqoMz+JcYRMAYV2DkMbvPCURy38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GU2WgC73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA74DC2BD10;
	Mon,  3 Jun 2024 19:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717444513;
	bh=1fIiUaMhINY/BVkZO99M6/eSuzyKLzaI9qYzq+ht54o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GU2WgC73jIvh4bn4NaorEWg2xhgW+IYbR0ift7S+6CWOfDNzNUePA/ofMhkB6uCtV
	 PdhhHFocOtzJNrBIgJkPIupD4qgeAArOL51ZWV0Ue4sloDKOTCvja0mLk9yeTDTfDS
	 xDESPcMEP5EAobL3A8DrOMQOlcdpQYLelBRzaY6vSjKmkPKgJyUbGNzrK3UjvxmeOl
	 YxBkRc99cANRbATQXqoDwLLpj1c+WsDo6jFhUgf3mru8YKznT1RdPpLZSukc+pdHNY
	 s1rYGFcsqSc9CXyAs+QwS2OpzqMeCB5RSWK1b08DFToFMpKqotXcOR0qeJYBRGe7N6
	 ClPT7F0bWCBew==
Date: Mon, 3 Jun 2024 20:55:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Julien Stephan <jstephan@baylibre.com>, Esteban Blanc
 <eblanc@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] iio: add support for multiple scan types
Message-ID: <20240603205502.5e6155f4@jic23-huawei>
In-Reply-To: <11841924e4e1db49001a2fe52f5985f3c044c184.camel@gmail.com>
References: <20240530-iio-add-support-for-multiple-scan-types-v3-0-cbc4acea2cfa@baylibre.com>
	<20240602102517.438b51b8@jic23-huawei>
	<11841924e4e1db49001a2fe52f5985f3c044c184.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 03 Jun 2024 12:25:55 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sun, 2024-06-02 at 10:25 +0100, Jonathan Cameron wrote:
> > On Thu, 30 May 2024 10:14:07 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >  =20
> > > Up to now, the IIO subsystem has only supported a single scan type per
> > > channel. This scan type determines the binary format of the data in t=
he
> > > buffer when doing buffered reads.
> > >=20
> > > For simple devices, there is only one scan type and all is well. But
> > > for more complex devices, there may be multiple scan types. For examp=
le,
> > > ADCs with a resolution boost feature that adds more bits to the raw
> > > sample data. Traditionally, for slow devices, we've just always used =
the
> > > highest resolution mode, but for high performance ADCs, this may not =
be
> > > always practical. Manipulating data after every read can hurt perform=
ance
> > > and in the case of hardware buffers, it may not be possible to change=
 the
> > > format of the data in the buffer at all. There are also ADCs where
> > > enabling the higher resolution can only be done if oversampling is al=
so
> > > enabled which may not be desireable.
> > >=20
> > > To allow for more flexibility, we would like to add support for multi=
ple
> > > scan types per channel.
> > >=20
> > > To avoid having to touch every driver, we implemented this in a way t=
hat
> > > preserves the existing scan_type field. See the "iio: add support for
> > > multiple scan types per channel" the details. The first couple of pat=
ches
> > > are just preparation for this.
> > >=20
> > > [1]:
> > > https://lore.kernel.org/linux-iio/CAMknhBHOXaff__QyU-wFSNNENvs23vDX5n=
_ddH-Dw3s6-sQ9sg@mail.gmail.com/ =20
> >=20
> > Nice series. Applied to the togreg branch of iio.git and pushed out as
> > testing for 0-day to poke at it.
> >=20
> > Obviously this v3 hasn't been on list that long, but there is still time
> > as I doubt I'll push out a non rebasing tree for a week or so.
> > This week is looking too busy! =20
>=20
> If there's still time, feel free to add my tag:
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
Done

