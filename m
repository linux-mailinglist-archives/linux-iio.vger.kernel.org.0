Return-Path: <linux-iio+bounces-14170-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F556A0A8B8
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBC91688D9
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09DE1B0414;
	Sun, 12 Jan 2025 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0ajaKoV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C81AB530;
	Sun, 12 Jan 2025 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736682008; cv=none; b=dJQ76or8pQUcYCaZIqnSAaL3D1jpLcIz+U0q+PgpPegD6aBR/CdTwcr5UWEdBBuX5zgn/QDYK9eQL253pnAvsiaU4D6xunmWrlYzHPMdZtyO1UOtxKfmwqnXDe+HSsxOLxTOtZIdPFmUfNUzHtQa5uAgbitUMeKUf/DcaTpqTaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736682008; c=relaxed/simple;
	bh=h1XqJAnxIkJPOnUeR74Khqq4VlauJOltBrKBC+pbc3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMLuRELgoL3MRqrIh1D4BiHWo6SM4+aVhzguheTRm4Gmx1CXXMQGN+uoTjngLHoByo7T73b/0LEA1B1OoMzc3TL8xZw8CsipzfekB8lsC5cP6SEVNX6iU8uI17OFdxeweI4cWG3l4zHuEn3W6MRLenNmA3j6lgkNomDAfGt/5f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0ajaKoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC27C4CEDF;
	Sun, 12 Jan 2025 11:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736682007;
	bh=h1XqJAnxIkJPOnUeR74Khqq4VlauJOltBrKBC+pbc3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B0ajaKoVefu4amvHhln9R8ZazPv+WasRI0ugyoyQWOj04ByBywir04UoZzSDFEG0m
	 EJQbh5TXzGmR4eTMM/Xl1LSAX2ysDL53QFWglEX9c/T/aEIgf0+i8EZxxzc0I/vzo/
	 +MXO7YluidTKki2YzBZgdhlwEtmQ/LeZ+sBrChido5tu0BSxUT0XeM+RAMdJHei5m2
	 RQ7ckMfxBynDdMGVvoron7sDl361tr2iPabR4VDS3BEy1cqXxZTXcYWLTtGUY5in+2
	 g+e9janK0HfuPlT8zk7kjZ+WQY0fjz67iCGhNgvZZtdB9nKJF5B4hH/Uf4HRw6/pcK
	 LiORUEOcoZrSA==
Date: Sun, 12 Jan 2025 11:40:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2 3/4] iio: adc: ad7380: add alert support
Message-ID: <20250112114001.6295d2d4@jic23-huawei>
In-Reply-To: <20250111125145.343484b5@jic23-huawei>
References: <20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com>
	<20241224-ad7380-add-alert-support-v2-3-7c89b2bf7cb3@baylibre.com>
	<20241228142457.576f47d4@jic23-huawei>
	<4be16272-5197-4fa1-918c-c4cdfcaee02e@baylibre.com>
	<CAEHHSvb_BRB-ygksULL4+o4eFEPSC4zOs1yBptFd8QzZtS0Dhw@mail.gmail.com>
	<20250111125145.343484b5@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Jan 2025 12:51:45 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 7 Jan 2025 09:51:23 +0100
