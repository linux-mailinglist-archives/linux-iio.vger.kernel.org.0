Return-Path: <linux-iio+bounces-19038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B37C4AA8702
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 16:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDB51897E2D
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F371C84AE;
	Sun,  4 May 2025 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYmW/Pv+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8291B0420;
	Sun,  4 May 2025 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746370552; cv=none; b=FOXfwbVdP1ge985lkYSnmt0hiiYDkqK1MoRFR98YpdrTmzJoFgrw/yECI8o6Mm67nIdcKT++0U9Y+IM1nCxe1d9giL8IkgA2rhRXg/t0e7K1QRneYYej7RKQYiFpKAVZJ5+DNkkP2kbW45FCU/5Pt7cTlhNwjXCiqsSW3PRhkUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746370552; c=relaxed/simple;
	bh=vrj1OZWNkG66dZ01sAaU7OPbnkPuToJd3eMZlGtWN5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3yxPELCwjW4EI8ZATUHGJGd328gh4d1/0gNv4LYUgUfkR/hU6M+KJ4y6Qy2IPfmYQkUZByBZ4JGTPIoOMH+sIje41gXB6VT60c1RacixGLYBidAFEcAV3B6d0Y4B2ZMnMxAWoknSPvQ4zyvLTHF7hI2Qs9ikKb7TLZem3ZpsWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYmW/Pv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46500C4CEE7;
	Sun,  4 May 2025 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746370552;
	bh=vrj1OZWNkG66dZ01sAaU7OPbnkPuToJd3eMZlGtWN5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kYmW/Pv+S1NISht7XdVEkKlYD10fOVRop2doU0a/MeY/QKjfn5Wgz5iBBMaRtcnej
	 H2hOrL01uuj/LPz7RMn5k4A0omEP8qUYyABdCKxRemin3/+B1RrNREsZXI8Q0EHL8J
	 gIxcvoTybZ1eMESzNWItXDzhI3forwVr22EmT7VUPIoXe4XDjcF6uxCluMtjqP8O3t
	 NOsk64onSN3z8uBeov6JN7cWF7/bDOC0ZTbroxdlbzZa35gE2VeGlSecarBRpgM8KA
	 pHYEzy0XiL5Z3vrgm5NMt/s5DIPgyV8N4wvuT5Q8NWcHtu55fM3QOBm/wBv0g/3sOk
	 SRvRXlrGOJlBQ==
Date: Sun, 4 May 2025 15:55:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich 
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= 
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7606: explicit timestamp alignment
Message-ID: <20250504155544.60fe3464@jic23-huawei>
In-Reply-To: <d7f00a8c9d4da6f780c1ec067be2702fa0e60ea1.camel@gmail.com>
References: <20250428-iio-adc-ad7606-fix-buffer-alignment-v1-1-88dfc57e5df0@baylibre.com>
	<d7f00a8c9d4da6f780c1ec067be2702fa0e60ea1.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Apr 2025 14:01:54 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2025-04-28 at 21:17 -0500, David Lechner wrote:
> > Use struct with aligned_s64 timestamp to make timestamp alignment
> > explicit. Technically, what we have works because for all known
> > architectures, IIO_DMA_MINALIGN is a multiple of __alignof__(s64).
> > But this way, we don't have to make people read the comments to know
> > why there are extra elements in each buffer.
> >=20
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.

Thanks,

Jonathan

>=20
> > =C2=A0drivers/iio/adc/ad7606.h | 13 ++++++++-----
> > =C2=A01 file changed, 8 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> > index
> > 89d49551eaf515bab9706c12bff056dfcb707b67..441e62c521bcbea69b4f70bb2d55f=
65334d2
> > 2276 100644
> > --- a/drivers/iio/adc/ad7606.h
> > +++ b/drivers/iio/adc/ad7606.h
> > @@ -155,12 +155,15 @@ struct ad7606_state {
> > =C2=A0	/*
> > =C2=A0	 * DMA (thus cache coherency maintenance) may require the
> > =C2=A0	 * transfer buffers to live in their own cache lines.
> > -	 * 16 * 16-bit samples + 64-bit timestamp - for AD7616
> > -	 * 8 * 32-bit samples + 64-bit timestamp - for AD7616C-18 (and
> > similar)
> > +	 * 16 * 16-bit samples for AD7616
> > +	 * 8 * 32-bit samples for AD7616C-18 (and similar)
> > =C2=A0	 */
> > -	union {
> > -		u16 buf16[20];
> > -		u32 buf32[10];
> > +	struct {
> > +		union {
> > +			u16 buf16[16];
> > +			u32 buf32[8];
> > +		};
> > +		aligned_s64 timestamp;
> > =C2=A0	} data __aligned(IIO_DMA_MINALIGN);
> > =C2=A0	__be16				d16[2];
> > =C2=A0};
> >=20
> > ---
> > base-commit: b475195fecc79a1a6e7fb0846aaaab0a1a4cb2e6
> > change-id: 20250428-iio-adc-ad7606-fix-buffer-alignment-9fcde71687dc
> >=20
> > Best regards, =20


