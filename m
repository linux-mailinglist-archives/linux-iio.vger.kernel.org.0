Return-Path: <linux-iio+bounces-24486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE90ABA6057
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 16:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC837AA53F
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCE42E1C56;
	Sat, 27 Sep 2025 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPG+/srC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF841E32D3;
	Sat, 27 Sep 2025 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758981885; cv=none; b=SFm0nWjexp+66dZ9w+uRljJpWpNE3IoymttaybU0odTMbSkfUk8Iv8o0vDiJc0p/HJ6cMv6OumTeo5OLWWeRNhgUCB+QrcqJYoEagJhPoW10Gjumy28TlnvnE+j/wdny1wr0rjMiwQQp+ghdNWVHhLiWh1EHcu0Mj1ntpDcKCu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758981885; c=relaxed/simple;
	bh=5xdEua8X8l/TAMdd3xOutBOvPgdsHiI9AwIPUbLnkgk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQQ2sLpkMiNQlxxojNSCLSuOu0EtdFOwiOc2dy47tTt2PrlQKAZIeP1e8SfoYPtMwyuxxQeG6gGI/BMoVm1hRNZ7JjdN+BgdMhHv5NAIFTcQenRz2CdujVRXx+3Iyo+6JqRfxATGsuFsMKPnHb86EzUG8iFxukujNJwwslYF4M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPG+/srC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412F5C4CEE7;
	Sat, 27 Sep 2025 14:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758981885;
	bh=5xdEua8X8l/TAMdd3xOutBOvPgdsHiI9AwIPUbLnkgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mPG+/srCImPh5QR9bZ9ZXp2LsaNb1zictrvurQ+3Or6t7dHS33eOFK0zdJ9XDWKhO
	 R/siSuyDQXkMoqOwJK3M6ltqAc/sitkxoCKszvLgpd5GuO7IQqGZ6Wnvyjw72Jvty2
	 mbZFXiUxxBrRaR16zslzrMC1D8y9qrvmMh9Ojj04mgy+9TIUDPH1qu9hnnVAyvFm2T
	 XHWkrB8h/Xehq1PO5bH/lVDFUVqDX77Pr7DN4EsLQQI4GqEHS0v0ib2q/FssC5icRX
	 28cBXYvZTnrWs+9kFfADDFOKO3w2VgEyUpD6igUGVZFrTSsqyr3QxT7SOztQWkolTP
	 vTi6bFVlw7iUg==
Date: Sat, 27 Sep 2025 15:04:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/18] iio: accel: bma220: move bma220_power() fct
Message-ID: <20250927150439.34906075@jic23-huawei>
In-Reply-To: <CAHp75Vc4TUu497JMuU0-bU0aqew9vUXLTDqDoqLMLkAC43Qv9g@mail.gmail.com>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
	<20250913-b4-bma220_improvements-v3-7-0b97279b4e45@subdimension.ro>
	<CAHp75Vc4TUu497JMuU0-bU0aqew9vUXLTDqDoqLMLkAC43Qv9g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 14 Sep 2025 15:05:47 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Sep 13, 2025 at 6:40=E2=80=AFPM Petre Rodan <petre.rodan@subdimen=
sion.ro> wrote:
> >
> > Move bma220_power() fct before bma220_init() since it will make the
> > next patch cleaner. =20
>=20
> ...
>=20
> > +static int bma220_power(struct spi_device *spi, bool up)
> > +{
> > +       int i, ret;
> > +
> > +       /** =20
>=20
> It's not a kernel doc, do not inherit the mistakes from the past.
Agreed.  To keep the series clean I'd do a cleanup of all incorrect instanc=
es
of this as a precursor patch.  Then these moves become cleaner.
Otherwise we have a whole load of patch descriptions with little
notes saying 'and fix incorrect kernel-doc markings' and that just
muddies the water!

Jonathan

>=20
> > +        * The chip can be suspended/woken up by a simple register read.
> > +        * So, we need up to 2 register reads of the suspend register
> > +        * to make sure that the device is in the desired state.
> > +        */
> > +       for (i =3D 0; i < 2; i++) {
> > +               ret =3D bma220_read_reg(spi, BMA220_REG_SUSPEND);
> > +               if (ret < 0)
> > +                       return ret;
> > +
> > +               if (up && ret =3D=3D BMA220_SUSPEND_SLEEP)
> > +                       return 0;
> > +
> > +               if (!up && ret =3D=3D BMA220_SUSPEND_WAKE)
> > +                       return 0;
> > +       }
> > +
> > +       return -EBUSY;
> > +} =20
>=20
>=20


