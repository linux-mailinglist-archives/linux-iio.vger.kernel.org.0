Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE0C5703E3
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jul 2022 15:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiGKNKX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jul 2022 09:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiGKNKU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2022 09:10:20 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2A33247A;
        Mon, 11 Jul 2022 06:10:17 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31c8a1e9e33so48205987b3.5;
        Mon, 11 Jul 2022 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0ZOXSRSmgwM/8CfCPUrZ7l+OIh1asVluDdyFXnWqD8E=;
        b=dJra3IJxOrzyO+7mkYfwJM+xkVjzbjwnshtKynJEY1d9HigyxWdhK/P3oXcEKtAwf2
         n0DGV/ppHdqO8+FJPsHVKM2viLcDrzrD/8N47vVpcxI8crZMoTcyG7GabZh66TgDQt5K
         vR/OejvhThCm/ej8J+wkLbdDy4W/ha21NgDgri/u9j0L83H7+q9NKgUOANZtb3iQeb5m
         p5azi6yuxgVK5tVtUrkEqXMghbb7Ofd2Wahz6HtCDfF99Vp1EADGzIX2hVaA1X+UFnUO
         Wv0TU96HYsKm2m1KnTL59Uo73M2HzpiYTf5Uqn3AdcZn42/FTSzvlq1rPQklocqPCM7c
         omEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0ZOXSRSmgwM/8CfCPUrZ7l+OIh1asVluDdyFXnWqD8E=;
        b=B3a081mhzE+LQs0sfA2PaIQ0uHM0Zu28W6GKHanlLdazH8LU/CGHdDQ+RXNlQOyATP
         JltTV5O2wwE+9tW8gcvjvnFExKQF125NU8+gO5G+uJrtLXOb5N5YWs7vkPd/aPu6aTv6
         xtGwf3DEHaEChnye0YRHidCai8te6bbiwr+IXg7s1RycWHSdZOAGge4KCKlemdpGuum5
         zOkORcIZOAGS1+I1nEzJD3Q9sMyQ+rjgI27v+Fcyp4xE2whQS+W1g+jKfKdkiAcLhQBN
         GmwI06gZiFlAAYkjiV8LsWw7NuLfIbWMTxsCsqIrISMaWyJ/fA/FyI8OrbdFDuT7U7mP
         km0g==
X-Gm-Message-State: AJIora+Wwu0+/HFin7JSMcI8gvjX8VcytzUbGlg6uAIs40ZjrQyluprN
        cw3HkBFqPYnjEqIKpCGKIMPQdFr8JZk0UNz6ilA=
X-Google-Smtp-Source: AGRyM1u1pNjRlMbjWdZEYceQFq+a842D/zBdsYQozhXo4zH7jPGpQ6tqGeQop8qO1ntORr3Ei1MkK2BI3EBjQhr2i6c=
X-Received: by 2002:a81:4bd7:0:b0:31c:91da:5a20 with SMTP id
 y206-20020a814bd7000000b0031c91da5a20mr20757632ywa.131.1657545016097; Mon, 11
 Jul 2022 06:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220711123835.811358-1-nuno.sa@analog.com> <20220711123835.811358-2-nuno.sa@analog.com>
In-Reply-To: <20220711123835.811358-2-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 15:09:39 +0200
Message-ID: <CAHp75VfUNNAEDuxMfYeg=ZkD-nrUcnc13g+zGBLufayavm-QUw@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] iio: inkern: only release the device node when
 done with it
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
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

On Mon, Jul 11, 2022 at 2:38 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> 'of_node_put()' can potentially release the memory pointed to by
> 'iiospec.np' which would leave us with an invalid pointer (and we would
> still pass it in 'of_xlate()'). Note that it is not guaranteed for the
> of_node lifespan to be attached to the device (to which is attached)
> lifespan so that there is (even though very unlikely) the possibility
> for the node to freed while the device is still around. Thus, as there

be freed

> are indeed some of_xlate users which do access the node, a possible race
> is indeed possible.

possible ... possible.

(I would drop the first one)

> As such, we can only release the node after we are done with it.

--=20
With Best Regards,
Andy Shevchenko
