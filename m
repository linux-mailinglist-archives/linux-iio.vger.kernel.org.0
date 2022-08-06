Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F97958B7CA
	for <lists+linux-iio@lfdr.de>; Sat,  6 Aug 2022 20:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiHFSqp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Aug 2022 14:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiHFSqn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Aug 2022 14:46:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBACFEE35;
        Sat,  6 Aug 2022 11:46:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89B5B6124B;
        Sat,  6 Aug 2022 18:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71514C433D6;
        Sat,  6 Aug 2022 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659811601;
        bh=B/0w1udhvHD/9i0cSXbtONOW92202f2YhMQiT3LJId8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pFsBYtApmnG2eqrOLyURupaAFLXeLc7W/9MhUykPguHD+e2ft00vYjP4PgD7meTaL
         aPiqJFS71t0cIyfkSjKk98zrKxyjz09pS447wpgFxKM6eWxbQk3PVjXmckPypt4Sfb
         Lm30+HGsvQ3Z8zumo7J6GRstmybs7OtVuu+uLeKiYDXuzzCb9QynrGjKoCD5Y60u6J
         Zd2cs38zj5zkuUAfwWbj8DgGekQr4BK6wercvB/3Om+mW3sBpol/kP2ySEzM+fgHeh
         7NU/Gt2skLPY/Q3zl2jiIS2qg1r4JEz2ddRLnSlZKFPH9bPGC1ox2H1RL+vuQEmBOd
         Lib5B34RgV13Q==
Date:   Sat, 6 Aug 2022 19:56:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <openbmc@lists.ozlabs.org>, <linux-imx@nxp.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-iio@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <chrome-platform@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <linux-arm-msm@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Olivier Moysan" <olivier.moysan@foss.st.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Fair <benjaminfair@google.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Patrick Venture <venture@google.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Nancy Yuen <yuenn@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Avi Fishman <avifishman70@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Haibo Chen" <haibo.chen@nxp.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: Re: [PATCH v3 00/15] make iio inkern interface firmware agnostic
Message-ID: <20220806195649.4aee65fc@jic23-huawei>
In-Reply-To: <20220715122903.332535-1-nuno.sa@analog.com>
References: <20220715122903.332535-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Jul 2022 14:28:48 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> First version of the series can be found here:
>=20
> https://lore.kernel.org/linux-iio/20220610084545.547700-1-nuno.sa@analog.=
com/
>=20
> Second version:
>=20
> https://lore.kernel.org/linux-iio/20220711123835.811358-1-nuno.sa@analog.=
com/
>=20
> v3 changes:
>=20
> [1/15]:
>   * Improved (spell fixes) commit message.
>=20
> [13/15]:
>   * Get back to u32 API for 'st,adc-diff-channels' but making it more cle=
ar
> what's going on;
>   * Fix infinite loop;
>   * Store number of st,min-sample-time-nsecs properties to avoid
> duplication in sanity checks.
>=20
> [15/15]
>   * Improved 'if' condition for readability.
>=20
> (hopefulyl did not forgot any tag)


Very nice work.  All applied, with a few minor tweaks as called out in
relevant patches.  Note I'll push this out as testing.  Will go out as togr=
eg
only after I can rebase on rc1 in a week or so time.

Thanks,

Jonathan

>=20
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
>=20
>  drivers/iio/adc/ab8500-gpadc.c           |  27 +--
>  drivers/iio/adc/at91-sama5d2_adc.c       |  30 +--
>  drivers/iio/adc/ingenic-adc.c            |   8 +-
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c      |  58 +++--
>  drivers/iio/adc/qcom-spmi-adc5.c         |  63 +++---
>  drivers/iio/adc/qcom-spmi-vadc.c         |  44 ++--
>  drivers/iio/adc/stm32-adc.c              | 125 ++++++-----
>  drivers/iio/inkern.c                     | 271 +++++++++++++----------
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c |   3 +-
>  include/linux/iio/consumer.h             |  28 +--
>  include/linux/iio/iio.h                  |   8 +-
>  11 files changed, 350 insertions(+), 315 deletions(-)
>=20

