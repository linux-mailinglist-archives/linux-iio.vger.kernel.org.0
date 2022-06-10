Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC84F546D9E
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 21:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348711AbiFJTvV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 15:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348190AbiFJTvU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 15:51:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AB11A0495;
        Fri, 10 Jun 2022 12:51:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id fu3so4251ejc.7;
        Fri, 10 Jun 2022 12:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bNY4bb5ZsDGbijlscX/zWHp76bvVhoKTJQjCK2gLBow=;
        b=DTARzN9ZKxLbpM5DnF604iI8/F/84/wIKw08CbQfw05YnVX88YGW6HVfBxQNHvMu4T
         MLrV3I1t6KM5Qc6HlnyeXHSTGoq8+8DaWtqoRUwsLbX6Mzc8EpX122ha3qRBRoFfEqzN
         Jk0f/3X9FLtgjhjaqJKanWVijWyNNRgDw6pmj5+2xfApIvc2SRAwOjLitceTonJ4eGE1
         a1A9wbvVgJFRqD/0S50YXqjQh+yziCS7x5lzFW9SKapPD3uUc9it44OjhImJd8j2+oZt
         Butz14g0HcCbwqNDkTuGrH/EVS+NkDJB41ZnGmOfym00EegEpO7qNAqhl52gA+RezkJc
         GTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=bNY4bb5ZsDGbijlscX/zWHp76bvVhoKTJQjCK2gLBow=;
        b=QqF1oYqxdj/8A49hslJ2q/OFkVEcmh9wT87J9OgJ577UXH8vNwpEF0zqOKGOrQUeS0
         +fSwF741JqdfBJekKrkMmuLJgnV0oTp6stxUIsorbS/qFTztgeIDK7AJfwuyDK77KuUt
         N/PTEEopPV4z68Sd4vCTUnfr17Ce2JcN4X/DXeVYIYrUBckMajMubyZSczTgF2ZE8aMj
         ZFwMsZ5OXcfMTNmBmjXEAuaYYkcJL59wpSTSgosPLgCvmdP4nKC9JwanyoDRufgwz1aY
         BxU0nmj3UNbr0jjEri1244So8EY0KGqAim5/T2BwQO0eUog3vKP3ImrmYqe+LIXFh9sg
         iWUQ==
X-Gm-Message-State: AOAM530cYdHQrLXISQwslZhAtTKr/UovRXqtYqz/ENC+JujLKq7tGTjB
        sIaK4Hb8uSXYj0r41POte4Y=
X-Google-Smtp-Source: ABdhPJxHRykgXinV3uoaEPm9Ud4a9M4gnh2v3qf5U98udrI7NhTVLe93fDw1Gnx05NF5PsnFjGIIwQ==
X-Received: by 2002:a17:906:51d6:b0:712:c9:8a1b with SMTP id v22-20020a17090651d600b0071200c98a1bmr10665567ejk.656.1654890677793;
        Fri, 10 Jun 2022 12:51:17 -0700 (PDT)
Received: from ?IPv6:2001:a61:136e:3c01:8bd4:cf6f:76f1:a861? ([2001:a61:136e:3c01:8bd4:cf6f:76f1:a861])
        by smtp.gmail.com with ESMTPSA id ck16-20020a170906c45000b006feb20b5235sm12715703ejb.84.2022.06.10.12.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 12:51:17 -0700 (PDT)
Message-ID: <d083dd2c7e9e6eefb32124648a06799a9ebe8dfd.camel@gmail.com>
Subject: Re: [PATCH 34/34] iio: inkern: fix coding style warnings
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Joe Simmons-Talbott <joetalbott@gmail.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-imx@nxp.com, linux-renesas-soc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        openbmc@lists.ozlabs.org, Cai Huoqing <cai.huoqing@linux.dev>,
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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
Date:   Fri, 10 Jun 2022 21:51:15 +0200
In-Reply-To: <YqNo6U8r80aNFzUr@spruce>
References: <20220610084545.547700-1-nuno.sa@analog.com>
         <20220610084545.547700-35-nuno.sa@analog.com> <YqNo6U8r80aNFzUr@spruce>
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

On Fri, 2022-06-10 at 11:53 -0400, Joe Simmons-Talbott wrote:
> On Fri, Jun 10, 2022 at 10:45:45AM +0200, Nuno Sá wrote:
> > Just cosmetics. No functional change intended...
> > 
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> >  drivers/iio/inkern.c | 64 ++++++++++++++++++++++------------------
> > ----
> >  1 file changed, 32 insertions(+), 32 deletions(-)
> > 
> > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > index 7eb536560ded..526519cefcb9 100644
> > --- a/drivers/iio/inkern.c
> > +++ b/drivers/iio/inkern.c
> > @@ -45,13 +45,13 @@ int iio_map_array_register(struct iio_dev
> > *indio_dev, struct iio_map *maps)
> >         int i = 0, ret = 0;
> >         struct iio_map_internal *mapi;
> >  
> > -       if (maps == NULL)
> > +       if (!maps)
> >                 return 0;
> >  
> >         mutex_lock(&iio_map_list_lock);
> > -       while (maps[i].consumer_dev_name != NULL) {
> > +       while (!maps[i].consumer_dev_name) {
> 
> Shouldn't this be?:
> while (maps[i].consumer_dev_name) {
> 

Ups... Nice catch! I was probably in bot mode already.

- Nuno Sá

