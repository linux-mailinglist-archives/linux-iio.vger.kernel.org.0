Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5B46FA3A6
	for <lists+linux-iio@lfdr.de>; Mon,  8 May 2023 11:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjEHJta (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 May 2023 05:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjEHJt2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 May 2023 05:49:28 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD91A18DE6
        for <linux-iio@vger.kernel.org>; Mon,  8 May 2023 02:49:25 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ac826a1572so43460181fa.0
        for <linux-iio@vger.kernel.org>; Mon, 08 May 2023 02:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1683539364; x=1686131364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0+P76mOquWNViliSYH9vueD2DBb8X+upf+fKSyca/cA=;
        b=fJY343lvsksYzvTK5TFQjxMQd5QhggQNiHANXNF+dHiG6Jy1xgsJGB+WWmrXkqg10Y
         J5zkTAWZbDNAHVx1Zvj+/UqHzYWKi4bC91jWessdWOmWg+7OBKyDsCMFsz5X9JTiBEJy
         0OWWesNooKs3p/N8e1Gd4vekaewHRi/WtKy0wZGyRseFpAverkfHeuTEe1Mqb1oguMaA
         IlWbQpcMO+v+8K+HqIt/zhb6FTk1FVSX1rD9jvZOQTpVSspqxzYdeBDGxF8rKrWge38p
         H0nhaB2m6ohg2+Ln9TRn6AQZ5jr7zm5ntR0xIMle96dfsK94eUP90XULGyMa0LsyOqiC
         7Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683539364; x=1686131364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+P76mOquWNViliSYH9vueD2DBb8X+upf+fKSyca/cA=;
        b=IGX+2sHxFgf9+ktdlvdeoKFqn5v+YBCPco6lv297ra8T6XKeb4X34P/VzQodLoksRZ
         yp6QjjWiAHNe1FOCwv5eom+ZVXsoMktaznNCklYzRpJZeCr0bStMPb4aWWNI3mTxZhAJ
         E4KLx2WY05F9QbGIi/ad4Yg+jRHl3bD7xev7ydxYS32sKE0V74TmpVownZOFzE7XUVPM
         tb21KH6emFuTvLgqV2700n0IMLybIKOrbZxmROzkw7kYZQjEk69u3FFZ7tBNUjOz1Nvr
         rptbQLyfkwvab5uoNtOvuOzsnZrhE3nOajquHskasQzAUGk1w7fnrIWssvDeQ0kBbQyh
         BnRA==
X-Gm-Message-State: AC+VfDyIeLFje5pgfzJ7ZvqRvCoHifylNL6YsHsHYr41oht1wB8PJ5Rn
        frYhusthv5qPfF1DKYO9CaEQ6/TkY392pyKGqqKMxA==
X-Google-Smtp-Source: ACHHUZ7X/a7i2eUnEBfwW1D0N7Wp6XSXdQNGXQNYPzb8DwmOIR5nmdVPOqEA5KIKkbt2vuSq9ywDD8O4WQmvqKw/8dw=
X-Received: by 2002:a2e:930d:0:b0:2ac:667b:bb36 with SMTP id
 e13-20020a2e930d000000b002ac667bbb36mr2627811ljh.33.1683539363951; Mon, 08
 May 2023 02:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230507184649.39290-1-marex@denx.de> <20230507184649.39290-2-marex@denx.de>
In-Reply-To: <20230507184649.39290-2-marex@denx.de>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 8 May 2023 11:48:47 +0200
Message-ID: <CAKv63usF-mcJbz=7hTuK3cUSoawLHEUBGH3d2tYKFEKKsikYVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] iio: mlx90614: Sort headers
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Acked-by: Crt Mori <cmo@melexis.com>

On Sun, 7 May 2023 at 20:47, Marek Vasut <marex@denx.de> wrote:
>
> Sort the headers alphabetically. No functional change.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Crt Mori <cmo@melexis.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> ---
> V2: New patch
> ---
>  drivers/iio/temperature/mlx90614.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index 909fadb623491..bd92b24918253 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -19,12 +19,12 @@
>   * the "wakeup" GPIO is not given, power management will be disabled.
>   */
>
> +#include <linux/delay.h>
>  #include <linux/err.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
> -#include <linux/module.h>
> -#include <linux/delay.h>
>  #include <linux/jiffies.h>
> -#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
>  #include <linux/pm_runtime.h>
>
>  #include <linux/iio/iio.h>
> --
> 2.39.2
>
