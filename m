Return-Path: <linux-iio+bounces-9385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101A09719CB
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 14:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB221C225C6
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 12:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6461B7910;
	Mon,  9 Sep 2024 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="F3gRozJ3"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC88C1B373E;
	Mon,  9 Sep 2024 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886036; cv=none; b=Dd+UdOsUVhTJHwyyoKsVmC0WtkcGFCn4Ovjkxt9Lg8vFlmqdN+uSf2+GABMAHx2ha8767TE3aDTQqA3Kpwo60rhfZ/csjqMU2TnT0kt3BzAU7wJ9tz4bLyzV4vEGtB9cDZUZ+Q1kVKdHRUl56PZneo3ngxMD9JUM2E0aaGu4JKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886036; c=relaxed/simple;
	bh=YwueyqPEiojXYGM/XHQSYkEN7VpW4ugk0re86uPQprg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tcchp+s3ciQAzz8wWe1ob8fx02f33sCOqWvh6sCyuumrAi+C+nKZ9vSUr8ONbno+CBoAqJIUJEtCfSClpkerGSSuOvsoB/EKyfDah+ZaRXJt78q0WpTrz8/SUy/X09jUKHQYhqz3khv9SkfDFRM8l+fGWLgm1hNLUfu0MPEBn9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=F3gRozJ3; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725886034; x=1757422034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YwueyqPEiojXYGM/XHQSYkEN7VpW4ugk0re86uPQprg=;
  b=F3gRozJ3nwRDz6rj3OsC2myPBnLWxUxPtDojmDV8zlv8lKfPoO//2eB9
   3VIqn/oQkNR7vuEFpu++98bRJmZbJJBB51gSMiDHnaM8EWi7l6gbEkF2U
   6kig/9LV0JsVY0C9+siFfFDgN/FzOj1nUnXbB4DwlDZkXMkcwsxWFGRtO
   3+pnAaJ+apabmOXXHKoj244ie/7t10etN/rjmERdVx66DJnlLXYDpJiLQ
   dJXInXtpk1d1zLNoD/EfntBWguGRUe/yEBdY9AqsilWDHj0IDb5gYlW7L
   S+iMHNNA7miHFiGzoK1UtjOgwHabj8bS+Dlv+gYIyPne1gIX07Jutx1jB
   Q==;
X-CSE-ConnectionGUID: nv1fxCHqT6u0Komx7IH4Dw==
X-CSE-MsgGUID: tkSYOf/jSGmgH9KHZMg+bA==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="asc'?scan'208";a="34630339"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 05:47:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 05:47:09 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 9 Sep 2024 05:47:07 -0700
Date: Mon, 9 Sep 2024 13:46:34 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Lechner
	<dlechner@baylibre.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: iio: dac: ad3552r: add io-backend
 property
Message-ID: <20240909-dwelled-specimen-949f44c8d04d@wendy>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-1-87d669674c00@baylibre.com>
 <20240908132925.331c5175@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w76YreWAZToXj343"
Content-Disposition: inline
In-Reply-To: <20240908132925.331c5175@jic23-huawei>

--w76YreWAZToXj343
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 08, 2024 at 01:29:25PM +0100, Jonathan Cameron wrote:
> On Thu, 05 Sep 2024 17:17:31 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
>=20
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >=20
> > There is a version AXI DAC IP block (for FPGAs) that provides
> > a physical bus for AD3552R and similar chips. This can be used
> > instead of a typical SPI controller to be able to use the chip
> > in ways that typical SPI controllers are not capable of.
> >=20
> > The binding is modified so that either the device is a SPI
> > peripheral or it uses an io-backend.
> >=20
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>=20
> > =20
> >  required:
> >    - compatible
> > -  - reg
> > -  - spi-max-frequency
> Sort of feels like both reg and spi-max-frequency
> are valid things to specify.=20
>=20
> Maybe we have an excellent IP and dodgy wiring so want
> to clamp the frequency (long term - don't need to support
> in the driver today).
>=20
> Maybe we have an axi_dac IP that supports multiple
> front end devices?  So maybe just keep reg?

I'd like to be convinced that this incarnation of the AXI DAC IP is not
a spi controller and that a ref to spi-controller.yaml is not out of
place here. It may not be something that you'd ever use generally, given
the "weird" interface to it, but it does seem to be one regardless.

I'd also really like to know how this fits in with spi-offloads. It
/feels/, and I'd like to reiterate the word feels, like a rather similar
idea just applied to a DAC instead of an ADC. We kinda hit a dead end
with generalising the spi-offload stuff due to lack of similar devices,
but maybe we were looking for other ADCs when instead it should have
been at all other types of IIO device?

> > =20
> >  additionalProperties: false
> > =20
> > @@ -238,4 +254,26 @@ examples:
> >              };
> >          };
> >      };
> > +
> > +  - |
> > +    backend: axi_dac@44a70000 {

"axi_dac":
- no underscores in node names please
- shouldn't it be "io-backend@" or something like that? Or even
  spi@? axi_dac isn't a class of device, and this device is not, AFAICT
  a DAC at all since the ad3552r is what actually does the conversion.

Cheers,
Conor.

> > +        compatible =3D "adi,axi-dac-ad3552r";
> > +        reg =3D <0x44a70000 0x1000>;
> > +        dmas =3D <&dac_tx_dma 0>;
> > +        dma-names =3D "tx";
> > +        #io-backend-cells =3D <0>;
> > +        clocks =3D <&ref_clk>;
> > +        dac {
> > +            compatible =3D "adi,ad3552r";
> > +            reset-gpios =3D <&gpio0 92 1>;
> > +            io-backends =3D <&backend>;
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +            channel@0 {
> > +                reg =3D <0>;
> > +                adi,output-range-microvolt =3D <(-10000000) (10000000)=
>;
> > +            };
> > +        };
> > +    };
> > +
> >  ...
> >=20
>=20

--w76YreWAZToXj343
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZt7uKgAKCRB4tDGHoIJi
0i+GAP47U+aha/lBvcgszglNNCbJ7/Chq59ThvT3rLwBXWgfhgD8CvJpeyWfNhjP
Jxcn0l55I3RfOqy3yjYzz/sP/DYncQ0=
=nWI1
-----END PGP SIGNATURE-----

--w76YreWAZToXj343--

