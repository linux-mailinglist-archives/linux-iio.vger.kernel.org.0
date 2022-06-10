Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152445468D5
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 16:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345818AbiFJOut (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 10:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344944AbiFJOuU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 10:50:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27967496BC;
        Fri, 10 Jun 2022 07:49:39 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id o10so35591569edi.1;
        Fri, 10 Jun 2022 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zWkAvm2IXlDyGZ0UgWFThaY4qnPSU5U8Y+oJ0NIguu0=;
        b=SQ+LihYiWIuYf6xqulrMEnX++/IX2vzMGPc2QpqU6sFGBggJteUcsg+e3wUg27h//x
         KE+Hsar0BRNsd9L2t3Cj862Or2T+hnYT4oHaY0J3P82xWVD80vWLMfPpUB0p0eSBa5eE
         0NzM/B6W52r4Cq+96HjMg+yPYPvC1kr6mzUrI+gXXfAUa616v2nF2RhqV9ww2HAUj5+A
         z/YmwOhvJ7g/r4AKQ6ZandGjQ/rsURSmG39nAqoS0fadbBiYNsRL+vjiFG8xrvGOtElp
         TUoHq9EcF224pB2Y6vqt/Oli6tzumzS9HooVQzrNKbkbx1jYcyNf2p+MPTrw/DDrp+B2
         wNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zWkAvm2IXlDyGZ0UgWFThaY4qnPSU5U8Y+oJ0NIguu0=;
        b=m2YUIVBbz+uKIXHnDXHc05B9X/raPV1Njrz/aqiUL6DCSmSFGvuFi4wj4WLxOvORmi
         xIK1YPGaaL5j2T1fM79hEmBEB3ipHZZgH0Dd8NwOFzYqn+zKHN1sUcawiSfJPPaefNiT
         8cQJaBoZZD8mxm+fIWfVxmu9iwFM4Zgd5j+buN1go9nqExCl9JjFf2L1SZOLO8EJmpDA
         Rj+hntULTQAqdRXlNjvg3IjZwgajFcxlt0mKKXNOy0CElDaF+Z62UkkqgWK2+j6RiJ+4
         ZqpiMHtfHkMbyNEeCK3SvS92BtrCIzuJ88l+9O/qvxT3hnFUW3dSMQ5G+Tonlw/4T5S+
         p3hw==
X-Gm-Message-State: AOAM530s9FSmVG3+wP47qmXPi0o45PNIMT0WsHeErVcxDkmJ7SJqFId8
        UG/TUVsBiuWHipuGc+ycbVNl1rPqIbEz95boOPA=
X-Google-Smtp-Source: ABdhPJy9gdpwBA5sThUt0tz3Y57F51s/85a/ySJS4TTKz4QCJy/P98K2AUNMQFxo/TDXBlL2r2NUMPWBYYbiis5yFko=
X-Received: by 2002:aa7:d303:0:b0:42d:d192:4c41 with SMTP id
 p3-20020aa7d303000000b0042dd1924c41mr52233345edq.178.1654872577673; Fri, 10
 Jun 2022 07:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220610084545.547700-1-nuno.sa@analog.com>
In-Reply-To: <20220610084545.547700-1-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jun 2022 16:48:59 +0200
Message-ID: <CAHp75VfhRoDupB2rFS+hg1zFN3=8RhnBcXrg0O72bKJYQz+8Kg@mail.gmail.com>
Subject: Re: [PATCH 00/34] make iio inkern interface firmware agnostic
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        chrome-platform@lists.linux.dev,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 10, 2022 at 10:45 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> The main goal of this patchset is to convert the iio inkern interface to
> be firmware agnostic. Some previous discussion was done in here [1].
> Though something odd happened while sending the patches and the RFC
> actually never landed in the IIO list (hopefully now works):
>
> As suggested by Andy, the series can be seen in three blocks:
>
> 1) "Fix" all drivers that were relying on iio.h for specific header
> files (mainly of.h and mod_devicetable.h). After that we can drop
> of.h from iio.h and just forward declare what we need.
>
> 2) Move "most" of the IIO in kernel interface to FW API. At this point,
> there's still some OF dependent API in place so that users are not broken=
.
>
> 3) Move all users of the IIO in kernel interface to the FW API and with
> that, make IIO firmware agnostic.
>
> On 3), the qcom-spmi-adc-tm5.c driver was only converted to use the IIO
> API while on the IIO drivers a full driver conversion was done. The
> thermal one would be really non trivial as we would also need to touch th=
e
> subsystem. On the IIO drivers, the conversions were mostly peacefull
> (apparently). Special care for the stm32-adc.c driver though as that one
> was far from being straight :).
>
> Lastly, this is only compile tested with allyesconfig for arm and arm64.
> While I surely can come up with some dummy devices to make sure I can sti=
ll
> properly get IIO channels, having proper tested-by tags on platforms
> relying on this interface would be very appreciated (and I suspect Jonath=
an
> will require it).

