Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A9B1F0CC3
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 18:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgFGQIT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 12:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgFGQIT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2020 12:08:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF7EC08C5C3
        for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2020 09:08:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 64so550949pfv.11
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2020 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/lTjDuJCL3y6fcqv/FiMUZc5xhoW+8W2Ou9KB/LImeI=;
        b=srXavBFATXls2qUz3oyiw1yLfuq33v+B7xhLXLng2KH+8wsG+pbIlOaWBxBu1bGfuh
         QLUaZBz37E9fbHLE5e5UDhK1WG7Eg198bVaq13f7pG7fgwKaVsgbj68WW0cQKJgxNjKz
         BsPIszS2zcFv7rMw7wehgS4XuhQW9V5neQzb9rRqX2ChhM6k/ADid+/R3zbPWX0L7Yd5
         VU1e8X02Njk92Gt8j09jc2/IL+CBnI+wWkOjibIoaM5P4mhZ9mRMuB6YWdJl5+bFJKPc
         RMfcl5WQsCVGBZ/V0SGThKzHzbRqCYM/Q4C76oJo7AQ3Pslr5Cc4GoAWj3TbPIm6+XVM
         Ccug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lTjDuJCL3y6fcqv/FiMUZc5xhoW+8W2Ou9KB/LImeI=;
        b=FtlSvFfNDUOv2bt7LMd0P2iuJS+2OHMvowaH6JOfLx995TKx+TgUkxU5rgFdZ/+DlJ
         odobh5h+b62l/Gt4gaXScW+kBnv/9lYYugMf5LDCsvp0sCapL1WwxnbP8RFcuVN+fpW7
         ZgxA9pnDvDVBONULv/eVBkrDiPha0YT1FU76lwA8spgbqgP93tz4qQFWxSPcYcSW3f79
         QPBMWEHtj1x9AsCadpJV9TxusmiifsMwvJpwoXQUHs8wllc+LhIOC2FhXKaynpV2/BLK
         44wgKLysNEHTHP4ptwgirrEzdRbRWe9e4BYW2mNnI/xRuJ65qZ9LQ2QlUteU9xQuFbOa
         oDZQ==
X-Gm-Message-State: AOAM5324Pm9LB9mBgvoUrduc3E2U2L1mNSC6T9y2XPEKN4Gi8JQzHvzW
        vld2WgWUmz6mf+mnPYjXbNAm1a+bwg3qY2KxhE8=
X-Google-Smtp-Source: ABdhPJwZ17IxxjTOfbM9P2WFwB8DQ6r5QxTR3N+hioJ8On+3Zvcjthlw7WylDkODUcgYjnyBgP5J4UCQ0KBNmmKgRqs=
X-Received: by 2002:a63:ff52:: with SMTP id s18mr17525260pgk.203.1591546098265;
 Sun, 07 Jun 2020 09:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200607155408.958437-1-jic23@kernel.org> <20200607155408.958437-4-jic23@kernel.org>
In-Reply-To: <20200607155408.958437-4-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 7 Jun 2020 19:08:01 +0300
Message-ID: <CAHp75VdOqLevSC0=Z4S29=sBfBoxTAKBgU7KAJpTrtjY5VJoGw@mail.gmail.com>
Subject: Re: [PATCH 03/32] iio:accel:bmc150-accel: Fix timestamp alignment and
 prevent data leak.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 7, 2020 at 6:57 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses a 16 byte array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by moving
> to a suitable structure in the iio_priv() data with alignment
> ensured by use of an explicit c structure.  This data is allocated
> with kzalloc so no data can leak appart from previous readings.
>
> Fixes tag is beyond some major refactoring so likely manual backporting
> would be needed to get that far back.
>
> Whilst the force alignment of the ts is not strictly necessary, it
> does make the code less fragile.

...

> +                       memcpy(&data->scan.channels[j++], &buffer[i * 3 + bit],
> +                              2);

sizeof() ?

-- 
With Best Regards,
Andy Shevchenko
