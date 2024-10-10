Return-Path: <linux-iio+bounces-10407-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEF0998F6C
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 20:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCED288180
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 18:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7783619D891;
	Thu, 10 Oct 2024 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBDr4N7Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353404A15;
	Thu, 10 Oct 2024 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583713; cv=none; b=G9LsVzMCYKurrcEjXjLlU8JYxMICGVRly/7rd6NpUbix/B1SaciwL3lqvTq5vb/FRRFE8/mAiQHtef/WEDXo+G5GuZILK62N09o8pol/Lm2OQuP6dGb5A41WsFBBnFMZ5kGkRGogQ/MobFb4rsAL7y/6oFkI0WYfUSepzfy0Ooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583713; c=relaxed/simple;
	bh=pNNUzgsfeE3vU6Z9Jaru3B2zlAzESzIjzx09qGL1/9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZn5N+HIOLXm82ZjatNJtOUGby4raFZx7imgQfbxb76q12dsWmgYNC83ZVCZcxMicDHm9jsQGuQZBRDcVuoiW4EDthPuqn+T1nbd8oIDRKWv1r4BafWZ2G6/m9kTnuJaA9qg3BWF7QvfaAVuuZ08+GCHP8A6wkcYU2MzEQ783UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBDr4N7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2120C4CEC5;
	Thu, 10 Oct 2024 18:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728583712;
	bh=pNNUzgsfeE3vU6Z9Jaru3B2zlAzESzIjzx09qGL1/9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XBDr4N7Q13MdOJgVw6Wzl5yIDzSS8lWC7jQCj/tolC3liU4D0Lzg3plDkG91bgAbg
	 zBs67Dyu5siAqCHAmQ+RKjJcBDbnZFCuQW7kis/KveRCXmjt6PXx1FtlOsv19EDWYH
	 EpiVQerNkPWoBPARGpo1LqDRQQbApcH2fC4Zewi3DhciCYlTzZkkG0bMxzRnoVMXrz
	 a863fw1YeeeuIuPO65BoIki47rjZsBkBvy9cNghmTHIQxKeg0fGj1uFCvStZJXTWZl
	 GFkBBmODz+dt6IloPoR/okfZc+EikoxZLwmfx8/OOnFxeyJPjhDz850IyJPnraQE4j
	 0/msx9waQaB/A==
Date: Thu, 10 Oct 2024 19:08:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=	
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7944: add namespace to T_QUIET_NS
Message-ID: <20241010190827.039b9125@jic23-huawei>
In-Reply-To: <b5427f9c7fdbd4b93ba7b355aaf44afde23b0026.camel@gmail.com>
References: <20241009-iio-adc-ad7944-add-namespace-to-t_quiet_ns-v1-1-a216357a065c@baylibre.com>
	<b5427f9c7fdbd4b93ba7b355aaf44afde23b0026.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Oct 2024 10:32:44 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2024-10-09 at 16:26 -0500, David Lechner wrote:
> > Add AD7944_ namespace to T_QUIET_NS. This is the preferred style. This
> > way the bad style won't be copied when we add more T_ macros.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan

>=20
> > =C2=A0drivers/iio/adc/ad7944.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> > index 0f36138a7144..a5aea4e9f1a7 100644
> > --- a/drivers/iio/adc/ad7944.c
> > +++ b/drivers/iio/adc/ad7944.c
> > @@ -80,7 +80,7 @@ struct ad7944_adc {
> > =C2=A0};
> > =C2=A0
> > =C2=A0/* quite time before CNV rising edge */
> > -#define T_QUIET_NS	20
> > +#define AD7944_T_QUIET_NS	20
> > =C2=A0
> > =C2=A0static const struct ad7944_timing_spec ad7944_timing_spec =3D {
> > =C2=A0	.conv_ns =3D 420,
> > @@ -150,7 +150,7 @@ static int ad7944_3wire_cs_mode_init_msg(struct dev=
ice
> > *dev, struct ad7944_adc *
> > =C2=A0	 * CS is tied to CNV and we need a low to high transition to sta=
rt
> > the
> > =C2=A0	 * conversion, so place CNV low for t_QUIET to prepare for this.
> > =C2=A0	 */
> > -	xfers[0].delay.value =3D T_QUIET_NS;
> > +	xfers[0].delay.value =3D AD7944_T_QUIET_NS;
> > =C2=A0	xfers[0].delay.unit =3D SPI_DELAY_UNIT_NSECS;
> > =C2=A0
> > =C2=A0	/*
> >=20
> > ---
> > base-commit: 96be67caa0f0420d4128cb67f07bbd7a6f49e03a
> > change-id: 20241009-iio-adc-ad7944-add-namespace-to-t_quiet_ns-a9ed6969=
2718
> >=20
> > Best regards, =20
>=20


