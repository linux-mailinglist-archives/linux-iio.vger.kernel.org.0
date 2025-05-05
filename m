Return-Path: <linux-iio+bounces-19118-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32B5AA9868
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 18:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E86D16E690
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 16:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A95826989B;
	Mon,  5 May 2025 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFCfPJKV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45527269820;
	Mon,  5 May 2025 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461653; cv=none; b=LtywZD2cqKUbUpke0Ruq3ldLbahQsyD22Alv1t8oqiFX5aADmu6ig2IEd+aMF4rzTWOKnRdogZCh6F6Y3HGpSlADFff4fuNzxKB7HFD7O2KTBYABbSPq5or+MPgaph7vF3K2qdYXGlwkQiCB/dQrzL9DfP7zYxHSfEMnmA5mdCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461653; c=relaxed/simple;
	bh=c2akGNl2Wk40azl4vCjlgOQQV6prinJ8u3YfroziW5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eisYy/oFk2p61kPc55AnGa3sB0W/6BRhVAFcENTwEX0/juvFuKwjF5xqtSERMny2jH9rm6Z0E9BQiRfsbZ4DGaxHvbUlRSgxQCBrg9C63va8TOfmjvMb/yjYKMjGo+wyUlUFRbrG0jE0wvl04oT1fuETJjz2WhyPFcrwBsey4vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFCfPJKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C95C4CEEF;
	Mon,  5 May 2025 16:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746461652;
	bh=c2akGNl2Wk40azl4vCjlgOQQV6prinJ8u3YfroziW5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hFCfPJKVaR69kaDC46ULPKdDKjFlPl/Yv7TkZcAsI7r2aOVMRjEdtoi8Ld1zEdbG5
	 2hcNQPuBA/FmjxRz8jvgknrxxhyqG4CtUtgQqlmMU02vyVPLiuhKfZ+zq8T+NrfEYx
	 FzYOqmUNYc1H80S0T43+LwpkuZwjMQKaJYPaNDkCcrDfK5mp1T1InvJLHlGPZ4khUY
	 PAVWxRV1Qcc6H/WVD/JsYqX4te4yZTqf7LkAtb6ON5ad2htJ53Xo7PRl3vF0RhBXyt
	 IZQR7JYSvrUaBoUPkRSko9ypmhiSPeRKtMZduA6w97mMtiIzU9K2HPomlk1C7IWtVG
	 +sNi/lsHYfT6A==
Date: Mon, 5 May 2025 17:14:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, nuno.sa@analog.com,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH] iio: adc: ad4000: Avoid potential double data word read
Message-ID: <20250505171406.5319a00e@jic23-huawei>
In-Reply-To: <Z_9SZ_XgKfv4DliG@smile.fi.intel.com>
References: <8f765cfd6e93fad4e755dd95d709b7bea2a388e2.1744718916.git.marcelo.schmitt@analog.com>
	<CAHp75VendQGLdpggySS3mX6M2YSeS70bvE8yg7sp_LNGDS-Scg@mail.gmail.com>
	<22858e4f-db8e-4c97-8551-a1934a9f2fe7@baylibre.com>
	<CAHp75VdKpSnwfKO4GaJmVOs8kHASsZ4V9yNcZ7EF_GVoDNmrfw@mail.gmail.com>
	<CAHp75VfuCkohVLUJKgcMrgad-fRk4aKx_Ki0gRxxhJP3qgvS1g@mail.gmail.com>
	<Z_9SZ_XgKfv4DliG@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Apr 2025 09:47:03 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Wed, Apr 16, 2025 at 09:01:02AM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 16, 2025 at 8:59=E2=80=AFAM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote: =20
> > > On Wed, Apr 16, 2025 at 12:22=E2=80=AFAM David Lechner <dlechner@bayl=
ibre.com> wrote: =20
> > > > On 4/15/25 1:02 PM, Andy Shevchenko wrote: =20
>=20
> ...
>=20
> > > > It would have to be:
> > > >
> > > >         xfers[1].len =3D roundup_pow_of_two(BITS_TO_BYTES(chan->sca=
n_type.realbits));
> > > >
> > > > But that gets too long for 1 line =20
> > >
> > > Actually there are a handful of drivers including SPI core that need
> > > that helper already, I would prefer to have a helper defined in spi.h.
> > >
> > > , so I prefer what Marcelo wrote. =20
> > > >
> > > > Maybe an idea for another day:
> > > >
> > > > #define SPI_LEN_FOR_BITS(bits) roundup_pow_of_two(BITS_TO_BYTES(bit=
s)) =20
> > >
> > > Right, but as static inline to have stricter types.
> > > =20
> > > > There are a couple of places in spi/ that could use this and several
> > > > iio drivers. =20
> >=20
> > Or even wider, in bitops.h / bit*.h somewhere. Let me craft a patch. =20
>=20
> Just sent a mini-series, you are in Cc there.
>=20

I've picked this one up for now.  Assuming we'll cycle round to use the new
helper once it's available in my upstream.

Thanks,

Jonathan

