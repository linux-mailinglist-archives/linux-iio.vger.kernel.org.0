Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB92546D91
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 21:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348475AbiFJTsb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 15:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiFJTs1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 15:48:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA121F5ACE;
        Fri, 10 Jun 2022 12:48:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o8so9962835wro.3;
        Fri, 10 Jun 2022 12:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Uw42AgxCz2OX29JjZrfK1zeziXwl4MAn7te6Qnb21ik=;
        b=VnmBwWKvliqZ17mqAO3YFUhuijHFVCA0X/6JoDEeNmtQ5fuB2ME76Abp7kguBl57K7
         M9/alivbnhSTovq/B//wCei53pyxQ+HtrJaffG1iGtF9Ndaudu7kcr9ovspAlwBkBSrl
         Qk8wAlB8QCS5xW3y97CMGT7D89Ky4udjBupXK19Q8pH4R+6TZMpKLOBEkE6ub91Xaf7Y
         S7oL2lI6/EzqlSBNis27lv8/Z8dTYnHGhUC0YHRirC4Dqxm1vVmg/6fapPeKzP00VvFU
         tNNMy6jrpva6Bk+UcwypSwoLQSKLiQbVV7FbXXq9G/VEvyzMlVefQmke6B2XscRqIWLl
         voDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Uw42AgxCz2OX29JjZrfK1zeziXwl4MAn7te6Qnb21ik=;
        b=viRo3WeJy74s7+9G4goKaz4xU7SIC/gnAlJfz/aL2I3JmaVBDaXHkPhW5Jk9QA6xTM
         Ul+gvPTO98PLjwGrHRPcSyZZUsz6yP6TWC1lk3cAX42DV/sKK6yMdBUd2m70XuV3r3B3
         6GRp2rWNGLEkwdOa1ZV15yhuLRDz9K3NARb/g13isY0jsv1Z0umOGH45+c+8q8GB0J3I
         iMUDEYi/OvDzCEXbz+1mWD9jEibjP+aDX8qHFLkTl9q5o9N/pDKNdGDz/0+zG9ZR3tEE
         1hq+ebtYKlwcWoAaEKuNxQpsfisBMtu1MAhHribarnFBqRMZFJbBeoDXkRd+FSFV2Xb5
         tyFg==
X-Gm-Message-State: AOAM530TFki8uH5pJTgc2rGLT2DQZU7A0AgcZa+kUmnV4jZDZuq8WcPz
        GC+2RVgy3rqOiEQiqrpmqR6s04wOIplw1gGZ
X-Google-Smtp-Source: ABdhPJy5G62/5XmSgGYkKL4gT5Hd/Ethb/qClZrbwW5M3Zb4SLtoP92M/h2fB9W3tywpi7sFv5O92A==
X-Received: by 2002:a5d:5983:0:b0:218:519e:78a5 with SMTP id n3-20020a5d5983000000b00218519e78a5mr20645990wri.718.1654890504947;
        Fri, 10 Jun 2022 12:48:24 -0700 (PDT)
Received: from ?IPv6:2001:a61:136e:3c01:8bd4:cf6f:76f1:a861? ([2001:a61:136e:3c01:8bd4:cf6f:76f1:a861])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d6503000000b002103136623esm257905wru.85.2022.06.10.12.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 12:48:24 -0700 (PDT)
Message-ID: <25e286370d34419c3fc32a75896d5bfebc4128ea.camel@gmail.com>
Subject: Re: [PATCH 22/34] iio: inkern: only return error codes in
 iio_channel_get_*() APIs
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
Date:   Fri, 10 Jun 2022 21:48:22 +0200
In-Reply-To: <CAHp75VcPoZ4FKTwDN_F76EZAcWYzAe1CHmuRuaP0wg3BgmPtfA@mail.gmail.com>
References: <20220610084545.547700-1-nuno.sa@analog.com>
         <20220610084545.547700-23-nuno.sa@analog.com>
         <CAHp75VcPoZ4FKTwDN_F76EZAcWYzAe1CHmuRuaP0wg3BgmPtfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2022-06-10 at 17:05 +0200, Andy Shevchenko wrote:
> On Fri, Jun 10, 2022 at 10:48 AM Nuno Sá <nuno.sa@analog.com> wrote:
> > 
> > APIs like of_iio_channel_get_by_name() and of_iio_channel_get_all()
> > were
> > returning a mix of NULL and error pointers being NULL the way to
> > "notify" that we should do a "system" lookup for channels. This
> > make
> > it very confusing and prone to errors as commit dbbccf7c20bf
> > ("iio: inkern: fix return value in
> > devm_of_iio_channel_get_by_name()")
> > proves. On top of this, patterns like 'if (channel != NULL) return
> > channel'
> > were being used where channel could actually be an error code which
> > makes the code hard to read.
> 
> ...
> 
> >                 np = np->parent;
> >                 if (np && !of_get_property(np, "io-channel-ranges",
> > NULL))
> > -                       return NULL;
> > +                       return chan;
> 
> Shouldn't it return a dedicated error code and not some arbitrary
> one?
> It may be I missed something and chan has a correct error code in
> this
> case...
> 

Since in this case we won't look for channels in the parent device, I'm
just honoring the code returned by 'of_iio_channel_get()'.

> ...
> 
> > +       if (nummaps == 0)       /* return -ENODEV to search map
> > table */
> 
> Comment is superfluous, the next line is self-explaining.
> 

Well, I agree. I just kept as it was on the original code. Can hapilly
remove it if no one objects against it.

> > +               return ERR_PTR(-ENODEV);
> 
> ...
> 
> > -               if (channel != NULL)
> > +               if (!IS_ERR(channel) || PTR_ERR(channel) == -
> > EPROBE_DEFER)
> 
> Btw, in the GPIO library we have a macro or inliner (don't remember)
> that represents such a conditional.
> Perhaps make it (if it's a macro) global, or introduce an inline in
> IIO?
> 
> Okay, it's here:
> https://elixir.bootlin.com/linux/v5.19-rc1/source/drivers/gpio/gpiolib.h#L179
> 
> It's similar, but not the same, so just play with an idea to
> introduce
> something in this file, maybe it's worth doing this, maybe not.
> 

I would also argue that could be something done after this series gets
applied...

- Nuno Sá

