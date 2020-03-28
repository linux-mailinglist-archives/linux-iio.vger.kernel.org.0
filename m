Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4989196523
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 11:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgC1Kpn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 06:45:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36120 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1Kpn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 06:45:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id i13so5863071pfe.3;
        Sat, 28 Mar 2020 03:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RukT/AsNxTsj07Q4HN6VwGWP+3cVI4PVAl2WbnFXBpI=;
        b=vd+Cb+zMmgqs2ObKAxYxSs8+PITxbH9LgVigA4nV84ah1k2O37DyEWAgzgQROXuvsn
         MZg8neG+WdTywOz4UrCRhe9YAqBkjWSCyExR487PzLTSrajIkABCAkHgzxI95f2/vMtp
         W5UyB0h4GQWv/EcLrGBf8NkRnJy4Gra75wav6gui+NtZQHvIlP78j8l1dtBrwkWltATO
         JM2vHGhGtxK1l9Y0z/SudM2PkyP3g1i8GlE5xaX5zP5vpGyx7nxaWn41fr8/z5J0+csh
         2+fPzsk773RtPV6WM5LWCH5W6FHeEZ0WlJ1XR4QlFvkIsKIG/K65bg3Q5/6YVbshUACr
         B20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RukT/AsNxTsj07Q4HN6VwGWP+3cVI4PVAl2WbnFXBpI=;
        b=eNdfsmIAMSpTMClbbfooVHgsQpzF7wPohM41cGRczs7D84FBS1etYnX6CC/CterISW
         aWuWwlujyhy0GBTzP5uCqv/tnyo9sHOgAbLfzE+fl6+N4zy2VEYiho4F7+EHya/uPhzi
         kHZ295E3KKlRqMbZc+7dELd7OoB/EFMKfC+KAbATHT/sVT9Fj0VNs8z+SZlpQMqt7tFh
         hXylJ1vbIFs/lpGxCnh/5zWKMKAIdeiCIK+j7ir8KAJb0svufQJlG8WRUaMPbr0z9GHq
         MlZg4uLwkQAYgbeBi80KbC5dpux//JxTKv/r1uWgLv2nl6MKrug41LCiqSr0ZolvOF2y
         4sFQ==
X-Gm-Message-State: ANhLgQ0v/oRZsF74qfG1g2XO/1ei5gR6FRcupN0VqpkuF2MI5OxQjq0F
        UvEFVdMh/DPfadSgbA2tf33SiE3V0lO0u85RCOY=
X-Google-Smtp-Source: ADFU+vu2zqVAQGh1j/qEr7LmshE0N+ohFw4ESZyZiR1C2rZjMfayj2Sg/HcofZVHte/2UykmaKsNC1qTOn9LXOdqtcQ=
X-Received: by 2002:a63:798a:: with SMTP id u132mr3905322pgc.203.1585392342491;
 Sat, 28 Mar 2020 03:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200328001154.17313-1-sravanhome@gmail.com> <20200328001154.17313-3-sravanhome@gmail.com>
In-Reply-To: <20200328001154.17313-3-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 28 Mar 2020 12:45:31 +0200
Message-ID: <CAHp75Vdc4MxMnmd_h6eFfZAji=4fir7x7bq2MX1q50nAQ1eJ=Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] mfd: mp2629: Add support for mps battery charger
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 28, 2020 at 2:12 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> mp2629 is a highly-integrated switching-mode battery charge management
> device for single-cell Li-ion or Li-polymer battery.
>
> Add MFD core enables chip access for ADC driver for battery readings,
> and a power supply battery-charger driver

...

> +#ifndef __MP2629_H__
> +#define __MP2629_H__

> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>

None of these header is in use here.

struct device;
struct regmap;

would be enough.

> +struct mp2629_info {
> +       struct device *dev;
> +       struct regmap *regmap;
> +};
> +
> +#endif

-- 
With Best Regards,
Andy Shevchenko
