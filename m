Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CF126ACC8
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 20:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgIOS73 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 14:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgIOS71 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 14:59:27 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD92BC06174A
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 11:59:26 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q4so4062889ils.4
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 11:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXjhbaioJ1CwG0eMn7q6MIoPqBac8yyeOFEem806Acc=;
        b=sZ2ZyJhEX6j4wzxNSJPInWSKJNrysXsWGJBiWSykfEZST2t6rClTC7ZfdWVnz0WaTa
         NjVuK2LtxCKysXyhHKnDKH04sDGTGtI6uxkRgKr0NIzYkPEBNmIpHyt7shzVF9oAO6Ya
         gi/JCbNkHSDNK3A/TcKCgpTilRbB2icVIchuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXjhbaioJ1CwG0eMn7q6MIoPqBac8yyeOFEem806Acc=;
        b=R6E6oWf8lb/xeClaDbHn+DGtivOXFCXuWJOLsey0OPie74MfRwNIaEHutQY3GdauBf
         pbLm0F/SnpmbGgs7IaNkeUoK88FBwMQx96VQ/FjO8h9leNkzsWrZFjiv/ZcUJdZgW0yB
         vAQHrnVtMOfDtqqaZACJ4A8A5iOZZW8Lu3TZP+3og0BEN07UODqZCveyIZ1DCBkAoA3Y
         6DD7ZoFBh/3LWUT4q5cl5CAriYIEO5D45EAfOvlHOo+qFiIQ4szPX1or30MNoRH9LAVB
         Uzv/PXZOJ5e+RAp5dETo8MbNZ9eBffjlDfFv2yI5rKnj6lCpmCep3SJLDp8BiYVY2djN
         u/Wg==
X-Gm-Message-State: AOAM531jh2Nf7zqXnu5dFTDJBZ+j2rPrBb6sk6AzkvObKqUmYD+P6YL1
        Jnuyf/Gmm0LZ8KcgyqzLIeQLt3hQSx2yZMDVnVIvZA==
X-Google-Smtp-Source: ABdhPJyNbeltHL7oudEtE/iOAYmr53vaFrBFHnIn8/u/B24xXDKUn/3sSzv4cO0BTapxmJUZq2JdrAugAdfnrxzJnGw=
X-Received: by 2002:a92:8b52:: with SMTP id i79mr18234243ild.177.1600196366177;
 Tue, 15 Sep 2020 11:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200910173242.621168-1-jic23@kernel.org> <20200910173242.621168-31-jic23@kernel.org>
In-Reply-To: <20200910173242.621168-31-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 15 Sep 2020 11:59:15 -0700
Message-ID: <CAJCx=gnwyNnTdAcuQ+SLcfRv9qnQTqza75vyAW6-g89=VmExCA@mail.gmail.com>
Subject: Re: [PATCH 30/38] iio:humidity:hdc100x: Drop of_match_ptr protection.
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
>  drivers/iio/humidity/hdc100x.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index 071cb2b12bb6..2a957f19048e 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -15,6 +15,7 @@
>
>  #include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/init.h>
>  #include <linux/i2c.h>
>
> @@ -417,7 +418,7 @@ MODULE_DEVICE_TABLE(of, hdc100x_dt_ids);
>  static struct i2c_driver hdc100x_driver = {
>         .driver = {
>                 .name   = "hdc100x",
> -               .of_match_table = of_match_ptr(hdc100x_dt_ids),
> +               .of_match_table = hdc100x_dt_ids,
>         },
>         .probe = hdc100x_probe,
>         .id_table = hdc100x_id,
> --
> 2.28.0
>
