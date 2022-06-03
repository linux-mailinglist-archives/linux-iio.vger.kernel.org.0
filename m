Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E0053CA11
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jun 2022 14:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiFCMf1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jun 2022 08:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiFCMf0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2022 08:35:26 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98D33700F
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 05:35:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so4265820wms.3
        for <linux-iio@vger.kernel.org>; Fri, 03 Jun 2022 05:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=fILpbKwSVybK14RohutE7tjq0XvbmfDBqKV5mmTQXRs=;
        b=aZJm3na+2kdj7l+z6szBug/mlEbeOTJBkiMHtqPaiL/dXHUsmcDZT2HbhPpEgJ3xGz
         WTlzEzzwE9uP6HyQIvs/63wvcuEjDVnMnwJ7ZSlrmvHYi3joe1U13WBR8D5o7nB9D+BR
         vAKlE5X5bBSJJNTc2J4SqOf3FoxfyzHNnsO2uEKkOWtzkOB8gZ0ib70clY7+4kluTE3a
         /aZvBg996RhzLz2JifLwB89aEKXilHvuZ2EM6SI7tEYAwQ++GeuE0UWqXEjZp0ROPjE5
         CE5DwiqJb10PvU1T9piLmAHA0Nh0NnQnCjt+v7bp24YeuCCBpuMFe70PdaQ7Z8PFxOm+
         jgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=fILpbKwSVybK14RohutE7tjq0XvbmfDBqKV5mmTQXRs=;
        b=gzMqzMWH/y7zNyJbjJmteWk96DEHXgbVvjyk6bmaGyzzqN0YSZHP4Vkojuh+ZQNinF
         yT1FhHfjtfI/NhHaeya8Y3LRPgh37WIBpIBBcrpZW5IepxI8fGUnAvb88mQGVPLAyOIO
         DBsZg9mQCbV2p5DAYzjIcAlTCWwTjibq0+o0O2Bu81285OqTaokH+hVsuifjakLJjkHC
         o5C6kv0HnrCk8GGV7uEW8ciEsTs37UM96kQOZ8VCnEBs5AoRCRVG2uSwe1W3K+BzbIuM
         0zq/GaaQGYSOu2jDNMAj3JoML+m4WqVB1dSnadXOCx4/1B47GP8yIDebI1YNyDDNEamn
         InGg==
X-Gm-Message-State: AOAM533aTc5R3AyI2cqMdgqn7mZEsV707cIzyZzXkyfK0bSLRxy5FUrw
        xUopfvSAHH76qOk56cRbqAI=
X-Google-Smtp-Source: ABdhPJxtCw1OsXhHeXd4iCUF+tkyME2LbwtmMy+tr8szOUALpp3YQjZG75eoYjaiJq0GT/ECiGubIg==
X-Received: by 2002:a05:600c:4618:b0:397:84aa:5585 with SMTP id m24-20020a05600c461800b0039784aa5585mr8510827wmo.21.1654259723048;
        Fri, 03 Jun 2022 05:35:23 -0700 (PDT)
Received: from p200300f6ef0219008f4342cbe8c8c65c.dip0.t-ipconnect.de (p200300f6ef0219008f4342cbe8c8c65c.dip0.t-ipconnect.de. [2003:f6:ef02:1900:8f43:42cb:e8c8:c65c])
        by smtp.gmail.com with ESMTPSA id r63-20020a1c2b42000000b003971fc23185sm11587121wmr.20.2022.06.03.05.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:35:22 -0700 (PDT)
Message-ID: <1e5b07dfa4d703ba1faff319be047fbd8b211f56.camel@gmail.com>
Subject: Re: [RFC PATCH 1/6] iio: inkern: fix return value in
 devm_of_iio_channel_get_by_name()
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
        Shawn Guo <shawnguo@kernel.org>,
        Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 03 Jun 2022 14:36:15 +0200
In-Reply-To: <CAHp75VftW=mR17gh=LiODYb7GyGbFFyH7pvpu-WarHL8MXjWZw@mail.gmail.com>
References: <20220602140400.213449-1-nuno.sa@analog.com>
         <20220602140400.213449-2-nuno.sa@analog.com>
         <CAHp75VftW=mR17gh=LiODYb7GyGbFFyH7pvpu-WarHL8MXjWZw@mail.gmail.com>
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

On Fri, 2022-06-03 at 13:16 +0200, Andy Shevchenko wrote:
> On Thu, Jun 2, 2022 at 4:04 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >=20
> > of_iio_channel_get_by_name() can either return NULL or an error
> > pointer
> > so that only doing IS_ERR() is not enough. Fix it by checking the
> > NULL
> > pointer case and return -ENODEV in that case. Note this is done
> > like this
> > so that users of the function (which only check for error pointers)
> > do
> > not need to be changed. This is not ideal since we are losing error
> > codes
> > and as such, in a follow up change, things will be unified so that
> > of_iio_channel_get_by_name() only returns error codes.
>=20
> ...
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 channel =3D of_iio_channel_g=
et_by_name(np, channel_name);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(channel))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR_OR_NULL(channel)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (!channel)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_=
PTR(-ENODEV);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return channel;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Why not make it not nested, i.e. just adding two lines after the
> existing check?
> if (!channel)
> =C2=A0 return -ENODEV;
>=20
>=20

I see, well yeah I guess I can do it so the diff is even smaller...

- Nuno S=C3=A1

