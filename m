Return-Path: <linux-iio+bounces-8601-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F1A95704D
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 18:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6913F1C22B57
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 16:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AD8176252;
	Mon, 19 Aug 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYkisTP+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E674AEF2;
	Mon, 19 Aug 2024 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085069; cv=none; b=gZqAuVN1DrgSkHFIztgBBovaeTI1mS1Qx7ex8w3vEibBjVmoK0XLDlEnh67mtN9Mvv8MIMzLsAKya1c6ZXDWtCDFY4IQRd9Uj3B4cCkSBUgio2SMuow7kbt+qsqUdApJVglLy6hcrl1DSFFG5xNZjcSe7wej128FInO7+ZIq7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085069; c=relaxed/simple;
	bh=bFh3yEYrHSvs/OzDOIJfaLafilZehjt1D8ebBRA7Vsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bugMFo012DmvILRdXpX/P8GrozkdKmzIkETSSdteHWXKa+ZOnkWQUZfU6eHGSicDYx+G9yGGrN96q7dZDVv+yqMex7h/PmQaMZiJPI5rtXRDv2xw9qz/QZKGNjkr5n4T50YRVFdegI/f5bmqVEukP8Nq1TM3alRwVg/WMzvXLpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYkisTP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84375C32782;
	Mon, 19 Aug 2024 16:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724085068;
	bh=bFh3yEYrHSvs/OzDOIJfaLafilZehjt1D8ebBRA7Vsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZYkisTP+vWlGWv0LONLRKCb2TreOJDqWIlDUY761Qc+Zp25Vl+d1Bj5iWV5JnLato
	 QrtB2huch/DaQrKQY3rN3rC3bw607tyvSFabHNdqAW5SCHlRY/XiJ5pmmILJOxUCC9
	 pnCUrRCUAV0NrNRMFhNt0kFHqj/RuETABGGF/gIQEfBhiaSLEaV5RWJe1gwzp5ffAw
	 j6XbT09Q3oDkBIsjkn3puZXqBmtM7rnMR80QUcFTzVTwITxyuAPo6r3nJoH+kHEa0E
	 gy6CovRfyuexR9kYBGKELl2SaRY72imcQdWJCZZS07AXjc3IH3SgrI9DUETedDLPrG
	 eHVILsVa0Ubhg==
Date: Mon, 19 Aug 2024 17:31:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	David Lechner <dlechner@baylibre.com>,
	Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: add AD762x/AD796x ADCs
Message-ID: <20240819-sensation-hardcopy-a547fcb1456c@spud>
References: <20240819-ad7625_r1-v3-0-75d5217c76b5@baylibre.com>
 <20240819-ad7625_r1-v3-1-75d5217c76b5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VqJEa9VIgsGQhIQs"
Content-Disposition: inline
In-Reply-To: <20240819-ad7625_r1-v3-1-75d5217c76b5@baylibre.com>


--VqJEa9VIgsGQhIQs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 10:11:43AM -0400, Trevor Gamblin wrote:
> Add a binding specification for the Analog Devices Inc. AD7625,
> AD7626, AD7960, and AD7961 ADCs.
>=20
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--VqJEa9VIgsGQhIQs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsNzRwAKCRB4tDGHoIJi
0qSVAP43gHhwvpghy3xyq91bfAl3CMrBDdPb852H64R41VXCsgEA4E/7/2E7NgUS
ED4DwCp5vXQhlqJHLD/Yz1kV1XRhCg0=
=JTay
-----END PGP SIGNATURE-----

--VqJEa9VIgsGQhIQs--

