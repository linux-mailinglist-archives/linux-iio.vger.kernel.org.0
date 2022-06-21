Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9AF553D75
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 23:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355354AbiFUVVa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 17:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356026AbiFUVVD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 17:21:03 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9870942A20
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 14:06:33 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p128so15574163iof.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 14:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y6NXYZnt7GfD7nCM3MSIuTVafK+mSbW9Za36ZIHtrtg=;
        b=lFJHH0sSmZE/1E9wekXM3McWWhwQcB2AO3xUVxM11/h4ty96qhrJu9uZQK+hwRbW3N
         z2/wmbtOQMYd+QTZNi7YoTsSdTl2FCNZpV2udeBvXov2Xcelha00vzGQnwQ76nhqshnp
         eObBB8UHB94zokQXcBflYDfOkJll6J41f4Xf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6NXYZnt7GfD7nCM3MSIuTVafK+mSbW9Za36ZIHtrtg=;
        b=yBetY0qS87VEeECUUKMhbTPZskxrJzSSFv4dlzdRafzyUsBw0EjwtMCpQwpsz5SZCC
         m2YuwRvsXTWAET082vqdyI2Jarva/w5YZmgT+ydqiDVgQJKZ5mZpzzwYETIO+0p1ud2Z
         bLLxeU9WmXJZ7f7XDDlBenXVJG18B0l2V3W/Xkvvl9EjHu8tL91/29texu/IeXfzYWf+
         QBJPj11sRosOzqKQx/pS6JDqiFXaW1qs72xaNQexk10MYd1Qok5NRfl91bQYtA9y8qbm
         pAO6JiB5Fm1FVSCJDohdhauJwJkLoK2pHPDpPuOXRLSgCphp3LeJ8oQDg83BvdOrZbIV
         oI7A==
X-Gm-Message-State: AJIora/VE/8napY4cJLBxTgJTuLi70TbMkCG6xIQ7wKr2gHw7WmdtUZ1
        0UHAQHdFLWSVhSK2qAMxSN3ux2ZEpHkDFcoGmhDRyw==
X-Google-Smtp-Source: AGRyM1uvSk+9kHw3Y0lpQyBzrrMcf3DuwN3z8aRH54kzy6mm0Ln9mAaryqxyrPn9SRXCFuGO8u5pz/z+HcQhRJ2+/IY=
X-Received: by 2002:a5e:9617:0:b0:66c:c840:571f with SMTP id
 a23-20020a5e9617000000b0066cc840571fmr2936ioq.131.1655845592566; Tue, 21 Jun
 2022 14:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220621202719.13644-1-jic23@kernel.org> <20220621202719.13644-25-jic23@kernel.org>
In-Reply-To: <20220621202719.13644-25-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 21 Jun 2022 14:06:21 -0700
Message-ID: <CAPUE2uvmK=xe0KF74tqeoAb0GmwQBxCpCKF4nnuL52Swo9ViMw@mail.gmail.com>
Subject: Re: [PATCH 24/36] iio: proximity: cros_ec_mkbp: Switch to
 DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Brian Masney <masneyb@onstation.org>,
        David Heidelberg <david@ixit.cz>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Christian Eggers <ceggers@arri.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Joe Sandom <joe.g.sandom@gmail.com>,
        "Ismail H . Kose" <ihkose@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rishi Gupta <gupt21@gmail.com>,
        Roan van Dijk <roan@protonic.nl>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 21, 2022 at 1:21 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Using these newer macros allows the compiler to remove the unused
> structure and functions when !CONFIG_PM_SLEEP + removes the need to
> mark pm functions __maybe_unused.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/proximity/cros_ec_mkbp_proximity.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/proximity/cros_ec_mkbp_proximity.c b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
> index 8213b0081713..571ea1812246 100644
> --- a/drivers/iio/proximity/cros_ec_mkbp_proximity.c
> +++ b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
> @@ -184,7 +184,7 @@ static const struct iio_info cros_ec_mkbp_proximity_info = {
>         .write_event_config = cros_ec_mkbp_proximity_write_event_config,
>  };
>
> -static __maybe_unused int cros_ec_mkbp_proximity_resume(struct device *dev)
> +static int cros_ec_mkbp_proximity_resume(struct device *dev)
>  {
>         struct cros_ec_mkbp_proximity_data *data = dev_get_drvdata(dev);
>         struct cros_ec_device *ec = data->ec;
> @@ -201,8 +201,8 @@ static __maybe_unused int cros_ec_mkbp_proximity_resume(struct device *dev)
>         return 0;
>  }
>
> -static SIMPLE_DEV_PM_OPS(cros_ec_mkbp_proximity_pm_ops, NULL,
> -                        cros_ec_mkbp_proximity_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(cros_ec_mkbp_proximity_pm_ops, NULL,
> +                               cros_ec_mkbp_proximity_resume);
>
>  static int cros_ec_mkbp_proximity_probe(struct platform_device *pdev)
>  {
> @@ -260,7 +260,7 @@ static struct platform_driver cros_ec_mkbp_proximity_driver = {
>         .driver = {
>                 .name = "cros-ec-mkbp-proximity",
>                 .of_match_table = cros_ec_mkbp_proximity_of_match,
> -               .pm = &cros_ec_mkbp_proximity_pm_ops,
> +               .pm = pm_sleep_ptr(&cros_ec_mkbp_proximity_pm_ops),
>         },
>         .probe = cros_ec_mkbp_proximity_probe,
>         .remove = cros_ec_mkbp_proximity_remove,
> --
> 2.36.1
>
