Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B7B54805A
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jun 2022 09:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbiFMHWa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jun 2022 03:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiFMHW3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jun 2022 03:22:29 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA3A12AF8;
        Mon, 13 Jun 2022 00:22:28 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id q104so3791136qvq.8;
        Mon, 13 Jun 2022 00:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=t8GkcF/AscIjmYX1Ft+2LOWOMCGcc3ou443uyI/gHgM=;
        b=lgYBehJwnc7p76Sp7QYODbs+eJsn9x/aAZca0AhE5KDXVc2emmsRxjtpfkhG0ym3jF
         +YmyjmCo8KwGowRdjt9uIvuUoTlmDmEhKvtAV4CSG4hTEjA91HAM5qlNsrTQS1SRX91R
         LFvp/Mktzkcb1CVjqHCgBxNr9WvYpOAxf+96MGlGzCOnNiSwu1/E0KM1WiGropKJpSPJ
         I1FGxJQBE5G5ow1BWz+8k8tlsSYxFVWF+sox/Wak2AzR/lG0tAdRt9KAZDThpdGND1Zh
         2o8Dtj8SUUB+OwaZDXw05iMGYlfFzStAu7j7cL8cCzdwPXdi8qQXd8eBti7wRpJI/O1K
         B+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=t8GkcF/AscIjmYX1Ft+2LOWOMCGcc3ou443uyI/gHgM=;
        b=RDJI1zvk1ddPstemqmiFxWVljz6PPgUeOK8PZUdZkq8raiqqxFTt9RP6/aGr5e1Sws
         mTn9N7tAO9QEyDkJgDcGbiHEaXIShcl7gIz/2acXbI6wa0r1qtNHadzRG9P05fxHaHKQ
         cWF5KTzGGRmmRZDTczHB+CrGumDa0crxAUirxpPEDCNK/TtpddjWonORWK6o/bb5wfF8
         hR8OX2Zd7MEgAPLCszFcPZwCqYtNAwKkcYJuQd1hnwb25j6LfKZkeuRHJodHvF9qwSf4
         6nqZH3cY6odkQoCFoR5DSNqoIPxcfEZEK7DpNlTa4pPJk+aohyUvbcEJ9T5Dz+skbUXg
         ZuKA==
X-Gm-Message-State: AOAM533CxL8DbYUWnzWJBJY+KFzZAnMo1S888m2o6jYQVdt15CFv50Tr
        xaB5TJxHy+oojCH7SmEwKKg=
X-Google-Smtp-Source: ABdhPJzJwQGuL0izMZeZrCmNmnxm8u/ohN3iHcmN+Ftx1/l43JyjW+szv6Fscr1wrYk++4pmje2xJg==
X-Received: by 2002:ad4:5b81:0:b0:465:ded8:780 with SMTP id 1-20020ad45b81000000b00465ded80780mr45550533qvp.119.1655104947222;
        Mon, 13 Jun 2022 00:22:27 -0700 (PDT)
Received: from p200300f6ef062c0090c03b551078f99d.dip0.t-ipconnect.de (p200300f6ef062c0090c03b551078f99d.dip0.t-ipconnect.de. [2003:f6:ef06:2c00:90c0:3b55:1078:f99d])
        by smtp.gmail.com with ESMTPSA id y6-20020a05622a004600b002f9399ccefasm4637163qtw.34.2022.06.13.00.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 00:22:26 -0700 (PDT)
Message-ID: <d1d465f2e828642f30bc8a2bdd49e89fdfed7caf.camel@gmail.com>
Subject: Re: [PATCH 34/34] iio: inkern: fix coding style warnings
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Joe Simmons-Talbott <joetalbott@gmail.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        chrome-platform@lists.linux.dev,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-iio@vger.kernel.org, openbmc@lists.ozlabs.org,
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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
Date:   Mon, 13 Jun 2022 09:23:16 +0200
In-Reply-To: <CAMuHMdXtLQOo2fiTHA-CBgWZE0hbPVUzv77sKrf_Qz8oHp7bkA@mail.gmail.com>
References: <20220610084545.547700-1-nuno.sa@analog.com>
         <20220610084545.547700-35-nuno.sa@analog.com> <YqNo6U8r80aNFzUr@spruce>
         <d083dd2c7e9e6eefb32124648a06799a9ebe8dfd.camel@gmail.com>
         <CAMuHMdXtLQOo2fiTHA-CBgWZE0hbPVUzv77sKrf_Qz8oHp7bkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2022-06-12 at 19:39 +0200, Geert Uytterhoeven wrote:
> Hi Nuno,
>=20
> On Fri, Jun 10, 2022 at 9:52 PM Nuno S=C3=A1 <noname.nuno@gmail.com>
> wrote:
> > On Fri, 2022-06-10 at 11:53 -0400, Joe Simmons-Talbott wrote:
> > > On Fri, Jun 10, 2022 at 10:45:45AM +0200, Nuno S=C3=A1 wrote:
> > > > Just cosmetics. No functional change intended...
> > > >=20
> > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> > > > --- a/drivers/iio/inkern.c
> > > > +++ b/drivers/iio/inkern.c
> > > > @@ -45,13 +45,13 @@ int iio_map_array_register(struct iio_dev
> > > > *indio_dev, struct iio_map *maps)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i =3D 0, ret =3D 0;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_map_internal =
*mapi;
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (maps =3D=3D NULL)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!maps)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&iio_map_list=
_lock);
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (maps[i].consumer_dev_n=
ame !=3D NULL) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (!maps[i].consumer_dev_=
name) {
> > >=20
> > > Shouldn't this be?:
> > > while (maps[i].consumer_dev_name) {
> >=20
> > Ups... Nice catch! I was probably in bot mode already.
>=20
> When making a change with no functional change intended, it is always
> a good idea to compare the generated assembler before/after.=C2=A0 I.e.
>=20
> =C2=A0=C2=A0=C2=A0 make drivers/iio/inkern.s
> =C2=A0=C2=A0=C2=A0 mv drivers/iio/inkern.s drivers/iio/inkern.s.orig
> =C2=A0=C2=A0=C2=A0 [make your change]
> =C2=A0=C2=A0=C2=A0 make drivers/iio/inkern.s
> =C2=A0=C2=A0=C2=A0 diff -u drivers/iio/inkern.s{.orig,}
>=20

Ah thx... That's indeed a good idea!

- Nuno S=C3=A1




