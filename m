Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C987C19494F
	for <lists+linux-iio@lfdr.de>; Thu, 26 Mar 2020 21:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCZUj0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Mar 2020 16:39:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39763 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgCZUj0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 16:39:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id d25so3368756pfn.6;
        Thu, 26 Mar 2020 13:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDuX70eaE4bpaQOBetGsOvBGL0lcD6ef/WORyaEM/DY=;
        b=P3ZSGEnasP9Vd9NR++xJJn9TcarGJpf2QxI/3hYJzy6upZ5YFETkC484KAfoVTDp9P
         Cyg2176D7HUI1qET4rEus3zBDgm8RGnhUXwIjwjF9RAOtEcEVwcglCcCWfbdScyjzsHk
         L+M40MwXapN2869LMYHD92duBE8B6ZKNMg+jyvrD3cC+VFZ4FuLoH7vUhEe2GnEadd9F
         FYy9VCwb8z/LLqX6pyfeHHc2v2WTk5jVK/mDnctYRI5pI6fyQNBqXZd07NWFEfl646GY
         a+HPNM2wNyOmaqDyF6S8iUuMlRn9k8BkdF3/7XBizg9XM18GZA11Bmwkdt7n2UAiI3sm
         Fo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDuX70eaE4bpaQOBetGsOvBGL0lcD6ef/WORyaEM/DY=;
        b=Mu2fCDnrUeS51Ryoi/2L2kbzeY2RTNE12E9iB0rqLsquAe4X7jcBg5MU1fxe/tjL6k
         Ii1n86zjBaW+tOnOFEnw+jHgkcjgsAoLRWq38Wg8OVoBkAoyUV221Xkl1FMSSXjlAGDR
         fbn5mRHLYw76XXL0T6beS8n+jLvNxijMBrSxr+Uz5cvaY50jEZmn4WJq/4K0Y/BTkBi3
         eXedKyUIuLq62bycEslCcqE5lI7XVCfYyvJvqyqhcW8o3cd0pkmGxljls8S7QX2hV/8S
         fzQ6gv9qKaEz2+hANGe3SeE3NzZRe0wBLXi8OH7aI1wX6faTevgfsKsaoB+fSObDDtB/
         E5Jw==
X-Gm-Message-State: ANhLgQ2zGos+OqfpZA7fDou5HRc2vmOjvah98po/H//cXVsgoDTFOtWA
        MW2BYCXayWXlKPOpljIV8mYGQXtdJq9dRKZR0zw=
X-Google-Smtp-Source: ADFU+vseCrYQg2Np8AbAbPVezLGYO74LTgQmzZkFkbF9bNUI8/WX6SgHn1q3eW8b6RvqMANQ7c7Ve38oDo6UJLrwOM4=
X-Received: by 2002:a05:6a00:2b4:: with SMTP id q20mr11130153pfs.36.1585255165429;
 Thu, 26 Mar 2020 13:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200326155118.8224-1-i.mikhaylov@yadro.com> <20200326155118.8224-3-i.mikhaylov@yadro.com>
In-Reply-To: <20200326155118.8224-3-i.mikhaylov@yadro.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 26 Mar 2020 22:39:13 +0200
Message-ID: <CAHp75VfL726QwyR4eJL1HCVLvyQ5W0tJfbEJ+mhmsRWHkB8=6w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: proximity: Add driver support for vcnl3020
 proximity sensor
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 26, 2020 at 5:51 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
>
> Proximity sensor driver based on light/vcnl4000.c code.
> For now supports only the single on-demand measurement.
>
> The VCNL3020 is a fully integrated proximity sensor. Fully
> integrated means that the infrared emitter is included in the
> package. It has 16-bit resolution. It includes a signal
> processing IC and features standard I2C communication
> interface. It features an interrupt function.

Thank you for an update, my (only minors) comments below.
After addressing them,

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

(Don't forget to fix DTS schema as Rob's bot pointed out)

...

> +#define VCNL_ON_DEMAND_TIMEOUT 100000 /* on-demand measurement timeout in us */

This also should have _US suffix, and thus comment is not necessary.

> +#define VCNL_POLL_US           20000

...

> +       if (reg == VCNL3020_PROD_ID) {
> +               data->rev = reg;
> +               mutex_init(&data->lock);
> +       } else {
> +               dev_err(data->dev,
> +                       "Product id (%x) did not match vcnl3020 (%x)", reg,
> +                       VCNL3020_PROD_ID);
> +               return -ENODEV;
> +       }

I would recommend to use standard pattern, i.e.
  if (reg != ...) {
    ...error handling...
  }

in this case else branch becomes a mainstream code in the function.

...

> +       rc = regmap_write(data->regmap, VCNL_LED_CURRENT, led_current);
> +       if (rc) {
> +               dev_err(data->dev, "Error (%d) setting LED current", rc);
> +       }

Now curly braces are redundant.

> +       return rc;

...

> +       rc = regmap_read(data->regmap, VCNL_PS_RESULT_HI, &reg);
> +       if (rc)
> +               goto err_unlock;

> +       *val = reg << 8;

This actually breaks the principle of not touching output buffers /
variables in case of error.

Perhaps

    unsigned int hi, lo;

instead of / along with reg?

> +       dev_dbg(data->dev, "result high byte 0x%x", rc);
> +
> +       rc = regmap_read(data->regmap, VCNL_PS_RESULT_LO, &reg);
> +       if (rc)
> +               goto err_unlock;
> +       *val |= reg;
> +       dev_dbg(data->dev, "result low byte 0x%x", rc);

-- 
With Best Regards,
Andy Shevchenko
