Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147FE66D8BA
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 09:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbjAQIyC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 03:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbjAQIx6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 03:53:58 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A72DE;
        Tue, 17 Jan 2023 00:53:56 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id n2so5311323qvo.1;
        Tue, 17 Jan 2023 00:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dseOSX2zTH+XeCQ35kHO/8kj0vzRJ47S5eW+pnauFVw=;
        b=IN1tCeVLnwqol5mOOyaSKxyI6kXzBL3oblSeLXVIqXyUFgWIwbZ0AEzA8olwW7upIy
         FObicSGhLmkCghdvzFXSEJAyGxharJCShW7z0r+lEuvRAdFgw/Mxnef/EERBExtq8sMy
         Mcp+PQsHnyA392QlG4twkaHS5FodAKoH3B3yaJJT0FBlqe7JmvyILW6DXybR86bCuoQC
         UqoyUTTaZe3pVph9PjUnNC+gdZK/JhrtzzJA5+OSVpLY72U3uaJRq46DnYklrCW6khCa
         fPiWIzKX0q18Q1gHryK2/LjCQP56sP8q10LYVdVfp1q/DwJiFCOzLG6iIT0dwfrQWPTz
         2MNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dseOSX2zTH+XeCQ35kHO/8kj0vzRJ47S5eW+pnauFVw=;
        b=n8bRI6JqpsDSEQxyHPc4WQPeZ6rxoE102ECGULl2fW5J6aiOE9Aftnft12RLQrLHtX
         eGM1/BJjPN4QPoacz8w9s2tyWlC0bQOLNI4HrGyI7pPX7Q49j304im/p0kh72Lblf+hH
         CKzZbsjCmkZPeCdXCi4+m4EY+0iQFUkpo93EDAocpw4IgplmoW+qveNCs2tRsp9fRgRW
         O2STvImyweOuJEi89whapRIzqxxm/qxJ3kvEM11tbS4Lg+qYq5jSUuieBYtZMS4I5Z4V
         vHjrYMXrXO4yyPZMh3DKs3S7t+11u6lT0WKbeeRIje/bxhyg0DZsm/By6mUcraymVwy8
         rFtw==
X-Gm-Message-State: AFqh2kor6XIouqN8K0Z4U2ba1h/WaEM0ZI5Y5o1Xz03Jjb5msL6mGjB1
        4yLH4z3KxfrBvzIyM7v0YzifjlW9BZtmY2iQlAU=
X-Google-Smtp-Source: AMrXdXvLiqXj9jIN/w78ICHR0nICmfROd8xLwBZS8MBQVeGvCEuFhhD92MzOr0asWEhyUaMDPd3N/hzGbdM64AxxTSk=
X-Received: by 2002:a0c:f6c2:0:b0:532:2dd4:fea3 with SMTP id
 d2-20020a0cf6c2000000b005322dd4fea3mr144148qvo.48.1673945635919; Tue, 17 Jan
 2023 00:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20220715122903.332535-1-nuno.sa@analog.com> <20220715122903.332535-13-nuno.sa@analog.com>
 <20220806192048.0ca41cc5@jic23-huawei> <20230116204452.il4gase2szipeexz@SoMainline.org>
In-Reply-To: <20230116204452.il4gase2szipeexz@SoMainline.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 17 Jan 2023 10:53:19 +0200
Message-ID: <CAHp75VdX9sFgn9STyzwcDCK1KYbU00ejFNcEP3FVnLk5J=Pktg@mail.gmail.com>
Subject: Re: [PATCH v3 12/15] iio: adc: qcom-spmi-adc5: convert to device properties
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        openbmc@lists.ozlabs.org, linux-imx@nxp.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-iio@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        chrome-platform@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-msm@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Fair <benjaminfair@google.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Patrick Venture <venture@google.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Nancy Yuen <yuenn@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Avi Fishman <avifishman70@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Guenter Roeck <groeck@chromium.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jan 16, 2023 at 10:44 PM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On 2022-08-06 19:20:48, Jonathan Cameron wrote:
> > On Fri, 15 Jul 2022 14:29:00 +0200
> > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >
> > > Make the conversion to firmware agnostic device properties. As part o=
f
> > > the conversion the IIO inkern interface 'of_xlate()' is also converte=
d to
> > > 'fwnode_xlate()'. The goal is to completely drop 'of_xlate' and hence=
 OF
> > > dependencies from IIO.
> > >
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > +CC Marijin who happend to post a patch for this driver that I just acc=
epted
> > and hence probably has hardware access.  Any chance of a test for this =
series?
> >
> > If not, no problem as this is fairly mechanical and we have testing on =
some of
> > the other drivers using the new code.
> >
> > I'll probably queue this up in the meantime but it won't end up upstrea=
m
> > for a few weeks yet.
>
> Jonathan,
>
> This CC just surfaced in my inbox while searching for our current
> discussion around missing labels in qcom-spmi-vadc - and on the side a
> userspace @xx label name ABI break (in qcom-spmi-adc5) caused by this
> patch's fwnode_get_name change - we could've caught it if I had not
> accidentally marked it as read and/or forgot about it.  My apologies.

Does the following addition to the top of the
adc5_get_fw_channel_data() fix the issue?

+       name =3D devm_kasprintf(adc->dev, GFP_KERNEL, "%pfwP", fwnode);
+       if (!name)
+               return -ENOMEM;

--=20
With Best Regards,
Andy Shevchenko
