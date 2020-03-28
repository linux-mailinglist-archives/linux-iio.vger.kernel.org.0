Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59766196531
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 11:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgC1KwY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 06:52:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41513 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgC1KwY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 06:52:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id d24so678489pll.8;
        Sat, 28 Mar 2020 03:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YcKn/H8EDvahzikQuDQ0C/2jv4PkNkkgCQKKj34zNzU=;
        b=Aq4+5gmji624zQXh/p3KCAR+m5x43hob634OL/vHwySR8euy8H9Z1vnBgp970IK8eD
         x24zEis9Y7h6I10OLNJ1oLzuoWRlnMBrL59ojvdpXzWNVKnpAfjCE/quPUckA0C84GB6
         ojq87jZ+RoyuIgX3Ch2qpzoMhIFzyqBzoT0/xAxdTnbi6uRbG8HtDmi46tAMTSdtL/NB
         yUpvK1ndDbPWHjwv5heS52sIEDeI0RsheV2+o2WWh8GzMwD35mlSn3qnsbpVBnUb0/NK
         OhiPGGPWMGjxHfLiw6D7fqYAZ+E/MZC0FemWrtD2K+5H4+jrFAqdWjApUEyvROiaysas
         hNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YcKn/H8EDvahzikQuDQ0C/2jv4PkNkkgCQKKj34zNzU=;
        b=OaGzN7ONZYLBdjZtGmpZaKhSP0+wC5Rqzao6bPf5jK0gs2zGqvJBq+gX7hMolUaBWS
         LRZu4OFJtGDs3TEA2/H4iYdtv4Py1pLn/d9kyytLrFaQnWaoFE4MGqIqKN8fYiOUnhPO
         y5hjjsMg9Q9h2lZINaxn3mMFmnk9j+FHR2MnBthULMnkIm6iu4piLXPjZWUgjdF/z3cB
         8ARFh/5u+xWjbqEg1vNJYLqLm7wTEBEqu1c+H9Ui5vGH/cUtuHW9DD9OzVX0E4C/Afpk
         qZKuXDC4eRD99dIidWrBZIGAqgWfWruOXwHCgnO6UNMlUwfOXCgkxKu53kJ9yPKH2K0o
         ZKaw==
X-Gm-Message-State: ANhLgQ2+Gkiz3BjWhYWrspC54XMPW2jt2YAqnRQ9i3X6VdkbokzJAuZg
        JYUT8tlcQ8qPVm4GpmWmBJ3EZp/bdG0P9OFBEIA=
X-Google-Smtp-Source: ADFU+vtWEO67dR4rn0uYyS0uWFD2xD8gBrqyU1X3pu1a9Fb0fdsPskth2ohRugs+hg9Jmm/g4k5LlQR5WBgqNXRyHj0=
X-Received: by 2002:a17:90a:8403:: with SMTP id j3mr4422773pjn.8.1585392742658;
 Sat, 28 Mar 2020 03:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200328001154.17313-1-sravanhome@gmail.com> <20200328001154.17313-4-sravanhome@gmail.com>
In-Reply-To: <20200328001154.17313-4-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 28 Mar 2020 12:52:11 +0200
Message-ID: <CAHp75Vd+m=1eaDY1JLvtNKbBPXsaTFmpewG=Vn+v-=+GMBCs2w@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] iio: adc: mp2629: Add support for mp2629 ADC driver
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
> Add support for 8-bit resolution ADC readings for input power
> supply and battery charging measurement. Provides voltage, current
> readings to mp2629 power supply driver.

...

> +               ret = regmap_read(info->regmap, chan->address, &rval);
> +               if (ret < 0)

' < 0' is not needed for regmap call.

..

> +               case MP2629_INPUT_CURRENT:
> +                       *val = 133;
> +                       *val2 = 10;
> +                       return IIO_VAL_FRACTIONAL;
> +
> +               default:
> +                       return -EINVAL;
> +               }
> +
> +       default:
> +               return -EINVAL;
> +       }

> +
> +       return 0;

Do you really need this? Looks to me as dead code.

...

> +       indio_dev->name = dev_name(dev);

Shouldn't be this a part number?
I heard something, so, I might be mistaken, but I hope maintainers
will help here.

-- 
With Best Regards,
Andy Shevchenko
