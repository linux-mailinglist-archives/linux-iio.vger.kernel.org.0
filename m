Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB48547511
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jun 2022 15:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiFKN6M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jun 2022 09:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiFKN6L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2022 09:58:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29035E92;
        Sat, 11 Jun 2022 06:58:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C788D60F25;
        Sat, 11 Jun 2022 13:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FBCC34116;
        Sat, 11 Jun 2022 13:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654955886;
        bh=nbFGh7icD9NslwLu6nhPgTSnek+SfmmZhWf7P+5Ny8A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UmWdJYYOx2uNSGz9CgyVRZf7Iz8aVNIzGSC+5v8ilWDX/MiVq9rr2PzYv+k3kImhk
         Dg5bxisg5HqmdOnOt0QDuNZzApXfOV3p8J8lXL2QeCV9gRUr0WYP6WuoiC2yG/ZiKO
         xAJyZy93UG7Fy8bPXIowGrSbP/94Q6I6rKv0j4m2XyeThYt9nLnZnVNt2IgdcBbOs9
         KCQ8Bt5th2zh1s0z3uYp3ec3Aq8Nwj4nkJVqhdZn64UEwVhx2n0FhfXD4fQT/JL3VF
         OYtYVjzewS2i7BQdTpjtQwQZFDuPtaXZxyLIvSzdC8hFjiN/x/20m2kW+u9Cl8U94A
         rMLdoTWEooFcg==
Date:   Sat, 11 Jun 2022 15:07:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
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
Subject: Re: [PATCH 06/34] iio: adc: ingenic-adc: explicitly add proper
 header files
Message-ID: <20220611150704.483ccccd@jic23-huawei>
In-Reply-To: <a67d3d01824db6376c2f15949021db4f2b6173cb.camel@gmail.com>
References: <20220610084545.547700-1-nuno.sa@analog.com>
        <20220610084545.547700-7-nuno.sa@analog.com>
        <CAHp75VcU-oV4is_y9=oaOx2ugvTEOy53h2wvbd3-Z9_gv5Y=zA@mail.gmail.com>
        <a67d3d01824db6376c2f15949021db4f2b6173cb.camel@gmail.com>
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

On Fri, 10 Jun 2022 21:49:22 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2022-06-10 at 16:45 +0200, Andy Shevchenko wrote:
> > On Fri, Jun 10, 2022 at 10:46 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrot=
e: =20
> > >=20
> > > Do not trust the fact that iio.h includes of.h which in turn
> > > includes
> > > all the headers we are relying on.
> > >=20
> > > The ultimate goal is to actually drop of.h from iio.h. =20
> >=20
> > ...
> >  =20
> > > =C2=A0#include <linux/mod_devicetable.h>
> > > =C2=A0#include <linux/mutex.h>
> > > =C2=A0#include <linux/platform_device.h>
> > > +#include <linux/property.h>
> > > +#include <linux/of.h> =20
> >=20
> > Ordering (from the context I don't see it's messed up already)
> >  =20
>=20
> Will double check on v2...

Fixed up whilst applying...

>=20
> - Nuno S=C3=A1

