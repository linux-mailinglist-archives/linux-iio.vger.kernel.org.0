Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBB66E0AFB
	for <lists+linux-iio@lfdr.de>; Thu, 13 Apr 2023 12:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDMKCL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Apr 2023 06:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjDMKCJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Apr 2023 06:02:09 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9777AA0
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 03:02:00 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id cm23so5586192qtb.3
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 03:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681380119; x=1683972119;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fV1zyY3Te22MAR8mEnxRboNLjvO9e3cULPGL5fA7+Bs=;
        b=JP5Z4U/rTuAv+sJozW4s1kz65b8capTLUp9/BG96IeryYOuwWURSM/IGX//cBed2E3
         vFtXFi2fZ0ifBbnlkaE+BCXGxB+r+A49unydvzgPsuAPjOzVvRCB5tmxWq3FdcBTE/Iz
         Ggqmin+KgrCDvLMgcOkRuymgLMBJNTTmQ1RC0BValqN/ln5FXwl8yFZx8y6+dAz4Y15J
         YoObEkDNpC7mnwlDFtBUCgOWWDi2Oaiir17ZcLZQxaWi83RePMQg4JfuxEYHozNlApsM
         23QmcOn8V1gV35X8ExBwWwqg7LKh/UeYHM6Omdyas21s6iWZItQ/FuMZzorZPh305tYN
         5Vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681380119; x=1683972119;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fV1zyY3Te22MAR8mEnxRboNLjvO9e3cULPGL5fA7+Bs=;
        b=bWwpOzKoBUtmetQgf6Wma3eIYQGMGrLhNrVt3mY/0pE6W/jQWMKaR202faofmk58RQ
         lVfoXm/MKx3LHO9Z3O2zSmepFp04aw6Wt8N9f7z9qyaRjjqgAQ3C7hmFctWYRpjSEol4
         0ppYfciUy8yJR/ds9vNIWLXwfagqy8PTLlzvIzctgsqDc8e3vfg8Bs8ecCYYHNY1QaZa
         nKoJF5tkVqXfpRqOexNXYwJwnKH4dtehpcK6xii7BIly9A/cp3zVfBZoa1xoTt1+nwZ/
         2YYRWOLS+zUHek48+S8yacUQlSdbbe+mGUFOthzzyl/ZnCm4w7MI/P3Sy7JaIQ8IpucX
         Mz/w==
X-Gm-Message-State: AAQBX9cAa/a1KLrI1zotmVmZUUs67DcNhVQV9cY6NLa12B6PwSWWKdsT
        jG/z9G52qEVFwcIP1SNE62g=
X-Google-Smtp-Source: AKy350ZNRFAaZuRggW3F90LDpBDHAkKe0miF2lVwzcgmCIGLq/g/D+1Ye7gdXsr+5Dki7ky64Se0nQ==
X-Received: by 2002:ac8:7d16:0:b0:3bf:d193:1b0 with SMTP id g22-20020ac87d16000000b003bfd19301b0mr2053332qtb.48.1681380119083;
        Thu, 13 Apr 2023 03:01:59 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id dw20-20020a05620a601400b0074269db4699sm359896qkb.46.2023.04.13.03.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 03:01:58 -0700 (PDT)
Message-ID: <8217129cb69c180bae1d3d839eed403c3b40e07b.camel@gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: ad7192: Fix internal/external clock
 selection
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>,
        linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>
Date:   Thu, 13 Apr 2023 12:04:05 +0200
In-Reply-To: <CAPJMGm4YhDNOLku_vWUJA8cYbUinoVoP+NmP4Te+fpa-bjfHfQ@mail.gmail.com>
References: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
         <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
         <CAPJMGm4YhDNOLku_vWUJA8cYbUinoVoP+NmP4Te+fpa-bjfHfQ@mail.gmail.com>
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

On Thu, 2023-04-13 at 10:33 +0200, Fabrizio Lamarque wrote:
> Fixed wrong selection of internal clock when mclk is defined.
>=20
> Resolved a logical inversion introduced in c9ec2cb328e3.
>=20
> Fixes: c9ec2cb328e3 iio: adc: ad7192: use devm_clk_get_optional() for mcl=
k

ditto...

> Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
> =C2=A0drivers/iio/adc/ad7192.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 94a9cf34a255..5a9c8898f8af 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -367,7 +367,7 @@ static int ad7192_of_clock_select(struct ad7192_state=
 *st)
> =C2=A0=C2=A0=C2=A0=C2=A0 clock_sel =3D AD7192_CLK_INT;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 /* use internal clock */
> -=C2=A0=C2=A0=C2=A0 if (st->mclk) {
> +=C2=A0=C2=A0=C2=A0 if (!st->mclk) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (of_property_read_boo=
l(np, "adi,int-clock-output-enable"))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
clock_sel =3D AD7192_CLK_INT_CO;
> =C2=A0=C2=A0=C2=A0=C2=A0 } else {

