Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C262D4535
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 16:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgLIPTV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 10:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgLIPTG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 10:19:06 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFB4C0613D6;
        Wed,  9 Dec 2020 07:18:26 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f17so1378724pge.6;
        Wed, 09 Dec 2020 07:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u1Wg1rt4Jt/BWrp83EFWowdTA+qCFgUamRbqvrf56/U=;
        b=IRm3NuJAgtHlcMXYdLyOqVfBzN3lWG8N9YwZeMO6cfwhjuN+JSSydhWQixXuDAZdTY
         OPBe79Il04B+yKzEoK3h4disTvFqJXXoK2G0qu25JQtgOtwmdfe0o3DLDa51t+YMOKY2
         cfvIZ9I3SUEu/ioAmTNYpWBeG3M7pa78KoE34MaiudaAcMGbgW/EZNUzeCQLjuMOHjVg
         Y2ggJEC+lyoUBvvRCY2fP0BG/pOhwgHSiHjXaMm65BKmNeYjEt8qi3Me9cIkMj4aSsCf
         h30voP08uRVrhT46GQRMTl+QlscCDjfuSHgablY9fcgquIgkEiIP9LDgrJLrEcWawKXU
         8e5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1Wg1rt4Jt/BWrp83EFWowdTA+qCFgUamRbqvrf56/U=;
        b=d6sXAUZ38D5iNBPaPdo1kkCIV7NFwSiUiTIXPEL8SctU+Ja8w8BtRkHfuo3r0xVRUe
         tlcQsbwUvyT7oU8UxgnfQyHvWUnZOzHrFEXLPUi354hq2Nhf6CuNErVGwrU1mGeeeDCa
         JqxU5oX4zYBvTMx6wgSQIJ8dvJSPDkAptLxVeSGtzJqu7hV+3uArYVLmCTAsEOV7hqwL
         5ku/3Nzoa23taYBp95PVawIOaiHeD+w0nY+IUV/+YSvBJ+q+ElIBBblj8TBe11lbTwrq
         iQVYEVr3CnD/USY2HMl2cas0euKySEQUNO13GypA7c75x1zh5WNWuVygVzjZOOZgt8ZO
         Q5tQ==
X-Gm-Message-State: AOAM533RveYIK5gef0yZeIwbjgo36d6M3+cP9JtbsCYi3Iu+/WyCud2D
        qn/kI1KwDLYIYDgEjxHxdI2srNtHiccCqmwmpZE=
X-Google-Smtp-Source: ABdhPJyYhKdbim01GsJEsVCbc9j9WBAczYUzP3i80F/rOuP9yYzYAZBUzPxDMFAE0laLA8Coqki2Qqg8sesoWqjwOmc=
X-Received: by 2002:a63:b1e:: with SMTP id 30mr2372559pgl.203.1607527105528;
 Wed, 09 Dec 2020 07:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20201203095342.73591-1-alexandru.ardelean@analog.com>
In-Reply-To: <20201203095342.73591-1-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Dec 2020 17:19:13 +0200
Message-ID: <CAHp75VffjpFyh0G3F6v0j5tXrURA2pCtWsSztC7KejhBFuLTvw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: core: register chardev only if needed
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 3, 2020 at 11:55 AM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> We only need a chardev if we need to support buffers and/or events.
>
> With this change, a chardev will be created only if an IIO buffer is
> attached OR an event_interface is configured.
>
> Otherwise, no chardev will be created, and the IIO device will get
> registered with the 'device_add()' call.
>
> Quite a lot of IIO devices don't really need a chardev, so this is a minor
> improvement to the IIO core, as the IIO device will take up (slightly)
> fewer resources.
>
> In order to not create a chardev, we mostly just need to not initialize the
> indio_dev->dev.devt field. If that is un-initialized, cdev_device_add()

un-initialized -> uninitialized

> behaves like device_add().

Are you sure there is no user space application that doesn't rely on
character device to be always present?

-- 
With Best Regards,
Andy Shevchenko
