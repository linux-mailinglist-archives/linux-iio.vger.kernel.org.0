Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BBA53C5B0
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jun 2022 09:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiFCHDH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jun 2022 03:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242382AbiFCHC0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2022 03:02:26 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4431AE0B5
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 00:01:41 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id m68so5310580qkb.9
        for <linux-iio@vger.kernel.org>; Fri, 03 Jun 2022 00:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=N5xsoYBV3lSp1U/+3RPiHE/wJEf3dxmtwPALgs4Sv2U=;
        b=QD7+85CehX7ukV1Swrao0kFRgOpxZI5PYq/PJdKpAF45xe32GiYidjnMBfN3ArZg9N
         LOjKMuSDXshr93GNWMNMkdI4M0NqiGmINbN6YQAtVKzaHF7SFPxtaVFoBAHwjkJSmUdg
         scVRw3784S4jLw8wi26UPXUHBaYTU8qD79qXi7z8yoAqXb2JMhjECR7vWRbAWtWusIGD
         f/IfyKfRbvKrEhY81EoAWPkftATkhtBjVdkA0PP87bs+VzFxv27CLP5sUiwM1ZxbRS1Z
         k1KaYCAod2HzQP4h/TPFobKEcm877Y0WGEYihriFUKJu1/E5+J/JJDMnkSCONZr9hDqs
         lkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=N5xsoYBV3lSp1U/+3RPiHE/wJEf3dxmtwPALgs4Sv2U=;
        b=7tZohNzjYYb38zfgDWtzKrbLHJHR+6SjDNyqqz5gSiA9IDg7kXszpjXMV5myt0Bztb
         cPWDItNn6XmBNCmNxTK7Dc/KUuks2nrijAKHvVZTnDjKfKtiUBH9JioJxSCiUJy7rkNL
         hVu3HBKhHyXvTTHQL14sx8v//aqwVJx42Ht0hW1SruN+lbVEr03YmI8/GCw123L0xv3Y
         2E1w7GCNlF9aCEEUk8+qMZuaQPm95W86pxbP7TOSfi3DyF/I3FtsJ3a3GYzOHsh6z2YE
         RiUykaSrVyfhRhyNbt6atvBgickXBZOTJpMLFul7FgsVipC8c9lC8yNS9uePX+dlhGzY
         FHiA==
X-Gm-Message-State: AOAM53295Es9RbLlGNL9RRHSpbJR9MfG0NiG3BYozJqDW3u43QwIvQrC
        9goVcYmDf9f1tu41WLBzzhtKDACeD35l8G9U
X-Google-Smtp-Source: ABdhPJyHwB35JHojYTaAXAEpWThg3BKvz25XvtbtBgMYTFcgC/CFAvIxMM/bF+2hkzhPxUOua6wPMQ==
X-Received: by 2002:a05:620a:2047:b0:6a3:3063:aa29 with SMTP id d7-20020a05620a204700b006a33063aa29mr5792618qka.144.1654239700331;
        Fri, 03 Jun 2022 00:01:40 -0700 (PDT)
Received: from p200300f6ef0219008f4342cbe8c8c65c.dip0.t-ipconnect.de (p200300f6ef0219008f4342cbe8c8c65c.dip0.t-ipconnect.de. [2003:f6:ef02:1900:8f43:42cb:e8c8:c65c])
        by smtp.gmail.com with ESMTPSA id n2-20020a05620a294200b006a6a3f1548bsm50577qkp.54.2022.06.03.00.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 00:01:39 -0700 (PDT)
Message-ID: <83723eeb824ff283d0109dce5d80222eb704c99f.camel@gmail.com>
Subject: Re: [RFC PATCH 0/6] iio: inkern: make interface firmware agnostic
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
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
Date:   Fri, 03 Jun 2022 09:02:28 +0200
In-Reply-To: <CAHp75VcuNo2OTUFZjCn2_M4Ku=C3-vDm3F0p0wPjS7_5gMNXmw@mail.gmail.com>
References: <20220602140400.213449-1-nuno.sa@analog.com>
         <CAHp75VcuNo2OTUFZjCn2_M4Ku=C3-vDm3F0p0wPjS7_5gMNXmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2022-06-02 at 16:32 +0200, Andy Shevchenko wrote:
> On Thu, Jun 2, 2022 at 4:03 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>=20
>=20
> You have in the addresses:
>=20
> Gwendal Grignou --cc=3DDmitry Baryshkov
> <gwendal@chromium.orgdmitry.baryshkov@linaro.org>,
>=20

Oh crap :facepalm:

> I would recommend using my "smart" script [1] that makes the list
> automatically.
>=20
> [1]:
> https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh
>=20

Interesting, though I'm giving a try to git-publish [1] and integrating
it in your script might not make sense. Still there's definitely some
stuff that I can use from your script to keep me doing this again.

That said, What's worst is that, somehow, the patches still did not
make it into the mailing list. I will wait a bit longer and try to
resend them...

[1]: https://github.com/stefanha/git-publish

- Nuno S=C3=A1

