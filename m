Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4D12DDC70
	for <lists+linux-iio@lfdr.de>; Fri, 18 Dec 2020 01:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgLRAle (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Dec 2020 19:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbgLRAle (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Dec 2020 19:41:34 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58E2C061794
        for <linux-iio@vger.kernel.org>; Thu, 17 Dec 2020 16:40:53 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id z5so456441iob.11
        for <linux-iio@vger.kernel.org>; Thu, 17 Dec 2020 16:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4w1rVgGZkkmQ5xd5p9+H0HBWGMlkftphPuS3GuvMK3w=;
        b=F+wMcMbfL+YLoy9vzpwf4xc69etB7hxMymx6QGw+AAT05rT0EZudOrTfAnCWT+I4nU
         7PcD9341oETeAXLLDl5DZyGk28LFBZKZDLPEc5+CAvJsZd5LD1tL9CP/jAHPPFFYcSJu
         CXJ2yOiDmo53GrQCnOzH4Nn8t9+jPaVfGDyM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4w1rVgGZkkmQ5xd5p9+H0HBWGMlkftphPuS3GuvMK3w=;
        b=WA8Etuy54Gj5SkCa+OSXCXiS6XFICluLS+lqEEYT4y6JtqkovlyXJZ0DQZl4iUhiCm
         ftc/yRJv7xY1RpOeBpmWDktnw2HkysmpWHQn+/meXzQpMGxYBYutnbJGtiF7SqdOxbjv
         VAIOqIUzZakyKQ+vn/NZ2iM6eowx5C7TRpHlO+Ro+GEfBtENqZMdOxW+MFIbeiVPfjfa
         fHiJYp95Rcg3fOwG5psEN8kaPjjB4gxQ9BaGi1v89SE+TgQHdVZ9ayXTCrson+yPm+hR
         dtJmBAae/Gepyc1L2+SOXwBz41Wg8wTzwIwVW369OioX9lEwSW/vMZPYoe7FL8arv2vA
         k3hQ==
X-Gm-Message-State: AOAM530cIrZ/Am2MkLgjXX7O9sD3I2kGoDP6QEobL+g6dOMJs1/KKPYG
        l1K5MOQDM8Re1/f8UsM4N6qZC5aVP1Iaq4nokDJIAQ==
X-Google-Smtp-Source: ABdhPJwRY7NiANnpNV/mruNA0Bj60DGvF0RZstrWutpDqYbTxLcTAGzsJCYvKOoLxrAlCsESwra3zW1bDl1ezIoblnE=
X-Received: by 2002:a02:a1ca:: with SMTP id o10mr1425092jah.19.1608252053181;
 Thu, 17 Dec 2020 16:40:53 -0800 (PST)
MIME-Version: 1.0
References: <20201216060233.597689-1-gwendal@chromium.org> <20201216060233.597689-4-gwendal@chromium.org>
 <CAHp75VdKCEQ11Kk=zBynd1g7gWhFyMCo-x=grntLSEY_U29PFA@mail.gmail.com>
In-Reply-To: <CAHp75VdKCEQ11Kk=zBynd1g7gWhFyMCo-x=grntLSEY_U29PFA@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 17 Dec 2020 16:40:41 -0800
Message-ID: <CAPUE2uuiDJOAQPy8zNuirmYVeSdSFuOp1CvJXaMok0Femcsi_g@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] iio: acpi_als: Add trigger support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 16, 2020 at 5:56 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Dec 16, 2020 at 8:02 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > As some firmware does not notify on illuminance changes, add a
> > trigger to be able to query light via software (sysfs-trigger or
> > hrtrigger).
> >
> > Check iio_info reports the sensor as buffer capable:
> >   iio:device0: acpi-als (buffer capable)
> >
> > To test, check we can get data on demand on an Intel based chromebook:
>
> + blank line
>
> >   echo 1 > iio_sysfs_trigger/add_trigger
> >   cat trigger2/name > iio\:device0/trigger/current_trigger
> >   for i in iio\:device0/scan_elements/*_en iio\:device0/buffer/enable ; do
> >     echo 1 > $i
> >   done
> >   od -x /dev/iio\:device0&
>
> space before &
Fixed in v5
>
> >   echo 1 > trigger2/trigger_now
>
> You may improve readability by using a temporary variable:
>
>   IIO_DEV="iio:device0"
>   ...
>   cat trigger2/name > $IIO_DEV/trigger/current_trigger
>   for i in $IIO_DEV/scan_elements/*_en $IIO_DEV/buffer/enable ; do
>   ...
>   od -x /dev/$IIO_DEV &
Fixed in v5
>
> Commit message keeps silent about the side effect of these changes on
> the old setups.
> Is there any?
No, add note in commit message.
>
> ...
>
> >  drivers/iio/light/acpi-als.c | 88 +++++++++++++++++++++++++++---------
>
> Question here, does it need a documentation update?
No, as the driver follows the current iio ABI.
>
> ...
>
> >  #include <linux/iio/kfifo_buf.h>
>
> Is it still in use?
Fixed in v5.
>
> --
> With Best Regards,
Thanks for thorough review,

Gwendal.
> Andy Shevchenko
