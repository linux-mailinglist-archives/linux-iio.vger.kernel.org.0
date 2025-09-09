Return-Path: <linux-iio+bounces-23908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3A7B5027D
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 18:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF931C6426C
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D56B35209B;
	Tue,  9 Sep 2025 16:25:05 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934F25D209;
	Tue,  9 Sep 2025 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435105; cv=none; b=DgqhU1jC6WZfK5XRvss5D14AOcgf8QXw2vIOZozJ4c3rtSqQJUBN5ma/jvLrObTR4zYc4a2NSwPxPAXLCO3WgMuUKjFl2hCgE/lhQfNA21zVomS1+7u/ZAxSUNCReEMm4vPS3nlO/tIGIozmuCyRsZAC2LeFdkis2mkLvts3+WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435105; c=relaxed/simple;
	bh=cOua30r+ToBx4Up2dWrmF/9V1mSkog7mr+huqsjOZic=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSM9ksV2zMvLtrPxRhsdnWz6puePS3ilqSeuKmo1Kyldb7eegEMsDmzLxsIPycjcojXN2hnEOiXpFjzgKGKcQW/k+G2yXKYLDtKharMd6OmdkJrckSo0BwWKujSRCkj/8rPgI5eFychdW984kdr1WSAg5CQzRTCpYLYNcjpEySw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cLpw54CClz6FCps;
	Wed, 10 Sep 2025 00:20:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4EC471402FF;
	Wed, 10 Sep 2025 00:25:01 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 9 Sep
 2025 18:25:00 +0200
Date: Tue, 9 Sep 2025 17:24:59 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
CC: Andy Shevchenko <andy.shevchenko@gmail.com>, Jonathan Cameron
	<jic23@kernel.org>, Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "Bartosz
 Golaszewski" <brgl@bgdev.pl>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Tobias Sperling
	<tobias.sperling@softing.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>, Hans de Goede
	<hansg@kernel.org>, Herve Codina <herve.codina@bootlin.com>, Alisa-Dariana
 Roman <alisadariana@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
Message-ID: <20250909172459.0000171e@huawei.com>
In-Reply-To: <de6b31ec-7a5a-43a1-b352-2b46055a1a23@gmail.com>
References: <cover.1757053456.git.mazziesaccount@gmail.com>
	<3cc1faffcb4f71f0755b6192f193acecd36bea67.1757053456.git.mazziesaccount@gmail.com>
	<20250907124207.2fe64214@jic23-huawei>
	<CAHp75VeaHFDDZDmc9xsbUxZbRgkipRtcSdXN=ZXL2+V2OvL=Mw@mail.gmail.com>
	<de6b31ec-7a5a-43a1-b352-2b46055a1a23@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 8 Sep 2025 08:10:11 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 07/09/2025 23:55, Andy Shevchenko wrote:
> > On Sun, Sep 7, 2025 at 2:42=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote: =20
> >> On Fri, 5 Sep 2025 09:42:31 +0300
> >> Matti Vaittinen <mazziesaccount@gmail.com> wrote: =20
> >=20
> > ...
> >  =20
> >>> +/* ADC channels as named in the data-sheet */
> >>> +static const char * const bd79112_chan_names[] =3D {
> >>> +     "AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A", "AGIO4A",       /* 0 - =
4 */
> >>> +     "AGIO5A", "AGIO6A", "AGIO7A", "AGIO8A", "AGIO9A",       /* 5 - =
9 */
> >>> +     "AGIO10A", "AGIO11A", "AGIO12A", "AGIO13A", "AGIO14A",  /* 10 -=
 14 */
> >>> +     "AGIO15A", "AGIO0B", "AGIO1B", "AGIO2B", "AGIO3B",      /* 15 -=
 19 */
> >>> +     "AGIO4B", "AGIO5B", "AGIO6B", "AGIO7B", "AGIO8B",       /* 20 -=
 24 */
> >>> +     "AGIO9B", "AGIO10B", "AGIO11B", "AGIO12B", "AGIO13B",   /* 25 -=
 29 */
> >>> +     "AGIO14B", "AGIO15B",                                   /* 30 -=
 31 */
> >>> +}; =20
> >> =20
> >>> +     /* Let's assign data-sheet names to channels */ =20
> >> Not seeing any value in this comment given the code that follows.
> >> Probably drop it =20
> >=20
> > It was my suggestion. I don't know if you noticed that the amount of> t=
he values is *not* power-of-two and it's harder to find a needed
> > value in the list. Moreover, you can read the discussion back and find
> > that actually it was a mistake in the list, which can be avoided (or
> > chances of which will be minimized) in the first place if we see the
> > comments. =20
>=20
> I believe Jonathan meant the:
>  >>> +/* ADC channels as named in the data-sheet */ =20
>=20
> not the "index comments". And I kinda agree with him, that's not adding=20
> too much. I'll drop that as suggested.
>=20

Yeah. I like the index comments - though less necessary if power of 2
as you say.

Jonathan

> Yours,
> 	-- Matti
>=20


