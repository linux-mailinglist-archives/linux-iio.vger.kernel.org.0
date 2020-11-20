Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC34D2BB6FA
	for <lists+linux-iio@lfdr.de>; Fri, 20 Nov 2020 21:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbgKTUbf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Nov 2020 15:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbgKTUbf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Nov 2020 15:31:35 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58082C061A47
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2020 12:31:35 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id d17so11276424ion.4
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2020 12:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=giOhm8nD8EJFip5suslW+X4IjIvxocmJFXiSwyea9Jg=;
        b=DKg3ULHriMBLRT1ulekHSqd4wKLfSLIQGx6ilPxcAIh6hnrRVR5p1QHKhuouYwpUlF
         ocT6hHRziXQ3Wq0uQgslSvyHHApldTKBlxXVZL31lqnZr9H2wKvlo09s82NQdzRC0i5k
         4jCRPefLEbIDUSItBE63gXU2K3s4T5814CUtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=giOhm8nD8EJFip5suslW+X4IjIvxocmJFXiSwyea9Jg=;
        b=BowU45IHeJKUAGUZOqkTgQB0zhW0yp94yfMTS7IUh8TnTFyo1mNdo0i6VWB+QmHcej
         3oA7dpCBULJVftISfooqV7MMyIcbq4ImnO6e1YDGpPsCxwF/djRbxjHqFORqBgV2Vqht
         FpYI458pye8WgvNlLvYz0PVDyZ6wdqgM/CIFc0ikOMK5KxK5ZTbD+Qb+qrqi1+Dl4zaK
         kQlqxcr2jP0jKGe+ZA/wgwR08vBADE7KS75rltBArSeNkLJ/o0AaW3vJBxvh8ufY+se/
         AjjOoCW16TMM5RbkmKHVP+Am35280G25hkZ3tVb7cvbffHrar4dMAAN8ei4Akq0twuWX
         e+Ag==
X-Gm-Message-State: AOAM532Wf88ueKBTmw5BUL9C45DoguoGe7Pryux2qhN3qLPf/+plYlI2
        oWc6ikYnmuw5rD1zgx70E/SpbO6NuBtDkpAb0FGYDA==
X-Google-Smtp-Source: ABdhPJxwubpbbx83wN7c0Gnzzg2tSw/iCmvmegNwZyzGyhmGJ3EsBrpwWFwj4id0Lh55mCk51iIJlXt6H1f/7tbsN3s=
X-Received: by 2002:a6b:1446:: with SMTP id 67mr23348951iou.87.1605904294510;
 Fri, 20 Nov 2020 12:31:34 -0800 (PST)
MIME-Version: 1.0
References: <20201120030103.36138-1-matt.ranostay@konsulko.com>
 <CALUj-guTNWK9m-bwmkRC3st9VExhFkXPiUevXw_EA9xamR6BYA@mail.gmail.com>
 <CAJCx=gn=jAeYkVtLQ8Ou7P9xRpvSaXpuUk5XWDxMD_HPMTzH+Q@mail.gmail.com> <8151a886-b2db-8d44-eee6-46e8eb300ffb@metafoo.de>
In-Reply-To: <8151a886-b2db-8d44-eee6-46e8eb300ffb@metafoo.de>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Fri, 20 Nov 2020 12:31:23 -0800
Message-ID: <CAJCx=gkHYsu6=ne2BPCajVP+N9natV3stieP0cKd5nTSC8ARRA@mail.gmail.com>
Subject: Re: [PATCH] HID: mcp2221: add ADC support
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     rishi gupta <gupt21@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Nov 20, 2020 at 11:54 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 11/20/20 8:17 PM, Matt Ranostay wrote:
> > On Fri, Nov 20, 2020 at 5:15 AM rishi gupta <gupt21@gmail.com> wrote:
> >> On Fri, Nov 20, 2020 at 8:31 AM Matt Ranostay
> >> <matt.ranostay@konsulko.com> wrote:
> >>> Add support for the three 10-bit ADC channels registered via
> >>> the IIO subsystem.
> >>>
> >>> Cc: linux-input@vger.kernel.org
> >>> Cc: linux-iio@vger.kernel.org
> >>> CC: Rishi Gupta <gupt21@gmail.com>
> >>> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> >>> ---
> >>>   drivers/hid/Kconfig       |  1 +
> >>>   drivers/hid/hid-mcp2221.c | 65 ++++++++++++++++++++++++++++++++++++++-
> >>>   2 files changed, 65 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> >>> index 05315b434276..4795744d9979 100644
> >>> --- a/drivers/hid/Kconfig
> >>> +++ b/drivers/hid/Kconfig
> >>> @@ -1157,6 +1157,7 @@ config HID_MCP2221
> >>>          tristate "Microchip MCP2221 HID USB-to-I2C/SMbus host support"
> >>>          depends on USB_HID && I2C
> >>>          depends on GPIOLIB
> >>> +       depends on IIO
> >> I am wondering what will happen on systems which do not enable IIO.
> >> This driver can not be used there.
> >> Is my understanding correct?
> > Actually yeah this should be "select IIO" to avoid that issue.
>
> No, we should not have a individual driver select a framework. This will
> cause all kinds of issues with reverse dependencies.
>
> It might be worth splitting this driver into a MFD driver, then the MFD
> cells could have their own module that depend on the subsystem and if
> not enabled the functionality will not be provided.

Would it make sense to use IS_REACHABLE(CONFIG_IIO) for the iio blocks?

Guessing the weak reference "imply IIO" would still be bad for the
driver selecting a framework?

Thanks,

Matt

>
> - Lars
>
