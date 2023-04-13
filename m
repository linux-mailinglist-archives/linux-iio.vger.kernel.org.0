Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B566E0BA9
	for <lists+linux-iio@lfdr.de>; Thu, 13 Apr 2023 12:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDMKrX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Apr 2023 06:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDMKrW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Apr 2023 06:47:22 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2558CA
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 03:47:18 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id ca22-20020a056830611600b006a3c1e2b6d2so9335428otb.13
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 03:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681382838; x=1683974838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taUnqldTSyaj/RaRk2S+QI3M39rxfsxRJ5gawmQUKWE=;
        b=e6EaDIXIRjF/SyclyrF4FecAm5miOm+YcmECov0ecCtBpqVibQ5nh7vAeknbsGU0eq
         /4i5mEmqh8sXaUmCFYlysd70aSDeFsQwLwFy1HSU9dAWKWr846sbZWnCn61+JH/6KMDO
         4eHcXtVIafyZpV4M2OIHhJGN74tBdqgqMbVRA45d7kduHKyG78V4myez/5OdtZTQTncv
         z7W7eVNJD3Ygq3I+9lWHJG5m8vL+k3YK34reTGLY6pjx8IcdBcQLZv4M3cDiJMGOTs/C
         2K/JFqeHHX4MnTJqQefyO9NjfOLMCzmqYVoiDVpjmhs/LxyD/mQq3QOvm7r37lLkKckS
         PBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681382838; x=1683974838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taUnqldTSyaj/RaRk2S+QI3M39rxfsxRJ5gawmQUKWE=;
        b=i0FdCjqUu/L1L+z2tt2SKcnhki0ld2NSTxlkY0wbG04F13baj6sjPsw7hPN0ix79Lk
         i5LGx6TpWycgSzP1OUEOtGKcHG9FAiqM5lqlIeyK/mrOgu9ylgZSpZEQoHHghLic6ScK
         Oe61rY5tQc14Kb2BAsns+3R68Ajfw6dVxE2QqLi2NslHJFnMJDJMGl080yBr7Urwz8hO
         5vEjSmj0QbUyEUKXEtR0NVKC7FRhi6zGa5oXxMSDt5vU6Ml4SqdLTtk1dIpyuEWgcIir
         468ySsD49cq1GBAgP8PZ5NkY/NfXTD+jTXsGfPZpxR4YyNvXNurMLrKZ6dfkC0y9hvnx
         1bSw==
X-Gm-Message-State: AAQBX9fKo7VDruO54pVcvwovjYKAG2iy3SHS3ZK1Cs2zaqmh0zd3kOe3
        nkgz+qaI+/AMJgwnFtwCr+B+OZ7uwDGzh/XYy8uLh0Or4SU=
X-Google-Smtp-Source: AKy350Zf323GuiBs1409WNgPJmEgNP0iP2etJCij/85gljOO+y9Tmm65HQ3j879/LzPWRs48ByrNd12ZekT3mj3wg/M=
X-Received: by 2002:a05:6830:22ce:b0:6a3:dfc9:12db with SMTP id
 q14-20020a05683022ce00b006a3dfc912dbmr422172otc.3.1681382837961; Thu, 13 Apr
 2023 03:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
 <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
 <CAPJMGm4YhDNOLku_vWUJA8cYbUinoVoP+NmP4Te+fpa-bjfHfQ@mail.gmail.com>
 <CAPJMGm7mgSi4-Td+8XMqBWLj_tiSVrbxVP7WYbhZnL+_8jJhng@mail.gmail.com> <ae323663d6f8306dff8283b192e014eba25af160.camel@gmail.com>
In-Reply-To: <ae323663d6f8306dff8283b192e014eba25af160.camel@gmail.com>
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Thu, 13 Apr 2023 12:47:06 +0200
Message-ID: <CAPJMGm47CB6BrzRCkK6DTcDE7C9uA3DQXb9x5PXvxNJwUtD6HQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: ad7192: Clarify binding documentation
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 13, 2023 at 12:13=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
>
> On Thu, 2023-04-13 at 10:36 +0200, Fabrizio Lamarque wrote:
> > ---
> >  .../bindings/iio/adc/adi,ad7192.yaml          | 28 +++++++++++++++----
> >  drivers/iio/adc/ad7192.c                      | 18 ++++++------
> >  2 files changed, 32 insertions(+), 14 deletions(-)
> >

> You should not mix bindings changes with driver changes... They should go=
 in
> separate patches.

> +  adi,clock-xtal:
> +    description: |
> +      This bit selects whether an external crystal oscillator or an exte=
rnal
> +      clock is applied as master (mclk) clock. It is ignored when clocks
> +      property is not set.
> +    type: boolean
> +

It looks like you could use a dependency... Grep for "dependencies:" in the
bindings folder.

> > -    st->avdd =3D devm_regulator_get(&spi->dev, "avdd");
> > -    if (IS_ERR(st->avdd))
> > -        return PTR_ERR(st->avdd);
> > +    st->vref =3D devm_regulator_get(&spi->dev, "vref");
> > +    if (IS_ERR(st->vref))
> > +        st->vref =3D devm_regulator_get(&spi->dev, "avdd");
> > +    if (IS_ERR(st->vref))
> > +        return PTR_ERR(st->vref);
> >
> I'm also not sure this will work as you expect. If no regulator is found,=
 you'll
> still get a dummy one which means you won't ever reach the point to get "=
avdd".
> Look here:
>
> https://elixir.bootlin.com/linux/latest/source/drivers/regulator/core.c#L=
2137
>
> So I guess you could devm_regulator_get_optional() for "vref" and then mo=
ve
> forward to look for "avdd" if you get -ENODEV from the first call. But us=
ing
> devm_regulator_get_optional() like this is really an __hack__ and not how=
 it's
> supposed to be used. So maybe this is cumbersome enough to just let it be=
 as
> before? You can just update the description in the bindings.
>
> - Nuno S=C3=A1

You are right. I missed it.
I kindly ask you to confirm if, as per your suggestion, I should send
a v3 patch series with the proper "fixes" tag and this last one
changed as follows:

 - No changes on driver side (keep avdd-supply instead of vref-supply)
 - Indicate in bindings documentation that avdd-supply is vref instead
(with the "Phandle to reference voltage regulator")
 - Add dependencies to yaml bindings

Thank you for your patience and for having this one reviewed again.

Fabrizio Lamarque
