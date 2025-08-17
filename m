Return-Path: <linux-iio+bounces-22882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9890B2951F
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 23:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9DC4E62B5
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 21:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A2923D2B6;
	Sun, 17 Aug 2025 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JxJDJW6B"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F72356B9;
	Sun, 17 Aug 2025 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755465033; cv=none; b=RJZZjTRpu43YecnFbqHaWU8kKPYWkxHkbGMPIB5ZK/g1PLubKjFliepBjhQXCL9czAbt1X1lCOzRFl60dVoVLZRyx0oOUlnkm16Min5DIejTH4DuIDYkGONsfRPpul1yBOZ8uzrD8hCq13LdmBwwX3pPNWKVYCg2H20FWLglmZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755465033; c=relaxed/simple;
	bh=AdlvrWJIkpT2eJcV3yXTIIpUaWLC5qt/oDvlpUtfE/k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnFwW1r3XeSxndDBmXWAKUqzJXnEjKcu0g26kUArFs9gJtBaQ1eIaxN9/Ob9wsLRXze7PL6+/uMdeeCJZ+mEWNlnUD3ZTMK6sxMuOfdMfYmYRu+Q5NVDI5zBjQVs5hEcp4DAgH7R8r51oH/uius4JzAXiYJ3T8i2y1y6oh9El50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JxJDJW6B; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 17 Aug 2025 17:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755465028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ve4jm5CXwDlv7GAWeNnaLmnHuVR8zr5FtPatq3KSzEE=;
	b=JxJDJW6BNaH2Au2RB6dTIZv/qs/WKUiP4NXbW6J2DirjUcjrpsl3i2YUys1LZytMCHbeNw
	kpLoupWcBukvzHPjJE8lQtWHaBZKwdfnDBgg7gHEah8w7AsHz/GEDr8Kz2uTcqc4qmqwNQ
	tzV23UdJpA47XaVsTeGJiHcOYk1LOVs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <ben.collins@linux.dev>
To: David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, Ben Collins <bcollins@watter.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: iio: mcp9600: Add compatible for
 microchip,mcp9601
Message-ID: <2025081717-fabulous-chameleon-5ad9bb@boujee-and-buff>
Mail-Followup-To: David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, Ben Collins <bcollins@watter.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20250815164627.22002-1-bcollins@watter.com>
 <20250815164627.22002-2-bcollins@watter.com>
 <20250816105825.35e69652@jic23-huawei>
 <66063382-78c6-4d93-be25-46e972e390f4@baylibre.com>
 <2025081711-coral-aardwark-9f061b@boujee-and-buff>
 <8e228d2d-d22f-4092-8c6d-94ce989b4a84@baylibre.com>
 <2025081713-wooden-clam-aee35a@boujee-and-buff>
 <65ca6431-56e1-4798-9ecc-6e6adf664f96@baylibre.com>
 <2025081716-tan-pillbug-ff2cb5@boujee-and-buff>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ysnvmq3eichik2xz"
Content-Disposition: inline
In-Reply-To: <2025081716-tan-pillbug-ff2cb5@boujee-and-buff>
X-Migadu-Flow: FLOW_OUT


--ysnvmq3eichik2xz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] dt-bindings: iio: mcp9600: Add compatible for
 microchip,mcp9601
MIME-Version: 1.0

On Sun, Aug 17, 2025 at 05:02:49PM -0500, Ben Collins wrote:
> On Sun, Aug 17, 2025 at 12:59:48PM -0500, David Lechner wrote:
> > On 8/17/25 12:34 PM, Ben Collins wrote:
> > > On Sun, Aug 17, 2025 at 11:51:22AM -0500, David Lechner wrote:
> > >> On 8/17/25 11:37 AM, Ben Collins wrote:
> > >>> On Sat, Aug 16, 2025 at 01:55:31PM -0500, David Lechner wrote:
> > >>>> On 8/16/25 4:58 AM, Jonathan Cameron wrote:
> > >>>>> On Fri, 15 Aug 2025 16:46:03 +0000
> > >>>>> Ben Collins <bcollins@watter.com> wrote:
> > >>>>>
> > >>>>>> The mcp9600 driver supports the mcp9601 chip, but complains abou=
t not
> > >>>>>> recognizing the device id on probe. A separate patch...
> > >>>>>>
> > >>>>>> 	iio: mcp9600: Recognize chip id for mcp9601
> > >>>>>>
> > >>>>>> ...addresses this. This patch updates the dt-bindings for this c=
hip to
> > >>>>>> reflect the change to allow explicitly setting microchip,mcp9601=
 as
