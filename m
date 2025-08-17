Return-Path: <linux-iio+bounces-22881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B32AB2951B
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 23:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DCB2176601
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 21:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45597EEA8;
	Sun, 17 Aug 2025 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hF+a+Jc3"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252D51D6194
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 21:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755464589; cv=none; b=fVUkXkG6Gk1/0yStcw4m7qpircUmpL1Z4YFI0naU6dI+JsZqsy3FBUk52YLKQ+NjQOUGGKWuO4Q5g5eoplqaCZj1cQMRFnzy09p7RsqKg/jIk63mEQXgql+Anyj5GwbE+jJpk2my0mQnhYJikAF5v5Th4L/99gHRy8QEu0i8FA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755464589; c=relaxed/simple;
	bh=8np73MZ3dfgQEKnRTet5owzFjzT1icMTCRFFIayX6Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEcrKkOB+3kDUSeNcoJWx/dja7a7Xh/5jwAtj7rrfT7tpYm6AJvnoFNt15D2T8hmSD9taOBssvM9ancko8xE7Rpl71tpbjuhP5g5ZMx8DH45nhZ253UeJ2UL/4Eq6g2hFfrCdbTNzETxteVgkQQP9NUkYkwaydeLJbuLX34ddPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hF+a+Jc3; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 17 Aug 2025 17:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755464574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yubaClVIohycjD92nlUFXkhnhtVO15c5HtE18Zh0xMQ=;
	b=hF+a+Jc3zrp//bC9Yb+0WPwXd1TOkritnpWfcceKHonwGEHnX6tQoFUTMphJt6szHBEKO2
	j3bqACGfgmRzIu1p/zphmMrZf3B6FO7vdmnJZt+AuHQu6PTg2PY/139OwHxPEWwkYJ1yNv
	KIUvZgi2ujM2sRx+cTNr1GYbLADQJmg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <ben.collins@linux.dev>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Ben Collins <bcollins@watter.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: iio: mcp9600: Add compatible for
 microchip,mcp9601
Message-ID: <2025081716-tan-pillbug-ff2cb5@boujee-and-buff>
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
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mfgi7y2gj34ketdi"
Content-Disposition: inline
In-Reply-To: <65ca6431-56e1-4798-9ecc-6e6adf664f96@baylibre.com>
X-Migadu-Flow: FLOW_OUT


--mfgi7y2gj34ketdi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] dt-bindings: iio: mcp9600: Add compatible for
 microchip,mcp9601
MIME-Version: 1.0

On Sun, Aug 17, 2025 at 12:59:48PM -0500, David Lechner wrote:
> On 8/17/25 12:34 PM, Ben Collins wrote:
> > On Sun, Aug 17, 2025 at 11:51:22AM -0500, David Lechner wrote:
> >> On 8/17/25 11:37 AM, Ben Collins wrote:
> >>> On Sat, Aug 16, 2025 at 01:55:31PM -0500, David Lechner wrote:
> >>>> On 8/16/25 4:58 AM, Jonathan Cameron wrote:
> >>>>> On Fri, 15 Aug 2025 16:46:03 +0000
> >>>>> Ben Collins <bcollins@watter.com> wrote:
> >>>>>
> >>>>>> The mcp9600 driver supports the mcp9601 chip, but complains about =
not
> >>>>>> recognizing the device id on probe. A separate patch...
> >>>>>>
> >>>>>> 	iio: mcp9600: Recognize chip id for mcp9601
> >>>>>>
> >>>>>> ...addresses this. This patch updates the dt-bindings for this chi=
p to
> >>>>>> reflect the change to allow explicitly setting microchip,mcp9601 as
> >>>>>> the expected chip type.
> >>>>>>
> >>>>>> The mcp9601 also supports features not found on the mcp9600, so th=
is
> >>>>>> will also allow the driver to differentiate the support of these
> >>>>>> features.
> >>>>>
> >>>>> If it's additional features only then you can still use a fallback
> >>>>> compatible.  Intent being that a new DT vs old kernel still 'works'.
> >>>>>
> >>>>> Then for the driver on new kernels we match on the new compatible a=
nd
> >>>>> support those new features.  Old kernel users get to keep the ID
> >>>>> mismatch warning - they can upgrade if they want that to go away ;)
> >>>>>
> >>>>> Krzysztof raised the same point on v2 but I'm not seeing it address=
ed
> >>>>> in that discussion.
> >>>>
> >>>> One could make the argument that these are not entirely fallback
> >>>> compatible since bit 4 of the STATUS register has a different
> >>>> meaning depending on if the chip is MCP9601/L01/RL01 or not.
> >>>
> >>> There are some nuances to this register between the two, but it can be
> >>> used generically as "not in range" for both.
> >>>
> >>> My understanding from the docs is if VSENSE is connected on mcp9601,
> >>> then it is explicitly open-circuit detection vs. short-circuit, which
> >>> is bit 5.
> >>>
> >>>> Interestingly, the existing bindings include interrupts for
> >>>> open circuit and short circuit alert pins. But these pins
> >>>> also only exist on MCP9601/L01/RL01. If we decide these aren't
> >>>> fallback compatible, then those properties should have the
> >>>> proper constraints added as well.
> >>>
> >>> In my v4 patch, I'm going to remove the short/open circuit interrupts
> >>> since they are not implemented, yet.
> >>
> >> Don't remove them from the devicetree bindings. Even if the Linux driv=
er
> >> doesn't use it, the bindings should be as complete as possible.
> >>
> >> https://docs.kernel.org/devicetree/bindings/writing-bindings.html
> >>
> >=20
> > I couldn't find anything that would easily describe this type of layout:
> >=20
> > properties:
> > ...
> >   interrupts:
> >     minItems: 1
> >     maxItems: 4
> >   interrupt-names:
> >     minItems: 1
> >     items:
> >       - const: alert1
> >       - const: alert2
> >       - const: alert3
> >       - const: alert4
> >=20
> > allOf:
> >   - if:
> >       properties:
> >         compatible:
> >           contains:
> >             const: microchip,mcp9601
> >     then:
> >       # Override maxItems
> >       interrupts:
> >         maxItems: 6
> >       # XXX Add items to existing list???
> >       interrupt-names:
> >         items:
> >           - const: open-circuit
> >           - const: short-circuit
> >=20
>=20
> We usually do this the other way around. The base binding lists
> all of the possibilities then an -if: constraint limits them
> if needed.
>=20
>=20
> So don't change what is there already and then add:
>=20
>=20
> allOf:
>   - if:
>       properties:
>         compatible:
>           not:
>             contains:
>               const: microchip,mcp9601
>     then:
>       properties:
>         interrupts:
>           maxItems: 4
>         interrupt-names:
>           maxItems: 4
>           enum:
>             - alert1
>             - alert2
>             - alert3
>             - alert4

