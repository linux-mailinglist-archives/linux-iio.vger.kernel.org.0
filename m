Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CF26E0AF6
	for <lists+linux-iio@lfdr.de>; Thu, 13 Apr 2023 12:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjDMKB0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Apr 2023 06:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjDMKBW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Apr 2023 06:01:22 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1199ED1
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 03:01:18 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id oo30so406885qvb.12
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681380077; x=1683972077;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=19pcScyinn7GiJLzgzF0riACB+Yf+Z183WuhqbMw1yo=;
        b=nE9A52oP3sPSrVgwLL94jNdjRu40mO6xySieWxeKdQ/u7DecdeQNr6sl3aITsznkZW
         9NXEDGcemzsajZ1BqxlqWS9fWUr37SFhGmnL/KfU9GZlX2T/Lpa/mkxOAd235qoryQrx
         BwtmaVPTdWGfVVZe8nmCCkvGCPaSNBncYJwDQ6Q3eA+k9xpErkLBdr+U+vqsfJZrLmz+
         JGfDSNElKcOIZ7SupvdeGiEgbq6kI9eCrl8OjpaCR15SP+Of++AtUpf19sEszIFaz9n9
         rsS/HC+gHSUZ98U0/flE3flRbDRjt83fpult4vxMOrauoHIv5V/jOi7JVK8GNBkWedoy
         OjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681380077; x=1683972077;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19pcScyinn7GiJLzgzF0riACB+Yf+Z183WuhqbMw1yo=;
        b=a8lOpc14AB1sYd8TRrf+rjk6B5eM3vL6VSK9q3T3Key3skmNrDGEkdWboa/M1Hb/zv
         Eo/6daKodVPBPlUl2XGSrlFvjqk+qujlksv2jxEVVYgb9X8mCGIH2TbGlIIExgnrWADK
         19uejLZ/SHSduIm/WHfKp9TRyzu1oqmSvRm4ca8pPkkkzsp+4xJTDv7ygTRYK9TR/yWx
         M7ABe1nxBcaJFQeZSEDbtIArbxyuAWmX+uYvQbJ4Bm9C9ZNOmtSOFgZMDeqDsNgm5d03
         r9klnQvdw7Ll+yiO4GIYTCnZvjBHt/7AzsZJ/JvsWoZkWrD8Lo9SwsxJFY1+Z8Q3j5LT
         ClXA==
X-Gm-Message-State: AAQBX9fT1GU8tX7mT/mgL/my2d0Ro29BTUqkO8QEjdiVqCgh8Q2JThtF
        F3VK3GhXyR2VjRUfvzpRScvu/+zFw2wUtACB
X-Google-Smtp-Source: AKy350Y126Vo06eo9lVGoxj81zbBmfBbCuK8Uj9BVl1nHfDWVqlx24ZQ1h/b9TI+bU8Kuy/X/KYTOA==
X-Received: by 2002:ad4:5cea:0:b0:5ef:4227:b3ae with SMTP id iv10-20020ad45cea000000b005ef4227b3aemr2476341qvb.17.1681380076991;
        Thu, 13 Apr 2023 03:01:16 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id t13-20020a05620a0b0d00b007426e664cdcsm341185qkg.133.2023.04.13.03.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 03:01:16 -0700 (PDT)
Message-ID: <3916c0ae90b91342f153fa14160e8c5ef5d1c7f0.camel@gmail.com>
Subject: Re: [PATCH v2 1/3] iio: adc: ad7192: Fix null pointer dereference
 on probe
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>,
        linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>
Date:   Thu, 13 Apr 2023 12:03:21 +0200
In-Reply-To: <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
References: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
         <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2023-04-13 at 10:28 +0200, Fabrizio Lamarque wrote:
> Pointer to indio_dev structure is obtained via spi_get_drvdata() at
> the beginning of function ad7192_setup(), but the spi->dev->driver_data
> member is not initialized, hence a NULL pointer is returned.
>=20
> Fixed by changing ad7192_setup() signature to take pointer to struct
> iio_dev, and get ad7192_state pointer via st =3D iio_priv(indio_dev);
>=20
> Fixes: bd5dcdeb3fd0 iio: adc: ad7192: convert to device-managed functions

This should be:
Fixes: bd5dcdeb3fd0 ("iio: adc: ad7192: convert to device-managed functions=
")

(applies to the other patches in the series).
> Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> ---

With the above fixed:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> Changes in v2: obtained ad7192_state from iio_dev pointer as suggested
> by Jonathan, removed Reviewed-by since the entire patch changed its
> content.
>=20
> =C2=A0drivers/iio/adc/ad7192.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 55a6ab591016..94a9cf34a255 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -380,9 +380,9 @@ static int ad7192_of_clock_select(struct ad7192_state=
 *st)
> =C2=A0 return clock_sel;
> =C2=A0}
>=20
> -static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
> +static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *n=
p)
> =C2=A0{
> - struct iio_dev *indio_dev =3D spi_get_drvdata(st->sd.spi);
> + struct ad7192_state *st =3D iio_priv(indio_dev);
> =C2=A0 bool rej60_en, refin2_en;
> =C2=A0 bool buf_en, bipolar, burnout_curr_en;
> =C2=A0 unsigned long long scale_uv;
> @@ -1073,7 +1073,7 @@ static int ad7192_probe(struct spi_device *spi)
> =C2=A0 }
> =C2=A0 }
>=20
> - ret =3D ad7192_setup(st, spi->dev.of_node);
> + ret =3D ad7192_setup(indio_dev, spi->dev.of_node);
> =C2=A0 if (ret)
> =C2=A0 return ret;
>=20
> --
> 2.34.1

