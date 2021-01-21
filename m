Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A812FEFE7
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jan 2021 17:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387618AbhAUQKM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jan 2021 11:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731893AbhAUQKD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jan 2021 11:10:03 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7EEC0613D6;
        Thu, 21 Jan 2021 08:09:22 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b8so1507371plh.12;
        Thu, 21 Jan 2021 08:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7oVga7Escj/c6BU5fn9u2qNIv4eQlnHp8uz/6apHm8=;
        b=u13qVxp+ZtSHi+YnVRLB3wpgmSKmpNWCcNZUbEumSVrAjePaV7jzEOA1BNcokSMm5K
         bb3cWcZ0R7Xzx0+2YBcJI6XQAMflPW1QUHNRf0Wb4fNYY3P59R262N2ZrHLs7wkQNvuT
         xNPAu9mlC5g0WJoVyGbN5+EdhNJ+knPl81IiiFYACckKVWftkHgTI1AlS1V+IAAG3O5L
         q/cDvnpumIrADAEIxyVXg48ada/aXIZr82dB3SFykrn4yA+vaxt/BLnir2ZHhTPPvF5E
         0iBiWUQ9xn7qsj5c5Fxo99lG/A22xWjkVBdWzXLz+D4EFR2LYsr6p2mAybN+REoeWSrE
         t4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7oVga7Escj/c6BU5fn9u2qNIv4eQlnHp8uz/6apHm8=;
        b=YwPt7yxXw11UHG6uW8ttXO844UtbTurtepDaROsL1I296cGdSsS+XX407Ud2gB3zUz
         xzM4FwKt9yAZ0gxsYY5hdAzwW1JaDbtp5AKyN2ALY1YuGYmBzVJy408Z6Erjmwa0y5hB
         55xOD3FVMrxq4hYRXHnqxODciPeQaKsLG/LaGtzyAvRV6kaLfUPWn1cHEmxUjuwI6TVZ
         uPH2W/svRCHW9TmyebCAb5ddNJM/kN9vYT0TRB+aeNmQxKZl8MX3zw+GFOJ1RytuAAFu
         5kOdmYJLwxpYEpqEJ0GzWQyNHP9J+FVoOAdDNpcvPM6q7H7Vja5SPNXGUcpnunJsiThC
         tB5A==
X-Gm-Message-State: AOAM533Xk+ahvjg09dTToVGt+SFOPIqnbIanXvqO5Wfg6/3bzvJoG/xP
        aLVMzXsC7Pfb0lsdYnuxtYh4dlD/TWH70idkPr0=
X-Google-Smtp-Source: ABdhPJz810rj4uEh3NOSZjkte6BAAPp2lkFigFSpC0lmoi8bADNmSJpDd6MCWI3LiIBOxL+SgTYdC7FnQIAMX/83wZI=
X-Received: by 2002:a17:902:7b96:b029:de:7ae6:b8db with SMTP id
 w22-20020a1709027b96b02900de7ae6b8dbmr425254pll.0.1611245361597; Thu, 21 Jan
 2021 08:09:21 -0800 (PST)
MIME-Version: 1.0
References: <20210121142716.6374-1-o.rempel@pengutronix.de> <20210121142716.6374-3-o.rempel@pengutronix.de>
In-Reply-To: <20210121142716.6374-3-o.rempel@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Jan 2021 18:10:10 +0200
Message-ID: <CAHp75VfnV+A=BpXGqf=xC=RTozfNrmq7X5V0o8aK2ptMyZF9YA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] counter: add GPIO based pulse counters
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jan 21, 2021 at 4:32 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Add simple GPIO base pulse counter. This device is used to measure
> rotation speed of some agricultural devices, so no high frequency on the
> counter pin is expected.
>
> The maximal measurement frequency depends on the CPU and system load. On
> the idle iMX6S I was able to measure up to 20kHz without count drops.

...

> +#include <linux/of_gpio.h>

It would be better to see OF agnostic code WRT GPIOs.

...

> +static ssize_t gpio_pulse_count_enable_read(struct counter_device *counter,
> +                                           struct counter_count *count,
> +                                           void *private, char *buf)
> +{
> +       struct gpio_pulse_priv *priv = counter->priv;
> +
> +       return scnprintf(buf, PAGE_SIZE, "%d\n", priv->enabled);

sysfs_emit()

> +}
> +
> +static ssize_t gpio_pulse_count_enable_write(struct counter_device *counter,
> +                                            struct counter_count *count,
> +                                            void *private,
> +                                            const char *buf, size_t len)
> +{
> +       struct gpio_pulse_priv *priv = counter->priv;
> +       bool enable;
> +       ssize_t ret;
> +
> +       ret = kstrtobool(buf, &enable);
> +       if (ret)
> +               return ret;
> +
> +       if (priv->enabled == enable)
> +               return len;
> +
> +       if (enable)
> +               enable_irq(priv->irq);
> +       else
> +               disable_irq(priv->irq);

Oops, if IRQ happens here, shouldn't we have priv->enabled already set properly?

> +       priv->enabled = enable;
> +
> +       return len;
> +}
> +
> +static const struct counter_count_ext gpio_pulse_count_ext[] = {
> +       {
> +               .name = "enable",
> +               .read = gpio_pulse_count_enable_read,
> +               .write = gpio_pulse_count_enable_write

Leave the comma here.

> +       },
> +};

...

> +static struct counter_signal gpio_pulse_signals[] = {
> +       {
> +               .id = 0,
> +               .name = "Channel 0 signal"

Leave the comma.

> +       },
> +};
> +
> +static struct counter_synapse gpio_pulse_count_synapses[] = {
> +       {
> +               .actions_list = gpio_pulse_synapse_actions,
> +               .num_actions = ARRAY_SIZE(gpio_pulse_synapse_actions),
> +               .signal = &gpio_pulse_signals[0]

Ditto.

> +       },
> +};

...

> +static struct counter_count gpio_pulse_counts[] = {
> +       {
> +               .id = 0,
> +               .name = "Channel 1 Count",
> +               .functions_list = gpio_pulse_count_functions,
> +               .num_functions = ARRAY_SIZE(gpio_pulse_count_functions),
> +               .synapses = gpio_pulse_count_synapses,
> +               .num_synapses = ARRAY_SIZE(gpio_pulse_count_synapses),
> +               .ext = gpio_pulse_count_ext,
> +               .num_ext = ARRAY_SIZE(gpio_pulse_count_ext)

Ditto

> +       },
> +};
> +

...

> +       struct device_node *np = pdev->dev.of_node;

> +       if (of_gpio_count(np) != 1) {
> +               dev_err(dev, "Error, need exactly 1 gpio for device\n");
> +               return -EINVAL;
> +       }

gpiod_count() ?

> +       priv->gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(np),
> +                                          NULL, GPIOD_IN, GPIO_PULSE_NAME);

of node to fwnode, can we avoid dragging this here to there?

Why is devm_gpiod_get() followed by a label setting not good enough?

> +       if (IS_ERR(priv->gpio))
> +               return dev_err_probe(dev, PTR_ERR(priv->gpio), "failed to get gpio\n");

...

> +static const struct of_device_id gpio_pulse_cnt_of_match[] = {
> +       { .compatible = "virtual,gpio-pulse-counter", },
> +       {},

No comma needed for real terminator entry.

> +};

-- 
With Best Regards,
Andy Shevchenko
