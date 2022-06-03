Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BF253CB96
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jun 2022 16:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiFCOfW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jun 2022 10:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiFCOfV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2022 10:35:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886B35045E
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 07:35:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v19so10414680edd.4
        for <linux-iio@vger.kernel.org>; Fri, 03 Jun 2022 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w/br5zIPpAAqgbsFvy3LMXAzcpSFslCRWL1RLLSho5w=;
        b=bMEOgcRVYKvta6P+i4g59wHfpyiaED6X0+JnjPfhmMrDrEfAVt2fZeBhMfM0d3XBc3
         BTAbMOEhwakdZqdBPFc5gk6kxIxpmOyi2CN/QoYv1aOKckjmNpGopYZ2eZNR0CBXMMtL
         FCDdcoHE4E0ayfwVDRjajHTdQd8vr+SO0mTzAUH0Qrtuve/1i2rTyLL8ANn2c4oM48dX
         FxxoxqhUYbT8wxXxPxb+HmD2hMgaSFNSkdfbKAo5IhSJXVbexPNU/9UCZKnIUywYBP1a
         /NHLcSQ11kgPc0/QRa0xoFJB3Cesl1Vm6PIvogsmmA65Vw+87jaouzUsitAELAY3iKCZ
         ZTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w/br5zIPpAAqgbsFvy3LMXAzcpSFslCRWL1RLLSho5w=;
        b=eRcdRkLfR7FbSvNqgzZXLiaPUUuiUZPhefe60E0M5ei7/htyClxaS06ScccOePiPVU
         l2XZzSHniudySfVkLgcv3KN+EFFk74rxAHc7ck72ul4rrT+LMTL7dRsJNSCpP7OXCxMu
         q7a6DOPocr6x02IsQ4lHycXcEJxtn3gLCkaNYLmlstwHkv1HpXGKyOQbcC3btpp7t4gi
         gLUcgOpvf4K6DqGZTeLBI5z622wakFZl46Dg4Nh3h1OzG2H+/eQxb+VD3n3Y/5mOnNBu
         7Mx43AKOxNgwVPNmhzv201ccTUSL9KiLUXlBWr6aIA+vTRZXRUWK9tTsFDH5yWmIs5mB
         O28Q==
X-Gm-Message-State: AOAM533iOLScKZ7DWqPcY9FtM1tlWpQ5RZdRDOeoEAFKTdMfzHm7InUI
        h/pfkq00NR/KN88m8e1l/ZX2SsLiVaoh6pDEhMc=
X-Google-Smtp-Source: ABdhPJyzZWjZxRak5HVl9ylACVR2XvJxAF39HLv0gjZpleBmVAZDd/SoPpC+jbEnI28f2YUcmMbpdZsRrwDuBqtmZhg=
X-Received: by 2002:a05:6402:4390:b0:42e:b7e:e9ac with SMTP id
 o16-20020a056402439000b0042e0b7ee9acmr9845735edc.97.1654266918078; Fri, 03
 Jun 2022 07:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220602140400.213449-1-nuno.sa@analog.com> <20220602140400.213449-6-nuno.sa@analog.com>
 <CAHp75Vc5DzQTd8hOydc5jn8BUGQFf=06Sad749387TYuHTTxew@mail.gmail.com> <46d4d0062324846faf65c697dcb10e4e53305edf.camel@gmail.com>
In-Reply-To: <46d4d0062324846faf65c697dcb10e4e53305edf.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 3 Jun 2022 16:34:42 +0200
Message-ID: <CAHp75Vcy7hv7N3uqaXcs9sZNSpQTMAkb-GQH=+yg6mBNUyJzkA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] iio: inkern: move to fwnode properties
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Nancy Yuen <yuenn@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Patrick Venture <venture@google.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Shawn Guo <shawnguo@kernel.org>
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

On Fri, Jun 3, 2022 at 2:53 PM Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> On Fri, 2022-06-03 at 13:57 +0200, Andy Shevchenko wrote:
> > On Thu, Jun 2, 2022 at 4:04 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

...

> > > +       parent =3D fwnode_get_parent(fwnode);
> > > +       while (parent) {
> >
> > > +               parent =3D fwnode_get_next_parent(parent);
> > >         }
> >
> > Forgot to mention:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D87ffea09470d94c93dd6a5a22d4b2216b395d1ea
>
> I did looked for something like that but it's still not in the IIO
> testing tree.

Now it's in the upstream, which means it is just a matter of time to
appear in IIO testing.

> (still I actually followed that patchset but completely forgot about
> the helper)

--=20
With Best Regards,
Andy Shevchenko
