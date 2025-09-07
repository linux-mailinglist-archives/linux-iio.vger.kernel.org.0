Return-Path: <linux-iio+bounces-23842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 424F5B47A80
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 12:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E3E1B208AD
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 10:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197F72494FE;
	Sun,  7 Sep 2025 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u88SsKbl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225222172D;
	Sun,  7 Sep 2025 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757241382; cv=none; b=abNlW4kpkLhRvohL2VwGqteOk0c1UEJTTWlmGvGDQPmgc07dVX/H05+nY4GR8WsjQACcDX+LemyXkmDb98X/4DEQNpqab/1Iu2v7VHV2WbI/B/dOiviOOOBFCCMqnqbB7iv68efLvDZ80YdxHKKN8q5/Bs0iCN1j5z4vncU/USw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757241382; c=relaxed/simple;
	bh=Tf7AQ4WSuG9UVW2qgE59TP2o2lToYQhB/cueYxqv8ws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZSlD6CJK3Zyt6xSGWTqvjLAyRdnn3hQQ7iGVy/OpkmmT+vOrb70I69KaPTU1RFCJjBTwtF+TRxueIxwi9W/dKkf+mFKcS+Zam0cf/SNNPerZKsAwWEpAfMCQ8JUlNHGrLgNFie0kjNd6mfzyeLmtsqP8S5gWup5/FZPOi8QRFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u88SsKbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41942C4CEF0;
	Sun,  7 Sep 2025 10:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757241381;
	bh=Tf7AQ4WSuG9UVW2qgE59TP2o2lToYQhB/cueYxqv8ws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u88SsKblCEOeKaSFPBY3yJzUP96gLkyWlCzQwptxa886nTOfa0DYP8fC9ra/W5xG3
	 vM3dup0h/fIru05VPur4Y/INdGqiUbdfvsAI4bTaMIfIftXDWAqZlxr8wvq4si0+Qq
	 HGXUADbrnd85vGIH00GsScb9tZpdp5qkZRWksieAP7SallGmuNa+zlBUMcK4ckh3VL
	 Pyf4IgQwHYYgmQXYvll3x1Mp9vaGqqtFQlUnxnNXfyb9YZELZ0un8vYEFqM+/ihtm8
	 danydBgLBy8Kr6BZ+I2oDqdEg9qUapB6FaxggFVGSTi40UAEA3hpDs+azHzm96kCUR
	 G2T2sYtCAPCKw==
Date: Sun, 7 Sep 2025 11:36:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Karel Balej
 <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Wronek <david@mainlining.org>,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/3] iio: adc: Add driver for Marvell 88PM886 PMIC
 ADC
Message-ID: <20250907113609.6060e557@jic23-huawei>
In-Reply-To: <CAHp75VewzAN+tcJ9GrWESY38Uq+qeA4QH=qeaEV8g35H67GcMg@mail.gmail.com>
References: <20250905-88pm886-gpadc-v3-0-4601ad9ccb51@dujemihanovic.xyz>
	<20250905-88pm886-gpadc-v3-2-4601ad9ccb51@dujemihanovic.xyz>
	<CAHp75VewzAN+tcJ9GrWESY38Uq+qeA4QH=qeaEV8g35H67GcMg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Sep 2025 16:39:05 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Sep 5, 2025 at 2:01=E2=80=AFPM Duje Mihanovi=C4=87 <duje@dujemiha=
novic.xyz> wrote:
> >
> > Marvell's 88PM886 PMIC has a so-called General Purpose ADC used for
> > monitoring various system voltages and temperatures. Add the relevant
> > register definitions to the MFD header and a driver for the ADC. =20
>=20
> Jonathan et al. The Q here is do we want to somehow make values
> spelling (in the comments and documentation) be unified with the
> Scientific Style [1]? Personally I find the article very useful and
> one style for the whole subsystem would be good to enforce (in my
> humble opinion). Thoughts?
>=20
> [1]: https://poynton.ca/notes/units/

