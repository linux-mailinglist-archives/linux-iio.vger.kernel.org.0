Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADAA547B49
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jun 2022 19:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiFLRqB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 12 Jun 2022 13:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiFLRqA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jun 2022 13:46:00 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138B5E09E;
        Sun, 12 Jun 2022 10:45:59 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id n24-20020a4ae758000000b0041b82638b42so830796oov.9;
        Sun, 12 Jun 2022 10:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xNhFuNm1nmnzKrxqQuO4XyzP0cAuS/p9Ps9ar4/pkNA=;
        b=rBZpEbtDe9ogwyCl5aKAZeYuIeFNbLxCFj+voN3oYfsgr566qS87dpaPHK61BPXfxI
         GYnatewn+qcvJEEKu3KkF6IMOxBJRhkP5lC8dQ/deQmpD/gyU1Rfk+mqInUhUIv+/Qrw
         QDYivWpLJ4tTyT/SRUzMZ0eJk22aMNXnWqhoGgETmthCDGKYW8rJNSv4UWSzjVBqTQ0Y
         rT5C2TCjbs5AQJ6cj1CDgpc/OzzqoqefVXK8uIyCtep5kk5985JECfRXQ7xJaudofEbH
         ChwADx3hH89+7Q+cLlaY+UN2urLJW6SA3JQliOE76PVLhrjRb54wkjO5dnAgub5ll59w
         FhBQ==
X-Gm-Message-State: AOAM531JT+vGRTMVIQYtjL9BzYb6Sai4poqdMp/RMmkpHezbEZwLZCBo
        PUaYOWLxkZdTXnHjoaoGnckJLguEY7aipw==
X-Google-Smtp-Source: ABdhPJwAWF2Xwa4TwmfvQzub7spRW+GbwStg9EvmhgcPkRgW1jN+HOg7DXvyIpG8QMnMcBHrsrBjyA==
X-Received: by 2002:a4a:d984:0:b0:329:a95a:d492 with SMTP id k4-20020a4ad984000000b00329a95ad492mr22457099oou.61.1655055958282;
        Sun, 12 Jun 2022 10:45:58 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id r9-20020a056830134900b0060afaae0e34sm2460700otq.0.2022.06.12.10.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 10:45:58 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id a8-20020a05683012c800b0060c027c8afdso2984239otq.10;
        Sun, 12 Jun 2022 10:45:58 -0700 (PDT)
X-Received: by 2002:a81:4811:0:b0:30c:8021:4690 with SMTP id
 v17-20020a814811000000b0030c80214690mr60597100ywa.47.1655055588159; Sun, 12
 Jun 2022 10:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220610084545.547700-1-nuno.sa@analog.com> <20220610084545.547700-35-nuno.sa@analog.com>
 <YqNo6U8r80aNFzUr@spruce> <d083dd2c7e9e6eefb32124648a06799a9ebe8dfd.camel@gmail.com>
In-Reply-To: <d083dd2c7e9e6eefb32124648a06799a9ebe8dfd.camel@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 12 Jun 2022 19:39:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXtLQOo2fiTHA-CBgWZE0hbPVUzv77sKrf_Qz8oHp7bkA@mail.gmail.com>
Message-ID: <CAMuHMdXtLQOo2fiTHA-CBgWZE0hbPVUzv77sKrf_Qz8oHp7bkA@mail.gmail.com>
Subject: Re: [PATCH 34/34] iio: inkern: fix coding style warnings
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     Joe Simmons-Talbott <joetalbott@gmail.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        chrome-platform@lists.linux.dev,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-iio@vger.kernel.org, openbmc@lists.ozlabs.org,
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Nuno,

On Fri, Jun 10, 2022 at 9:52 PM Nuno Sá <noname.nuno@gmail.com> wrote:
> On Fri, 2022-06-10 at 11:53 -0400, Joe Simmons-Talbott wrote:
> > On Fri, Jun 10, 2022 at 10:45:45AM +0200, Nuno Sá wrote:
> > > Just cosmetics. No functional change intended...
> > >
> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>

> > > --- a/drivers/iio/inkern.c
> > > +++ b/drivers/iio/inkern.c
> > > @@ -45,13 +45,13 @@ int iio_map_array_register(struct iio_dev
> > > *indio_dev, struct iio_map *maps)
> > >         int i = 0, ret = 0;
> > >         struct iio_map_internal *mapi;
> > >
> > > -       if (maps == NULL)
> > > +       if (!maps)
> > >                 return 0;
> > >
> > >         mutex_lock(&iio_map_list_lock);
> > > -       while (maps[i].consumer_dev_name != NULL) {
> > > +       while (!maps[i].consumer_dev_name) {
> >
> > Shouldn't this be?:
> > while (maps[i].consumer_dev_name) {
>
> Ups... Nice catch! I was probably in bot mode already.

When making a change with no functional change intended, it is always
a good idea to compare the generated assembler before/after.  I.e.

    make drivers/iio/inkern.s
    mv drivers/iio/inkern.s drivers/iio/inkern.s.orig
    [make your change]
    make drivers/iio/inkern.s
    diff -u drivers/iio/inkern.s{.orig,}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
