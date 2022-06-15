Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7164554C4FD
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 11:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347767AbiFOJsi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 05:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347636AbiFOJs0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 05:48:26 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA4D46C89;
        Wed, 15 Jun 2022 02:48:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id h23so22058729ejj.12;
        Wed, 15 Jun 2022 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0PdQgE8AW1FqJLlPb9KUQOuMjK/uFPg0d1n7yjok5Y=;
        b=OGmPBo1bh6/K8gPJVE9mmZrImpniTz8kXMIDMvi0Q9K1WW+zBmciWBO+p/GaV99YXk
         oHFiREXM0nibnUAt4Yj3UZr/RUT1/r+RZ9kYEJNYOJLvmZcsm3i4CJzOHrzaSXefH/2C
         EqvOmjRQk429Tou8QbLxOgo8wp1SEotONcNF6rJ1mrvmkOIJlXpKNyoNVL6lR30bzwSn
         94ftqKDwzD5l6TNrYy/6usiIDRYVqNUAwA649T1LhGnEmA3ExhW1t9ljtIbiLJSpLZxP
         1Y+hbK+PLvFTv8VT4mxi45x9xje/o81usn2TnxMftMftTfpMWILtGmFhvwSoqheD/zg4
         WIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0PdQgE8AW1FqJLlPb9KUQOuMjK/uFPg0d1n7yjok5Y=;
        b=GiDJoRdV4w9BxcSznfEJP1NAAGtUGWyhVhMlS9WEf5oH55ZckJGE2P26PA9cgvRK4O
         Xbs14Oo97Ib/jZLIkcJYzgv8PUZRVTiP3EqgfrVLI/NWdBWxx6rVO1xAwCria+xRqe8L
         5SEuK5G0MhuqrnsgPz5hCzMkOh2J0nxq01bV+IaH9i1srCEcIJj/LuAt9D9+u9JoCbOg
         r+kvKi6sx9aplA0pvFhfc4JKsX41NCLABhVFVe9raUOqDpTLFgOTqo8g93bBYe4lAe7F
         8GVVeWIEZuUgdR9950kXoPXh7OnuAN+z9t5gPLf2OpYbMdogg76mZ8FZnx/tROIkxkB3
         Jp1A==
X-Gm-Message-State: AOAM530XfoI6XebuvTrnhvDhPoC5n9mgAtWTh+xShJ6mq8e3vz2S4NKH
        w4+ChdccapI6gbNqU07qkwwomzx39/H5h1sgxa8=
X-Google-Smtp-Source: ABdhPJzzrmS0VyKeWdLvJmIOSc060BFAQCXQq3Affwz81i3FaUy1gH0naGLWVBnIArni8GVKIq8gs9pmp6sqAkAuoZU=
X-Received: by 2002:a17:906:149:b0:711:fca6:bc2f with SMTP id
 9-20020a170906014900b00711fca6bc2fmr8195332ejh.497.1655286502558; Wed, 15 Jun
 2022 02:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220614194225.2226447-1-sravanhome@gmail.com> <20220614194225.2226447-3-sravanhome@gmail.com>
In-Reply-To: <20220614194225.2226447-3-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jun 2022 11:47:44 +0200
Message-ID: <CAHp75Vf8TeD2sxeROTmSr9frCs=CvZ2eaMFW=4D2+W3unj7dcA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] mfd: mp2629: Add support for mps mp2733 battery charger
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
> mp2733 is updated version of mp2629 battery charge management
> device for single-cell Li-ion or Li-polymer battery. Additionally
> supports usb fast-charge and higher range of input voltage.

USB

It seems I already gave this comment somewhere.

...

The code looks good.

-- 
With Best Regards,
Andy Shevchenko
