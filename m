Return-Path: <linux-iio+bounces-5097-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A08068C9497
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 14:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345E328141E
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 12:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCBD45000;
	Sun, 19 May 2024 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hawj10/X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C29E175AE;
	Sun, 19 May 2024 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716120174; cv=none; b=dFf2J1eTmXylgotfRDD0W7QX6vqsv/2yp/QvpDuODgqGyphOiZmu6e1Qs93jyiB45HlE3IQCw20CFURjcOTIcJhxyykJdH69nKMdzwcZIXm/2FnJrLDL5JJevISSBXehIok/C5a9R7L/vVLaCjhTpklw58ZvkaDC4FZTmhQK2dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716120174; c=relaxed/simple;
	bh=QEDQ8TVAXqlyhLNMWKZ5Zw3pAPKwxRatynyS3tTCohA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCr5Sbq286ur3df7TI2pi3VrKOR9DwJ0FjWbg4A/GK6AODhJS+sw0BFHmv9It60WU4oPQVEVeySw0Q35/59pbawXz5m0PRsUxYw+uevZ2mMXKmxOpoVSpg3DkRzAIK+b+wIweQbHjGwH/zhs6M6qnlt+Idw5gZ9qZboBt+uH1MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hawj10/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639DDC32781;
	Sun, 19 May 2024 12:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716120173;
	bh=QEDQ8TVAXqlyhLNMWKZ5Zw3pAPKwxRatynyS3tTCohA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hawj10/Xob3iRht5nWc4C5tmP1LWiNlplQEbLss4z9IQ9OpdFzt1DZhCUC26CxJll
	 1huFboAja1cHlksDjlgEcrqtVmLiV7+FuXZJ7v+wCFGwIA8c38IUIRY4ibaPCn6b36
	 BO9hRbGz5Ldd/fZJtMZg2X3qlzA90veReCKJvxYoNC9xK2/eLU3AnXeLJg6LmVmwwR
	 eashi/FpORGeYg1Obn41i+9oK9vw4noWJRFzPOFp+CmKMpB1vf+nl8jukAmgz5Ce/z
	 Hfgd0HsoLsWz0xFIMeU1ADiTI0dWMH/FvxPLc3CUNI9gdKexJHlfAw9MhGYbmDCVIq
	 Q8UqXvluwZBoA==
Date: Sun, 19 May 2024 13:02:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Arthur Becker <arthur.becker@sentec.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: light: add veml6040 RGBW-LS bindings
Message-ID: <20240519-irritable-richness-0a07286d289f@spud>
References: <ZR1P278MB1117B205886E023F9F72A2E881E22@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
 <20240513-repulsive-fiftieth-884b3805472f@spud>
 <20240519125705.49967e97@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ozr55vnr3ViejvHB"
Content-Disposition: inline
In-Reply-To: <20240519125705.49967e97@jic23-huawei>


--ozr55vnr3ViejvHB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 12:57:05PM +0100, Jonathan Cameron wrote:
> On Mon, 13 May 2024 17:26:12 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Mon, May 13, 2024 at 02:35:44PM +0000, Arthur Becker wrote:
> > > This commit adds device tree bindings for the veml6040 RGBW Light Sen=
sor
> > >=20
> > > signed-off-by: Arthur Becker <arthur.becker@sentec.com> =20
> >=20
> > If you're writing a standalone binding for this and not putting it into
> > trivial-devices.yaml you should document the supply for this device.
>=20
> It's a broken email thread. Driver is there, but soemthing has gone
> wrong with sending.

To be clear, the bit about "standalone" was compared to putting it in
trivial-devices.yaml, not to do with the threading and it being a patch
without a driver.

--ozr55vnr3ViejvHB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZknqagAKCRB4tDGHoIJi
0vBjAP47K6pxApuYF8YvXKyyXY8f/ohMsK4Q7q1kmHslGRnHIgEA4qcOlXKUYfK1
T+namC/PMik30yLiNIJak0PXtCxNzQU=
=6zea
-----END PGP SIGNATURE-----

--ozr55vnr3ViejvHB--

