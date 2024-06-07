Return-Path: <linux-iio+bounces-6008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA429007A4
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9575229139D
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3831991AF;
	Fri,  7 Jun 2024 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0pt8R5C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D721615748C;
	Fri,  7 Jun 2024 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771751; cv=none; b=TgwdTf8lm/k1ixMwM23rMXcQ2Tgha3NEMzoERsj1b/1LOtFrBkpnQ4USf/fx552aHaJllRKiAgUghcpLmkqmtQ2zwTnJpGG/tusDlZG+VfGIdS/vtQd2+wZhkAfGy+AJD9UhktJwsNAmF+mbBZkhR84mNSOlJL4wfYz8v1Usx/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771751; c=relaxed/simple;
	bh=Dah+ChQ30COmYKoOSkEp/ZOZCouT1BnT04Y9qNO3bFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvHROvybcqglNqId/JmR704kjvJpsE5RRyBmXiXH29NjBl0IZh1BmPl+Mes9ZQKxEE+2iP3nF4ycIG7rsBsZl+uPwo+HHuRiVh2hARQ1TAuCNWf4fB0WJQfg5SP70RoyjF/0c4HrolJMCkm3jeL4F/+3uR+mQME8xlaJrnZx6UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0pt8R5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803CFC2BBFC;
	Fri,  7 Jun 2024 14:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717771750;
	bh=Dah+ChQ30COmYKoOSkEp/ZOZCouT1BnT04Y9qNO3bFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F0pt8R5CXyV/cemvv21kVco3FGaAkegSMt9veVJm8QdOmEewdp6v2prpOTdK8KqYR
	 X08/kOkeDW1WRz2D2oerNVjDqpzzAxXe8vW7a6NsvEsuqxfAcIpZk7Ty8OWkaf/mvJ
	 A78sQx4NdqRKLekmTLXyQ88TCgidS0ldFng0qSylRUzumtGfPaM3Us0fr+vXtLI4lG
	 i6oD0YBFWTBQI4VRuJYi0rv6HgQTDH3yzXWn/+TxP70fbXXmCrEUSFshmdNFexwxss
	 5JqThMZbY2K866L/GWanFdtNgo2gFMZkjWK3hQY9Pnz0Xl8deaSb1W9YDZ0pB6pq3G
	 v9VO+G2u3XgXQ==
Date: Fri, 7 Jun 2024 15:49:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: iio: adc: Add AD4000
Message-ID: <20240607-declared-chubby-df1c81646794@spud>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <b8a211e09c17f5a9f0a6aa6e11d6375ff398c918.1717539384.git.marcelo.schmitt@analog.com>
 <20240605-tables-pectin-66d4d4dd12b5@spud>
 <ZmMawAukzpOcdJqy@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mGYo5D1kJPq130vJ"
Content-Disposition: inline
In-Reply-To: <ZmMawAukzpOcdJqy@debian-BULLSEYE-live-builder-AMD64>


--mGYo5D1kJPq130vJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2024 at 11:35:44AM -0300, Marcelo Schmitt wrote:
> On 06/05, Conor Dooley wrote:
> > On Tue, Jun 04, 2024 at 07:43:53PM -0300, Marcelo Schmitt wrote:
> > > Add device tree documentation for AD4000 series of ADC devices.
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,ad4000
> > > +      - adi,ad4001
> > > +      - adi,ad4002
> > > +      - adi,ad4003
> > > +      - adi,ad4004
> > > +      - adi,ad4005
> > > +      - adi,ad4006
> > > +      - adi,ad4007
> > > +      - adi,ad4008
> > > +      - adi,ad4010
> > > +      - adi,ad4011
> > > +      - adi,ad4020
> > > +      - adi,ad4021
> > > +      - adi,ad4022
> > > +      - adi,adaq4001
> > > +      - adi,adaq4003
> >=20
> > Are all these actually incompatible? I'd like a note in the commit
> > message as to why that's the case. A quick look at the driver showed
> > that the differences in the driver between the ad402{0,1,2} are limited
> > to the "dev_name". Same went for some other devices, like the
> > ad40{02,06,10}.
>=20
> Yes, that's correct. Some chips only vary by name and max sample rate whi=
ch
> boils down to only having a different dev_name in the driver.
> Can those have grouped compatible strings?
> dt_binding_check fails if curly brackets are used.
> properties:
>   compatible:
>     enum:
>       - adi,ad402{0,1,2}

compatible:
  oneOf:
    - const: adi,ad4020
    - items:
        - enum:
            - adi,ad4021
            - adi,ad4022
        - const: adi,ad4020

>=20
> The groups of similar chips are:
> AD4020/AD4021/AD4022
> AD4003/AD4007/AD4011
> AD4002/AD4006/AD4010
> AD4001/AD4005
> AD4000/AD4004/AD4008


--mGYo5D1kJPq130vJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmMd4QAKCRB4tDGHoIJi
0m3aAQCqm1iAmlqMMULyvGG/jj/YF3eqzO7Wj9CXKpMOs3OTgQD9Hl43+DrEc4x2
0bmGjvUv5UElOQKUwtXj9J6IRcWdhw8=
=/nSM
-----END PGP SIGNATURE-----

--mGYo5D1kJPq130vJ--

