Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429672C4550
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 17:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbgKYQeF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 11:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbgKYQeF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 11:34:05 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7E1C0613D4
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 08:34:05 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id n137so2841867pfd.3
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 08:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojUEknFMAD/QVX9KT2+JouZO/4ae2a+qG3HbqFpF9Gs=;
        b=CoG30PZvBlfnJfOGFDDzMULd9N7wwAxuhLsiQORrs6OYQ9jxrpgjzOcFt1q0/ql3nP
         eL1HfcQ1arhltEqZNK3t5aDuajp5jb+JxrdgyXTpYeYM2XkPj3qZug8Bk0wdIDmHEToO
         TsX+yaft2nIx03gV0qxnX0Qc18CSLRjCnhfXnfELe+S8mUC3xWqMcK1JxcvQW3LS98PC
         osqmVH3wvlewa2CFIBHcf9aIpaeugnFgihk88vIiQE4YYJWExRWU1kP6Z/pwqHLnKlfO
         kDLKq5S70UTsc2V/RpttAvZfYynBYQq3b1rBvRL4g5DfveqJkMxw1XId8py5gtNJ055r
         hbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojUEknFMAD/QVX9KT2+JouZO/4ae2a+qG3HbqFpF9Gs=;
        b=ng0aPkKTnsYi8jVfJhWvzGGuktBV1IRdQORa5HpMiB+1EFKROcv2z6Z4KC5V9Ia6w0
         T2wGISWcYSmqaOEw/0b4MmxAdJcsjGGfHVr9Bp8+3keNeT0gCUK2ZLFc8PG4fhr4Jfod
         K0ZGLa44O9nk4L2MCf/eYyvy1/hPZEiyNyPXmvDs58YJ+Fh6rx5rntDQZgjJehcgGzPY
         RoaWA1h1SnvNRsWKPu6xtL4gNuIAE8Axr7uDnYvhRVgeeHeR9UPS75bMIMA2/MAemM+W
         MywFwQTXBdXqZyeQaxtYuD7tpnksYhOCM+6sE6RXP/73Wc1uIYMPm4C19HSfZQxYXYw2
         WNaw==
X-Gm-Message-State: AOAM53369n7AYroZ1T+3uQoHm79roaujQyTYZOAOL67b6Ak14a63BhkN
        /Ze+kgJ3hqlAxeNeD+JzXxOTAZ2LRm/wHAS5dRA=
X-Google-Smtp-Source: ABdhPJzlj6O6KtCnWYwAHa/myx2NZgDiJHslzC7I2RIjq1qFz8y9yTmbVdtCzSkfg9DnO7mACuJwQbpW8lLuo33uUTE=
X-Received: by 2002:a62:7e4f:0:b029:18c:9322:739b with SMTP id
 z76-20020a627e4f0000b029018c9322739bmr3796646pfc.7.1606322044515; Wed, 25 Nov
 2020 08:34:04 -0800 (PST)
MIME-Version: 1.0
References: <20201125083618.10989-1-hdegoede@redhat.com> <20201125083618.10989-3-hdegoede@redhat.com>
 <CAHp75VcZQ1duxHnUTD9ewRhWxoHay8S6AQaEK3v3jJr+oQcbDw@mail.gmail.com>
 <ee0d26b1-ee54-0c2c-cd9f-40366e3b10d4@redhat.com> <CAHp75Vc7v4z=VkaopsfXoJfFMxt9GxS6iofjNvOcUQrauKhDXA@mail.gmail.com>
 <9f0f2060-24cf-cc7b-9089-9f5c8e024e39@redhat.com>
In-Reply-To: <9f0f2060-24cf-cc7b-9089-9f5c8e024e39@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Nov 2020 18:34:52 +0200
Message-ID: <CAHp75VdKjxsY2ZCixfG5rdJNmcfGN6nLiLVCtqyh83LYUqFMXA@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: accel: bmc150: Check for a second ACPI device
 for BOSC0200
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 25, 2020 at 6:09 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 11/25/20 12:20 PM, Andy Shevchenko wrote:
> > On Wed, Nov 25, 2020 at 1:11 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >> On 11/25/20 11:55 AM, Andy Shevchenko wrote:

...

> >> i2c-BOSC0200:base

> > What if you have two devices with the same ID and both have two
> > I2cSerialBusV2() resources? Second one can't be instantiated because
> > 'base' is already here.
> > Making it like i2c-BOSC0200:00.base would be much better in my opinion.
>
> Ah I see, that is a somewhat valid point. But I really never expect
> there to be 2 ACPI devices with a BOSC0200 hw-id, while also specifying
> more then 1 i2c-client per node. That would just be all kinds of messed-up.

I also don't expect such, but probability is still greater than zero
(somebody may copy'n'paste the ASL excerpt from this device and apply
as SSDT in one of DIYs kinda projects).

> Thinking about this I think that getting a WARN_ON (and thus a bug report)
> about a duplicate kobject-name when this happens would actually be good,
> because then we need to figure out what the beep is going on on that
> system. Note that other then triggering a WARN_ON the second
> i2c_acpi_new_device will simply fail in this very unlikely scenario
> (I know because I triggered this by accident while working on the patch).
>
> Since in a way getting this WARN_ON is actually good (lets us know about
> completely unexpected circumstances) and that making the name dynamic
> as you suggest requires a bit of extra code I would actually prefer to
> keep this as. Please let me know if that is ok with you.

Can you put a comment in the code that this name is considered global
for now as we do not expect such circumstances. Then I'll be fine.

-- 
With Best Regards,
Andy Shevchenko
