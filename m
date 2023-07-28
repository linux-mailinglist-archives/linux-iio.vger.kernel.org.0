Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1E87676B4
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jul 2023 22:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjG1UAY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jul 2023 16:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjG1UAW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jul 2023 16:00:22 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F582421E
        for <linux-iio@vger.kernel.org>; Fri, 28 Jul 2023 13:00:19 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d167393b95aso5271323276.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Jul 2023 13:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690574418; x=1691179218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+c7MR/bJd4Hz6dTew8BkstsuRnMMAYcSoL0ChCst6AA=;
        b=nJ7XhKK2oRjENGChjgarXAF/oxfIodtk+0diUD6AgPm8jm5eDcUEbUrezeaZenvjON
         s4X/eyzQ+3zXM/N1fvxYIR3incawecxMQRck9EU5SbxQwTV1wqvdyvU1cFJndG4BjDRM
         agnxuIgvGsXCRI3OrVB/QExBsGRLlVROKTxkioWgr0Mxi2uTvLiUcLAz7hs37+rmHZx7
         RY8VC61b4Q5Wmm1XwWmjS0Y9iW6zfc8gVEvNQVKmVq11q6UhxiUB98qSZh/ssVWEz+Fa
         +JEw3zmiv7TECgvmSLJxRR21ywv2ZFXgMcqeAUCCDtWnsD0E2AdLOkYHHXsCzSzcBBbq
         vMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690574418; x=1691179218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+c7MR/bJd4Hz6dTew8BkstsuRnMMAYcSoL0ChCst6AA=;
        b=jA8NvGB7rMfdQTxZi2XpalMU37EvLEf0pcPWpPXDXupQlBUeEubfX4qsyiUS+dE9eZ
         /LaHL0EFA8iOqGnkrnUaRAPmt8opWs7ueLLB13161rFPtq4lOnmLz5pjyTNXT0KOOaQu
         BpXrPzarDP73Lm7HKhuZ4+UxJqsz4XDL74b7tJTaVRH+G2QlxwW2k2ljxyy2xjqTvREI
         KF0mzNmbeXqrubmSZnMhaZENfLMler5NQcslTpCrcVAvOv7NHHalsIHrdZ1kFkj40OEf
         LcBpkFz3fjj/hOtFN0RxKI8oKvYcYWGThJLO7Orr5YNPlYtr7bwN/NDj7LrnonTXiYJT
         vNSA==
X-Gm-Message-State: ABy/qLbBaZBXjGouWRYZxI3w5nr40cLj/tm3NQ5at15itd5+BRqFPoFm
        wv3alQOIBkpVCqeJwAEzNl/9Fgr/WKeeu3DNn0kH0g==
X-Google-Smtp-Source: APBJJlGpALC/ukx/XzWD4GYg1zwDicd7CUoA9JJyWOi/lHUHLhHaOiAAOWaMHG007eWk6fLKaY0PRSXfxyK1rnCr83k=
X-Received: by 2002:a25:6894:0:b0:ce7:3374:5664 with SMTP id
 d142-20020a256894000000b00ce733745664mr3163001ybc.15.1690574418678; Fri, 28
 Jul 2023 13:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230727073912.4178659-1-ruanjinjie@huawei.com>
In-Reply-To: <20230727073912.4178659-1-ruanjinjie@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Jul 2023 22:00:07 +0200
Message-ID: <CACRpkdbjYJxU6Dy_0jrNFhLMH_PqsSq+uvXzmZ3EiYYk4=HM=A@mail.gmail.com>
Subject: Re: [PATCH -next] iio: adc: Remove redundant dev_err_probe()
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     jic23@kernel.org, lars@metafoo.de, haibo.chen@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, heiko@sntech.de,
        ktsai@capellamicro.com, risca@dalakolonin.se,
        christophe.jaillet@wanadoo.fr, dan.carpenter@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jul 27, 2023 at 9:39=E2=80=AFAM Ruan Jinjie <ruanjinjie@huawei.com>=
 wrote:

> There is no need to call the dev_err() function directly to print a custo=
m
> message when handling an error from either the platform_get_irq() or
> platform_get_irq_byname() functions as both are going to display an
> appropriate error message in case of a failure.
>
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
