Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE46753CBC2
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jun 2022 16:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245203AbiFCOsl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jun 2022 10:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiFCOsk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2022 10:48:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889F627B18
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 07:48:39 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x62so10453033ede.10
        for <linux-iio@vger.kernel.org>; Fri, 03 Jun 2022 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gKgOdeh4hn7RZKv6w+AmPNJj8Cm7HVTvVAPq2v7BZis=;
        b=ZF0w2BjiZ00EWl/huBH7p58JrTm8h9o/ohyQk6nbx9HK8ljChPPtSMI8NnEoSrU0tz
         mK28KcxyzGSGiBkX2iJexHFavJ+iUG+3ytrNjRQSCerOYiwKrOnGVduL6XPM8EHQZ/KR
         gWPlLwqmT2WaGVzHnUMrm0C+KrWyTjCvf/tD5g7gVtpLwoHjIRBO6JBM1OK//pC7JZsa
         CqKy6iVz853OSybVJom0joMsbCp3jqtY4453u4cJeJZl0anEV9VnlVH+xspN/c98VDgf
         oz1hwiOd7g3tSEY2U17rSdlXw8qPKgmqxsFVG20n5hFCXNT4/LmG/rp4DFP02d/WuwAE
         uLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gKgOdeh4hn7RZKv6w+AmPNJj8Cm7HVTvVAPq2v7BZis=;
        b=yIWC8u/mdwtRNs1Y49OkNFdFFN8iAZ6HHBy2lEbnxREgmclCexKM3gtkZD1p/vuAjd
         mIR33HaEdYH06Uh33W9+KnU/lyFgfvVT1bnNM6EGanYF7sqYRTqd4CKt/eNpPwceJ4ay
         iTHtRUDSx6GI7l462LxVrndW2wL3m3WFNdYFGrC65cva4fnQg2IUOgDuJeg7cExbBDiE
         Xp7DSVDtB4nerBuF0+MzliEXecNsRbpSx7geNxhjF7zQpncBulDajvFPgsDNhm7Zmh75
         LqEHAa7iq/LCe+X4ohwUVZxtcKt2ki2DDxMOJDhKtjkVLn3LhUzXxI34bnqh5cJ/W6m1
         g0qA==
X-Gm-Message-State: AOAM531Trbj8a5WbzKOrnWKAQQEMxqNb4lF3BWCn01/l+w68XcUz319N
        vWxxz8wzLA0da2uLtM3QwrAcOzi8yO9XLwqQJu8=
X-Google-Smtp-Source: ABdhPJzytHAQUsTtP2HfDvocJoTcvjeKC++8bepZVLZUagwMqE4LKIBLb5Sy1cYVQw67BpcgZpHkUDDHwK7hqXlGn/U=
X-Received: by 2002:a05:6402:2806:b0:42b:67fc:8565 with SMTP id
 h6-20020a056402280600b0042b67fc8565mr11143193ede.230.1654267718114; Fri, 03
 Jun 2022 07:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220602140400.213449-1-nuno.sa@analog.com> <20220602140400.213449-6-nuno.sa@analog.com>
 <CAHp75VeHwqbNTMfWA03-epKaksPNgRrXh3f5hktEE0u6qjPyyw@mail.gmail.com> <543ab19106938b7655ee2877bf52c8e786c1c55a.camel@gmail.com>
In-Reply-To: <543ab19106938b7655ee2877bf52c8e786c1c55a.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 3 Jun 2022 16:48:02 +0200
Message-ID: <CAHp75VeD__cxLKoCqJGP4htqK6vtjHxcEE9w9w=PTvaa7xTv0Q@mail.gmail.com>
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

On Fri, Jun 3, 2022 at 2:51 PM Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> On Fri, 2022-06-03 at 13:52 +0200, Andy Shevchenko wrote:
> > On Thu, Jun 2, 2022 at 4:04 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

...

> > I think you may split this in an easy way, i.e. convert core to
> > fwnode, while providing inliners for of_node cases (like it's done in
> > IRQ domain) and then remove them after conversion.
>
> I see, in our case that might be really simple as we only have one user
> of devm_of_iio_channel_get_by_name() which is the only api directly
> using OF. of_iio_channel_get_by_name() has no users and all the other
> public APIs use 'struct device' so we can do the conversion
> internally...

Even better than I expected!

...

> > That said, I think what you need is to split this series to three
> > logical parts:
> > 1) shuffle header inclusions around so, iio.h will use forward
> > declaration (on driver basis);
> > 2) convert inkern.c to fwnode while providing OF wrappers
> > (to_of_node() helps);
>
> Just to be clear, we should still add an fwnode_xlate() callback? So we
> have both temporarily and if some new driver needs this interface it
> can already use it instead of of_xlate...

No, I mean to leave a callback to be OF-specific and pass fwnode with
to_of_node(). Then convert it separately either on per driver basis
(if possible and makes sense) or altogether.

> > 3) convert of_xlate (on driver basis it might be tricky, up to you).
>
> Yeah, I might see how easy it is to fully convert the drivers using
> of_xlate. If easy enough, I'll probably do it...

--=20
With Best Regards,
Andy Shevchenko
