Return-Path: <linux-iio+bounces-24914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A24BCDF1E
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 18:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C0A813553C6
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EF62FBE13;
	Fri, 10 Oct 2025 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2bNziFE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E7F2F83A7;
	Fri, 10 Oct 2025 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760113331; cv=none; b=jmJFPOatdLKyUdwSsKIRyFgJyr/oklvkrJ0xVLjz9VV14p1rajzpWhHbkCpTzxjavSEKKH+1mxcHX81/ZxU0q/vK+HHWtWUDmnrimmvl79iUmh6Ug1iY1nlaf3HVgUU1zc4tmeKD9y6axjZVs4UkSuzXzzoTlvJxW+iTdXb74FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760113331; c=relaxed/simple;
	bh=yrHwPKjQd3S4q6w+FpNn+pv8d9xPfUXVOJ9aqSNRGko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LF9M62fgocLPcjSIxoOhcoF81alSEog1HhK088WtjxCZvd2AQMZcjRu3KgIJFfxRvA0GrTbvZyetmh2ADabB2WseRmjLaQ7QaHBgBaxYeAn0ZUKrRIvKwFMAGNzERhDxr2zc+Xq2TspUNfpDgJGjyl4YgJP2mnew4cP1RRny5iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2bNziFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79911C4CEF1;
	Fri, 10 Oct 2025 16:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760113330;
	bh=yrHwPKjQd3S4q6w+FpNn+pv8d9xPfUXVOJ9aqSNRGko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C2bNziFEO5YCeIq7I5Hy3mz4ST7+ATCr2XuFZsUPQWOMXuwsCZdCzWnWoGZXOztDK
	 NHeldpbVKuXpGI165cjxyqoQWDEDQMBtuDOJJJO0bqY7SAJqwCuidrpZUOObVjv24Q
	 itDESkKWc/EFeX59m0dq+DvkM70+bw1hdFJAwGXImw349jnBf21rubUKlFd/hxQLF9
	 g2XnpJPupHeROmCBQzxLXLuTQVlRZWv8xyZHp8v8S4IFUqI5Dm7Ybq0euwS/IiElcb
	 xrLTN9b6FwHjjGF8ATIN2OppOe3vnAAyEgk+mPSjRHWdzt1vxVHna0dyYkvSiHRXse
	 RA1Z6f3l1CTbw==
Date: Fri, 10 Oct 2025 18:22:08 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Francesco Lavra <flavra@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
Message-ID: <aOkysKyWX2hYEnED@lore-desk>
References: <20251009173609.992452-1-flavra@baylibre.com>
 <20251009173609.992452-3-flavra@baylibre.com>
 <aOg3dg21aWNTF47x@lore-desk>
 <160b32c14df3daa06304fef430534561cabcfaea.camel@baylibre.com>
 <aOjAK9LRMCcBspkb@lore-desk>
 <9dbd2ae7883ec8dba65706603a29f3144076840e.camel@baylibre.com>
 <aOkG-jBOYXxWy1z3@lore-desk>
 <007e87d2-92f5-417a-a6bf-1babd4c60c61@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yKYukquOmuv+XOKl"
Content-Disposition: inline
In-Reply-To: <007e87d2-92f5-417a-a6bf-1babd4c60c61@baylibre.com>


--yKYukquOmuv+XOKl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 10, David Lechner wrote:
> On 10/10/25 8:15 AM, Lorenzo Bianconi wrote:
> > On Oct 10, Francesco Lavra wrote:
> >> On Fri, 2025-10-10 at 10:13 +0200, Lorenzo Bianconi wrote:
> >>>> On Fri, 2025-10-10 at 00:30 +0200, Lorenzo Bianconi wrote:
> >>>>>> The rate at which accelerometer or gyroscope sensor samples are fed
> >>>>>> to the hardware FIFO (batch data rate, or BDR) does not have to
> >>>>>> coincide with the sensor sampling frequency (output data rate, or
> >>>>>> ODR); the only requirement is for the BDR to not be greater than
> >>>>>> the ODR. Having a BDR lower than the ODR is useful in cases where
> >>>>>> an application requires a high sampling rate for accurate detection
> >>>>>> of motion events (e.g. wakeup events), but wants to read sensor
> >>>>>> sample values from the device buffer at a lower data rate.
> >>>>>
> >>>>> can you please provide more details here? Are you using the hw fifo
> >>>>> to
> >>>>> read
> >>>>> data? If we configure the hw fifo according to the BDR (even assumi=
ng
> >>>>> the
> >>>>> watermark is set 1) the hw will generate interrupts according to the
> >>>>> BDR
> >>>>> (bdr < odr).
> >>>>
> >>>> Yes, I'm using the hw fifo to read data. The use case is to enable
> >>>> event
> >>>> detection (which works best at high sampling rates) and sensor data
> >>>> streaming at the same time, without requiring the data stream to be =
at
> >>>> the
> >>>> same rate as the sensor sampling rate. So the amount of I2C (or SPI)
> >>>> traffic (as well as the rate of periodic interrupts) required by the
> >>>> data
> >>>> stream is kept to a minimum without sacrificing the accuracy of event
> >>>> detection.
> >>>
> >>> I guess you can get the same result (reduce sensor data interrupt rate
> >>> keeping high odr value) configuring the hw fifo watermark.
> >>> Does it work for you?
> >>
> >> Setting the hw fifo watermark to a high value reduces the rate of
> >> interrupts, but doesn't do much to reduce the amount of I2C traffic, s=
o the
> >> issue would still be there.
> >=20
> > ack, now I got the goal of the series. I think the series is mostly fin=
e.
> > I guess hwfifo_odr instead of bdr is more meaningful, what do you think?
> > Naming is always hard.
> >=20
> > Regards,
> > Lorenzo
>=20
> In the IIO subsystem, we prefer to include the units in the variable/
> field name as well, e.g. hw_fifo_odr_mHz.

ack, but please avoid camel case :)

--yKYukquOmuv+XOKl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaOkysAAKCRA6cBh0uS2t
rNyqAQDhoovgFftrabIIzyYaN/fIz+QUiedbdC6uptRxuMPO3wEAzuCpK5hF3qpQ
aaY8Vlo+dFmT+wLSidbMJcQcgSbSiwo=
=4Deh
-----END PGP SIGNATURE-----

--yKYukquOmuv+XOKl--

