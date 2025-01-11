Return-Path: <linux-iio+bounces-14128-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9BCA0A3A9
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 13:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A7F3AA0B2
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 12:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840E619AA58;
	Sat, 11 Jan 2025 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/2HTxbH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CF61EB44;
	Sat, 11 Jan 2025 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736599914; cv=none; b=gkIqtvbjeRBk4KYyilv+HjXG7a8EXFi+4WeBp/s31cGCMsf7HNJYKa+8FEMKp65rQkokzSUhDkdPejtyPUiIm7PkkH+b9i0vUZp0NY2lLG/sRqDUc6jboCar25jDVSAaahxTkV5slxeV4aIS9DHn3RJY4i1dV27LBTUmG3jlvJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736599914; c=relaxed/simple;
	bh=ZPsaHh77bUt/btfigV/TZ+RX4+GIriP4gZ0gxo2/AOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAn9BQI0wKy0dT5RNdU0H1aVczInckpi7zzggRykfeXhYtfw1zvl06yiuBN4+VIvMnOt/XLX7NDiKXF50UpTKn7APKsG97RJrnKq9KC2KH/mx4BTeDhwIkfj3frB8V9InrQEOe9e1jaOxIPplr9cGo6WZ0ENx+rcGval3bupXyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/2HTxbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36776C4CED2;
	Sat, 11 Jan 2025 12:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736599913;
	bh=ZPsaHh77bUt/btfigV/TZ+RX4+GIriP4gZ0gxo2/AOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b/2HTxbH4jVikQvj2u/E4rbYee5cYjl6Nc/v0wHGWXbB5ln+aol4dWVW1Rl5PWNN/
	 ljqkrS0oU13GOm+rhcFVrZpqikk4NK31s/S6tAK4o3T/oNH2BhLxWv3e/U+QNt+0Zi
	 hWyfFwRPZAfGvs43IfXQV5DVb/bzFAXK9u2LOtk8lFvT00j0VXh0SVX5qWHxqwA/oJ
	 lwUrCGD0S2i40aBlmak7ZaVfHcVK3a935MAc58UBecSoL/crCyeTVO5KYc9TuBos3Y
	 wkJjNgDyGmnxtsLIoYETm7sZu3utoa7p7Ciy95URUccTpeUzhHK1tQLMtwSy8Bq6D2
	 o2Yn3k6EgUi9g==
Date: Sat, 11 Jan 2025 12:51:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2 3/4] iio: adc: ad7380: add alert support
Message-ID: <20250111125145.343484b5@jic23-huawei>
In-Reply-To: <CAEHHSvb_BRB-ygksULL4+o4eFEPSC4zOs1yBptFd8QzZtS0Dhw@mail.gmail.com>
References: <20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com>
	<20241224-ad7380-add-alert-support-v2-3-7c89b2bf7cb3@baylibre.com>
	<20241228142457.576f47d4@jic23-huawei>
	<4be16272-5197-4fa1-918c-c4cdfcaee02e@baylibre.com>
	<CAEHHSvb_BRB-ygksULL4+o4eFEPSC4zOs1yBptFd8QzZtS0Dhw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Jan 2025 09:51:23 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> Le lun. 6 janv. 2025 =C3=A0 16:29, David Lechner <dlechner@baylibre.com> =
a =C3=A9crit :
> >
> > On 12/28/24 8:24 AM, Jonathan Cameron wrote: =20
> > > On Tue, 24 Dec 2024 10:34:32 +0100
> > > Julien Stephan <jstephan@baylibre.com> wrote:
> > > =20
> > >> The alert functionality is an out of range indicator and can be used=
 as an
> > >> early indicator of an out of bounds conversion result.
> > >>
> > >> ALERT_LOW_THRESHOLD and ALERT_HIGH_THRESHOLD registers are common to=
 all
> > >> channels.
> > >>
> > >> When using 1 SDO line (only mode supported by the driver right now),=
 i.e
> > >> data outputs only on SDOA, SDOB (or SDOD for 4 channels variants) is
> > >> used as an alert pin. The alert pin is updated at the end of the
> > >> conversion (set to low if an alert occurs) and is cleared on a falli=
ng
> > >> edge of CS.
> > >>
> > >> The ALERT register contains information about the exact alert status:
> > >> channel and direction. Unfortunately we can't read this register bec=
ause
> > >> in buffered read we cannot claim for direct mode.
> > >>
> > >> User can set high/low thresholds and enable event detection using the
> > >> regular iio events:
> > >>
> > >>   events/in_thresh_falling_value
> > >>   events/in_thresh_rising_value
> > >>   events/thresh_either_en
> > >>
> > >> If the interrupt properties is present in the device tree, an IIO ev=
ent
> > >> will be generated for each interrupt received.
> > >> Because we cannot read ALERT register, we can't determine the exact
> > >> channel that triggers the alert, neither the direction (hight/low
> > >> threshold violation), so we send and IIO_EV_DIR_EITHER event for all
> > >> channels.
> > >>
> > >> In buffered reads, if input stays out of thresholds limit, an interr=
upt
> > >> will be generated for each sample read, because the alert pin is cle=
ared
> > >> on a falling edge of CS (i.e when starting a new conversion). To avo=
id
> > >> generating to much interrupt, we introduce a reset_timeout that can =
be
> > >> used to disable interrupt for a given time (in ms)
> > >>
> > >>   events/thresh_either_reset_timeout
> > >>
> > >> When an interrupt is received, interrupts are disabled and re-enabled
> > >> after thresh_either_reset_timeout ms. If the reset timeout is set to=
 0,
> > >> interrupt are re-enabled directly.
> > >> Note: interrupts are always disabled at least during the handling of=
 the
> > >> previous interrupt, because each read triggers 2 transactions, that =
can
> > >> lead to 2 interrupts for a single user read. IRQF_ONESHOT is not eno=
ugh,
> > >> because, it postpones the 2nd irq after the handling of the first on=
e,
> > >> which can still trigger 2 interrupts for a single user read. =20
> > >
> > > After some of our recent discussions around interrupt handling and
> > > the guarantees (that aren't) made, even disabling the interrupt doesn=
't
> > > prevent some irq chips queuing up future interrupts.
> > >
> > > https://lore.kernel.org/all/io53lznz3qp3jd5rohqsjhosnmdzd6d44sdbwu5jc=
frs3rz2a2@orquwgflrtyc/
> > >
> > > I'm not sure this alert can actually work as a result :(
> > > I am struggling to come up with a scheme that will work.
> > > =20
> > Would it work if we change it to a level-triggered interrupt instead of=
 edge
> > triggered?

Whilst I'd hope it would I'm not 100% sure.

> >
> > Since the main purpose of this is to trigger a hardware shutdown, perha=
ps we
> > could just omit the interrupt/emitting the event and keep the threshold=
 and
> > enable attributes if we can't come up with a reasonable way to handle t=
he
> > interrupts?
> > =20
>=20
> Hi Jonathan, and David,
>=20
> I think this is getting very complicated for something not that useful
> in practice.
> If needed we can go back on this later to find an appropriate solution.
> I sent a non RFC V3 version, removing the interrupt handling? Does
> that work for you?

Works for me.

>=20
> Cheers
> Julein
>=20


