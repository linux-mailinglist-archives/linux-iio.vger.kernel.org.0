Return-Path: <linux-iio+bounces-22876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B87B29497
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 19:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27B847A3D28
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 17:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40782FE061;
	Sun, 17 Aug 2025 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iaZrUUWw"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7027453
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755452074; cv=none; b=aEWWzB++/2JgU14C0dyxkC/LW75NiAWDJYPonoFcBWbhEEp2Url8VH1IUvlW3S4KdbjHEHnxCr383HjO5KdgzVyAAGccPLVJprlG55OhcBLM//Sp63Sp5pmWQlJCZ7yLV02Ltdnu5KNOpLyysH1S3VKNK5Hgx3Z3RSgndcdQxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755452074; c=relaxed/simple;
	bh=RwB/DDIb6opM2ULvBt72StCBbsngJupBmwL6J25OWAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmkKRFJ+bw3r9FJVQx3V3N+ZLBiTo3Q6FbeS7rJDLKHu5cvnch+RJpImoLKpeY5CAKv1hz/bCPPVMP8dqxeGMsmx0fEQJaD5TbOjtho9OfPauTlFR0Po+0eYXjcwZVp6SwbnJEqaOVLu2c85jPgIUd1G/a7s3OTeKGx3UkHSYr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iaZrUUWw; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 17 Aug 2025 13:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755452060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BNsVrdnvFypp0sG1vA9s+V9fNjo1Zu+/ID90N7aE+Ks=;
	b=iaZrUUWwNJLkEGUQu153ibC9G6D72GYDKNDCNfdUYHkXkfR0hCZ0+k/EaLUHAGxUFFTvRv
	L1V60wM1VGmkwxa3cXb5wylPVUiZPC0DFh/mxJaULcZ5Z5nw5ENffq1QAZmYgeOmCmfTYm
	miEbENWUnhRTJQsSZm3Ik65P3ESIRjk=
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
Message-ID: <2025081713-wooden-clam-aee35a@boujee-and-buff>
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
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bk5mkohm5lcfkkd3"
Content-Disposition: inline
In-Reply-To: <8e228d2d-d22f-4092-8c6d-94ce989b4a84@baylibre.com>
X-Migadu-Flow: FLOW_OUT


--bk5mkohm5lcfkkd3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] dt-bindings: iio: mcp9600: Add compatible for
 microchip,mcp9601
MIME-Version: 1.0

On Sun, Aug 17, 2025 at 11:51:22AM -0500, David Lechner wrote:
> On 8/17/25 11:37 AM, Ben Collins wrote:
> > On Sat, Aug 16, 2025 at 01:55:31PM -0500, David Lechner wrote:
> >> On 8/16/25 4:58 AM, Jonathan Cameron wrote:
> >>> On Fri, 15 Aug 2025 16:46:03 +0000
> >>> Ben Collins <bcollins@watter.com> wrote:
> >>>
> >>>> The mcp9600 driver supports the mcp9601 chip, but complains about not
> >>>> recognizing the device id on probe. A separate patch...
> >>>>
> >>>> 	iio: mcp9600: Recognize chip id for mcp9601
> >>>>
> >>>> ...addresses this. This patch updates the dt-bindings for this chip =
to
> >>>> reflect the change to allow explicitly setting microchip,mcp9601 as
> >>>> the expected chip type.
> >>>>
> >>>> The mcp9601 also supports features not found on the mcp9600, so this
> >>>> will also allow the driver to differentiate the support of these
> >>>> features.
> >>>
> >>> If it's additional features only then you can still use a fallback
> >>> compatible.  Intent being that a new DT vs old kernel still 'works'.
> >>>
> >>> Then for the driver on new kernels we match on the new compatible and
> >>> support those new features.  Old kernel users get to keep the ID
> >>> mismatch warning - they can upgrade if they want that to go away ;)
> >>>
> >>> Krzysztof raised the same point on v2 but I'm not seeing it addressed
> >>> in that discussion.
> >>
> >> One could make the argument that these are not entirely fallback
> >> compatible since bit 4 of the STATUS register has a different
> >> meaning depending on if the chip is MCP9601/L01/RL01 or not.
> >=20
> > There are some nuances to this register between the two, but it can be
> > used generically as "not in range" for both.
> >=20
> > My understanding from the docs is if VSENSE is connected on mcp9601,
> > then it is explicitly open-circuit detection vs. short-circuit, which
> > is bit 5.
> >=20
> >> Interestingly, the existing bindings include interrupts for
> >> open circuit and short circuit alert pins. But these pins
> >> also only exist on MCP9601/L01/RL01. If we decide these aren't
> >> fallback compatible, then those properties should have the
> >> proper constraints added as well.
> >=20
> > In my v4 patch, I'm going to remove the short/open circuit interrupts
> > since they are not implemented, yet.
>=20
> Don't remove them from the devicetree bindings. Even if the Linux driver
> doesn't use it, the bindings should be as complete as possible.
>=20
> https://docs.kernel.org/devicetree/bindings/writing-bindings.html
>=20

I couldn't find anything that would easily describe this type of layout:

properties:
=2E..
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

allOf:
  - if:
      properties:
        compatible:
          contains:
            const: microchip,mcp9601
    then:
      # Override maxItems
      interrupts:
        maxItems: 6
      # XXX Add items to existing list???
      interrupt-names:
        items:
          - const: open-circuit
          - const: short-circuit

--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--bk5mkohm5lcfkkd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmiiEpYACgkQXVpXxyQr
Is9rgg/9Ga4RVc8YsHjrR1im0rq3doFqDT+AzIVNSv88SuN81oUko0jF3nC/lhDI
VPyGjGcdsVl8Ikk+lDteQhRCU9Ca3IC+/u+q/pYuz9OMTdIMbONU8h+XQOV4okM9
ZvmSPxZ7RxPajjlXGggIoAAeaVDNeoP1cc4Ylpwt0VarOXME5Sp0DNdpITwi8BDB
I2O+DIsTikcQwDxwKvFK2iHiAM6zUF4GgwqQi7vjaYNGdIzKvs1fHrzKrMtbb9yB
7BPkHvRLifyoIQhuQStDyX2MN3RL345IlW6VJjcUhjLM8jLOSMagoYzxLsPrZAVE
7CYlaMHMcoMadvwLB5Zj9zkRXOcDr61La1DYH0q8WaYdR3FF3evpDoYSOusMEMz0
uQPlqox/cAIc0BMGGMBoYzXv9HcH5rimaSZctUGNq3l7lX+t0cI9daBLTcC8C1NV
1SLbQwsrrVu4PETrJZ/CuWB1dX3XxdJVO41/KYW+rXuLi9vdt7hQuyQlX/L9m/gJ
hLbOkaQ6p1m1yxmxiS1FIldsJS27IPun3C8/xrzJk9oCazk+595nXrRIIGpnJTfn
+YbHOL5+aSMfW6ICR4P9q8K/zZbuE4+WDLO0r5M0P3ZZicioTBD8iVkxL79ziulo
PViq6L7hK/7UDbgGrxeRx4vq69D38DTP4zzuHG2ijCTqalTq7HI=
=MSp4
-----END PGP SIGNATURE-----

--bk5mkohm5lcfkkd3--

