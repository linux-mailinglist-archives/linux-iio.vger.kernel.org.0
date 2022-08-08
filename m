Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338B958C74C
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 13:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242723AbiHHLJN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 07:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242711AbiHHLJL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 07:09:11 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C0C1DE;
        Mon,  8 Aug 2022 04:09:10 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id i24so6109442qkg.13;
        Mon, 08 Aug 2022 04:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1ZICuUACDXU0wRf1BqE8YVxt+1awvyMB+ydR4p42Cs8=;
        b=olPoyO7twh/XWlMoJnk3/MsFlbsdBl3NlJNlLg0nJKJ3+TZf1ZL/AzM1I9Mts5VwhE
         0zj4O0xINVUYrrNaKQ+Au/34Zr6ni22+Z1oSB3a5OCX8rlOpWJFz83/O/W/AqiHkXtJG
         En84T4Yn+hQCyn1QH4SA36CJCaMTxoLL0P0bdLWRPAj4lrBZtiBC23WTq2d93XMms1fq
         WQsPCADsl1TdVt2b3JBflfX4mlhGgiOxlzQcj6FAUBJ/nIgo0KuT+/7gnZYQ4hCjHsaV
         NiFcAl+pZamVHdL5PzvWu6ARplUNmqqsuoqchxRObpw4yQn2qHq3cu6HLI+CZ3EDnPmz
         3mJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1ZICuUACDXU0wRf1BqE8YVxt+1awvyMB+ydR4p42Cs8=;
        b=B62DD2TVuT4Ts+kPkEclF6/fVo3NNCUR68vpc7cxp1DNzqyn2FU4EhE7xVgO0wjNP5
         dt7gHef6H6t7m2FuQpbuaspkPsc2g2rRp1OdcVondCYR56jXf3XPoYOWjLSCLVxgORhT
         SfiUE+DL83fb9KIrgjJOvknM/k0BYCtmaEPzrcgp1ZR2DVu2BbHZWK9H43Xw2hCKrI/M
         wEiWRpYYC0Ne/6kXZhecgQx9aXqrKfSzwsoXCUD9xuHLIBplsmINPdG5tXC+aWdDlNNm
         TWXfHO5+LuG/T0kf7xlO+DdHFZMS/oB8y5vOV+8hsheWxcOmPcaC9pphJLfv65wFZ2OD
         bXeQ==
X-Gm-Message-State: ACgBeo2h4lm0I06wF4fBivP+tdzNj0JKuE8sbGTQFE2hht22tu4IIT8e
        GNn+/8gEoKA5ccacYynW8vTFnEM422lzf2wBMxIma9NQyJSZtw==
X-Google-Smtp-Source: AA6agR4oLpcG0qUwUOreFHUzaTJRELzubdWQHIzy4ayjZ7SM66hICMg2cDJlURl4Ro9nTwjko7jyoO3/w9Xtazf1J5k=
X-Received: by 2002:a05:620a:2809:b0:6b6:5908:316e with SMTP id
 f9-20020a05620a280900b006b65908316emr13993778qkp.734.1659956950005; Mon, 08
 Aug 2022 04:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659909060.git.jahau@rocketmail.com> <ca008512c5196a377042cd71254dedad3668bb44.1659909060.git.jahau@rocketmail.com>
In-Reply-To: <ca008512c5196a377042cd71254dedad3668bb44.1659909060.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 13:08:33 +0200
Message-ID: <CAHp75Ve19nzSem+CCL6w77mkavSCW0LzrDTAWkfQUHJXy=QAoA@mail.gmail.com>
Subject: Re: [PATCH v5 06/14] iio: magnetometer: yas530: Rename functions and registers
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

On Mon, Aug 8, 2022 at 1:03 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> This is a preparation for adding YAS537 variant.

the YAS537

> Functions that are used only by YAS530, YAS532 and YAS533 are renamed from
> yas5xx to yas530. Same for the registers.
>
> To avoid part listing in function and registers names, the name of the first
> variant is used. Where appropriate, comments were added that these functions
> are used by more than one variant.
>
> Functions that will be used by all variants including YAS537 remain in the
> naming scheme yas5xx. Or YAS5XX for registers, respectively.

...

>  /**
> - * yas5xx_get_measure() - Measure a sample of all axis and process
> + * yas530_get_measure() - Measure a sample of all axis and process
>   * @yas5xx: The device state
>   * @to: Temperature out
>   * @xo: X axis out
>   * @yo: Y axis out
>   * @zo: Z axis out
>   * @return: 0 on success or error code

> + * Used by YAS530, YAS532 and YAS533

In this case (multi-line comment) the period should be added to the
sentence. Ditto for other similar cases.

>   */

Otherwise the change looks good. So, if you address these,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
