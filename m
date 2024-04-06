Return-Path: <linux-iio+bounces-4105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF0289AA54
	for <lists+linux-iio@lfdr.de>; Sat,  6 Apr 2024 12:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A19282AA8
	for <lists+linux-iio@lfdr.de>; Sat,  6 Apr 2024 10:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673C422EFD;
	Sat,  6 Apr 2024 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORwnPHoa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A3817C8B
	for <linux-iio@vger.kernel.org>; Sat,  6 Apr 2024 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712399383; cv=none; b=Psim0xPQ3wCmMjAcX/K3uTWmQ+Sx2V9VCpG703zTHHySquHVHnZ3DyVvxNLM55AN8wsKCAkrhci22KR2N6I/1N6RqCY3q6y0IVmIvNhYx2IeSC2fsoBPfDbvyZCDKJS4tAVPZBX6CJ4lw+fOOD6XLh9rDKDvdKT7atRjlJ/i/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712399383; c=relaxed/simple;
	bh=vEd5fPYqo+Vjs7AG5Jbet+H99VNZ9K1inKQDrmmRgGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfkM6rfRfsaoCstXDDvxsoj0fr/ggNW8DpsZ5wAp0KQoIcHWNSHy5TZ6jIrabVxmjAFy13LFKhJHzk+4R6rwIRxgT5fuuHX7puiR5x+l4J4/r+2u9YV/Yg/05oh+yzyuWwbStY1S14gzxFHsNMsc7DMiz2iwCm9XTSfubHs7yVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORwnPHoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523CEC433C7;
	Sat,  6 Apr 2024 10:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712399382;
	bh=vEd5fPYqo+Vjs7AG5Jbet+H99VNZ9K1inKQDrmmRgGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ORwnPHoavDh0hIp9tkRCEFmka0rEHjjkGbLL5X0xM+4ZUvEjJTehJyEaBnGcb1lBj
	 KCAAOVsvQoEd0tj91bOgds37i9TROlS1Mygxm36XYHlEBGSeeXJ3eSgu60fSrVcKl7
	 OKGckimJxJQ1VLNoRmnZmwSpXK28MrtP8S+IEfSUGxzTG+7ZTK1YD/GmVROtN9p2ga
	 iGi0v5QTdeHZlokWPDFWz4PkpJQDcOPPIAdMCIe8pTpenW7/OkK0dtpMDHIL2UD0nY
	 UibTaA2mZGSMumCLhtfbJP56NVBSIVjtVtC2IUlWuDrb8s5VrHbawvWwapwsGgFgzA
	 zsJWgMPLGi0Tw==
Date: Sat, 6 Apr 2024 11:29:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: linux-iio@vger.kernel.org, Marius Cristea
 <marius.cristea@microchip.com>, Mihail Chindris
 <mihail.chindris@analog.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Kim Seer Paller <kimseer.paller@analog.com>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, Cosmin Tanislav <demonsingur@gmail.com>, Nuno Sa
 <nuno.sa@analog.com>, Linus Walleij <linus.walleij@linaro.org>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/8] IIO: More use of
 device_for_each_child_node_scoped() and __free()
Message-ID: <20240406112929.5eb88dd9@jic23-huawei>
In-Reply-To: <4f29b9e1d713b1db94c86a829438f83bba686984.camel@gmail.com>
References: <20240330190849.1321065-1-jic23@kernel.org>
	<4f29b9e1d713b1db94c86a829438f83bba686984.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 04 Apr 2024 11:09:31 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2024-03-30 at 19:08 +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Mixture of new code that entered in parallel with the original conversi=
on
> > set to use this new scoped cleanup and cases I missed.=C2=A0 Note the
> > relevant code didn't make the 6.9 merge window but is queued up for
> > 6.10 in the togreg branch of iio.git and linux-next.
> >=20
> > Includes allowing easier building of the ab8500-gpadc driver to enable
> > testing the changes. Seems a sensible change to make in general.
> >=20
> > This series is making us of the automated cleanup introduced in
> > linux/cleanup.h and new device_for_each_child_node_scoped() to avoid
> > the need to remember to call fwnode_handle_put() in early exits from
> > loops over the child nodes. This can also be used for simple scope
> > based cleanup as seen in the ad3552 patch. In general this makes it
> > easier to avoid a common class of bug.
> >=20
> > Jonathan Cameron (8):
> > =C2=A0 iio: adc: ab8500-gpadc: Allow COMPILE_TEST builds
> > =C2=A0 iio: adc: ab8500-gpadc: Fix kernel-doc parameter names.
> > =C2=A0 iio: adc: ab8500-gpadc: Use device_for_each_child_node_scoped() =
to
> > =C2=A0=C2=A0=C2=A0 simplify erorr paths.
> > =C2=A0 iio: adc: ad4130: Use device_for_each_child_node_scoped() to sim=
plify
> > =C2=A0=C2=A0=C2=A0 error paths.
> > =C2=A0 iio: adc: ad7173: Use device_for_each_child_node_scoped() to sim=
plify
> > =C2=A0=C2=A0=C2=A0 error paths.
> > =C2=A0 iio: frequency: admfm2000: Use device_for_each_child_node_scoped=
() to
> > =C2=A0=C2=A0=C2=A0 simplify error paths.
> > =C2=A0 iio: dac: ad3552: Use __free(fwnode_handle) to simplify error
> > =C2=A0=C2=A0=C2=A0 handling.
> > =C2=A0 iio: adc: pac1934: Use device_for_each_available_child_node_scop=
ed()
> > =C2=A0=C2=A0=C2=A0 to simplify error handling.
> >=20
> > =C2=A0drivers/iio/adc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0drivers/iio/adc/ab8500-gpadc.c=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++--
> > =C2=A0drivers/iio/adc/ad4130.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 7 +--
> > =C2=A0drivers/iio/adc/ad7173.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 24 +++-------
> > =C2=A0drivers/iio/adc/pac1934.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 77 +++++++++++++------------------
> > =C2=A0drivers/iio/dac/ad3552r.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 59 +++++++++--------------
> > =C2=A0drivers/iio/frequency/admfm2000.c | 24 +++-------
> > =C2=A07 files changed, 73 insertions(+), 128 deletions(-)
> >  =20
>=20
> LGTM,
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20

Series applies with exception of patch 1 where discussion is ongoing.

Thanks,

Jonathan

