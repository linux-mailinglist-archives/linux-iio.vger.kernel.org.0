Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9B178F0EB
	for <lists+linux-iio@lfdr.de>; Thu, 31 Aug 2023 18:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346712AbjHaQJB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 31 Aug 2023 12:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346725AbjHaQJB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 31 Aug 2023 12:09:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72151BF;
        Thu, 31 Aug 2023 09:08:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55D23628FE;
        Thu, 31 Aug 2023 16:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C508C433C8;
        Thu, 31 Aug 2023 16:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693498136;
        bh=VwM7qmZwL0LfwTXvw6CcC/Oxp23S2JlM/KwU31Hzoew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iBCnyJlQgDulXcpJ0ntNjLsU7W1O/3K0x4maauJR3MfubxUdi1RrWHl5v5juEiIKd
         6j3syWmx7rqEQw64hx9myG2r2t1Kl2AA4gpvlLAGHCw6jQoojbU3nXgZ7FNdGX5ntY
         8pOaVksk9XgEQGCjOhlVamswSuVixvRVpDv0D+8CktfjjNnOChGuJVIwp90DhdG+LP
         dNpUHybVy03S6+oPWXblgF7fzMYx1l3dGhgb+cwuOoaedgg+2Bsysyan+KsCDKgd/5
         LdGeLOjhNbovOTJitMzvd+ztJvrHNrBC2hVMsHOcKZuoe5tVTYricWeCSkUL9i9tCk
         5MFUtL59dp2yg==
Date:   Thu, 31 Aug 2023 17:08:51 +0100
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
Subject: Re: [PATCH v3 0/5] Add RZ/G2UL MTU3a support
Message-ID: <20230831-iphone-muscular-7442cda2c39e@spud>
References: <20230727081848.100834-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hDUORSrU7M6o6mlp"
Content-Disposition: inline
In-Reply-To: <20230727081848.100834-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--hDUORSrU7M6o6mlp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 09:18:43AM +0100, Biju Das wrote:
> This patch series aims to add MTU3a support for RZ/G2UL SMARC EVK.
> Also it fixes overflow/underflow interrupt names.
>=20
> v2->v3:
>  * Dropped patch#4, as it accepted for 6.5 fixes.
>  * Moved patch#2 to patch#1 as it is fixes patch.
>  * Added Rb tag from Geert for patch#1 and patch#3.
>  * Updated the link to lore for Closes tag for patch#2.
>  * Documented RZ/Five SoC as the same IP used in RZ/G2UL SoC.
>=20
> v1->v2:
>  * Added Ack tags from Conor Dooley for binding patches
>  * Updated commit description RZ/G2UL->RZ/{G2UL,Five} for patch#5.
>  * Fixed build error reported by kernel test robot by replacing
>    GIC_SPI x ->SOC_PERIPHERAL_IRQ(x) for patch#5.
>=20
> Biju Das (5):
>   dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow interrupt
>     names
>   dt-bindings: timer: renesas,rz-mtu3: Improve documentation
>   dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs
>   arm64: dts: renesas: r9a07g043: Add MTU3a node
>   arm64: dts: renesas: rzg2ul-smarc: Add support for enabling MTU3

I'm seeing dtbs_check issues in next & Linus' tree as the binding
patches for this don't seem to have landed.
What's the craic with getting them applied?

Thanks,
Conor.

--hDUORSrU7M6o6mlp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPC7EwAKCRB4tDGHoIJi
0vG2AQDOw1T5mt+KLqizXOrufBVI8DrfzfsP+8hF8JSCGpfslwEAuBks5VYsqIlM
/pPHCvPcGg+EEYLeiQlkP8EXk93RiQ4=
=mtLw
-----END PGP SIGNATURE-----

--hDUORSrU7M6o6mlp--