This might be a little more complicated. I want to add a boolean for
microchip,vsense so the SC/OC aren't even available without that flag
being true (default false).

I could just assume that having the interrupts means this flag is true,
but that doesn't cover the case where the interrupts might not be used
or even wired up, but the SC/OC detection in the status register can be
used.

I was going with this:

  interrupts:
    minItems: 1
    maxItems: 4

  interrupt-names:
    minItems: 1
    items:
      - const: alert1
      - const: alert2
      - const: alert3
      - const: alert4

  microchip,vsense:
    default: false
    description:
      This flag indicates that the chip has been wired with VSENSE to
      enable open and short circuit detect. By default, this is false,
      since there's no way to detect that the chip is wired correctly.
    type: boolean

=2E..

allOf:
  - if:
      properties:
        # XXX Does this work like logical AND? Passes dt_binding_check
        microchip,vsense: true
        compatible:
          contains:
            const: microchip,mcp9601
    then:
      properties:
        interrupts:
          minItems: 1
          maxItems: 6
        interrupt-names:
          items:
            - const: alert1
            - const: alert2
            - const: alert3
            - const: alert4
            - const: open-circuit
            - const: short-circuit
--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--mfgi7y2gj34ketdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmiiQ3kACgkQXVpXxyQr
Is87chAAnkRlb6Abjc1BQ47CcO8XDV+yJCdVNpHugbd70f2sSb0kukUxMk3r83q4
Y0gG9oA2fOvzp5Y5ZlspcW3vcAu8o2dpxX7MejSIBYh6AmrhIDjkRuzBO+eObs3e
x/yeWlai/onSKTzC8xVPhNWd2CBciYTqjAuUXPu+2wNN5LvxjFipK/mwQXQXDLue
3wU1s0gdKej7094eMZqV4sWr/3/b2ZdQxmbXViaDUtOad95lzzwmCuFyzt+2dWxu
agjjoQhb/IbyxXEGS2cD4hFmarNwN0aegdlt88ZdfNkax7BCQ/V9NXRHVSwtNRHx
niId+tZ2Cec24bmtJOhCDW4vRPUJ3em2563Ou45BSlgrYuf+w7NZhvAxbkHQo7Nj
58J4MtgvUw6u9+Sq53clOTRWyvdBlb+F2rt0tDpYJ4IHEl09PUW/TKcySccwKBMs
BAshdfNOZg+5Lgh8LyXa8gwiJkwTkDgVsFa7gR9v3/nUKOAuon+hBKc7m3GoUnjP
a0n72vx89YoYuWnhGyffVgD+5j/9Kd/tsxuSrT2axHeNko4ztLdmCI0rz153POFc
IPxhIHLgysOXKZE3KneQ4vSS9Ez33zBlFIjTXgkNqqz5+W/5lIty624hfyo53dsH
6/eQGnSS7q3YTGJSxUh1rHqk3LZJqAgGTlqVYN/7YhIPJ0Hsi2w=
=NhOC
-----END PGP SIGNATURE-----

--mfgi7y2gj34ketdi--

