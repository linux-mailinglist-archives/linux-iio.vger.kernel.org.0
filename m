Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC29B546960
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 17:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbiFJP3F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 11:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiFJP3E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 11:29:04 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D3BD82;
        Fri, 10 Jun 2022 08:29:03 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y15so24568395ljc.0;
        Fri, 10 Jun 2022 08:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v+jZ6r+UjKDKeJGUYw7c5giWLtAjtBGzVupfZsrUfPw=;
        b=YftxElw48vAzTMHF/1nfU7VfFHsJSYUmrN1ldESryIJDZgWI62xwEtnFBnCOtU1dBy
         hugT6puqW7XaZIJXo1TEsfOzKiAxZbj7elvsLJSguBWcH268hWJLPJ9n6csgtT0bsFAu
         oG+5atjoQLcNfaqFj1A/1giu0nztBRDoV5yyzxGAH+WDdZW8PWD5NPRMy9Jb68+jEOas
         rO7SvIZAjGbxr/an2qmDZHU6GyFFqKxmQkILq2u14xvgnxAOPDhGLNNy8IiKfsMtIYqY
         o3DiP0TqRJiGuuR8sP4NOpGYv3F2oz+tU1K7wiqJ+zfYH/pArdVyPDp3VHieI+PB2M76
         nAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v+jZ6r+UjKDKeJGUYw7c5giWLtAjtBGzVupfZsrUfPw=;
        b=7jm+buB8HKvwKL9Sn5W/7hYFbYU8IcK/sBfqKIWppWheM9hVA3ga2CJEWJB0M4101H
         HVrihFAmUNSGknGLFsDdDFgFeGTNBUPhLdujo0CgGITrOQlpBG8AfXnSqXQd/fL6ahJV
         N1WdWHgijltnAA5x4EAPHpzQJ5gi1PFcz6Qby8uJqWXPbGlwzcRXjLAZCOEQn5hBCv2P
         jmeBGuBp0UxCBVKqqViZyUOq41t/DIalFGJCDmhYN0koEwnafmR2bjf/nBStB4gxmQcs
         YuOdWa604n+O9Br2ieNcCK45cSUvYpKBRNo12OaXkHsefqZ4vD0PPBE5b99YeSeWaU5u
         FsRg==
X-Gm-Message-State: AOAM533oLUExYRk+W8CE7hqAFIaFmbvXdWfv0fRjqhfGs3rIi1B08ixY
        pVrDWZv9w+pClYvEEOALb9alfYo4P76c54zoyHM=
X-Google-Smtp-Source: ABdhPJwl2v2/H6OLQAJbbAo++RAUaoWbhTiq/DJO2nyXA23eqXmg6t46Wkkb2wH2XOIksQG/+e42V+8jRbh1NeB2EQY=
X-Received: by 2002:a2e:b8d1:0:b0:255:bfef:7212 with SMTP id
 s17-20020a2eb8d1000000b00255bfef7212mr8012769ljp.378.1654874942164; Fri, 10
 Jun 2022 08:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220610084545.547700-1-nuno.sa@analog.com> <CAHp75VfhRoDupB2rFS+hg1zFN3=8RhnBcXrg0O72bKJYQz+8Kg@mail.gmail.com>
In-Reply-To: <CAHp75VfhRoDupB2rFS+hg1zFN3=8RhnBcXrg0O72bKJYQz+8Kg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jun 2022 17:28:24 +0200
Message-ID: <CAHp75VevzkT-WYz=BiWhDAETx==Sswe-rYCo_qxy7vyL2qRwVA@mail.gmail.com>
Subject: Re: [PATCH 00/34] make iio inkern interface firmware agnostic
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        chrome-platform@lists.linux.dev,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
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

On Fri, Jun 10, 2022 at 4:48 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jun 10, 2022 at 10:45 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Ditto for patches 26-34.

--=20
With Best Regards,
Andy Shevchenko
