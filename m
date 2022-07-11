Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45A15704EE
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jul 2022 16:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiGKODi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jul 2022 10:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGKODh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2022 10:03:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D249656E;
        Mon, 11 Jul 2022 07:03:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r10so994980wrv.4;
        Mon, 11 Jul 2022 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=/s/OGdlF8gDduadx4LnZlsIPtzs9KiJR7EJ+peqCSpc=;
        b=f7S5z3cJiEVRqzrgIcyYJ0WR48nsA/Ndj1Rkr2kt+NBRFf5eg2uWQrd/MXBzfhne0y
         iwh/biJoo/tUnIBZ59D1UJ2MZhAd0MJTzEororHJvT2kKF7rr+wcIRgEfNSE1+2a6p7G
         OTHEuRl5gLgHP31ivAK1JB/JwBHsZMpAlTnI0rp0AP169bYRyzn0Sbgo3owVHS/vUchj
         bn51mIT64xCPri2REasD0Ixtyf721cJrRYoZotxL7o5vXaQqOL0QF2Kg8IOgZvG+YLsK
         jE3UtLdrl5C2cRH0WAbkqmpFI93w/iA4Kl4QpyYBkAtSdwo2/ZUzjWYGfJgdmdkKZaYX
         wW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=/s/OGdlF8gDduadx4LnZlsIPtzs9KiJR7EJ+peqCSpc=;
        b=VT9PofihCGSBVrNnNF2ymS3jQiF+OnOeMKTtpkOS+hW779ApvEumkrXKfFgkGWVnKw
         WW7kU7lBeaRUnzJq3d5rt+kaZZu0EDdLQGRJit88HgKISzBUjhA0xLHXkRDB+yiI+dYr
         Zp2gLpT0szMt+3yQX/U3CcHNdnuY3LC6t5xP5JmpVJCURg+AkNT+cE9LEizIpQeAaKrq
         UE9AL+F3pnChLOUD9BcJ7QWDGE+GIiKB7y4TgPYtU3pIgGAM/Topk4kwivxwpA1Ocb35
         VQoOqqkvOl2zdKaQ39sxUypWnQnGZctPMG9v0zBUfhLRweygJpZS/LREKw2X8Az0JvyR
         a+3g==
X-Gm-Message-State: AJIora9WILWlOWgDxaQs67DItm/SefQASaG+EEv7XbHkzXN9pjUDM7W1
        ATgrhxhM44gEny0Ava8E0LY=
X-Google-Smtp-Source: AGRyM1uVKiSNZ63xvM1SkZGg8MDD3NqDak8QVg5CmjgLLJR/63rBoop6xkxZjGyO50qafCZExu5qgw==
X-Received: by 2002:a05:6000:a0c:b0:21d:a699:d54e with SMTP id co12-20020a0560000a0c00b0021da699d54emr5172920wrb.605.1657548214450;
        Mon, 11 Jul 2022 07:03:34 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d4d4d000000b0021b91d1ddbfsm5816067wru.21.2022.07.11.07.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 07:03:34 -0700 (PDT)
Message-ID: <8417d206124ba823a907bd27f4f6ce53a9080249.camel@gmail.com>
Subject: Re: [PATCH v2 00/15] make iio inkern interface firmware agnostic
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        chrome-platform@lists.linux.dev,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Andy Gross <agross@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Fabio Estevam <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Patrick Venture <venture@google.com>,
        Amit Kucheria <amitk@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 16:04:35 +0200
In-Reply-To: <CAHp75VeMXP1WyQcFQU_RW-a_CSGVMF_NsgHtLEbL8hi-n8gSVw@mail.gmail.com>
References: <20220711123835.811358-1-nuno.sa@analog.com>
         <CAHp75VeMXP1WyQcFQU_RW-a_CSGVMF_NsgHtLEbL8hi-n8gSVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
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

On Mon, 2022-07-11 at 15:22 +0200, Andy Shevchenko wrote:
> On Mon, Jul 11, 2022 at 2:38 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >=20
> > First version of the series can be found here:
> >=20
> > https://lore.kernel.org/linux-iio/20220610084545.547700-1-nuno.sa@analo=
g.com/
>=20
> I'm under the impression that I gave tags for some of these patches
> when they were the part of the bigger series. Am I wrong?
> In any case for patch 6-14,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Yes, you're right. Should I have dropped them?

- Nuno S=C3=A1
