Return-Path: <linux-iio+bounces-5776-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E72FA8FBAAE
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 19:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998A91F227E6
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 17:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8604214A0A2;
	Tue,  4 Jun 2024 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="py5b0Q6i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F2C14A088;
	Tue,  4 Jun 2024 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522870; cv=none; b=dItWI3s3jBBBKysmD2Nqt6OFl9UtSSHi42Sl+rwwXtOptuCSf8ZOlW1EbTH1mde+Yw86w8+bbqnXTSqbPTu8/G/0hLROW7YEttfrfiu13M25NTx0/QZiHWDu//F/mfPUfluM5LyOT81iOYiKhc2GOWuPZL1RQr7SeuPgzGEVGAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522870; c=relaxed/simple;
	bh=DuJG1xUSNNkn688G+JiifzfvYtedjIXjfodfy1p8X2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8+FETWMqpevRtMeestJlNpLEru/CD9yZ8UkSTppy5C4h4ANBth8xjBBH+q+TdasgMdnXNpzmbl593jNqV7BicWGS+FHqz3Nc5Rb45aUGO85ny0gUYsqqzqZzgkYyyMTghSIl/NVmMwZO4VlhT49SAEqSSqQi/qyRT38Rt4qGMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=py5b0Q6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A5EC2BBFC;
	Tue,  4 Jun 2024 17:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717522869;
	bh=DuJG1xUSNNkn688G+JiifzfvYtedjIXjfodfy1p8X2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=py5b0Q6id6opaDgThP9tW+2w+Mr6FKZCZEYcQeyktM5uwCMxaSQ3tLTRYCsV64TyG
	 FbTmsfPka90RPkj6JE8JMCfrON7OHaKniAduwjyM/oNIGFiK8W/LxkznEDfuVJ/3JT
	 cEJLxaJiuT5DO7OuWppJiab1KSjTntO4nxP09hxi9VO1chfPePnCvGKsTAtI4AgNWy
	 K2Eckd4dladsZ2corT7UlS+IbYTOGFJeiQcXrzLYNYkWHITfXN57kCO6g6hdy1U6Qn
	 ud7AAaUItShyttYXmGMwM6woZ8uH5js2zPCvkudRvZr97hs7ZgP2HQdFIFdT71TVGe
	 tZ1s/jWqOlZgw==
Date: Tue, 4 Jun 2024 18:41:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Konstantin Porotchkin <kostap@marvell.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-phy@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 4/7] dt-bindings: phy: armada-cp110-utmi: add optional
 swap-dx-lanes property
Message-ID: <20240604-tucking-aggregate-0496e393f21c@spud>
References: <20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com>
 <20240602-cn9130-som-v6-4-89393e86d4c7@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="antw0Vz5LrrLd1V3"
Content-Disposition: inline
In-Reply-To: <20240602-cn9130-som-v6-4-89393e86d4c7@solid-run.com>


--antw0Vz5LrrLd1V3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 02, 2024 at 05:49:39PM +0200, Josua Mayer wrote:
> Armada CP110 UTMI supports swapping D+ and D- signals.
> usb251xb.yaml already describes a suitable device-tree property for the
> same purpose but as child usb controller node.
>=20
> Add optional swap-dx-lanes device-tree property to armada cp110 utmi phy
> with same semantics as usb251xb:
> The property lists all ports that swap D+ and D-, unlisted ports are
> considered correct.
>=20
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  .../devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml      | 6 =
++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/marvell,armada-cp110-u=
tmi-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,armada-cp110-u=
tmi-phy.yaml
> index 9ce7b4c6d208..2ef02aac042a 100644
> --- a/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy=
=2Eyaml
> +++ b/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy=
=2Eyaml
> @@ -41,6 +41,12 @@ properties:
>        Phandle to the system controller node
>      $ref: /schemas/types.yaml#/definitions/phandle
> =20
> +  swap-dx-lanes:

Missing a vendor prefix.
Otherwise, to me naive eye, seems okay.

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |

This | probably isn't needed though, there's not any format here that
seems worth preserving.

Thanks,
Conor.

> +      Specifies the ports which will swap the differential-pair (D+/D-),
> +      default is not-swapped.
> +
>  # Required child nodes:
> =20
>  patternProperties:
>=20
> --=20
> 2.35.3
>=20

--antw0Vz5LrrLd1V3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZl9RrwAKCRB4tDGHoIJi
0pUBAP9rw/WOT5tk+YGVhId6qKQNcjIeXvys1UKCwDNlO7k3SAEA6/Im72mCS8P8
HCYHLplimcTSkkx+oYWfqs/KnzhQ+wQ=
=vdFm
-----END PGP SIGNATURE-----

--antw0Vz5LrrLd1V3--

