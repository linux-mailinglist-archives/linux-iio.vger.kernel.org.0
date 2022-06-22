Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B055542B2
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jun 2022 08:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349768AbiFVGXr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jun 2022 02:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350539AbiFVGXS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2022 02:23:18 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EDFCFE
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 23:23:17 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id e4so18115930ljl.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 23:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S7M1kev6slYXU1zMfSIREt40Fm1HNQYgwmgp0GkZvFc=;
        b=Oh4f93KzHR+o87FsBjX0RwHDymChaKeaxMIszmgrqqHLDp3ZcdGxMCccU6rG7KkqRC
         GPYsWlWVvmhgM9P4thnWkj+w5L1ubqJ9p0Vmz4FV7cL7FLijzOrjN30g1JUD9EwvSTgu
         EDWySHMjO7v5FA3TaeYKBvhDzUDYDYEh7ffAfSMQhHyEcjqcTiwaDcV++lcelnBYHMPQ
         CsK1AIGLncVVRdxilBHKZvyitlaA9CuacwtrVjGfr6P7P+fnIXQ90oEvGbb5lkVT8Q+1
         K1zAdRH9QhPUVBeWJKd6g4uiUmio+kjqF8AT+zv9D5FPpk0zSYnEBT6nlNKXjSZCXnCX
         h46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S7M1kev6slYXU1zMfSIREt40Fm1HNQYgwmgp0GkZvFc=;
        b=idg8Sact+JvdcpNAOX6xxUZj4Nza5I4WfOzLpTZGlQtY5HUsx0tXMyl3BF5zTvajsr
         nD1Sb+pW1VkCTe1xGs4lcAqLRLwKbRqgPw5Gaiqhsw9EKs80Wh3RTWahT9BqxRZFh7pv
         0xK2TOEJ/nWDJ4dqUYiJGESOlj74mdaEa8v5OYl+1uS0FwPjeF6MbJmcbi8lVXTKnxlC
         vGegr26utP0pDhiBy5GRlSGPBiRMM1xJWTPrjNvfEUPds6SwdnCIu3hISGEnOIWoj4b1
         dI9Yx8dHRBBRVOBLwFdKS9xhH3blmVZsFyTp05kzPxa9yGCyXM0sjdGvE7d/GTarZdDV
         OA7g==
X-Gm-Message-State: AJIora+rpJcqqF3ZM0POdABWNy9k1Rz4MHY3bVTzR8W1ZQPchzGDhknR
        S77EY6xO/05/uiGbD1X8fNM=
X-Google-Smtp-Source: AGRyM1snwfjcX0ah5iE9kArvHm7lYS4/Et1FwirOmtxquFexq7ZHQvxH1JrmQwKzo+0nvQ6iNUMdkA==
X-Received: by 2002:a2e:9941:0:b0:247:dce8:b0ec with SMTP id r1-20020a2e9941000000b00247dce8b0ecmr982802ljj.404.1655878995490;
        Tue, 21 Jun 2022 23:23:15 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id z22-20020a195e56000000b0047f66294ff4sm1416563lfi.151.2022.06.21.23.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 23:23:14 -0700 (PDT)
Date:   Wed, 22 Jun 2022 08:25:04 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Brian Masney <masneyb@onstation.org>,
        David Heidelberg <david@ixit.cz>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Christian Eggers <ceggers@arri.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Joe Sandom <joe.g.sandom@gmail.com>,
        "Ismail H . Kose" <ihkose@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rishi Gupta <gupt21@gmail.com>,
        Roan van Dijk <roan@protonic.nl>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 12/36] iio: dac: ltc1660: Switch to
 DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Message-ID: <YrK1wM/Pt8NQdmLX@gmail.com>
References: <20220621202719.13644-1-jic23@kernel.org>
 <20220621202719.13644-13-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZAq4xVGMATV1TjOO"
Content-Disposition: inline
In-Reply-To: <20220621202719.13644-13-jic23@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ZAq4xVGMATV1TjOO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 21, 2022 at 09:26:55PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Using these newer macros allows the compiler to remove the unused
> structure and functions when !CONFIG_PM_SLEEP + removes the need to
> mark pm functions __maybe_unused.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

--ZAq4xVGMATV1TjOO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmKytbkACgkQiIBOb1ld
UjLXLA/+I6uEa9NMfdMKV7IO//vbNzxDguUeDuaScfND8D+8TR7NC+PFJBcgZR0j
zf87lHhMmb5ealeqOVsZ777bk/LfvCvY/hDQ/dRWYhLG5Z7olzmi2kQfbUDQvKjF
YsOKknarvV1R9j+orll2yQ6Q/EmeioxSqwGiV3gDYsv9QIKPHqDnOVCRZqCA1CtL
tE6Fft48d3m8zPLYmusIk8RUuXkhaGKTBAQ9LjK6cp7Ytk7DKkGu7q61tnGQxTGM
jGTrdxcqXG8asdxRTnRkmuTnGnmukSvIu5ajFGH7Xg6Ii5t0KhtAM4KMkdvo9Xxp
PlQUXA0NGScAynz3BFgV9aO/aivi/RaFp2ChYY0E5AHeDJuCshCaypL7sqc3RXi1
QTRfOdGrNU9liSoY23yVDs9WSTXZAv8n7zPYoxzIB5Z420Y19b7C3iZ5+f2FxwIE
Tu9nSLZuPdV55ITzV/Vz/as7qkZwj2iv5pV/s5GucM4DLwccoc/imK0Jho6MkULL
u5Ge+tbdXw9QVv+6dAZbGvUTJjI4PCoh4lrxUlq9BxhJXAkXoa02sn5xvlJSf1Tj
aLdXraiYQF7f1PjM/l30MbgKHsY+D+pmUvVXZZh8+lby4/9z9eMo6/zj2H5AXn+n
Vdo8HhAcCLV8ZqTV/UpE5O1Rv/dVCMny+RGXM/FYGalPsn13YjY=
=5/Cl
-----END PGP SIGNATURE-----

--ZAq4xVGMATV1TjOO--
