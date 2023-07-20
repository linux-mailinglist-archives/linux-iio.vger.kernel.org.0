Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C622075B55A
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jul 2023 19:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjGTRQb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jul 2023 13:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjGTRQb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jul 2023 13:16:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EB5CC;
        Thu, 20 Jul 2023 10:16:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A936561B9C;
        Thu, 20 Jul 2023 17:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D49C433C7;
        Thu, 20 Jul 2023 17:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689873389;
        bh=/pLT2xGvqWlqTBYovNwylHnAo5dISq29AylGYc5Qmg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kyHfrH2cRZ4HoPyCZvZgaM4qK4YlmRMPZVAafEz1T0RLuqRFXLSKKfIF9QpMj1Gnb
         areKWhFL/OtsE2io09YJbctarZVVSqQsNLEonkQuateai/XEVQYnC1oGJwq5Q+JPJH
         mmQdkYtRZafu7Hq0xd9n9Kd9nVBGuBT8m62Oa4kJAWX9NIYR/NI6a569LR/Y872EuW
         ZDPHTAkJgHuXjOf3JRQsxo/Iug1+AdEEvzSNWTOjunXDkcsbMBhY+gVck/SrE/+Eb4
         sscMlDekEsHiWXAyDXpaAtJ2ZQl1XQdTHxyXPvJKDbNZOjfg2O29ZPHyxWAvcqpBpQ
         0g+aL+jD8jJ7A==
Date:   Thu, 20 Jul 2023 18:16:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 3/6] dt-bindings: timer: renesas,rz-mtu3: Document
 RZ/G2UL SoC
Message-ID: <20230720-childlike-discern-35427537dab3@spud>
References: <20230720131016.331793-1-biju.das.jz@bp.renesas.com>
 <20230720131016.331793-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IWl0MOq/UWSpzDO8"
Content-Disposition: inline
In-Reply-To: <20230720131016.331793-4-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--IWl0MOq/UWSpzDO8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 02:10:13PM +0100, Biju Das wrote:
> Add MTU3a binding documentation for Renesas RZ/G2UL SoC.
>=20
> MTU3a block is identical to one found on RZ/G2L, so no driver changes are
> required. The fallback compatible string "renesas,rz-mtu3" will be used
> on RZ/G2UL.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml=
 b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
> index 670a2ebaacdb..2269e0bf8818 100644
> --- a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
> +++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
> @@ -109,6 +109,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - renesas,r9a07g043-mtu3  # RZ/G2UL
>            - renesas,r9a07g044-mtu3  # RZ/G2{L,LC}
>            - renesas,r9a07g054-mtu3  # RZ/V2L
>        - const: renesas,rz-mtu3
> --=20
> 2.25.1
>=20

--IWl0MOq/UWSpzDO8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLlr6AAKCRB4tDGHoIJi
0qcjAQDo1EGSbQq2ZUf+aGJQnXBxM4yrqO3W1lkO4/kFuxSyGgD+PmDbOMp2jXxr
pZc+9CCJttqoCybPR3oprUtfn7aLRgs=
=Si3C
-----END PGP SIGNATURE-----

--IWl0MOq/UWSpzDO8--
