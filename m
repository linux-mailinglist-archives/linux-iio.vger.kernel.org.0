Return-Path: <linux-iio+bounces-18253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB7BA938D9
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5128E1751
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 14:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45EE1D54E9;
	Fri, 18 Apr 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUY5A2r/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6EEEC8;
	Fri, 18 Apr 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744987872; cv=none; b=E/zSSRAPafUDk8h5VoqEqmJkltvsWuFJht0SrfWphlaSmuM+9TuGJkgtc+NpBBlxCYT9cvpIJssxFPGd2Wb31/r3NoNahKP7N6s/LzkBRsRMlSC71a884ior2QHNeyDz1Kiws4d38gRScOvhu2vBcv/LUZaj/xWQB1YJNr+FSnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744987872; c=relaxed/simple;
	bh=bNG069bANGf30ORJdaTSbWaHvDsABZiESkRt7KTKH9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsjmojizHHiVi6dQNQSjW6PPZy8RlSl3YXY2jPS4FvWjG0fAqhCG2Voj/zMu+mLXVlpIUE2ceIeNzS5MBR7RvG9AoKqqtKylQ4F3EgBOKTtYMmQbiBG/SKxkuFf7CADBNIf0lESG/eQh+0sEpKeaUMHyxwG/upNzYlncJ7hGbr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUY5A2r/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A43EC4CEE2;
	Fri, 18 Apr 2025 14:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744987871;
	bh=bNG069bANGf30ORJdaTSbWaHvDsABZiESkRt7KTKH9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lUY5A2r/U0nCOjjtPhudNKNqeAXxrr/J53n7CF7KYuRy50/cqSDje+VCmg7F4MVo1
	 oIDbHdqmT8faaGRgbVlwxWmVZuzGujLJyU84Ypb/HoA3+NHWcbjuVdhO26oXWC/WrK
	 ++kt3Y09BRhH2F9LLdlLdHnTwu6KmMO22IUmKmFPAexz/TUEEag39zeTZuY/MR11Oh
	 ah6SR18wRB2GysTaj2jqWjfBeOGL+45C9VRkKo8yCBv7UxDVI8Dxy3heFOLa550V/0
	 osGGsMf4bElmwzXxZldkl0pXhXaiGqd6VOFFuaghA3QxTzY0Dn8mR+sUusyV7Rz+VD
	 TPiK8JB96MGOg==
Date: Fri, 18 Apr 2025 15:51:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, David Lechner 
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Tomasz Duszynski <tduszyns@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Andreas Klinger
 <ak@it-klinger.de>, Petre Rodan <petre.rodan@subdimension.ro>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 4/8] iio: chemical: pms7003: use aligned_s64 for
 timestamp
Message-ID: <20250418155102.563607f5@jic23-huawei>
In-Reply-To: <2ac349c8dd9b7fcc86e2caae1f74943c23289921.camel@gmail.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	<20250417-iio-more-timestamp-alignment-v1-4-eafac1e22318@baylibre.com>
	<20250417183535.00004d87@huawei.com>
	<2ac349c8dd9b7fcc86e2caae1f74943c23289921.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Apr 2025 09:51:37 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2025-04-17 at 18:35 +0100, Jonathan Cameron wrote:
> > On Thu, 17 Apr 2025 11:52:36 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >  =20
> > > Follow the pattern of other drivers and use aligned_s64 for the
> > > timestamp. This will ensure that the timestamp is correctly aligned on
> > > all architectures.
> > >=20
> > > Also move the unaligned.h header while touching this since it was the
> > > only one not in alphabetical order.
> > >=20
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > > =C2=A0drivers/iio/chemical/pms7003.c | 5 +++--
> > > =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pm=
s7003.c
> > > index
> > > d0bd94912e0a3492641acd955adbc2184f4a11b3..e05ce1f12065c65d14b66ab86e2=
91fab47805de
> > > c 100644
> > > --- a/drivers/iio/chemical/pms7003.c
> > > +++ b/drivers/iio/chemical/pms7003.c
> > > @@ -5,7 +5,6 @@
> > > =C2=A0 * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
> > > =C2=A0 */
> > > =C2=A0
> > > -#include <linux/unaligned.h>
> > > =C2=A0#include <linux/completion.h>
> > > =C2=A0#include <linux/device.h>
> > > =C2=A0#include <linux/errno.h>
> > > @@ -19,6 +18,8 @@
> > > =C2=A0#include <linux/module.h>
> > > =C2=A0#include <linux/mutex.h>
> > > =C2=A0#include <linux/serdev.h>
> > > +#include <linux/types.h>
> > > +#include <linux/unaligned.h>
> > > =C2=A0
> > > =C2=A0#define PMS7003_DRIVER_NAME "pms7003"
> > > =C2=A0
> > > @@ -76,7 +77,7 @@ struct pms7003_state {
> > > =C2=A0	/* Used to construct scan to push to the IIO buffer */
> > > =C2=A0	struct {
> > > =C2=A0		u16 data[3]; /* PM1, PM2P5, PM10 */
> > > -		s64 ts;
> > > +		aligned_s64 ts; =20
> >=20
> > Bug I think..=C2=A0 So another one that really needs a fixes tag.
> > For all these we might be lucky with padding on the allocations
> > but we shouldn't really rely on that. =20
>=20
> Agreed... We're likely not that lucky for x86-32
Applied with
Fixes: 13e945631c2f ("iio:chemical:pms7003: Fix timestamp alignment and pre=
vent data leak.")
and +CC stable.
>=20
> - Nuno S=C3=A1
> >  =20
> > > =C2=A0	} scan;
> > > =C2=A0};
> > > =C2=A0
> > >  =20
> >  =20
>=20
>=20


