Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E655468C9
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 16:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349641AbiFJOtI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 10:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349558AbiFJOsS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 10:48:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AB7443C4;
        Fri, 10 Jun 2022 07:47:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b8so18927422edj.11;
        Fri, 10 Jun 2022 07:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=++QT23Kd+FIQRCrQZQe7WTN4LUSOZ4DgBVw4lFAkbv8=;
        b=YwdpHX6f3Yq7XH6KVuJEH9ag++zBILZ6r8FsafNlXSwCgT0Dl8CqFiXT7KHM8bkxLF
         Nf3apV6d4L93j7uQRUCQhfPnmHha/4rR3cl4CH0wTu2qP9AubKK84Y1/5SrnrJXh4Ahn
         IHWXMQweEAe4L6rRNL8hyvGDC+tXkCijuh7kwaC6b4zb2Fi95twp90585Rpk40WBFx5Q
         muSamB7AY2Fu4ZNvlMLB4lydiKJ0aoWk0nyFA1KImb/1g5oZTCP5Wbi/kMK06kNHl63V
         +yQuuhfrlNx/YA3zsGLwtnf8allQ3v1lUsyKJ5ydnTMsCuw9LiMm1xrT9pUSobmkyPxj
         gU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=++QT23Kd+FIQRCrQZQe7WTN4LUSOZ4DgBVw4lFAkbv8=;
        b=hlAxYgBIahCZlmn++Je1go/uOcN6Pv/OGwLGt2MCW90z+7i7mgJmm85NUKKSLav763
         Yc6fFEZ581mw84paguycCnFZqLHDgt671BIubLt5IRHjAC+nGNaodMKz99PA3C1za0+1
         wakTE72tuW7WJ2NBekTh0ZjIiIruIJzfUrsWdzhfpRrYBiHQp0Ig9xlgHKzLdXBzIbDd
         V90E1bdAnewB/VTLcMz3Zv5lMxDBlsqZmpbD6g8ORCwXg7X6PPSQkGtF3Z+Q9pU580iJ
         2+BVoT5WO/JBUFxURntj8tMv+22yFigxmBbF56rOoox0X4/gDt+BUru1jyaI42iw8s5W
         AgFg==
X-Gm-Message-State: AOAM531t8oe1dVsaB/ZVfRTxjnqk+SyvpMzETwYgU85qj2pRJRucYr+s
        Z3gizNY1y+pLqFv6BFf+3ijdkSH/gFPguiIySi8=
X-Google-Smtp-Source: ABdhPJxUxO59q0a4JvFZDrd7A8E4K6/eK/ZjPOa7JqgennKhOjFwPSMHvPp7iEiz3gXgkjUbucymQNwJhKdm75HJnyM=
X-Received: by 2002:a05:6402:4390:b0:42e:b7e:e9ac with SMTP id
 o16-20020a056402439000b0042e0b7ee9acmr50565604edc.97.1654872475078; Fri, 10
 Jun 2022 07:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220610084545.547700-1-nuno.sa@analog.com> <20220610084545.547700-16-nuno.sa@analog.com>
In-Reply-To: <20220610084545.547700-16-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jun 2022 16:47:16 +0200
Message-ID: <CAHp75VdCrFa67_k3TJSznT0fzEK3h3+fk0MHpuwM6NBpTQODEw@mail.gmail.com>
Subject: Re: [PATCH 15/34] iio: humidity: hts221_buffer: explicitly add proper
 header files
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 10, 2022 at 10:47 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> Do not trust the fact that iio.h includes of.h which in turn includes
> all the headers we are relying on.
>
> The ultimate goal is to actually drop of.h from iio.h.

...

>  #include <linux/irqreturn.h>
>  #include <linux/regmap.h>
>  #include <linux/bitfield.h>
> +#include <linux/property.h>

Yes, I see, but you can make life easier if you try to squeeze to the
most sorted part. I do not see full context, but here I would put it
before regmap.h.

--=20
With Best Regards,
Andy Shevchenko
