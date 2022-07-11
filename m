Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEA6570420
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jul 2022 15:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiGKNXV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jul 2022 09:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiGKNXU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2022 09:23:20 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F563C16C;
        Mon, 11 Jul 2022 06:23:17 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31cf1adbf92so48676177b3.4;
        Mon, 11 Jul 2022 06:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=axlXcCK4wzxh1OC0E6EXS/IHkDmYX0iUqKB8KvL3LFw=;
        b=azAe6ar9N7tB2G+wHrOJqidSXtmkRQD0XszfgYTB2+nUuftFTGrYAwFKLK6B3VSvxS
         LYH1Ch1YfniUWTW3CljT9wnoyta+kScApyRgNBBwtUCi/8SuQpTd15On5hM+RMT/pKOw
         PMR9DZHIJNVz/bOy9TkXGjKfVd1yG6ELLdYt5M1YzJQnXHR03UvBzEXEZrZakP3yZjhg
         msD6j0yevsiH5FrMqegzrvcVo0vnL0k2Re8yem12ugUbCbH9UeagckJsjPGufgCutt6V
         CGQsws9fhqWC8Mn/goNdZTafu0+ayr/f54YG0TitzQOIrIasgcA2HjL7yimlYdQsrgHv
         atcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=axlXcCK4wzxh1OC0E6EXS/IHkDmYX0iUqKB8KvL3LFw=;
        b=Qh/NjwmvD6SZdXG+JVFmRkw3JhQioRBcNBNKDyTFYarBT0XI0YR16JaOsVTC97BSjB
         s9kW4iXUimU9U8npa2ctEecGGVnoWrgXivpCRksa5MF0hSpxrcN4RBK9lJlXb8R+hEFe
         BKdz0icA0dQQZ5ZsoFXXYa0xz+c/jmDSFnLoCXWjallY3tXTs8d7BFpSGhJ3QAe00JJe
         KtYb5LCuvU6jc9t3KMnKD/d0+cMicoMQu9bOM7qb3XBQjO1RjBXXzVjOWhT3/60yB3+P
         lKdiRtnsz65cab4QJwa+ry3VhHqSqkCLdDvNe+SkIlo3LWHdyjKHjF18g9ynSNoszxFV
         JBrw==
X-Gm-Message-State: AJIora8MBPB4p8pvjEuBOyIgw9T09WaL6B3ryTAq12lSB+xH2uZ8dmTD
        LN6IXvzI9XMwyg9E1LjXvDi+m6U/AvhfbB2+TEMGSmIjJOxEwV8g
X-Google-Smtp-Source: AGRyM1uI6d1T0dRGT/n+l18kDyDiKT6LcPWA/8qru61SWwefVBnYcSZqQGKMaS94keyx+UdRlU9g/tUjYLQBPiPZtwE=
X-Received: by 2002:a81:4bd7:0:b0:31c:91da:5a20 with SMTP id
 y206-20020a814bd7000000b0031c91da5a20mr20827843ywa.131.1657545796406; Mon, 11
 Jul 2022 06:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220711123835.811358-1-nuno.sa@analog.com>
In-Reply-To: <20220711123835.811358-1-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 15:22:39 +0200
Message-ID: <CAHp75VeMXP1WyQcFQU_RW-a_CSGVMF_NsgHtLEbL8hi-n8gSVw@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] make iio inkern interface firmware agnostic
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
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

On Mon, Jul 11, 2022 at 2:38 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> First version of the series can be found here:
>
> https://lore.kernel.org/linux-iio/20220610084545.547700-1-nuno.sa@analog.=
com/

I'm under the impression that I gave tags for some of these patches
when they were the part of the bigger series. Am I wrong?
In any case for patch 6-14,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> v2 changes:
>
> [1/15]
>   * Fix typo and added more description in the commit message.
>
> [3/15]
>   * Remove superfluous code;
>   * Commit message spell fixes and added more details;
>   * Improved error handling (this is the most significant change in this
> version. More details on the commit message).
>
> [4/15]
>   * Drop the 'ugly' parent_lookup flag. With the new error handling,
>     we can use -ENODEV to infer if we should proceed or not with the
>     lookup.
>
> [5/15]:
>   * Moved some local declarations up so long lines first;
>   * Use 'bus_find_device_by_fwnode()';
>   * Proper ordering in includes.
>   * Adapted error handling in '__fwnode_iio_channel_get_by_name()' taking
> ACPI into account and when 'name' is given but index < 0. It seems that
> ACPI code can actually return -ENOENT with index < 0 for which case we
> should continue the search. Not sure if a check  in ACPI ('if (index < 0)
> return -EINVAL;) like is done in OF would make sense...
>
> [12/15]:
>   * Use 'device_property_count_u64()' to get the number of diff channels.
> So no need for 'magic' divisions by 2 (no idea why I haven't done like
> this in the first place).
>
> [15/15]
>   * Fix wrong conversion of 'if (ptr !=3D NULL)' to 'if (!ptr)'.
>
> Special note for patch 3/15 where -ENODEV is still used despite some talk=
s
> about using -ENOENT and hence, be more in line with firmware code. The
> reason I kept it was to be consistent with the rest of the file. I'd say
> that if we want to move to -ENOENT we should do it in a separate patch
> and for the complete file.
>
> Nuno S=C3=A1 (15):
>   iio: inkern: only release the device node when done with it
>   iio: inkern: fix return value in devm_of_iio_channel_get_by_name()
>   iio: inkern: only return error codes in iio_channel_get_*() APIs
>   iio: inkern: split of_iio_channel_get_by_name()
>   iio: inkern: move to fwnode properties
>   thermal: qcom: qcom-spmi-adc-tm5: convert to IIO fwnode API
>   iio: adc: ingenic-adc: convert to IIO fwnode interface
>   iio: adc: ab8500-gpadc: convert to device properties
>   iio: adc: at91-sama5d2_adc: convert to device properties
>   iio: adc: qcom-pm8xxx-xoadc: convert to device properties
>   iio: adc: qcom-spmi-vadc: convert to device properties
>   iio: adc: qcom-spmi-adc5: convert to device properties
>   iio: adc: stm32-adc: convert to device properties
>   iio: inkern: remove OF dependencies
>   iio: inkern: fix coding style warnings
>
>  drivers/iio/adc/ab8500-gpadc.c           |  27 +--
>  drivers/iio/adc/at91-sama5d2_adc.c       |  30 +--
>  drivers/iio/adc/ingenic-adc.c            |   8 +-
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c      |  58 +++--
>  drivers/iio/adc/qcom-spmi-adc5.c         |  63 +++---
>  drivers/iio/adc/qcom-spmi-vadc.c         |  44 ++--
>  drivers/iio/adc/stm32-adc.c              | 121 +++++-----
>  drivers/iio/inkern.c                     | 271 +++++++++++++----------
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c |   3 +-
>  include/linux/iio/consumer.h             |  28 +--
>  include/linux/iio/iio.h                  |   8 +-
>  11 files changed, 347 insertions(+), 314 deletions(-)
>
> --
> 2.37.0
>


--=20
With Best Regards,
Andy Shevchenko
