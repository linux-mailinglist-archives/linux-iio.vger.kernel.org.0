Return-Path: <linux-iio+bounces-15358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29438A3156F
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 20:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124AD3A04B0
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 19:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2A5264F81;
	Tue, 11 Feb 2025 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD3ER5Te"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9401326388A;
	Tue, 11 Feb 2025 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302108; cv=none; b=Lni2id2bDcLJT7GIBoJj/7Yjl11WOp5/twRzAB7FO5MeQbkPe/NBgkciARssHXGa+W45HKDzSznSlhUXJ6q4qy3gYZzT+DAV/LWmyX+pBg4HxJ7uv+1vcX6M9NsdwhJJ1ER4teVWAdVxWlZAWpJDyIHxLNIkz/KDYjzn6vqJddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302108; c=relaxed/simple;
	bh=FtiCB/Gnit/rjhpi4OMYVtXqmpza4wtHtS9goXNepZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCC6fnur3Jsp8S88ndUTBcTWpC3tZJOoPin5ksb5bv5ifwgEMRt9O4tSYrkXqRNmgH/VXsmE311PIXdhF9q2l02nTtNzJBZRWMchlEObMah+CRGvyOFTo+mdIYtKcgVtFEdzYNm25pXMcOJ1PuD2lzBZnlDAUkPHy7cuIiZnpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD3ER5Te; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B24C4CEDD;
	Tue, 11 Feb 2025 19:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739302108;
	bh=FtiCB/Gnit/rjhpi4OMYVtXqmpza4wtHtS9goXNepZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bD3ER5TeFDc1/t8c6JcAsesFhr004XSAaDs+wWifLhe9Xq1WuzTXvU6tMa7LZZzCH
	 x8ggsZEEkJfHGZTb80k8HRy4fBERdEIjSbF2Pv3G6p/NAoczO3Aqp0tGVhpZ6RHCKQ
	 RYk1jJXc1SegL4CfEEpy1zX2lNGAqrkFehNSO5udyIjwMlYjRm22d1vQLTYkXvVbRD
	 L5eRXh9yWkFeZdWR70w8nHss1GeGRUl3FeOecdtKRxPC8JXTrP09NlG8KmBYaUnjkz
	 HKvdXYUT1q6R9EShsmePqWHZUGZ2GLNQNKeCwEQ+7nW+39Gm05bofaQEYQJDlYqQxg
	 ltVXRYXRKIKYw==
Date: Tue, 11 Feb 2025 19:28:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa	 <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: adi-axi-dac: drop io_mode check
Message-ID: <20250211192819.0c0be5fb@jic23-huawei>
In-Reply-To: <4c526d89750e1578d8c341caae77aac0321d7ace.camel@gmail.com>
References: <20250206-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-1-863a4b2af4ea@baylibre.com>
	<20250208154521.193da461@jic23-huawei>
	<2ae962c19bc9d180dabf52e256a1d6bf215f9bf0.camel@gmail.com>
	<20250210191353.2a5fcd4b@jic23-huawei>
	<4c526d89750e1578d8c341caae77aac0321d7ace.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Feb 2025 09:56:31 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2025-02-10 at 19:13 +0000, Jonathan Cameron wrote:
> > On Mon, 10 Feb 2025 10:05:47 +0000
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > On Sat, 2025-02-08 at 15:45 +0000, Jonathan Cameron wrote: =20
> > > > On Thu, 06 Feb 2025 09:36:14 +0100
> > > > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > > > =C2=A0  =20
> > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > >=20
> > > > > Drop mode check, producing the following robot test warning:
> > > > >=20
> > > > > smatch warnings:
> > > > > drivers/iio/dac/adi-axi-dac.c:731 axi_dac_bus_set_io_mode()
> > > > > =C2=A0 warn: always true condition '(mode >=3D 0) =3D> (0-u32max =
>=3D 0)'
> > > > >=20
> > > > > The range check results not useful since these are the only
> > > > > plausible modes for enum ad3552r_io_mode.
> > > > >=20
> > > > > Fixes: 493122c53af1 ("iio: dac: adi-axi-dac: add bus mode setup")
> > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>=C2=A0=
  =20
> > > > Ah. I missed this.=C2=A0 Anyhow made the same change directly so al=
l is well
> > > > than ends well!
> > > > =C2=A0  =20
> > >=20
> > > Hi Angelo, Jonathan,
> > >=20
> > > I wanted to reply to this one when I saw it but I haven't done right =
away
> > > and
> > > then totally forgot. Sorry about that!
> > >=20
> > > I don't really agree with the "fix" in this patch. AFAIU, smatch is
> > > complaining
> > > since the enum is apparently defaulting to an unsigned type which mea=
ns
> > > doing
> > > the >=3D 0 check is useless. But we should keep the upper bound... =20
> >=20
> > Why? It's an enum so unless we are messing around with deliberate casts=
 the
> > compiler should always be able to spot this. The check may be needed on=
 a
> > future =20
>=20
> I do not think the compiler will catch this:
>=20
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index c1dae58c1975..5234dd5e227d 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -293,7 +293,7 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev
> *indio_dev)
>          * Back bus to simple SPI, this must be executed together with ab=
ove
>          * target mode unwind, and can be done only after it.
>          */
> -       st->data->bus_set_io_mode(st->back, AD3552R_IO_MODE_SPI);
> +       st->data->bus_set_io_mode(st->back, -1);
>=20
> A W=3D1 build (clang) did not complained at all... Maybe tools like smatc=
h will.
>=20
> > date if we add more types to that enum.
> >=20
> > So I agree the check wasn't terrible and perhaps acted as hardening but=
 it
> > isn't strictly speaking doing anything today.
> >  =20
>=20
> It's not a very super important check, I agree... and being an enum will =
be
> easier to spot a raw value being passed during a review but since we alre=
ady had
> the check, I don't see why we should remove it completely and not keep th=
e upper
> bound.

ok.  I'd take a patch putting the upper bound back.   Enums checking is an =
interesting
hole to fall down.

Jonathan

>=20
> - Nuno S=C3=A1


