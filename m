Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6782B7AB0B1
	for <lists+linux-iio@lfdr.de>; Fri, 22 Sep 2023 13:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjIVLaR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Sep 2023 07:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjIVLaQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Sep 2023 07:30:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29115AC
        for <linux-iio@vger.kernel.org>; Fri, 22 Sep 2023 04:30:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED32C433C8;
        Fri, 22 Sep 2023 11:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695382210;
        bh=kcu6bV59mCPFudl+FqsxWmvsIoqfFkVrqnRHgh/OQ3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4ATQY9KC3drFwpc4NULdzExIUdKRODHy912og8q6CXypaCdcWxeurVUx24Vp0T/w
         Z/bc0+Ri5dIOpP2d2lqua3bkWrobVYJ4USsr9X/moMTjG9CW34vptXxs79aT0XmfhZ
         qyZdNb1uF3WJ8O4obdbhPmBqNKvBIl2xqFUR9IdKXQvSTSE4erLfUGmYHJie+bh4YN
         pFYZP3pmHlxJyAEOCKosys9mjv3x4FPvLC3VpF9oXFSF/EXCsHvb3yon2Dklp2ljdT
         x2I44sp2ieSTQx96jMmwJTjlidLtpuMyvME5GFgfRh6RRjjSKn/P98aS3iIoGvWD4i
         bYrPpjpB75taA==
Date:   Fri, 22 Sep 2023 12:30:06 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     devicetree@vger.kernel.org, Alexandru Lazar <alazar@startmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,ads1015: Document optional
 interrupt line
Message-ID: <20230922-demise-shallot-2623f8ff869b@spud>
References: <20230921192420.70643-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9HSak8AY9HARqeTX"
Content-Disposition: inline
In-Reply-To: <20230921192420.70643-1-marex@denx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--9HSak8AY9HARqeTX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 09:24:20PM +0200, Marek Vasut wrote:
> The ADS1015 can have optional IRQ line connected, document it in the DT b=
indings.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Alexandru Lazar <alazar@startmail.com>
> Cc: Conor Dooley <conor+dt@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Marco Felsch <m.felsch@pengutronix.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/=
Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> index e004659099c19..d605999ffe288 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> @@ -23,6 +23,9 @@ properties:
>    reg:
>      maxItems: 1
> =20
> +  interrupts:
> +    maxItems: 1
> +
>    "#address-cells":
>      const: 1
> =20
> --=20
> 2.40.1
>=20

--9HSak8AY9HARqeTX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQ16vgAKCRB4tDGHoIJi
0imEAP940SaqHrs9Ws8VDaW6C046rMT3N0tItEjhA6usEIVcrQD/RfBgIYRG38ya
G2WDYP+iXZ1J5KgCBIDDV3CSQn8FSQo=
=s0WP
-----END PGP SIGNATURE-----

--9HSak8AY9HARqeTX--
