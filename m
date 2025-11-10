Return-Path: <linux-iio+bounces-26151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0A3C483FB
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 18:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F2F422F70
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765F22FC866;
	Mon, 10 Nov 2025 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/f8290t"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262F828D829;
	Mon, 10 Nov 2025 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794249; cv=none; b=pUbX9ls2BYefcEXjHN00vxm1i4F164H7eTk7CdMKu5OH9yBivweV64THPckM5NeZDy/C5OG4nTqAImymHUxPIx6nglMgT8cQOPRXb/RJvLQZHRq5oL/BWBgNPb7OCjUgETkGEjzFeG5Mk5FJmqH5u987B8iZKxIdxOJLbAiqAcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794249; c=relaxed/simple;
	bh=GlWEUJ81HuML3QniPfob+FZyBGIp/OgbbJgntqBpGV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYflYcfTK1r2rQUZcGIdzeKNqaJFwcZecFJnEpe1YrmFx6CfoN2yjCSmYhDqZXYpTub+4mce3PcON4ga5KxaTimcwwVseJUGL+zxLxO/qqhT1D50ZHVL6pL7I8ZIMNqooW5Mwwv0l3s+eal4EmKZuhlH75esnUAOS1P/+plQ1pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/f8290t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8DDC4CEF5;
	Mon, 10 Nov 2025 17:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762794248;
	bh=GlWEUJ81HuML3QniPfob+FZyBGIp/OgbbJgntqBpGV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/f8290tO0Qum103i3UTbYvQJViWqXdRzOLaLZpBVpzFJbKTDf8GfzuY7aTcAvTRA
	 /jF6uSv2pWoAceJx7WXTgkYDQbOUQid0BbI5xyZK/DMk/dP5EkZKnznNi3d9XAUS0w
	 U5uoiA7WuqFmoo8FhrRcjTfambWpwdFgjro4beBd+36XfArmfbcp+v2EUD5ikr/EAm
	 fALV09seY/gdEf074FGUCjQxQd8DiXYQGY2oAZ5Ogc0Iu49+IWaiGixzUHWtgtdwMW
	 A2VqkOPYjDao3JHSacdLMAIiR2MVf4ykzKwnyTHKmtZE8u1pQNhQ6iKaS0oriFO0p8
	 iGTOVCHfe65Ig==
Date: Mon, 10 Nov 2025 17:04:05 +0000
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: spi: Add spi-buses property
Message-ID: <aRIbBVNzo-7EYJbl@finisterre.sirena.org.uk>
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-1-2098c12d6f5f@baylibre.com>
 <20251021142129.GA34073-robh@kernel.org>
 <14ae0769-341b-4325-b925-7bba6d57bbdf@baylibre.com>
 <20251030135126.GA3749313-robh@kernel.org>
 <f731ebd7-6494-45f5-861d-05a2926cc5fa@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JY5VEXwAAsIpIsIR"
Content-Disposition: inline
In-Reply-To: <f731ebd7-6494-45f5-861d-05a2926cc5fa@baylibre.com>
X-Cookie: You dialed 5483.


--JY5VEXwAAsIpIsIR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 05:42:44PM -0500, David Lechner wrote:
> On 10/30/25 8:51 AM, Rob Herring wrote:

> > But it can't really be 2 independent buses/controllers unless the ADC=
=20
> > has 2 completely independent interfaces, right?

> Correct.

> The proposed property really only concerns the data lines (tx/rx). It doe=
sn't
> care if there is 1 or 2 SCLK lines and it doesn't care if there is only 1=
 CS
> line.

> So maybe spi-data-buses would be a better name for the property? Or
> spi-data-ports (using the NXP FlexSPI controller docs terminology)?
> Or spi-data-channels?

This bindings discussion seems to have stalled out?

--JY5VEXwAAsIpIsIR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkSGv0ACgkQJNaLcl1U
h9ChyQgAg3ZRTKZiHLuTOHpkH+zC1xu6qXXVEgDCvya8kcGtk1SZuS/Z9ctSXQRd
AUAwuRDDY51+uQVewX3TPXBjsfJK1c/3CQOWZ2boNWgOrpHcN4WhQESem7O9eYue
ONdSa6DpVU0E+SLo0TYkNBSEeE0WKEhGGlYjW0CvIlHiZBHo7zxzqxt7lXPd48um
2pYqZMdC/h5yeahRJ8Cjl2ZdJLKGvqnE+DP0UBLoHxNKxDznMCwFwzxHL8YLWsjn
dxoMNisrtyJSeFBHrjdHPHFEeaZD4Pn2lvk4sCdi+vG/tWeGUVIU/Lnp9YjK96/D
Q+Xe+sZVvakT+7qwg5XHHYOY5wVc8g==
=XKp/
-----END PGP SIGNATURE-----

--JY5VEXwAAsIpIsIR--

