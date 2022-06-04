Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E9C53D6F1
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 15:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiFDNKh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 09:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiFDNKg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 09:10:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED2831909
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 06:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 292CBB803F5
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 13:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E8DC385B8;
        Sat,  4 Jun 2022 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654348231;
        bh=/bIFr/y8xS7t/EmL20/mJPG7N0RsP5HSwGlRbjw2Hxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c7vcw5vR7LhqHDfvqrCJqWGURLhritoP7nBetuhoFpj2CU88e9B7a2I+VY1WOrEYQ
         JJ34kVHq3s6O8jLWIZRR9ZEfQGHIiSdFPO+wFmfxsJHs9rG48PeUqC7zhR8/TbNq00
         KRo5wdMNHWsGrBVVqcxz8uiY+W/PWdFMSkm3T2LrLFqdxvSHf7IVajDke60KOQKnqD
         AyZ+sYwtz62xDTI2M+YDBf9wT5D3yP2RLBvb8keBLccpGsh6aVn82gSqohNrixWNae
         qnm8mxomTlHYT2x8G5e10kzXXcXSIN9c2JYrWtAC0CEDICXXkhxqFmIbPcigUJ6/Bg
         354VueR62kayA==
Date:   Sat, 4 Jun 2022 14:19:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
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
        Wan Jiabing <wanjiabing@vivo.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
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
        Shawn Guo <shawnguo@kernel.org>,
        Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [RFC PATCH 1/6] iio: inkern: fix return value in
 devm_of_iio_channel_get_by_name()
Message-ID: <20220604141925.129f0ffe@jic23-huawei>
In-Reply-To: <1e5b07dfa4d703ba1faff319be047fbd8b211f56.camel@gmail.com>
References: <20220602140400.213449-1-nuno.sa@analog.com>
        <20220602140400.213449-2-nuno.sa@analog.com>
        <CAHp75VftW=mR17gh=LiODYb7GyGbFFyH7pvpu-WarHL8MXjWZw@mail.gmail.com>
        <1e5b07dfa4d703ba1faff319be047fbd8b211f56.camel@gmail.com>
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

On Fri, 03 Jun 2022 14:36:15 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, 2022-06-03 at 13:16 +0200, Andy Shevchenko wrote:
> > On Thu, Jun 2, 2022 at 4:04 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:=
 =20
> > >=20
> > > of_iio_channel_get_by_name() can either return NULL or an error
> > > pointer
> > > so that only doing IS_ERR() is not enough. Fix it by checking the
> > > NULL
> > > pointer case and return -ENODEV in that case. Note this is done
> > > like this
> > > so that users of the function (which only check for error pointers)
> > > do
> > > not need to be changed. This is not ideal since we are losing error
> > > codes
> > > and as such, in a follow up change, things will be unified so that
> > > of_iio_channel_get_by_name() only returns error codes. =20
> >=20
> > ...
> >  =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 channel =3D of_iio_channel=
_get_by_name(np, channel_name);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(channel))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR_OR_NULL(channel)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (!channel)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return E=
RR_PTR(-ENODEV);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return channel;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =20
> >=20
> > Why not make it not nested, i.e. just adding two lines after the
> > existing check?
> > if (!channel)
> > =C2=A0 return -ENODEV;
> >=20
> >  =20
>=20
> I see, well yeah I guess I can do it so the diff is even smaller...

I'd prefer the way Andy suggested as well due to the slightly simpler contr=
ol
flow.

Thanks,

Jonathan

>=20
> - Nuno S=C3=A1
>=20

