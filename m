Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14E1333145
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 22:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhCIVu0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 16:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhCIVuY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 16:50:24 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E0AC06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 13:50:24 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id k2so15648447ioh.5
        for <linux-iio@vger.kernel.org>; Tue, 09 Mar 2021 13:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0mqqfbY/wWz/mYs+BdQDZVGZxNuOENxA8jIeObUmtk=;
        b=VDwmtLBudyOrKf+UKEq+Rojv2V57bF/mwh3ysJMFN4WlCafrwcLcqZS5Oz5XJS3fOB
         vfnoSdV/GCOnZ/lPpDFZSgMWVSWA/c03OXJ1PsnbOFTZ3Z3B9GnPcrBJknDxnD2LN+Pu
         oezlVu2sCrvho9HxMLlNJ8ce6c7SpIVjfBzEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0mqqfbY/wWz/mYs+BdQDZVGZxNuOENxA8jIeObUmtk=;
        b=exdIspG7Ech1v2gyD0NGGkeT8PEd5JnPFBmIWhC3upicw7zY++k8OATKCXRSWXTq6k
         J70zB5pG474cr1dpo3KhNeuTxFppwyJMgME5pKhX7JD56xTQG3xDzv3gwV6TehKrZ7Nz
         x4fstB2wMYAOJ+p3UwuSQ46GdwGd2Moj4pKnd+XTwIFSl8e97Lx8aEqQl/dRVP8N1htQ
         7yy+L1wZXoC83IFvKQ11Ok7yezYhW5pjmK0w3m0nmp5SpjxuClI0RgvyUjOtaYhPfGUN
         nn2+XXKWY1FRW0+IEIu1kWHS3tX14fWExioEDGC+6bzNlzlXcuKXL3uKNoEI8hsXsZrX
         +7AA==
X-Gm-Message-State: AOAM532mw/fZ+wt6dm4F6rGlRzaU3iEvVPtc3vieFyN9viFoy+bWO74X
        tGl3tpSFIDbeKf2SxgByDuxBsRGg7tlJ0ggO4gXRRw==
X-Google-Smtp-Source: ABdhPJx4yMWWc1lSB8VLu9HICLswfXQgEA9Enlo61ruETAfRqiA/mff4GeOl27EkWd1RSqY+p6NGVKLAN4DMfjrrV08=
X-Received: by 2002:a5d:93c2:: with SMTP id j2mr134647ioo.166.1615326623459;
 Tue, 09 Mar 2021 13:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20210309193620.2176163-1-gwendal@chromium.org> <20210309193620.2176163-8-gwendal@chromium.org>
In-Reply-To: <20210309193620.2176163-8-gwendal@chromium.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 9 Mar 2021 13:50:12 -0800
Message-ID: <CAJCx=gn-_gMND7VTmHggZqJmiGXwpps-ongxY-RbDuENDi_eQA@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] iio: as3935: Remove code to set trigger parent
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ardeleanalex@gmail.com,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 9, 2021 at 11:37 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> iio_trigger_set_drvdata() sets the trigger device parent to first
> argument of viio_trigger_alloc(), no need to do it again in the driver
> code.
>
> Given we call devm_iio_trigger_alloc() and devm_iio_device_alloc() with
> dev as parent, we do not have to set data->trig->dev.parent to
> indio_dev->dev.parent anymore.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
> Changes in v4:
> Improve commit message.
>
> No changes in v3.
>
>  drivers/iio/proximity/as3935.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index b79ada839e012..edc4a35ae66d1 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -411,7 +411,6 @@ static int as3935_probe(struct spi_device *spi)
>
>         st->trig = trig;
>         st->noise_tripped = jiffies - HZ;
> -       trig->dev.parent = indio_dev->dev.parent;
>         iio_trigger_set_drvdata(trig, indio_dev);
>         trig->ops = &iio_interrupt_trigger_ops;
>
> --
> 2.30.1.766.gb4fecdf3b7-goog
>
