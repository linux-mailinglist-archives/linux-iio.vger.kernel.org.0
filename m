Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6D753CA1B
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jun 2022 14:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiFCMjq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jun 2022 08:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244381AbiFCMjo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2022 08:39:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B88B3A712
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 05:39:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q7so10257451wrg.5
        for <linux-iio@vger.kernel.org>; Fri, 03 Jun 2022 05:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=RG9EULX6AXWSuj88ad7zTUODZ3cXTtnOgya4os1rkQ4=;
        b=LdJyE7vorMelh+W1IGGKFj2M9ThM1A/OdqrbR9y7rm06xSdDUhA2o9HXKNgRC7YwLe
         C9EboN/EHYBXYrCNofFZG4ULlL35gbqAt+FlVKlo3cgOFyqG/8gTddVRQOrjvET6qDMN
         gOCKlbAQiP6JPlXyr1NWEkL91nWRigN13Hf4foDEfxGcrm/xDShuIkDW680S+LexuSgT
         4DLICe9VfZJGGEISZ99Nt9pzZkRptX0+U2yLpJJme4w9ibxDmNoUM4AKZGl+dohPWrSS
         EuinpYorB0Atg/uL92yO8zD0a/y5foHwerrQf3566XIciBcYvk4F2uaru6I/tOhpGPwn
         SlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=RG9EULX6AXWSuj88ad7zTUODZ3cXTtnOgya4os1rkQ4=;
        b=2dNb+tq7tD4+6CJOGZBl1YM8OcQlS91CXjxq1ynAur+mB/YdP5MJP1fIX2mdPpjhYS
         kOETG7ueSaJBcMMHGbDoYs/egsBNssxpoDM9HKI347BW15JOv2+4vqJTlZemn7yK8NxI
         vAgFQqeh0ImfNLdbRRUAaq3RNljB7QRjoiCLyP9kCuBXtF8kb1u5CqkyzcCwxBw4REaT
         tVWVCzQolHpqLDO/y3D5TEkxlJATupro2dZk/UPT5CfmqaVNsJbvL8kHgr6dZ8Gn4KxA
         O616V+GQGZyTt+4cvSsthbcaD//0ey7RSScvw9rnb+H78DmBQDjU3dfZ1RtYvMMCq2Fe
         Xl+A==
X-Gm-Message-State: AOAM5339axKS1vdaGm/A5n+8gCGVa1LYmtypV+igwPEPqW4kekufSB4P
        fiCk0Cho/x33No8teEb+oSk=
X-Google-Smtp-Source: ABdhPJwu+B07nGtbx3J4+846qqmStUY4f3uFz3/LfO9ja+jhAS19kPSKRwPJHtqphxNr7BJsVvRVRQ==
X-Received: by 2002:adf:f68f:0:b0:210:2ef7:e801 with SMTP id v15-20020adff68f000000b002102ef7e801mr8077150wrp.318.1654259982169;
        Fri, 03 Jun 2022 05:39:42 -0700 (PDT)
Received: from p200300f6ef0219008f4342cbe8c8c65c.dip0.t-ipconnect.de (p200300f6ef0219008f4342cbe8c8c65c.dip0.t-ipconnect.de. [2003:f6:ef02:1900:8f43:42cb:e8c8:c65c])
        by smtp.gmail.com with ESMTPSA id c186-20020a1c35c3000000b0039bc95cf4b2sm8415929wma.11.2022.06.03.05.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:39:41 -0700 (PDT)
Message-ID: <572ffbcb2512d458c8e8de822336d45845545a98.camel@gmail.com>
Subject: Re: [RFC PATCH 4/6] iio: inkern: split of_iio_channel_get_by_name()
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
Date:   Fri, 03 Jun 2022 14:40:34 +0200
In-Reply-To: <CAHp75VecehGSpv+KQgiowqTKo2kz8M_wUS14HHuDorrq1uc_xw@mail.gmail.com>
References: <20220602140400.213449-1-nuno.sa@analog.com>
         <20220602140400.213449-5-nuno.sa@analog.com>
         <CAHp75VecehGSpv+KQgiowqTKo2kz8M_wUS14HHuDorrq1uc_xw@mail.gmail.com>
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

On Fri, 2022-06-03 at 13:37 +0200, Andy Shevchenko wrote:
> On Thu, Jun 2, 2022 at 4:04 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >=20
> > This change splits of_iio_channel_get_by_name() so that it
> > decouples
> > looking for channels in the current node from looking in it's
> > parents
> > nodes. This will be helpful when moving to fwnode properties where
> > we
> > need to release the handles when looking for channels in parent's
> > nodes.
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * For named iio channels, f=
irst look up the name in the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * "io-channel-names" proper=
ty.=C2=A0 If it cannot be found, the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * index will be an error co=
de, and of_iio_channel_get()
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * will fail.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (name)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 index =3D of_property_match_string(np, "io-channel-
> > names", name);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chan =3D of_iio_channel_get(np, i=
ndex);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_ERR(chan) || PTR_ERR(chan=
) =3D=3D -EPROBE_DEFER) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 *parent_lookup =3D false;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (name && index >=3D 0) =
{
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pr_err("ERROR: could not get IIO channel
> > %pOF:%s(%i)\n",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 np, name ? name :=
 "", index);
>=20
> It's one TAB less now, means you may compress more on one line,
> including replacing
> name ? name : "" --> name ?: ""
>=20

I can taking the 100col limit... AFAIR, Jonathan wants to stick to the
old limit unless readability is severely impacted by it which I don't
think it' the case here.

That said, I'm more than fine in using the new limit as long as
Jonathan agrees with it.
>=20

- Nuno S=C3=A1
