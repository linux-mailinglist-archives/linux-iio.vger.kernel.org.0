Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EC121C4C8
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jul 2020 17:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgGKPQh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jul 2020 11:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbgGKPQh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jul 2020 11:16:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60072C08C5DD
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2020 08:16:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a14so3875191pfi.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2020 08:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2Hy7sszIZwg+naSP/I9a5ZJLCqscYui1QrXtibBFrE=;
        b=JXxFldlRwpNgqVnHVPQBSwsRdhyNzvhFrin4o2HTmxo26x9xKPoSXODT9OpnNETkFs
         wPss6eHYKeFJzOSTNcPF0je7ElfCly0pS2P+vVrHmMwQrHVU9EKr1SCGFcAYKq3HJpRL
         XLmaJd/dYi5XYMB9W55gdUbzoTqhSWDjX+t7YGscLDHxAo4yiJsuYFQhKDuGAZYOPo7D
         IL7xnv4fnOx02F9d38R6CzCkPK0ugVIH9z27TaZPEpxOc2LyFOWj6q0Bd6K68N9ezj7z
         7XcK8JAlvD/PX+YFL3xh3JU+PkzSkYKjgxSnlz4M6tRZ00a2eBE1DLjFkErLjBIQhB9u
         /qQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2Hy7sszIZwg+naSP/I9a5ZJLCqscYui1QrXtibBFrE=;
        b=Pl0dvQjcbiWmxN//c78VBt6oxU9c03LiQwBpAJ+MS2Q97PB4GeBTey5MJLdVJjB8K9
         DpH3zytRiCTt0eVzy1B+N28lvHwARuj0wSXl2YnDOe06TPHSKR0DT2T/hHjb0jOaKGTE
         5CO6kjNx8FYUPzGwIGifBLE3WUvQk7GveCF46GO5+SFZfav2IgKRM0jnUwvjPSnzt2VE
         ReDshp86cjWzLeoSFFh8N0qJBg0uQpyzVHnFTgQci/qOTcOOc9VLsAgZZJsLtR8sTKKt
         JbjvVgR1rAMn8ObocVSpnPwHoWQB3QSK9iveRwL8BOymaTcKXDvVdtUrYRxfOrCODGVI
         k7eA==
X-Gm-Message-State: AOAM532CDOap+MAEx0BLuz6erPkf8QIQ3i2DVWYZk1F4cGNoKVI67ZQN
        Lz5mfvKwLiFyHnKU1162UIox6ulJQHaU+soUROs=
X-Google-Smtp-Source: ABdhPJyn+ag7szo8XR4WQI0RnhUBO2MPf1Lur7gG7QdrUvueziG0f9ZS3/drxPGNBVFAVBSxGgdKDzccTBlEjIddAjk=
X-Received: by 2002:a63:924b:: with SMTP id s11mr60727536pgn.74.1594480596834;
 Sat, 11 Jul 2020 08:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <86d053d1re.fsf@norphonic.com>
In-Reply-To: <86d053d1re.fsf@norphonic.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 11 Jul 2020 18:16:20 +0300
Message-ID: <CAHp75VfGHL54rViUAx0-V=S3QqUjoxNBV5f9Be9C-UXk2tHr+A@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] iio: humidity: Add TI HDC20x0 support
To:     Eugene Zaikonnikov <ez@norphonic.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, development@norphonic.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 10, 2020 at 2:54 PM Eugene Zaikonnikov <ez@norphonic.com> wrote:
>
> Add support for HDC2010/2080 driver and sysfs documentation for its
> heater element.
>
> HDC2010 is an integrated high-accuracy humidity and temperature sensor
> with very low power consumption. The device includes a resistive heating
> element. The temperature range is -40C to 125C with 0.2C
> accuracy. Humidity measurement is 0 to 100% with 2% RH accuracy.
>
> Signed-off-by: Eugene Zaikonnikov <ez@norphonic.com>

You have to use Git tools, such as `git format-patch ...` followed by
`git send-email ...`
Attachments are very hard to review.

-- 
With Best Regards,
Andy Shevchenko
