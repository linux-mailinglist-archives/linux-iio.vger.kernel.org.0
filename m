Return-Path: <linux-iio+bounces-22822-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EF2B28E26
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD79A58786D
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E85221C9E1;
	Sat, 16 Aug 2025 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1aeo4fd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3951826281;
	Sat, 16 Aug 2025 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755351192; cv=none; b=oKAka03jrAvrUWHqRQxjOTrdDMu9OwT1rTJV+6fdBfcw0r35NuBblScTdijKM2myufBzhrXRXDEqRmfZOa5omGXnxec9e2cOGVht8afu7DH55Bfz5BoJIOutykAJIEoralg2hvRct9LtC3aaD0Neas0uElYB4t4K8+IIO0u+RTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755351192; c=relaxed/simple;
	bh=5z/Ngh1sow4p1DfepKszTyKq2cFs4DdXPS1bYQr+7SM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfJNoaUtmsirLcXcnn2TPtM2bPuHzofMJGGhDRep8hwJFj4iz7t0YQX/RAAJZ2RxeXS7xfVaAboIm9OsXoasHQ7GlVEIhMPNenH2AkWsmmb045H1/dPbtQ+lVnDS/7TWE89ds02PzxNeVbMNnSC5ZfP+IKtf41HHUUAyE6wr98E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1aeo4fd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DC6C4CEEF;
	Sat, 16 Aug 2025 13:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755351191;
	bh=5z/Ngh1sow4p1DfepKszTyKq2cFs4DdXPS1bYQr+7SM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l1aeo4fdpSU/R3S4NPRhw46HyHttezNFaZOT6MyGafT5debrBdfEbI++fLMkuqzFU
	 28Jtut4aB0ymi0bDIH8NqieFIizIQCXkZWmXwB4JDdl34Fhcw/4T3xqVMF4Y/IIe3T
	 DN9uLXBj+M+DL5EUoEJapofPdLNsMdW8dDp2KF54GtIXqTzezfCdyyJjj6+d4ceELT
	 N1YV+fl1/dmiyPv2rsoMznNdgAFN6t6pqsHTSiCbK7gGAuIq0ZrVHpRyXxQ5Xr9uYR
	 H1OmqaIJmf7WuRXbGijNF4F7q/5Y2sr/P/0xhB30B7jW+2KtB9AtLJxNGnWyac1fH+
	 YEAwpTsZkfu5Q==
Date: Sat, 16 Aug 2025 14:33:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Angelo Dureghello
 <adureghello@baylibre.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7380: fix missing max_conversion_rate_hz on
 adaq4381-4
Message-ID: <20250816143303.6fe40510@jic23-huawei>
In-Reply-To: <CAHp75Vf3s1ftm0wBPbeTuKgO0W22ndpdcGE+zSMSHD=4z1O4Xg@mail.gmail.com>
References: <20250811-iio-adc-ad7380-fix-missing-max_conversion_rate_hs-on-ad4381-4-v1-1-ffb728d7a71c@baylibre.com>
	<CAHp75Vc_-2czsaZ_-3+cSWAzyvz-PASR5mjCyoAxTu9qSEYyLA@mail.gmail.com>
	<5732b907-ccb8-4302-8fd7-ded63a5d852b@baylibre.com>
	<CAHp75Vf3s1ftm0wBPbeTuKgO0W22ndpdcGE+zSMSHD=4z1O4Xg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Aug 2025 21:22:28 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Aug 11, 2025 at 9:18=E2=80=AFPM David Lechner <dlechner@baylibre.=
com> wrote:
> > On 8/11/25 2:07 PM, Andy Shevchenko wrote: =20
> > > On Mon, Aug 11, 2025 at 8:32=E2=80=AFPM David Lechner <dlechner@bayli=
bre.com> wrote: =20
>=20
> ...
>=20
> > >> +       .max_conversion_rate_hz =3D 4 * MEGA, =20
> > >
> > > MEGA --> HZ_PER_MHZ =20
> >
> > If we do this, we should fix up all of the other similar ones
> > in a separate patch. So I would leave this patch as-is. =20
>=20
> Will it happen sooner?
>=20
> > > With that done
> > > Reviewed-by: Andy Shevchenko <andy@kernel.org> =20
>=20
> I leave this to Jonathan because in spite of being a fix I still think
> it's better to use an appropriate multiplier (also note, MEGA appeared
> in the kernel much later than HZ_PER_* constants, which sounds in my
> favour).
>=20

I'll take this as is.  A future tidy up might switch them all over.
I've always been in two minds as to whether the unit specific ones
are helpful for this case where one of the scales is 1.

Applied to the fixes-togreg branch of iio.git.

Jonathan


