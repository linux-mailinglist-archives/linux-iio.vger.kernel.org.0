Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF5053C9A4
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jun 2022 14:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbiFCL5u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jun 2022 07:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243652AbiFCL5s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2022 07:57:48 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0240721814
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 04:57:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id q1so15456961ejz.9
        for <linux-iio@vger.kernel.org>; Fri, 03 Jun 2022 04:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GAiNawLk5ifUkYwy9NLxfWrPLQp41DKaqb5X0zwydAc=;
        b=clH62Z6hiO2gYOqWJlqrzhvxlX8GUnYL7ghoRIqKWoZ0lZ8aUpOYBo6ivzAiaHU0sz
         LUsKPdqnIt2LNZ7u7uYJrPXjoJ5KEiM289NJK/UrAMJ2w597IRL44XmXWlMXHN7MH2jU
         rysTh4jZbNFGEV2Y6jQyeH5aANZsVzNgfUoZy0G2MqHrUz2W0q0/nQVEDthj4RpK6/Kv
         sPWQpBY85dFlgk8b/GKTQVyxUg5crtJ28zA0qoq/CaSBg4HU8XX6N+mAW025McI9VFVO
         yubCQPFtN5JuEOI39sZIHWLuEqOe//+PiY/r5doNX7sDy7Fm99Z2Kr6pTK/O+F2DHqio
         PRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GAiNawLk5ifUkYwy9NLxfWrPLQp41DKaqb5X0zwydAc=;
        b=ZNtT+YAhvktToOMR/wuF9CeaddAkkeK+vtbidYfqdI85RO/6NoLP/6v4ywR/EieQho
         xpIYGdFNGphD58dYyrw9u2lDhjr6FRZREZftRUQLUQycm44S1/oaZ8hRoBGS171nxFff
         zW1lt/AjULxttY7+vu1QKUpyALXxpC8yuFHA+1l9joXWD0KSOv4ZvHS6vX5xE/o5xMS7
         FJmREXdwr5PyLIAKhs0EKFN7MAsBCStArS+SfqrifQj3+0hUkle7kVBqtxKlF7taDkA4
         ehnJmbj4biNZv3CC9AJhzy/YjGmAh0Sl/Iis1yAQe8V8W2AuFafxn1GDBPmAeGPoijFs
         VyGA==
X-Gm-Message-State: AOAM533Dwdrn7Albm3KUCD4gSi0ocaertsuXiG5rzh4jy3WBpAoc7kQc
        U8kjBdX51qDauNvsBBIZOc+o6hkRxDRAQtavzPM=
X-Google-Smtp-Source: ABdhPJxC53U3o3hPjlo88W+VHGiS2k+weJaggsT8GPQFURDHg7IAXl3F/BlYFKXcNQ7nk6KeAgp9BvrAhtQ9JZfgiBg=
X-Received: by 2002:a17:907:868e:b0:6fa:2fe2:92d6 with SMTP id
 qa14-20020a170907868e00b006fa2fe292d6mr8403764ejc.639.1654257465801; Fri, 03
 Jun 2022 04:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220602140400.213449-1-nuno.sa@analog.com> <20220602140400.213449-6-nuno.sa@analog.com>
In-Reply-To: <20220602140400.213449-6-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 3 Jun 2022 13:57:09 +0200
Message-ID: <CAHp75Vc5DzQTd8hOydc5jn8BUGQFf=06Sad749387TYuHTTxew@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] iio: inkern: move to fwnode properties
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

...

> +       parent =3D fwnode_get_parent(fwnode);
> +       while (parent) {

> +               parent =3D fwnode_get_next_parent(parent);
>         }

Forgot to mention:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D87ffea09470d94c93dd6a5a22d4b2216b395d1ea

--=20
With Best Regards,
Andy Shevchenko
