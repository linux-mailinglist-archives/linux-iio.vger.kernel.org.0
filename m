Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1EA764164
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jul 2023 23:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjGZVsQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jul 2023 17:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGZVsP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Jul 2023 17:48:15 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9F5FA
        for <linux-iio@vger.kernel.org>; Wed, 26 Jul 2023 14:48:14 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-794b8fe8cc4so946268241.0
        for <linux-iio@vger.kernel.org>; Wed, 26 Jul 2023 14:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690408093; x=1691012893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2GIhGVcby32mIJ7MPIu1EoCC5uLJavrxNrbJD8I4Mw=;
        b=hCft1AGOUoBwX7OpvINjbeClc2O7dJzA5n5dvbdNreXH9Y/i4TMA0mjV9j78UCvAKG
         rO+vf72y8ovLRYYd2gxcle/Xtviswc0IlXAFwv9psiScceqWbMWFAVZVUbOOPMn5VUIw
         dhy9AlFpa+7Qgu2ykxC5w5IvPneAPLR1PG98QbkhNd2g4n//hcnMcQ1eAkgiWFW9C/Az
         Q/wDcnexOGLiNa2a67dzFiB6klzUG0OUSyUvcaF6Z5P4R+8dojjzNrs6mnYVeH5qTHkf
         maFd2nf5/RT6++1Ya0DcaVhqZhKe5B8ko3kN3R4nvlBLGwDSUdA/aBcEvZL3Z7Sac4bx
         upmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690408093; x=1691012893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2GIhGVcby32mIJ7MPIu1EoCC5uLJavrxNrbJD8I4Mw=;
        b=bgvtp5irkZIe3U+/0OMUMvdiszTzinUETr93gE54x+5+nTijJfQBLxdOB4s2Apgckb
         yX9SAozioTGg+nmh1hi4ZabUuGPqCa80zspGGKaGXeL4qQHmHhI3WIBRWvj6NhMelSoN
         ebk/aN8tgvMh3qHgr5AarFpLoA1yUCch3dvrcGCZd5F6U/UqNJ3/g7gIV3EM2UMHXUXq
         B27oROt2XS1aMrkjMal0QyMRMrC4FrHQSlKPg+DcJrDFQDNlUaKip5RdBBxNLRLB7a83
         uYcwF4m+9Dvvuqeyyy2UYdKZasl9Wj/aGA9c39l2EXQISdg9k70gh/bt6MfBYGSznexd
         L+fA==
X-Gm-Message-State: ABy/qLaz6mbk/NXymBFGS9VrLLrEVQefDwgoozUhYq37rvwnUixToQdB
        ISLLz8XKjkTuFfPj0VYDXMxKKolv1iUXNq/SkvE=
X-Google-Smtp-Source: APBJJlGDYVzBC2hvsQ8FGWq56rTl1YjlH0aAMXhOLrd4J+uQVF0169ZwLnkB95LXZ/zTMnvWTZvJHA==
X-Received: by 2002:a05:6102:7a8:b0:443:5ddf:4f5b with SMTP id x8-20020a05610207a800b004435ddf4f5bmr95081vsg.11.1690408093114;
        Wed, 26 Jul 2023 14:48:13 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id ei8-20020a056102470800b004476173564bsm134417vsb.30.2023.07.26.14.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 14:48:11 -0700 (PDT)
Date:   Wed, 26 Jul 2023 17:48:09 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: ABI: sysfs-bus-counter: Fix indentation
Message-ID: <ZMGUmed0JaR0dezA@fedora>
References: <20230721151243.282435-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TmqJ1/AmkgGlDBRM"
Content-Disposition: inline
In-Reply-To: <20230721151243.282435-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--TmqJ1/AmkgGlDBRM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2023 at 04:12:43PM +0100, Biju Das wrote:
> Fix the indentation of the KernelVersion, Contact, and Description in
> external_input_phase_clock_select_available block by replacing
> spaces with tabs similar to other blocks.
>=20
> Reported-by: Pavel Machek <pavel@denx.de>
> Closes: https://patchwork.kernel.org/project/cip-dev/patch/20230606075235=
=2E183132-5-biju.das.jz@bp.renesas.com/
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Hi Biju,

I'll queue this for counter-next with the Closes tag changed to point to
Pavel's initial report on lore [^1] (let me know if that's not correct).

Thanks,

William Breathitt Gray

[1] https://lore.kernel.org/r/ZH8D3lCobUJP2T4K@duo.ucw.cz/

> ---
> v1->v2:
>  * Updated commit description
>  * Replaced spaces->tab for Contact and Description lines.
> ---
>  Documentation/ABI/testing/sysfs-bus-counter | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/=
ABI/testing/sysfs-bus-counter
> index dc3b3a5c876b..73ac84c0bca7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -22,11 +22,11 @@ Description:
>  			phase clock.
> =20
>  What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_sele=
ct_available
> -KernelVersion:  6.4
> -Contact:        linux-iio@vger.kernel.org
> +KernelVersion:	6.4
> +Contact:	linux-iio@vger.kernel.org
>  Description:
> -                Discrete set of available values for the respective devi=
ce
> -                configuration are listed in this file.
> +		Discrete set of available values for the respective device
> +		configuration are listed in this file.
> =20
>  What:		/sys/bus/counter/devices/counterX/countY/count
>  KernelVersion:	5.2
> --=20
> 2.25.1
>=20

--TmqJ1/AmkgGlDBRM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZMGUmQAKCRC1SFbKvhIj
KzjgAP4juJC0ahv7zGUlL7Y+YZHMEZMrHTHPLIw5z6IvNuBp1gEA5fP0S3ZulvRj
Ktu4LnpInTzifPZIblgez8xe+Oo8Fwg=
=GLHQ
-----END PGP SIGNATURE-----

--TmqJ1/AmkgGlDBRM--
