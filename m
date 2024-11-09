Return-Path: <linux-iio+bounces-12089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABD89C2E28
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 16:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36C71F21B25
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 15:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2905919ABAB;
	Sat,  9 Nov 2024 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4Z8Lw4o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6708233D6B;
	Sat,  9 Nov 2024 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731165543; cv=none; b=PRUzwmgz8PASZG7aB5U1mSg4ary3WOUuM0rDPDI9/HupUE/YXDgma8L+E2mLAOaV02IPdG2jgvZ+Wu7p1Z1ioOVS1W8fbxWRI2W2LV7D0PJnA4siSFRJn34AL2zXqXFq8v7+XqI3RdlXA6DocNlex/gv9m07QG/Uzolaqw7VGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731165543; c=relaxed/simple;
	bh=d8IrYy8jruuuVAG9Sf7ay7FX8k29bWRSG6Whn6Ivo64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDmkki8Bt3ZsVjEShE5U0BD8eCWq0A7pGTdZlECuo3ugJTZseL+7ltPF9k5eRkYbxvK4/6VL+ox2BgWG+EaSqZ3mYnNCB2rTT9xnrQEK+hIEDiqtJuOAXJ6S/GUkaKGKuCDbhLzg4YzZ5s2yaIUYF0/pcQ+XJubylahGrm3QgGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4Z8Lw4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DA3C4CECE;
	Sat,  9 Nov 2024 15:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731165543;
	bh=d8IrYy8jruuuVAG9Sf7ay7FX8k29bWRSG6Whn6Ivo64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R4Z8Lw4oiFQ4ugJaFVAWWM9tEKZ5Eid0T6FPTSYXLiwhSblHKslojTnoUKh8grOJQ
	 XB3DCTOrsMzCw/FuwweuUg5u8IJ7VGh1fgibzbqcMIFjCOUHfvOSj7ad9T6a9exN4k
	 WXoNFiJ5WHlt3Uhu6BfsLlJ0TdmoRnusmbWhcR4Npui6Bw55KduqCrwJF55Cf2XF/e
	 Um4GsJY5iRvohdI0pGMdj5Xr6qCQQSaozKKEcr9vwLBe5S743urqXN6VbUyomnIPf/
	 Ei8Yl5a7mapE9cArhOA8covIkH9hw9vtOgCWWKDED9XGXAa47lRZbuLhmdQALMpRlF
	 10dPC8DGifRig==
Date: Sat, 9 Nov 2024 15:18:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7173: remove unused field
Message-ID: <20241109151856.049c18b2@jic23-huawei>
In-Reply-To: <f1aff5adfb369c3926e43b7ecaa95d23e0126343.camel@gmail.com>
References: <20241104-iio-adc-ad7173-remove-unused-field-v1-1-da9500a48750@baylibre.com>
	<f1aff5adfb369c3926e43b7ecaa95d23e0126343.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 05 Nov 2024 08:44:40 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2024-11-04 at 13:42 -0600, David Lechner wrote:
> > Remove the unused chan_reg field from struct ad7173_channel. This was
> > set but never read.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
> > Noticed this while looking over the code.
Applied.
> > ---
> > =C2=A0drivers/iio/adc/ad7173.c | 2 --
> > =C2=A01 file changed, 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> > index a0fca16c3be0..29ff9c7036c0 100644
> > --- a/drivers/iio/adc/ad7173.c
> > +++ b/drivers/iio/adc/ad7173.c
> > @@ -193,7 +193,6 @@ struct ad7173_channel_config {
> > =C2=A0};
> > =C2=A0
> > =C2=A0struct ad7173_channel {
> > -	unsigned int chan_reg;
> > =C2=A0	unsigned int ain;
> > =C2=A0	struct ad7173_channel_config cfg;
> > =C2=A0};
> > @@ -1316,7 +1315,6 @@ static int ad7173_fw_parse_channel_config(struct =
iio_dev
> > *indio_dev)
> > =C2=A0		chan->address =3D chan_index;
> > =C2=A0		chan->scan_index =3D chan_index;
> > =C2=A0		chan->channel =3D ain[0];
> > -		chan_st_priv->chan_reg =3D chan_index;
> > =C2=A0		chan_st_priv->cfg.input_buf =3D st->info->has_input_buf;
> > =C2=A0		chan_st_priv->cfg.odr =3D 0;
> > =C2=A0
> >=20
> > ---
> > base-commit: 56686ac80b859c2049cc372f7837470aa71c98cf
> > change-id: 20241104-iio-adc-ad7173-remove-unused-field-e3d2ca362501
> >=20
> > Best regards, =20
>=20


