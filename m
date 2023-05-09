Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D245C6FC688
	for <lists+linux-iio@lfdr.de>; Tue,  9 May 2023 14:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjEIMhR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 May 2023 08:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbjEIMhQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 May 2023 08:37:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB594693;
        Tue,  9 May 2023 05:37:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B0EB64658;
        Tue,  9 May 2023 12:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F510C433D2;
        Tue,  9 May 2023 12:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683635834;
        bh=23WmTlHqB8GKuHtze5i9OU+RHltBzQLVtD0kxtl5B44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VgFQEOQYE4wGXCEWpBdd2HbsZ/YJkzS8S38w6iCUmFGQYLNvh7tYiTbsEMpaA8vo+
         MufE+ZBiPDvEjkPRPy3TbM4v5v4G9YJ9aCU/a85rC3Z5Cs8w1JIHxruUpGJ2IBU85M
         bgG6fSwEGGeWVqTY0CePgKCrtvHQR6WiKKfmRIjX/4ryXenSd9JrCwvl/THq8Ga1sq
         yhtQGku7MBV1Xa0WwC4wrp1Yn+6nyijZuTwLut7DVqUhvzVhnqg/lCHsUiqicKaAk/
         6DVYLxSOz7iIWCULNOY/4b7V2FqkDT0/lzPVSRObkMZHg0uV1LnJ9/9pA5deD9+8m7
         Ny2ryllCwlYrQ==
Date:   Tue, 9 May 2023 14:37:11 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: renesas,rcar-gyroadc: Fix
 adi,ad7476 compatible value
Message-ID: <ZFo+d6zOWLaQI+go@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <6b328a3f52657c20759f3a5bb2fe033d47644ba8.1683635404.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zqr5vemGW+2fYBDo"
Content-Disposition: inline
In-Reply-To: <6b328a3f52657c20759f3a5bb2fe033d47644ba8.1683635404.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--zqr5vemGW+2fYBDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 02:34:22PM +0200, Geert Uytterhoeven wrote:
> The conversion to json-schema accidentally dropped the "ad" part prefix
> from the compatible value.
>=20
> Fixes: 8c41245872e206ec ("dt-bindings:iio:adc:renesas,rcar-gyroadc: txt t=
o yaml conversion.")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Good catch!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--zqr5vemGW+2fYBDo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmRaPncACgkQFA3kzBSg
KbZ+MxAAiielfvZyjGxQ9vr2Aeonv5zEI2yju8Ha2lz/2hXAoaToNh4quSbYHU1Y
uPgH7V+xfk0tk0FhAlSPBXnPE36cHWNxAF6muLgJPm2bWCIhXEQBdW/fmRmD9c4n
RLgysaAQouIuDPm/chQkBAz6PdLn7OxESO2u9L9gi5Lr5UxSYdIV6UooLfOQSoel
KQau0IRDVQMwM0hb7NNlH82hT4xeLW88kQU5smVf7UZDx5jkzZPuj4ntmvqDFzGq
7xswV53cMnGJ+Yq8bVzkUaoV3tL+9POZ1f6aUG+yD7fwOa4fBD7fBmXKcgzMQQse
rfC3kNrDnPfaL92+E8lNRwV12cjRr7c1gwlLDSf9ofDQraxIcTjz/EH26B1sD7mC
tfZNIxDvszLdQW2dL7xgPjQmf8VkGyhYx++WduetzwbhLNrk2oiuT5Ql6Fx/bbJM
xNdUXIY+UIzFjuGDWyMkiftLS/am713gQiF68qg+qSroujzqAv0384BK7/oeyLCP
znMMnYlFGOlj46qqG/rDWVlvYc2eeV5kZux0e7Gr3WTPrGlOluLRGCooYeYQi2Jt
1sE0zeRdMyNmKYzSCT3Rx/nNKo/t7oBAwGvgzRgDKsR+hCa5QFtmaXOmYcQnEGsu
7dp4kFgMbrRHh+omqARQ3RpfUZlu97IQskxWGNk9C8iYmro0aas=
=8T4V
-----END PGP SIGNATURE-----

--zqr5vemGW+2fYBDo--
