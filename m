Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC31B546E0F
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 22:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350518AbiFJUIs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 16:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348721AbiFJUIr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 16:08:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E424323EFAA;
        Fri, 10 Jun 2022 13:08:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r187-20020a1c44c4000000b0039c76434147so1642428wma.1;
        Fri, 10 Jun 2022 13:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=EYdxdXjqZnMfe3vNUEt1qvnu5edzLozRvBmutng2gcs=;
        b=CwmfAF6XHzbKO8jEH1gk+bM/1vpPQGL/FBas2sxdEfvaPOWCrmy31A4DGlV+qRbNLh
         EhE7R/0Apge67rflwIqv8xb8iI3MVz4tH/cjgvlR0njUgo8D/mQ1I7jC3EKVSvYMwwcI
         sbxI1wxllvZ09BnK2w2SbAc5pxLTidgyMANYo96BcCZ/obK1SZsjQnLrn4I8/dPp07XC
         G1yQR1Yy0wNiRGatiMcWPC3BBg8FGpQTCb/lIQdyvipx939yxhZ6fvPdX3cj8ChHvy5k
         k6USF7TyLBfpolWfhPNfaJpv5ZIkxehFF9XkoRvK3oVX5QPgU1PKY2VQfWO+6rp3rB/o
         VRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=EYdxdXjqZnMfe3vNUEt1qvnu5edzLozRvBmutng2gcs=;
        b=H3CPzW8Euz8LNLgs3k/Y57+KlLESEQOURkXzEsPUgqCY7RCSnPBecMU8p6EyXvKcno
         b92PY2kWHyTlJ5t4sRshYsEwr8QFkaCTgEwx27NeSHUy8ilePt2cdtkja2Crqint2fj5
         Z6ZRrcGa05fMnf5KB5ZoQKz9mzxfVbS7wLuJGoEtXl5Kg49C1iyuMM4WhEkwS2fdR9B4
         D+eNxe2E7RwKn+2VGYJq7PoQAEXiqYlw6ilaLhXBrRMo3lHVtXe8OsppgyLFKeZ9rHii
         OcokeAOs9VkdLNKT4iPmScHOwHRXr5Bdy0ubN4KOq2JfIWHP0L4+cfZ7ykRdRmKHG7v5
         XlKg==
X-Gm-Message-State: AOAM533wYhCix341fNDynKC+HvcNXl3aPjW5Z7NXPt4avLMIfJuUrotf
        MOAZip/RuTX0YVSIE8y6muY=
X-Google-Smtp-Source: ABdhPJzFMI/kZj6Y7ZsIIRkgwHejQ91g4pjv9UVjVQoEdMHpUhK/4CORgOZeBhdrhfbjPGUylvA40Q==
X-Received: by 2002:a1c:f704:0:b0:39c:6684:b375 with SMTP id v4-20020a1cf704000000b0039c6684b375mr1346597wmh.66.1654891724476;
        Fri, 10 Jun 2022 13:08:44 -0700 (PDT)
Received: from ?IPv6:2001:a61:136e:3c01:8bd4:cf6f:76f1:a861? ([2001:a61:136e:3c01:8bd4:cf6f:76f1:a861])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d4e8a000000b00210320d9fbfsm436482wru.18.2022.06.10.13.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 13:08:44 -0700 (PDT)
Message-ID: <ef73aa5801ae1c8078e6a930f22feb6214038176.camel@gmail.com>
Subject: Re: [PATCH 20/34] iio: inkern: only relase the device node when
 done with it
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
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
Date:   Fri, 10 Jun 2022 22:08:41 +0200
In-Reply-To: <CAHp75VcdwjTYDF2c-StsL7-pLKtV3vGxinX8+1nJydqB_WNXiA@mail.gmail.com>
References: <20220610084545.547700-1-nuno.sa@analog.com>
         <20220610084545.547700-21-nuno.sa@analog.com>
         <CAHp75VcdwjTYDF2c-StsL7-pLKtV3vGxinX8+1nJydqB_WNXiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2022-06-10 at 16:56 +0200, Andy Shevchenko wrote:
> On Fri, Jun 10, 2022 at 10:48 AM Nuno Sá <nuno.sa@analog.com> wrote:
> > 
> > 'of_node_put()' can potentially release the memory pointed to by
> > 'iiospec.np' which would leave us with an invalid pointer (and we
> > would
> > still pass it in 'of_xlate()'). As such, we can only release the
> > node
> > after we are done with it.
> 
> The question you should answer in the commit message is the
> following:
> "Can an OF node, attached to a struct device, be gone before the
> device itself?" If it so, then patch is good, otherwise there is no
> point in this patch in the first place.
> 

Yeah, I might be wrong but from a quick look... yes, I think the node
can be gone before the device. Take a look on the spi or i2c of_notify
handling and you can see that the nodes are get/put on the add/remove
notifcation. Meaning that the node lifespan is not really attached to
the device lifespan. If it was, I would expect to see of_node_put() on
the device release() function...

Again, I might be wrong and I admit I was not sure about including this
patch because it's a very unlikely scenario even though I think, in
theory, a possible one.

- Nuno Sá

