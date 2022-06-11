Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089D054753C
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jun 2022 16:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiFKOHY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jun 2022 10:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiFKOHX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2022 10:07:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1084B1DA53;
        Sat, 11 Jun 2022 07:07:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F7C160F35;
        Sat, 11 Jun 2022 14:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6736C34116;
        Sat, 11 Jun 2022 14:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654956438;
        bh=sYrcnctOT1kg2rtUoj2m7nGi8WnuwpUPezuz5OO1NN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bbXSpdcwgal7gAnf16jULcsmRlfACXBw6a77ZvEr6NSlsLv+8lH4Yw73ue78Q7laW
         1x5yo0RCc5QtnxdmW3e85EDzoCUuj1EM/CPL4UXXvN0gL7/o3gzK/BLN1gcY/2KMvt
         +9rTVuTl2t+2wYPgXvmT+Jh482GId+ORxUmnhvhy9ArQJqsF5uUxR+hXwJLMyYjLG6
         W/p4U5bCmJNubnlMpHySZnyO7oo2IqtsZ+KTMcIZXQL6OXcCZvpOdCg3rJlO1eFh0U
         7Bnf5TWv+Mnf59isUCSVFHpCkbFmjMmtcFTFcdusioLsSrRcxByVGMRo8q8SAuLUf/
         wj9VhvuX6sEcA==
Date:   Sat, 11 Jun 2022 15:16:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-imx@nxp.com>, <linux-renesas-soc@vger.kernel.org>,
        <linux-mips@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <chrome-platform@lists.linux.dev>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, Cai Huoqing <cai.huoqing@linux.dev>,
        Benjamin Fair <benjaminfair@google.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Benson Leung <bleung@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Patrick Venture <venture@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Nancy Yuen <yuenn@google.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Gwendal Grignou" <gwendal@chromium.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        "Tali Perry" <tali.perry1@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        "Lorenzo Bianconi" <lorenzo@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Guenter Roeck" <groeck@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        "Olivier Moysan" <olivier.moysan@foss.st.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 12/34] iio: common: cros_ec_sensors: explicitly add
 proper header files
Message-ID: <20220611151618.10be5e3e@jic23-huawei>
In-Reply-To: <20220610084545.547700-13-nuno.sa@analog.com>
References: <20220610084545.547700-1-nuno.sa@analog.com>
        <20220610084545.547700-13-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Jun 2022 10:45:23 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> Do not trust the fact that iio.h includes of.h which in turn includes
> all the headers we are relying on.
>=20
> The ultimate goal is to actually drop of.h from iio.h.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied

> ---
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drive=
rs/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 376a5b30010a..61e07a7bb199 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -16,6 +16,7 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>

