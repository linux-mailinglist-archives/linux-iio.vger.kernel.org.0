Return-Path: <linux-iio+bounces-8897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AC09665A5
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 17:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD0E2851A1
	for <lists+linux-iio@lfdr.de>; Fri, 30 Aug 2024 15:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE1D1B790F;
	Fri, 30 Aug 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDQ+cEJc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A176B1B5821;
	Fri, 30 Aug 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031994; cv=none; b=qNuqUGS0jg4rQrYfaqUX8sk6U7eZKxlkP09lV60EmdyxCZBYUVAm4JY+WN0+1F1rEzPLuqltopVBlmfPWN/4t44+8ncfX4TkmbTDwrr7XXp+JOay2vkeYbPe0zRN52hM5myvB6cuC7xNfiT/ijRgiiDVBPn8um/49T5Vq55EzdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031994; c=relaxed/simple;
	bh=oNCCs+eEzkGQ4trGqNatqV533zN5HVkZhKWaI/iEjsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kc+xQgUNnHbj+u5SOPGzgH1K1r8Jj+zYf8kf9WfCrnEFxvIGxi+ILFnOUz01NQ2Hz5sL6gZiFySdBvkZ6zPEuEy1HdQ7olQWm7HXc8ncCGbkY9f8cvpeQUycRML6TK1yhCvN6j6TA9v3h1y3YfiSOTGpEuVmF8/q+8Q8PXYWJmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDQ+cEJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A32C4CEC5;
	Fri, 30 Aug 2024 15:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725031994;
	bh=oNCCs+eEzkGQ4trGqNatqV533zN5HVkZhKWaI/iEjsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDQ+cEJcRwR/2tknocKteL5zFtlGsV9ZXtI0ELlEhUjTcbPen4gJ/sQbJFQi+DqCy
	 1vRDBGnUVDXeezAKTEFqQAJveWxVBsKXQ0ohg0Po1b8hIg4wI8dFUM3LcMaWl0fvuG
	 qZBKE4apniG1dssrJ220EiodkrO0O6A4NAO5m2gyASR569VU9wwu3bCRDyim4nNEhy
	 6bdMCc9mZltrV2zsWd+cJk/oGIU0AU+BarRlknq0fgfwyFt/4ryB8qlaE5/FVmzQzl
	 ETZJXjZZ1GicvI8p6ZzymeXhCbdrClME2tYdRuPyAQZer9mLNAryAWTh6w5Gccb00e
	 3CXQR1XhpTaGA==
Date: Fri, 30 Aug 2024 16:33:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH RFC 4/8] dt-bindings: iio: dac: add adi axi-dac bus
 property
Message-ID: <20240830-quilt-appointee-4a7947e84988@spud>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>
 <20240829-stopwatch-morality-a933abb4d688@spud>
 <d4eddc24-9192-4a4a-ac67-4cfbd429a6a9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O8AcbMJiu18HmGgA"
Content-Disposition: inline
In-Reply-To: <d4eddc24-9192-4a4a-ac67-4cfbd429a6a9@baylibre.com>


--O8AcbMJiu18HmGgA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 10:19:49AM +0200, Angelo Dureghello wrote:
> Hi Conor,
>=20
> On 29/08/24 5:46 PM, Conor Dooley wrote:
> > On Thu, Aug 29, 2024 at 02:32:02PM +0200, Angelo Dureghello wrote:
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > >=20
> > > Add bus property.
> > RFC it may be, but you do need to explain what this bus-type actually
> > describes for commenting on the suitability of the method to be
> > meaningful.
>=20
> thanks for the feedbacks,
>=20
> a "bus" is intended as a generic interface connected to the target,
> may be used from a custom IP (fpga) to communicate with the target
> device (by read/write(reg and value)) using a special custom interface.
>=20
> The bus could also be physically the same of some well-known existing
> interfaces (as parallel, lvds or other uncommon interfaces), but using
> an uncommon/custom protocol over it.
>=20
> In concrete, actually bus-type is added to the backend since the
> ad3552r DAC chip can be connected (for maximum speed) by a 5 lanes DDR
> parallel bus (interface that i named QSPI, but it's not exactly a QSPI
> as a protocol), so it's a device-specific interface.
>=20
> With additions in this patchset, other frontends, of course not only
> DACs, will be able to add specific busses and read/wrtie to the bus
> as needed.
>=20
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > ---
> > >   Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 9 ++++=
+++++
> > >   1 file changed, 9 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.ya=
ml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > index a55e9bfc66d7..a7ce72e1cd81 100644
> > > --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > @@ -38,6 +38,15 @@ properties:
> > >     clocks:
> > >       maxItems: 1
> > You mentioned about new compatible strings, does the one currently
> > listed in this binding support both bus types?

You didn't answer this, and there's insufficient explanation of the
"hardware" in this RFC, but I found this which is supposedly the
backend:
https://github.com/analogdevicesinc/hdl/tree/main/library/axi_ad3552r
adi,axi-dac.yaml has a single compatible, and that compatible has
nothing to do with "axi_ad3552r" as it is "adi,axi-dac-9.1.b". I would
expect either justification for reuse of the compatible, or a brand new
compatible for this backend, even if the driver can mostly be reused.

Could you please link to whatever ADI wiki has detailed information on
how this stuff works so that I can look at it to better understand the
axes of configuration here?

> >=20
> > Making the bus type decision based on compatible only really makes sense
> > if they're different versions of the IP, but not if they're different
> > configuration options for a given version.
> >=20
> > > +  bus-type:
>=20
> DAC IP on fpga actually respects same structure and register set, except
> for a named "custom" register that may use specific bitfields depending
> on the application of the IP.

To paraphrase:
"The register map is the same, except for the bit that is different".
If ADI is shipping several different configurations of this IP for
different DACs, I'd be expecting different compatibles for each backend
to be honest.
If each DAC specific backend was to have a unique compatible, would the
type of bus used be determinable from it? Doesn't have to work for all
devices from now until the heath death of the universe, but at least for
the devices that you're currently aware of?

> > If, as you mentioned, there are multiple bus types, a non-flag property
> > does make sense. However, I am really not keen on these "forced" numeri=
cal
> > properties at all, I'd much rather see strings used here.

> > > +    maxItems: 1
> > > +    description: |
> > > +      Configure bus type:
> > > +        - 0: none
> > > +        - 1: qspi

Also, re-reading the cover letter, it says "this platform driver uses a 4
lanes parallel bus, plus a clock line, similar to a qspi."
I don't think we should call this "qspi" if it is not actually qspi,
that's just confusing.

Cheers,
Conor.

> > > +    enum: [0, 1]
> > > +    default: 0
> > > +
> > >     '#io-backend-cells':
> > >       const: 0
> > >=20
> > > --=20
> > > 2.45.0.rc1
> > >=20
> --=20
>  ,,,      Angelo Dureghello
> :: :.     BayLibre -runtime team- Developer
> :`___:
>  `____:
>=20

--O8AcbMJiu18HmGgA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtHmNQAKCRB4tDGHoIJi
0nuSAP4/5s5LIi7WeGptks/V/sxAnqULmH/Xr48/M9Kso5CxBAD/T/7gk0aGvLvK
qFh6V6pwK6t+OBBihFTVSjmPo1KGDAA=
=e7vR
-----END PGP SIGNATURE-----

--O8AcbMJiu18HmGgA--

