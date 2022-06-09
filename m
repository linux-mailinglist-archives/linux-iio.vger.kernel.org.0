Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53CB5446CF
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jun 2022 10:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbiFII6R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jun 2022 04:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242922AbiFII5S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jun 2022 04:57:18 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B8B1F0A44
        for <linux-iio@vger.kernel.org>; Thu,  9 Jun 2022 01:57:01 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3137eb64b67so32498817b3.12
        for <linux-iio@vger.kernel.org>; Thu, 09 Jun 2022 01:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBfkHwomqoQVJ5iP1a2Ln1xJk4/FQ1l7KDZnSrjGyvI=;
        b=CYMqNPSHsyef6IYIjtBDYtFTSUn1o6iyPLDe8mf8prTfChI1zGYYhZJMnZbIm8FiUA
         oFLPwxEEaLjzBwYEOVui5kYGjSsgNIAimczfx9M39BGZceNvvn7B+iLjim4VVSBu6fJZ
         2jewT7TUVHYrl9g6+B2+aW4+4YvCT463SN4tgb9YALjUttohTGfZIrscesbKzhkMXkck
         UIj8Em3qDrKGD46Qkwrg0aW6L3yLIueuP8Ui3YA4rbQfNNBg055qfNuYcPIkvwu/l9Pd
         ZS6qlYwxguwdwJaiisIkYOG25JFfCkpxH9QSk8sJQ9B3/x7Xl8O7eO42Kv/QeUMEelcY
         jguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBfkHwomqoQVJ5iP1a2Ln1xJk4/FQ1l7KDZnSrjGyvI=;
        b=exVxVq4hXXuQS8zC8U9WTqm6iwxT+zgrUcIFC2KFsuO7bOIyWb6XZ4XDiHCvcCXj7h
         f8YhRbCKo1RsO3gCFJLoCbP8oTniEWTrKHhq7gTP7xhoECMp/BXNM47L+4AnpXvzMu9u
         i6xXDGWUYogxxqimNbKL1fNg62eF0mjbxjDK2SGfu+1FRSRIMrKN/aXcVJwPoM1BHv4c
         91R+GKnUuWNABAksVa4y03VpAOJjZV28kU6KNv6FanMaX+SGTe6xAZc7+sXVsxwbOM+/
         x2DRZZyIuWtua406Fpg29fV2rjmvj1uJ0btbq68nAI3CCnK+CftVT242Gw8dYA5iRLg5
         GXRA==
X-Gm-Message-State: AOAM531fKjrtfE9SRtbTTGH0kxeaN3pncF0KG14wU1p+NV0Khn3puwNY
        iA+mfW+s79b1RFWAgqmsyJ+jDrcFHgpvbwguwoR1eA==
X-Google-Smtp-Source: ABdhPJxNzvkXPmRzVZDJz9jkuJQA/0Aqdy3mgR2XfgBXPstnVV58qlb0sz3vcA2VXVVLiI4X9Riy6fyHeYZoi1rfG0U=
X-Received: by 2002:a0d:e246:0:b0:30c:5e77:7104 with SMTP id
 l67-20020a0de246000000b0030c5e777104mr43630744ywe.448.1654765020379; Thu, 09
 Jun 2022 01:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654727058.git.jahau@rocketmail.com> <a914ca0ea6f0149cd2941d60ae6fa2f49927f66a.1654727058.git.jahau@rocketmail.com>
In-Reply-To: <a914ca0ea6f0149cd2941d60ae6fa2f49927f66a.1654727058.git.jahau@rocketmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Jun 2022 10:56:49 +0200
Message-ID: <CACRpkdZzHcmGTeeVv+_EiwoPeFdyv4Dv_TOL9ZxjP-7UEoqhXQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio: magnetometer: yas530: Add YAS537 variant
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 9, 2022 at 1:39 AM Jakob Hauser <jahau@rocketmail.com> wrote:

> This adds support for the magnetometer Yamaha YAS537. The additions are based
> on comparison of Yamaha Android kernel drivers for YAS532 [1] and YAS537 [2].
>
> Functions used by YAS530 & YAS532 only were renamed from yas5xx to yas530_532.
> Registers were renamed accordingly.
>
> In the Yamaha YAS537 Android driver, there is an overflow/underflow control
> implemented. For regular usage, this seems not necessary. A similar overflow/
> underflow control of Yamaha YAS530/532 Android driver isn't integrated in the
> mainline driver. It is therefore skipped for YAS537 in mainline too.
>
> Also in the Yamaha YAS537 Android driver, at the end of the reset_yas537()
> function, a measurement is saved in "last_after_rcoil". Later on, this is
> compared to current measurements. If the difference gets too big, a new
> reset is intialized. The difference in measurements needs to be quite big,
> it's hard to say if this is necessary for regular operation. Therefore this
> isn't integrated in the mainline driver either.
>
> [1] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c
> [2] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>

Nice work! I have reviewed the drafts before in private and can't see
any remaining issues with the final version so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
