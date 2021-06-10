Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45973A294F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 12:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhFJK1j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 06:27:39 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:38785 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFJK1j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 06:27:39 -0400
Received: by mail-pg1-f169.google.com with SMTP id t17so5656225pga.5;
        Thu, 10 Jun 2021 03:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cj+MPWIUrXgB6pYKg9OatCm8cIlTwFg6Vxp4HjwB8Ng=;
        b=fhdMZvTVKl1M9ad8PFG2EF1PPwmqR5dv+xAVxxVJ23pj9DWXOOQN9jZ9RAMlH2Z9r7
         hSElsUonwUHCehtMzFBNdaQgc9vraX7uTqvRupb9GDdCOoi1HREtCqHqkSlnJZah28OD
         edgOfaNFBEx4pNwdJqibhEqWhCjuLZfdL1F8enYnAiHVLTVcL+5bBZJ0wfY1MelDFMJ+
         6CUeCjCcwskykurCuz8gx8m2JBZc3yl0NeeNmCy69oiQr9B6cT2Uo6QkjUCu9cKvSgDa
         SDzOFKwW+nzRKBGrXGF0TeXasI8YldB4Lz8TqFCa/3fy/Ol9OCNHVlF69Bdf0YSw59Yr
         HG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cj+MPWIUrXgB6pYKg9OatCm8cIlTwFg6Vxp4HjwB8Ng=;
        b=tYbezOjVdz8AOjh3dC3DxZkRoyN9CvYpMh6mb5S0haIOhmQFEbQnCMAUNK0kV8ALvN
         ERTFF4g4Z0G/SBUYVMxzovmiBlRV1EGuR5YWMTXANvFLis8iUTN3P2wycNoewzab4/yY
         +HoIwszPi7ltpCB68Am6VHm0pPN84gUdXJ1HarM14KQ8wolPIqW2xzx9YNZ7reTxzZz4
         QPJw8Nrhj6uZwrLELrhw3SKXMPVkaBi8aApVUnVTlhH8lyTRhEDmD88RE8bnTqBiljqa
         egepsZ/qLBugCRvt+yTVqdZ5Js2zEsvHSAklqs1K9D2eFHBcKNC8dVd6VZfHkWXsYfrG
         QRSw==
X-Gm-Message-State: AOAM530g9ZOK0DRaiMJxmtBAXbw8eUP3hIOTQcgv/gYa6tHGsZvLIKHk
        0BdpQvb3b2pVDDPzq2LQlx9NaXmna2BObBalzr5YYlaK3Ac=
X-Google-Smtp-Source: ABdhPJyF8M3M2S9wofAFgiKnc4T3Kuh1ghy6YAb669U/WssdcbVrXkQZBv6D2QzHV9IBa6bAoPAmi9BeWeKP5H3zU/w=
X-Received: by 2002:a63:79c3:: with SMTP id u186mr4266834pgc.203.1623320683220;
 Thu, 10 Jun 2021 03:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210610095300.3613-1-stephan@gerhold.net> <20210610095300.3613-2-stephan@gerhold.net>
In-Reply-To: <20210610095300.3613-2-stephan@gerhold.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Jun 2021 13:24:27 +0300
Message-ID: <CAHp75Ve_uDeNM+TPEDc-w6tV+rSoF1sAPXo5rKjqC2+3vjDgHQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] iio: accel: bmc150: Drop misleading/duplicate chip identifiers
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Laurentiu Palcu <laurentiu.palcu@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 12:56 PM Stephan Gerhold <stephan@gerhold.net> wrote:
>
> Commit 0ad4bf370176 ("iio:accel:bmc150-accel: Use the chip ID to detect
> sensor variant") stopped using the I2C/ACPI match data to look up the
> bmc150_accel_chip_info. However, the bmc150_accel_chip_info_tbl remained
> as-is, with multiple entries with the same chip_id (e.g. 0xFA for
> BMC150/BMI055/BMA255). This is redundant now because actually the driver
> will always select the first entry with a matching chip_id.
>
> So even if a device probes e.g. with BMA0255 it will end up using the
> chip_info for BMC150. And in general that's fine for now, the entries
> for BMC150/BMI055/BMA255 were exactly the same anyway (except for the
> name, which is replaced with the more accurate one later).
>
> But in this case it's misleading because it suggests that one should
> add even more entries with the same chip_id when adding support for
> new variants. Let's make that more clear by removing the enum with
> the chip identifiers entirely and instead have only one entry per
> chip_id.
>
> Note that we may need to bring back some mechanism to differentiate
> between different chips with the same chip_id in the future.
> For example, BMA250 (currently supported by the bma180 driver) has the
> same chip_id = 0x03 as BMA222 even though they have different channel
> sizes (8 bits vs 10 bits). But in any case, that mechanism would
> need to look quite different from what we have right now.

...

>  static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {

Perhaps sort this by chip_id value?

...

>  static const struct acpi_device_id bmc150_accel_acpi_match[] = {
> -       {"BSBA0150",    bmc150},
> -       {"BMC150A",     bmc150},
> -       {"BMI055A",     bmi055},
> -       {"BMA0255",     bma255},
> -       {"BMA250E",     bma250e},
> -       {"BMA222",      bma222},
> -       {"BMA222E",     bma222e},
> -       {"BMA0280",     bma280},
> +       {"BSBA0150"},
> +       {"BMC150A"},
> +       {"BMI055A"},
> +       {"BMA0255"},
> +       {"BMA250E"},
> +       {"BMA222"},
> +       {"BMA222E"},
> +       {"BMA0280"},
>         {"BOSC0200"},
>         {"DUAL250E"},

I have noticed during review patch 3 that the arrays are unsorted, can
we at the same time sort them by ID, please?

...

>  static const struct i2c_device_id bmc150_accel_id[] = {

Ditto.

>         {}
>  };

...

>  static const struct acpi_device_id bmc150_accel_acpi_match[] = {

Ditto.

>         { },
>  };

...

>  static const struct spi_device_id bmc150_accel_id[] = {

Ditto.

>         {}
>  };

-- 
With Best Regards,
Andy Shevchenko
