Return-Path: <linux-iio+bounces-9234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1C696EE9A
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 10:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292091F24DF8
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 08:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307B4158DDC;
	Fri,  6 Sep 2024 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRiu7/ej"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A52155CBD;
	Fri,  6 Sep 2024 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612943; cv=none; b=RrlX+mS9GjSmVrzShTs0UJrov7ThvvkXtuZYUVZWr6aGefgviKGeqEunKYP5dCb75a991kXs3hPaw5zNLvIhwsUOoivJqJEAZDSv6sIPKbGEebouCj4jFPnWm9Oz/EGvV5z4F2opwOhRfKMt5mavufVgEx9MdjyzDvgT4lIPK2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612943; c=relaxed/simple;
	bh=1aAaNnmeOLOewP2Gk674dATUFG1To6NBujHf5BahOR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U40eUj8DECqjQ1iqWW1dU0+VNngdBMI3ZDPjnUHzUvHLQj/y283EWCGwBs5fsvk2rg5/j0U6KG+pfpOi7xSZyvzZ0DzklYM2cDv0Xzikvs1Zx8VZLoSMMVDotohlU4dMPARE5eY3hSiLykTgurqZP0cA+pD4ehKKQpG6mmIRUl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRiu7/ej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C86C4CECA;
	Fri,  6 Sep 2024 08:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725612941;
	bh=1aAaNnmeOLOewP2Gk674dATUFG1To6NBujHf5BahOR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRiu7/ejJIaDDh1TaE2LFl6HgF8rS0Lx8PqV2mbwAUxEuTa7CHT/Cve6AajCHvbw9
	 6Bzq+Pm7RUyvj/PDIUr409jYbJ+XLBShT4EEceVF+OJEAwf1sG624CmMHSfgh2VJTu
	 CIPcGwiByeiJ14e1GdAqD0tOiYiB8JyHawSOg1EiWHHGQB3x7f6azknPL45mUtEGCO
	 zdGvXqnLBXijHdeAJyuBnUtBsfEtRiEcA4A/UEwVbEojY9rM76+KbWBNfJMZy2xjrH
	 1F1qTgBeBvAtD539hhqzPcM0otyn+kHG8OpU2rv48fi679KA2/qaT+b9R2zMPmjpyk
	 S1LK7/8gOS3AQ==
Date: Fri, 6 Sep 2024 09:55:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
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
Message-ID: <20240906-float-cabana-69e69e9dc6a0@squawk>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>
 <20240829-stopwatch-morality-a933abb4d688@spud>
 <d4eddc24-9192-4a4a-ac67-4cfbd429a6a9@baylibre.com>
 <20240830-quilt-appointee-4a7947e84988@spud>
 <642d61b23c58d9b846e42badb2f2d97691c92144.camel@gmail.com>
 <20240906-reveler-waggle-8a7043690633@squawk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T/cH56Qfnq1MBPg/"
Content-Disposition: inline
In-Reply-To: <20240906-reveler-waggle-8a7043690633@squawk>


--T/cH56Qfnq1MBPg/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2024 at 09:50:30AM +0100, Conor Dooley wrote:
> On Thu, Sep 05, 2024 at 11:50:45AM +0200, Nuno S=E1 wrote:
> > On Fri, 2024-08-30 at 16:33 +0100, Conor Dooley wrote:
> > > On Fri, Aug 30, 2024 at 10:19:49AM +0200, Angelo Dureghello wrote:

> > > > > > +=A0=A0=A0 maxItems: 1
> > > > > > +=A0=A0=A0 description: |
> > > > > > +=A0=A0=A0=A0=A0 Configure bus type:
> > > > > > +=A0=A0=A0=A0=A0=A0=A0 - 0: none
> > > > > > +=A0=A0=A0=A0=A0=A0=A0 - 1: qspi
> > >=20
> > > Also, re-reading the cover letter, it says "this platform driver uses=
 a 4
> > > lanes parallel bus, plus a clock line, similar to a qspi."
> > > I don't think we should call this "qspi" if it is not actually qspi,
> > > that's just confusing.
> > >=20
> >=20
> > Just by looking at the datasheet it feels like typical qspi to be hones=
t. And,
> > fwiw, even if not really qspi, this is how the datasheet names the inte=
rface.
>=20
> Right, just a phrasing issue in the cover letter I guess :)

The other thing that this brings into question, and I forget if I said
it before (perhaps to David on IRC) was whether or not the ADC/DAC needs
to be a child of the backend, if the backend is providing the SPI bus
that the device is attached to. Why would it not be the case, if as you
say, it appears to be a real qspi controller?

--T/cH56Qfnq1MBPg/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZtrDiQAKCRB4tDGHoIJi
0ubcAQDna5dbOQOhgjUpwDofzl9b0VrpweCcBHp1X7hDA5XdiQD/XI+HiyIeEoAs
igX18hbDjHJVWNocwVX2aJukAeRIUwc=
=BBdT
-----END PGP SIGNATURE-----

--T/cH56Qfnq1MBPg/--

