Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6B7374F80
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 08:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhEFGpe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 02:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhEFGpc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2021 02:45:32 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D34CC061574
        for <linux-iio@vger.kernel.org>; Wed,  5 May 2021 23:44:35 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l19so3867457ilk.13
        for <linux-iio@vger.kernel.org>; Wed, 05 May 2021 23:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iE3HP6YaDtiJyFDGICjRlUEy/ndaKCRyktyib2JbRHE=;
        b=LObLRpfgosrdTUkTMTIM3p06U10aZlAAJ+FufCrP0fRu2ggJ/XffLf9WNglN/eKsYG
         xksO8zqWMwHHiBNi6kD9WmeW7iqA9g2PhusiS/iXRxt5oIZF8/NLKXnkyS3yvWwpmOs1
         2o2mWuvcq4fn5qgkAczQqcLbsllMXoXnzrJmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iE3HP6YaDtiJyFDGICjRlUEy/ndaKCRyktyib2JbRHE=;
        b=sjQx9CD2n1d/LRUZE6nWNwCWkVYBD4bdeoISyI7qqGa+efxozfhxxjyXahkHkOrgBF
         rTQfulOZge4XysaJA7JR81o2h1Opvhb/Vf6R8hHsQYTV08rF0y6mWc8MxzmrxWalakwb
         Pj25whnjp1tKGfjsEIxXkZQaEYyKVLEV4LlwvQeTFwucAILxI/T3VxDlF2a8uC2kAls9
         pFsx71qx6l0GyrY1gRsP66A+gmRRE1adUn2X5YA59DDJiT666+VdLAZb+g/FnZOHxIDY
         RtOaGyf+xo5ZjlUpFVp8iPkLJVWMoHt8noiE83hLAYX2+5xCGKN+pKGJfwDuuixtpwBK
         B8jQ==
X-Gm-Message-State: AOAM531x1orVb2cUBke3TKv/bRrT3RdNDqvMPkWGAfhpHO8XSzPy8HWq
        vYFq5M99FBA+sMI1+NqVaALwE4BLKcD172Qzg69vHg==
X-Google-Smtp-Source: ABdhPJygfKxBYbTtJyx3uGRLRoU4LBNocz1pwOE/vq+6foBm/IBs00zWhtvtlbAdnDdgzGCsUqb+HxqZnkh9lrpWP+o=
X-Received: by 2002:a05:6e02:eac:: with SMTP id u12mr2776347ilj.177.1620283474778;
 Wed, 05 May 2021 23:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210501171352.512953-1-jic23@kernel.org> <20210501171352.512953-8-jic23@kernel.org>
In-Reply-To: <20210501171352.512953-8-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Wed, 5 May 2021 23:44:23 -0700
Message-ID: <CAJCx=gkhT6Hw07n5nY6RGP5dk7kQeUanSib2gR9FQBEJaJD-yA@mail.gmail.com>
Subject: Re: [PATCH 07/11] iio: potentiostat: lmp91000: Fix alignment of
 buffer in iio_push_to_buffers_with_timestamp()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 1, 2021 at 10:15 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Add __aligned(8) to ensure the buffer passed to
> iio_push_to_buffers_with_timestamp() is suitable for the naturally
> aligned timestamp that will be inserted.
>
> Here structure is not used, because this buffer is also used
> elsewhere in the driver.
>
> Fixes: 67e17300dc1d ("iio: potentiostat: add LMP91000 support")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/potentiostat/lmp91000.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index 8a9c576616ee..ff39ba975da7 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -71,8 +71,8 @@ struct lmp91000_data {
>
>         struct completion completion;
>         u8 chan_select;
> -
> -       u32 buffer[4]; /* 64-bit data + 64-bit timestamp */
> +       /* 64-bit data + 64-bit naturally aligned timestamp */
> +       u32 buffer[4] __aligned(8);
>  };
>
>  static const struct iio_chan_spec lmp91000_channels[] = {
> --
> 2.31.1
>
