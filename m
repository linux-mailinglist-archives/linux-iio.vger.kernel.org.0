Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E164410B4
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 21:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhJaUKT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 16:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhJaUKT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Oct 2021 16:10:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A142C061570
        for <linux-iio@vger.kernel.org>; Sun, 31 Oct 2021 13:07:47 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g10so57375906edj.1
        for <linux-iio@vger.kernel.org>; Sun, 31 Oct 2021 13:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZUcAEMxgxtm8sBFVLQTQdgy/KnvDQGapvndHtOpcYM=;
        b=Wkgw2iPqLgtl9h34SU4aAUXQFmwCx4Oe+WG44dDYSYCEWc0nyANy3ovaXkEYBZR3Dj
         SpnEmK4KuqP8PEEnlS6fVjQndjuRonak13rOaU5FQBzsTIUl51s4ogez4M0M65RdovlP
         gTqZvKBgzKZOYjLnyobewQPuZbqdE2iVmZZ2/kmBt80HjCQ95mSsnlpmmdlQESztyl6v
         NPNKvHmoTqKDW7s1j3w+BZNLjugie+ltjoJMXDYAYWPtYbJ9ZuT4RM2rzgeoRqe1jFoD
         M2+B5/NnSEb7/Qd4O+2CU64p4O1yVDHGGIlVGs+TR9o7TH8pew1mGp5pVN9irYL8fPjt
         6U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZUcAEMxgxtm8sBFVLQTQdgy/KnvDQGapvndHtOpcYM=;
        b=e7cfHNMFhhixymV4GbCfouiejbMYTwCJLYpNQdgOAeT26zppxbVpLMBvQI3Daaulsa
         0dehDY0tnVuDlYMeqUcZhnsYWBCbur8Z0As3KCrAS3M2zOCU6uujWX7LjFZ0YcHtAAu2
         BVgv5dzJV5N4mANDZQkFckDaQWusCnCZ/aP3XZNcgAuHWJUH18UjNbONik9QSU6gGCmn
         D9KewJd4hbC7nIGZtdqwG2JKarB+t5l8aCtuJwenvVJzwh5QowYdq5tFhTWVefOyxNoT
         TGzAnU9z59k8RQGwIQQDENjGx9jOWWW1mnDq2yH1m9yAtY3KSb5kzOy6CXTqUYSYb1qB
         9mSw==
X-Gm-Message-State: AOAM530tOg7qkpswLU1ZnK7tZNaIS1F5lunS+YwdBudvm/bGH6T4SCc3
        peGC4pG7lOzWdQnZaJ1MQzm6oAKbfQ7QQqWUd8E=
X-Google-Smtp-Source: ABdhPJwZlHOLWAmCLcsFenlUWECwoy3MMzArUrkNSSO7C+Zkx4ekuUWALkQ0F6svV3Y8nUV205fOnWc41qwXY9CivXw=
X-Received: by 2002:a17:906:a158:: with SMTP id bu24mr28817800ejb.356.1635710865713;
 Sun, 31 Oct 2021 13:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211031164603.4343-1-maslovdmitry@seeed.cc>
In-Reply-To: <20211031164603.4343-1-maslovdmitry@seeed.cc>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 31 Oct 2021 22:07:09 +0200
Message-ID: <CAHp75Vd99uk+wZHpVyYEveNGTaK9Nj5-oYTRua2UhOKjtYnS_g@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: ltr501: Added ltr303 driver support
To:     Maslov Dmitry <maslovdmitry@seeed.cc>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, north_sea@qq.com,
        baozhu.zuo@seeed.cc, jian.xiong@seeed.cc
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 31, 2021 at 6:46 PM Maslov Dmitry <maslovdmitry@seeed.cc> wrote:
>
> Previously ltr501 driver supported a number of light and,
> proximity sensors including ltr501, ltr559 and ltr301.
> This adds support for another light sensor ltr303
> used in Seeed Studio reTerminal, a carrier board
> for Raspberry Pi 4 CM.

> Signed-off-by: Maslov Dmitry <maslovdmitry@seeed.cc>

I believe it should be Dmitry Maslov, i.e. First name Last name.

...

> @@ -1597,6 +1610,7 @@ static const struct acpi_device_id ltr_acpi_match[] = {
>         {"LTER0501", ltr501},
>         {"LTER0559", ltr559},
>         {"LTER0301", ltr301},
> +       {"LTER0303", ltr303},

Any evidence of this ACPI ID being in the wild, please?

-- 
With Best Regards,
Andy Shevchenko
