Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D952359AA
	for <lists+linux-iio@lfdr.de>; Sun,  2 Aug 2020 20:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgHBSCy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Aug 2020 14:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHBSCx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2020 14:02:53 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D7AC06174A;
        Sun,  2 Aug 2020 11:02:53 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p8so2558789pgn.13;
        Sun, 02 Aug 2020 11:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4HiYNt38nc70/fF7gpPYeiC1nVRazwaZXZ0UbUAj+g=;
        b=cWsnVevzoK5pBbgZECT6VJ89nBen1DFqMuLo8VaTzwqLpb2XsSQGqpei3I86NShXFw
         JtbeddrTC4NlAue+Io6adpxLpWb9+R/md/h97DVE3lAS4V/yC457dFLJ96G5omZXLMXs
         MYwvkucIVEJaPbs17A6MR23oOWW86agyI7+rW69Gl3ClDUIFnCSHP62Dp6ahcMFXhr8q
         aM2IxSlqubNixcNRoACXBm8l5/H2cSZMWQN71SOXwG77oIzU4x/5WudHc3aTRgXj0Wtx
         WpuLezEr4qY+i2pK+d5v1AVwJFD3vxZxTm80lZS67yRyH2DW/mdeKuszPKAPX8fqaAP+
         f4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4HiYNt38nc70/fF7gpPYeiC1nVRazwaZXZ0UbUAj+g=;
        b=YNNHsW/neBgAHDiyGzyIdNSRDFmkpwL4FVICy2Hhr2irHvdwf+n+dLtU1SlD4RN7PH
         Mdu63OuorVyKym5eDeNDALi1qxSqoEhl8Pwfsa2+E8IdJir0YZnqvKZ6fjmtEVSpG7AS
         2ERrxcgjK1ReRrIgonJat2WpVQWwFk/g9t8YswlEJelohr7dq0YT4jRHMjcWlscPVCbj
         C+yVZsLQkuRcn75y02aslwU4+51D2ePrnEH5DpB4GrYiu6gUi6AriN3B+rcYrrmPwVnr
         p85aJeGUWTmGHx0u2ldFL1Z+FObmgl1zhJMDAiujou3zDq7Wh+SBVae3NeRDA2+CE2VS
         kJgA==
X-Gm-Message-State: AOAM532LWDtLXKG7AzxUs9lDWuassMKtroBxdAThmhDdWKplrRCRJ35z
        BulqazewQF1tES6i4sqqch5t1bMmFMdIo4GAlrFaf/VihFg=
X-Google-Smtp-Source: ABdhPJw5JOMxGms/mWTQqZxa8LeV3Xy1njo/BoKFfVVk31VdvI94KbxgRI4a6cy4H6Gw1rPS78YQGlLWXJF9sVHo0yM=
X-Received: by 2002:a62:158e:: with SMTP id 136mr12689670pfv.36.1596391372482;
 Sun, 02 Aug 2020 11:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200802163735.76617-1-ceggers@arri.de> <20200802163735.76617-3-ceggers@arri.de>
In-Reply-To: <20200802163735.76617-3-ceggers@arri.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 2 Aug 2020 21:02:35 +0300
Message-ID: <CAHp75Vev64E86OWm+eV=1o4ZDs0Xh_Y1z6V54GmpRwWmjD7=eA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: light: as73211: New driver
To:     Christian Eggers <ceggers@arri.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 2, 2020 at 7:40 PM Christian Eggers <ceggers@arri.de> wrote:
>
> Support for AMS AS73211 JENCOLOR(R) Digital XYZ Sensor.
>
> This driver has no built-in trigger. In order for making triggered
> measurements, an external (software) trigger driver like
> iio-trig-hrtimer or iio-trig-sysfs is required.
>
> The sensor supports single and continuous measurement modes. The latter
> is not used by design as this would require tight timing synchronization
> between hardware and driver without much benefit.

Thanks for an update, my comments below.

> Datasheet: https://ams.com/documents/20143/36005/AS73211_DS000556_3-01.pdf/a65474c0-b302-c2fd-e30a-c98df87616df

Do we need the UUID after the document file name?

...

> +/* Available sample frequencies are 1.024MHz multiplied by powers of two. */
> +static const int as73211_samp_freq_avail[] = {
> +       AS73211_SAMPLE_FREQ_BASE * 1,
> +       AS73211_SAMPLE_FREQ_BASE * 2,
> +       AS73211_SAMPLE_FREQ_BASE * 4,
> +       AS73211_SAMPLE_FREQ_BASE * 8

+ Comma.

> +};

...

> +#define AS73211_OFFSET_TEMP (-66.9)
> +#define AS73211_SCALE_TEMP  0.05

In the kernel we don't do float arithmetic. How these are being used?

...

> +               *val2 = (AS73211_OFFSET_TEMP - (int)AS73211_OFFSET_TEMP) * 1000000;

> +                       *val2 = (AS73211_SCALE_TEMP - (int)AS73211_SCALE_TEMP) * 1000000;

Magic 1000000 multiplier.

I think here you got them always 0. And to fix that you need to
redefine (with also units included in the name) above constants like
#define ..._OFFSET_TEMP_mC 66500
... _SCALE_TEMP_?? 50

Consider to use definitions from
https://elixir.bootlin.com/linux/latest/source/include/linux/units.h

...

> +       }}
> +
> +       return -EINVAL;

Make it default case.

> +       }
> +
> +       return -EINVAL;

Ditto.

...

> +       }}
> +
> +       return -EINVAL;

Ditto.

...

> +       ret = devm_iio_device_register(dev, indio_dev);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;

  return devm_iio_device_register();

And consider to drop ' < 0' for devm_*() calls. As far as I understood
your intention to explicitly leave them because of i2c_*() calls,
though devm_*() and such are different.

-- 
With Best Regards,
Andy Shevchenko
