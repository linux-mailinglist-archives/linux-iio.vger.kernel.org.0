Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF11A1A8561
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 18:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407468AbgDNQmj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 12:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407456AbgDNQmc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 12:42:32 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B86AC061A0C;
        Tue, 14 Apr 2020 09:42:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d24so138449pll.8;
        Tue, 14 Apr 2020 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BaE5xtuaHnNpipifyvaW4HHNFdG1qUBuWSeqScaNbPg=;
        b=fweroCpStL7FmPM6ywlL5me8387DKQfxTELUYOKM6hnR5nkCuIXo+jd2DIdGpZr21I
         ug510Km+8tWS8mOatSSm0wf6MjCAbKKFD2e9oLSU0PBGecsFYGiwblybXHRA8hpuC7sZ
         j14iF8Z7c6kgDEQ/UjMmPxlNCwaU4tSZMC4ehCfTgY2eQacq3MCCY++b1W1EcCK3BdWs
         6Xiynfj+lOnOnnEyl2ezb8wW9UPYYS1wcig+T6LCXikEqWKzWXMW5ux+sWL7z5l7ttlp
         /B35yycb7y2HCp7FofY2w2UzLbS3OgavjGjKDHE44iVHwBtp4pJ9WK/aV8GZN5LrhtQh
         lT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BaE5xtuaHnNpipifyvaW4HHNFdG1qUBuWSeqScaNbPg=;
        b=som2/a1yT4M5k6+C8TBVT4IXMiF+HlPw0lfhhY7VLwxUZc0joDjZepbw3n37suHNrH
         L9JoZ1siNPhN3YZVgV1oJBq/i2OEkwAifw2IfqAGgGWRHDuePjl6CmVxOznv850dX9Ad
         pZVCJrhIo7cCHRzwrJDBMqQd2JNxblNy6ejpYjL2+tyPYCiv6OMXRt6tiKHT5DRrb4a3
         iFuhgwuOighHenjugwhLVh+yE2/XVjZN8k/qIQIAnDFdrQwOoarg+ctkYWZ9EvlSkK6F
         wiK9NVnq59aNzF6qfn6ETQlYV68U/2AYrE0DiqcxqNRyzMLmcgVqgF8d1Trxr0qveecs
         SaKQ==
X-Gm-Message-State: AGi0PuZkeaHsp9JAZCh5yncTEeswI/K62GkWBQid1pWM+KGEXXrDnV/7
        JMHFOqlirrjFyGbjFI+x1WbHNxCLdvkthNr+zQ/VQlWzRlg=
X-Google-Smtp-Source: APiQypICgAp4y1bVzeBiwyAyp3p0BOH+vDzleW7tdIJIbAlPpNL7hdC9qQlXOzBPFIPzy8RUcoeGBHwsW9/bWU66MF8=
X-Received: by 2002:a17:902:aa09:: with SMTP id be9mr832961plb.18.1586882551514;
 Tue, 14 Apr 2020 09:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200414153415.957-1-mani@kernel.org> <20200414153415.957-3-mani@kernel.org>
In-Reply-To: <20200414153415.957-3-mani@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Apr 2020 19:42:24 +0300
Message-ID: <CAHp75Vf1wzBD+r5L7XFPW=ydxFLBfBNr6Jc4b6sMWR4Rci-Acw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: chemical: Add support for external Reset and
 Wakeup in CCS811
To:     mani@kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, narcisaanamaria12@gmail.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 14, 2020 at 6:34 PM <mani@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <mani@kernel.org>
>
> CCS811 VOC sensor exposes nRESET and nWAKE pins which can be connected
> to GPIO pins of the host controller. These pins can be used to externally
> release the device from reset and also to wake it up before any I2C
> transaction. The initial driver support assumed that the nRESET pin is not
> connected and the nWAKE pin is tied to ground.
>
> This commit improves it by adding support for controlling those two pins
> externally using a host controller. For the case of reset, if the hardware
> reset is not available, the mechanism to do software reset is also added.
>
> As a side effect of doing this, the IIO device allocation needs to be
> slightly moved to top of probe to make use of priv data early.

Thank you for an update, my comments below.

...

> +       reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
> +                                            GPIOD_OUT_LOW);
> +       if (IS_ERR(reset_gpio)) {

> +               dev_err(&client->dev, "Failed to acquire reset gpio\n");

If it's a deferred probe, it would spam the log.

> +               return PTR_ERR(reset_gpio);
> +       }

...

> +               static const u8 reset_seq[] = {
> +                       0xFF, 0x11, 0xE5, 0x72, 0x8A,
> +               };

I would suggest to comment above from where you got this and the
meaning of the numbers.

...

> +       data->wakeup_gpio = devm_gpiod_get_optional(&client->dev, "wakeup",
> +                                                   GPIOD_OUT_HIGH);
> +       if (IS_ERR(data->wakeup_gpio)) {

> +               dev_err(&client->dev, "Failed to acquire wakeup gpio\n");

Ditto.

> +               return PTR_ERR(data->wakeup_gpio);
> +       }

-- 
With Best Regards,
Andy Shevchenko
