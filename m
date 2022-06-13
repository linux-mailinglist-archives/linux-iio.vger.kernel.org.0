Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E9F54A2B9
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 01:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345008AbiFMX0I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jun 2022 19:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245591AbiFMX0H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jun 2022 19:26:07 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8265326C9
        for <linux-iio@vger.kernel.org>; Mon, 13 Jun 2022 16:26:06 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id i16so7757615ioa.6
        for <linux-iio@vger.kernel.org>; Mon, 13 Jun 2022 16:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbxRBPwDsE33S/4VWlMl76EK8aUfLE1juYHGI23Fd9s=;
        b=Q7KcmegsUIXtRK/aUvN0dfl38itVsJxSdSzTcmQADGwvhawJSCjwQwVZ0S8tUk0MLT
         sMnvKm08Vjq/p4mvxxELqyBzAmAjWGgT7rWjMhrgeHhzxIhiWA+1OfCJLNEYSXGBiuwX
         KKgoji0LufhQdFZhgUnLRooUwbeqYKZVNWnzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbxRBPwDsE33S/4VWlMl76EK8aUfLE1juYHGI23Fd9s=;
        b=V/zliBkHGBTUu+dLJi88uH6rgj6NGbv51Pk9gyZGPkc8L+DAA/43aVZnOo3nfSns9x
         +oPO6iCkTlCGFY2ORUojTuvP1cCUFupOGEQ84OYfGwYrJOw1TAWVIQBel+jlTJ/M/g6M
         OZaGDHi11attaRmfrHXtO5DvgXXki3HTev5Md5VDSXm/atld+3zxn3bymAOML+IIaOVX
         gopaaUHUdccuecajRi3vNd0LwfrVVbjtNJjF1MRcQB6xMDKy27nXAfqi2Uz0nC+0G8IN
         nR5ccnvrQOxhZVAduJ+0+DLSXXQz9+aVaWp0h/03IpsGojfLqCwLAEKuqXGJ1QwZLWoj
         CNpw==
X-Gm-Message-State: AOAM533D/lGAg0v8P2QaG9/rXujAsyRo6GXaFmKza8IfnrncQaSKHj8U
        zoBO4G7Mlmzhr6FxPgeVzCiZdCbfpRAFVtAAFiQyIg==
X-Google-Smtp-Source: ABdhPJz6BzkhxT4qPiTDFCP9A72GGdJ/EGAHIkamJTf26bfTUwgdrW/qNn+EcsJTpA9WG7RlmeDt//ajXwXTAncS/68=
X-Received: by 2002:a05:6602:2d4b:b0:669:f213:c6e1 with SMTP id
 d11-20020a0566022d4b00b00669f213c6e1mr1080945iow.77.1655162766187; Mon, 13
 Jun 2022 16:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220613232224.2466278-1-swboyd@chromium.org>
In-Reply-To: <20220613232224.2466278-1-swboyd@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 13 Jun 2022 16:25:55 -0700
Message-ID: <CAPUE2usiMSi-njO5G9wELOdRuL428Vw9BtS4NfbKX1wtVCMaWA@mail.gmail.com>
Subject: Re: [PATCH] iio:proximity:sx9324: Check ret value of device_property_read_u32_array()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Aashish Sharma <shraash@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-iio@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 13, 2022 at 4:22 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> From: Aashish Sharma <shraash@google.com>
>
> 0-day reports:
>
> drivers/iio/proximity/sx9324.c:868:3: warning: Value stored
> to 'ret' is never read [clang-analyzer-deadcode.DeadStores]
>
> Put an if condition to break out of switch if ret is non-zero.
>
> Signed-off-by: Aashish Sharma <shraash@google.com>
> Fixes: a8ee3b32f5da ("iio:proximity:sx9324: Add dt_binding support")
> Reported-by: kernel test robot <lkp@intel.com>
> [swboyd@chromium.org: Reword commit subject, add fixes tag]
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/proximity/sx9324.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 70c37f664f6d..63fbcaa4cac8 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -885,6 +885,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
>                         break;
>                 ret = device_property_read_u32_array(dev, prop, pin_defs,
>                                                      ARRAY_SIZE(pin_defs));
> +               if (ret)
> +                       break;
> +
>                 for (pin = 0; pin < SX9324_NUM_PINS; pin++)
>                         raw |= (pin_defs[pin] << (2 * pin)) &
>                                SX9324_REG_AFE_PH0_PIN_MASK(pin);
>
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> --
> https://chromeos.dev
>
