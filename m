Return-Path: <linux-iio+bounces-563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EED07802F9F
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 11:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91BFB1F211EE
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 10:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66E61EB40;
	Mon,  4 Dec 2023 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0nOnqmO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678861A5B8;
	Mon,  4 Dec 2023 10:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F68C433C7;
	Mon,  4 Dec 2023 10:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701684556;
	bh=yAwfL5mlp8gk6o+ikzKIP73jtJkwWRk8g+V6+GxfLIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K0nOnqmOlhVv/esO8SayjWZHFABUXAll5SanpcJ8LIG1Wxu0H0Oh17qPt2/fca0j1
	 cWiMhwWlU7N8GfAF5bH5je505MlbMG1tCeG6zmUWziEPPQpcMReclw2QYaglJ8ZmWf
	 bR3Iq5Xl7aC2T/dK+mTkXGBfTz1wmgGuyqOt1NBj/e5OJPxIKkQ4DSBqKY4biWodGb
	 RjMxULXXjz9iVgRjFcJHuKx3Mw9xAIvcPJ6TW4cBjlLDlz2X9WW7Vf6XRZmhF0Tlir
	 VKOJCrX4xas0QR9smsCvZGHIgc4csvzzcCL53osFoEZaWZVuxNhddmMd5zjFJ1mmxT
	 jA6oyDlvGCrEQ==
Date: Mon, 4 Dec 2023 10:09:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Philipp Jungkamp <p.jungkamp@gmx.net>
Cc: Jeff LaBundy <jeff@labundy.com>, David Lechner <dlechner@baylibre.com>,
 Sicelo <absicsz@gmail.com>, linux-iio@vger.kernel.org,
 maemo-leste@lists.dyne.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
 linux-input@vger.kernel.org
Subject: Re: supporting binary (near-far) proximity sensors over gpio
Message-ID: <20231204100908.5b1bfc16@jic23-huawei>
In-Reply-To: <94eafe4dfe176d0ca01ddbd0ec599e3c5fb2e0a3.camel@gmx.net>
References: <ZVevR_ajeB1jfDS9@tp440p.steeds.sam>
	<CAMknhBE5A3w7ntdWC9cFDYSrPQNPoH7sQ5PVXKEy6MAJmZ93SA@mail.gmail.com>
	<ZWLKsVu/v8m9nA0U@nixie71>
	<94eafe4dfe176d0ca01ddbd0ec599e3c5fb2e0a3.camel@gmx.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 26 Nov 2023 11:59:05 +0100
Philipp Jungkamp <p.jungkamp@gmx.net> wrote:

> Hi,
>=20
> would it make sense to move the HID human presence driver at
> drivers/iio/light/hid-sensor-prox.c to the input system then? This
> driver only checks for the "Biometric" (0x2004b0) and "Biometric: Human
> Presence" (0x2004b1) HID usages. The former has a vendor defined value
> range, the latter is defined as a boolean switch. See the HID Usage
> Tables, section 21.1 and 21.6.

These boundaries always get messy.  Given there is a value range, it
might get used for something else.
>=20
> I take from this discussion that the input subsystem would make more
> sense for the "Biometric: Human Presence" usage.

Potentially yes
>=20
> I just wanted to chime in as there seems to be some older precedent for
> a binary sensor in the iio subsystem. I tried to get that sensor
> working for the proximity sensor on my laptop last year.

I guess this one landed because it looked much like the hid light sensors
and no one raised the question at the time (that I recall).

Probably not worth moving it, but we may well have suggested putting
it in input if we'd noticed at the time!

Jonathan

>=20
> Regards,
> Philipp Jungkamp
>=20
> On Sat, 2023-11-25 at 22:33 -0600, Jeff LaBundy wrote:
> > Hi Sicelo and David,
> >=20
> > On Sat, Nov 18, 2023 at 06:09:18PM -0600, David Lechner wrote: =20
> > > On Fri, Nov 17, 2023 at 12:22=E2=80=AFPM Sicelo <absicsz@gmail.com> w=
rote: =20
> > > >=20
> > > > Hi
> > > >=20
> > > > Some phones have 1-bit proximity sensors, which simply toggle a
> > > > GPIO
> > > > line to indicate that an object is near or far. Thresholds are
> > > > set at
> > > > hardware level. One such sensor is OSRAM SFH 7741 [1], which is
> > > > used on
> > > > the Nokia N900.
> > > >=20
> > > > It is currently exported over evdev, emitting the
> > > > SW_FRONT_PROXIMITY key
> > > > code [2].
> > > >=20
> > > > So the question is: should a new, general purpose iio-gpio driver
> > > > be
> > > > written, that would switch such a proximity sensor to the iio
> > > > framework?
> > > > Or evdev is really the best place to support it?
> > > >=20
> > > > There are a couple of people who are willing to write such an iio
> > > > driver, if iio is the way to go.
> > > >=20
> > > > Regards,
> > > > Sicelo
> > > >=20
> > > > [1]
> > > > https://media.digikey.com/pdf/Data%20Sheets/Osram%20PDFs/SFH_7741.p=
df
> > > > [2]
> > > > https://elixir.bootlin.com/linux/v6.6.1/source/arch/arm/boot/dts/ti=
/omap/omap3-n900.dts#L111
> > > >  =20
> > > Since this is really a proximity switch (it is either on or off)
> > > rather than measuring a proximity value over a continuous range, it
> > > doesn't seem like a good fit for the iio subsystem. If the sensor
> > > is
> > > on a phone, then it is likely to detect human presence so the input
> > > subsystem does seem like the right one for that application.
> > >=20
> > > More at
> > > https://www.kernel.org/doc/html/latest/driver-api/iio/intro.html
> > >  =20
> >=20
> > I tend to agree; if there are only two discrete states as is the case
> > for a
> > GPIO, then this is technically a switch and not a sensor. Therefore,
> > input
> > seems like a better fit; that is just my $.02.
> >=20
> > FWIW, a similar discussion came up a few years ago in [1] and again
> > the key
> > differentiator was whether the output is discrete or continuous.
> >=20
> > Kind regards,
> > Jeff LaBundy
> >=20
> > [1]
> > https://lore.kernel.org/linux-iio/9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@=
redhat.com/
> >  =20
>=20


