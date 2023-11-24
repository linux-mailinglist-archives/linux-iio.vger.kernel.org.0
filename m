Return-Path: <linux-iio+bounces-317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C089A7F7344
	for <lists+linux-iio@lfdr.de>; Fri, 24 Nov 2023 13:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483BEB21404
	for <lists+linux-iio@lfdr.de>; Fri, 24 Nov 2023 12:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175E8208C0;
	Fri, 24 Nov 2023 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXpvF9N0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C343F200DE;
	Fri, 24 Nov 2023 12:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8307CC433C8;
	Fri, 24 Nov 2023 12:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700827316;
	bh=hrjlwaXyO8Sx9eRi9836/W2vWddRTOY8yyICsyVGQyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kXpvF9N01cUCt0D3+EfNq75stz295/8YSl20fI+Q3492hlYD0SgpNukiKkzW27kNN
	 1CXZLJLZBx+EBi1T/pNA5BXU64QcxyLLTEvmY24tZz1qxTIwtXsPMMkwVEEkTBYEO9
	 yo2SqAvpafV4aJLLPflLFG4HF5KeqFqsGouCueuPcJMtlcHmV8EWrL8lxtC3F9iY8w
	 LEbxqCB1qHnNtnwNPx4Ftz0CYxyFkv58CsgKDpK1+QcgWUwrjSOJoqD7cNa+s/gbMk
	 TPEE/8x85NT+r0FaLrHyz4Oprnrc/JCxc+tGGK1l77gJcoGNRUB+aAomUdrG/4imE5
	 9zVFTlPWkzw0w==
Date: Fri, 24 Nov 2023 12:01:52 +0000
From: Conor Dooley <conor@kernel.org>
To: peiyu li <579lpy@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: humidity: Add TI HDC302x support
Message-ID: <20231124-much-screen-ea709763e69b@spud>
References: <20231118105815.17171-1-579lpy@gmail.com>
 <20231118110232.17261-1-579lpy@gmail.com>
 <20231119-donated-hypnotist-33529b63bee8@spud>
 <CAELPsEaQZ1a-JO2Vne_MZXWN+nVh7LEw1z_wbHVjiLrKPtd_rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0SWPnNmwqGgtzzTg"
Content-Disposition: inline
In-Reply-To: <CAELPsEaQZ1a-JO2Vne_MZXWN+nVh7LEw1z_wbHVjiLrKPtd_rQ@mail.gmail.com>


--0SWPnNmwqGgtzzTg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 07:38:52PM +0800, peiyu li wrote:
> On Sun, Nov 19, 2023 at 21:41, Conor Dooley wrote=EF=BC=9A
> ...
> > > - change the maintainers to me.
> > > - hdc3020,hdc3021,hdc3022 are compatible,I've changed the dirver.
> >
> > Does that even compile? It was the binding I wanted you to change, not
> > the driver. Take a look at the example-schema for how to do this.
> In example-schema.yaml, I did not see another way of writing "compatible".
> So does this mean I need to add an example contains
> compatible =3D "ti,hdc3021", "ti,hdc3020";

There is an example in the example schema with two compatibles, take a
look.

--0SWPnNmwqGgtzzTg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWCQsAAKCRB4tDGHoIJi
0n0bAQCOezRt8aq9W+VU8hN3LZsgVmBPu0GZb0b1OVqYPTsc8gD/adYZhNaSOIBu
34xTfwVwj3ctdCHhWvFOaODJRdmQiAI=
=gdWQ
-----END PGP SIGNATURE-----

--0SWPnNmwqGgtzzTg--

