Return-Path: <linux-iio+bounces-19430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6197AB2855
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 15:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6385A176719
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9970256C96;
	Sun, 11 May 2025 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fy/hxhfF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857082905;
	Sun, 11 May 2025 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746969194; cv=none; b=U+vgAoqTwvLth5GwxfffqsTxxKPRUZOu41Af+uVGgTP0XC0r11SULxK8wwAKvFXQIVgW1JE3FUDEGSZ+uBRbtCDpUxyDbq+wq/pa9MNGXwIRmENkFtGMMmtBXkr8ZfK2/6jHMStSaOxe5TDZg4oOvFAWUQAv12mRBIrkBf50cps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746969194; c=relaxed/simple;
	bh=IWkrCn40iA6/09g/AXoUlerfn05WurUKSosH4eCdlq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkwhmmlqeO6yuDCbi6QEdgnE9E0faMmPNOD8pbeTQ1MOBj1VV4uw/S3CzkUWj4z21iZyWDhcjEzdkSoWYdBHa4+Cwbtb2aqtSr46DyhnazvHZoM8jmWxCG97VCp/0/G4TKgb69ZUBZOMxUpNC+rIfxCfAKCcdotRVAw/eayEBJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fy/hxhfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8A3C4CEE4;
	Sun, 11 May 2025 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746969194;
	bh=IWkrCn40iA6/09g/AXoUlerfn05WurUKSosH4eCdlq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fy/hxhfF0Bh7CyWJMr3mHYHEBxic77/9TVcF5YS++uGhYAWM9+CFTsLTFtqVe6OHM
	 qCxg5oMiUtaQNixgUX+uX4j0D8cn6/lHsqGx2IwyWaobbYl1K+LSFQ72Ml7W4FHZfl
	 M1mx1Bb679mw76KTxB+/KNT+5Jbi5E3tuqZ6WPY/AKoATDDLwhSPTVx8vIzjcLAXa4
	 DapNvCMOgYbJ3QhzG1copQQYq2M8uu68GFgrO5gxCDKpbJoz/W7ufRjWUiI3yc/KjN
	 oKrM9mJfA3/3O4V7cT5C0pa8F3RbEVCN4W+5v4SJVTTQ3EUmxoyrPI81F3v7SF1+00
	 bhP1yE+NRCRRA==
Date: Sun, 11 May 2025 14:13:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4851: fix ad4858 chan pointer handling
Message-ID: <20250511141307.0418bde2@jic23-huawei>
In-Reply-To: <310975db928bbd57411da9ff18746df8836fe642.camel@gmail.com>
References: <20250509101657.6742-1-antoniu.miclaus@analog.com>
	<310975db928bbd57411da9ff18746df8836fe642.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 09 May 2025 13:47:41 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2025-05-09 at 13:16 +0300, Antoniu Miclaus wrote:
> > The pointer returned from ad4851_parse_channels_common() is incremented
> > internally as each channel is populated. In ad4858_parse_channels(),
> > the same pointer was further incremented while setting ext_scan_type
> > fields for each channel. This resulted in indio_dev->channels being set
> > to a pointer past the end of the allocated array, potentially causing
> > memory corruption or undefined behavior.
> >=20
> > Fix this by iterating over the channels using an explicit index instead
> > of incrementing the pointer. This preserves the original base pointer
> > and ensures all channel metadata is set correctly.
> >=20
> > Fixes: 6250803fe2ec ("iio: adc: ad4851: add ad485x driver")
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > --- =20
>=20
> LGTM
Applied to the fixes-togreg branch of iio.git.

Thanks

Jonathan

>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> > =C2=A0drivers/iio/adc/ad4851.c | 14 +++++++-------
> > =C2=A01 file changed, 7 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
> > index 98ebc853db79..f1d2e2896f2a 100644
> > --- a/drivers/iio/adc/ad4851.c
> > +++ b/drivers/iio/adc/ad4851.c
> > @@ -1034,7 +1034,7 @@ static int ad4858_parse_channels(struct iio_dev
> > *indio_dev)
> > =C2=A0	struct device *dev =3D &st->spi->dev;
> > =C2=A0	struct iio_chan_spec *ad4851_channels;
> > =C2=A0	const struct iio_chan_spec ad4851_chan =3D AD4858_IIO_CHANNEL;
> > -	int ret;
> > +	int ret, i =3D 0;
> > =C2=A0
> > =C2=A0	ret =3D ad4851_parse_channels_common(indio_dev, &ad4851_channels,
> > =C2=A0					=C2=A0=C2=A0 ad4851_chan);
> > @@ -1042,15 +1042,15 @@ static int ad4858_parse_channels(struct iio_dev
> > *indio_dev)
> > =C2=A0		return ret;
> > =C2=A0
> > =C2=A0	device_for_each_child_node_scoped(dev, child) {
> > -		ad4851_channels->has_ext_scan_type =3D 1;
> > +		ad4851_channels[i].has_ext_scan_type =3D 1;
> > =C2=A0		if (fwnode_property_read_bool(child, "bipolar")) {
> > -			ad4851_channels->ext_scan_type =3D
> > ad4851_scan_type_20_b;
> > -			ad4851_channels->num_ext_scan_type =3D
> > ARRAY_SIZE(ad4851_scan_type_20_b);
> > +			ad4851_channels[i].ext_scan_type =3D
> > ad4851_scan_type_20_b;
> > +			ad4851_channels[i].num_ext_scan_type =3D
> > ARRAY_SIZE(ad4851_scan_type_20_b);
> > =C2=A0		} else {
> > -			ad4851_channels->ext_scan_type =3D
> > ad4851_scan_type_20_u;
> > -			ad4851_channels->num_ext_scan_type =3D
> > ARRAY_SIZE(ad4851_scan_type_20_u);
> > +			ad4851_channels[i].ext_scan_type =3D
> > ad4851_scan_type_20_u;
> > +			ad4851_channels[i].num_ext_scan_type =3D
> > ARRAY_SIZE(ad4851_scan_type_20_u);
> > =C2=A0		}
> > -		ad4851_channels++;
> > +		i++;
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	indio_dev->channels =3D ad4851_channels; =20
>=20


