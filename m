Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96137756C3C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jul 2023 20:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjGQShD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Jul 2023 14:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGQShB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Jul 2023 14:37:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB29BE5;
        Mon, 17 Jul 2023 11:36:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79D57611EC;
        Mon, 17 Jul 2023 18:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5141DC433C7;
        Mon, 17 Jul 2023 18:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689619014;
        bh=tf5C7ZeWwiSknLBebqdf9e5Mdxw7uxlH5xfI9Wcq/kQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FLA0hgQ4kPuHIPyqCQsZzacvIc1snhtdZBuF7ClT0YjfNwqzOFgGBDWAxrjBYPu2k
         8nmToxKC8GE2v8Nftk87mDkh/m1QuNoQQDpRtDP2tM2uwq+ixdzhrXVL7m90I41y1h
         yiGl2hLqUCKQdICYTq5NswFHDQ3/J7+vrA5E6dVoZ7jow6yyFdlv4TN4lAH95RJrGB
         AU10y/A2GB/BzKXFWTFXDOBnCustGGqTIIzBuQpSK3V2rHvMeTRNrZinaukNnYXmZm
         Rw0AWxWf8pfJDkayKQMa9xGwQz2QdV70zPQiXdG9ZIQqqshP3DtcAda/f9okgE5Vz2
         Dk1Ow5MwAmcdQ==
Date:   Mon, 17 Jul 2023 19:36:49 +0100
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
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH] dt-bindings: timer: renesas,rz-mtu3: Improve
 documentation
Message-ID: <20230717-quadrant-operate-d7927b9dd647@spud>
References: <20230717115757.164284-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vWpkUzHbGcjePyjV"
Content-Disposition: inline
In-Reply-To: <20230717115757.164284-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--vWpkUzHbGcjePyjV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 12:57:57PM +0100, Biju Das wrote:
> Fix the documentation issues pointed by Pavel while backporting
> it to 6.1.y-cip.
>  - Replace '32- bit'->'32-bit'
>  - Consistently remove '.' at the end of line for the specifications
>  - Replace '          (excluding MTU8)'-> '(excluding MTU8)'
>=20
> Reported-by: Pavel Machek <pavel@denx.de>
> Closes: https://patchwork.kernel.org/project/cip-dev/patch/20230606075235=
=2E183132-3-biju.das.jz@bp.renesas.com/
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--vWpkUzHbGcjePyjV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLWKQQAKCRB4tDGHoIJi
0hIfAQDjXLniEheKVSZKJMYEpn4kIardIiIOy/i3NY9779DolgEAuBY1hPUUA2ho
7wZYkuwhn/LSuhwakc9xvF8Bb9yg3Qs=
=om29
-----END PGP SIGNATURE-----

--vWpkUzHbGcjePyjV--
