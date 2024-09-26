Return-Path: <linux-iio+bounces-9797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A1C9876AC
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 17:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667E32869A3
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 15:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4D5152165;
	Thu, 26 Sep 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ds/7j4pg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9368E13777E;
	Thu, 26 Sep 2024 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365248; cv=none; b=JSb5M+OqqJIsoF+PYFFxLA0/tSPSTfzp0q+Wvaj2kqDDed70yraJRfbxeiSJ/yASPKvCnVdG9KSA+QCtpx4oab/j+RolSFLqeRoz8L3cnXHn+kxlZnvZ9U4RXekdsmkXTCMHakxdxteOJIM1pvySP0k/OxcuJ5uxiy86ObQ/75M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365248; c=relaxed/simple;
	bh=3XqQa1S4pPEpYGC473x6A+WKkpX5QqHWPg4UIF/AHv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=henqpOZWiQpFlLnN692vRcRiuI15MCrU832hZJwFSAC1BfeNWbojcHINhGwAjVABw5FhIFBD7lq9OENeCFk3jNKZ7osLxwbCzZfBw1ZGPIO3UO3lnk6SS+OIm4+tnkyTZkYHVRddd0PNB/MHo29Ymh0A94KDFzPQgdQ5P2iaf30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ds/7j4pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC4DC4CEC5;
	Thu, 26 Sep 2024 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727365248;
	bh=3XqQa1S4pPEpYGC473x6A+WKkpX5QqHWPg4UIF/AHv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ds/7j4pgNDAn1Hhdsk2P+iELKBRcq/g3fK5rYEB71F/+wETOSYdNaIpPQkJKu4ZIL
	 OS7s5WpkI+hODgHBJqArlTnmHFqHJk6pZwDhhmBa92fCLQ+6BU06D1QW0VQVwlIWPe
	 zSbfI++Zhi6VUnW86ZgcBifi9gkPhEZdvjH+iD8nPqufV5ElF8mBLNJpLFbibSWOur
	 zY/iEpbe4hMo+TujBt0VQKklGs+v8jgYGWJg9ZffnWknLDwmYFSKgMPOcPRJJtjSkC
	 IaBfOc25+w6Ca5I0iIWkhvYl0MzzCNEu8JKKZzoxoJfqe4fD8HuWhqcda0JZ0+cynV
	 Iaf9pj55Cskuw==
Date: Thu, 26 Sep 2024 16:40:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ivan Mikhaylov <fr0st61te@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: iio: adc: add a7779 doc
Message-ID: <20240926-tasting-twitter-01e807270dd0@spud>
References: <20240926135418.8342-1-ramona.nechita@analog.com>
 <20240926135418.8342-2-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dPcabCR052Cwt+GZ"
Content-Disposition: inline
In-Reply-To: <20240926135418.8342-2-ramona.nechita@analog.com>


--dPcabCR052Cwt+GZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 04:53:55PM +0300, Ramona Alexandra Nechita wrote:
> Add dt bindings for AD7779 8-channel, simultaneous sampling ADC
> family with eight full =CE=A3-=CE=94 ADCs on chip and ultra-low input
> current to allow direct sensor connection.
>=20
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--dPcabCR052Cwt+GZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvWAeQAKCRB4tDGHoIJi
0mFPAP90X6GYF+zb6YW43Qnl+FiKGEOBCXku3k7B8ji0hQWELwD9HtdDik5VwIF4
duc//BfDAMKiQyC6Y8JNrHZ1xLW+Vwc=
=vQQH
-----END PGP SIGNATURE-----

--dPcabCR052Cwt+GZ--

