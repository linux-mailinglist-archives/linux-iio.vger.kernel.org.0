Return-Path: <linux-iio+bounces-5926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525428FF264
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 18:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310921C26487
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66550197A99;
	Thu,  6 Jun 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjRM0ku0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2D9190484;
	Thu,  6 Jun 2024 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690883; cv=none; b=D8ZOdB9ss6baT8w4ad/uarCGoExN75+0tDR6QkqxLbLu5KGzhc9hfs2MfVlNYle59a5I4AqO7gJ0QI3sxUh3v6pAOtFTp7dPOsL0s2KyfmRtUTPQyAn1ijKE9nXMzZPQHNPkBtvEUFJrnPGJDbKerrorIlH6Y2Jtf8m0M71Golg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690883; c=relaxed/simple;
	bh=+cmAf72y5POah1NpyyIb4Lau7qS9oZS21wkpmv9qEio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqxR4Fxm+8TRVLcdrbuFPjyaWQK4Tq7HcRVRchOCyq+L4NvSr+GKeqj7aFyb2OkuOSqWzPEtciPkXSeZY9KkU8FrJqeS3Td5dO6ZBaQk+DphlBhEgKlknDP+ZG4ktA3EpG3R64poldXeiHZVl3LvISxMKOBcSruOsmJZwYZJUMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjRM0ku0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0329C2BD10;
	Thu,  6 Jun 2024 16:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717690882;
	bh=+cmAf72y5POah1NpyyIb4Lau7qS9oZS21wkpmv9qEio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gjRM0ku0J4KTQzi8bnmdF4nh3fgQBiRVmMiPam9o3ejint+L4c0q7ununjAgk8Lym
	 qFfM7+zacqjN82o6SRXDkw/ZTwta9T0HkrrAWuHNNECd5Wv+UXC8IU0KwA3/0wjn2/
	 jJjeAxMsf7L9YkouHseADh/t4ErYOXXXoJdl6fiFc5F4VYuvoytGkNv8gAHyskB10L
	 mwZVzNO+zbEGaYKmOi7LLs2ocQscSJl2H28zFsraATh6Vc0cEcmo/Dp9Elr3nEaUIY
	 RjiK99djJws1H8/p9p7aqcXZLWizgRe9qEINeoJuZWOZrLDx5n9NOK0NMCDUi/NmPZ
	 hcz2vOBmZOCjg==
Date: Thu, 6 Jun 2024 17:21:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: amlogic,meson-saradc: add
 optional power-domains
Message-ID: <20240606-clothing-deceit-910ad6aebe1e@spud>
References: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-sardac-v1-1-40a8de6baa59@linaro.org>
 <20240605-abdomen-starch-4fd4d7ead431@spud>
 <1a82eeb8-bb95-4fad-acce-798ba0cda170@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a9tWOetrfT4l+L95"
Content-Disposition: inline
In-Reply-To: <1a82eeb8-bb95-4fad-acce-798ba0cda170@linaro.org>


--a9tWOetrfT4l+L95
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 09:54:22AM +0200, Neil Armstrong wrote:
> On 05/06/2024 18:58, Conor Dooley wrote:
> > On Wed, Jun 05, 2024 at 11:37:08AM +0200, Neil Armstrong wrote:
> > > On newer SoCs, the SAR ADC hardware can require a power-domain to ope=
rate,
> > > add it as optional.
> >=20
> > What about the older socs that don't have power domains, the property is
> > now usable there?
>=20
> Old SoCs doesn't necessarily have an associated power domain, or was hand=
led
> by firmware, does it harm if we make it optional for older ones as well ?

I mean, really all of these devices have a power domain, even if the DT
doesn't describe one as it's hardly gonna work without power, so the
commit message just seems odd to me. I don't care enough to ask for a
new commit message though.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--a9tWOetrfT4l+L95
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmHh/QAKCRB4tDGHoIJi
0hMxAQDME6Isi1Om+F82DIFxdun87ci2FJHShbHxkeQrVZuWVQD/Qbui0InQz1Yk
zESnI+lhIsrcHkaUvZVxuHm8MfgsDwU=
=EZ+g
-----END PGP SIGNATURE-----

--a9tWOetrfT4l+L95--

