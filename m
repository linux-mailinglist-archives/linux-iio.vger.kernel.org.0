Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648B0256F8A
	for <lists+linux-iio@lfdr.de>; Sun, 30 Aug 2020 19:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgH3RkK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Aug 2020 13:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgH3RkJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Aug 2020 13:40:09 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C326C061573;
        Sun, 30 Aug 2020 10:40:09 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l191so2992377pgd.5;
        Sun, 30 Aug 2020 10:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X723aEDZab551p4YPovWdlB8+uUD9xkovcO1mRr3nko=;
        b=tUffjiQ1/Yl3+XS5cw2GTmvnGn5kbNZYNt7GVW3IeClGL6N7CteNtHxVIKOHI7Nueu
         d30lE5OUjSbeg/o3atMmKxo0lEuV+cTb3FWGP6EjDs488DL/U8bZxS7xNSSIMdJwZPj4
         1pp/+yDFm/PNjcxZqbcNq9GWKlxuRvvDQBxCzDbVCuTD97MPZANszNFdPEw1BH0dYJIw
         ojpw1F47YtFd2XEcVupLJuL93Ux4gDOLde79XZoeWN6uRJGZ95/0h4ykaLdkw5T6re7U
         BH24moiO1rMJiBK8UxNmZq4pPgUzFPJ3AWVx/YNhi8V6XzpZxfYLqqWMSmQ+PwJNKwTl
         IB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X723aEDZab551p4YPovWdlB8+uUD9xkovcO1mRr3nko=;
        b=HTSk6JZ/KI4z7nSBaT3cwo71NQn8MKsJ8cMD3LC/tqAgY1B6OFjcbVOmohC6oQDdOy
         JFDpdemDhDS1M4NrbWdT8jS3KPtvmhZ5DGzvwFC+9GiXoQ0RPNrWE5rLRMjbVAZGV8rO
         BF043ZlcxE/vEGOhoFq4OyfFuRzq4pPqCaHx78Lt0hFnF26M7taOALbpTBxBGfmYE1VX
         w2DyhlAteVDgLXRrZxdUq8sN9G/2lZ+qj8+K7uzgDGEYtxk/SpHpWqaG7pmysA1T0KVK
         zbKc8M4B0CgjNXoaAGQVgRXQ85NNwsu1EYvTjeA5AdeQcD0eJCi69TE3tiF+ElJ7KwYM
         DkBQ==
X-Gm-Message-State: AOAM533pyeDB4QfO0g8SyKetLct8VtQSrsnA7vnWSeXK1KdOjZ3OHQ7p
        4k7GJR9zzO223M4ODPrRqdtl3P4bAXWkkbhQJ2U=
X-Google-Smtp-Source: ABdhPJybwiDaC0Kgjc3ue8z1ZXQZWjlwcmOPK8godMBjRwwDDBANG3jTHYPKKr6N705Bp/GHxvNsgwZPdsiKF9vPhms=
X-Received: by 2002:a63:ec4c:: with SMTP id r12mr5412712pgj.74.1598809208515;
 Sun, 30 Aug 2020 10:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <1598259985-12517-1-git-send-email-gene.chen.richtek@gmail.com> <1598259985-12517-2-git-send-email-gene.chen.richtek@gmail.com>
In-Reply-To: <1598259985-12517-2-git-send-email-gene.chen.richtek@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 30 Aug 2020 20:39:52 +0300
Message-ID: <CAHp75VdmzurQQB2597VB=PCt0THV0TRVdhXdvO3Z3qcdLCeEPg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: adc: mt6360: Add ADC driver for MT6360
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 24, 2020 at 12:07 PM Gene Chen <gene.chen.richtek@gmail.com> wrote:
>
> Add MT6360 ADC driver include Charger Current, Voltage, and

include -> that includes

> Temperature.

...

> +       help
> +         Say Y here to enable MT6360 ADC Part.
> +         Integrated for System Monitoring include
> +         Charger and Battery Current, Voltage and
> +         Temperature

We have a wider field for this text. Also, use proper punctuation.

...

> +#include <linux/completion.h>
> +#include <linux/interrupt.h>

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>

