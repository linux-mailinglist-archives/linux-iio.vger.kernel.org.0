Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6DF5509B2
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 12:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiFSKdm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 06:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbiFSKde (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 06:33:34 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626D4D13E;
        Sun, 19 Jun 2022 03:33:33 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o10so11459691edi.1;
        Sun, 19 Jun 2022 03:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+X1hXjyvwp+2w3vayb4RCn/spxH4ZaqgCltaU1rHplA=;
        b=BTJQO9voJW1vKsgT0btEodY1tvnnhpJRDcYGMAxTb2Ib5d5g3Euen13gbEH+aGVa95
         d91YXagZiZ71giTOlXTlVMgtSx0i+qeJUAiC5bN62iStl7tR8gA6k24GuCKMRe3Oh+vP
         7GWqANCPAsqiIVEzDUMhwXh4jBwFuD6IbW2ECqpYbMNEjylWcyixH9rQry/UB8xJt+7x
         ygQeq2qXl7RwIvw70rdfCiRZcCKVxRQiBFTuusmb0mSbBkvpn3H4TUjc0yFm8Rkzy7l0
         RvZ1MjVkbzTiE1TXz/CKuZsY6BqBevqjH/tVCnZzc36MvXDQ7ebQo8J2cb1S4VfQCJNj
         dBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+X1hXjyvwp+2w3vayb4RCn/spxH4ZaqgCltaU1rHplA=;
        b=HTyuU3swut1Ok8N8V4kp5VmhxsufXBVvUqp2DjpFj4ekVNVN/r/yNlIwxv+LrdLNiZ
         5+L12udZoMUpIBZmCb5KJi7/yrFMW8zwVF+UzwANp9313kW+u6GUjmSXKn1KZI7s2e0R
         WXEJNXmiTOVWsXyTZRPmjvcf+S7kiwWbDXxGsMWXrwiFtJZROsCplF3YE0lnpIq5/edf
         Sx47d88gGJn2cIwJiGdalOOvwSa6W+rksT/Y4VAq9omvsBPQlXAKCIjIxdKVviHKIXwC
         EmQMCfdBaQoPu6BS60U/OEy3mSdOKygx5Rwf8AgQBFX0kqWs+6N9ax8rnhPk0vDFBMPW
         kgxg==
X-Gm-Message-State: AJIora8ugjnMWqm+9dXBuKZuBhRGbm6ntbDfcIlJ8qAYOds8GhXhbWWH
        oCo7sFciD5D5MhVuzX+bmcr4QiIJYAysfW2Dc9A=
X-Google-Smtp-Source: AGRyM1vChaySuuq26yuk1hR8OBgh/cK+d6arLHy+Vl2o2vFb/x7G+7oVeQ9TKZZtcE1MIbq/LfilJh1p4+i7LNg5cKs=
X-Received: by 2002:a05:6402:5002:b0:435:1ff1:99ee with SMTP id
 p2-20020a056402500200b004351ff199eemr22679113eda.230.1655634812846; Sun, 19
 Jun 2022 03:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655509425.git.jahau@rocketmail.com> <3bdb392bb75073bdfe10aab1739fee2d6c64f10c.1655509425.git.jahau@rocketmail.com>
 <20220618162833.218dbe67@jic23-huawei>
In-Reply-To: <20220618162833.218dbe67@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Jun 2022 12:32:56 +0200
Message-ID: <CAHp75VemByhNAYGuP2h-5HazPZL7k5tyGc1WV2gKEdjX_5Sing@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] iio: magnetometer: yas530: Add YAS537 variant
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jakob Hauser <jahau@rocketmail.com>,
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

On Sat, Jun 18, 2022 at 5:19 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Sat, 18 Jun 2022 02:13:16 +0200
> Jakob Hauser <jahau@rocketmail.com> wrote:

...

> > +             for (i = 0; i < 17; i++) {
>
> Reduce indent by doing this as multiple loops.
> Though even better if you can use bulk writes.
>
>                 int j = 0;
>                 for (i = 0; i < 12; i++) {
>                         ret = regmap_write(yas5xx->map, YAS537_MTC + i,
>                                            data[j++])
>                         if (ret)
>                                 return ret;
>                 }
>
>                 for (i = 0; i < 4; i++) {
>                         ret = regmap_write(yas5xx->map, YAS573_OFFSET_X + i,
>                                            data[j++]);
>                         if (ret)
>                                 return ret;
>                 }

I guess you are referring to _noinc variants of regmap bulk operations.

> > +                     if (i < 12) {
> > +                             ret = regmap_write(yas5xx->map,
> > +                                                YAS537_MTC + i,
> > +                                                data[i]);
> > +                             if (ret)
> > +                                     return ret;
> > +                     } else if (i < 15) {
> > +                             ret = regmap_write(yas5xx->map,
> > +                                                YAS537_OFFSET_X + i - 12,
> > +                                                data[i]);
> > +                             if (ret)
> > +                                     return ret;
> > +                             yas5xx->hard_offsets[i - 12] = data[i];
> > +                     } else {
> > +                             ret = regmap_write(yas5xx->map,
> > +                                                YAS537_HCK + i - 15,
> > +                                                data[i]);
> > +                             if (ret)
> > +                                     return ret;
> > +                     }
> > +             }

-- 
With Best Regards,
Andy Shevchenko
