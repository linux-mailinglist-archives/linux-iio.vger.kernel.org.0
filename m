Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01BC91968C5
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 19:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgC1S4w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 14:56:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33118 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgC1S4w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 14:56:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id d17so6466108pgo.0;
        Sat, 28 Mar 2020 11:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4HHlXxbXXtMBcda41lMVxwqCfKXpypsMxOoSrEjA1Ko=;
        b=uGwtTVYBhkTB2izKKxsA2QIkU1+f13YKWrgXdavHLelUDiGAcbZSvfoo65pXoeezTv
         xic/NWs3f+63xWk4uo5z2cdBrnnajWN2ZxZJNxkaK6LvKY0pilzfnfIcEcSNAhFEq2XB
         O8oB6G0veXREa6kVtCn8tCsSLScqDv0Vq7SORhBCkcOqbljvf2ISvmRLODaIeGfk0gnO
         syp2/kKI3mfNeAkHIZjIdnzmTBeljOgDVj4rSafWWLlfRMhCnsX3667qqSxUQNm59i7m
         CyACq9GPYwIhG8NYDIrPQxh6ICCtGPOlR+UxSq4NW3nx/LK2Ggcrzdx62o1zjXv852RG
         BQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HHlXxbXXtMBcda41lMVxwqCfKXpypsMxOoSrEjA1Ko=;
        b=eG1K+AB/Q3l2XkQE0oACO5Mx0d7mPNuH5ZUsqHS7fZ58NLVN54mftmw6j15zDv0Zgz
         M16aaQX4Wf+HCG2+AQAEH+pHzeDKQwMMDWrrYiWpx92gxUsBwYRk0Kcgp57ViYpn7GUf
         3s/OETN1xHK6c66TD+HnQG1dJzpYvmotUPWJ9YU7Th6cKlJBmNSvo8z8QeTLJnL8ckAA
         K8Q1LCc42tCAcFDQEE7wgpZcglSpp3++6KrZK88OEh2NTEGSviPVN6mkDUI/zC8Cj1a5
         9nKbDl2sSFcDuGw4xozIScxjF2RG3kBkqOxxpMBO6XGSsdzu0DpwRSn32/FTqTNm3shY
         /chg==
X-Gm-Message-State: ANhLgQ0cvU9WjhOiXkz1ueKCmlsGf6atZJxbKI8SlEOJlXon9OehOcn0
        V8oLAp6MRV3JcR5r2zp5igPGer74s+wusDL7vLY=
X-Google-Smtp-Source: ADFU+vtIDt63eZ3/CBJTRiljKEiIFZZS8m8+DJZgk/QqIoOY2kD1gREKSfq7qKI5usQv3XhAIYh1EXCUbfK/aEpVoN4=
X-Received: by 2002:a63:5859:: with SMTP id i25mr5290889pgm.74.1585421811018;
 Sat, 28 Mar 2020 11:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200327104954.27829-1-i.mikhaylov@yadro.com> <20200327104954.27829-3-i.mikhaylov@yadro.com>
 <20200328151102.4279cb42@archlinux>
In-Reply-To: <20200328151102.4279cb42@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 28 Mar 2020 20:56:39 +0200
Message-ID: <CAHp75Vfo18+PD8N1WaonLDHv=QLOdb6xpD_grVVj02L=GtqNDA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: proximity: Add driver support for vcnl3020
 proximity sensor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
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

On Sat, Mar 28, 2020 at 5:11 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Fri, 27 Mar 2020 13:49:54 +0300
> Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

...

> > Datasheet: http://www.vishay.com/docs/84150/vcnl3020.pdf
> > Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> A few things inline.
>
> I note Andy suggested a Datasheet tag, but has it actually been
> standardised?

I don't think so, but I bet it's a good idea to have it.

...

> > +     rc = device_property_read_u32(data->dev, "led-current", &led_current);
>
> The presence of a firmware read (dt / acpi etc) means that the i2c id table
> isn't actually useful for probing.

...in case if there are no defaults hard coded in the driver.

> > +     if (rc) {
> > +             dev_err(data->dev, "Couldn't get led current (%d)", rc);
> > +             return rc;
> > +     }

...

> > +     rc = regmap_read(data->regmap, VCNL_PS_RESULT_HI, &hi);
> > +     if (rc)
> > +             goto err_unlock;
> > +     dev_dbg(data->dev, "result high byte 0x%x", hi);
> > +
> > +     rc = regmap_read(data->regmap, VCNL_PS_RESULT_LO, &lo);
> > +     if (rc)
> > +             goto err_unlock;
>
> These are neigbouring registers.  Can you not get away with a bulk read?
> The datasheet suggests the device does auto address incrementing.
>
> If you do that, you can read directly into an __be16/__le16 (I haven't
> checked which) and do an endian conversion to whatever the cpu is
> using.

Oh, indeed. How I missed this during my review? :-)

-- 
With Best Regards,
Andy Shevchenko
