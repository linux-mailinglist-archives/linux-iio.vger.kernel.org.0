Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AB553BAB3
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jun 2022 16:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbiFBO13 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Jun 2022 10:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235876AbiFBO1V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jun 2022 10:27:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FACDC82E
        for <linux-iio@vger.kernel.org>; Thu,  2 Jun 2022 07:27:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id f21so10280536ejh.11
        for <linux-iio@vger.kernel.org>; Thu, 02 Jun 2022 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rznpIuwiQWYU8RsZfiZ4gWz8NQ8N61s84ztL+4LkNPo=;
        b=AIZukQ71+7f/FijSc3x7BPKDI53rIlibA0VvAI9OMxXlrZj7/Izo3HsvAOH3AsNIFh
         0f9nfIgwIcotm1sJCk6TT8Xzl5hd0u895IbubeOY4GcuPKMQ75dj7oo6wuHLSa/6QH8w
         47eMbVq/DYrkz/OhoGRxhyKLZGN5I6TgxYbQ4XnaIJbsSOuwY/yW9DeyT2d7AzrvXdZw
         OF1CdlYKi0yt3onq0ZFPtaS0FnVNopyuSBBCcoU9ve4TPQiXxXcV/+uwbX09FvOaOH3g
         Hjk3/1owC4n0iyoEJKVYWr3QR1qBGXqP1ydkggcudmGSZEptMKeTOBW7qrlgCh5vSrov
         XZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rznpIuwiQWYU8RsZfiZ4gWz8NQ8N61s84ztL+4LkNPo=;
        b=LbSe8c7PPyTmcFUvK6/AqpcZQcGznb4fI2rWw7+0XWVma/39JHI5BN/JQWZcGReh6i
         IaLe/m++fGNf0H02ckFIA4O76mIj+cUjUV7ADAuajz/CvJ8bKc//G9MTnxe/88viniT3
         dnx6FDEwZQjgiqN1GYhUF+5jwnA3Di3TozUshP2S4+XL0nXW+a0xeLMgOvkBlH0Y2KOA
         oD+JUD2SYx/ve2y24Y+3NTBmipkWy5oUzCSP2ctdv6AcLmrv+QJUUC4VncWdRN3oQNVM
         XtTPF8Lm08wLfxIaJyBHatu9GN/KOTGnLNpgYQe/tdV9PeCA7F3Z+eNPLjj1CIMrqfj6
         97HQ==
X-Gm-Message-State: AOAM531NQgYdQyOiFapqyC47GAJYUK7XIgbNUOYLpGET5kFc716NFVZJ
        4vP9MWl2iUZmgGcxzE7iUImVFaqPq2an4n3zRRk=
X-Google-Smtp-Source: ABdhPJzz0cIWpYPSn1xnzqznQdXHnG9PcLLc+V71cqhSlSwdWGUyMbv1wRUuawOoMIVyK+cTL7kFjrOTvEFD4yyRtiI=
X-Received: by 2002:a17:907:6e1a:b0:6fe:f357:3837 with SMTP id
 sd26-20020a1709076e1a00b006fef3573837mr4670877ejc.44.1654180035720; Thu, 02
 Jun 2022 07:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220602140400.213449-1-nuno.sa@analog.com>
In-Reply-To: <20220602140400.213449-1-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Jun 2022 16:26:39 +0200
Message-ID: <CAHp75Vdf9Nrd31MYo4_b2M8bu3N2iUirhbzTc7t=X-pyMzkfHQ@mail.gmail.com>
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
>
> The main goal of this patchset is to convert the iio inkern interface to
> be firmware agnostic.
>
> In the process of doing it, I discover the bug solved in patch 1/6 which
> also served as motivation for patch 2/6.
>
> Note that patch 3/6 is touching multiple files at once since the changes
> are very simple. I can separate it in several patches if that is
> preferred for better tagging though.
>
> The same can be said for patch 5/6 even though in this case it will be
> more cumbersome to separate it in several patches (we will need to
> temporarily support both options; convert each driver separately;
> remove of). I think the changes in the drivers are simple enough that
> we can have it like it is now...
>
> Lastly, this is only compile tested with allyesconfig for arm and arm64.
> While I surely can come up with some dummy devices to make sure I can sti=
ll
> properly get IIO channels, having proper tested-by tags on platforms
> relying on this interface would be very appreciated (and I suspect Jonath=
an
> will require it).

Thanks! I will definitely have a look into it later on.

> Nuno S=C3=A1 (6):
>   iio: inkern: fix return value in devm_of_iio_channel_get_by_name()
>   iio: inkern: only return error codes in iio_channel_get_*() APIs
>   iio: treewide: explicitly add proper header files
>   iio: inkern: split of_iio_channel_get_by_name()
>   iio: inkern: move to fwnode properties
>   iio: inkern: fix coding style warnings
>
>  drivers/iio/adc/ab8500-gpadc.c                |   7 +-
>  drivers/iio/adc/ad7606.c                      |   1 +
>  drivers/iio/adc/ad7606_par.c                  |   1 +
>  drivers/iio/adc/at91-sama5d2_adc.c            |   7 +-
>  drivers/iio/adc/berlin2-adc.c                 |   2 +
>  drivers/iio/adc/imx7d_adc.c                   |   1 +
>  drivers/iio/adc/imx8qxp-adc.c                 |   1 +
>  drivers/iio/adc/ingenic-adc.c                 |  10 +-
>  drivers/iio/adc/mp2629_adc.c                  |   1 +
>  drivers/iio/adc/mt6360-adc.c                  |   1 +
>  drivers/iio/adc/npcm_adc.c                    |   1 +
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c           |  14 +-
>  drivers/iio/adc/qcom-spmi-adc5.c              |  13 +-
>  drivers/iio/adc/qcom-spmi-vadc.c              |   7 +-
>  drivers/iio/adc/rzg2l_adc.c                   |   1 +
>  drivers/iio/adc/stm32-adc.c                   |   7 +-
>  .../cros_ec_sensors/cros_ec_lid_angle.c       |   1 +
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |   1 +
>  drivers/iio/dac/stm32-dac.c                   |   2 +
>  drivers/iio/dac/vf610_dac.c                   |   1 +
>  drivers/iio/humidity/hts221_buffer.c          |   1 +
>  drivers/iio/inkern.c                          | 240 ++++++++++--------
>  drivers/iio/light/cros_ec_light_prox.c        |   1 +
>  drivers/iio/pressure/cros_ec_baro.c           |   1 +
>  drivers/iio/trigger/stm32-lptimer-trigger.c   |   1 +
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c      |   3 +-
>  include/linux/iio/consumer.h                  |  28 +-
>  include/linux/iio/iio.h                       |   7 +-
>  28 files changed, 200 insertions(+), 162 deletions(-)
>
> --
> 2.36.1
>


--=20
With Best Regards,
Andy Shevchenko
