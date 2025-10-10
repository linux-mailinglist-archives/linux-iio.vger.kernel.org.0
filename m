Return-Path: <linux-iio+bounces-24906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E8EBCD129
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 15:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77D954EB327
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 13:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C6621579F;
	Fri, 10 Oct 2025 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjDcJxSR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D2934BA46;
	Fri, 10 Oct 2025 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102141; cv=none; b=ISXWWWZNghdwkwMYlL96LMzrhxCMUvc5c0goOA0LM/8RQaczzq9BXr37ao5e2Yl7hbLy+HFWLla0lwxB0q98dW4msAsNkHtMS2v3TN/6r6VGs3O1FijTkHhxYzjho9s0c/hXYRBJSpgO5gKh2y5IWo85SzjLuCUh3y0arcJOF8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102141; c=relaxed/simple;
	bh=O8r1zDNV/ies1XRo8c9X1EYti/ggkfRs1ACGmDvFl38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPdyrtSbeHIDoAItsXhmwCXKnSoN98RWor1YceFwbq83VzEMrimBl9isVrZVEU37uUm+LGeiRwQXEnaN2dO06xVb7f0ZtqN1XmX6l2BB2h3lBWDpJQpnAyBmORYFc9gSPxWclzPbWzP16DJemKsnGrtPJgDOkY2Hmk25uRwLLhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjDcJxSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BB8C4CEF1;
	Fri, 10 Oct 2025 13:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760102141;
	bh=O8r1zDNV/ies1XRo8c9X1EYti/ggkfRs1ACGmDvFl38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HjDcJxSR0hQ09NB7ldl0ncgXbArBd7W3/aipJ7JWIBd0IVJZFQUxq91KNtX588cP5
	 tUqU9nFMF/hTOKIBDIFlrEbrMCYcio/+/LdjJvxJWqh3hqNuo8nyFTrU8fw/grlr1F
	 51/MxZVpQER9pjo+mzUfTbnVBMv4Oobfirt55L7OTi2YeyAMPS1TD/eVJu044PFz8S
	 wMFseFHULY58amwtA1wtRKVzbMRqL52BpWwnfw1V8IDXMpKIINudKi3MB84QJTEAD+
	 1R9I4fq3tU1a4crLuMERSdGYBCGsyljURp3FMxZW73+yzlQbcTGzq26QPMTPm9SscT
	 fNR0cB7xZ2yag==
Date: Fri, 10 Oct 2025 15:15:38 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO
 batch data rate
Message-ID: <aOkG-jBOYXxWy1z3@lore-desk>
References: <20251009173609.992452-1-flavra@baylibre.com>
 <20251009173609.992452-3-flavra@baylibre.com>
 <aOg3dg21aWNTF47x@lore-desk>
 <160b32c14df3daa06304fef430534561cabcfaea.camel@baylibre.com>
 <aOjAK9LRMCcBspkb@lore-desk>
 <9dbd2ae7883ec8dba65706603a29f3144076840e.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q9L2gUSXS00tM16I"
Content-Disposition: inline
In-Reply-To: <9dbd2ae7883ec8dba65706603a29f3144076840e.camel@baylibre.com>


--Q9L2gUSXS00tM16I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 10, Francesco Lavra wrote:
> On Fri, 2025-10-10 at 10:13 +0200, Lorenzo Bianconi wrote:
> > > On Fri, 2025-10-10 at 00:30 +0200, Lorenzo Bianconi wrote:
> > > > > The rate at which accelerometer or gyroscope sensor samples are f=
ed
> > > > > to the hardware FIFO (batch data rate, or BDR) does not have to
> > > > > coincide with the sensor sampling frequency (output data rate, or
> > > > > ODR); the only requirement is for the BDR to not be greater than
> > > > > the ODR. Having a BDR lower than the ODR is useful in cases where
> > > > > an application requires a high sampling rate for accurate detecti=
on
> > > > > of motion events (e.g. wakeup events), but wants to read sensor
> > > > > sample values from the device buffer at a lower data rate.
> > > >=20
> > > > can you please provide more details here? Are you using the hw fifo
> > > > to
> > > > read
> > > > data? If we configure the hw fifo according to the BDR (even assumi=
ng
> > > > the
> > > > watermark is set 1) the hw will generate interrupts according to the
> > > > BDR
> > > > (bdr < odr).
> > >=20
> > > Yes, I'm using the hw fifo to read data. The use case is to enable
> > > event
> > > detection (which works best at high sampling rates) and sensor data
> > > streaming at the same time, without requiring the data stream to be at
> > > the
> > > same rate as the sensor sampling rate. So the amount of I2C (or SPI)
> > > traffic (as well as the rate of periodic interrupts) required by the
> > > data
> > > stream is kept to a minimum without sacrificing the accuracy of event
> > > detection.
> >=20
> > I guess you can get the same result (reduce sensor data interrupt rate
> > keeping high odr value) configuring the hw fifo watermark.
> > Does it work for you?
>=20
> Setting the hw fifo watermark to a high value reduces the rate of
> interrupts, but doesn't do much to reduce the amount of I2C traffic, so t=
he
> issue would still be there.

ack, now I got the goal of the series. I think the series is mostly fine.
I guess hwfifo_odr instead of bdr is more meaningful, what do you think?
Naming is always hard.

Regards,
Lorenzo

--Q9L2gUSXS00tM16I
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaOkG+gAKCRA6cBh0uS2t
rHLRAQCQLWQ0sOMo9fZdnLqw2UQ/r+BFlsyeejmJSC6ZZltjCQEAmQBL+WP6q8p0
gJfXdcR2Y602paeKhLq8US/aby3zLwc=
=yC/a
-----END PGP SIGNATURE-----

--Q9L2gUSXS00tM16I--

