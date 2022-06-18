Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A034D5503F2
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 12:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiFRJxr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 05:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiFRJxp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 05:53:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C7820F77;
        Sat, 18 Jun 2022 02:53:44 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id s12so12787511ejx.3;
        Sat, 18 Jun 2022 02:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d26tELcPPLMsSaA7zDtyTnK2AsfKl9yRi/D8BIsew14=;
        b=ZdJLrkdx8W+9KaYtqucoexzUA5jcbVzNLDqFoinYCKKb4Rnv6eJ+z8giAkJL26wYfF
         nsxhqD+FB36Xc9OE/lAZijHDoJPdZa22WNn3PHtK4kOMpQd6hNYH/TJDZF1vH5x6UqzU
         Jas3HwK8Q0HLaP9RnHeGKZKCpFcAzCkpwWrgOdZumBHxfKjy2I0yOVdOjGaHdinEgEWO
         vfeEjiNaVPTR4d01DjQoHCY89qbWGH4mMrWMWGKoj8EItwuLsuhy3X90kx8ksObNMGvp
         mOqdJwysj6Om+8f7XXOdORVbTiQPMbwQGujRqxF0hidQkQyA/il5jjdazKJm/lg76yXX
         NGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d26tELcPPLMsSaA7zDtyTnK2AsfKl9yRi/D8BIsew14=;
        b=D092ArOEPefiRAm42OuwB86/yLGYDJW3y6Dehi8LjAR64A/krbVeos2TaBP/G4tonV
         ul3ByckJvyF5IjSQmNKWl6Jzekb/YDAbu1txVf4oy3ekYb96o0DCuGvj1xxfM8AZA3cn
         E9nTD1liA2F2JxRBgbN/WL14iWQsGAsxqF+Qy/VTOEm062zt1+GVQe+wPl5CFU/VsmnG
         EL94TnbKBzzocO7fwyPgoYPOG+AWQTsT4DMhv71xbCtyExnkamKhuz91YGA+Fr99TliK
         CDxbTDdQ7vcVUZNnqGsxE+W5ABjEiV1Na+VZHS8kqsECz+DsbP5JgY7K86iwR/0reO/L
         smEg==
X-Gm-Message-State: AJIora8xYw8LXtOg3mrTJ6WCgj3p4psXP0up9+pQkOFJPVOJbenfrwvd
        q/f3SleEsK80Jd+O0wD6cOMZih2skpt/8iakIzk=
X-Google-Smtp-Source: AGRyM1sRXa8ha6Iyn9tn+1a1cEzViRUSf2X5Ybbg+nF1+qrujSaVq2vkxYzGPsnxEsY16BmZPZpSb6PHAYZ00LyuamQ=
X-Received: by 2002:a17:906:149:b0:711:fca6:bc2f with SMTP id
 9-20020a170906014900b00711fca6bc2fmr12887966ejh.497.1655546023032; Sat, 18
 Jun 2022 02:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655509425.git.jahau@rocketmail.com> <362744427c87bfcfa8c885b1bb174dacc4861ec3.1655509425.git.jahau@rocketmail.com>
In-Reply-To: <362744427c87bfcfa8c885b1bb174dacc4861ec3.1655509425.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 18 Jun 2022 11:53:04 +0200
Message-ID: <CAHp75Vc=uqirY2c2aRWoxiw1pOwznZynaecED_LCG+t2xLjnGg@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] iio: magnetometer: yas530: Apply minor cleanups
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jun 18, 2022 at 2:15 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> This commit gathers minor cleanups in the current driver.
>
> In the device examples, "Xiaomi" is too generic, specific devices should be
> listed here. E.g. Xiaomi Redmi 2 seems to have YAS537 but it's not fully clear
> if this applies to all its variants. Samsung Galaxy S7 is often quoted in
> conjunction with YAS537.
>
> In the function yas530_get_calibration_data(), the debug dump was extended to
> 16 elements as this is the size of the calibration data array of YAS530.

We do not accept or even consider contributions w/o SoB tag, sorry.

P.S. Reading briefly, split this to two patches:
1) moving %*ph parameters out from stack;
2) documentation and indentation fixes.

-- 
With Best Regards,
Andy Shevchenko
