Return-Path: <linux-iio+bounces-7311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6501C92742C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 12:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94861B23D35
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 10:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073CB1ABC45;
	Thu,  4 Jul 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Y/BW60Uw"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52C712D76E;
	Thu,  4 Jul 2024 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720089470; cv=none; b=Yeeu6RYsVpHz1b/KY0eh0R6/IjadbMepzUAvFqqpR+Mm3cQapV/d8BSkP4bHkWrtGG/mpWZzXfbI0K1e2hbqBAD1YpYu+Mb+POdLUriw1k2skPLgXj77F7byY+cxQg6pMFuL1dNE6IckoAiZ9MQj9lHiBSHLBDkhmIEU/KuL6a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720089470; c=relaxed/simple;
	bh=I3yB44eJpSE5MtEWunHhYNnzEUavV3jYSvRon/R63q4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbHPckDAYBBBiIu936i16t8Ea7HDRY7thgZieRxfi5s8sQJ+L+V13QUzaKggp6PAPVaVk4phFw61mM40jE+8ssmRGMHl6NywEZN2ASZ8slUqJxqnrP7FUZQ43FyrP8GwEauObl9GD/nK2s1M/jN2sy546y+naa8tyKqtqqVeXwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Y/BW60Uw; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720089468; x=1751625468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I3yB44eJpSE5MtEWunHhYNnzEUavV3jYSvRon/R63q4=;
  b=Y/BW60UwsBFOO2jw/KDCT5m2wQk5IX0CIWNnTRoQ2HoJG1z/yprk7+2+
   DF2WCg9kcWU6feC74C94hhPwuDYOvNSbJVhAuonhtiO0tjt1spvwK9uVf
   K10gfGY67YIjeBT9f0lk82H0SPC59mK5i6PM6DzH9LHiqJA3FC6WHNo5t
   rQNYAuhDnEtyHzENF2Mlm/bNA/BHj55qacRKHWW5WQU1snCddvNNlMiEt
   mB9KyLdw+/lSqRsSBonf1PeAxHVMoh+4MX/llJDmD8GRDJdd2B9iAEfPq
   wB7R1EI+DWKYNyNA480PVYNW1bLfvUZEKFYjJnaCuf5CLZM984oDuhurf
   g==;
X-CSE-ConnectionGUID: Hmz/xXFxQReOTn98HhrE8Q==
X-CSE-MsgGUID: e6N7O7D1RdOEXAzWejL0yQ==
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="asc'?scan'208";a="29489727"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2024 03:37:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jul 2024 03:37:42 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 4 Jul 2024 03:37:41 -0700
Date: Thu, 4 Jul 2024 11:37:20 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Matteo Martelli <matteomartelli3@gmail.com>
CC: Conor Dooley <conor@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add binding for pac1921
Message-ID: <20240704-distinct-sulk-4fc97a9ddbab@wendy>
References: <20240703-iio-pac1921-v1-0-54c47d9180b6@gmail.com>
 <20240703-iio-pac1921-v1-1-54c47d9180b6@gmail.com>
 <20240703-bovine-thumping-c3747fd7caa1@spud>
 <668674271f02d_92937078@njaxe.notmuch>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1vcxoOf7MdROzijp"
Content-Disposition: inline
In-Reply-To: <668674271f02d_92937078@njaxe.notmuch>

--1vcxoOf7MdROzijp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 12:06:31PM +0200, Matteo Martelli wrote:
> Conor Dooley wrote:
> > > +
> > > +  microchip,dv-gain:
> > > +    description:
> > > +      Digital multiplier to control the effective bus voltage gain. =
The gain
> > > +      value of 1 is the setting for the full-scale range and it can =
be increased
> > > +      when the system is designed for a lower VBUS range.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [1, 2, 4, 8, 16, 32]
> > > +    default: 1
> > > +
> > > +  microchip,di-gain:
> >=20
> > Why is this gain a fixed property in the devicetree, rather than
> > something the user can control? Feels like it should be user
> > controllable.
>=20
> Gains are user controllable via the IIO_CHAN_INFO_HARDWAREGAIN. I also ad=
ded
> them as DT properties thinking that they could be pre-set depending on ha=
rdware
> specifications: for instance by board design the monitored section is alr=
eady
> known to be in a particular voltage/current range (datasheet specifies
> gains-ranges mapping at table 4-6 and table 4-7). Then, even if gains are
> pre-set, the user can change them at runtime for instance by scaling them=
 down
> upon an overflow event. However, I can get rid of those gain properties i=
f they
> are out of the DT scope.

Usually gain values are left out of DT entirely, unless the gain is
something set by the board, for example, whether or not some input pins
are tied high or low.

> > > +    description:
> > > +      Digital multiplier to control the effective current gain. The =
gain
> > > +      value of 1 is the setting for the full-scale range and it can =
be
> > > +      increased when the system is designed for a lower VSENSE range.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [1, 2, 4, 8, 16, 32, 64, 128]
> > > +    default: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - shunt-resistor-micro-ohms
> >=20
> > You're missing a vdd-supply btw and the !read/int pin isn't described
> > here either. I think the latter needs a property to control it (probably
> > a GPIO since it is intended for host control) and a default value for if
> > the GPIO isn't provided?
>=20
> The driver does not currently handle the vdd regulator nor the gpio for t=
he
> !read/int pin. Should they be added to the DT schema anyway?

Yes.

> I think I can add the vdd regulator handling with little effort, my guess=
 is
> that the "vdd-supply" property can be optional and defined as "vdd-supply=
: true"
> in the DT schema. Then the driver, if the vdd-supply property is present =
in the
> DT, would enable the regulator during device initialization and PM resume=
, and
> disable it on driver removal and PM suspend.

Nah, the regulator should be marked required in the binding, since
without power the device cannot function, right? The regulator core will
create a dummy register if one is not provided in the device tree, so
you don't need to add any conditional logic around regulator actions.

> Reguarding the !read/int pin, the current driver overrides it with a regi=
ster
> bit so it would not be considered at all by the device.

We should fully describe devices, where possible, even if the driver for
the device doesn't use it.

Cheers,
Conor.


--1vcxoOf7MdROzijp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoZ7YAAKCRB4tDGHoIJi
0tNiAQClR//D6va0NOuDr2w0cnW7KSXBWtDCjRH9QKRQLU4o9wD/W+DNZAFQxZiv
Fw4zdmGYhewLsSgEuAZAYWVhCUXIBQw=
=gP5S
-----END PGP SIGNATURE-----

--1vcxoOf7MdROzijp--

