Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E47546D97
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 21:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348555AbiFJTt2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 15:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiFJTt2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 15:49:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B6F3C3073;
        Fri, 10 Jun 2022 12:49:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m24so2957117wrb.10;
        Fri, 10 Jun 2022 12:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=u9muj2CCpJ3bi2OBicnt3vUuhr/462OKXXDNMSoOjkA=;
        b=nJO3QDlMK8Oo8cC2rEDrsS8zHoFWKSvz9V9tp5Slqj6XFK8gGsnauvl4/5a9Zlujsw
         CorVf5dfKaQH6teMfzW+hEHcOqhkKmK+dqKhgaSLIk2OjK2OrHpiPiYlnLwU4fkOG5Z5
         4PmGHwSchAW9lf+n6mIfhoGZyeWAKEIX9r6hS5AcDvGRjX5QHRl7KdZO9iqyazhYBNgz
         7pfLKuBvFnE/1MuQV2//JtuGP6S3TUo035W5eNVrysQCBRxAgc/0GKH+7gd2XMdw+zE2
         BOR2sXaNMk/Pkqsivac6peQf8L0kcC+Xa3RD9v9FKZpipTo6kRu9/aVYFutE3X708T/B
         a27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=u9muj2CCpJ3bi2OBicnt3vUuhr/462OKXXDNMSoOjkA=;
        b=vfTtHW1eggJliOh0AC1NgF83A3tkzclS3VzUHar+8fmS2lPPY5knhiTf6+tVrAuQrw
         nacKbCX5gbLON47L6mBgaGCi8OoBowazoHq0uvHY3pW1Wn6fRsklqRb/wTHiR9I+4zv7
         1vXNYeXfcxVfd/08XCcs+MrYl0amwcTSAJTYAtdpYZKOUbKnyexitCL6FiPkdJPLTLqB
         AQ1m4DyHRl+5NMMBTaKrSEh622wXtd80Nnr6tI9n22kEoIgRO+52hbVefsg1yFRAVPfb
         0euE0DHhb72XTcEC57xk6V/ZzpuUr/PGy8QQ5SurwYq4Jwj7Axece7cAj4hWSs5rPI4w
         vPUw==
X-Gm-Message-State: AOAM530ubZgR7Nan2wO4UqfIMscO4EPQ4kcsb40DNNQg7fd8qfbFP7PR
        p063FC9ddrExL932zuxD5po=
X-Google-Smtp-Source: ABdhPJw1wyN/M1WFaQFuP+jX/NGTq2GqnLXXrOE71+r/B9uelliduc7dUH3CHihgz35kd6pD213QmQ==
X-Received: by 2002:adf:d1c6:0:b0:218:51ae:8812 with SMTP id b6-20020adfd1c6000000b0021851ae8812mr21038542wrd.178.1654890565371;
        Fri, 10 Jun 2022 12:49:25 -0700 (PDT)
Received: from ?IPv6:2001:a61:136e:3c01:8bd4:cf6f:76f1:a861? ([2001:a61:136e:3c01:8bd4:cf6f:76f1:a861])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c4ecf00b0039c4945c753sm4278743wmq.39.2022.06.10.12.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 12:49:25 -0700 (PDT)
Message-ID: <a67d3d01824db6376c2f15949021db4f2b6173cb.camel@gmail.com>
Subject: Re: [PATCH 06/34] iio: adc: ingenic-adc: explicitly add proper
 header files
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
Date:   Fri, 10 Jun 2022 21:49:22 +0200
In-Reply-To: <CAHp75VcU-oV4is_y9=oaOx2ugvTEOy53h2wvbd3-Z9_gv5Y=zA@mail.gmail.com>
References: <20220610084545.547700-1-nuno.sa@analog.com>
         <20220610084545.547700-7-nuno.sa@analog.com>
         <CAHp75VcU-oV4is_y9=oaOx2ugvTEOy53h2wvbd3-Z9_gv5Y=zA@mail.gmail.com>
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

On Fri, 2022-06-10 at 16:45 +0200, Andy Shevchenko wrote:
> On Fri, Jun 10, 2022 at 10:46 AM Nuno Sá <nuno.sa@analog.com> wrote:
> > 
> > Do not trust the fact that iio.h includes of.h which in turn
> > includes
> > all the headers we are relying on.
> > 
> > The ultimate goal is to actually drop of.h from iio.h.
> 
> ...
> 
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/mutex.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/of.h>
> 
> Ordering (from the context I don't see it's messed up already)
> 

Will double check on v2...

- Nuno Sá