For non-commented patches 1-19:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

You may add it for the commented patches in the 1-19 range in case you
are going to address my comments.

> [1]: https://lore.kernel.org/linux-iio/20220604141925.129f0ffe@jic23-huaw=
ei/T/#mfd5ccd793841569182e4f831f2c46089b665c346
>
> Nuno S=C3=A1 (34):
>   iio: adc: ad7606: explicitly add proper header files
>   iio: adc: ad7606_par: explicitly add proper header files
>   iio: adc: berlin2-adc: explicitly add proper header files
>   iio: adc: imx7d_adc: explicitly add proper header files
>   iio: adc: imx8qxp-adc: explicitly add proper header files
>   iio: adc: ingenic-adc: explicitly add proper header files
>   iio: adc: mp2629_adc: explicitly add proper header files
>   iio: adc: mt6360-adc: explicitly add proper header files
>   iio: adc: npcm_adc: explicitly add proper header files
>   iio: adc: rzg2l_adc: explicitly add proper header files
>   iio: common: cros_ec_lid_angle: explicitly add proper header files
>   iio: common: cros_ec_sensors: explicitly add proper header files
>   iio: dac: stm32-dac: explicitly add proper header files
>   iio: dac: vf610_dac: explicitly add proper header files
>   iio: humidity: hts221_buffer: explicitly add proper header files
>   iio: light: cros_ec_light_prox: explicitly add proper header files
>   iio: pressure: cros_ec_baro: explicitly add proper header files
>   iio: trigger: stm32-lptimer-trigger: explicitly add proper header
>     files
>   iio: core: drop of.h from iio.h
>   iio: inkern: only relase the device node when done with it
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
>  drivers/iio/adc/ab8500-gpadc.c                |  27 +-
>  drivers/iio/adc/ad7606.c                      |   1 +
>  drivers/iio/adc/ad7606_par.c                  |   1 +
>  drivers/iio/adc/at91-sama5d2_adc.c            |  30 +--
>  drivers/iio/adc/berlin2-adc.c                 |   2 +
>  drivers/iio/adc/imx7d_adc.c                   |   1 +
>  drivers/iio/adc/imx8qxp-adc.c                 |   1 +
>  drivers/iio/adc/ingenic-adc.c                 |   9 +-
>  drivers/iio/adc/mp2629_adc.c                  |   1 +
>  drivers/iio/adc/mt6360-adc.c                  |   1 +
>  drivers/iio/adc/npcm_adc.c                    |   1 +
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c           |  58 ++---
>  drivers/iio/adc/qcom-spmi-adc5.c              |  63 +++--
>  drivers/iio/adc/qcom-spmi-vadc.c              |  44 ++--
>  drivers/iio/adc/rzg2l_adc.c                   |   1 +
>  drivers/iio/adc/stm32-adc.c                   | 128 +++++-----
>  .../cros_ec_sensors/cros_ec_lid_angle.c       |   1 +
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |   1 +
>  drivers/iio/dac/stm32-dac.c                   |   2 +
>  drivers/iio/dac/vf610_dac.c                   |   1 +
>  drivers/iio/humidity/hts221_buffer.c          |   1 +
>  drivers/iio/inkern.c                          | 241 +++++++++---------
>  drivers/iio/light/cros_ec_light_prox.c        |   1 +
>  drivers/iio/pressure/cros_ec_baro.c           |   1 +
>  drivers/iio/trigger/stm32-lptimer-trigger.c   |   1 +
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c      |   3 +-
>  include/linux/iio/consumer.h                  |  28 +-
>  include/linux/iio/iio.h                       |   9 +-
>  28 files changed, 347 insertions(+), 312 deletions(-)
>
> --
> 2.36.1
>


--=20
With Best Regards,
Andy Shevchenko
