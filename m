Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18105468E3
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiFJO4n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 10:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiFJO4m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 10:56:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2866141;
        Fri, 10 Jun 2022 07:56:40 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z7so35618698edm.13;
        Fri, 10 Jun 2022 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=27H3ValQb+HBvUPzRu8Xf/glxEPwy0TQVzU1GqPnVOU=;
        b=eoLQQvbaXDJR95EC5g5LJ5CxHbAJV47MdiWWQDebUGy9Q4ljUChinzTC65zAyx9+cu
         P1TKzxsUNIbMO6DgJKWLF02va3yYhlizG8M969o8ytL6wp0eioeV35oB2ovGhpg0HL2J
         AtE27v900JQInLKWLqxjz95V4dBqhK4TH2d+FpSxvJHnaV2+W4R07LunLSpcHXFduZip
         CtWpeygUURiujmqCRQx07U09RQlXGX3kfWPB66KuMLyPm04qs+bAtSY+koRjNgs1IcDR
         1X5UPyx91NZwB8hqYfnf3lsrVd7c+3ZPhRnd7kjLUGHQEmxcvRwvNYyB/XfwXQBjPuch
         iMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=27H3ValQb+HBvUPzRu8Xf/glxEPwy0TQVzU1GqPnVOU=;
        b=BLZplKxXqRALUxWoA0WIT+yyjwulSMxbuf6Po8ZSIXZdVQJl9RM8plCFbTxHVzd2aG
         ygwnGzKXU8vm/I1KZtzguMlhjXTfFLhH7QmJo4jCNgM064fI35sbak59Q0Y4XAGyUW8a
         RBaltiZLrvAivGO+IerZJ9wHafR37gK7cRzpuH0bUogSWwNpoofATfij/DKZlJTasrkI
         Q53/dXcMe4fQQp07rvjDPKdeWCAuwElkQL2kO4WDnYVX4j+prwxqhCmt7g3x0+muLa/K
         pZoOlIazk7WEIymPSOcVRuumWfivF1HwaPLF/VC1jUq5a9jf/YFnup7NscshxD/R5SoY
         LZVA==
X-Gm-Message-State: AOAM5325u0TJLjrs+W5JDX092P/F4/2TGwvWnPUA2oj1jfvlRdh2Hjtm
        WRGb4uEletcTg+hKijYH0JIGCkjhht250PoMsSU=
X-Google-Smtp-Source: ABdhPJy+4W6TzW/Fih8FB8596xZDMbGHtv+y8KFgg0s5ncZshszK0PY5LIku4jQLDiOJ5W3CjVR22n6jku9zOiOB+lo=
X-Received: by 2002:aa7:d303:0:b0:42d:d192:4c41 with SMTP id
 p3-20020aa7d303000000b0042dd1924c41mr52267347edq.178.1654872998983; Fri, 10
 Jun 2022 07:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220610084545.547700-1-nuno.sa@analog.com> <20220610084545.547700-21-nuno.sa@analog.com>
In-Reply-To: <20220610084545.547700-21-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jun 2022 16:56:02 +0200
Message-ID: <CAHp75VcdwjTYDF2c-StsL7-pLKtV3vGxinX8+1nJydqB_WNXiA@mail.gmail.com>
Subject: Re: [PATCH 20/34] iio: inkern: only relase the device node when done
 with it
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

On Fri, Jun 10, 2022 at 10:48 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> 'of_node_put()' can potentially release the memory pointed to by
> 'iiospec.np' which would leave us with an invalid pointer (and we would
> still pass it in 'of_xlate()'). As such, we can only release the node
> after we are done with it.

The question you should answer in the commit message is the following:
"Can an OF node, attached to a struct device, be gone before the
device itself?" If it so, then patch is good, otherwise there is no
point in this patch in the first place.

--=20
With Best Regards,
Andy Shevchenko