I would rather move this block after linux/* headers because it's
subsystem related (not so generic).

> +#include <linux/irq.h>

Are you sure about this?

> +#include <linux/kernel.h>
> +#include <linux/ktime.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>

...

> +#define MT6360_AICR_MASK       0xFC

GENMASK() (and include bits.h for that).

> +#define MT6360_ADCEN_MASK      0x8000

> +#define MT6360_PREFERCH_MASK   0xF0

> +#define MT6360_RPTCH_MASK      0x0F

Ditto for all above.

...

> +enum {
> +       MT6360_CHAN_USBID = 0,
> +       MT6360_CHAN_VBUSDIV5,
> +       MT6360_CHAN_VBUSDIV2,
> +       MT6360_CHAN_VSYS,
> +       MT6360_CHAN_VBAT,
> +       MT6360_CHAN_IBUS,
> +       MT6360_CHAN_IBAT,
> +       MT6360_CHAN_CHG_VDDP,
> +       MT6360_CHAN_TEMP_JC,
> +       MT6360_CHAN_VREF_TS,
> +       MT6360_CHAN_TS,

> +       MT6360_CHAN_MAX,

No comma for terminator.

> +};

...

> +       const struct converter {
> +               int multiplier;
> +               int offset;
> +               int divisor;
> +       } adc_converter[MT6360_CHAN_MAX] = {
> +               { 1250, 0, 1}, /* USBID */
> +               { 6250, 0, 1}, /* VBUSDIV5 */
> +               { 2500, 0, 1}, /* VBUSDIV2 */
> +               { 1250, 0, 1}, /* VSYS */
> +               { 1250, 0, 1}, /* VBAT */
> +               { 2500, 0, 1}, /* IBUS */
> +               { 2500, 0, 1}, /* IBAT */
> +               { 1250, 0, 1}, /* CHG_VDDP */
> +               { 105, -8000, 100}, /* TEMP_JC */
> +               { 1250, 0, 1}, /* VREF_TS */
> +               { 1250, 0, 1}, /* TS */
> +       }, sp_ibus_adc_converter = { 1900, 0, 1 }, *sel_converter;

This is quite hidden in the code. Better to move out from the function at least.

...

> +       start_t = ktime_get();
> +       predict_end_t = ktime_add_ms(mad->last_off_timestamps[channel], 50);
> +
> +       if (ktime_after(start_t, predict_end_t))
> +               predict_end_t = ktime_add_ms(start_t, 25);
> +       else
> +               predict_end_t = ktime_add_ms(start_t, 75);
> +

> +       timeout = wait_for_completion_timeout(&mad->adc_complete, msecs_to_jiffies(200));

Above code full of magic numbers.

...

> +       value = (rpt[1] << 8) | rpt[2];

put_unaligned_be16() (or what is this?)

...

> +       /* set prefer channel to 0xf */

What 0x0f is?

> +       regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_PREFERCH_MASK,
> +                          0xF << MT6360_PREFERCH_SHFT);

0xf should be GENMASK() and have its descriptive name.

> +out_adc:

The rule of thumb is to explain in the label what is going to do,
rather than some abstract words. Here, i.e.,
out_mutex_unlock:

> +       mutex_unlock(&mad->adc_lock);

...

> +       if (mask == IIO_CHAN_INFO_PROCESSED)
> +               return mt6360_adc_read_processed(mad, chan->channel, val);
> +
> +       return -EINVAL;

Usual pattern is
 if (err_condition)
  ...handle error...

...

> +       /* 11 ch s32 numbers + 1 s64 timestamp */
> +       s32 data[MT6360_CHAN_MAX + 2] __aligned(8);

We have a better approach now (with a struct being used).

...

> +       u8 configs[3] = {0x80, 0, 0};

Magic.

...

> +static int mt6360_adc_probe(struct platform_device *pdev)
> +{

> +       mad->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +       if (!mad->regmap) {
> +               dev_err(&pdev->dev, "Failed to get parent regmap\n");
> +               return -ENODEV;
> +       }

You may do this before allocation happens. Also consider to introduce
temporary variable to simplify below code, i.e.

struct device *dev = &pdev->dev;
struct regmap *regmap;

...

> +       mad->irq = platform_get_irq_byname(pdev, "adc_donei");
> +       if (mad->irq < 0) {

> +               dev_err(&pdev->dev, "Failed to get adc_done irq\n");

This duplicates the core message.

> +               return mad->irq;
> +       }

...

> +       irq_set_status_flags(mad->irq, IRQ_NOAUTOEN);

Why?


> +       ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to register iio device\n");

> +               return ret;
> +       }
> +
> +       return 0;

return ret; (At least, but I would go even further and do return
devm_iio_device_register(); directly)

> +}

...

> +static const struct of_device_id __maybe_unused mt6360_adc_of_id[] = {
> +       { .compatible = "mediatek,mt6360-adc", },
> +       {},

No comma for terminator line.

> +};

-- 
With Best Regards,
Andy Shevchenko
