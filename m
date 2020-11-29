Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A2E2C7B2F
	for <lists+linux-iio@lfdr.de>; Sun, 29 Nov 2020 21:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgK2UiC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Nov 2020 15:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgK2UiB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Nov 2020 15:38:01 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68CFC0613CF
        for <linux-iio@vger.kernel.org>; Sun, 29 Nov 2020 12:37:15 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id a9so16701755lfh.2
        for <linux-iio@vger.kernel.org>; Sun, 29 Nov 2020 12:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ID7X4LNmsCPnqrBygYdugLZ/+0Z/j24tNkqATwrEUGw=;
        b=pjsG10PIjheruhJ7vfWEYPfAY5gKmxZFy0L0eOOXU4mlaPIuNkym4YWGjlFTzpUT0z
         MCud+U8aiJAm3hPlXnFwmqYipYmvFJy8LWHYkLDEYb+Lf5RGa3CrTNfFC2IdciujifG0
         Xt2tGgp5Sq3m5YdW1oRGrZ5eNKvreXAy8GkWF7dioo384/k0qJUbjBDYw/Y5Dy1d8Urp
         yoIV6kXxAUgthAjICoyiWJIUBGtubfP9efHF7kVDrTTBzQqfTLHYa5J7FdMBSFOGUfBe
         P0KHr91/LSgTPorQbIj+8OgbwKQZwstO8SCtU0o84UudrrS7jJS8OgBP5/NNDkPDZFqL
         ZlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ID7X4LNmsCPnqrBygYdugLZ/+0Z/j24tNkqATwrEUGw=;
        b=J3Ym23PnO7K6tu92Cumf9mSy4KLtGWJlHvZmh6ZN0DRhTi4NOzfXO1OJCUuukGMjCG
         wOXYieaxxtC6ADdcy8Ygkh1W+z3rJHyZT8ZVm/BJCmD3gkb54rifOfC4SDLHdr0LSzyZ
         jY8VN8hcaJ2h9EG2fDHOZKxIxxyviHrGmUtyJUvQNFxOWr7tNxrz1UTCd4PePf603LZB
         TvD6BHrkQkf9jAQikqzUMQE1fv/4aNPkFkVEqF64CzJkjHeVHQdTyxMOMmugEUlATr3z
         jfRYNGeb8B21bDso8ZvUTpUmbsDxypqwc/YxNskbPVuMBjrTlsARyEq66YmD6PZHARBY
         fwHg==
X-Gm-Message-State: AOAM531lStB/mfRdZFJ+CPmNPAkRNs1fN2dOHUc//U/t5nNhPaSjHJ/i
        a8uFe/zsZoFjFSv0MDgBnKPw1mm82p7TQPQdvAQAPA==
X-Google-Smtp-Source: ABdhPJxz9uA3oqcQLWSOajUcrJoaRBrlkWQn848CcV8l1oLvSC1jpfeIc0hUaaYK4pO0WZtEsrwI9pqNZKws0M23Wx0=
X-Received: by 2002:a19:ca05:: with SMTP id a5mr8435129lfg.571.1606682234000;
 Sun, 29 Nov 2020 12:37:14 -0800 (PST)
MIME-Version: 1.0
References: <20201129184459.647538-1-jic23@kernel.org>
In-Reply-To: <20201129184459.647538-1-jic23@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Nov 2020 21:37:02 +0100
Message-ID: <CACRpkdatjOsCKmeGsfwMA17FZ7RMjmEBU8YFrbrZ_Nstzedd3w@mail.gmail.com>
Subject: Re: [PATCH v2] iio:gyro:mpu3050 Treat otp value as a __le64 and use
 FIELD_GET() to break up
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 29, 2020 at 7:47 PM Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Inspired by Andy Shevchenko's proposal to use get_unaligned_leXX().
>
> The whole one time programable memory is treated as a single 64bit
> little endian value.  Thus we can avoid a lot of messy handling
> of fields overlapping byte boundaries by just loading and manipulating
> it as an __le64 converted to a u64.  That lets us just use FIELD_GET()
> and GENMASK() to extract the values desired.
>
> Note only build tested. We need to use GENMASK_ULL and %llX formatters
> to account for the larger types used in computing the various fields.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Link: https://lore.kernel.org/r/20201128185156.428327-1-jic23@kernel.org
> ---
>
> Changes since v1:
> * Fix 32 bit builds by using GENMASK_ULL (thanks to Linus + Andy)

Easy to test since I'm playing with one of these right now!

Before:
[    2.677957] mpu3050-i2c 2-0068: found MPU-3050 part no: 6, version: 14
[    2.695905] mpu3050-i2c 2-0068: die ID: 05A1, wafer ID: 12, A lot
ID: 0000, W lot ID: 662, WP ID: 3, rev ID: 1A
After:
[    2.667944] mpu3050-i2c 2-0068: found MPU-3050 part no: 6, version: 14
[    2.686969] mpu3050-i2c 2-0068: die ID: 05A1, wafer ID: 12, A lot
ID: 0000, W lot ID: 662, WP ID: 3, rev ID: 1A

And works too.
Tested-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I used the same approach in the Yamaha driver and it looks good
there too.

Yours,
Linus Walleij
