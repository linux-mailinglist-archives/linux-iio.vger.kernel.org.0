Return-Path: <linux-iio+bounces-20437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DBDAD595B
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42AEF188327A
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 14:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BE228A72F;
	Wed, 11 Jun 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLlXrggN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2D326A1D0;
	Wed, 11 Jun 2025 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653763; cv=none; b=UNauLKgvC/PhcIEjoD1r7w1W7LlmmALlqCCNoLq2x9PwVNAFC5avLLOLEe/Yp+ddBxFcTS5mFZ/mb0G4TaebicYFTpp5Zbv/ZLJ3kOEjKbf6y3u3mKOpbsoerblj58DYGDMEhLhPHjJP+ZnMAVLE+ZR87VXghUNXaxSpDpnW/ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653763; c=relaxed/simple;
	bh=isneXLCqbOruHYkj2ItmtM8OHJUlnBsjO2FCHsL8Jwg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asL7gJE914hPEQVhonI0zE88Hoqb8B8fyS6HtgArTv8XBnrrYFeQZkqRQ+TrQBiFBWw4g2SBl+Mg+hA2njqZftJEm9VM7zJWHIG9OicYuwwiVJVgAO4j9koF61i1oSUYnYHA2mllHyF0RSSRnzi47wRdhuDL/T8lC8u8IA69Q3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLlXrggN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4ACC4CEE3;
	Wed, 11 Jun 2025 14:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749653763;
	bh=isneXLCqbOruHYkj2ItmtM8OHJUlnBsjO2FCHsL8Jwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gLlXrggNR4yholGByFgP2+BgEpfybD5papqiAeDCWY8iyX0kbApFoUNgwe1MCOmzR
	 py+PK+XYTu+gbK1IIJ62BjDxMjlAienR5W853iWao5od15/h/Sy96lbSLdJrrr1mKu
	 fEDUFa+7nZBYB99XPNPMN+3BexYeZUgTtNUixEAejdwpIvpy2vrsES6O2qS16G+dND
	 vaDZrqky2OKmj6f/dUmLtGJsqvcebgiiHUnCJhDBWa1kgOoQItVBUlwmjBwz093RCZ
	 DUVaK6jA8UkJn5g4EkhBvY7iqRCMawKivdPg0izsUG/Q2XMcYXg8ylbGJibq9Vh7UR
	 dW0rnyrFB+rlg==
Date: Wed, 11 Jun 2025 15:55:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio <linux-iio@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iio: imu: inv_icm42600: add WoM support
Message-ID: <20250611155555.68ac59e4@jic23-huawei>
In-Reply-To: <FR3P281MB17573A98ECB6B89306DB8DCBCE6AA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250418-losd-3-inv-icm42600-add-wom-support-v3-0-7a180af02bfe@tdk.com>
	<20250418-losd-3-inv-icm42600-add-wom-support-v3-1-7a180af02bfe@tdk.com>
	<aAPDovuee7hoY1PS@smile.fi.intel.com>
	<FR3P281MB17573A98ECB6B89306DB8DCBCE6AA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Jun 2025 14:13:38 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Andy,
>=20
> sorry for the very late response, here are my answers.
>=20
> Thanks,
> JB
>=20
> >________________________________________
> >From:=C2=A0Andy Shevchenko <andy@kernel.org>
> >Sent:=C2=A0Saturday, April 19, 2025 17:39
> >To:=C2=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> >Cc:=C2=A0Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@m=
etafoo.de>; David Lechner <dlechner@baylibre.com>; Nuno S=C3=A1 <nuno.sa@an=
alog.com>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-ker=
nel@vger.kernel.org <linux-kernel@vger.kernel.org>
> >Subject:=C2=A0Re: [PATCH v3 1/2] iio: imu: inv_icm42600: add WoM support
> >=C2=A0
> >This Message Is From an External Sender
> >This message came from outside your organization.
> >=C2=A0
> >On Fri, Apr 18, 2025 at 06:19:02PM +0200, Jean-Baptiste Maneyrol via B4 =
Relay wrote: =20
> >> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >>=20
> >> Add WoM as accel roc rising x|y|z event. =20
> >
> >...
> > =20
> >> +static unsigned int inv_icm42600_accel_convert_roc_to_wom(uint64_t ro=
c,
> >> +							 =C2=A0int accel_hz, int accel_uhz)
> >> +{
> >> +	/* 1000/256mg per LSB converted in =C2=B5m/s=C2=B2 */
> >> +	const unsigned int convert =3D (1000U * 9807U) / 256U; =20
> >
> >Wondering if KILO (or MILLI?) is a good suit here... =20
>=20
> This one is a little complex, since we have gravity value in mm/s=C2=B2 m=
ultiplied
> by 1000 to go to =C2=B5m/s=C2=B2.
> If you have an idea of better writing that, I will do.
 =3D (9807U * (MICRO / MILLI)) / 256U;

probably best way to express what you've written.  Rely on compiler working
out the constant for us.

> >> +static int inv_icm42600_accel_disable_wom(struct iio_dev *indio_dev)
> >> +{
> >> +	struct inv_icm42600_state *st =3D iio_device_get_drvdata(indio_dev);
> >> +	struct device *pdev =3D regmap_get_device(st->map);
> >> +	struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSOR_CONF_IN=
IT;
> >> +	unsigned int sleep_ms =3D 0;
> >> +	int ret;
> >> +
> >> +	scoped_guard(mutex, &st->lock) { =20
> > =20
> >> +		st->apex.wom.enable =3D false;
> >> +		st->apex.on--; =20
> >
> >Hmm... Even if the below fails we consider it successful? Why? =20
>=20
> If it fails, there is no easy way to restore functioning. Better consider
> everything is disabled to not prevent the chip go into sleep (which will
> disable the feature anyway) and give a chance to reenable it afterward.
>=20

Maybe add a comment?


J

