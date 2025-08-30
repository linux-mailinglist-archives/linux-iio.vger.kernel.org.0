Return-Path: <linux-iio+bounces-23502-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611DDB3CF20
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 21:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA5F2054D1
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 19:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DB92DECCE;
	Sat, 30 Aug 2025 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7Z+BbC+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7442DECB1;
	Sat, 30 Aug 2025 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756583314; cv=none; b=tomA75Cqf4qWaJdiS0Q1bzzdiDw55nNEdXOKDlgXt7zTI4VfWs0EKsiRdpm35Ok18yIgCSpXk3YoekDvHzMM5xfIFkP8Vsd+yoj2q+ODgCAD03BSE+79ldqbGWveyb1Ps1wLNkKeLZ/4ugDImZkUoxrSkecvbG7D0N1nTUBXyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756583314; c=relaxed/simple;
	bh=nxhkrwDWENSNGtc5OQq3ZamPiocNMcAhP7SnWuBKeMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNCMmEWY44TxfWxEMDBrNqjFL7B9vrdEcpQqpvrRGVNYC60c7pB2+2nIZzOvbPgsqCWFpDvLckxwOkOjvbw1SgXPJiI1ELp8wd1Dnw9KM2bxK9u1Mb2FyyCn0eQEIkknJ20G2oclwQahtJzA9mDLRxjBU1H/DwIWutrF1wV6xWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7Z+BbC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C67C4CEEB;
	Sat, 30 Aug 2025 19:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756583314;
	bh=nxhkrwDWENSNGtc5OQq3ZamPiocNMcAhP7SnWuBKeMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h7Z+BbC+OVLkECjKMPowRJAJ1i99aJNefncaPk+TMrRFcFCYD8pB6uqDzlFAOs1L9
	 +CpXRKZ0+NpYOehvGjICig0N/9FBN+YcqqYQfFH8KgVfRzPE+ruUBzs1dgBm45f5So
	 GXPPpHlfxtadQMBPnU0aNbnYRRPsKPOmvMmXZOJs4qt1nwIpfUu5IdJ+0KSzdmdJMi
	 I4sphF+DdMwfyUN1BCfPWf4Ic4w2tjwYFxLZcM/OSCg3qjimLsqEt62PNbRj6IKBTg
	 9qx+HGW+cD14Xej85hjcbL4DRezMME9mPyzjQqSuq8acTeuf5AsiPVKjwZ9IffD6xq
	 MVWQM0CR+YIlA==
Date: Sat, 30 Aug 2025 20:48:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: adc: ad7124: add external clock support
Message-ID: <20250830204824.2f9d7a48@jic23-huawei>
In-Reply-To: <CAHp75Vf8fAFin1tJ-yjr22RPuDgBEBnj6JO3GkjDcZsmYoOfYA@mail.gmail.com>
References: <20250828-iio-adc-ad7124-proper-clock-support-v3-0-0b317b4605e5@baylibre.com>
	<20250828-iio-adc-ad7124-proper-clock-support-v3-3-0b317b4605e5@baylibre.com>
	<CAHp75VdtQ8vKULomgqPxwX=WZWUde7PC129BEznYqefd-U4DEQ@mail.gmail.com>
	<a20356ca-05ca-4c99-819b-4b278e799f2a@baylibre.com>
	<CAHp75Vf8fAFin1tJ-yjr22RPuDgBEBnj6JO3GkjDcZsmYoOfYA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Aug 2025 22:11:12 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Aug 29, 2025 at 8:19=E2=80=AFPM David Lechner <dlechner@baylibre.=
com> wrote:
> > On 8/29/25 10:53 AM, Andy Shevchenko wrote: =20
> > > On Fri, Aug 29, 2025 at 12:55=E2=80=AFAM David Lechner <dlechner@bayl=
ibre.com> wrote: =20
>=20
> ...
>=20
> > >> +                       if (clk_hz > MEGA) { =20
> > >
> > > I read your answer, but maybe I missed something?  Can we use (1 *
> > > HZ_PER_MHZ) here? =20
> >
> > I suppose we can. But it doesn't add any additional information.
> > We already know we are dealing with Hz because of clk_hz and 1
> > is implicit. So it is just a matter of style preference. Since I
> > read a lot of code, I tend to prefer the minimal approach - it is
> > less to read and still has the same meaning. =20
>=20
> Physicist in me prefers pedantism in comparison of the units. We don't
> compare kilometers with kilograms (maybe not the best example, though,
> if you understand what I mean :-).
>=20
As I don't think either of you have particularly strong opinions on this
(or at least you'll both be flexible) and I want to merge it.
I tweaked to 1 * HZ_PER_MHZ and applied the series.

Thanks,

Jonathan

> > >> +                               clk_sel =3D AD7124_ADC_CONTROL_CLK_S=
EL_EXT_DIV4;
> > >> +                               st->clk_hz =3D clk_hz / 4;
> > >> +                       } else {
> > >> +                               clk_sel =3D AD7124_ADC_CONTROL_CLK_S=
EL_EXT;
> > >> +                               st->clk_hz =3D clk_hz;
> > >> +                       } =20
>=20
>=20


