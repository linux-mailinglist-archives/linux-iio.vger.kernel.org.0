Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B581A26ACAC
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 20:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgIOS4h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 14:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgIOS4E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 14:56:04 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52764C061353
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 11:55:53 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b6so5307602iof.6
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9wMzQ23dRiUT+rWKMory83xYeaIWJOT6qia9k7wcRkY=;
        b=Hb83v4Y9MViJyl1yWAZCJFcc/i56g8a/LG29MRik4E8ocTZZAYoCHvXJd1G2HqS/7t
         SVvbKRorqfY9pIuXerUHrhp+wazMs0I9QrqrcMJGHxKoSXVBC71MSdeUDeqFrpR+lpof
         nNXIsYRWBnunDlsX8v+kVvhjkz839r8MUNuQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wMzQ23dRiUT+rWKMory83xYeaIWJOT6qia9k7wcRkY=;
        b=E6pFUc+e9panBMntDWBAJJTv/9pfdojE8v/Vc2/oY+8UQ7rbBgq0U/QBA+oBEQ5X1y
         SxrleJaZwkKbQkIuhKrGooPkg1KX4GtdAAK0agRaqIgvdPlUdiJL0f+OsJymp+EbVJPA
         Id78AtMA/Q9D/56W1SF7EXPVGhhj6ePRuIzqSXacGug5A457WSneGXdeIAmuWlwlrUQ1
         OpbJmJuLwT4WDd5Aip1ifAdcFgImgLPTT7pgc+m9W8WmFikOhRlkYAqIadKy1efJwx49
         PL9Jm7KAAzLuLq8VFVbhuGkNahYC6D1TszvNC1CRWvL5jNH1JtDHrixHZfMftjfj/ZkN
         7rMg==
X-Gm-Message-State: AOAM530Yeg7WZWmJBuPTrInBbHgtgL6GDlGy9epZZ1XwvzGjrXGcOGO9
        XCrvPudb1D5ubECl5ePCUwaN5Kl41TkEpqCqqLJx0aFM8F0fFQ==
X-Google-Smtp-Source: ABdhPJxKouDmstjf3ZmG4Vj2rTaDWzgqPt/wrudSBMgW2cczbVBbJ5pDwu1NcFlqisgd67HBVZN3w90IlZSJ/ZJbRA4=
X-Received: by 2002:a05:6638:d0b:: with SMTP id q11mr18169356jaj.68.1600196152716;
 Tue, 15 Sep 2020 11:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200910173242.621168-1-jic23@kernel.org> <20200910173242.621168-25-jic23@kernel.org>
In-Reply-To: <20200910173242.621168-25-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 15 Sep 2020 11:55:41 -0700
Message-ID: <CAJCx=gkv+tO_k9YYL1+WtXkNDn_AGCGhZHBor=ygebifufdDyg@mail.gmail.com>
Subject: Re: [PATCH 24/38] iio:chemical:ams-iaq-core: Drop of_match_ptr protection
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 10, 2020 at 10:35 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This prevents use of this driver with ACPI via PRP0001 and is
> an example of an anti pattern I'm trying to remove from IIO.
> Hence drop from this driver.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/chemical/ams-iaq-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/chemical/ams-iaq-core.c b/drivers/iio/chemical/ams-iaq-core.c
> index 8c1b64fd424a..97be3669c554 100644
> --- a/drivers/iio/chemical/ams-iaq-core.c
> +++ b/drivers/iio/chemical/ams-iaq-core.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/mutex.h>
>  #include <linux/init.h>
>  #include <linux/i2c.h>
> @@ -177,7 +178,7 @@ MODULE_DEVICE_TABLE(of, ams_iaqcore_dt_ids);
>  static struct i2c_driver ams_iaqcore_driver = {
>         .driver = {
>                 .name   = "ams-iaq-core",
> -               .of_match_table = of_match_ptr(ams_iaqcore_dt_ids),
> +               .of_match_table = ams_iaqcore_dt_ids,
>         },
>         .probe = ams_iaqcore_probe,
>         .id_table = ams_iaqcore_id,
> --
> 2.28.0
>
