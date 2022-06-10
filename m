Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404755468E8
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jun 2022 16:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiFJO5k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jun 2022 10:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiFJO5j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2022 10:57:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F7E55B3;
        Fri, 10 Jun 2022 07:57:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gl15so40113058ejb.4;
        Fri, 10 Jun 2022 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FiFiZSOb5fy9Qyr8SrnJ9LwGpGEbO4FbIZTS4c08mfw=;
        b=mHU8yDAtySOxuZnlqlJbNLpyJN3LBFi9PrnPSFEfeFm7M2jv5fjv8Qf76KtG5ym6pL
         zkZuCdBdSgbcyNoKtu/B6lszfOt0Fqu8SsJ8CMw5fYM1VNDA/Y+sUBYi+0zJpPpd0xpX
         GqJnvLd7h8gOjOxHxYZ/XhWYDauZ6ABgtRMVuL/FwV9lajqaalv5jN2AMxSm1u+li79y
         SOozLN5MSK0xUqb+vCqGOgxuxQhV6pd7co2o75pIOxdiwQ9NIOtUiXyicUlKY7RcEXkx
         D2hlqs1xCK/BKhcwcnjRNBLBnLizBihH24xIJcCjwlZlIblip3w3rkDylnKfA4zaFT3C
         1Rhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FiFiZSOb5fy9Qyr8SrnJ9LwGpGEbO4FbIZTS4c08mfw=;
        b=cpartEZ97ZtFc+KhlkLXStwSboW+hKfug095yUmOG1EOX7vlYV32uxwHC1oEDnFQth
         ogwO4hOHRSza2uUzP9EYJxeKH4rS+kqIo/eScU3i+rRDTAtg3GAupwEYkr+AZwABsJS9
         mnGx0MlJHQaQ4gjlO7gR0KTvPVz9GQa7dE53OmiUC1biDA9maG4sKzt4Q4SadlqzMfFA
         2Zl3n1x7trbgsQ7QPnjmn7ZSRhm1kJy+rNsERX05wK44t8yLG3KkQEy9yl66l32qvc5R
         zaBH86mceFyjcLQyV+robVytlubitUjpCUmuiW02QxPPJw0A/vwgSuQwy+/FWwB1toM4
         QUdw==
X-Gm-Message-State: AOAM532u9nVf0DrKJSgwxmiFXeqixri6W5D1WqDFNjN7DfInfpucmZTv
        L8TL4os5AgMj/F6GmREgSrFFOHKS1U/AM+4PrxM=
X-Google-Smtp-Source: ABdhPJwgw1cdwy7+7BSEWyUuttbgW9nGvtz5OwQueP4zXXWoa6V054VmGJY2Kj9j5Z7jUAiFw2Aa2m1Mt+A03k0tKIs=
X-Received: by 2002:a17:906:434f:b0:711:eb76:c320 with SMTP id
 z15-20020a170906434f00b00711eb76c320mr15425618ejm.636.1654873054113; Fri, 10
 Jun 2022 07:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220610084545.547700-1-nuno.sa@analog.com> <20220610084545.547700-22-nuno.sa@analog.com>
In-Reply-To: <20220610084545.547700-22-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jun 2022 16:56:57 +0200
Message-ID: <CAHp75VdpAaO1VCy1WxUgR6z2LZ62gE+6Gp5aE=UrYdCqmZtBWw@mail.gmail.com>
Subject: Re: [PATCH 21/34] iio: inkern: fix return value in devm_of_iio_channel_get_by_name()
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

On Fri, Jun 10, 2022 at 10:48 AM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> of_iio_channel_get_by_name() can either return NULL or an error pointer
> so that only doing IS_ERR() is not enough. Fix it by checking the NULL
> pointer case and return -ENODEV in that case. Note this is done like this
> so that users of the function (which only check for error pointers) do
> not need to be changed. This is not ideal since we are losing error codes
> and as such, in a follow up change, things will be unified so that
> of_iio_channel_get_by_name() only returns error codes.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 6e39b145cef7 ("iio: provide of_iio_channel_get_by_name() and devm_=
 version it")
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/inkern.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 9d87057794fc..87fd2a0d44f2 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -412,6 +412,8 @@ struct iio_channel *devm_of_iio_channel_get_by_name(s=
truct device *dev,
>         channel =3D of_iio_channel_get_by_name(np, channel_name);
>         if (IS_ERR(channel))
>                 return channel;
> +       if (!channel)
> +               return ERR_PTR(-ENODEV);
>
>         ret =3D devm_add_action_or_reset(dev, devm_iio_channel_free, chan=
nel);
>         if (ret)
> --
> 2.36.1
>


--=20
With Best Regards,
Andy Shevchenko
