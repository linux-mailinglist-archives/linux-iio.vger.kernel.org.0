Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFB21B3118
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 22:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDUUXX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Apr 2020 16:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgDUUXX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Apr 2020 16:23:23 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270C8C0610D5;
        Tue, 21 Apr 2020 13:23:23 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id ay1so5696691plb.0;
        Tue, 21 Apr 2020 13:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zl40T50FPbwBzCKH7/OEcPTWE7rgN74/mA60zW5oOTo=;
        b=kSVKMtXhsAi8UcAwt4iulSL7+eVDGadF0SrWh1wVO8+gwbi2E3F2/Bu88eqAMDqnNC
         aZ2mjX0aG8et1NQWeo8ZoqL86PFMAa9v96WA6g5JD4PlRfZEH0jzquzVm9R6IChZKIhb
         zcY8v9xaimsRqlZD3L00+wNkc2bvpGkgsA4MSxRZvyOGgRs3kAMODPQAfqLSRs2OSJqh
         BcNdlAijqbWjZzMYeVHCEUzCC2faFEgiPzbSIl3mFI1991GqAT/ycuXtVyi9GAtgp9qw
         WIkb7B71vc+P6LPbsdJKzeE5C7bacRjKervPeUmo9fHz2TSRbjWv9YZNWlE9xPV6oFpe
         Di8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zl40T50FPbwBzCKH7/OEcPTWE7rgN74/mA60zW5oOTo=;
        b=cY3t05GscfJbY08quxK/bL2BiGnsftewrmnK/Lae9xALiiRyVjJs1K2CKzWwos2xn6
         aPG8LjjNDXYVv0iPQtT4LxpdznRsQkLhuOYY1JphRpgOwlQxGfF4LnZEQj493Dlgrj28
         /sVxaUeirFOyclbBtKY0eB5sqB9FsLddaCqgvuDTpB59gJH0RsRTt8jGxElhpT7q0788
         50N7f5qi1iWI9VPkf4dwkOtN+4dbCxIqFX4JBnCphi61INVCNtMgLXYQG7rClmQaDxu6
         5ft0hbUhlmxKLnrpcHHg/3DdLSzR6ezJu7+FfRom9jKiWcAJNjYcCAdZ0d4ofAMK362v
         5gGQ==
X-Gm-Message-State: AGi0PuYAmniL6kAlbKMg2Ss23scbj7nUB+U6ANCEG0B0151mdKuBWirn
        RVzluqD3kGDPS1wi4G40NSuV5rRb7oM/ijejd4o=
X-Google-Smtp-Source: APiQypLAu9QTbWNgbPerC9FiXf54TGJy1cCm8ZU48UUMzfczq3a63vgoRJ4CWI4WeYnDtbGa2fmkEOryIT/jGVwyPhs=
X-Received: by 2002:a17:90a:2401:: with SMTP id h1mr7862503pje.1.1587500602433;
 Tue, 21 Apr 2020 13:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200421194005.6295-1-i.mikhaylov@yadro.com> <20200421194005.6295-3-i.mikhaylov@yadro.com>
In-Reply-To: <20200421194005.6295-3-i.mikhaylov@yadro.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Apr 2020 23:23:11 +0300
Message-ID: <CAHp75VdZ=jmQFt68+iniDbhGY9Q-ueT6QzrL82mLmsoGwftxFg@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] iio: proximity: Add driver support for vcnl3020
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

On Tue, Apr 21, 2020 at 10:39 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
>
> Proximity sensor driver based on light/vcnl4000.c code.
> For now supports only the single on-demand measurement.
>
> The VCNL3020 is a fully integrated proximity sensor. Fully
> integrated means that the infrared emitter is included in the
> package. It has 16-bit resolution. It includes a signal
> processing IC and features standard I2C communication
> interface. It features an interrupt function.

...

> +static int vcnl3020_get_and_apply_property(struct vcnl3020_data *data,
> +                                          const char *prop, u32 reg)
> +{
> +       int rc;
> +       u32 val;
> +
> +       rc = device_property_read_u32(data->dev, prop, &val);
> +       if (rc)
> +               return 0;
> +

> +       /* An example of conversion from uA to reg val:
> +        * 200000 uA == 200 mA == 20
> +        */
> +       if (!strcmp(prop, "vishay,led-current-microamp"))
> +               val /= 10000;

I probably missed the point why this function is needed at all, since
we always call only for a single property.

On top of that, why do we have this nasty strcmp()? Can't we simple do
something like

static int vcnl3020_get_and_apply_property(struct vcnl3020_data *data,
const char *prop, u32 reg, u32 div)
{
...
  val /= div;
...
}

static int vcnl3020_get_and_apply_led_current_property(struct
vcnl3020_data *data)
{
  /*
   * An example of conversion from uA to reg val:
   * 200000 uA == 200 mA == 20
   */
// Note by the way comments style
  return vcnl3020_get_and_apply_property(data, "vishay,led-current-microamp",
                                              VCNL_LED_CURRENT, 10000);
}

?

> +       rc = regmap_write(data->regmap, reg, val);
> +       if (rc) {
> +               dev_err(data->dev, "Error (%d) setting property (%s)\n",
> +                       rc, prop);
> +       }
> +
> +       return rc;
> +}

-- 
With Best Regards,
Andy Shevchenko
