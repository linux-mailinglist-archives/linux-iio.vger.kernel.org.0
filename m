Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901B36E0C58
	for <lists+linux-iio@lfdr.de>; Thu, 13 Apr 2023 13:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDMLVe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Apr 2023 07:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDMLVd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Apr 2023 07:21:33 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D955527E
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 04:21:31 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id l11so16080823qtj.4
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2023 04:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681384890; x=1683976890;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=85YDIMWiI1RfmyVRENeUb9fTQxKC+rACPx4Ep6gZ30k=;
        b=o441Mrod8lvZAVWDo7zasR3HUMwE8geyALBOcym1y902q+wK3dp32tPSS6ivsKYkFU
         CyuJK8+g1+kZceAA9EY146hYNQd1RxrntT8GZ6xdXdqPwvMFjiGqjjdCOe0Fewp9OlLv
         PUoTK2sqL/MbNpWh0lsLXlZRkP4hg82jsKS/kYr30Zsz2pxdHAqVNUaIIijGkhm6hsU9
         /W+ITSHQ92QsqHo3Ydpj94F6N299vyzclfsHVDeZI8PhZcEEntOmdEurFF7vZTAHeFhi
         wT4twpNiItuYtigtXt+m+5k86XzCipN03Gt6BifWFUxJ3ftokNoUeStmjG9gDjLWxKiN
         iQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681384890; x=1683976890;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85YDIMWiI1RfmyVRENeUb9fTQxKC+rACPx4Ep6gZ30k=;
        b=kgYntvyYu090tRNy4y7BnKbtoMlY8J8owMdseXpa4DS7VWjJs5dEWjJfL+pvRzs/f9
         0CtfLjwIZYQFuf45OVppfH0TmbpcqX3RsuBAUUMw0GhKMbdGx2MkIUa68jhoZOW9K/hC
         rT30/fVSNlJD8JsRTX/X4tWXBZaBTS+hAI4ZasdM1Dr1hhaVpRZuIYUfuD8DcWXFGjyO
         0TP4Vji4th2TptFKWD92NFJ73PbYx8jjn8hbVRQhIVuVQrrf2KuIupYjk9vN8au2v1Cy
         mgetNNanW851y6kBw5JZHq4flZPGclH+SKKcYV1cSrZNM/Vk32Eoaq4LFsJdl8IC5baq
         ZrUw==
X-Gm-Message-State: AAQBX9eRCspcY1v0ELHq+YpqRfSLpQFdFSXphlvwOrk2Q7NS93WdeMDg
        7R8Stx+1lP1UlGjNiqOoRts=
X-Google-Smtp-Source: AKy350bxtJHBKrbRuHgZs5F3GqjwhlAiBIDNd+5RRmCtfCaJ588uncAkbR31CxRwt6D09b0Nib3VCg==
X-Received: by 2002:a05:622a:170c:b0:3e6:456d:42be with SMTP id h12-20020a05622a170c00b003e6456d42bemr2602861qtk.37.1681384890086;
        Thu, 13 Apr 2023 04:21:30 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id i1-20020ac813c1000000b003e387a2fbdfsm435421qtj.0.2023.04.13.04.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:21:29 -0700 (PDT)
Message-ID: <ed06e8c5786373f095f0d63fb88dfe7d3801f752.camel@gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: ad7192: Clarify binding documentation
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Date:   Thu, 13 Apr 2023 13:23:35 +0200
In-Reply-To: <CAPJMGm47CB6BrzRCkK6DTcDE7C9uA3DQXb9x5PXvxNJwUtD6HQ@mail.gmail.com>
References: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
         <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
         <CAPJMGm4YhDNOLku_vWUJA8cYbUinoVoP+NmP4Te+fpa-bjfHfQ@mail.gmail.com>
         <CAPJMGm7mgSi4-Td+8XMqBWLj_tiSVrbxVP7WYbhZnL+_8jJhng@mail.gmail.com>
         <ae323663d6f8306dff8283b192e014eba25af160.camel@gmail.com>
         <CAPJMGm47CB6BrzRCkK6DTcDE7C9uA3DQXb9x5PXvxNJwUtD6HQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2023-04-13 at 12:47 +0200, Fabrizio Lamarque wrote:
> On Thu, Apr 13, 2023 at 12:13=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.=
com> wrote:
> >=20
> > On Thu, 2023-04-13 at 10:36 +0200, Fabrizio Lamarque wrote:
> > > ---
> > > =C2=A0.../bindings/iio/adc/adi,ad7192.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 28 +++++++++++++++----
> > > =C2=A0drivers/iio/adc/ad7192.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 18 ++++++------
> > > =C2=A02 files changed, 32 insertions(+), 14 deletions(-)
> > >=20
>=20
> > You should not mix bindings changes with driver changes... They should =
go in
> > separate patches.
>=20
> > +=C2=A0 adi,clock-xtal:
> > +=C2=A0=C2=A0=C2=A0 description: |
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This bit selects whether an external cr=
ystal oscillator or an
> > external
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock is applied as master (mclk) clock=
. It is ignored when clocks
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 property is not set.
> > +=C2=A0=C2=A0=C2=A0 type: boolean
> > +
>=20
> It looks like you could use a dependency... Grep for "dependencies:" in t=
he
> bindings folder.
>=20
> > > -=C2=A0=C2=A0=C2=A0 st->avdd =3D devm_regulator_get(&spi->dev, "avdd"=
);
> > > -=C2=A0=C2=A0=C2=A0 if (IS_ERR(st->avdd))
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(st->avdd);
> > > +=C2=A0=C2=A0=C2=A0 st->vref =3D devm_regulator_get(&spi->dev, "vref"=
);
> > > +=C2=A0=C2=A0=C2=A0 if (IS_ERR(st->vref))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->vref =3D devm_regulat=
or_get(&spi->dev, "avdd");
> > > +=C2=A0=C2=A0=C2=A0 if (IS_ERR(st->vref))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(st->vref);
> > >=20
> > I'm also not sure this will work as you expect. If no regulator is foun=
d,
> > you'll
> > still get a dummy one which means you won't ever reach the point to get
> > "avdd".
> > Look here:
> >=20
> > https://elixir.bootlin.com/linux/latest/source/drivers/regulator/core.c=
#L2137
> >=20
> > So I guess you could devm_regulator_get_optional() for "vref" and then =
move
> > forward to look for "avdd" if you get -ENODEV from the first call. But =
using
> > devm_regulator_get_optional() like this is really an __hack__ and not h=
ow
> > it's
> > supposed to be used. So maybe this is cumbersome enough to just let it =
be as
> > before? You can just update the description in the bindings.
> >=20
> > - Nuno S=C3=A1
>=20
> You are right. I missed it.
> I kindly ask you to confirm if, as per your suggestion, I should send
> a v3 patch series with the proper "fixes" tag and this last one
> changed as follows:
>=20
> =C2=A0- No changes on driver side (keep avdd-supply instead of vref-suppl=
y)
> =C2=A0- Indicate in bindings documentation that avdd-supply is vref inste=
ad
> (with the "Phandle to reference voltage regulator")
> =C2=A0- Add dependencies to yaml bindings
>=20

Yeps, but note that for the bindings patch you are making distinct changes =
(
adding missing properties and changing one) so someone might complain. But =
for
me, personally, they are simple enough that can go in one patch. Just prope=
rly
document it in the commit description.

> Thank you for your patience and for having this one reviewed again.
>=20

Sure, I also like to have my patches reviewed :)

- Nuno S=C3=A1

