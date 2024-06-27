Return-Path: <linux-iio+bounces-6989-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E4691AC50
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 18:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4891F264F3
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 16:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30BF19938A;
	Thu, 27 Jun 2024 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvbP5fE0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87944196D9E;
	Thu, 27 Jun 2024 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504801; cv=none; b=LJcer+yqoyFyFDpfeBpYWlVpmxN92BwZO4A2U8R8O4+qrWeeiSQzLPcpwNE3CEZvXBqNlfOLT4uCTIDtxVP3WCwPrRiZ/nLPxycS9fZp6qX5hW28CIm58LTCfDf4LfCBd8rzEYY0JgxXKvnE9gFYfXGAck7XsWo/tIA9L2XVuxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504801; c=relaxed/simple;
	bh=Xy8p5tBdXTNSi+VSsPN5KrFq5OpVySTdyBhY1w8K56U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqlA4Mov2vsOzWfYI4cHZKpKsdVDebrX/xJ2Fe32kF4RkXmuEHeFDBtnH9/Bm5kLSDHEVsPWHduza64ecvDs6+jUtXLJrcknHMh1Ao4bio5IRwNy5KaZaDFV5y0gx0V1Zk8JFsWA3VUVeQZTXjBD/Ho1zQCdRhalir7MyU4IeQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvbP5fE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6F0C2BBFC;
	Thu, 27 Jun 2024 16:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719504801;
	bh=Xy8p5tBdXTNSi+VSsPN5KrFq5OpVySTdyBhY1w8K56U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TvbP5fE0s7bxXlV/ANoBDW1w2LV+dB4xnZkJcmTZhncZcXM6P2DzUFzoV2oUyLC3j
	 QDVBT2UwKtx/3Ayl8GIil5t6RHhx1X0/0148KrUS627JT/Ad/08CLLw75ZlLU+gu/C
	 YXVmozK+WaSkr09x9RARMyZIa17Ky23qmzzb8nCZu3u6Xvrt7rihqnRRPfH9X/aHkL
	 5bX1ndfP5JOtyoT7RyELKraJSU034fjOrP94AeRFluzZueCrFid8ypTQdkt9dTbC/F
	 dNtZXVE+kVfFkTFdcFgx5IgfoIOZX68oGI/POaobDlv6+J6Z3kgJK+qNO/yd1YD99L
	 BUR/ueBnFowXw==
Date: Thu, 27 Jun 2024 17:13:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Olivier MOYSAN <olivier.moysan@foss.st.com>
Cc: fabrice.gasnier@foss.st.com, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] dt-bindings: iio: add sigma delta modulator
 backend
Message-ID: <20240627-identity-enviable-4fda0b3a09c0@spud>
References: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
 <20240625150717.1038212-6-olivier.moysan@foss.st.com>
 <20240625-babied-skies-0722dbdfc524@spud>
 <eefc746a-2181-41da-b777-b077a4c19b77@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qjo94KATqhmQaPj6"
Content-Disposition: inline
In-Reply-To: <eefc746a-2181-41da-b777-b077a4c19b77@foss.st.com>


--Qjo94KATqhmQaPj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 06:40:58PM +0200, Olivier MOYSAN wrote:
> Hi Conor,
>=20
> On 6/25/24 17:34, Conor Dooley wrote:
> > On Tue, Jun 25, 2024 at 05:07:13PM +0200, Olivier Moysan wrote:
> > > Add documentation of device tree bindings to support
> > > sigma delta modulator backend in IIO framework.
> > >=20
> > > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> >=20
> > I don't review bindings for a job, I can only reliably get to look at
> > my mail queue in the evenings, please give me a chance to reply to you
> > before you submit a new version.
> >=20
>=20
> Sorry, the short review delay.
>=20
> > > +$id: http://devicetree.org/schemas/iio/adc/sd-modulator-backend.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Sigma delta modulator backend
> >=20
> > Same comments about filename and title apply here as the previous
> > version. "TI $foo Sigma Delta Modulator" and drop the reference to back
> > ends or the pretence of being generic.
> >=20
>=20
> The logic here is the same as for the former sigma delta modulator driver.
> (see discussion [1])
> I mean introducing a generic and minimalist driver to support sd modulato=
rs,
> but not dedicated to a specific modulator. The ads1201 is chosen as a bas=
ic
> modulator here. But it is rather an arbitrary choice.
>=20
> I agree "backend" reference is not really relevant here. I have to think
> about a way to manage the coexistence of this sigma delta modulator driver
> with its former version.

To be blunt, I don't care about drivers! Well I do, but not in this
particular context. You can absolutely have a driver that supports
multiple backends or sigma delta modulators, but right now we are
talking about a binding and this binding supports exactly one sigma
delta modulator - and with an explicit compatible. In that context,
presenting the binding as generic makes little sense.

> [1] https://lore.kernel.org/all/6943aaf5-b580-0fd1-7a2e-b99f7a266388@st.c=
om/

Looking at this though, I question the binding more... The programming
model of the device is identical as a backend or otherwise, so it
shouldn't be getting a new compatible. Isn't this actually as simple as
adding #io-backend-cells to the existing binding and using that to
determine whether the device is being used as a backend or in isolation?

Thanks,
Conor.

--Qjo94KATqhmQaPj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn2PnAAKCRB4tDGHoIJi
0o7EAQCyFBPYkFKusgKeZs1ud2wJm+9/kIQha/hizkDF8ymXQgD9EbUe6GulJhrb
/0Pi6G9SFcNRfPkj1g69k9ejdJ84hAc=
=6JuI
-----END PGP SIGNATURE-----

--Qjo94KATqhmQaPj6--

