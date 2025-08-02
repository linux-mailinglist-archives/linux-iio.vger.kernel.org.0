Return-Path: <linux-iio+bounces-22189-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D98B18E29
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 13:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EABE1795D6
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 11:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2176E218599;
	Sat,  2 Aug 2025 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8t2Nf3I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8842E370E;
	Sat,  2 Aug 2025 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754133365; cv=none; b=T594PPXigvLK7+zB72JTk4rE86vPmuLvqXKNuQY/XQtPoTrHFD2hQvQ3ER2QNdYeNHXQHgiHzZk8K+TrkCOleaiM8K1ZFOirgKLuWC8/PE0iT+ye8sL2RxjWJOUnNzQz9EKZ71wQEU8zC9jnBy6d4fty6Q34sOKfqnuEnJyxLs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754133365; c=relaxed/simple;
	bh=ROkCxdnFsnFe0CfnoInM3PW61b3W3sguZ58TwVRfWPw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8kHnGq4uccMDzfivruBhHOWh3ghgJuJ6ILUiHaP6zBqTj0WMZYrpoLRMNrwIdDmQgEU+v6DKjl25do792zjapBwT3udbWxQx38BOsP4Wbq9AKpzWFhSdypIARekUPPVUSjc57UjJkOD+z5vd6xU25KZNSWFTMVEivd/vve8s1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8t2Nf3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BD5C4CEEF;
	Sat,  2 Aug 2025 11:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754133365;
	bh=ROkCxdnFsnFe0CfnoInM3PW61b3W3sguZ58TwVRfWPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p8t2Nf3IFb/66MmBTQmZtWyBzOa8Lt8SASmnUxRqjSKxouad6cYHCNOrX0hruFYPo
	 3U6iz79rf38MBQyFKbb5xWsmBgz7G4mZ8YVkX2hx1cu2j2K+5yUPuKOn4SDnEZ2WTu
	 ekvalM0NGnqhrBd+Zrp1Ai2XzgyDcWcXxYEf2kkjL3PeSgolGuEIz0pESizNCLwDaD
	 ISHmxi9qSmxEr3cst4E/6Lg5lOz/qLiS1LNgCtsMCqzwEvTBmd+C4G/CVShpITOqv/
	 oQOBBxjz2pbNo+1smglVA+IW96u1WzApmsFww0H5PLIm0eU8eruc4oyx5pnVG0y2um
	 ly7ZKTMezhmMg==
Date: Sat, 2 Aug 2025 12:15:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Dixit Parmar <dixitparmar19@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magnetic Sensor
Message-ID: <20250802121556.36440419@jic23-huawei>
In-Reply-To: <CAHp75Vdc7RB8MG+jYcSxkvD2EY2weZJMnvkbgmqibYGLkcUEBQ@mail.gmail.com>
References: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
	<CAHp75Vdc7RB8MG+jYcSxkvD2EY2weZJMnvkbgmqibYGLkcUEBQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 2 Aug 2025 10:53:30 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Aug 2, 2025 at 8:44=E2=80=AFAM Dixit Parmar <dixitparmar19@gmail.=
com> wrote:
> >
> > The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> > applications includes joysticks, control elements (white goods,
> > multifunction knops), or electric meters (anti tampering) and any
> > other application that requires accurate angular measurements at
> > low power consumptions.
> >
> > The Sensor is configured over I2C, and as part of Sensor measurement
> > data it provides 3-Axis magnetic fields and temperature core measuremen=
t.
> >
> > The driver supports raw value read and buffered input via external trig=
ger
> > to allow streaming values with the same sensing timestamp.
> >
> > While sensor has interrupt pin multiplexed with I2C SCL pin. But for bu=
s =20
>=20
> the sensor
> an interrupt
> an I2C
>=20
> > configurations interrupt(INT) is not recommended, unless timing constra=
ints
> > between I2C data transfers and interrupt pulses are monitored and align=
ed.
> >
> > The Sensor's I2C register map and mode information is described in prod=
uct
> > User Manual[Link]. =20
>=20
> Replace Link here with 1...
>=20
> > Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/i=
nfineon-tlv493d-a1b6-datasheet-en.pdf
> > Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-U=
serManual-v01_03-EN.pdf =20
>=20
> ...and add space followed by [1] here.
>=20
> ...
>=20
> > Changes in v2:
> > - Drop regmap implementation in favor of using direct i2c APIs to
> >   have uniform communication APIs across the driver. =20
>=20
> This I don't understand. I mean the motivation behind this. Usually
> direct I2C communication is used to do some initial checks and
> configuration and rarely for the actuall run-time driver
> functionality. Otherwise it means that the regmap may be used with a
> customised read and write methods.
>=20

This was my suggestion.  The device has very odd characteristics that
means writes really are not register based.  You have to write them all
every time with now addressing.

So to me regmap just wasn't a good choice here. You could do something
some nasty stuff to hammer it into a custom regmap, but to me it's just
not a good fit.

Jonathan

>=20


