Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495D353CA3E
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jun 2022 14:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbiFCMx7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jun 2022 08:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiFCMx7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2022 08:53:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA3E36E08
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 05:53:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z17so4057287wmf.1
        for <linux-iio@vger.kernel.org>; Fri, 03 Jun 2022 05:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=YTs8VPz/2AXsPXPG75ovAhF2/Afdm8hhmMlI0rs55Wg=;
        b=aAqvYEENzt47DWV29dlCRYNTmDyzRoxUGK4lBhop2LwAVIQ9W8NxTnwZ72XpBgAb7d
         azA51aARw1tb/thWN/YV3aSnKq89xo6U9MQJaXNQ2hEgcHONsxm5OJ6VIjELtfDsx2Jc
         InYNKSdCvGqTKOWrwGnXBQ+lLDWKXCYSxtcGcUCJDWGhM+u7grJhGTrXeglxUH7KCvDu
         jc/3ZCsxqmNWK6znRMzHSN/rhBS5B+njAI11OQNe/S5i6JLO9FUnmc/fFyQduWqb/JcJ
         G4XIo7SOSJpnD7EZ0wS0sN3UGSZ/U2IXxMMvE1AtWfRNh7M54pPx/AcRtZ16VF+u93BP
         RqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=YTs8VPz/2AXsPXPG75ovAhF2/Afdm8hhmMlI0rs55Wg=;
        b=TYqwcJCal9qbXyK0PZwEeUJZgKa1MoAUsco0WvxtFnFDA43eU72ypwZhGkskKTzFqF
         D4gLGJsAGjVEaqpTF8+jAiHawkthYxEyXy5m7IXfbw47vGhHBfjq4lKnTbzfnDgv+gSM
         2ofQHbfMpjJRkZmAJtWNzbPZm+OWkK9Vz0iw2o9QtXtpyqldTN+tRRaPkTRNeqeBGaD4
         Kfi6ScKm9vHdWkDBOL2gGvsflCpxD/LIlUdxsjZ8y/0gQtr4t/AHRO8wWNehLkrCMQ5M
         PTtiD2wf/LXT4jt9eoPsWaKgIXm6JMe3qlM5EshdCJKx0HdYvR06HWJU2OPywYf5vwAO
         hSBw==
X-Gm-Message-State: AOAM532g+2Osp2F+kI1f0OnGAeNYyZViOVCboCCdPrgE7UB2h1tk45HI
        plnTIPHb1GkxoAJDVQpVKBo=
X-Google-Smtp-Source: ABdhPJwleoAOhfXycXCNvyOQWrMtvVps8uyzJgaWZus6RKqmahjSgR/yQ/+XMgPxLav3YIC9MYeIFQ==
X-Received: by 2002:a7b:c114:0:b0:397:506f:262c with SMTP id w20-20020a7bc114000000b00397506f262cmr37131430wmi.56.1654260836570;
        Fri, 03 Jun 2022 05:53:56 -0700 (PDT)
Received: from p200300f6ef0219008f4342cbe8c8c65c.dip0.t-ipconnect.de (p200300f6ef0219008f4342cbe8c8c65c.dip0.t-ipconnect.de. [2003:f6:ef02:1900:8f43:42cb:e8c8:c65c])
        by smtp.gmail.com with ESMTPSA id b15-20020adfde0f000000b002103136623esm7597018wrm.85.2022.06.03.05.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:53:56 -0700 (PDT)
Message-ID: <46d4d0062324846faf65c697dcb10e4e53305edf.camel@gmail.com>
Subject: Re: [RFC PATCH 5/6] iio: inkern: move to fwnode properties
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
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
Date:   Fri, 03 Jun 2022 14:54:49 +0200
In-Reply-To: <CAHp75Vc5DzQTd8hOydc5jn8BUGQFf=06Sad749387TYuHTTxew@mail.gmail.com>
References: <20220602140400.213449-1-nuno.sa@analog.com>
         <20220602140400.213449-6-nuno.sa@analog.com>
         <CAHp75Vc5DzQTd8hOydc5jn8BUGQFf=06Sad749387TYuHTTxew@mail.gmail.com>
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

On Fri, 2022-06-03 at 13:57 +0200, Andy Shevchenko wrote:
> On Thu, Jun 2, 2022 at 4:04 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parent =3D fwnode_get_parent(fwno=
de);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (parent) {
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 parent =3D fwnode_get_next_parent(parent);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Forgot to mention:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D87ffea09470d94c93dd6a5a22d4b2216b395d1ea
>=20

I did looked for something like that but it's still not in the IIO
testing tree.

(still I actually followed that patchset but completely forgot about
the helper)

- Nuno S=C3=A1
