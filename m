Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5A3585339
	for <lists+linux-iio@lfdr.de>; Fri, 29 Jul 2022 18:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbiG2QNz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Jul 2022 12:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiG2QNy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jul 2022 12:13:54 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F2C8051A;
        Fri, 29 Jul 2022 09:13:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a89so6404943edf.5;
        Fri, 29 Jul 2022 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BiIVKWMwPl8zZC85CjosOGko4Lv+xC1/XTxOKwarLfM=;
        b=fHjwOp65DrOZsASHo3V6MmffON5jfRjreK76MSH/9FmqaKcPgXUMdjfStPZ30hy1/z
         eEpNlLAfmCv47SL5iaPrfqh5Fa8Cmdjj0JNvIKUvmNM+O+RWahv3FP0EXPWi0F9iWtEX
         FKnH6d+b4/7sutXltkM/VfJ4mXO2JDoUgiOjeHUYxeVv3FuH+uqX8DiA8+rHKJx0LU8C
         y8g/edseJMbSQbkZzsspjg7zW4rMbamKGcopts1Nz00Ee8hHI8XwMWMhfqJqJLouJhl3
         fQa9FCrK9xiPowFusD6pOWBiwCu3I9+DgIK50UQD3AK6TzlaIfXlZxe2HRVpSEnrGA9x
         h5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BiIVKWMwPl8zZC85CjosOGko4Lv+xC1/XTxOKwarLfM=;
        b=u1EqJGi5F2VcfeW8O/DSZ/KCpkysuY2z+HaMgNhQIsqoSoOrGs45+uxia13k5rwZEw
         WOPM7pwIaWHPkbsdzix9/HEo+/iYmV8/CatXN39S3DWe76xfWZqs8nDQQP8M30n6YdIX
         X3haypLc1Qtulfkmy+WQDSoWKnLb44hSkSiw+BWSs/M3DlF8XCI9lVH7IwZghcjKNOfs
         Kkk+soWJI+qCB167qqX7uBFFmX572Z12DiGKyPUJyItRLrH7fi+3P0yUWSPJY6xNS1cD
         kpYmwnyw6NegMWZSTqsj5VwzTXmRJL8OfJHYjVJsy2wRJyHb75zsRBO6SivNYfSe6gX4
         eqqw==
X-Gm-Message-State: AJIora+LlBID8Sf6SVvYWhsgVmaMix+RU1Jj5Hgag+dsyW0E5J/18O7Z
        F0dy2z+VTD8WHenNOtHqjK854caYhFjt2sm4QIc=
X-Google-Smtp-Source: AGRyM1sHbgpBR+oeKzR4ubTM2Q2PSKokyw+LCj2VgGVFEBFen7c4/7rYvdFQ3pjMMnsrVMCRCzzIsQKQwzvelBdHx/M=
X-Received: by 2002:a05:6402:40c3:b0:43b:d65a:cbf7 with SMTP id
 z3-20020a05640240c300b0043bd65acbf7mr4331513edb.380.1659111232431; Fri, 29
 Jul 2022 09:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656883851.git.jahau@rocketmail.com> <28a2a9ec27c6fb4073149b897415475a8f04e3f7.1656883851.git.jahau@rocketmail.com>
 <CAHp75VfGqk_q1iDyj06tEuTNoG35xjOL0_5HgokFauUz_aAwFQ@mail.gmail.com>
 <8639301c-ae9e-54ac-919d-baeb8760a31b@rocketmail.com> <CAHp75VecjLe67XfK6qgM4eZfKiTJ-UabD40i6Q_YmMpyWAWMkg@mail.gmail.com>
 <c52e34f1-1cc3-4351-e03b-6b9bf83481b6@rocketmail.com>
In-Reply-To: <c52e34f1-1cc3-4351-e03b-6b9bf83481b6@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jul 2022 18:13:14 +0200
Message-ID: <CAHp75Ve_0srfZbvKJ4z8dW3Mp_a8CHSTqASSAY_SOJiD20K0eA@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] iio: magnetometer: yas530: Introduce "chip_info" structure
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 29, 2022 at 1:06 AM Jakob Hauser <jahau@rocketmail.com> wrote:
> On 27.07.22 19:39, Andy Shevchenko wrote:

...

Just a couple of remarks.

> Indeed, to my own surprise I found a solution with the 2D array:
>
>         static const char * const yas5xx_product_name[] = {
>                 "YAS530 MS-3E",
>                 "YAS532 MS-3R",
>                 "YAS533 MS-3F",
>         };
>
>         static const char * const yas5xx_version_name[][2] = {

yas5xx_version_names (note S at the end)

>                 [yas530] = { "A", "B" },
>                 [yas532] = { "AB", "AC" },
>                 [yas533] = { "AB", "AC" },
>         };
>
>         ...
>
>         struct yas5xx_chip_info {
>                 ...
>                 const char *product_name;
>                 const char * const *version_name;
>                 ...
>         };
>
>         static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
>                 [yas530] = {
>                         ...
>                         .product_name = yas5xx_product_name[0],
>                         .version_name = yas5xx_version_name[0],

Also 0 --> yas530 (use enum:ed indices)

>                 },
>         };
>

-- 
With Best Regards,
Andy Shevchenko
