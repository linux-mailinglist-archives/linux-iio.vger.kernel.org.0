Return-Path: <linux-iio+bounces-24176-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB6FB5A148
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 21:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFA81C03B66
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 19:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AADC2F25E2;
	Tue, 16 Sep 2025 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeiRSBEr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B661FBEA2;
	Tue, 16 Sep 2025 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050464; cv=none; b=XU7eT9FlZU4ePmH3REd8rTQnfIdj+DOjRl+eS6ufTXXpw/LM9HcgWRdUrLsXTSW4y5Lht7b3v4DyR1F2sW3wV5yXzHja1C1esh523RFgoYRQCyL8+PPMaah6LyVP1K4nM7zyS2A7Vj7f05TzXlYJIlA8vgaz6Ur+fAFqsVlONfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050464; c=relaxed/simple;
	bh=+5w/cHHsMi3HiFOnCiVNH48CuMDOqzyQSHdW+O7wiys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ps8aa2HWjPntQnxZgnHBLR5KgdhW/nPnk5eqAo7NHv/nveyr8wyMiyu5ZpuSyRvY3CTadcBnPd9k0Mj9nkRWCe0q4sjOkQhXzampz1dwmyUaI2GITAMClthIz+ZDS24WmJ+uczzgOfrdcclXwL+tpIYtPXssUGaCqhjzoZ1XqLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeiRSBEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8547C4CEEB;
	Tue, 16 Sep 2025 19:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758050464;
	bh=+5w/cHHsMi3HiFOnCiVNH48CuMDOqzyQSHdW+O7wiys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OeiRSBErvqz+cliurvNo/ueg+bmVv0SgHKS8A8gYdoRKcab503nyRx/ENiM4pNdon
	 LmkoFHuwsgW/Q8ckdNbYNSwHqiYd3u3+CZ1Jfx/rJ9hDfB05/JQspJWcVhaT8Y5DyM
	 lc9v/euHCZKwFh3nb9mxGzSI8jbnvlRpcBHuGJpcJyE9KUCIHugdfDH9+7SqV6vs3+
	 uDNvHhOhb2NrI/8SJlpHkDjgU5njFSuC4XukG5kFpYxuiU2L2+74gcnsP2ulvcbIkW
	 tQMm2jOpM06LAdHZbEJTHR4hFxNQjKAC2GMxp/nW2MOEDAS7AP9UudwTQ4U7++dmt2
	 vcDxMIM4yMWDg==
Date: Tue, 16 Sep 2025 20:20:58 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v11 1/3] dt-bindings: iio: adc: add max14001
Message-ID: <20250916-alto-vaseline-f8dafbab03e9@spud>
References: <cover.1757971454.git.marilene.agarcia@gmail.com>
 <30f33a64da0339eccc1474406afb2b1d02a0cd6b.1757971454.git.marilene.agarcia@gmail.com>
 <8e88b601-1329-4cdb-bbd7-feb998c552e8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NwfCVTRFvQ7doDJR"
Content-Disposition: inline
In-Reply-To: <8e88b601-1329-4cdb-bbd7-feb998c552e8@baylibre.com>


--NwfCVTRFvQ7doDJR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:40:47AM -0500, David Lechner wrote:
> On 9/15/25 5:16 PM, Marilene Andrade Garcia wrote:

> >=20
> > The MAX14001 and MAX14002 both have the COUT output pin and the FAULT
> > output pin, and work the same. I have decided to declare them as interr=
upts
> > because I think some action should be done when they are hit. However, =
the
> > implementation of these features is not present in the v11 driver code,=
 as
> > it was not in v9. But I plan to submit it in the next steps.
>=20
> The devicetree bindings should be as complete as possible and not care
> if the driver doesn't use everything. So adding them now is the right
> thing to do.

> > +  interrupts:
> > +    minItems: 1
> > +    items:
> > +      - description: |
> > +          Asserts high when ADC readings exceed the upper threshold an=
d low
> > +          when below the lower threshold. Must be connected to the COU=
T pin.
> > +      - description: |
> > +          Alert output that asserts low during a number of different e=
rror
> > +          conditions. The interrupt source must be attached to FAULT p=
in.

These descriptions read wrong to me. They __are__ the COUT and FAULT
pins, given what David responded to above, not something that can be
connected to these pins (if they were, they would be represented as
-gpios rather than interrupts most likely). Unless you mean that these
pins can have some other use and are only available on the COUT/FAULT
pins when some register value is set - but even in that case saying
"must be" doesn't fit since the interrupt property could be used to
configure the device accordingly.

--NwfCVTRFvQ7doDJR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMm4mgAKCRB4tDGHoIJi
0imOAP0ZC2aY5vECp3LF3rgrn/fkRX8Lr8A7hdrfivq83WcRyQEA4KSSTzqFwflb
3PcXNE5a3VYZFeq924CIasGoN631dwY=
=Z0Ld
-----END PGP SIGNATURE-----

--NwfCVTRFvQ7doDJR--

