Return-Path: <linux-iio+bounces-24895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C424BCC15B
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 10:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E909B3A9B73
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 08:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACC427A10D;
	Fri, 10 Oct 2025 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtFmb7UY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4637726E6F8;
	Fri, 10 Oct 2025 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760084014; cv=none; b=cRUDy3IQ22gQ12ezMkI/c9KC19Ukc340P9UHOGP7IMaNxBQOw2M1OLf0kfLb0gkDRDlp6rq7x5rvid/Xq79/EgKtOCUJUf6J9Nttnpmr34k6illYVz5wcOwb5/KkNGdY+gz8OMBdujkzADEQERLvRZkc9/GpXICRzjbYoE63SRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760084014; c=relaxed/simple;
	bh=NCG/AguGKXwNIKfn3/5AYy3gu/mijLfeLMAj5kh6sXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmTBSetI9W82X1jKtYrpn9GZcFjOm3Pr9CELzyfLfHMuNexKgNPmsdj/xRYtofcsA5nx4tIU2GjedDAIuTijLiHEARv1nsLa77DVM7svb2H+M331eStxy8bmFhWupLO5jHR4FvL//CoL+Ku3VDLqEBq5rEtYQdJmt1dYmyfnM3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtFmb7UY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A129C4CEF1;
	Fri, 10 Oct 2025 08:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760084013;
	bh=NCG/AguGKXwNIKfn3/5AYy3gu/mijLfeLMAj5kh6sXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtFmb7UYayyxGl7+En9Kza68J9ZiNfSEKMbhdDx2VSHuXKI3vQ3FvJPlv7lVRHk4f
	 jDcgmLaE8N/A+DCHHjlvuv1K5jgu3KWbrlVlffVEI+pmRvegScrvdHkz4yYYLL0bkF
	 ZCpbLGZ190ITdWf7aWJgra/trhYCKKt88c3CR0K6u7pRzXUPHoCPeGXixG3Uo4072j
	 rkdTKHsCEi11bh0L18Qq1pI17dY7kuUA5LjWBuibszNuSiV8vW4qz+PiVFuINhjo0l
	 Ehts+OoKqFAyysCm9cPSqiOvV4VsP2BXXgdqHsjnCNWO3u40xAuQbBhmz2t2NOud7G
	 Z5J6wB1N5AxYA==
Date: Fri, 10 Oct 2025 10:13:31 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
Message-ID: <aOjAK9LRMCcBspkb@lore-desk>
References: <20251009173609.992452-1-flavra@baylibre.com>
 <20251009173609.992452-3-flavra@baylibre.com>
 <aOg3dg21aWNTF47x@lore-desk>
 <160b32c14df3daa06304fef430534561cabcfaea.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IApbmY+f9tQjAJHX"
Content-Disposition: inline
In-Reply-To: <160b32c14df3daa06304fef430534561cabcfaea.camel@baylibre.com>


--IApbmY+f9tQjAJHX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 2025-10-10 at 00:30 +0200, Lorenzo Bianconi wrote:
> > > The rate at which accelerometer or gyroscope sensor samples are fed
> > > to the hardware FIFO (batch data rate, or BDR) does not have to
> > > coincide with the sensor sampling frequency (output data rate, or
> > > ODR); the only requirement is for the BDR to not be greater than
> > > the ODR. Having a BDR lower than the ODR is useful in cases where
> > > an application requires a high sampling rate for accurate detection
> > > of motion events (e.g. wakeup events), but wants to read sensor
> > > sample values from the device buffer at a lower data rate.
> >=20
> > can you please provide more details here? Are you using the hw fifo to
> > read
> > data? If we configure the hw fifo according to the BDR (even assuming t=
he
> > watermark is set 1) the hw will generate interrupts according to the BDR
> > (bdr < odr).
>=20
> Yes, I'm using the hw fifo to read data. The use case is to enable event
> detection (which works best at high sampling rates) and sensor data
> streaming at the same time, without requiring the data stream to be at the
> same rate as the sensor sampling rate. So the amount of I2C (or SPI)
> traffic (as well as the rate of periodic interrupts) required by the data
> stream is kept to a minimum without sacrificing the accuracy of event
> detection.

I guess you can get the same result (reduce sensor data interrupt rate
keeping high odr value) configuring the hw fifo watermark.
Does it work for you?

Regards,
Lorenzo

>=20
>=20



--IApbmY+f9tQjAJHX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaOjAKwAKCRA6cBh0uS2t
rHXOAQDdbkkMotmwZ+Vr7x+FHdRaGJzRsYZwEzKnzdjbRjZmRAD/cFXhT3F49JKu
IQAflgI6WyOEPQwbUl3qEa9tmgTYBAM=
=z3e/
-----END PGP SIGNATURE-----

--IApbmY+f9tQjAJHX--

