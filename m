Return-Path: <linux-iio+bounces-8693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CCC95BB2A
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 17:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E0A1F25620
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 15:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA561CDA05;
	Thu, 22 Aug 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Obach4Vn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917F91CCEF8;
	Thu, 22 Aug 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342202; cv=none; b=C/9M1rYoKXz84x6mqTRvmxphCK3s4tfKvjIX2DxZpOG04BrDpFcoyC7za6l51AJKr4h8ofQ9KHVuNETtaXAHbcPQbGLt9y+WpKIUFReDBSlFbxKbciB1sLf3yCMoczCFUQyFxLvYfp86nSKCng8comgW5pKswIevvIn6YJA+IRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342202; c=relaxed/simple;
	bh=gqhE289N3O+DWBlo4LTGRrk+e4dB0ttAA6yDY9Vx6Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTop7Fco08t96liLB+usrF5g1X0SXjoymSnrYEAD+Os8KO6MdsVFG6XaxCmLffB5URlnjOfk732x5mJO5MSSVgYq4Hrzl/HjbmMa75vGaiZxPBx09Ib5IwfrhtqlftI7202V83ngJ8NXJj+YUnWB0CMvxxXvTxeJRYxqtxZFpcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Obach4Vn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8DCC4AF0C;
	Thu, 22 Aug 2024 15:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724342202;
	bh=gqhE289N3O+DWBlo4LTGRrk+e4dB0ttAA6yDY9Vx6Js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Obach4VnevwF6PVZKlHVYAX/SY7dPgdcaffE4vqQTYortChW2G/daLYqHKZYTYQ1/
	 hg/z/F0dEVI4s3m38GSvo1rKVij4yA0CNHF5T54XHENtqCZFR01Z+x/e3lXfw5hYJ4
	 N833GugP1jkQPIDdYbaD+l8ijbmyy5sYm6XkcihCjxsfToUHqn9+azivPply8C69im
	 EuhKdf6crdSv6RLT25VId6iuen0NA5W4zoNcMT1YVsEJVc3vtXzJTNa5fQIdGwNE6i
	 YWwcoiD2ljEepK8x07Du3u7uQLPt8tJJsZfjL1ggOoyow7aK6CCeIAB7a8llSWPHyn
	 GfOs4j/drOpQQ==
Date: Thu, 22 Aug 2024 16:56:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Esteban Blanc <eblanc@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: iio: adc: add ADI ad4030, ad4630 and
 ad4632
Message-ID: <20240822-elixir-distort-a4b841f3bfa3@spud>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
 <20240822-eblanc-ad4630_v1-v1-1-5c68f3327fdd@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QqCA6/O2HNzlTRLS"
Content-Disposition: inline
In-Reply-To: <20240822-eblanc-ad4630_v1-v1-1-5c68f3327fdd@baylibre.com>


--QqCA6/O2HNzlTRLS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 02:45:17PM +0200, Esteban Blanc wrote:
> This adds a binding specification for the Analog Devices Inc. AD4030,
> AD4630 and AD4632 families of ADCs.
>=20
> - ad4030-24 is a 1 channel SAR ADC with 24 bits of precision and a
>   sampling rate of 2M samples per second
> - ad4630-16 is a 2 channels SAR ADC with 16 bits of precision and a
>   sampling rate of 2M samples per second
> - ad4630-24 is a 2 channels SAR ADC with 24 bits of precision and a
>   sampling rate of 2M samples per second
> - ad4632-16 is a 2 channels SAR ADC with 16 bits of precision and a
>   sampling rate of 500K samples per second
> - ad4632-24 is a 2 channels SAR ADC with 24 bits of precision and a
>   sampling rate of 500K samples per second
>=20
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4030.yaml    | 113 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   8 ++
>  2 files changed, 121 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> new file mode 100644
> index 000000000000..7957c0c0ac7a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2024 Analog Devices Inc.
> +# Copyright 2024 BayLibre, SAS.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4030.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD4030 and AD4630 ADC family device driver
> +
> +maintainers:
> +  - Nuno Sa <nuno.sa@analog.com>
> +  - Michael Hennerich <michael.hennerich@analog.com>

This doesn't match the MAINTAINERS file entry below FYI.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--QqCA6/O2HNzlTRLS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsdftQAKCRB4tDGHoIJi
0hJcAP9piPcb/kfHDWMWWLNLWnaNiTv0Wm2hR/LoUpOlyi0aqAD/ZC4fW7ZGSfAx
ZV8CecaSsRwy4+oC0PmlH56jyFhyMgA=
=bPdu
-----END PGP SIGNATURE-----

--QqCA6/O2HNzlTRLS--

