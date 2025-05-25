Return-Path: <linux-iio+bounces-19860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A0FAC338C
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 11:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6605188BE9F
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 09:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812C51EA7EB;
	Sun, 25 May 2025 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTPJGLLM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325D03BBF2;
	Sun, 25 May 2025 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748166262; cv=none; b=ai1/JkEmrRJEG3SPwOhHUSmahBjY8iLMIqMu4lDE8WBL5Gnh1l+OACNF6CYuuxnXIw9RpGeU/31Wvoi7KFbgXtc75uoRiUyhUF2tuNj/6C5P54mWLUMaRUZdxKyjv1PZaOQocqdhuavdhPZoAxxcoszR0AGKoQtT1LXRS3NYdd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748166262; c=relaxed/simple;
	bh=Yl/HgWXWk9L+vxiqjaSsICod6Zx8Emsy9sKiSjYCOhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBFyrEXLCKrARKEx+KNaC1PVmiPsHuRsJfyYTI9KwNmbiI1OfHH12ruEkBr2yuLDtTwj57V9BrETa9mgGyxHhghVjnG1yb3902aV0XNcvzXXl+2zXW2ngMNV1u8sTb63pU271jW51k4xZsOJ8iwb9IUzhKcI2cXnjw4/XweTFfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTPJGLLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883DCC4CEEA;
	Sun, 25 May 2025 09:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748166261;
	bh=Yl/HgWXWk9L+vxiqjaSsICod6Zx8Emsy9sKiSjYCOhk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kTPJGLLM9lKGWEyGKJddL4qr7ZwqMQMeA+7YljCaWGm2OduoVrEb4DsKp/AK2n9O+
	 6GGnZ85rr+qkToWlnFwrZCQQirA/S8/I6GntaD+xcIXlq8ytXb9lfTH1BtgXxl30kO
	 s3gaggcWV9oWdyuHr47+v+gI8s5sPXTfTMTJsedHEUPFi2b8c5vs82fe2+rSIrGEsi
	 wGRa35k2mVBRIE1uaPnHn3sBqNNCdziH9xMU9zC04wLtESDvwCsLZnllwQAHZerOJ8
	 mgQCSoVNku3LQs1h7592oGz6kk8vMg/NhGPNLRVjoYvXy379KQ1KGMf1xUQa2/4Cck
	 4EscP0w0p57NQ==
Date: Sun, 25 May 2025 10:44:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: 4843ec52-57e2-418a-b640-8e05ba60959e@baylibre.com, David Lechner
 <dlechner@baylibre.com>,
 1aff0f813bb3fee55c5483be860b6885abdb81e5.1747175187.git.Jonathan.Santos@analog.com,
 Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
 broonie@kernel.org, Pop Paul <paul.pop@analog.com>
Subject: Re: [PATCH v8 10/11] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
Message-ID: <20250525104411.7108bfe3@jic23-huawei>
In-Reply-To: <aCuxQgCPgeFAqwWh@JSANTO12-L01.ad.analog.com>
References: <cover.1747175187.git.Jonathan.Santos@analog.com>
	<1aff0f813bb3fee55c5483be860b6885abdb81e5.1747175187.git.Jonathan.Santos@analog.com>
	<aCtmt+ozqSRDGQxi@JSANTO12-L01.ad.analog.com>
	<4843ec52-57e2-418a-b640-8e05ba60959e@baylibre.com>
	<aCuxQgCPgeFAqwWh@JSANTO12-L01.ad.analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 May 2025 19:31:30 -0300
Jonathan Santos <jonath4nns@gmail.com> wrote:

> On 05/19, David Lechner wrote:
> > On 5/19/25 12:13 PM, Jonathan Santos wrote: =20
> > > On 05/15, Jonathan Santos wrote: =20
> >=20
> > ... =20
> > >> +
> > >> +/* Decimation Rate range for each filter type */
> > >> +static const int ad7768_dec_rate_range[][3] =3D {
> > >> +	[AD7768_FILTER_SINC5] =3D { 8, 8, 1024 },
> > >> +	[AD7768_FILTER_SINC3] =3D { 32, 32, 163840 },
> > >> +	[AD7768_FILTER_WIDEBAND] =3D { 32, 32, 1024 },
> > >> +	[AD7768_FILTER_SINC3_REJ60] =3D { 32, 32, 163840 },
> > >> +};
> > >> + =20
> > >=20
> > > Since we're still discussing some points =E2=80=94 is the `step` in=20
> > > `[min step max]` for the IIO range additive or multiplicative? It is =
not=20
> > > clear on documentation, maybe on purpose or I have missed something.
> > >=20
> > > Here, decimation/OSR doubles from 8 or 32 for SINC5/WIDEBAND, and is =
a=20
> > > multiple of 32 for SINC3. So I'm still unsure how to represent this t=
o be
> > > clear to the user. =20

Ah.  Indeed. It is intended to be additive. Good catch.

> >=20
> > Sounds to me like sinc5/wideband should be lists instead of ranges.
> > It is only 6 values. =20
>=20
> So can we mix lists and ranges for the same attribute? I see that this
> is not usual.

Should be fine to mix. Userspace should never be assuming one or the other =
anyway.
I guess maybe some pretty tool might change how it presents the data depend=
ing
on what it sees in the first entry?  Do we know of any tool this would trip=
 up?

Jonathan

>=20
> >=20
> >  =20


