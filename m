Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43035BBF47
	for <lists+linux-iio@lfdr.de>; Sun, 18 Sep 2022 20:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIRSVB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Sep 2022 14:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIRSU7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2022 14:20:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F35E083
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 11:20:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id f20so33797544edf.6
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FjX4wj99N/BeJ3U6t/qCFb9HZWeI0WCfgI61Ozjr9tA=;
        b=TlCPVZ6AcBmPaZdTK3YEp08P+lmgTGc1IDMhF7N6vSMclPwlrx9ZRUQ3yL9AA3VlJB
         /Zvl9uUY++RdBP7Qch6fYFifMRB7Uhya4ZoTjj2LdNrkJqGjy7UzYrqVdCSsogRlh9Zo
         4raKWESN8QVNOGovxnBrrTGHgs4JDWbej/5mwcycmm7UBBifqEWKKUUg9/ZUds7pDAzS
         lhcXAa1YNsuToPmDQLU+pNYcyLHaDCan4lrPip1f4Ire7z58iUDNqy/D8Wkp66fxKJ8n
         pCXrsGBe+j6YmYjDt365++wBKtNekqNw0PXyJD1e+Hw8rYAQrboWcLD267uwQMwerJcX
         hqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FjX4wj99N/BeJ3U6t/qCFb9HZWeI0WCfgI61Ozjr9tA=;
        b=KDFS/EjgHWfvsBJx/q8AVbPwNpot9kEC2FfTaBZkTF0ytkMCGVP2aTgaEz2Bjr3m0H
         52yonA9gpmKRB3fByDx4MLN98DWLs1eR7wBCXuZJuJ9BisZJS4u5IYwHKoqMwaIgLpaq
         GVzIUbvtx3AJJBk5XRuIk/Et3APXlZlSWZBR4lPOKu9Kncjed3cUxEu+xX35kzb0P5M2
         J5cpNXxo9EujTP6j5JOYDJusMH2HRMKmQ/sMsj+rxuM9iB2toqnMc/Ei300cA3trO2JH
         vcuAJcDa1uPH9Ka2T9AqFW5y6jBrfgcb0enrXTdJrc5InvdFiVLyxNBsM7/8lKXSKPQF
         F8tg==
X-Gm-Message-State: ACrzQf2Uu6+ICaUYfgfs/Qcgcibb/ZBkbBHSXJZJ1X2nmIYgKuUuVjVO
        sfPC6i840OGFa7digvRF8GUrqSvktxbZDAcW1YY=
X-Google-Smtp-Source: AMsMyM4DnDbFA59LvJAHTDE8RjcXY3w1Mh22dI+s/mIX7Mnu47HyULuUBMHbeiyotJJ7dKKYeJ+Pf5CnYV1+B5F2bRg=
X-Received: by 2002:a05:6402:5cb:b0:452:e416:2bc4 with SMTP id
 n11-20020a05640205cb00b00452e4162bc4mr12622344edx.114.1663525256325; Sun, 18
 Sep 2022 11:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220917131401.2815486-1-jic23@kernel.org>
In-Reply-To: <20220917131401.2815486-1-jic23@kernel.org>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Sun, 18 Sep 2022 23:50:44 +0530
Message-ID: <CAM+2EuKsr0sE8Y2PdR7aqUBSX+65RU-=HcMegiUveoB=XtUMKw@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: bma400: Fix smatch warning based on use of
 unintialized value.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Sep 17, 2022 at 6:44 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Only specific bits in this value are ever used and those are initialized,
> but that is complex to reason about in a checker. Hence, initialize
> the value to zero and avoid the complexity.
>
> Smatch warning:
> drivers/iio/accel/bma400_core.c:1287 bma400_tap_event_en()
> error: uninitialized symbol 'field_value'.

Acked-by: Jagath Jog J <jagathjog1996@gmail.com>

>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Jagath Jog J <jagathjog1996@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/accel/bma400_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index eceb1f8d338d..ad8fce3e08cd 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -1184,7 +1184,8 @@ static int bma400_activity_event_en(struct bma400_data *data,
>                                     enum iio_event_direction dir,
>                                     int state)
>  {
> -       int ret, reg, msk, value, field_value;
> +       int ret, reg, msk, value;
> +       int field_value = 0;
>
>         switch (dir) {
>         case IIO_EV_DIR_RISING:
> --
> 2.37.2
>
