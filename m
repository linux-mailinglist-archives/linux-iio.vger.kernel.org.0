Return-Path: <linux-iio+bounces-12167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB879C48BA
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 23:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8FD280F7B
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 22:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806771BC9F5;
	Mon, 11 Nov 2024 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riL9iqbt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E07166F32;
	Mon, 11 Nov 2024 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362631; cv=none; b=nuvl9GdgcUwFWpmhNx03Pe7huDjVXcWQ+mEadDldu+wrBas6Ja3uyRtK6USAhCjv0mN+Io30S4/tPeiUo9mwJqmYbdROWbPqRzgr8jWb90eU1So5hhjqMt9rgtNSwIgWC+bKafxDQTYDn61vS980gfV1HQvPylOiqpGnWukNEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362631; c=relaxed/simple;
	bh=/Wy4YidZGwjesqXErLGt7skkvYZCZ+x2ehWCREUyIAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vlf1oPqPj4ayOqph+idd/nrLdtnSQIKG+l2ixLAG5ueXClcPTfta5iFNL0QosrqJhLnRv0wDGwt+r8ETvX6CR0eUcAxrtGF0n1LJdc+mxjANW+cX9+v0pBbYxoVN/O5mPUF4aCLOGb1CaQUxb064inPmXQ77bUDZfz7NLy5P9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riL9iqbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEA7C4CECF;
	Mon, 11 Nov 2024 22:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731362630;
	bh=/Wy4YidZGwjesqXErLGt7skkvYZCZ+x2ehWCREUyIAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=riL9iqbtW8IvnGCiJcjj8/1C0+k8mlR5QhUe7LCulJ8Wci1nKMZ/7LhHpQVIv+r4H
	 yK3uHTC5eVHOOWnPisZ7/3xGcgF/xLm6/p/jMyug+taDYW3gBtdDkqrx/NXBTAZRgg
	 bKdK05okjMACDBhAR5qDNfRg1IQOQQhEpa3mJrxvouAE57sy8X0t7ULAvDlG+fskju
	 4y/iF3hrrfydQEuNGxZqWAwVdbN87xTmnJEgVctVLNACYRVsoh/0cxUfiz/CjfRn5+
	 sGmFN+bhQHyZ2AUS0U+1FhtRTRyZMjp00fXkRmctGU3BOzkTN9nqye1ti0sN+hBomr
	 kCMfF6tpbeQbw==
Received: by mercury (Postfix, from userid 1000)
	id 2F65B1060457; Mon, 11 Nov 2024 23:03:48 +0100 (CET)
Date: Mon, 11 Nov 2024 23:03:48 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Stanislav Jakubek <stano.jakubek@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Pavel Machek <pavel@ucw.cz>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: mfd: sprd,sc2731: convert to YAML
Message-ID: <26gfhjt2sslcqqe7s7zgrxmyz2jbxiwcxjzhyw7zdfp655lcc5@phreemx4obs4>
References: <efd200c3b5b75405e4e450d064b026f10ae2f8e0.1730709384.git.stano.jakubek@gmail.com>
 <20241106090422.GK1807686@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rl5it4vjkjpkjjip"
Content-Disposition: inline
In-Reply-To: <20241106090422.GK1807686@google.com>


--rl5it4vjkjpkjjip
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/2] dt-bindings: mfd: sprd,sc2731: convert to YAML
MIME-Version: 1.0

Hi Lee,

On Wed, Nov 06, 2024 at 09:04:22AM +0000, Lee Jones wrote:
> On Mon, 04 Nov 2024, Stanislav Jakubek wrote:
> > Convert the Spreadtrum SC27xx PMIC bindings to DT schema. Adjust the
> > filename to match the compatible of the only in-tree user, SC2731.
> > Change #interrupt-cells value to 1, as according to [1] that is the
> > correct value.
> > Move partial examples of child nodes in the child node schemas to this =
new
> > MFD schema to have one complete example.
> >=20
> > [1] https://lore.kernel.org/lkml/b6a32917d1e231277d240a4084bebb6ad91247=
e3.1550060544.git.baolin.wang@linaro.org/
> >=20
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > ---
> > Changes in V3:
> > - remove $ref to nvmem/sc2731-efuse and list the compatibles with
> >   additionalProperties: true (Krzysztof)
> >=20
> > Changes in V2:
> > - rebase on next-20241029
> > - drop partial examples in child node schemas, move them here (Rob)
> >=20
> > Link to V2: https://lore.kernel.org/lkml/ZyExK01iprBHhGm6@standask-GA-A=
55M-S2HP/
> > Link to V1: https://lore.kernel.org/lkml/Zr3X1RoQs7ElTnlJ@standask-GA-A=
55M-S2HP/
> >=20
> >  .../bindings/iio/adc/sprd,sc2720-adc.yaml     |  17 --
> >  .../bindings/leds/sprd,sc2731-bltc.yaml       |  31 ---
> >  .../devicetree/bindings/mfd/sprd,sc2731.yaml  | 252 ++++++++++++++++++
> >  .../bindings/mfd/sprd,sc27xx-pmic.txt         |  40 ---
> >  .../bindings/power/supply/sc2731-charger.yaml |  21 +-
> >  .../bindings/power/supply/sc27xx-fg.yaml      |  38 +--
> >  .../regulator/sprd,sc2731-regulator.yaml      |  21 --
> >  .../bindings/rtc/sprd,sc2731-rtc.yaml         |  16 --
>=20
> Is everyone happy with me merging this through MFD?

Sorry for the delay - fine with me for the power-supply bits.

-- Sebastian

--rl5it4vjkjpkjjip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmcyfzoACgkQ2O7X88g7
+pozVBAAip8XTgv2F10yeVBSrdoO1rENCjCRjWNlqiSjb+c7zd/kLyFMZeOJnDXY
BLwDzwFjc4x2pc4K+YA0Li+x8b0iwQPWcWdpMzcprGCJ41RXbVVKcLu3SxEFwwiu
5BY6n85NGhpvDavuScUKXP/Nf8sCUj3mngHSaLTJGB8o1CyAZZh0LCZ47gpMV9pM
7NBC6ooIz8dQfvRSExhoP1Is2HYEmReqbXfan52159l94VEBmSMs2DrVnIA+uQ1K
9zGiJ3O1PSiVPgh+BVoADP0N/xtSDDVI0ecmR/jq55IWWirHUwi5fvgVgAU0Zt7x
K9318gHatFmwmeq3o6Z9tY5wMew2ZvN02QBKoMJLUmtPap/y4y1j9koiFDz6ucl2
OjpwldiXCYwA68emp/c0d9MXkcHCsb1E4QGvs0HUpPP94vgbIxKEYfDeJLbsgG7Y
W51ywYONmsh3g/Ggafeg81yGKecffzULW6xZUEMRyHUniBtukixNc7AeH+tHkt86
PtRRuKUN9rvBWeydjJW7s8n+XlMFz+7ytDp4iPanWd56y0tByJq9LyHihTXfqDSa
HT+o1eNyjZDyleD6kFXa1GXLjdjRuX1B3cuUDGyjiBo1k2Z1M9s9IuX15TPMj+p8
jmeLYR0oBM9FMoOYwXXw2cJqJjMe8giswbPv0pfohNvVANRMpCg=
=HeH9
-----END PGP SIGNATURE-----

--rl5it4vjkjpkjjip--

