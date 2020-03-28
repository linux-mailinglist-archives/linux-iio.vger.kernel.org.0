Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D981C196571
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 12:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgC1LC3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 07:02:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42327 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgC1LC3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 07:02:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id e1so4512746plt.9;
        Sat, 28 Mar 2020 04:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ybzEvvM/Y1fK+T4WB91lb7mb7tennh3w1iclknsvBKc=;
        b=gjcm36dXWUs94y8B/p36oRvfBldTX64A6N06TUsXWS0b6nFqH9rrxoCyNRHHeaiVvv
         2LEb+zr4cpeSH3c8zLRfFw7jgECmRWw4mCs/f3/u2Ww6lmBoefnBs/fIN8A3GcNwNmVK
         Gicsud5Vj0H+I01Pg+ccfKrB1dPmMbHfo1vaCaGqSPFv7xrTY5WUlOXlUYi74oWp2hiF
         z5LLYLMYKpyFvO3E4jC5wkTmryGlRW/yfOWK22PC1u+XAiXNEzFJ45Tz92vRfXqUUlc1
         dN8XRULR6WSGhd1zWwvsa8Yy3X25R3H3u2heWimkaCV/Sz8qgKBtT6k0nXrMQ0JfeK5b
         2yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybzEvvM/Y1fK+T4WB91lb7mb7tennh3w1iclknsvBKc=;
        b=Mq90f3Nhi73MFpYncHkTweX/jPhRB1Nu8S1AEaweCkrCt3gDehgZKMM4EYbCm+nqxS
         gFWq0gT7AZThy70TERzTyvPaF+YZfjWooc2QKlL72C56y5g3ssHt0oYCZGUzhZ8EWjEP
         YHE96N1W3X7pDsy8emZJ1nwPkre4D93C86Zvho88HSv3NjQrMj7MT+Ev9x8xoaoGmGjX
         BIDOVcTxPAfF98iI4bShycZIsPinJX3WPG3xcu0NDukBI6L/BU55VFDdzrvLIsQuq5u9
         GZnO2sDEfTLS7ihC2uOwyKwksO+VNg/7UcF8rnXdxMIrm8MGnAXYTbVPopNE8YVyth8V
         V6tA==
X-Gm-Message-State: ANhLgQ24Kxf25wpCOcwQ2CCrFkSdc7wYOUiEG3M0wKpelBVwt5Y5mCsY
        9Ha5dmzr/MudgEZcLpDpt3hmaAD4bhYIZWiZT3Q=
X-Google-Smtp-Source: ADFU+vuCr9+XdOtdmikLkVMOj3ejA58Zcuyfi6kogZWnczcwpxiLFPcnu2MTG/IsoHJiICAMnk8f3uvOS5NSWlNwi7k=
X-Received: by 2002:a17:90a:9408:: with SMTP id r8mr4479521pjo.1.1585393348229;
 Sat, 28 Mar 2020 04:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200328001154.17313-1-sravanhome@gmail.com> <20200328001154.17313-5-sravanhome@gmail.com>
In-Reply-To: <20200328001154.17313-5-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 28 Mar 2020 13:02:17 +0200
Message-ID: <CAHp75VefP3oPyRJ=Z9Y5Wv3rSc-nJdKFLJ60YLdUbP5dFikS+w@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] power: supply: Add support for mps mp2629 battery charger
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
> The mp2629 provides switching-mode battery charge management for
> single-cell Li-ion or Li-polymer battery. Driver supports the
> access/control input source and battery charging parameters.

...

> +#include <linux/module.h>
> +#include <linux/of_device.h>

Missed header bits.h.

...

> +       ret = iio_read_channel_processed(charger->iiochan[ch], &chval);

> +       if (ret < 0)

Is it possible to get positive returned value?

> +               return ret;

...

> +       val->intval = (rval * props[fld].step) + props[fld].min;

Too many parentheses.

...

> +       return ((psp == POWER_SUPPLY_PROP_PRECHARGE_CURRENT) ||
> +               (psp == POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT) ||
> +               (psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT) ||
> +               (psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE));

Ditto.

...

> +       return ((psp == POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT) ||
> +               (psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT));

Ditto.

...

> +       return sprintf(buf, "%d mohm\n", rval);

Hmm... For units we usually have separate node, but it is up to
maintainer, I dunno what the common practice is there.

...

> +       int val;
> +       int ret;
> +
> +       ret = kstrtoint(buf, 10, &val);
> +       if (ret)
> +               return ret;
> +

> +       if (val < 0 && val > 140)

What the point to convert negative values in the first place? kstrtouint()

> +               return -ERANGE;

...

> +       struct power_supply_config psy_cfg = {NULL};

{ 0 }

-- 
With Best Regards,
Andy Shevchenko
