Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150FD570458
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jul 2022 15:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiGKNdc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jul 2022 09:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGKNdb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2022 09:33:31 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E118E;
        Mon, 11 Jul 2022 06:33:30 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31d7db3e6e5so18357997b3.11;
        Mon, 11 Jul 2022 06:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RQwilQfI/adDo9s97R0fAFu247sWntEmkcOlLUrzmwo=;
        b=e25Ptdx+BdRNZeRkxgFp/iHvgBc6IBcweUa8B2jlTvKLiVqyJQJfMGti/8p+8qB5HQ
         yPoI+6CajM35ns+P98l88f/GR+baEOdC1/8HJLLNDKp93L/MA/2iuLd7Yuwc5ut6YjEv
         JSlVxwxCvNlJCYEVCEE7VspV5kOhs7lhJmVEP0XTIzKiP6p4zljgpeNZld8mjAO17C03
         EJOoClA0+qbZPUmXPrh7GdpLSKi28HSj5rSFJ+Se4yeT/998AA0g1y7YeibrBcqb2Dkd
         FcexyLq+JlU/3YdreGmIDl9+qQr97oEzJ2pTVBs9yN4TeGJ2pvJIXMbVmgiAYE1E43XS
         1XGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RQwilQfI/adDo9s97R0fAFu247sWntEmkcOlLUrzmwo=;
        b=32qRQjejauPFOVK4CIHYohFX5LSBYRWN6vgm/BTwV8imJ/k0lBoJW73+Bb0D+5CKEB
         5ddGRikZ963j3jgTNk88f5fzOwzExY7HqQQ6BG0k3UJplRR+0oWmQ2PSO5/Yucddu2cM
         8uVW6qER3FN7kw8QfC06il/hIV8ZP5AMnV5On6IbKjLoLWv1cPVyIs2J7QzDqH7K/Uq3
         e0cVBrK+qTa2gCNTaHYMiwExQ1khqnRHpsOMx0i1/mhgeIIKrzc+j4cecAYTGvxv0KQB
         h7Ljr8q8d2+kuwqbLXM/LaSrrN6aRKDJ6gMBMNUByhDyWRqeKwqRqqHk+EOcHHC9YjE8
         KUYA==
X-Gm-Message-State: AJIora+ukGfg7FBytWbrmYzyWL3dRB5ZaeyW83AW4uSJU/8OfxBOPr4v
        U1Ov+BHXYhaJN1m+tLjWS+Rj5BbMb2zsUrmfSWU=
X-Google-Smtp-Source: AGRyM1vwFLTnD43GPFTgMLTlXqUGdlI71lJPoTCRuiV/S15q+5KKdFYTwkQcKTfOBN8LuvnS9zGKXXrKLTRdthklF8Q=
X-Received: by 2002:a81:8397:0:b0:31c:8a02:3f6d with SMTP id
 t145-20020a818397000000b0031c8a023f6dmr19617833ywf.486.1657546409819; Mon, 11
 Jul 2022 06:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220711123835.811358-1-nuno.sa@analog.com> <20220711123835.811358-16-nuno.sa@analog.com>
 <CAHp75VcnuAtc+n+nhQ16yP9S-veX2c6ruquSewtPJdcqQwpyAQ@mail.gmail.com> <OS0PR01MB592214D4F12E0636DB7B98CD86879@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592214D4F12E0636DB7B98CD86879@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 15:32:53 +0200
Message-ID: <CAHp75Ve1mAj9u3rVU7qseZ-MYw_PDjAAFA+69XeRv_pvEW-ZrQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/15] iio: inkern: fix coding style warnings
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Andy Gross <agross@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Fabio Estevam <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Patrick Venture <venture@google.com>,
        Amit Kucheria <amitk@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 11, 2022 at 3:28 PM Biju Das <biju.das.jz@bp.renesas.com> wrote=
:
> > Subject: Re: [PATCH v2 15/15] iio: inkern: fix coding style warnings
> > On Mon, Jul 11, 2022 at 2:40 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote=
:

...

> > > -       if (name =3D=3D NULL && channel_name =3D=3D NULL)
> > > +       if (!name && !channel_name)
> > >                 return ERR_PTR(-ENODEV);
> >
> > After this change in place, I think it's better to convert it to
> >
> >   if (!(name || channel_name))
>
> It should be name && channel_name
>
> See below.
>  (! ( 1 || 0)->  (! (1 && 1)

I didn't get what you are implying here. Please, check again what's in
the original code and what's being suggested.

> > which shows intentions clearer.

--=20
With Best Regards,
Andy Shevchenko
