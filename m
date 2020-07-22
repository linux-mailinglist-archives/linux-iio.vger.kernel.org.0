Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1E622A0F9
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 22:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgGVUyq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 16:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVUyq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 16:54:46 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373BBC0619DC
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 13:54:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d1so1576179plr.8
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 13:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=52uV824Z5mOz5zC5EVNI88VW705agysq2X5RKF+y3e4=;
        b=qs8irUU/sr7JEJnqEJXYPMz/Ag9PaKligBZGJDfj6UVpszoLKVppHKcJuo6NaWldXN
         C2RfOwpjjwICnU66be/9H40S2PiHzdNKodiQYxHPFddsswBFfSWhfX636FIK72aqxcVE
         dCkSIY6lqR+cGcGQHLy0ZVIS13+SsR3M3mWriTuTmBnHaGGb6ukCNyGo7gEdAdDdCqxL
         T54AYPIOdkvNiW2UP/qvu8Zwst5EX33KTuj0Ndh2XNem1i+M8KIWdJ51gNvmtqlyjfUL
         LtS6022o1UM+9/rzs1Oub33/3vP5/YEPWEbqlAPiqrGnLZ59Yd6Qnh76k+ZM1DfZIfFG
         OOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52uV824Z5mOz5zC5EVNI88VW705agysq2X5RKF+y3e4=;
        b=dE//OTDz69Yo62aPW4QJwQVj+AoqWuArOBdecVlHh9nBR8RucCVKNr2NF5/EV9gtbD
         olzqRpGGMqwXoU6YWdX9NJksps7H2Uq2Tygb1ERL/XCSvJvcZE+3IXPEGMR+Gl2kfoUw
         kKef7rI9WVyhjvaR0q+WpNIGinKbtL91NdtMPr/mA/MpBBMqgzxn9vFkrxsa4h9tcz50
         cRhDaJ1jpqfGTbs7UcmPOXzp5xKAFKS2rW2+04vv0RxmkxcaOyKJdo9wmBClXuCBxlIS
         +swU6Iqt0sbwupYj4UZgK0EF0zKnKSfFBPbRHhOAEzTI9ZCZ4l0Y9gpmyCrKncA+wvjc
         kCwA==
X-Gm-Message-State: AOAM531rOX30CXNTHaD9ZhK2OAFzOttEV0VQeVZ/blhWE9E+KizpIUXp
        FqCFI2dTqPf2hvNdYgQd/LPzerUtTvSWMoh1KFs=
X-Google-Smtp-Source: ABdhPJw4dcWnVStU2kAexvDXfN+iQVHA60HlaTFHYOxcdn0DaSZmflwJUIV7qw2W+QuoiUWwLjSnEzZCKiOYR0NgdDU=
X-Received: by 2002:a17:902:9a4b:: with SMTP id x11mr1074294plv.255.1595451285705;
 Wed, 22 Jul 2020 13:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200722155103.979802-1-jic23@kernel.org> <20200722155103.979802-24-jic23@kernel.org>
In-Reply-To: <20200722155103.979802-24-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Jul 2020 23:54:29 +0300
Message-ID: <CAHp75Vc5UiY1pBvyS=rQ1RjhVcDGNYgkVhvB6UB4kvuNg0a5CA@mail.gmail.com>
Subject: Re: [PATCH v3 23/27] iio:adc:ti-ads124s08 Fix alignment and data leak issues.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Murphy <dmurphy@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 22, 2020 at 6:53 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving to a suitable structure in the iio_priv() data with alignment
> explicitly requested.  This data is allocated with kzalloc so no
> data can leak apart from previous readings.
>
> In this driver the timestamp can end up in various different locations
> depending on what other channels are enabled.  As a result, we don't
> use a structure to specify it's position as that would be missleading.

...

> +       /*
> +        * Used to correctly align data.
> +        * Ensure timestamp is naturally aligned.
> +        */
> +       u32 buffer[ADS124S08_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8);

u32 vs. u16?

-- 
With Best Regards,
Andy Shevchenko
