Return-Path: <linux-iio+bounces-18622-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7015A9C098
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 10:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8D3461815
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 08:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1BE233D7B;
	Fri, 25 Apr 2025 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLETo7rC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F09A233723
	for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568905; cv=none; b=cMnhOskO18Zy+VHgLi/mHurrLy8ZbtJxjxFck6R6I8ZOqxxvmaiOlPXRt+FR6QPU0n3aGXB1aGwpBTwaLIc5sgfkHv0yMzvHly69c6G6UJXo8ihep9hKuYOmCxwNgUA205Kie3lq8igxrDSbcPdrj3Ed2i7eqcveSi0yWUlJip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568905; c=relaxed/simple;
	bh=LID4vhhyAfA7m+2PmE21lHedYmfZjhtByMsY8XRkzOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCIr49ldU5vic4ztdSVGYocq6txhmri6aEY2HMIFcVH0+m+zeSd3J0ck6E0kUXQuoTlGzhTLhOxtbg6NB3KOhjfaRWBCW9flkUZ/ExCEivpBeNp2pJJEw+ezoLts9lJeUTg0WQe1NeOCFw5mGLpMSDMzazFGT5IR0s9+Z0f5Q2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLETo7rC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E006C4CEE4;
	Fri, 25 Apr 2025 08:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745568904;
	bh=LID4vhhyAfA7m+2PmE21lHedYmfZjhtByMsY8XRkzOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VLETo7rCiKV8MlLjY30tc7iGwPaiJ4hQWYVwiVXVCrUjxpBfqHwPulN5XRLR8v2kV
	 7RUD5KPXTwmyX/4KDr7QsCPovE2QSq8Qw62pRjEOm6wurqW+1G10GpyuZOoTigGUJx
	 cUmfZjntWXRRFQep2pfnt8cglJlMDLU/cIfoZDt4+eyUQ5CuyXPnZHNUrdAq8AdmXW
	 WdFOiBSG+BWaQc8zy68tpkXyDBkAP2n3yifMUReaEtZZDVcoMM90AiU98N4/ZGbphk
	 RNKV1Kl/JvQmpTMm6s/ldI9HMKygAagLm7Kd8CspxT5mlCGAn1/YiWvuulzwD7lLQ3
	 SSGbm2i1x42Lw==
Date: Fri, 25 Apr 2025 09:14:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nattan Ferreira <nattanferreira58@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <jpaulo.silvagoncalves@gmail.com>,
 lucasantonio.santos@usp.br, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: Prevent concurrent access during
Message-ID: <20250425091458.28e9ceca@jic23-huawei>
In-Reply-To: <CAKj1jXr3pacMg-9DkUijiJH0e_YSB=NoWcS+DcOu-vzwSrAWDA@mail.gmail.com>
References: <20250419232316.36002-1-nattanferreira58@gmail.com>
	<c2golk6627ybfpw3t7lnerritq2yysi5zhdlvahnvhxoevmojn@j3d2stvivkyk>
	<20250420211706.GB5621@francesco-nb>
	<CAKj1jXr3pacMg-9DkUijiJH0e_YSB=NoWcS+DcOu-vzwSrAWDA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Apr 2025 15:04:25 -0300
Nattan Ferreira <nattanferreira58@gmail.com> wrote:

> On Sun, Apr 20, 2025 at 6:17=E2=80=AFPM Francesco Dolcini <francesco@dolc=
ini.it> wrote:
> >
> > On Sun, Apr 20, 2025 at 01:07:28PM -0300, Jo=C3=A3o Paulo Gon=C3=A7alve=
s wrote: =20
> > > > Use iio_device_claim_direct() to protect register access via debugfs
> > > > from conflicting with buffered capture modes. This prevents data
> > > > corruption and ensures correct device operation when users access
> > > > registers while streaming data.
> > > > =20
> > >
> > > but debugfs is meant to be used during development/integration,
> > > where this probably is not an issue. =20
> >
> > Is even worth doing any such a change? I assume Jonathan will have an
> > opinion on what's the expectation for an IIO driver.
> >
> > Nattan, can you explain why you need such a change? What is the use
> > case?
> >
> > Francesco
> > =20
>=20
> Hi Francesco and Jo=C3=A3o,
>=20
> Thanks for the feedback and your thoughts on this.
>=20
> To clarify the use case: The primary reason for preventing both read
> and write access when the buffer is active is to avoid potential data
> corruption and inconsistencies. When the buffer is streaming data,
> concurrent register access (either reading or writing) can lead to
> unexpected behaviors, such as incorrect register values or misaligned
> data. This can cause confusion and make it harder to debug or test the
> driver, as well as introduce risks in production if these issues
> persist unnoticed.
>=20
> I understand that development and integration are critical stages, and
> while it's tempting to allow register access for diagnostic purposes,
> my concern is that even during this phase, uncoordinated access to
> registers could result in misleading data, which could cascade into
> errors or incorrect assumptions.
>=20
> With that said, I do see the merit in Jo=C3=A3o=E2=80=99s suggestion to a=
llow read
> access while blocking writes. If that aligns better with the IIO
> driver expectations, I=E2=80=99m happy to update the patch accordingly.
>=20
> Let me know your thoughts or if you think there=E2=80=99s a better approa=
ch here.

My personal view is that these debug interfaces provide a terrible way
to shoot yourself in the foot whenever we enable them.   As such I'm not
really convinced that we need protections.   Limiting write access is
probably fine but it also an ABI change. Technically someone might be using
that interface in their userspace code and see breakage at which point we
get into  the silly situation of having to revert this hardening...

I'd be interested in a proposal to lock these down in general via a config
parameter or new drivers restricting things as you have done here.

Jonathan

>=20
> Best regards,
> Nattan Ferreira


