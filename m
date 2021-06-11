Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87C53A4802
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhFKRm5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKRm5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 13:42:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B699C0617AF
        for <linux-iio@vger.kernel.org>; Fri, 11 Jun 2021 10:40:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so6262515pjs.2
        for <linux-iio@vger.kernel.org>; Fri, 11 Jun 2021 10:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKUquuYsoz8hbClx1strrxWJbTmhdlgRdx/Ra2/om9Y=;
        b=qIhnZk9rGcJ35Xa3WuB2cWTxkQF/bkAZL68XhmQRYubX3wMLfO1+IvQtE4u3OMBbb6
         eFPciGncgftSdUHDTgpi8wi995UMey4sltXjZSqNYYcVGW/d/03hnHSY4lNY4V0f/Q79
         9W6Mdx5qRqFZTZJ5poYpyOptKGQUMvHpW6KYmo/nTXS6GG423046OPitmSp3rwfWqO8h
         bcll9/Y4dbhlma5z7ulBfG9HpRChPsz50lCpqHewbeNVu0OhgsD3Niijnnb6kKYuhoEz
         0UI+qezni+prCNfogm6lHGhk5y8ZIWPyBABY2/4kyg7rgd6G8wnpvq9SEatY2c5zyQMb
         9XDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKUquuYsoz8hbClx1strrxWJbTmhdlgRdx/Ra2/om9Y=;
        b=ey3MVHHcxyuYf/iMla1LSiJHNGDruyfRR9RtsboSbrrwHofk/96Ame4IrurRr/P1BW
         HJk7Nbf38d//CFGev09ND0XgawLMnKUi85ulRSi6eMlaRMYA09hQnsjJzdN1o81n8Kqq
         Wrw2Ui5wSnbMSSkLLXWuLamw08uItyYckDpx/dphdhQ0mO+ju/+FIqBqcXmiSQG+JUld
         ienfKxQil3WH2j0I730rVGsO27AwSs7fMmjQkkJIZbXrSXYew2fMDQkzSTW6OhtFe+Ts
         EfW2WuLUiHh+ziUl/FGDOn3mOeSA9lr/ijJsNmfug76SbfwJd4uBvHOJNcy7f8DxK94D
         v4JQ==
X-Gm-Message-State: AOAM531IYlLXr8P4SaV0ZyDAkV42LfpdPw/UQdqqnPAMlOegI7cAMu/c
        58fDRhj7WlN2O+EBZwBmUUGIKIkEgpsqoO5U6c0=
X-Google-Smtp-Source: ABdhPJzNd63LGmJ6PoY7zhZu7RJKUWOdhBGBnnsXR/7Bxv1mOsXhymietERVd/zW32uEWlj1GlJ/hjKyGE4BW8Ik3GM=
X-Received: by 2002:a17:902:d305:b029:10d:c8a3:657f with SMTP id
 b5-20020a170902d305b029010dc8a3657fmr4907527plc.0.1623433258598; Fri, 11 Jun
 2021 10:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210611152614.109361-1-jic23@kernel.org> <20210611152614.109361-3-jic23@kernel.org>
In-Reply-To: <20210611152614.109361-3-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 11 Jun 2021 20:40:42 +0300
Message-ID: <CAHp75VfwbCsHXxN6tnsA6acj0cKnQQuX0_SPY_fiSbsYgMpz2A@mail.gmail.com>
Subject: Re: [PATCH 2/7] staging:iio:addac:adt7316: Cleanup includes
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Nuno Sa <Nuno.Sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 11, 2021 at 6:25 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Result of consideration of the output of the include-what-you-use
> tool.  Also a forwards definition of device to avoid any
> ordering of headers issues.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/staging/iio/addac/adt7316.c | 5 -----
>  drivers/staging/iio/addac/adt7316.h | 1 +
>  2 files changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index ccbafcaaf27e..e81791ee182f 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -8,14 +8,9 @@
>  #include <linux/interrupt.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/irq.h>
> -#include <linux/workqueue.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> -#include <linux/slab.h>
>  #include <linux/sysfs.h>
> -#include <linux/list.h>
> -#include <linux/i2c.h>
> -#include <linux/rtc.h>
>  #include <linux/module.h>
>
>  #include <linux/iio/iio.h>
> diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
> index 8c2a92ae7157..a1f6324ead59 100644
> --- a/drivers/staging/iio/addac/adt7316.h
> +++ b/drivers/staging/iio/addac/adt7316.h
> @@ -10,6 +10,7 @@
>
>  #include <linux/types.h>
>  #include <linux/pm.h>

+ blank line?

> +struct device;
>
>  #define ADT7316_REG_MAX_ADDR           0x3F
>
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
