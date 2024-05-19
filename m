Return-Path: <linux-iio+bounces-5119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85B08C9577
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 19:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3F11F21B78
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 17:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E805C4D11B;
	Sun, 19 May 2024 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zsc91cou"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992F54D59B;
	Sun, 19 May 2024 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716138542; cv=none; b=c+CCWIk3eU8kDM0aRgWbguZya4e/NLuvV5Ij+IcIiu/yKJbj9PzQh+GNB4ZjvTdLOIO9LZPckIonbi41RclfRrnUyr8278OD9GlVSAsbRalbWdbpNv5nGR5eFk47LqI9QyWODWyhRvM8BRUQuvdVmdEYfaENIE9OcideQzoYoyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716138542; c=relaxed/simple;
	bh=lEMXpprkSCoVGZB8PN5bp+4R/KVLH9QiI/3kMDX7fig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NM4K3IRbwhsAYdmyOF0wNXoPzsCMtjmt0GNvRCXBzb5joz7UQduJJEyAvanVoyqOq8sNG5lCO3ZRF0oAkVJ7OR2IpEIO5ObdkMQG+cksT6NAJXZdjDJEameD8jyuGdZWtxSGndQQHisKKzxDcXVuppVt+wlP8pyj4R/9FTdN/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zsc91cou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950ADC32781;
	Sun, 19 May 2024 17:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716138542;
	bh=lEMXpprkSCoVGZB8PN5bp+4R/KVLH9QiI/3kMDX7fig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zsc91couCj6lG0MQV8VLtQ97HqCB3vv9KfkeKBnPfCx+IG/k7hdmoo2bCBv2zG+Cg
	 jfOtBJXF/9+25ji0YQ9mnSOJC0n33uPRlbyJ+hfskKpwtwO5107StPrx8qREDVRPup
	 O+hAZjI3RP0DabQZajaTr577SWhblBiRQwjn8a+9mbWEgoX9/kw3jaq0SjruTMfCiv
	 2JFxM1R+SnNHMcK2hC5Ieq4lJZR0Au442B27aSesP/vxu9uBLLYOnoWT/cd9K+n6pF
	 B//biMw2wBCI6JSbygS2WRJgOjIxZ2BhgEHUM8+T5IuToTwEFrLgRBYjhR+RCE4y9x
	 Y5ZxI/+I7qjFw==
Date: Sun, 19 May 2024 18:08:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v2 7/9] iio: adc: ad7173: Remove index from temp channel
Message-ID: <20240519180851.43729fa9@jic23-huawei>
In-Reply-To: <CAMknhBGfu_an738aWqL19zGm7tTOZtoOv-+eY3kn3Zt+-eShwg@mail.gmail.com>
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
	<20240514-ad4111-v2-7-29be6a55efb5@analog.com>
	<CAMknhBGfu_an738aWqL19zGm7tTOZtoOv-+eY3kn3Zt+-eShwg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 15 May 2024 18:34:17 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Tue, May 14, 2024 at 2:23=E2=80=AFAM Dumitru Ceclan via B4 Relay
> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> >
> > From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >
> > Temperature channel is unique per device, index is not needed.
> >
> > This is breaking userspace: as main driver has not reached mainline yet
> > it won't affect users as there are none. =20
>=20
> But it is queued up, so probably need a Fixes: here to make sure it
> makes it into the release.
Yes. We can fix this but it will need to go as a fix during the rc cycles
rather than wait for the next merge window like the rest of this series.

Jonathan



>=20
> >
> > Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> > ---
> >  drivers/iio/adc/ad7173.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> > index d965b66d4d5a..d66b47e1a186 100644
> > --- a/drivers/iio/adc/ad7173.c
> > +++ b/drivers/iio/adc/ad7173.c
> > @@ -828,7 +828,6 @@ static const struct iio_chan_spec ad7173_channel_te=
mplate =3D {
> >
> >  static const struct iio_chan_spec ad7173_temp_iio_channel_template =3D=
 {
> >         .type =3D IIO_TEMP,
> > -       .indexed =3D 1,
> >         .channel =3D AD7173_AIN_TEMP_POS,
> >         .channel2 =3D AD7173_AIN_TEMP_NEG,
> >         .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> >
> > --
> > 2.43.0
> >
> > =20


