Return-Path: <linux-iio+bounces-16135-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6417A482B6
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 16:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFEC11888288
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0058D25EF95;
	Thu, 27 Feb 2025 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1DgGDbo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F7123BCE3;
	Thu, 27 Feb 2025 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669178; cv=none; b=HJpkJwKvehVmjM0tsxVufJA4SbI19sIa2AtYcSVAq9yaAvgjXJS0sC0OIh5YWkC4O9izuauEkbfNrOggdiMM3sI4UD3E03Had2tAkgv2AznFa+ql4YDzdXcOv3CGrlwMjevLYNorJR7B8OyaepbEnOwUSppGw52vRkWLmiDYoPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669178; c=relaxed/simple;
	bh=7STf7KR5l+VejlzjpR6E9zLjagUfqiPeoLC/F4HyI+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsiRELZich8Oe7y4101ideISEkRPt5hCvPcNgcWOqPFbDYSZl0trx1RJjEnVZLUIDgOmzqsafvXKv/bowJ8h1He3I0uSQIA1DvJX8JgA6RXth+cV8GKwqGp6H8z8+C31uc255rkWevI2dZsv5WV6ss0DCUuz++Vq4we9rhGWh1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1DgGDbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EC8C4CEDD;
	Thu, 27 Feb 2025 15:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740669178;
	bh=7STf7KR5l+VejlzjpR6E9zLjagUfqiPeoLC/F4HyI+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1DgGDbozJrXDySPeEwcaVWIuwFMGuBU00Hfx+8kMP+fKJY6gA5/1nay2+MTvwBIv
	 4mlESna60cg4Rx8ZpkUFHIf72oTAo+wQkVqvzL2jRCf8mtuoT89MRQ7V0Mx+xxdDgb
	 DMLu4CX1A8UtRup4TE8qLARxpydaweF/KQ/RYldAkeNPxpdQiO9hMsyUvGJi+FiAFA
	 4YVF2Yvaql9XEu5BxTQLTtFdAlw0rFgskYkC1LezmR3ALXNVyS+BPbo/Y2KNzdhkpR
	 wbuLSfMTjnO0iOP7AbCaaYxJDgrlZXEHybbIm7lfi36SX1rUKFrl7cFR+HNrRsY5j9
	 ZxOgqZ+gtOglQ==
Date: Fri, 28 Feb 2025 00:12:53 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>,
	=?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dharma.B@microchip.com,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 0/2] microchip-tcb-capture: Add Capture, Compare,
 Overflow etc. events
Message-ID: <Z8CA9RTZWChh9cJW@ishi>
References: <20250211151914.313585-3-csokas.bence@prolan.hu>
 <Z7h0AXV1zlgp9Nw-@ishi>
 <8fb9f188-3065-4fdc-a9f1-152cc5959186@prolan.hu>
 <Z7vihBqOgP3fBUVq@ishi>
 <bfa70e78-3cc3-4295-820b-3925c26135cb@prolan.hu>
 <Z7_xTQeTzD-RH3nH@ishi>
 <20250227135330.GC182392@tpx1.home>
 <Z8B1LDT-n2XTTp8q@ishi>
 <202502271437280a6701d8@mail.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S63rS5Zp1ngJmb2c"
Content-Disposition: inline
In-Reply-To: <202502271437280a6701d8@mail.local>


--S63rS5Zp1ngJmb2c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 03:37:28PM +0100, Alexandre Belloni wrote:
> On 27/02/2025 23:22:36+0900, William Breathitt Gray wrote:
> > On Thu, Feb 27, 2025 at 02:53:30PM +0100, Kamel Bouhara wrote:
> > > On Thu, Feb 27, 2025 at 01:59:57PM +0900, William Breathitt Gray wrot=
e:
> > > > Let me make sure I understand the situation correctly. This SoC has=
 two
> > > > Timer Counter Blocks (TCB) and each TCB has three Timer Counter Cha=
nnels
> > > > (TCC); each TCC has a Counter Value (CV) and three general registers
> > > > (RA, RB, RC); RA and RB can store Captures, and RC can be used for
> > > > Compare operations.
> > > >
> > > > If that is true, then the correct way for this hardware to be expos=
ed is
> > > > to have each TCB be a Counter device where each TCC is exposed as a
> > > > Count. So for this SoC: two Counter devices as counter0 and counter=
1;
> > > > count0, count1, and count2 as the three TCC; i.e. counter0/count{0,=
1,2}
> > > > and counter1/count{0,1,2}.
> >=20
> > [...]
> >=20
> > > > Kamel, what would it take for us to rectify this situation so that =
the
> > > > TCC are organized together by TCB under the same Counter devices?
> > >=20
> > > Hello,
> > >=20
> > > Indeed, each TCC operates independently except when quadrature mode is
> > > enabled. I assume this approach was taken to provide more flexibility=
 by
> > > exposing them separately.
> > >=20
> > > Currently only one channel is configured this would need to rework the
> > > driver to make the 3 TCCs exposed.
> > >=20
> > > Greetings,
> > > Kamel
> >=20
> > Skimming through the driver, it looks like what we'll need is for
> > mchp_tc_counts[] to have all three TCCs defined, then have
> > mchp_tc_probe() match on a TCB node and configure each TCC. Once that's
> > setup, then whenever we need to identify which TCC a callback is
> > exposing, we can get it from count->id.
> >=20
> > So for example, the TC_CV register offset is calculated as 0x00 +
> > channel * 0x40 + 0x10. In the count_read() callback we can leverage
> > count->id to identify the TCC and thus get the respective TC_CV register
> > at offset + count->id * 0x40 + 0x10.
> >=20
>=20
> We can't do that because the TCC of a single TCB can have a mix of
> different features. I struggled with the breakage to move away from the
> one TCB, one feature state we had.
> Be fore this, it was not possible to mix features on a single TCB, now,
> we can have e.g. the clocksource on TCC 0 and 1 of TCB0 and a PWM on
> TCC 2. mchp_tc_probe must not match on a TCB node...

Okay I see what you mean, if we match on a TCB mode then we wouldn't be
able to define the cases where one TCC is different from the next in the
same TCB.

The goal however isn't to support all functionality (i.e. PWM-related
settings, etc.) in the counter driver, but just expose the TCB
configuration options that affect the TCCs when configured for counter
mode. For example, the sysfs attributes can be created, but they don't
have to be available until the TCC is in the appropriate mode (e.g.
return -EBUSY until they are in a counter mode).

Is there a way to achieve that? Maybe there's a way we can populate the
sysfs tree on the first encountered TCC, and then somehow indicate when
additional TCCs match. Attributes can become available then dynamically
based on the TCCs that match.

William Breathitt Gray

--S63rS5Zp1ngJmb2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ8CA9QAKCRC1SFbKvhIj
KzfbAQDlTYiUlgbcGQwRUT570H/RH0ghKls+Gy2YmhpCVscIcAD9E/gGa6CbXDL+
5KRRytXkMqv0z8iXRNmCVcaYM07jxw4=
=xdBI
-----END PGP SIGNATURE-----

--S63rS5Zp1ngJmb2c--

