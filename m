Return-Path: <linux-iio+bounces-12472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8C49D53A3
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 20:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07761B20C86
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 19:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CA91C8315;
	Thu, 21 Nov 2024 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/AxaY1I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7041C304F;
	Thu, 21 Nov 2024 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732218839; cv=none; b=Pst/haCN713XNHf3fxJ5V2ESwwlT1OO8CEiDntCSdCxf8rk9IFGk+/M7mdgOksK3pODu9283BHt5xC1qD2cO3xK4/lLNGCi/67k/PPaPqaBmEwAoCbJHSdVpdHGG0YKY03zS6TEYtaS3TGgyt3WbXS3GTiujXcJxGguThslfPa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732218839; c=relaxed/simple;
	bh=M0bDefENAtEaYK8veMFJkCk5vN5395Dp38Zqv9BBARg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9bJ1kKH4n+wONxyhatDwAiYHJM7C+tVJ563jII+jaPTjsw0t6lUOoO36MnObhBDui6PX236ix9Gjsl5PLTqYcPGDe9xqPoLyDC/PXlo2etmmss9/c9TVQXo98nPRDhE2TePfS0x0U6aEUg6+5NK4OqojJrjFrLDjjisHov4OA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/AxaY1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74746C4CECC;
	Thu, 21 Nov 2024 19:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732218839;
	bh=M0bDefENAtEaYK8veMFJkCk5vN5395Dp38Zqv9BBARg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/AxaY1INLUobLkQSEV1Ez611w+AQy5xVj0AbvHdEOXKaFgeOjGdsMD8sngA+B/dW
	 AB5XRl3Ylz9Z8GxNB1ECdionB4txfo9+21LntwaQUyNuiwEupAad8QWTSQZuUIM6qP
	 t6IWknGGmRx4rkoEYBZZDzQdTnLunZpw2Eftj8UkOBMqxUCOK8q7gHZTkEHcYnNHMV
	 uy3/owEpXIpDT4Eg6Z/nNd5ok3QTQ0s6UgR540FsrJWzqpQnnFgZDycL/esjXwmDzs
	 3DgRwa6ufqYEvGRj7rUx2Wbbg+X2rixKEITQerypntxcHeEs4709FRkE27aSf6gbKY
	 poROz0CXY4bQA==
Date: Thu, 21 Nov 2024 19:53:53 +0000
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Guillaume Stols <gstols@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, jstephan@baylibre.com,
	aardelean@baylibre.com, adureghello@baylibre.com
Subject: Re: [PATCH 2/9] dt-bindings: iio: dac: adi-axi-adc: Add ad7606
 variant
Message-ID: <20241121-wackiness-threaten-b53d2a27fbd9@spud>
References: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
 <20241121-ad7606_add_iio_backend_software_mode-v1-2-8a693a5e3fa9@baylibre.com>
 <49bc9ec4-f252-4903-b5be-1d35ee8d48be@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g22nKfEJVAyL8X+l"
Content-Disposition: inline
In-Reply-To: <49bc9ec4-f252-4903-b5be-1d35ee8d48be@baylibre.com>


--g22nKfEJVAyL8X+l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 10:57:44AM -0600, David Lechner wrote:
> On 11/21/24 4:18 AM, Guillaume Stols wrote:
> > A new compatible is added to reflect the specialized version of the HDL
> > that is not covered by the IIO backend paradigm: We use the parallel
>=20
> It still is being used as an IIO backend, so I would leave out the
> phrase "that is not covered by the IIO backend paradigm".
>=20
> > interface to write the ADC's registers, and accessing this interface
> > requires to use ADI_AXI_REG_CONFIG_RD,ADI_AXI_REG_CONFIG_WR and
> > ADI_AXI_REG_CONFIG_CTRL in a custom fashion.
> >=20
> > Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml=
 b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > index e1f450b80db2..43bc0440c678 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > @@ -17,13 +17,20 @@ description: |
> >    interface for the actual ADC, while this IP core will interface
> >    to the data-lines of the ADC and handle the streaming of data into
> >    memory via DMA.
> > +  In some cases, the AXI ADC interface is used to perform specialized
> > +  operation to a particular ADC, e.g access the physical bus through
> > +  some special register to write ADC registers.
> > +  In this case, a different compatible is used, and the driver behaves
>=20
> Quick, delete the word "driver" before Krzysztof sees it. :-p

And also perhaps worth mentioning under the --- line that the x in the
compatible is not a wildcard, for similar reasons ;)

--g22nKfEJVAyL8X+l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZz+P0QAKCRB4tDGHoIJi
0pXGAQCVz8AR9qILOY2+4SlinMtDxnCsNOcoSwEUTO3ICQyBCAD/dUJKqoKfiB0H
Z55xs2qiCI4e517oaHN6L/d1DT0r5gs=
=jy8b
-----END PGP SIGNATURE-----

--g22nKfEJVAyL8X+l--

