Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF9E54CB48
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 16:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244177AbiFOO1B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 10:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241582AbiFOO1A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 10:27:00 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6796945042
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 07:26:59 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-316287dc2d2so31051937b3.6
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 07:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xMSeDjVBl8Op1MiME+3ol3t5KwHqA10J2T41KnFjWVI=;
        b=qz4+2/j3HuKLbz8sDkEIpH8ZLP9Jo8DhJ+Q2ht5CP+YvOT59Zf+re5Tujl0ZB6ZFPL
         6eIRF/MkMH9d8XYNP4+51SwLnjpzBos7nFmTYB8Ul+O4d2U6PeoLZ7QjQijKEZ8jLm95
         SELWUDdWwSs1Mh2zeOOA3+M0iUdmkybKKFT7IjVpsD5/9ncX5E7fGGraLMKtF7YFOE15
         3ZsziFepyBJtS+OHCqnLHN05xHlLU+0K7/YCV5W8FlGwHDwuOBWTMVvTFAoqv5pVaZxz
         Rpqrs1a41xszHea5Bvl2plED3iCFlGdMsfyTuDfKIA63BBNAp8s43G582spKqlDGmWXf
         4qPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xMSeDjVBl8Op1MiME+3ol3t5KwHqA10J2T41KnFjWVI=;
        b=H6/G1HpMGt5aZxu4XHbgAlvDl1mKuht+zVbHmDySuOcJq834sstIK3elMD6Uw0nOWc
         TVGq4YC1deW3cGCKGbLP2F1ikGUpTgGyJ+G8Rju/7kBIzq+riSccHCADa9pPSeffTonH
         kfMWzq5rWwBAwkzVc53HrgRpDClIdG5z5PxOq1MvozbPr/5/Pr00FEYbr4VDsUUSsPHp
         iQwbnZk/2pUaje0jR0mOzC1JVQbE8d3WNqwMlo23kkToX7aOYfPUHEkryXpi4KwXwPrB
         NQdztT7HMajvV1XII7hr/Kgm2GbWS8Vf6bKSfqB+M0gGcc7TMVEoc90+r+9WXmaYmwU/
         DrvA==
X-Gm-Message-State: AJIora8fn2/Ceei+SWOWh7b67kpH7ySVEVMug7eZwjAfbcbAeWVPkNar
        l/ilQj2nkPCD+GvT2LHD+YSQjeVjHvFn1JCvI8F/GA==
X-Google-Smtp-Source: AGRyM1uf8yFhBnEUo8jDPf5ukxxTZvvQvwcMTtNGMVxYlbJA7mSO+23X9N9/rXSOE+V75SpZAwzwan4QnL+Hc3y01yY=
X-Received: by 2002:a0d:e246:0:b0:30c:5e77:7104 with SMTP id
 l67-20020a0de246000000b0030c5e777104mr12571722ywe.448.1655303218482; Wed, 15
 Jun 2022 07:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220610084545.547700-1-nuno.sa@analog.com> <20220610084545.547700-28-nuno.sa@analog.com>
In-Reply-To: <20220610084545.547700-28-nuno.sa@analog.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jun 2022 16:26:47 +0200
Message-ID: <CACRpkdYVqsEdDDHLSkfJzMDPbPgkVihxa+ukLg1XnoyGghcdoA@mail.gmail.com>
Subject: Re: [PATCH 27/34] iio: adc: ab8500-gpadc: convert to device properties
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 10, 2022 at 10:48 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Make the conversion to firmware agnostic device properties. As part of
> the conversion the IIO inkern interface 'of_xlate()' is also converted to
> 'fwnode_xlate()'. The goal is to completely drop 'of_xlate' and hence OF
> dependencies from IIO.
>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
