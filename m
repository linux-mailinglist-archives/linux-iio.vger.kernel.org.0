Return-Path: <linux-iio+bounces-16862-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB15A62D11
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 13:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E07189C2D0
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 12:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AC81F8BC8;
	Sat, 15 Mar 2025 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsXU3DSO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1413D1862;
	Sat, 15 Mar 2025 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742043466; cv=none; b=uVr4FIoRcmFvweSsDLmPyHW6ky6rWgkkqNuwW15E6ScCqd7xAuJ0Jbi7d7JIukpa9zS1yOukM5OzEs4sWpcLI4MKHLwS/w/XOrhFyIxAe3TjOVqQzlvpmVTX2cxBjI273gVSYkkfZssSA26kk3fibZA1vAwQzgg1BVpbadqVRhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742043466; c=relaxed/simple;
	bh=4Uq4QTnEUqaSeewmKwwoXOqFpd/hSm7kN4Y5MywxXN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPK1c9Tfa5han3jZXZWf9Q1Hyx6DLLErAZG7bjF2Xq2LMcruf9L1EOBBKrnDm6kXaiMo88yemlDEsUVVDyvdV0BJ2ItRcEwgYPqkC5TTa8oPUBTVKGzTHkvMNnr1U2Nh9odYE694GafdkQJnkUxJPKcl6ObikgTRfX2FdkHI+kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsXU3DSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D97C4CEE5;
	Sat, 15 Mar 2025 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742043465;
	bh=4Uq4QTnEUqaSeewmKwwoXOqFpd/hSm7kN4Y5MywxXN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XsXU3DSObPiHF949yfXcI7X2w1dhvSiLJAW8WJS5OZiHWXf6zgEPwvV4674ssw3c8
	 b4pKiGtFbBbeLz9tKiIei57MK0pgPYP48dRE7/B7w6SNipo7EfUfZSulN1/lv+mt32
	 OQKLY/zm4LIrKasY6XcOCbzf2DvXRy5IU3mo8S65o81IgHzNTCxRzP+mqOCBjiPdHO
	 jKdBA6Du7QZW3RPJtisUlF9FiVHB9NTsRuHGI88Kl87VR6NMR3jj2YWeGDtdAzAuGt
	 Ldyd18I3sBtHIJSi7XNgPGTEvOpk4lzxFjsaqtOZP+DoXqqYwQO3cDU/oLwpOJpDqX
	 E/pJybjkrkzSQ==
Date: Sat, 15 Mar 2025 12:57:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Lechner 
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich  <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v1 1/1] iio: amplifiers: hmc425a: Remove not fully
 correct comment
Message-ID: <20250315125739.36355160@jic23-huawei>
In-Reply-To: <96b2920f2bfd4ac44de73f3f940eb66913996952.camel@gmail.com>
References: <20250313162254.416422-1-andriy.shevchenko@linux.intel.com>
	<96b2920f2bfd4ac44de73f3f940eb66913996952.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Mar 2025 20:48:51 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2025-03-13 at 18:22 +0200, Andy Shevchenko wrote:
> > The OF match table can be used outside of OF-based platforms.
> > Remove the (misleading) comment.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.
>=20
> > =C2=A0drivers/iio/amplifiers/hmc425a.c | 1 -
> > =C2=A01 file changed, 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/=
hmc425a.c
> > index d9a359e1388a..e92d7f399e33 100644
> > --- a/drivers/iio/amplifiers/hmc425a.c
> > +++ b/drivers/iio/amplifiers/hmc425a.c
> > @@ -398,7 +398,6 @@ static int hmc425a_probe(struct platform_device *pd=
ev)
> > =C2=A0	return devm_iio_device_register(&pdev->dev, indio_dev);
> > =C2=A0}
> > =C2=A0
> > -/* Match table for of_platform binding */
> > =C2=A0static const struct of_device_id hmc425a_of_match[] =3D {
> > =C2=A0	{ .compatible =3D "adi,hmc425a",
> > =C2=A0	=C2=A0 .data =3D &hmc425a_chip_info_tbl[ID_HMC425A]}, =20
>=20


