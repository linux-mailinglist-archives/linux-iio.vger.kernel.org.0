Return-Path: <linux-iio+bounces-23454-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B5FB3CB0C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 15:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2893D3A87B2
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 13:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E901A08A3;
	Sat, 30 Aug 2025 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="XMBebaK+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05149155A30;
	Sat, 30 Aug 2025 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756559064; cv=none; b=bleB6A/tpsBMqBY0YY3RBZ6jx2N4NjaLCbdZ/1B1hCcXxpGC+Z+wwXD3/kMrjqrrL0gQfnty798uTW53NokDFX0CptbPWKPrmNaMzPuCLCRNcy9ZJMF09Uc3BgmAkyXv0jILGuYBfDKLgRmnEwoAGGzlrUQsRnjgp4tHYjexmGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756559064; c=relaxed/simple;
	bh=11NSSVhheYOLZaSTjIwSXMD/oNiJ80kwwV+v61I0AUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKiXcQTbYkiN4rUU4/fggqLtHS/dA/WovhefZIf4gP4Xcpj5WbSeAsxzV51dBNFJ+OnSyeiseBpoP30y60mw90pr0U5ZRgNM9iwg5pc0WASyqXYVGKzWiS+oexJXr+/b4ZM8dBoTYbJX0IvZJo9dM4Z/mNEdZpBOVLhsCwnkEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=XMBebaK+; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=ApRLQQtCH50g3dUPsfYYJf4yyx0+V5Jj3o8tU6wcblM=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756559028; v=1; x=1756991028;
 b=XMBebaK+filpWh6CJ90lw/J/jz9t9q5i4I/3nZDyMBNZmi2hHq6bJDp7rP0mKYzW8mc4LM5V
 KyURpHszDlCuXUbZPy9jIUu56/SvwJNLy/OixX5bVO6MRKQLfbmZeFw1kGHKAieFIuypWUz/ZPo
 zPhjyHo8PS7xqekuJ+SCRaUWr7fcA2XyBhucXi0fBS9L8MrdztSN6dMI0SEPM+fPmRlvrmUsuLQ
 JkpGhP9UbpNasx0OM7Z435yg29h6/5qPYwZoD34ZUMnJ7yJnwcJtcONdEP3Uya54APsJJVuskXc
 2XMtBjAkbVj7Gjoe5qVsq/dBM1SDpzcozeOGofO3TE23A==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 01aa2079; Sat, 30 Aug 2025 15:03:48 +0200
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>,
 Lee Jones <lee@kernel.org>, David Wronek <david@mainlining.org>,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
Date: Sat, 30 Aug 2025 15:03:47 +0200
Message-ID: <10724132.nUPlyArG6x@radijator>
In-Reply-To:
 <CAHp75Ve=xJ6vTUydaTw9GuYr22ZXp3HFA5N0tP7NET=CvZJB8Q@mail.gmail.com>
References:
 <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
 <4f93d53a-3dfa-4b9f-8c09-73703888d263@baylibre.com>
 <CAHp75Ve=xJ6vTUydaTw9GuYr22ZXp3HFA5N0tP7NET=CvZJB8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday, 30 August 2025 06:37:27 Central European Summer Time Andy Shev=
chenko wrote:
> On Fri, Aug 29, 2025 at 2:41=E2=80=AFAM David Lechner <dlechner@baylibre.=
com> wrote:
> > On 8/28/25 5:17 PM, Duje Mihanovi=C4=87 wrote:
=2E..
> > +     if (adcnum < 0 || adcnum > 3)
> > +             return -EINVAL;
>=20
> in_range()

Not sure how relevant that check is anymore; in my current local
version this can definitely only be called for one of the GPADCx
channels. Should I drop it then?

> > > +     for (int i =3D 0; i < 16; i++) {
>=20
> Why signed? What is the magic value here?

No magic to my understanding, it's that the bias generator can output
16 different current levels.

> > > +             ret =3D regmap_update_bits(*map, reg, 0xf, i);
>=20
> GENMASK() or even better to have a definitive constant.

While at it, could

> > +              *amp =3D 1 + i * 5;

use a macro too?

> > > +     raw =3D gpadc_get_raw(iio, chan->channel);
> > > +     if (raw < 0) {
> > > +             ret =3D raw;
> > > +             goto out;
> > > +     }
>=20
> Instead just assign to ret and if okay, reassign to raw.

I've refactored that function greatly since and now have:

*val =3D gpadc_get_raw(iio, chan->channel);
if (*val < 0)
	return *val;

Is assigning to *val immediately alright?

> > > +     const u8 config[] =3D {0xff, 0xfd, 0x1};
> >=20
> > IIRC, IIO subsystem prefers spaces around the braces.
> >=20
> >                         { 0xff, 0xfd, 0x1 };
>=20
> Also make them fixed width, i.e. 0x01

I've replaced these with macros as David suggested.

> > > +config 88PM886_GPADC
> > > +     tristate "Marvell 88PM886 GPADC driver"
> > > +     depends on MFD_88PM886_PMIC
> > > +     default y
>=20
> Really? Why tristate then?
> I would expect default MFD_88PM886_PMIC instead,
>=20
> > > +     help
> > > +       Say Y here to enable support for the GPADC (General Purpose A=
DC)
> > > +       found on the Marvell 88PM886 PMIC. The GPADC measures various
> > > +       internal voltages and temperatures, including (but not limite=
d to)
> > > +       system, battery and USB.
>=20
> Please, add a line about the module name if one chooses 'm'. Or see
> above =E2=80=94 drop the "tristate" and explain why this driver may not b=
e a
> module in the commit message.

'default MFD_88PM886_PMIC' would make it y as that one is a bool. How
about 'default m if MFD_88PM886_PMIC' or, since this already depends on
_PMIC, 'default m'?

Regards,
=2D-
Duje



