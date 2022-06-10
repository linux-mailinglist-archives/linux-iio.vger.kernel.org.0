Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1EA5468B1
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 16:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiFJOqa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 10:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344435AbiFJOp5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 10:45:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D571C4240;
        Fri, 10 Jun 2022 07:45:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u12so53943326eja.8;
        Fri, 10 Jun 2022 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KoDE34zocTcx3MPzWCnR4QwZS2ytF1uI72CoiLyAcyQ=;
        b=cPMR1qwhgBciQ4QuFRIqiyeHmWI4Ln4CHN421omnkh7YH9MB7rz/jhyXlDcjROB6tT
         JiSpoNNM1qEgfFc/7U9Bzbww3hRJhk8lPntDxUJBZ89txLcz/l4eIrftQGXd/SjihNQ3
         DYhEWO3cPHerQ6tMoyNMwIS+iCRH+4RQ3UEZLVQEmS5QOfbNGv833fIl2ncEf4jXl14U
         yi4+tL0c+r7c5GU8P4oAYYhsdlfSHRZE9gQECvEhxRs3N2lDYwzDcaqkKjAEBpHjgt9p
         K0sdA/V/R/iXE5p8XbseNASd66P628xRR1EgKSZHtqMGGV6sRCzr4iT7MWyT+gB6Znn7
         cYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KoDE34zocTcx3MPzWCnR4QwZS2ytF1uI72CoiLyAcyQ=;
        b=wDrtoqnXTRpv8dLCFfY+V16Aliq4Wd/Y4GllI6rseVOzempBmJ0FT7OyCKrijT7IBK
         qVAmj+NhVjidwDwmuKK0LG1ddC7XSgfFEA2ZvfIBQ0DBpf796fEmFKXZ4U0vt7V23EgU
         3sXRZTtMKTMgJ0q/JD7+jUaqt05yAUpbAIDr8VREsFsCGxz0F+7gxv0Qxdf84Bk4pay5
         ZFew3eEKaC1N9g9XFqX4b25/lSZ/y8jC0ddq2RBUv+yU52ENBM56SfXCp3cx+sdOLW1S
         fg/h/YDtZJkgl9hV8KOgjGb9lOdpHImyE+qtmuCKHeIR65Hp1RnfBfwrCT9fLpUhCE6T
         MzEw==
X-Gm-Message-State: AOAM530WrDjqBSUVTsz0Xukg5lrlj7nENB+R3jAMSCwCkLKwr0OaqLpD
        NpR75/xgcg5q6xMeTdEw1S92rFn63KWlonBh3uI=
X-Google-Smtp-Source: ABdhPJxizt9m4eKBTNu+PJtwHNsl6LS2ZuZ/AzA8lc7FGXQyzDHIdcU8VIdIbeQpqLpHnNiy07ZL4b6rgaPhYce2N3E=
X-Received: by 2002:a17:906:1193:b0:70d:cf39:a4db with SMTP id
 n19-20020a170906119300b0070dcf39a4dbmr35595214eja.44.1654872354568; Fri, 10
 Jun 2022 07:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220610084545.547700-1-nuno.sa@analog.com> <20220610084545.547700-7-nuno.sa@analog.com>
In-Reply-To: <20220610084545.547700-7-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jun 2022 16:45:07 +0200
Message-ID: <CAHp75VcU-oV4is_y9=oaOx2ugvTEOy53h2wvbd3-Z9_gv5Y=zA@mail.gmail.com>
Subject: Re: [PATCH 06/34] iio: adc: ingenic-adc: explicitly add proper header files
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

On Fri, Jun 10, 2022 at 10:46 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> Do not trust the fact that iio.h includes of.h which in turn includes
> all the headers we are relying on.
>
> The ultimate goal is to actually drop of.h from iio.h.

...

>  #include <linux/mod_devicetable.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/of.h>

Ordering (from the context I don't see it's messed up already)

--=20
With Best Regards,
Andy Shevchenko
