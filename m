Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FDA55055E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 16:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiFROCR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 10:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244203AbiFRN5U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 09:57:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDCDE6B;
        Sat, 18 Jun 2022 06:57:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19F3B60BB1;
        Sat, 18 Jun 2022 13:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EE2C3411A;
        Sat, 18 Jun 2022 13:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655560638;
        bh=lRorEWc2KTi7z7ymOlOmHg76zQDyaFrAFstUtz9SnBg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AHFj/HFoFUUH94y50WWJJ41Nc0+xVyu0BnPz6ynMPeCuA7tW1khpFHcZOcygfpS66
         1PJdLDzuD9XLdoajYWLREwRAil3c82vDUZ1NpmJkmEvfQh8et0/u/ebN3adQ5YS49E
         8rFcodb3jxfyoQyunzWPPKvsaeSLocaZU+cQic/JV8F9tZOPKEeTIt8kcRe5ZukkUq
         tC8mkXxl1GHz/gJLiyIVLfWHvitlR6Yvz5/CJvrG8iSMlMnfArAYkQhVYGdY+V8m14
         j2OCBtwYS9BuyltkfUIfF1QkJE3GHgLcO5pM1rV3UdWaNJotY41oTuDuq5mtMGUnRq
         zduVJofRh6Ktw==
Date:   Sat, 18 Jun 2022 15:06:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-imx@nxp.com,
        linux-renesas-soc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        openbmc@lists.ozlabs.org, Cai Huoqing <cai.huoqing@linux.dev>,
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
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 22/34] iio: inkern: only return error codes in
 iio_channel_get_*() APIs
Message-ID: <20220618150624.1bfc8914@jic23-huawei>
In-Reply-To: <35e7c36c9ecbdc67698b413cf867cf19442ccfa9.camel@gmail.com>
References: <20220610084545.547700-1-nuno.sa@analog.com>
        <20220610084545.547700-23-nuno.sa@analog.com>
        <20220611161701.46a68837@jic23-huawei>
        <35e7c36c9ecbdc67698b413cf867cf19442ccfa9.camel@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Jun 2022 09:06:49 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Sat, 2022-06-11 at 16:17 +0100, Jonathan Cameron wrote:
> > On Fri, 10 Jun 2022 10:45:33 +0200
> > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >  =20
> > > APIs like of_iio_channel_get_by_name() and of_iio_channel_get_all()
> > > were
> > > returning a mix of NULL and error pointers being NULL the way to =20
> >=20
> > pointers with NULL being the way to...
> >  =20
> > > "notify" that we should do a "system" lookup for channels. This
> > > make
> > > it very confusing and prone to errors as commit dbbccf7c20bf
> > > ("iio: inkern: fix return value in
> > > devm_of_iio_channel_get_by_name()")
> > > proves. On top of this, patterns like 'if (channel !=3D NULL) return
> > > channel'
> > > were being used where channel could actually be an error code which
> > > makes the code hard to read.
> > >=20
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > ---
> > > =C2=A0drivers/iio/inkern.c | 24 +++++++++++-------------
> > > =C2=A01 file changed, 11 insertions(+), 13 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > > index 87fd2a0d44f2..31d9c122199a 100644
> > > --- a/drivers/iio/inkern.c
> > > +++ b/drivers/iio/inkern.c
> > > @@ -214,7 +214,7 @@ static struct iio_channel
> > > *of_iio_channel_get(struct device_node *np, int index)
> > > =C2=A0struct iio_channel *of_iio_channel_get_by_name(struct device_no=
de
> > > *np,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *name)
> > > =C2=A0{
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_channel *chan =
=3D NULL;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_channel *chan;
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Walk up the tree o=
f devices looking for a matching iio
> > > channel */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0while (np) {
> > > @@ -231,11 +231,11 @@ struct iio_channel
> > > *of_iio_channel_get_by_name(struct device_node *np,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0chan =3D of_iio_channel_get(np, index);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!IS_ERR(chan) || PTR_ERR(chan) =3D=3D -
> > > EPROBE_DEFER)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bre=
ak; =20
> >=20
> > This original behaviour is 'interesting'. If we get a error like -
> > ENOMEM
> > we should return it rather than carry on.=C2=A0 Do we have enough
> > knowledge
> > of possible errors here to be more explicit on when we keep looking
> > up
> > the tree?=C2=A0 I think we can get -ENOENT from
> > of_parse_phandle_with_args()
> >=20
> > That raises an interesting question on whether -ENODEV is the right
> > response
> > for the previously NULL case or is -ENOENT more consistent with other
> > of_ functions?=C2=A0 No device could be thought of as being the case th=
at
> > needs
> > to defer (in hope it turns up later) whereas no entry means it will
> > never
> > succeed. =20
>=20
> From what I could see, of_parse_phandle_with_args() either returns=C2=A0
> -EINVAL or -ENOENT. We also have the internal of_iio_channel_get()
> which can return -ENOMEM. So I guess we should only continue looking if
> we get -ENOENT?
>=20
> To be clear, do you still prefer to explicitly return -ENODEV in the
> previous NULL cases or should we honor the return code from=20
> of_parse_phandle_with_args() and just return chans (and thus ENOENT)?
You've looked at this more than me, so whilst I think -ENOENT is probably
slightly more consistent I'll go with whatever you conclude is the
best option.  Maybe add a small amount of description on what you chose
and why to the relevant patch descriptions.

Thanks,

Jonathan


>=20
> - Nuno S=C3=A1

