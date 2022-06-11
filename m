Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5235B547576
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jun 2022 16:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiFKONw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jun 2022 10:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiFKONd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2022 10:13:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39F564D25;
        Sat, 11 Jun 2022 07:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72ACEB80B78;
        Sat, 11 Jun 2022 14:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A775DC34116;
        Sat, 11 Jun 2022 14:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654956804;
        bh=nyZvL91oFCb9bthQSadgYmYYNFgPdHqKzIod7PSvXoE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C2tuo46TtbrdY2D19m2dgc8qWZXkB9kD9XOOUf+g2P6r7or/YShlN3zfieoRbi1Vk
         mRI7PO6xQMBBZDFZ33JtIn/6IVQn/VTxVQXaJO1ADbDwlQfv3ugfoK+SZ2wWPnkBEe
         NQN0YnkPwxplxSwb5TPXK7nCa4EcaM5XEQsCru/WIGnRxSEQ5MOC6fJr8zRFIfBTyu
         tLwN+T41I7UHRhABICFeESgCC5Pk7w7sag45jDCofg7ENDt7w2JsMMV2UnrL0YRNvo
         0EPVDiII3hAp7sPmFQsLP0zYudeuY2ortQ78I2x55E+QAmRNr9FxfNDMWR9mLxN2JJ
         ED2zAMUfpL0uQ==
Date:   Sat, 11 Jun 2022 15:22:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        dl-linux-imx <linux-imx@nxp.com>,
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
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 15/34] iio: humidity: hts221_buffer: explicitly add
 proper header files
Message-ID: <20220611152222.43ab685e@jic23-huawei>
In-Reply-To: <CAHp75VdCrFa67_k3TJSznT0fzEK3h3+fk0MHpuwM6NBpTQODEw@mail.gmail.com>
References: <20220610084545.547700-1-nuno.sa@analog.com>
        <20220610084545.547700-16-nuno.sa@analog.com>
        <CAHp75VdCrFa67_k3TJSznT0fzEK3h3+fk0MHpuwM6NBpTQODEw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Jun 2022 16:47:16 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jun 10, 2022 at 10:47 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >
> > Do not trust the fact that iio.h includes of.h which in turn includes
> > all the headers we are relying on.
> >
> > The ultimate goal is to actually drop of.h from iio.h. =20
>=20
> ...
>=20
> >  #include <linux/irqreturn.h>
> >  #include <linux/regmap.h>
> >  #include <linux/bitfield.h>
> > +#include <linux/property.h> =20
>=20
> Yes, I see, but you can make life easier if you try to squeeze to the
> most sorted part. I do not see full context, but here I would put it
> before regmap.h.
>=20
With full context it's clear the list is way off sorted, but meh
putting it above regmap probably reduces the follow up diff a tiny
bit and I doubt Nuno feels strongly about this so I went with
what Andy suggested as a tweak whilst applying.

Applied

Thanks,

Jonathan

