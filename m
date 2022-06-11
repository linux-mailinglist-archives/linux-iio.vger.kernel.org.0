Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DC05475CB
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jun 2022 16:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbiFKOuG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jun 2022 10:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiFKOuF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2022 10:50:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D7D5584;
        Sat, 11 Jun 2022 07:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0D2D60FF7;
        Sat, 11 Jun 2022 14:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC62CC34116;
        Sat, 11 Jun 2022 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654959004;
        bh=LX+rtX5P3mKqmVMa/tJgwQ4uwQTtTzZC0lJMO9c+uKY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NozNRnZ9eVVMlh3i/YFnXyveVGFVoLy0j6zJGUcdi8rJ4t2MDdOBT4MXOdmzJVbc1
         ZIKXXfLH89Q8gM33/AvmEkMy7rRJRm4wLuFmzjkNryddMmxJ0F2puXoi1DHkqKnEe7
         BMw3tDXb1LdjCJv0ZwsNznU5FKt/MnWP7qW7wg4BxhiFAu9Kgcsl40fmseyFCTpUIr
         irqOYi+V8FtnEYrtIDDJq5R6/OmDksOY9wgPTCNXsn8yQGMxmJq3ghGfhFOXEXv/SZ
         8mQiUM2KswJhVPFAsaXxGO2zwsjGSn8/KxZl6/iv+Lc9WGRXVQ578HMjv3GoAbU3KS
         d8lBUX9EjQXSA==
Date:   Sat, 11 Jun 2022 15:59:02 +0100
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 20/34] iio: inkern: only relase the device node when
 done with it
Message-ID: <20220611155902.2a5a7738@jic23-huawei>
In-Reply-To: <ef73aa5801ae1c8078e6a930f22feb6214038176.camel@gmail.com>
References: <20220610084545.547700-1-nuno.sa@analog.com>
        <20220610084545.547700-21-nuno.sa@analog.com>
        <CAHp75VcdwjTYDF2c-StsL7-pLKtV3vGxinX8+1nJydqB_WNXiA@mail.gmail.com>
        <ef73aa5801ae1c8078e6a930f22feb6214038176.camel@gmail.com>
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


+Cc Mark Brown for a query on ordering in device tree based SPI setup.

On Fri, 10 Jun 2022 22:08:41 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2022-06-10 at 16:56 +0200, Andy Shevchenko wrote:
> > On Fri, Jun 10, 2022 at 10:48 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrot=
e: =20
> > >=20
> > > 'of_node_put()' can potentially release the memory pointed to by
> > > 'iiospec.np' which would leave us with an invalid pointer (and we
> > > would
> > > still pass it in 'of_xlate()'). As such, we can only release the
> > > node
> > > after we are done with it. =20
> >=20
> > The question you should answer in the commit message is the
> > following:
> > "Can an OF node, attached to a struct device, be gone before the
> > device itself?" If it so, then patch is good, otherwise there is no
> > point in this patch in the first place.
> >  =20
>=20
> Yeah, I might be wrong but from a quick look... yes, I think the node
> can be gone before the device. Take a look on the spi or i2c of_notify
> handling and you can see that the nodes are get/put on the add/remove
> notifcation. Meaning that the node lifespan is not really attached to
> the device lifespan. If it was, I would expect to see of_node_put() on
> the device release() function...

I had a look at spi_of_notify() and indeed via spi_unregister_device()
the node is put just before device_del() so I agree that at first glance
it seems like there may be a race there against the useage here.
Mark (+CC) out of interest why are the node gets before the device_add()
in spi_add_device() called from of_register_spi_device() but the matching
node puts before the device_del() in spi_unregister_device()?
Seems like inconsistent ordering...

Which is not to say we shouldn't fix the IIO usage as this patch does!

>=20
> Again, I might be wrong and I admit I was not sure about including this
> patch because it's a very unlikely scenario even though I think, in
> theory, a possible one.

The patch is currently valid even if it's not a 'real' bug.
Given we are doing a put on that device_node, it makes sense for that
to occur after the local use has finished - we shouldn't be relying on
what happens to be the case for lifetimes today.

Now, I did wonder if any drivers actually use it in their xlate callbacks.
One does for an error print, so this is potentially real (if very unlikely!)

This isn't a 'fix' I'd expect to rush in, or necessarily backport to stable
but I think it's a valid fix.

Perhaps add a little more detail to the patch description for v2.

Thanks,

Jonathan


>=20
> - Nuno S=C3=A1
>=20