> Julien Stephan <jstephan@baylibre.com> wrote:
>=20
> > Le lun. 6 janv. 2025 =C3=A0 16:29, David Lechner <dlechner@baylibre.com=
> a =C3=A9crit : =20
> > >
> > > On 12/28/24 8:24 AM, Jonathan Cameron wrote:   =20
> > > > On Tue, 24 Dec 2024 10:34:32 +0100
> > > > Julien Stephan <jstephan@baylibre.com> wrote:
> > > >   =20
> > > >> The alert functionality is an out of range indicator and can be us=
ed as an
> > > >> early indicator of an out of bounds conversion result.
> > > >>
> > > >> ALERT_LOW_THRESHOLD and ALERT_HIGH_THRESHOLD registers are common =
to all
> > > >> channels.
> > > >>
> > > >> When using 1 SDO line (only mode supported by the driver right now=
), i.e
> > > >> data outputs only on SDOA, SDOB (or SDOD for 4 channels variants) =
is
> > > >> used as an alert pin. The alert pin is updated at the end of the
> > > >> conversion (set to low if an alert occurs) and is cleared on a fal=
ling
> > > >> edge of CS.
> > > >>
> > > >> The ALERT register contains information about the exact alert stat=
us:
> > > >> channel and direction. Unfortunately we can't read this register b=
ecause
> > > >> in buffered read we cannot claim for direct mode.
> > > >>
> > > >> User can set high/low thresholds and enable event detection using =
the
> > > >> regular iio events:
> > > >>
> > > >>   events/in_thresh_falling_value
> > > >>   events/in_thresh_rising_value
> > > >>   events/thresh_either_en
> > > >>
> > > >> If the interrupt properties is present in the device tree, an IIO =
event
> > > >> will be generated for each interrupt received.
> > > >> Because we cannot read ALERT register, we can't determine the exact
> > > >> channel that triggers the alert, neither the direction (hight/low
> > > >> threshold violation), so we send and IIO_EV_DIR_EITHER event for a=
ll
> > > >> channels.
> > > >>
> > > >> In buffered reads, if input stays out of thresholds limit, an inte=
rrupt
> > > >> will be generated for each sample read, because the alert pin is c=
leared
> > > >> on a falling edge of CS (i.e when starting a new conversion). To a=
void
> > > >> generating to much interrupt, we introduce a reset_timeout that ca=
n be
> > > >> used to disable interrupt for a given time (in ms)
> > > >>
> > > >>   events/thresh_either_reset_timeout
> > > >>
> > > >> When an interrupt is received, interrupts are disabled and re-enab=
led
> > > >> after thresh_either_reset_timeout ms. If the reset timeout is set =
to 0,
> > > >> interrupt are re-enabled directly.
> > > >> Note: interrupts are always disabled at least during the handling =
of the
> > > >> previous interrupt, because each read triggers 2 transactions, tha=
t can
> > > >> lead to 2 interrupts for a single user read. IRQF_ONESHOT is not e=
nough,
> > > >> because, it postpones the 2nd irq after the handling of the first =
one,
> > > >> which can still trigger 2 interrupts for a single user read.   =20
> > > >
> > > > After some of our recent discussions around interrupt handling and
> > > > the guarantees (that aren't) made, even disabling the interrupt doe=
sn't
> > > > prevent some irq chips queuing up future interrupts.
> > > >
> > > > https://lore.kernel.org/all/io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5=
jcfrs3rz2a2@orquwgflrtyc/
> > > >
> > > > I'm not sure this alert can actually work as a result :(
> > > > I am struggling to come up with a scheme that will work.
> > > >   =20
> > > Would it work if we change it to a level-triggered interrupt instead =
of edge
> > > triggered? =20
>=20
> Whilst I'd hope it would I'm not 100% sure.

How much do we care about a potential double report?  Maybe we just let it =
happen?
Does it create an infinite chain?

Jonathan

>=20
> > >
> > > Since the main purpose of this is to trigger a hardware shutdown, per=
haps we
> > > could just omit the interrupt/emitting the event and keep the thresho=
ld and
> > > enable attributes if we can't come up with a reasonable way to handle=
 the
> > > interrupts?
> > >   =20
> >=20
> > Hi Jonathan, and David,
> >=20
> > I think this is getting very complicated for something not that useful
> > in practice.
> > If needed we can go back on this later to find an appropriate solution.
> > I sent a non RFC V3 version, removing the interrupt handling? Does
> > that work for you? =20
>=20
> Works for me.
>=20
> >=20
> > Cheers
> > Julein
> >  =20
>=20
>=20


