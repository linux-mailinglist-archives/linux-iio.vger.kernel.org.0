Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F06053C95C
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jun 2022 13:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244014AbiFCLaX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jun 2022 07:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244028AbiFCLaS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2022 07:30:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AD53C701
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 04:30:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z7so9735667edm.13
        for <linux-iio@vger.kernel.org>; Fri, 03 Jun 2022 04:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YuoJXxYg+ultqKI/rbWfpD2nyRsY8FPC3rrrS/V1lBI=;
        b=V+VvP6BdV6VIvqj8hvvKykGKwuS0sqSLkRojjzXqm5nNMKIRk4YFHt2RtVq+d7EZtG
         mE3gQcT/3bMcYeuEyxlxJT92bdrFMs5EAVcqzHd1sR3xPoDNna1aqdXuglW6EJP4fo88
         W0d7YHk9/2304kPZRUbSEh98gsi7vcQs7SOjy6rV5oGzV2tD/4Z05uB2TA/34WAr3ceV
         T7MhvUN/sisOq1DpDeAJTp6hAaw9ewL2vHcmy8zhCA+nXuM8SOQTGYFAaR32rfVwU93f
         mWurMieWDYEXuqdxhrS1wTkoShM6M+O0BZ219PKPnGyClt3M0ycxE+sPuXTPxrCTSGpZ
         zKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YuoJXxYg+ultqKI/rbWfpD2nyRsY8FPC3rrrS/V1lBI=;
        b=HupbMOHA7h0nz36sdr+mK8T7kUjVeJrCC+g7ts9CnrW7ChcLkG9fRm7x3U+w4k3bpK
         3u8Q5+eGMrkIqtq4VUtP2bGFmikf3MPW3S48LT2gS2rfUp0xKF97hB0DQvN2/lSGzRXa
         z55GlkJifI6DkdajE0cap5zxEDAmgzXRzB5emEuvbctHnzD1Slo6kYB4dUUgxRLjvHfu
         C4quEepkL9fXiDU6QlsWw37/xgQM1uDTTSexqtg9Qlf/JoMNbl2vK/b3yLc2kKBlTh7a
         2DIb9EwdIXXPEI8063/vk6KrF9aoSVrz7KDB4MIxYqn3Qf+aQHFcyLcQwM5CQmAEKp3s
         aRsQ==
X-Gm-Message-State: AOAM530rrdAoH0LB7xORFSQRX/UWpNC9wZDdNUG0EqQbqcbxEb0imLqq
        MjTu5lu6+uqcbOJJ1oaBjqGILVqFmAW2Ua6f8Ck=
X-Google-Smtp-Source: ABdhPJwq2FvYV2ksnd/O0Vb+e3WvsLK2XfW/bmYj/dRbtXqZH7pYu+o65EXAR/wLVSEtOK2wXj7aJ8DPArZ05yQ6V6o=
X-Received: by 2002:aa7:d481:0:b0:42d:d5fd:f963 with SMTP id
 b1-20020aa7d481000000b0042dd5fdf963mr10219967edr.209.1654255816112; Fri, 03
 Jun 2022 04:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220602140400.213449-1-nuno.sa@analog.com> <20220602140400.213449-4-nuno.sa@analog.com>
In-Reply-To: <20220602140400.213449-4-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 3 Jun 2022 13:29:40 +0200
Message-ID: <CAHp75VeTZNEdokBZXDmGwf0zOqVQY9dnPmZ6_OPV8iKRdWsyPg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] iio: treewide: explicitly add proper header files
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

On Thu, Jun 2, 2022 at 4:04 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> Apparently some drivers are relying on the fact that iio.h includes of.h
> that in turn includes all the headers these drivers were relying on. Fix
> it so that in a following patch we can make iio firmware agnostic and
> remove of.h from iio.h.

I believe it should be split on driver-basis.

...

> --- a/drivers/iio/adc/ingenic-adc.c
> +++ b/drivers/iio/adc/ingenic-adc.c
> @@ -18,6 +18,8 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/of.h>

Ordering?

--=20
With Best Regards,
Andy Shevchenko
