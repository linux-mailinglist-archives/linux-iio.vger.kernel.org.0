Return-Path: <linux-iio+bounces-11949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EBB9BF2F1
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 17:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A991F21F07
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 16:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B70204080;
	Wed,  6 Nov 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cshKHZZV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0587189F5C;
	Wed,  6 Nov 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909592; cv=none; b=m45RpY2zpRogdIZNTpBBsxZUM+2oEwrR/eAsZOm2hZxH37F3iflU5C3NMbgqw9imN1rlAvD3Y78ehLPiY1MjzYzHfTsDPCidM4RDQKLIVyT96w5GwxJjsfLj7IGftVN92/fenB7YorsTKVQQyQvWNQJSXxiD1miUEwAAHjOtirc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909592; c=relaxed/simple;
	bh=dTuD8etQK1as5a2h+NWAEDvTetEZY5ki9oji2OXxqRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1vUoX5Llm5wQM4utqLfsyz2tkuSwbRh6HZ54CBnykX/Vwx8RyzKUiZvakn41EmnyMzu3KiaKHkeKV38Q8IcN3reCXeZLy3USp3I7p2y6exWIUySaQr8t7tmvxVAKt/wxF3QYjLnXlpKsDeYTTajPHkM/kLD0cMbl4ZW0ju9wW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cshKHZZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F3AC4CEC6;
	Wed,  6 Nov 2024 16:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730909592;
	bh=dTuD8etQK1as5a2h+NWAEDvTetEZY5ki9oji2OXxqRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cshKHZZVNpfpeAjwuoOwWomv7lCCQFOmVRMbCC7WT4kNyMQKFjWHoFPWb8GmipzYc
	 hIz+8lhyrssZigWqq3FKL/8XbVIC8I+ssq0aliIPCCs8TybGcfg+QxmVlsSoqfaTAn
	 OWv2KGutS01+3hTJTNPHjThOCdlvWxJEfIVoO+y4WN7+yae750oUsL585Jgx5zI1rh
	 m4/DToo8zuSBwwR6EtDxtwTCjrBHujBn4RfxUNhxIkwArjVeI2ck5bG4aA6sbQheDr
	 CNJbzUu1GbXnxNbO23+5n5eeqOuv01d+QJpMBg3vk8bKfX0LniFbRc7WjTOEDQvCU5
	 sTZ2YVnG+tolw==
Date: Wed, 6 Nov 2024 16:13:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
Cc: Eason Yang <j2anfernee@gmail.com>, avifishman70@gmail.com,
	tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
	yuenn@google.com, benjaminfair@google.com, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	javier.carrasco.cruz@gmail.com, andy@kernel.org,
	marcelo.schmitt@analog.com, olivier.moysan@foss.st.com,
	mitrutzceclan@gmail.com, matteomartelli3@gmail.com,
	alisadariana@gmail.com, joao.goncalves@toradex.com,
	marius.cristea@microchip.com, mike.looijmans@topic.nl,
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
	yhyang2@nuvoton.com, openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: Add binding for Nuvoton
 NCT720x ADCs
Message-ID: <20241106-humid-unwired-1d3fa1f50469@spud>
References: <20241106023916.440767-1-j2anfernee@gmail.com>
 <20241106023916.440767-2-j2anfernee@gmail.com>
 <6c20875c-4145-4c91-b3b5-8f70ecb126f0@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MjU5mkQF8kA0duUf"
Content-Disposition: inline
In-Reply-To: <6c20875c-4145-4c91-b3b5-8f70ecb126f0@amperemail.onmicrosoft.com>


--MjU5mkQF8kA0duUf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2024 at 11:58:06AM +0700, Chanh Nguyen wrote:
>=20
>=20
> On 06/11/2024 09:39, Eason Yang wrote:
> > This adds a binding specification for the Nuvoton NCT7201/NCT7202
> > family of ADCs.
> >=20
> > Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> > ---
> >   .../bindings/iio/adc/nuvoton,nct720x.yaml     | 47 +++++++++++++++++++
> >   MAINTAINERS                                   |  1 +
> >   2 files changed, 48 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,=
nct720x.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.=
yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
> > new file mode 100644
> > index 000000000000..3052039af10e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/nuvoton,nct720x.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton nct7202 and similar ADCs
> > +
> > +maintainers:
> > +  - Eason Yang <yhyang2@nuvoton.com>
> > +
> > +description: |
> > +   Family of ADCs with i2c interface.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nuvoton,nct7201
> > +      - nuvoton,nct7202
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  read-vin-data-size:
>=20
> Is it generic property or vendor property? I tried to find in the
> https://github.com/torvalds/linux/tree/master/Documentation/devicetree/bi=
ndings
> , but it seems this property hasn't been used on other devices.
>=20
> If it is vendor property, then I think it should include a vendor prefix.
> For examples:
>=20
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bi=
ndings/iio/adc/adi%2Cad7780.yaml#L50
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bi=
ndings/iio/adc/fsl%2Cvf610-adc.yaml#L42
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bi=
ndings/iio/adc/st%2Cstmpe-adc.yaml#L22

An explanation of why it cannot be determined from the compatible would
also be good. Two compatibles and two values makes me a little
suspicious!

--MjU5mkQF8kA0duUf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZyuVjwAKCRB4tDGHoIJi
0r8qAP9P7kaywRwDNIUfUhRZgobeyzxRZW+mS9lmBafdUk9w+wD/abZJkKEzZukx
MAAD/6b+6Bclx/ACc2ypkNzWVK4scAU=
=fggK
-----END PGP SIGNATURE-----

--MjU5mkQF8kA0duUf--

