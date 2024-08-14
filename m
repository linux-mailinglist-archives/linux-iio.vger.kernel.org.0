Return-Path: <linux-iio+bounces-8476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7847995225B
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 20:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DCA91C215B7
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 18:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17561BE22E;
	Wed, 14 Aug 2024 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwkZhANb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0F81BD50A;
	Wed, 14 Aug 2024 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723661771; cv=none; b=QEDkShNT6u4YdHRMspi5EcFI7/lWvV98Wpn01Gk8CI937NrnhWw7CEburI27px2k+5LRQ8/tG4h2nb1zJs8kDAy17d5vT0X6TLWuKJ47gXazKD4UUe40wbKnzuXKjm3RhoQJ+5besAMbLjSQX5oak7PtQ3tWXTfgtCcUi6ws+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723661771; c=relaxed/simple;
	bh=Xv9C46HpZceyjCFwUhc0Uj0Qtp88YtYV1+E9aXwhCl8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnO4MG1M2xHM5wLp/MDN6MpRsUNKeJjMxn8hz45F8oEsJek4A6p12KyiK83MLZQnq+WwV4/DJjdf3fInp+NDfiaUZWnTLwuX05cUtX4ELhx1ZzxdSocvL78nupoBvOI8AihZYy/Q8SEcnjhNnCVF7asVfcG6hptpXgf4xLVr15c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwkZhANb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3837C116B1;
	Wed, 14 Aug 2024 18:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723661770;
	bh=Xv9C46HpZceyjCFwUhc0Uj0Qtp88YtYV1+E9aXwhCl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qwkZhANbbMHwZIyU8NQw7hoa293CLmaW/Y//oT/h5DCSVJN8KcUt/yp/Y2zbp3B6m
	 TS0k7DZh7oMP6uELyi34MCMRdedu9uoGfXAhZToz1Kuujai5kpa3I6g9S/jJI/kGHx
	 00f61bjLELtX7/fosKpYDW7aDqbmubqBptMtHe3B+4uKlSUF0qw3BhqUHN2jaoqjd5
	 /+RjUWhdlCyedd4hfrZ8IWMyNnMhkEMOVJxXM250IiwTDu/+3nm0DHHzPZFYaRiLqA
	 G8n8FFKBazcOcWnUGNVRvSCyaa45y3QAWFEaj3Ux040UH3OHILunAjpFyv8C+Kd3U4
	 HVvZlGvgSaxww==
Date: Wed, 14 Aug 2024 19:56:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= 
 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad4695: implement triggered buffer
Message-ID: <20240814195604.6a871c6c@jic23-huawei>
In-Reply-To: <8b32d9819e44436af39c5f32b095c41f8ebd77b1.camel@gmail.com>
References: <20240807-iio-adc-ad4695-buffered-read-v1-0-bdafc39b2283@baylibre.com>
	<20240807-iio-adc-ad4695-buffered-read-v1-1-bdafc39b2283@baylibre.com>
	<20240810103540.03e758a5@jic23-huawei>
	<4bdb10c2-057f-4254-864b-99bb7ac1509d@baylibre.com>
	<8b32d9819e44436af39c5f32b095c41f8ebd77b1.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Aug 2024 09:28:06 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2024-08-12 at 12:03 -0500, David Lechner wrote:
> > On 8/10/24 4:35 AM, Jonathan Cameron wrote: =20
> > > On Wed,=C2=A0 7 Aug 2024 15:02:10 -0500
> > > David Lechner <dlechner@baylibre.com> wrote:
> > >  =20
> > > > This implements buffered reads for the ad4695 driver using the typi=
cal
> > > > triggered buffer implementation, including adding a soft timestamp
> > > > channel.
> > > >=20
> > > > The chip has 4 different modes for doing conversions. The driver is
> > > > using the advanced sequencer mode since that is the only mode that
> > > > allows individual configuration of all aspects each channel (e.g.
> > > > bipolar config currently and oversampling to be added in the future=
).
> > > >=20
> > > > Signed-off-by: David Lechner <dlechner@baylibre.com> =20
> > >=20
> > > Main thing in here is I think you can use available_scan_masks
> > > to avoid the need for the error path on just the temperature channel
> > > being enabled.
> > >  =20
> > I had not thought about doing it that way, but now that I am
> > thinking about it, it seems like we would need to have a scan
> > mask in the list for every possible combination of channels.
> > This would be 10s of thousands of possible scan masks for 16
> > channel chips so that doesn't seem like the best way to go.

Indeed not my best suggestion.

> >=20
> > But adding some special handling to make the temperature
> > channel just work should be easy enough to add.
> >  =20
>=20
> Not sure if the following is meaningful to this usecase but I used to thi=
nk like you
> but then realized that iio_scan_mask_match() will do bitmap_subset(). So =
you only
> need to enable a subset of the available scan mask for things to work (an=
d with that
> you should no longer need an insane number of combinations). The core wil=
l then take
> care of demuxing the actual enabled channels. AFAIR, strict scan matching=
 is only
> used for HW buffering.

Hmm. The validate_scan_mask callback also doesn't work as that's really abo=
ut
restricting cases where we are onehot or similar (so restricting number of =
channels
or that sort of thing).

So, I think this is a driver problem to hide it.

Just have some logic in the driver that enables a dummy channel if only the
temperature is enabled and throw it away (probably fine to put it in the
data passed to iio_push_to_buffers() and rely on the it either being
treated as garbage, or dropped depending on whether it is in a hole, or
on the end of the scan.  That should give the intuitive interface
we expect (no restrictions to bite us that don't have to be there - see one=
hot
case where we have no choice) without adding too much complexity.

Jonathan

>=20
> - Nuno S=C3=A1


