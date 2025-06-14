Return-Path: <linux-iio+bounces-20651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D82AD9CEC
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 15:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7D91799A3
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52912C3269;
	Sat, 14 Jun 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEvXEJJo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC842E11CC;
	Sat, 14 Jun 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908026; cv=none; b=N55URcqs66jGBlC1L3usqlxq2Gd9KfSOLcLVk65wv9N9h8bIZCB8307J66BMegKi5mE2YRYU7p2OAxz85N6Js3w+wDRo82i+ZvVi4ZLFyzQpUoxNYtVC9b2qW4idEeNDg62i3J0lbqvKI1Gy+wPz2XauzhIYvWSukPAwE79M5G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908026; c=relaxed/simple;
	bh=FwV0qHN2N+rQBmiE1YjwcFdnvo4kF9W8W+kUyPqNMCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YIwcpS6iwEs14GT14PIrTpYs23lkGxHe/moEnr005o6e+s9CiZiWMi3/wmPsbokwBMdYsJ5at7pSDMnSlpDsRJ7UsMS//jJ6fUMMKw8aYbAECafzTRhssKAHPYZzQRgtP+eSIAQRCgYHdbznWY1493xTQpT3QDgrAHoVbE3/Tgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEvXEJJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB12C4CEEB;
	Sat, 14 Jun 2025 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908026;
	bh=FwV0qHN2N+rQBmiE1YjwcFdnvo4kF9W8W+kUyPqNMCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pEvXEJJo+NQ4Dphn1wbyiNg/J6gwj1Pu7Cm8/k+InY68Kyi2Aa4lkTZFJvlVdw5c/
	 Aqy/hTZEMNSD0rMoNGTVcvLHwxPuoWZR8fvrxPSWptKFsQPXnRpBJxcwdflHNgTosC
	 Rx3oGexCXRwBpH0jd7h3ZhQkHcWm2PomlLla4PjsO+2QRQ7gpTe/+OHC037IBHUJkE
	 DC/ewLGsyikj33EVBl8x5Zp08QMWfZBzCCFXoSY7ISIyEg+qckmGVuWv28pseMWYQT
	 042uoljQvysKpk21/T8pHmbrqt6rZUcwcfn7WwgPSdTwAd/7A9z2VbM1TjF2dx3Avf
	 9pwD/PJnOj7qw==
Date: Sat, 14 Jun 2025 14:33:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/11] iio: accel: adxl313: add AC coupled
 activity/inactivity events
Message-ID: <20250614143335.2049da6e@jic23-huawei>
In-Reply-To: <CAFXKEHZj7nYOJA7Ztxh8xiOcPpwDNBzNyN830tiKL=7rL0fiug@mail.gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
	<20250601172139.59156-11-l.rubusch@gmail.com>
	<20250608172317.63473b9b@jic23-huawei>
	<CAFXKEHZj7nYOJA7Ztxh8xiOcPpwDNBzNyN830tiKL=7rL0fiug@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Jun 2025 21:58:36 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Hi Jonathan,
>=20
> On Sun, Jun 8, 2025 at 6:23=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Sun,  1 Jun 2025 17:21:38 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add AC coupling activity and inactivity as MAG_ADAPTIVE events. This =
adds
> > > up an additional set of threshold and period handles, verifies matchi=
ng
> > > disabling functionality and extends setting the link bit to complemen=
tary
> > > event configurations.
> > >
> > > This means, e.g. either ACTIVITY or ACTIVITY_AC can be enabled. The m=
ost
> > > recent set will remain configured. Disabling ACTIVITY where ACTIVITY_=
AC was
> > > enabled is ignored, since it does not match (should be disabling
> > > ACTIVITY_AC). When INACTIVITY or INACTIVITY_AC is also enabled, the l=
ink
> > > bit will be set. Note, having the link bit and auto-sleep in place ac=
tivity
> > > and inactivity indicate the power save state change and thus will onl=
y be
> > > triggered once a state transition occurs. Since there is a separate A=
C bit
> > > for ACTIVITY and for INACTIVITY, events can be linked independently f=
rom
> > > each other i.e. ACTIVITY can be linked to INACTIVITY_AC for instance.
> > >
> > > When one of both is disabled, the link bit will be removed. Hence, the
> > > remaining event will not indicate a plain state change anymore, but o=
ccur
> > > as a periodically triggered inactivity event or for each activity eve=
nt
> > > above the threshold.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> >
> > Minor thought on rereading this.  If we don't have the link bit set
> > (and the paired event) the AC events are more accurately described as
> > MAG_REFERENCED as they are referenced simply to whatever acceleration
> > was going on when they were first enabled.   Only with the link bit
> > set (and the other event type enabled) are they actually adapting
> > (so MAG_ADAPTIVE).
> > =20
>=20
> Going by examples, I can follow you as practically I'm aware of the
> difference between a plain inactivity setup and a link-bit enabled
> inactivity(and activity) setup. Initially I thought of MAG and the
> AC-coupled equivalent being MAG_REFERENCED. By your explanation I
> understand why you preferred MAG_ADAPTIVE rather. But still all three
> configurations are possible.
>=20
> My idea is, the driver implementation supports all cases in parallel,
> at least to a certain extent. I mean, at the current implementation
> someone can configure plain activity, or AC-coupled activity, or
> respectively, their inactivity equivalents - when both, an activity
> type together with an inactivity type are enabled, they will be linked
> counter events. I.e. "adaptive" - and auto-sleep will be turned on for
> the inactivity periods. Built on using just plain IIO API w/o custom
> API calls.
>=20
> Due to all the possible combinations, this comes at a certain
> complexity. In terms of configuration and for instance mapping to MAG,
> MAG_REFERNCED or MAG_ADAPTIVE. Here I rely on your feedback. On my
> side, I'll try to recycle the automation setup to verify registers are
> configured as I like them to be using the sysfs handles (that's btw
> the reason why I'm glad to have debugfs on board). So, if you tell me,
> to change it rather to MAG_REFERENCED, I'll do it, but then AC-coupled
> events will be all MAG_REFRENCED w/ or w/o link bit. Or we come up
> with a total different approach, like putting link-bit AC on
> MAG_ADAPTIVE and plain AC-coupled on MAG_REFERENCED, but then what
> about MAG events w/ or w/o link-bit? hmm, I think current approach
> seems to be a good compromise. Let me know what you think.

I don't have a good answer for how to handle this complexity :(
This was more about an earlier question I think you asked about whether
there was a way to have the user opt in to the link bit or not.

I'm fine with treating them all as adaptive and glossing over exactly
how it is adapting but that doesn't get us to link bit control if
we decide that wants to be explicitly exposed at all.

J
>=20
> Best,
> L
>=20
> >
> > Maybe there is room to use that to ultimately control whether the
> > link bit is set or not (putting aside the power aspect of that).
> > =20


