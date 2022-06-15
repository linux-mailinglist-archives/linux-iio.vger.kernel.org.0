Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C901A54C52D
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 11:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347186AbiFOJxr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 05:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346788AbiFOJxn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 05:53:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFFB396B9;
        Wed, 15 Jun 2022 02:53:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id v1so22058234ejg.13;
        Wed, 15 Jun 2022 02:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GikhKivQJzKmYbaChPmx+v0UPgQb1tXpSd4vkzT/6G8=;
        b=B2AjlhIDHLQOvymCm4IJdMdL/DamnXoTSTbLLamPDD8Q1oyrl7tyT7Q5NDlgLtE/oC
         O00MjBh/ZAsy+PFebM/tVA7aPphzwUwuWrEB69dYUsyodJ0W0gt2yN6zmbBvzcCgXNoH
         tBDNvOSzHJsmON3iM0Ui8/8MI6gPmz+EcN+cFARfjBfjSLkqXT6YKRFS2wAkOnNMOvlb
         6Chni6Hj14F7zdxOy8Egrv7EP1f9Fxai2ldd3vcp4bwkyg5huuSnlrzWH18wPIV+PNDw
         adyMcIAsSOGwawb8hwRl0cflJzVZFCtDkqAHwE5lEWamG50PkehTEQeWagF/v1iMAO9n
         QS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GikhKivQJzKmYbaChPmx+v0UPgQb1tXpSd4vkzT/6G8=;
        b=vy3ftPMy3xHiMBVCN+zM487dSS0VY7uU/g4hvgmiZNdRTNzFU1bV1wnPx1qM5r8vma
         cHEnoE7zWUwZtDeJarG2+20kFao4cR2HV9gMNlRKUQDDSRWp3mQ3sR++G+qS6xmbh7aV
         rz/wP7dPgL+vlCBoUzXIccuU8V6uV4SnDNbkFa8xEpJ7hWHXPYDoJIiKUDP0Vjm3hl5b
         /vazFUzB3n2lor8xInbmNmi6Zfb1XSR4wFckc/CZOwjsYLEN49lW7DTMpiuwj75bnQSU
         gdWu3uglm9CwMxw4TLgZ34xAGezKmS1SRjXkX25mXy9LeJ3IVMmm+y0OECvfhmFiMZ/b
         6NQQ==
X-Gm-Message-State: AOAM533T3crkZ632RD7/C5ant8quqJnVSs5X/xwphQbAS1qMTBbNWLfK
        q8m6HKlYMNppWYNDMZwo111OL+Uyf/TAVTNetSE=
X-Google-Smtp-Source: ABdhPJyEtwPNSHSqff8aykeV3/Ia3F9lMkiK8P/fePUy2yIogqe9RTZF/xt0Mb7SATy13R/UwRVx6oidEYzd7P9BQJw=
X-Received: by 2002:a17:906:c7c1:b0:711:d2e9:99d0 with SMTP id
 dc1-20020a170906c7c100b00711d2e999d0mr8061029ejb.639.1655286820739; Wed, 15
 Jun 2022 02:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220614194225.2226447-1-sravanhome@gmail.com>
In-Reply-To: <20220614194225.2226447-1-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jun 2022 11:53:04 +0200
Message-ID: <CAHp75VdY4UUw9xSCFscSZrmd0s63LhcTSP16_Nn135iv2QSheQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] iio: adc: mp2629: fix wrong comparison of channel
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
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

On Tue, Jun 14, 2022 at 9:42 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> Input voltage channel enum is compared against iio address instead
> of channel.

the channel

...

I do not see a cover letter, but FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
for all patches except DT binding
Note, some of the comments regarding spelling were given, I believe
you are going to address them in v3.

> Fixes: 7abd9fb64682 ("iio: adc: mp2629: Add support for mp2629 ADC driver")
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  drivers/iio/adc/mp2629_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/mp2629_adc.c b/drivers/iio/adc/mp2629_adc.c
> index aca084f1e78a..e7fbfe92e884 100644
> --- a/drivers/iio/adc/mp2629_adc.c
> +++ b/drivers/iio/adc/mp2629_adc.c
> @@ -73,7 +73,7 @@ static int mp2629_read_raw(struct iio_dev *indio_dev,
>                 if (ret)
>                         return ret;
>
> -               if (chan->address == MP2629_INPUT_VOLT)
> +               if (chan->channel == MP2629_INPUT_VOLT)
>                         rval &= GENMASK(6, 0);
>                 *val = rval;
>                 return IIO_VAL_INT;
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
