Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C9933245E
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 12:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhCILrU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 06:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhCILrM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 06:47:12 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A27C06174A;
        Tue,  9 Mar 2021 03:47:12 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id q22so610450pjd.0;
        Tue, 09 Mar 2021 03:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gRjR7StjqFpOsF/tq48F+0Q6hHwDEC10FqFA0jTl/wQ=;
        b=T9/BSR12qrFXLPwR8BD2jam0bWigKWj3UNdJqUuWJdW1sy9T8JzHNOlqxfiK/gIOMF
         7WvDnxrR9cB4no3PGlAggyardqdXXFuyASABnoDbsENdFmz7mqoK/AX54RBLruoANp3I
         LO4ys9wHdlE2OycQeaj8TuxhiFViLwIUAk6+OGm6bAA59oNCorljvB4hHnh5vcwYXN6e
         neHhz1rIKPTUHS5HFtaZW/FobkK79tBi4DM1Dh4cvksmOnRG4LSoJKboDB9nydU8I7KS
         7cOGGIrPO/UTiPqbHqnqGKcdiaD4IdhJIok1uRQykk72xQa4H9X4T8FgmQNPz/s91Mu4
         bIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gRjR7StjqFpOsF/tq48F+0Q6hHwDEC10FqFA0jTl/wQ=;
        b=psUJlirqWc2wdOaAPF3zZ3rUlVGtfrBHj3n3k48SeaIg6IPzITtgj3kbc33XkHru4n
         4dNzV3bnkgNrJcBf3N+KAI4Gekfh8hJAN67dO04dCaErd7iTF0OvlpvzZQiInDt1tfK5
         70S11tA/RMvpKBqA1nJDJqOBDEwQScyH69GBvDzs5wUnhHcxD3D3vpkU4O5xBJ6CVCqr
         cxOahOcFB8wqCzNpbH7uc1OjzCMK0a4iAwGQH8WtdOZYZbwBSRXVW1LnbJNGvCGRUtY2
         YjEz4CCdPo6LgPiqDnYNN52DJ3Y48FmUdKErXKjbAeT5sFO1/ye5jwH4cj1pW8HvlkYF
         T4wg==
X-Gm-Message-State: AOAM532mw2KTEl3dgffqbgZlY58boAvc824wzcauCZzOnHUKGhHItTMV
        YHco+WaeXNA1PvrdQWZjKaCi3sGbJyoHHgsoCQ0=
X-Google-Smtp-Source: ABdhPJy9hEv69dyAPIb0MqVm0L5yUcMDcsc/vAKjhq9wr5eb5ACaE/MLHExQ1Zywg1b+JdNt50J7IDcHqAPMBMfL+1Q=
X-Received: by 2002:a17:90a:e454:: with SMTP id jp20mr946902pjb.129.1615290431961;
 Tue, 09 Mar 2021 03:47:11 -0800 (PST)
MIME-Version: 1.0
References: <20210305133813.27967-1-o.rempel@pengutronix.de>
 <20210305133813.27967-3-o.rempel@pengutronix.de> <20210305190239.000075fe@Huawei.com>
 <CAHp75Veu-G41mDUZubCgHD_V+_znd0HJoO03ZL7JpgwtjMYLCQ@mail.gmail.com> <20210309114150.lubvvtqblw2y5zlk@pengutronix.de>
In-Reply-To: <20210309114150.lubvvtqblw2y5zlk@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Mar 2021 13:46:55 +0200
Message-ID: <CAHp75VfR2_N=krD8Rady77ST19o5vL7zChLnJ32wmx-+M1N3pg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: add ADC driver for the TI TSC2046 controller
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 9, 2021 at 1:42 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> On Tue, Mar 09, 2021 at 01:05:27PM +0200, Andy Shevchenko wrote:
> > On Fri, Mar 5, 2021 at 9:05 PM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Fri, 5 Mar 2021 14:38:13 +0100
> > > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > >
> > > > Basically the TI TSC2046 touchscreen controller is 8 channel ADC optimized for
> > > > the touchscreen use case. By implementing it as IIO ADC device, we can
> > > > make use of resistive-adc-touch and iio-hwmon drivers.
> > > >
> > > > So far, this driver was tested with custom version of resistive-adc-touch driver,
> > > > since it need to be extended to make use of Z1 and Z2 channels. The X/Y
> > > > are working without additional changes.
> > > >
> > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > >
> > > Hi Oleksij,
> > >
> > > To consider this as a possible long term route instead of just making this
> > > a touchscreen driver, we'll want to see those mods to the resistive-adc-touch.
> > > Of course that doesn't stop review of this in the meantime.
> > >
> > > There are quite a few things in here that feel pretty specific to the touchscreen
> > > usecase. That makes me wonder if this is a sensible approach or not.
> >
> > I'm wondering if this has any similarities with existing drivers under
> > drivers/input/touchscreen.
>
> Yes, for example: drivers/input/touchscreen/ads7846.c

Then I have a few questions here:
1/ why the above mentioned driver can't be extended to cover this?
2/ or why is the proposed driver named after the touchscreen instead
of the real AD/C chip behind it?
3/ maybe we can introduce a simple AD/C driver under IIO for that?


-- 
With Best Regards,
Andy Shevchenko
