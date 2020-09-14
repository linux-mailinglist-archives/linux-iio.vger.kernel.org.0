Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3B32686D4
	for <lists+linux-iio@lfdr.de>; Mon, 14 Sep 2020 10:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgINIIW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Sep 2020 04:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgINIHZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Sep 2020 04:07:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD1BC06174A
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2020 01:07:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o20so11927530pfp.11
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2020 01:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJ8yq2TeBG53NeLP9GDHsvtKrrzS9ggi/2Fg4ngvy5w=;
        b=oaGQCapv2q/MKZGTIpssKErE3fmMotF/dC/Irr0940WL9YQQP/3krkoKnuCbqZDyLC
         s4O2stHR4AhKSkmqifo3kw88B8nNAJ5buC6R2B4znoQXtiul++4HqcsVNVDy9RtYx1Pq
         QAuJ8IO44CeVUoZXI2vs9/YX/jpX8DHugIFphRQcpFNWL6XdvRZVz8vio5Xb5jN5vD6h
         XXjkt94WXLdoBKZ9Rt+bSDPLaBmz5UuUk29k9HXDwHjoSnwWlXFRlvPhonzc5Irz1a5L
         6b06nCdt4h21KSZdTPCNhQeLlgQ6o/80BvGM1HXfeDqV3A3OAiB1Sb+NMPpvBhbneV7q
         1p8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJ8yq2TeBG53NeLP9GDHsvtKrrzS9ggi/2Fg4ngvy5w=;
        b=QS9D4wdWKuXReIfF2N9fB5ouKQc7/qYKcxGD81HUHW+uTgsFLdDJbw0oQvcPtA2awA
         TgV3ksnQCZfErkwaV/adMHaJFnrwYJkgQ1JzO8M6+ckg0t1ATcj6QAaRHG3MpeRK0YSv
         NPKiFCjvy5OIHRA+8ME4lQuRD1cnjAXKbr/dL5YLKEYLYWnX3TOTC0JGqrCzbynEdeNS
         lyHgt6aV8QjGPvjEGHgs0K6ut17fY1m65OM/Pi4ljTZsYTHYK4KVvU6VgaYQ4de2zmVH
         62lCntC9M2tUNhO5MU8tYPh+0XuSHdVZdOFlieeMNNQXP3VEn+be7ZY6fLguGY6cK9JY
         GWNA==
X-Gm-Message-State: AOAM533HgFVyXys24sHjjmKpfidabSBFr5LtysAYaQlv5MaqhdmZa2R7
        VlAoMM4Te92/8rLeh58HMJjFOb77m+PqxRYfPr9eQIREWMnChw==
X-Google-Smtp-Source: ABdhPJy5b4OWLdowicDqRmOHnnUUOQ+29JGtp76vtj26EVRl8btprLYvszlHd2o8CKbqQDonhlSJI7NTnU9QVTfWsGM=
X-Received: by 2002:a63:ec4c:: with SMTP id r12mr9750132pgj.74.1600070844656;
 Mon, 14 Sep 2020 01:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200910173242.621168-1-jic23@kernel.org> <20200910173242.621168-6-jic23@kernel.org>
In-Reply-To: <20200910173242.621168-6-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 14 Sep 2020 11:07:08 +0300
Message-ID: <CAHp75VcwsCK+R-543rzQOPLB5Vi=2yUjRb2nYYATatsKf7CE6w@mail.gmail.com>
Subject: Re: [PATCH 05/38] iio:potentiometer:max5481: Drop invalid ACPI binding.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maury Anderson <maury.anderson@rockwellcollins.com>,
        Matthew Weber <matthew.weber@rockwellcollins.com>,
        Slawomir Stepien <sst@poczta.fm>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 10, 2020 at 8:35 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Given that an ACPI binding must start with 3 or 4 capitals,
> this cannot represent a valid binding.
>
> It seems unlikely anything out there is using it.

Totally agree.
The names are dictated by the ACPI specification and don't mention
small letters.

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Maury Anderson <maury.anderson@rockwellcollins.com>
> Cc: Matthew Weber <matthew.weber@rockwellcollins.com>
> Cc: Slawomir Stepien <sst@poczta.fm>
> ---
>  drivers/iio/potentiometer/max5481.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
> index 6d1e1a57cba1..a88ed0eb3adc 100644
> --- a/drivers/iio/potentiometer/max5481.c
> +++ b/drivers/iio/potentiometer/max5481.c
> @@ -7,7 +7,6 @@
>   * https://datasheets.maximintegrated.com/en/ds/MAX5481-MAX5484.pdf
>   */
>
> -#include <linux/acpi.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/module.h>
> @@ -182,22 +181,10 @@ static const struct spi_device_id max5481_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, max5481_id_table);
>
> -#if defined(CONFIG_ACPI)
> -static const struct acpi_device_id max5481_acpi_match[] = {
> -       { "max5481", max5481 },
> -       { "max5482", max5482 },
> -       { "max5483", max5483 },
> -       { "max5484", max5484 },
> -       { }
> -};
> -MODULE_DEVICE_TABLE(acpi, max5481_acpi_match);
> -#endif
> -
>  static struct spi_driver max5481_driver = {
>         .driver = {
>                 .name  = "max5481",
>                 .of_match_table = max5481_match,
> -               .acpi_match_table = ACPI_PTR(max5481_acpi_match),
>         },
>         .probe = max5481_probe,
>         .remove = max5481_remove,
> --
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
