Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135557390EB
	for <lists+linux-iio@lfdr.de>; Wed, 21 Jun 2023 22:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjFUUlN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Jun 2023 16:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFUUlN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jun 2023 16:41:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFB619A2;
        Wed, 21 Jun 2023 13:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ABF8616C4;
        Wed, 21 Jun 2023 20:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF9FC433C0;
        Wed, 21 Jun 2023 20:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687380069;
        bh=nya6SkUgwfDXCEydm5k48I31KnLlVNlDYFz+QA9GuLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IhZCdW6hQYna6WgkSn9B/T+6H5C6NTyxE981mkqyZPSw+Jt8NJLHIXfnaIRD87uKS
         XHUazIQnjDy3M2zPFiKU07h/lyuFnDbp+Ead+Vqrxq8RMcIOM4D9oYKiIPPcmnY5xN
         ZEzMeBTVqmBfW/wBE1T+aFt/8e6JXHfao9q+xFxnaqGMEZE+2mv2yv9VVOZ2SVY0wC
         ac9A+ouHwYHBzSo+1561tIw0nNV0v/V1jYApmNbQORw0gmwS6mTa/8RNdn5Q5VBsba
         FbsW9GEowsmPWVO0Epu2mx1+WrrSCABGWnTZZ3qKtynswXivpN+c3IQEUhBly8pfZJ
         dFWMsnQHXzB9g==
Date:   Wed, 21 Jun 2023 21:41:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alazar@startmail.com, daniel.baluta@nxp.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,ads1015: fix datarate max
 value and meaning
Message-ID: <20230621-unsavory-ransack-f0a3af93325c@spud>
References: <20230621160857.3400747-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bAeHDUPxy3KL+ZJD"
Content-Disposition: inline
In-Reply-To: <20230621160857.3400747-1-m.felsch@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--bAeHDUPxy3KL+ZJD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 06:08:57PM +0200, Marco Felsch wrote:
> Datarate (dr) is a 3-bit wide register field. Values from 0 to 7 are
> allowed for all devices but only for the ADS1115 devices a value of 7
> does make a difference.
>=20
> While on it fix the description of the datarate for ADS1115 devices as
> well.
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  .../devicetree/bindings/iio/adc/ti,ads1015.yaml   | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/=
Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> index 2127d639a7683..e004659099c19 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> @@ -78,9 +78,9 @@ patternProperties:
>        ti,datarate:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          minimum: 0
> -        maximum: 6
> +        maximum: 7
>          description: |
> -          Data acquisition rate in samples per second
> +          Data acquisition rate in samples per second for ADS1015, TLA20=
24
>            0: 128
>            1: 250
>            2: 490
> @@ -88,6 +88,17 @@ patternProperties:
>            4: 1600 (default)
>            5: 2400
>            6: 3300
> +          7: 3300
> +
> +          Data acquisition rate in samples per second for ADS1115
> +          0: 8
> +          1: 16
> +          2: 32
> +          3: 64
> +          4: 128 (default)
> +          5: 250
> +          6: 475
> +          7: 860

I'll leave this one to Rob or Krzysztof to ack/review, but this does
seem like as good an opportunity as any to migrate to a property that
allows you to put the actual data acquisition rate in & not have to add
new key-value mappings to the binding to support devices with differing
schemes.

> =20
>      required:
>        - reg
> --=20
> 2.39.2
>=20

--bAeHDUPxy3KL+ZJD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJNgYQAKCRB4tDGHoIJi
0gJTAQDJqTakuIIA3mTEYmLrHIni5A4YA9rCzDSK8DkHbLPXSwD9EOYe8+eJgb8z
x/te/fo+HktDS7lULHAW4iN8HfLjSQo=
=BPV4
-----END PGP SIGNATURE-----

--bAeHDUPxy3KL+ZJD--