Consistency is indeed good, but I'm always careful about putting up
barriers to submission. So I'd prefer starting with guidance and general
review comments about consistent style, but probably not pushing back too
hard initially at least on new code where a consistent slightly different
style is applied. e.g. there is inconsistency in this patch as Volt and
Ampere get capitals but not Ohm (which should given all 3 are named
after people)

To actually move to such a style we'd need to fix up at least some existing
comments but that would be a trade off against churn.

I've been useless for years about putting an IIO maintainer entry profile i=
n place.
https://docs.kernel.org/doc-guide/maintainer-profile.html but that is where
probably where this sort of extra documentation of specific requirements wo=
uld belong
unless we can get broad agreement across subsystems where comments with uni=
ts
are common.

Before moving to any standard on this I think we'd want to make sure
we at least don't 'clash' with what is accepted in other subsystems where
these units are common.  +CC some relevant maintainers.

Jonathan

>=20
> ...
>=20
> > +static int gpadc_get_raw(struct iio_dev *iio, enum pm886_gpadc_channel=
 chan)
> > +{
> > +       struct pm886_gpadc *gpadc =3D iio_priv(iio);
> > +       __be16 buf;
> > +       int ret;
> > +
> > +       ret =3D regmap_bulk_read(gpadc->map, pm886_gpadc_regs[chan], &b=
uf, sizeof(buf));
> > +       if (ret)
> > +               return ret;
> > +
> > +       return be16_to_cpu(buf) >> 4; =20
>=20
> + asm/byteorder.h (after linux/* but before linux/iio/*)
>=20
> > +} =20
>=20
> ...
>=20
> > +               /*
> > +                * Vendor kernel errors out above 1.25V, but testing sh=
ows that =20
>=20
> 1.25 V
>=20
> > +                * the resistance of the battery detection channel (GPA=
DC2 on
> > +                * coreprimevelte) reaches about 1.4Mohm when the batte=
ry is =20
>=20
> 1.4 MOhm or even 1.4 M=CE=A9
>=20
>=20
> > +                * removed, which can't be measured with such a low upp=
er
> > +                * limit. Therefore, to be able to detect the battery w=
ithout
> > +                * ugly externs as used in the vendor fuelgauge driver,=
 =20
>=20
> fuel gauge
>=20
> > +                * increase this limit a bit.
> > +                */
> > +               if (WARN_ON(*raw_uV > 1500 * (MICRO / MILLI))) =20
>=20
> + bug.h
>=20
> > +                       return -EIO; =20
>=20
> ...
>=20
> > +               /*
> > +                * Vendor kernel errors out under 300mV, but for the sa=
me =20
>=20
> 300 mV
>=20
> > +                * reason as above (except the channel hovers around 3.=
5kohm =20
>=20
> 3.5 kOhm / 3.5 k=CE=A9
>=20
> > +                * with battery present) reduce this limit.
> > +                */
> > +               if (*raw_uV < 200 * (MICRO / MILLI)) {
> > +                       dev_dbg(&iio->dev, "bad bias for chan %d: %duA =
@ %duV\n", chan->channel, =20
>=20
> Also add spaces before units.
>=20
> > +                               *raw_uA, *raw_uV);
> > +                       continue;
> > +               }
> > +
> > +               dev_dbg(&iio->dev, "good bias for chan %d: %duA @ %duV\=
n", chan->channel,
> > +                       *raw_uA, *raw_uV); =20
>=20
> Ditto.
>=20
> > +               return 0;
> > +       }
> > +
> > +       dev_err(&iio->dev, "failed to find good bias for chan %d\n", ch=
an->channel);
> > +       return -EINVAL;
> > +} =20
>=20
> ...
>=20
> > +       ret =3D DIV_ROUND_CLOSEST(raw_uV, raw_uA); =20
>=20
> + math.h
>=20
> ...
>=20
> > +       page =3D devm_i2c_new_dummy_device(dev, client->adapter,
> > +                                        client->addr + PM886_PAGE_OFFS=
ET_GPADC);
> > +       if (IS_ERR(page)) =20
>=20
> + err.h
>=20
> > +               return dev_err_probe(dev, PTR_ERR(page), "Failed to ini=
tialize GPADC page\n"); =20
>=20
>=20


