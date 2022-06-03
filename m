Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1A353C931
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jun 2022 13:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiFCLRZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jun 2022 07:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238794AbiFCLRQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2022 07:17:16 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADAD19FB6
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 04:17:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 25so9443017edw.8
        for <linux-iio@vger.kernel.org>; Fri, 03 Jun 2022 04:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pYgPlNnTwHU2r14tFACTBhke5qQdbZd39FwPnYREGxE=;
        b=NSuAakcLdC82enHkYFWJgaT2vX84I3wJbCiIgiHtUUb1td4LCUvg0TRi7XOu9LjWWe
         ot+QDXlrr/nSZXPUNB30hclWFbeBHwZ8EcoZmOAYGCWAFGR8hKBzL76vjM2rN0eNsgot
         qbPOQWUfoF4bhSxnDmvDsgFlqpQpMq4y5aruoD3F52yJ+4rvA+MU09TLUSPJotFJuhKt
         ubvr6EZlhrHJK4IgutpInCKpqrFp2lI3Cs2oz7AmQtrcpUbvZKIPrIBohpmVSW609kuW
         0OiYWW29drjSrvtpBLVvNcHM/fH4qZhT7FKplxEJ7h6n2WrrtM953UiEYzdTiMzpGFkt
         UeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pYgPlNnTwHU2r14tFACTBhke5qQdbZd39FwPnYREGxE=;
        b=acRzXdP2HNe4bb34gtQcY5zTsaVaVNcEOc8lLP22K5F9lF+EYbI2zjlUVEZ68mUGI5
         go9pWO8w5B90TpO1ZnZz7quQn1sv5U9u+OKdlUiqoWVCL6R8shCsAsfvul37RO7Ssvlb
         w8ls5kozLXPwID8wzxj0Lc8WdzaxAIRh7096pp8/GlSXkLZqucu89NrGn1K2HJRAhk8F
         tVkX7gcoKGmlkmk2zAakaqolqRRUrd9pJrvQ25LyF7gx8MR4pO5sl6N9RaasemtucT7m
         b3hhzFSNnXrMQ9yoWygPHSH+4Y186eu7Sv7+Rrw2a1VtEavLX7iXY7Hm6LU9750DtdcF
         5jMA==
X-Gm-Message-State: AOAM533pvX0QqpT74bL6QUdN0qRsbNGA+x+jgu5dJTsrhQ6+UlVf/WZF
        FQRZP3I360VNPeMq878/mxex9joIDuOo6qEXChiUpAmT9qqo2g==
X-Google-Smtp-Source: ABdhPJxjyko3Y8t0yYqCQwCwF91HH+T5EqzvMG6Mzj83ezqADxQ5tKW8a2Pq8c0F/6VKTUobDzzS+5OucXB3WyxcKr0=
X-Received: by 2002:aa7:c396:0:b0:42d:8b86:a8dc with SMTP id
 k22-20020aa7c396000000b0042d8b86a8dcmr9935679edq.54.1654255034136; Fri, 03
 Jun 2022 04:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220602140400.213449-1-nuno.sa@analog.com> <20220602140400.213449-2-nuno.sa@analog.com>
In-Reply-To: <20220602140400.213449-2-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 3 Jun 2022 13:16:37 +0200
Message-ID: <CAHp75VftW=mR17gh=LiODYb7GyGbFFyH7pvpu-WarHL8MXjWZw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] iio: inkern: fix return value in devm_of_iio_channel_get_by_name()
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
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

On Thu, Jun 2, 2022 at 4:04 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> of_iio_channel_get_by_name() can either return NULL or an error pointer
> so that only doing IS_ERR() is not enough. Fix it by checking the NULL
> pointer case and return -ENODEV in that case. Note this is done like this
> so that users of the function (which only check for error pointers) do
> not need to be changed. This is not ideal since we are losing error codes
> and as such, in a follow up change, things will be unified so that
> of_iio_channel_get_by_name() only returns error codes.

...

>         channel =3D of_iio_channel_get_by_name(np, channel_name);
> -       if (IS_ERR(channel))
> +       if (IS_ERR_OR_NULL(channel)) {
> +               if (!channel)
> +                       return ERR_PTR(-ENODEV);
>                 return channel;
> +       }

Why not make it not nested, i.e. just adding two lines after the existing c=
heck?
if (!channel)
  return -ENODEV;


--=20
With Best Regards,
Andy Shevchenko
