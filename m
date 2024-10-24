Return-Path: <linux-iio+bounces-11150-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E069AEC67
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 18:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D8E1F2318F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 16:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A6F1F81A7;
	Thu, 24 Oct 2024 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwBW0tNv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605E51F4724;
	Thu, 24 Oct 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788105; cv=none; b=FZRrH/sMrkzDYsfcyFmiEEHUt4z3htYpAT3Hn1bMOI9qixHTvfuPtV0aNBjvwJ9wSdBN6Hn6qtESijO2ayuR6LvgT5Gtz/YGDQXRrrcmEaTO8a6oonjYfz6of/3PVGgehqGIt3oNdxiDFb/KYIM9dGS+CyWG+j3xX8LCIRCxAws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788105; c=relaxed/simple;
	bh=+RxJdL+Uc9rc3Lz3hS3n8/ydIcGoanJIfQXZ4yrsXoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGfPbkxEMS4IR/o6YcxDZFert0KibxSuMxWo8Q2T0a3M5bJaO/5nzvqfbgp3mUg3Bxqvxm9YQm/YTqMo19NSALQ8+w/UhUADRgwWtDdYm2JRt1NQXzGkB8clH7lsR+m1r7v5xviqxWyi1YmRGxO6HE+oJOyXJsEV4nQWoCVlgIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwBW0tNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2043FC4CEE3;
	Thu, 24 Oct 2024 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729788104;
	bh=+RxJdL+Uc9rc3Lz3hS3n8/ydIcGoanJIfQXZ4yrsXoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwBW0tNvmU8/8dQHGnWIz1Dzho2YXTHQVDOaLols73cCic39JNjuLHCc453I9hGe6
	 UyIj/ajyjtp03wZQU4YAyJoJWvj9uV330MVwVCHFV4YcVggSsFm89pzDd3CtNa+mQU
	 ZnsKSxqNelEn5LqErbFIdIwHyRngMJjG/USSWL5BLhwd7K0GzUl6IoNuz03XEZu7vC
	 5B1XVjQKU8uyeRVnHy1Kw1ulbtRYhij1XWjl3uWJaHBAY0ODCHRnA/Bn/NMV9t8bSG
	 9pb9PUqOdGHcc/15gT0eI0rS2jBDWD5NKuLjjyIN64237zHUL+9WSKIyk/80aF0Y5R
	 NuRXkwAjsqW2A==
Date: Thu, 24 Oct 2024 17:41:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: adc: ad7380: add adaq4370-4 and
 adaq4380-4 compatible parts
Message-ID: <20241024-reaffirm-sizable-bb426dc1e27f@spud>
References: <20241024-ad7380-add-adaq4380-4-support-v3-0-6a29bd0f79da@baylibre.com>
 <20241024-ad7380-add-adaq4380-4-support-v3-1-6a29bd0f79da@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tTGPlZ0/zm6LA1V8"
Content-Disposition: inline
In-Reply-To: <20241024-ad7380-add-adaq4380-4-support-v3-1-6a29bd0f79da@baylibre.com>


--tTGPlZ0/zm6LA1V8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 10:16:56AM +0200, Julien Stephan wrote:
> adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS) are quad-channel precision data
> acquisition signal chain =CE=BCModule solutions compatible with the ad738x
> family, with the following differences:
>=20
> - pin selectable gain in front of each 4 adc
> - internal reference is 3V derived from refin-supply (5V)
> - additional supplies
>=20
> To select the gain a new patternProperties is added to describe each
> channel. It is restricted to adaq devices.
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--tTGPlZ0/zm6LA1V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxp4wwAKCRB4tDGHoIJi
0hqyAP9qoxBMtJ3wbKnGt0HewRy1sUgGzE19AN6j1of66R7T3QD+MwK6jZ/1P4O4
vAS/uI0mNcKjigMR3EITs9ya5GG83Ac=
=RTMc
-----END PGP SIGNATURE-----

--tTGPlZ0/zm6LA1V8--

