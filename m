Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DB753C97E
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jun 2022 13:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbiFCLiK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jun 2022 07:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiFCLiH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2022 07:38:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB1BDFCD
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 04:38:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x5so4693420edi.2
        for <linux-iio@vger.kernel.org>; Fri, 03 Jun 2022 04:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=owTN0aQcdcUgazgPvq6N4wFStuHNmRQMmCcbBwwZW+s=;
        b=Vyl3HdhKW45syRFgxGRw4Rdpkwh4cSC1gA2ODenbBV2ZSpglcIqhjnIk3nsd1xqYDy
         dF5YMBOuc4Uk1WyOTO8AJDQ7I3JHnDczDtJ1VmjUFmmdYuDSiuc5hERd+s0GPkvqYuJ+
         0u9pMqyhVLRGl8oZHRx98srv2GVoGjrkPb8Vbev7wnhsw4O++gbv15y+6PK+eZ38yLeP
         Zl4Ii3OFkEjOflHgfuIfgB0tFGKlvtiQTCWVnODYvAXjHCCTNLJsYFXTFp8EnBKUqn2q
         tbj5KCvE/aj0LSOeoSqt4tYBthnLOF5gJY7RaR7iQIMK2b8FCT7bR0XV32UyOP1fu68l
         2Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=owTN0aQcdcUgazgPvq6N4wFStuHNmRQMmCcbBwwZW+s=;
        b=Zlg0QP1it7S57DYOUsg5Kyf/BY1rRxioiNvagVA3ecmZIJKQGEScv2MLfwq6XxJU2+
         XOQpZ4YhC5Decxm3LMSJ40z2DiDyRHOMsZzgKeEpNbgiG/EoTkdIibZe2rleyZ/ba8+/
         cjowonS79OORRDLe4wOI9HKwYKEoYxkpuFN5JOlqqXoPlykfJNyjgwPZkpRpdiBPciVE
         0yHi+YTMmbpAhiide7UbqmJmZmiw9FpgfVVWhqHO43gwFlT6wycqF6AWs0Q/WnDMfyF7
         LN+JrJJaZDwtW3saVS4o7v3n8owSYw8x8h20EyzFzLdKeWB3MAZz5Ao1x/vAj3vnjCKr
         Xp6w==
X-Gm-Message-State: AOAM532CbfggNf1yhyAsVJGAAMbCnF5lnD5H7V838onJCW4c1W96g60t
        kznO4Q3S2uubV+9ArEtmDwT/wbsHBT/FjXeXzaY=
X-Google-Smtp-Source: ABdhPJxMO0cWwxeaz9vTcmQmU5laAX1W41VAnmwhwcW1584kflrY3XBrwZlVX97TZsY9L4Pq5tuSPk0j0opT2ooGjqA=
X-Received: by 2002:aa7:c396:0:b0:42d:8b86:a8dc with SMTP id
 k22-20020aa7c396000000b0042d8b86a8dcmr10035264edq.54.1654256284561; Fri, 03
 Jun 2022 04:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220602140400.213449-1-nuno.sa@analog.com> <20220602140400.213449-5-nuno.sa@analog.com>
In-Reply-To: <20220602140400.213449-5-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 3 Jun 2022 13:37:28 +0200
Message-ID: <CAHp75VecehGSpv+KQgiowqTKo2kz8M_wUS14HHuDorrq1uc_xw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] iio: inkern: split of_iio_channel_get_by_name()
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

On Thu, Jun 2, 2022 at 4:04 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> This change splits of_iio_channel_get_by_name() so that it decouples
> looking for channels in the current node from looking in it's parents
> nodes. This will be helpful when moving to fwnode properties where we
> need to release the handles when looking for channels in parent's nodes.

...

> +       /*
> +        * For named iio channels, first look up the name in the
> +        * "io-channel-names" property.  If it cannot be found, the
> +        * index will be an error code, and of_iio_channel_get()
> +        * will fail.
> +        */
> +       if (name)
> +               index =3D of_property_match_string(np, "io-channel-names"=
, name);
> +
> +       chan =3D of_iio_channel_get(np, index);
> +       if (!IS_ERR(chan) || PTR_ERR(chan) =3D=3D -EPROBE_DEFER) {
> +               *parent_lookup =3D false;
> +       } else if (name && index >=3D 0) {

> +               pr_err("ERROR: could not get IIO channel %pOF:%s(%i)\n",
> +                      np, name ? name : "", index);

It's one TAB less now, means you may compress more on one line,
including replacing
name ? name : "" --> name ?: ""

> +               *parent_lookup =3D false;
> +       }

--=20
With Best Regards,
Andy Shevchenko
