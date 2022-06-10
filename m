Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC125468FD
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 17:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiFJPG0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 11:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiFJPGZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 11:06:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7873621CBE3;
        Fri, 10 Jun 2022 08:06:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bg6so34231835ejb.0;
        Fri, 10 Jun 2022 08:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rmSZhFt+L2EkdTfA4PhCKlZgd+Ko2Rb6WSrQZb1cOCI=;
        b=qCr8IJLDkZnLtvz4aw+Xn5xelUdctRwoMbU2miyXWPJSzLZTJK2NeLG1JzUB9nU2nE
         5/RMCchvqx1ozjmNfNiBY4sJPZPjH7Ea5MpV7IYxt94+qFzIQuzmrr/zYYAP+dIEnmfQ
         0fNqjCzWxWfSnGY9kbiR2idz19Ic+Z0cFo4bKxJeyYNHmLilyZVs6SAOptiXPyxSMutY
         Q7ONB7ISiyNGWXXWBalOU8nD+18nZBZ9WdCwlSDCAAdrCEX08bVOGzs/5dUYND/pccgd
         ragBkS8mjJZY0gn+bjB5N+tuF1Ez2mGm8CSLoHNzEXhhSe1/Zmu/grPIAqadHgCBJWvt
         dswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rmSZhFt+L2EkdTfA4PhCKlZgd+Ko2Rb6WSrQZb1cOCI=;
        b=vgo1X/qjtQ6G9R8LRZMgn2JHzPyCF+OG/PerUsd/gwGxy7WOkzWrEt77MYpxtPHFxt
         XRdpuOBs44YwvQpKtX0AHfd+ONn0OyCb2AimuqUTQ+YhXuVONy+O06rlJ843siroz41e
         u+GTG0c/vUd9AOOmB5BOq0ZafRQJ+veDk5ngAjCDWeJxVT/t0LuMhseicGdosDT34dkS
         vf9MJNvTZ7USKuqokqnb/ZNnpthED+cCwG89xrID8aRtsIxjovB/aC+8kiPWfZQEiz+Z
         BIKzKVL2+rQEO5crw7gNphkCE5cwudiyj6hO9iq2uEMfRq9yt1M2hScwE7z5BDzWyRKt
         TBvQ==
X-Gm-Message-State: AOAM530IUO/XGPNEro+G8iNaDY+3pQy2wtpGHt5gKvyNqN8FdJk/P+vY
        J7DkUAJhsCizAK3NegZN7nyvgtbTtRU1Suk6LWs=
X-Google-Smtp-Source: ABdhPJxLQGYHGj7gcyVcctXCwCgpnEr2cRyaoQ3/TTAEPMeK3HCToHy6/n79bgCvIjvr7StG2KRTs/e28PmBV+zKUAU=
X-Received: by 2002:a17:906:c7c1:b0:711:d2e9:99d0 with SMTP id
 dc1-20020a170906c7c100b00711d2e999d0mr23093435ejb.639.1654873582571; Fri, 10
 Jun 2022 08:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220610084545.547700-1-nuno.sa@analog.com> <20220610084545.547700-23-nuno.sa@analog.com>
In-Reply-To: <20220610084545.547700-23-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jun 2022 17:05:45 +0200
Message-ID: <CAHp75VcPoZ4FKTwDN_F76EZAcWYzAe1CHmuRuaP0wg3BgmPtfA@mail.gmail.com>
Subject: Re: [PATCH 22/34] iio: inkern: only return error codes in
 iio_channel_get_*() APIs
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        chrome-platform@lists.linux.dev,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Benjamin Fair <benjaminfair@google.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Benson Leung <bleung@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Patrick Venture <venture@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Nancy Yuen <yuenn@google.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 10, 2022 at 10:48 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> APIs like of_iio_channel_get_by_name() and of_iio_channel_get_all() were
> returning a mix of NULL and error pointers being NULL the way to
> "notify" that we should do a "system" lookup for channels. This make
> it very confusing and prone to errors as commit dbbccf7c20bf
> ("iio: inkern: fix return value in devm_of_iio_channel_get_by_name()")
> proves. On top of this, patterns like 'if (channel !=3D NULL) return chan=
nel'
> were being used where channel could actually be an error code which
> makes the code hard to read.

...

>                 np =3D np->parent;
>                 if (np && !of_get_property(np, "io-channel-ranges", NULL)=
)
> -                       return NULL;
> +                       return chan;

Shouldn't it return a dedicated error code and not some arbitrary one?
It may be I missed something and chan has a correct error code in this
case...

...

> +       if (nummaps =3D=3D 0)       /* return -ENODEV to search map table=
 */

Comment is superfluous, the next line is self-explaining.

> +               return ERR_PTR(-ENODEV);

...

> -               if (channel !=3D NULL)
> +               if (!IS_ERR(channel) || PTR_ERR(channel) =3D=3D -EPROBE_D=
EFER)

Btw, in the GPIO library we have a macro or inliner (don't remember)
that represents such a conditional.
Perhaps make it (if it's a macro) global, or introduce an inline in IIO?

Okay, it's here:
https://elixir.bootlin.com/linux/v5.19-rc1/source/drivers/gpio/gpiolib.h#L1=
79

It's similar, but not the same, so just play with an idea to introduce
something in this file, maybe it's worth doing this, maybe not.

--=20
With Best Regards,
Andy Shevchenko
