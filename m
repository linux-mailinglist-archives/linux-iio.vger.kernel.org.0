Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724025EA648
	for <lists+linux-iio@lfdr.de>; Mon, 26 Sep 2022 14:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiIZMiR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 08:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiIZMhv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 08:37:51 -0400
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428F1BC8E;
        Mon, 26 Sep 2022 04:15:05 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id bu25so8372867lfb.3;
        Mon, 26 Sep 2022 04:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=GEHx2Zx+RBNFyA2ObZg/iZDM5N6nWFbfzSpwnjh0Wbo=;
        b=d9MBNAs/QF3Dbjssw9gL+Kwi4QdVIfrrj9Ir6te7WzzgxdFfq4w5RFFMeuprQhJWWv
         R4mTvzPhImqPsqqnkqRyjq49pbCUBTGrruyBBFe5rAR8VBaaf4lZ6YHyFzjocOsuib68
         VAxwXRDWMdmCTaQtLLTYCKkBnl0Q5ynMJ4Fj2kyk4TGkC+qzWFArW7Sd3DwdkTGuN14O
         FlPTrBqpoXjqVp7w0U/CZoWh3DtgxeMt/Vh04yBNti/EJ1LoiMAOohJREWJnl5vsVzJ7
         deh+QHzD3x8d6LWPy47MdAY8l9ePN295knBrT9B7qHrPwYNZgya3pdDEdg1sIatrvIU5
         hmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=GEHx2Zx+RBNFyA2ObZg/iZDM5N6nWFbfzSpwnjh0Wbo=;
        b=yCdkjXB+GKk59/SyY8Iz55bg0SQRZu8Dt2v/YDwurrbh1rNtljHu6ZfjRLA/uFyKLz
         D6uranAyeUHHpghyAl2/Q1dPS8PqJDwL+fQ7u9rnI1lL1rLGDzfCy+VQOAYEdEgLbwpz
         S6JJb/cg7I5jCik17GkGDNs1vWVCaqPWYdBLPZTlRtNeX6qymHQuvrt4mz5mZ5V3vS6y
         3Ut+VX9loyQrkZRqougnGM6uytMKqAgnUEMgTXo93pYMZWK0F8xIKiOnmX08+R4QZIce
         qkxSEnIxECeoRFoMxdJsMBOMfa5xduZnJ2KdstPT3UJwnBu15R1b6XgDE+PyausDBiKX
         sQSw==
X-Gm-Message-State: ACrzQf02j1bJ0lfJeXftiNqcX+C5emS7gpTDskSyBqf8U00LLtpH66dG
        sQ3TFg64dmX/f9GjxsirSL+7Rb+Y11Y=
X-Google-Smtp-Source: AMsMyM4btK+INKfBLYmoUvUUOKV8RDjw9Juzg9hPO815B3kd9Tbm03ocf1tFfR/CiF+3T1f8zdwPyw==
X-Received: by 2002:a05:6512:398c:b0:49a:f04e:d241 with SMTP id j12-20020a056512398c00b0049af04ed241mr9446761lfu.455.1664190773363;
        Mon, 26 Sep 2022 04:12:53 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id t27-20020ac2549b000000b00494603953b6sm2506273lfk.6.2022.09.26.04.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 04:12:52 -0700 (PDT)
Date:   Mon, 26 Sep 2022 13:18:58 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mcp3911: fix sizeof() vs ARRAY_SIZE() bug
Message-ID: <YzGKolEWAZ0Z/fQf@gmail.com>
References: <YzFsjY3xLHUQMjVr@kili>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vqTdV70CllBLXm88"
Content-Disposition: inline
In-Reply-To: <YzFsjY3xLHUQMjVr@kili>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--vqTdV70CllBLXm88
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Good catch.
Too bad I missed it.

/Marcus

On Mon, Sep 26, 2022 at 12:10:37PM +0300, Dan Carpenter wrote:
> This code uses sizeof() instead of ARRAY_SIZE() so it reads beyond the
> end of the mcp3911_osr_table[] array.
>=20
> Fixes: 6d965885f4ea ("iio: adc: mcp3911: add support for oversampling rat=
io")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

> ---
>  drivers/iio/adc/mcp3911.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index b35fd2c9c3c0..015a9ffdb26a 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -248,7 +248,7 @@ static int mcp3911_write_raw(struct iio_dev *indio_de=
v,
>  		break;
> =20
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		for (int i =3D 0; i < sizeof(mcp3911_osr_table); i++) {
> +		for (int i =3D 0; i < ARRAY_SIZE(mcp3911_osr_table); i++) {
>  			if (val =3D=3D mcp3911_osr_table[i]) {
>  				val =3D FIELD_PREP(MCP3911_CONFIG_OSR, i);
>  				ret =3D mcp3911_update(adc, MCP3911_REG_CONFIG, MCP3911_CONFIG_OSR,
> --=20
> 2.35.1
>=20

--vqTdV70CllBLXm88
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmMxip0ACgkQiIBOb1ld
UjI7sA//VZbtIseTAiOXt4x0ZC3TuyMYmboUe8m/z0yzOpZ9xfz+/yNVPnTE38H8
rUPYv8oPAyHXL3FDwriXkf6hGhW7PvK3y8R4L5k4uQQc2HIGMDDCLcymowjTx093
J3iDd2zFLUEkJ3Qn5RkHlyY4dLZ60vfrAOsIBS6dcFvea0g9D5SzECWKR4X9GTPc
bbDLJ21BTx1STGzfOKBV7C+pLR13Zmfr5LwZl5R32cbZgrJnnYbIcXgLPMZ1FeWo
KCzy8rhavTVtTso9ET4zNRQHu+gjoHCet0C34tUAraYineI0a75dDvIXceu2VXwd
fP1kb1cFarLJGTF0i6quzatH4/5Q1VZTXa20RqW5aVL2NZ2s4Yw1RD8d0RJKU4T0
wjlrlGmgESZuSWGuEo3jkbaobT3Q9Wb9+JHCaPK7cApt3zAkqKK44STh4Z3/Y8tG
qZJDsCFyKToqVkFnCIHQGk+ONxxEq/NA5AyM1lC5UXueaJh1P/29YO9b+rqf00h7
fyM5INacS5u9lp66OYki9BrM7iB/sBdHCEvcdxccrJ2ziKys84/WVZaEfGI8CGpd
jryEq2R5+AkzABTkMiONwDq9xiqN5oSyX6sjM7xS6K7f8sblHmlLDVUoARhSz9dB
/X9thivDH/D9L1W51oPl0I+XKVYkclumcGNCjxGoSw1UCOCv3Nk=
=jHQG
-----END PGP SIGNATURE-----

--vqTdV70CllBLXm88--