> > >>>>>> the expected chip type.
> > >>>>>>
> > >>>>>> The mcp9601 also supports features not found on the mcp9600, so =
this
> > >>>>>> will also allow the driver to differentiate the support of these
> > >>>>>> features.
> > >>>>>
> > >>>>> If it's additional features only then you can still use a fallback
> > >>>>> compatible.  Intent being that a new DT vs old kernel still 'work=
s'.
> > >>>>>
> > >>>>> Then for the driver on new kernels we match on the new compatible=
 and
> > >>>>> support those new features.  Old kernel users get to keep the ID
> > >>>>> mismatch warning - they can upgrade if they want that to go away =
;)
> > >>>>>
> > >>>>> Krzysztof raised the same point on v2 but I'm not seeing it addre=
ssed
> > >>>>> in that discussion.
> > >>>>
> > >>>> One could make the argument that these are not entirely fallback
> > >>>> compatible since bit 4 of the STATUS register has a different
> > >>>> meaning depending on if the chip is MCP9601/L01/RL01 or not.
> > >>>
> > >>> There are some nuances to this register between the two, but it can=
 be
> > >>> used generically as "not in range" for both.
> > >>>
> > >>> My understanding from the docs is if VSENSE is connected on mcp9601,
> > >>> then it is explicitly open-circuit detection vs. short-circuit, whi=
ch
> > >>> is bit 5.
> > >>>
> > >>>> Interestingly, the existing bindings include interrupts for
> > >>>> open circuit and short circuit alert pins. But these pins
> > >>>> also only exist on MCP9601/L01/RL01. If we decide these aren't
> > >>>> fallback compatible, then those properties should have the
> > >>>> proper constraints added as well.
> > >>>
> > >>> In my v4 patch, I'm going to remove the short/open circuit interrup=
ts
> > >>> since they are not implemented, yet.
> > >>
> > >> Don't remove them from the devicetree bindings. Even if the Linux dr=
iver
> > >> doesn't use it, the bindings should be as complete as possible.
> > >>
> > >> https://docs.kernel.org/devicetree/bindings/writing-bindings.html
> > >>
> > >=20
> > > I couldn't find anything that would easily describe this type of layo=
ut:
=2E..
> > We usually do this the other way around. The base binding lists
> > all of the possibilities then an -if: constraint limits them
> > if needed.
> >=20
> >=20
> > So don't change what is there already and then add:
> >=20
=2E..
> This might be a little more complicated. I want to add a boolean for
> microchip,vsense so the SC/OC aren't even available without that flag
> being true (default false).
>=20
> I could just assume that having the interrupts means this flag is true,
> but that doesn't cover the case where the interrupts might not be used
> or even wired up, but the SC/OC detection in the status register can be
> used.
>=20
> I was going with this:
>=20

Nevermind, I figured this out. I'll send v4 soon.


--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--ysnvmq3eichik2xz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmiiRT8ACgkQXVpXxyQr
Is/XWg//Y5A7k72av+JmqcRqWTIGA4LVvAJJMiE3nufI/loV/Z5w7z3h9j9FXOVy
19nscIWi6D8hh3mBVvwxlWnFoCfhzPA3f8BQTSgv+4V/bpge3ANbodDjAv0+Q8pB
HZA4jrDBIup0g09GqNZw2p1MVGC7lotXHrPY1FZdBuL1za9fsWAhcm07sfW2jtTc
d/AqVC1cw+8QlZ+bZsqJYfwB5ebBpb0p2kOVgwtCovrdPzAXGN0qfS/UDAX4uJhg
e35TUJeEqwFZYyOx2i2etv0/1PPxAxtYRBeXtlr5u4PR2/ypRv4N9n0zjETUp4b/
U84w+dcL9EqrRr3dYN/j44lNwr3YTgIE0Dx18hC2mYnb2Hu8JVfo+jxagbyRrG1c
eQI0j6RZaxFPW+ggc9BZ6siIQrtoPAdFPOeLaYRi+7BCcBRDJ4kStBWVngma4UXF
iTwdeQD6Q7bS1Q72o/g8j7zEgX371WlSwA4aDWuwkpxk0NuOw8S4FteAx52wtQHJ
sOX3dcKOvxy7duCDxetIMgmS754se1fyRpM221hxxDANXGdCUNVldxxddUfUgi+a
3B4Z2M8I2JP9ev7L830GdblzfIvyN+/xWGqUaSnGvohSpjJ0sLYZnCECNiRzaw6D
MGDNd3/y61QfaCqS04WYK65eAUmthEYA5rY8h/u6aUxDksXuiOA=
=s+Og
-----END PGP SIGNATURE-----

--ysnvmq3eichik2xz--

