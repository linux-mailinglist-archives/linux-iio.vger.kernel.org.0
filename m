Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B054353C99B
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jun 2022 13:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244096AbiFCLw5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jun 2022 07:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241403AbiFCLw4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2022 07:52:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA1D1C113
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 04:52:55 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id q1so15434721ejz.9
        for <linux-iio@vger.kernel.org>; Fri, 03 Jun 2022 04:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bs93fY/foEywu4lUw4CVKkhmrPneTFg28BrZIWCOUYk=;
        b=Hrt8WO1BuqrdNvhQI3M+pKXs5/pndoPsJ3aYHvjEZelDOio9130bHoGeocLdXcPSPT
         APkVfB6kYzONK7SHnAbaQsAjUrtBXkdtSy9Lv8YIDT3Mfvnod7wdCdKXOCj/AJ0MSkII
         Wld+VXXnetwMWgxhDdlXQfA1k90zm6RpRa/H7SPJv/hnPuJ+lmHm5Fi15/7bCop5osVu
         nkzLggqzRWf8AG8DhcHKMXAuESlinxB5SLoIih5ijeOfYJePKaaNlEbvMaclo/6KH0uI
         0EnPpajxixqPhTqtrIf5l0VaCYHqf1or878UhbvJmZgU9dG3p262OdW+FP4ZCMKkJ58l
         gGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bs93fY/foEywu4lUw4CVKkhmrPneTFg28BrZIWCOUYk=;
        b=FJcowU7Z5YTcTC3j+6INwcgE5FibKc/UYm1ROIKbX6C8XZBHNRcp8AWcz6jKtxviXz
         HuGLh/Udfc07hEXkCQPBVvRShY57BOh5ka6/coEytZna65FrICXr7lITlSsAUh2jWjIp
         litu9rN3WWP0Vrx9Ki5GfzyqpjCHofUpOLB+xVMMnXE3uFxTovFi1kiolscMalvsPxmk
         43yeSxUHt1qLEJuMbzCK32IzLgc+Oj8JkNG3QLHmLj7IvWjPXGTo/h6lBeG7PAVv3iPW
         JVPApcBA1bJo82eIEHH5CQdDsMCtv12SWtUECyVM9o5NeoOgEa6TLuVcI62YRct24K1r
         BhPg==
X-Gm-Message-State: AOAM531qgWs1NaVMQkD+QBq+xERXAaAXq8ZYdhYSotdekK6AWclHklTV
        SAEydUiwug7CRmCcAmgQe9FlJiNpK2OIpc8ohHA=
X-Google-Smtp-Source: ABdhPJxtx10G5V/MCYn0kNXfHBTWzBkbS+I3yCVUhG5dCu2/KSjMiwdOxMGxI5be1qZc5mPJuO/RQy3MF1fC9FMURkQ=
X-Received: by 2002:a17:907:6e04:b0:6f4:d6f3:c72a with SMTP id
 sd4-20020a1709076e0400b006f4d6f3c72amr8489833ejc.636.1654257174201; Fri, 03
 Jun 2022 04:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220602140400.213449-1-nuno.sa@analog.com> <20220602140400.213449-6-nuno.sa@analog.com>
In-Reply-To: <20220602140400.213449-6-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 3 Jun 2022 13:52:18 +0200
Message-ID: <CAHp75VeHwqbNTMfWA03-epKaksPNgRrXh3f5hktEE0u6qjPyyw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] iio: inkern: move to fwnode properties
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
> This moves the IIO in kernel interface to use fwnode properties and thus
> be firmware agnostic.
>
> All the users had to be naturally updated to the new interface exposed by
> IIO.

I think you may split this in an easy way, i.e. convert core to
fwnode, while providing inliners for of_node cases (like it's done in
IRQ domain) and then remove them after conversion.

I think of_xlate is not needed to be touched at all. Let it die with
OF altogether. Yes, it won't be fully OF-independent, but it will down
the scope of the next change where you can convert of_xlate to
something agnostic.

...

> --- a/drivers/iio/adc/ab8500-gpadc.c
> +++ b/drivers/iio/adc/ab8500-gpadc.c
> @@ -39,6 +39,7 @@
>  #include <linux/slab.h>
>  #include <linux/mfd/abx500.h>
>  #include <linux/mfd/abx500/ab8500.h>
> +#include <linux/fwnode.h>

Ordering.

...

> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -21,6 +21,7 @@
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/fwnode.h>

Ordering?

...

>   * @consumer_channel:  Unique name to identify the channel on the consum=
er
>   *                     side. This typically describes the channels use w=
ithin

used / usage ?

...

>   * @consumer_channel:  Unique name to identify the channel on the consum=
er
>   *                     side. This typically describes the channels use w=
ithin

Ditto.

>   *                     the consumer. E.g. 'battery_voltage'

...

> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 233d2e6b7721..18ca5a7cb154 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -10,13 +10,14 @@
>  #include <linux/device.h>
>  #include <linux/cdev.h>
>  #include <linux/iio/types.h>
> -#include <linux/of.h>

You may split this change easily since there is nothing from of.h in
use. Just add forward declaration as you have done, but for the OF
case.

...

That said, I think what you need is to split this series to three logical p=
arts:
1) shuffle header inclusions around so, iio.h will use forward
declaration (on driver basis);
2) convert inkern.c to fwnode while providing OF wrappers (to_of_node() hel=
ps);
3) convert of_xlate (on driver basis it might be tricky, up to you).

--=20
With Best Regards,
Andy Shevchenko
