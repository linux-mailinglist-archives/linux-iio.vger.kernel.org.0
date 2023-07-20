Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FA675B570
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jul 2023 19:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjGTRTM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jul 2023 13:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGTRTL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jul 2023 13:19:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E51132;
        Thu, 20 Jul 2023 10:19:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAC9961B9D;
        Thu, 20 Jul 2023 17:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571B2C433C8;
        Thu, 20 Jul 2023 17:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689873549;
        bh=PCeBJb2it4GDnzii3g1inFDY9PKx76314UTnyFWdLTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A/7ceHjrWq8IBFEMpU8XgEb9ndiYaRqmjtIgpy4WzuqsudOYhuYDVs3KrC7fFcBsk
         DqwMNVphMj0bjO7hAR72UYGPBg0DmfKHYdnMbs2AGi75HUCpTiUrIL1pw6QWlUCxvR
         Y7jNZe2lAQVfOMt3h8M9c/B/FVrRNItXEAHDWVOYg3eCNlQM4QXrLpqBwXgH3SjUXb
         3LDy3kgLYi9w3k/RKPy7YQxQWjRf5ujl0d9au0APamVGyJ4racmwjle8X7Fcaq8URj
         QiJYGtxqcqrv/95PYR91govMdJcmQ0j9fnxoPVQVfSUA8d25AApKi63/UKnRBlEN3T
         NPP/c2ILds4cQ==
Date:   Thu, 20 Jul 2023 18:19:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        stable@kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: timer: renesas,rz-mtu3: Fix
 overflow/underflow interrupt names
Message-ID: <20230720-clash-borax-b458480d1579@spud>
References: <20230720131016.331793-1-biju.das.jz@bp.renesas.com>
 <20230720131016.331793-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MW2bXVyLy+hXKyIU"
Content-Disposition: inline
In-Reply-To: <20230720131016.331793-3-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--MW2bXVyLy+hXKyIU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 02:10:12PM +0100, Biju Das wrote:
> As per R01UH0914EJ0130 Rev.1.30 HW manual the MTU3 overflow/underflow
> interrupt names starts with 'tci' instead of 'tgi'.
>=20
> Fix this documentation issue by replacing below overflow/underflow
> interrupt names:
>  - tgiv0->tciv0
>  - tgiv1->tciv1
>  - tgiu1->tciu1
>  - tgiv2->tciv2
>  - tgiu2->tciu2
>  - tgiv3->tciv3
>  - tgiv4->tciv4
>  - tgiv6->tciv6
>  - tgiv7->tciv7
>  - tgiv8->tciv8
>  - tgiu8->tciu8
>=20
> Fixes: 0a9d6b54297e ("dt-bindings: timer: Document RZ/G2L MTU3a bindings")
> Cc: stable@kernel.org
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

I assume this means that nothing is actually using these interrupt
names?

--MW2bXVyLy+hXKyIU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLlshwAKCRB4tDGHoIJi
0t55AQDz0NSQJfxvl+nR9Y5hWRTccTVr1L6oNorO/EggbADklgD9ES3zktzX4fEu
l92TRktDZDFa4dKcrtFiGN/0/htCiQg=
=aIp8
-----END PGP SIGNATURE-----

--MW2bXVyLy+hXKyIU--
