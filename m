Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD9153BACC
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jun 2022 16:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbiFBOcs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Jun 2022 10:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiFBOcr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jun 2022 10:32:47 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C6A27CCF3
        for <linux-iio@vger.kernel.org>; Thu,  2 Jun 2022 07:32:45 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x62so6512715ede.10
        for <linux-iio@vger.kernel.org>; Thu, 02 Jun 2022 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O9ZkbBNgOsEe1U27TrmbDRsH84lapUKdItJ5Qcs7VA4=;
        b=fdpSWkrzZuVnU+VKZttKaX0BYbzZVHO+asdXxOJ0v9OklDFOqBjtG/+bMNXIRbayTO
         j5vch6MgrkBs9ngptE+3k3pIQsdgu/WETyvnWcvKdKeXvqYteKzg5Ks9nM9G1iDpHX87
         3W3ekVG1wP7T+rcxRbvTVozZj7O/aAzCvt0R2EnY5p7UIMckkGSCsLmi7NpXwVSk1Snq
         nm1Q2q5j0p9BYLitOXKlRws/SLY3YiEiRwR6vTkFRIwfre9p4DyNtv3yJFBXNb4wwt+T
         bLTzk3IpZBKOMlb1QAQ5QmTZnsRP8u2+oOO/xh2hmnO1VFdMlSiGYCh4tyHBpR+VT1R3
         MhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O9ZkbBNgOsEe1U27TrmbDRsH84lapUKdItJ5Qcs7VA4=;
        b=UAGitBBevpcrL/Ieb3yk6ca26AwXNk/4q24swFhkYMiZuG5xunruXtYsL8WscfpkF0
         7RVGU55jaRSl/kxZbghBuAA+PqIhqAUIfcUmgXk3YMOaekLeBhnK5BADnjS8CQJBCdpr
         6TrT286qbavBjrgaXWDvTUNiRRBtjW0fuMs98lqdDKc6ix1it5Z2+tUkczQvCvZIY/op
         ZBPqtgRIUsCkrmzAn1TILTfbM0pnCRrIuv+v4VYZcoo+ljGMtNwzt7FCKBMFbS79ksur
         3szd1IcU9bbjFBN4sMS+0APtqd4M70Np/8YkSJrs6nJtzJu42ArH6i4TCYSE6mfWg1DP
         /FQw==
X-Gm-Message-State: AOAM5308nEvyp6xuo/vH+xFuhKDqQOx7KGCaeW+4B9OrhXqJdDY7Mdtz
        cMEFsbiwC4yh7JVeRSdSbXAzpcwnXhVTiGl+ssY=
X-Google-Smtp-Source: ABdhPJzIqJ+qGxEqLGGK43yFH99HkhiKtSA5fgYQwduddz+GleGA45x7nG9NwK5vLVU76uSuuE/+v5QDtcFFkkIFiL0=
X-Received: by 2002:a05:6402:11d2:b0:42d:e68a:eae0 with SMTP id
 j18-20020a05640211d200b0042de68aeae0mr5747460edw.111.1654180364486; Thu, 02
 Jun 2022 07:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220602140400.213449-1-nuno.sa@analog.com>
In-Reply-To: <20220602140400.213449-1-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Jun 2022 16:32:08 +0200
Message-ID: <CAHp75VcuNo2OTUFZjCn2_M4Ku=C3-vDm3F0p0wPjS7_5gMNXmw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] iio: inkern: make interface firmware agnostic
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

On Thu, Jun 2, 2022 at 4:03 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:


You have in the addresses:

Gwendal Grignou --cc=3DDmitry Baryshkov
<gwendal@chromium.orgdmitry.baryshkov@linaro.org>,

I would recommend using my "smart" script [1] that makes the list automatic=
ally.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.=
sh

P.S. Patches are welcome as usual :)

--=20
With Best Regards,
Andy Shevchenko
