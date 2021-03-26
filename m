Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6C734A60E
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 12:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhCZLCk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Mar 2021 07:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhCZLCP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Mar 2021 07:02:15 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D523BC0613AA;
        Fri, 26 Mar 2021 04:02:14 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so4057802pjq.5;
        Fri, 26 Mar 2021 04:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/eKkuDjHsXzeQAjqtTP1yNfq8k1nDjlJIzue3/QVco=;
        b=ux1z2lyMai9nMRh6moP2Syhfig0iEUrZEDiHV0/5Absb6b1Vt5+r5YNrwkBXAdpY3y
         ICCopS6VPz87I2CJ9BXEy/O++ZVIUtR9NAuZDAwsVnP35xeSJPm3BhCawcVRocgab0ys
         1tIDmjaJwI6KhiPCh2QoLDGcMABhWMKcZs2pz3y9HVr8m4Ky9KEnZqnxQQ2fDJqBMklz
         tTjYxYlnvCgWIjyhKzof3QxSjoj7VlKiskN1ovYFWzwsbfxPic9WAdel+D9uuZ5Dcj9s
         goJQ8u2wr9loOU+3zLDw80QbCL7xFx0Qzm6zwG9x4rw8rXN6rCxm2ZJT6iA3fnQB8gC0
         BnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/eKkuDjHsXzeQAjqtTP1yNfq8k1nDjlJIzue3/QVco=;
        b=WXd8LotIY9vom+9Wmb+k80w4J8JaumHASJSXJEERT9hVf7T9AswW2biP56w0IITa2H
         61cVYgawJmVQtY+PlxjrrTmgobHrVVKG8/ssO1VaOa8UD7FXABbwO9EpuubrJX+C0ixk
         Qdk2JmMl11ZUmKiOAPdBYqct3tos7T00HXxOTr+hlqTMQxVFUclMZlWcXw0DveL107gg
         HiLIXMjyyhGjohuMDifU4XzAvvud8nqh3leTko72AQgYyzpjZf2DxAleoBF9p5LAegDs
         ioHfhDp5xYJLcuXxaz0AjC1Z92Kvf6g/0X/eE+55thItOW5GTv6FvZJjM/YlYLw8WTdB
         0IPQ==
X-Gm-Message-State: AOAM532aXvLyUe+VWyTIaa6JGVk8SQRSy3wBmg47MA6jGaWPXdbugLTi
        ZhuFITgSP5erUw33xZkK5YE/1t41CzURtqzYAao=
X-Google-Smtp-Source: ABdhPJwT1uUgIGJVmDXKZG6sZGVN3au3R3Ta/RoftvKTErSnZRExoFSMZoFJRVcGPPKOycms+VHR36mJy1HauFptasY=
X-Received: by 2002:a17:90a:b311:: with SMTP id d17mr13506221pjr.228.1616756533742;
 Fri, 26 Mar 2021 04:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210325220505.14507-1-joe.g.sandom@gmail.com>
In-Reply-To: <20210325220505.14507-1-joe.g.sandom@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Mar 2021 13:01:57 +0200
Message-ID: <CAHp75VcfE0VUrtAqCM0KC9RFvy8XMv++tjYCP2dKZCMosPQ2tw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] Added AMS tsl2591 driver implementation
To:     Joe Sandom <joe.g.sandom@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 26, 2021 at 12:05 AM Joe Sandom <joe.g.sandom@gmail.com> wrote:
>
> Driver implementation for AMS/TAOS tsl2591 ambient light sensor.
>
> This driver supports configuration via device tree and sysfs.
> Supported channels for raw infrared light intensity,
> raw combined light intensity and illuminance in lux.
> The driver additionally supports iio events on lower and
> upper thresholds.
>
> This is a very-high sensitivity light-to-digital converter that
> transforms light intensity into a digital signal.

I'm under the impression that you ignored at least half of my comments
[1]. Have you seen them?

[1]: https://lore.kernel.org/linux-iio/CAHp75VcSW2xXdH--rXaN7xt0Ju+qfw9c_va0gGRGPgpBua0H-Q@mail.gmail.com/

Please. address and come again.
NAK for this version, sorry.

-- 
With Best Regards,
Andy Shevchenko
