Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310435E587C
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 04:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiIVCT3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Sep 2022 22:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIVCT2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Sep 2022 22:19:28 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338239C235
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 19:19:27 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s125so10597637oie.4
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 19:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=q7LU/8PQyoDrnPpaYwcGUoi3e7+VI2dbaGmtFZ+Rqy8=;
        b=KeoX4RCwJy4wo4dx7VX3EcK3tEyBEpglLldC9FIYue1shv0pTbGvPRuOQfIuLTs/V3
         LOu0svobJ0PS1akGS+v64ud1KBaJcW/qCW7aygS2aN80czEJ/plaKwlZHU/dTntknLRc
         7XtizAC8vLxItADG2NZrL+sSSnfpXmB/RkdH6HHgodbkj568UDNO/M9flSPGWFHeYqcm
         kb+LSQH4FZhR9LdycukW84iWFg+BBZBWiDnTenci6BkQjleFBb1j3Lg4hzUkzQkLUkxZ
         LK1DSrfq1chNk6pGL7QCZBn9AdfqwA4d/Qtj4m7e9NaRbhljpNgKmM6nJlgIdw2m6GC/
         rUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=q7LU/8PQyoDrnPpaYwcGUoi3e7+VI2dbaGmtFZ+Rqy8=;
        b=sdDM72ySzIptGgExh/F3mVywZkS2aCl5BM8sOdU6UPinAULhDLsY4DCyu1eGFARpqm
         0D4MTeC73X3jXNDhaTuvWl4Au66SBN3FWsj58CuxHI2TcNmQH3gy7TfiaVlMaY68+3Md
         W/+8gPwPR+x+e8rpNIBH4ldIPBl77GUSTyhx24/6vphGHv2eTK75FisvPUqgh2Zfqi9p
         sVApTReua5yaXMkHjYRnDb9Ufam6BmIUIe7rcEeSqRwVwP2kBS3oK7E/dLhkZ9Lh9IzA
         Ub3A7TMTS7LOtMf0xt5X2pCWRCNGXZ4NDcaioyBKvfsacRyIHUDQdklHBFnsOUo4nOyo
         FhCQ==
X-Gm-Message-State: ACrzQf0vtZ5xom2OYXQACSd+F6jhXoBbTn+Y2Gqs9fkkx7fC+lgYHyY5
        daKGY4kAS3KLXtyjG5lQzxzPQg==
X-Google-Smtp-Source: AMsMyM7eElVxy+gKV32xN12V0S+ruBc5RIsvlQlqE+CdB9iaoiqD0zW+Ij+QhXwzmnZNiDqQLXHxzg==
X-Received: by 2002:a05:6808:f90:b0:350:6c57:eba5 with SMTP id o16-20020a0568080f9000b003506c57eba5mr5189849oiw.265.1663813166121;
        Wed, 21 Sep 2022 19:19:26 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id j1-20020a9d7381000000b00655dda40f54sm2078632otk.78.2022.09.21.19.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 19:19:25 -0700 (PDT)
Date:   Wed, 21 Sep 2022 22:19:23 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vgevr.kernel.org, mranostay@ti.com
Subject: Re: [PATCH v7 4/4] MAINTAINERS: add TI ECAP driver info
Message-ID: <YyvGKzd9Cw/zTt6a@fedora>
References: <20220921100627.124085-1-jpanis@baylibre.com>
 <20220921100627.124085-5-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6vauxs2ZcvOv8QeW"
Content-Disposition: inline
In-Reply-To: <20220921100627.124085-5-jpanis@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--6vauxs2ZcvOv8QeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2022 at 12:06:27PM +0200, Julien Panis wrote:
> This commit adds driver info for TI ECAP used in capture operating mode.
>=20
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

I'd like to see at least an "S: Maintained" line before I pick this up.
An "M:" line would also be appreciated if available; it can be a company
team address or mailing list if preferred.

William Breathitt Gray

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d4999f68bda8..fa92518b22ef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20322,6 +20322,12 @@ T:	git git://linuxtv.org/mhadli/v4l-dvb-davinci_=
devices.git
>  F:	drivers/media/platform/ti/davinci/
>  F:	include/media/davinci/
> =20
> +TI ENHANCED CAPTURE (eCAP) DRIVER
> +R:	Julien Panis <jpanis@baylibre.com>
> +L:	linux-iio@vger.kernel.org
> +F:	Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
> +F:	drivers/counter/ti-ecap-capture.c
> +
>  TI ENHANCED QUADRATURE ENCODER PULSE (eQEP) DRIVER
>  R:	David Lechner <david@lechnology.com>
>  L:	linux-iio@vger.kernel.org
> --=20
> 2.37.3
>=20

--6vauxs2ZcvOv8QeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYyvGKwAKCRC1SFbKvhIj
Kyg/AQDG0hUwqkF7voIbXqiLEHfJpbZDxxHBbGHOcREzTAL1rAD9HVCH1s1WWXM5
B7acbPOcQUrY1K5y9WT9eBO7v4wpmQc=
=fNNE
-----END PGP SIGNATURE-----

--6vauxs2ZcvOv8QeW--
