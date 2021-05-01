Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1183D3708B8
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 21:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhEATNt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 15:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhEATNt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 May 2021 15:13:49 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC538C06174A
        for <linux-iio@vger.kernel.org>; Sat,  1 May 2021 12:12:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n16so606705plf.7
        for <linux-iio@vger.kernel.org>; Sat, 01 May 2021 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W4yP6llHgysA+UxqSW++aXvY11Cr/P1PcNUE4nmvGEs=;
        b=CF5Sq/lNcI72BnkaZswSFhPWuX/sB/94eOoZy2eFQLo+V0tVv4nbPn8Tc7IGqbJN0Y
         BsMpwm6vEbRpOe8cFAWkG12sI12jF/K1ZGbOmWXUf4X9GHy/xpnC3pQT59QJng+APU7f
         Rx+Jq2uOGzbhhI94NjhvpfoqhSELJDPiPCYO40XV1XtkPu3fF74saUzelGNEL68L5bbd
         Dw8C78g6LpFPJH0ARKhXsf9kne2Ns0Fqzow5oKtqXS8EjAughXxnogKfh0NrMmRU4jvT
         m/MoW2pxkvF7ibR8HY3BabBp10BdJkzRs7bHgHaRI5su92GCA58FO3q7WtYavFKEN78I
         Btpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W4yP6llHgysA+UxqSW++aXvY11Cr/P1PcNUE4nmvGEs=;
        b=Xz/YI+tHkElIWghjN0/ubDAzNagQpjSfVBQwWkvkpAO50FlDW1LEKdGdwFOb4bGl88
         rDuEJp662kP7vPs8v4+tIb5H5jFao35g4SAezwYQkzbAZy94meLSHXxCxjT5WJ65ZEQG
         mz7EFvaCvAtuTfATPHymmfleJi/+Q53xmZYf1No7HnwPm8DiqpcqemmRKSmo00LY1MQH
         izgc31UHYk1aXj64JMeEhJvjBsPg5CmD9RgDw/9j/pN/BNsSk7h30lzRF4DFUR2ZxAod
         xQxF9oKaVHrXBJVm3nmN4UMZlyHK/DboQtI9pSqEBYe4Qr85R4+sc8pkGPUWqmaoAiTH
         rirw==
X-Gm-Message-State: AOAM532p51viHHCk62r2AhQ3hvptdRw2KYVBacyP+obIo5GVjInHD3bu
        eA/L/vUCcAWUMxeqMNoiJ4ZT6QGv0jVAThUyH4k=
X-Google-Smtp-Source: ABdhPJyY5c+C2qvb7gYK6naOux8U+7dSh3vy2PRKjkYsaMGCNMje48455gYSSnvqzqnD9H3Q9X5T6GiZOmSm2vdvWoc=
X-Received: by 2002:a17:90a:d90c:: with SMTP id c12mr6948548pjv.129.1619896377300;
 Sat, 01 May 2021 12:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210501170121.512209-1-jic23@kernel.org>
In-Reply-To: <20210501170121.512209-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 1 May 2021 22:12:40 +0300
Message-ID: <CAHp75VdWmEHdn1iuA3xNHLMbhiapguEmrktGkf5vDFrPdy1XJA@mail.gmail.com>
Subject: Re: [PATCH 00/19] IIO: Alignment fixes part 2 - struct used to ensure alignment
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Andreas Klinger <ak@it-klinger.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 1, 2021 at 8:03 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> I finally got around to do a manual audit of all the calls to
> iio_push_to_buffers_with_timestamp() which has the somewhat odd requirements
> of:
> 1. 8 byte alignment of the provided buffer.
> 2. space for an 8 byte naturally aligned timestamp to be inserted at the
>    end.
>
> Unfortuantely there were rather a lot of these left, but time to bite the bullet

Unfortunately

> and clean them up.
>
> As discussed previous in
> https://lore.kernel.org/linux-iio/20200920112742.170751-1-jic23@kernel.org/
> it is not easy to fix the alignment issue without requiring a bounce buffer
> (see part 4 of the alignment fixes for a proposal for that where it is
> absolutely necessary).
>
> Part 2 is the simple cases where the timestamp position is always the same
> (as not more than 8 bytes of other scan elements) and where it is either
> in a structure that is kzalloc'd or there was already an explicit memset
> that would clear any holes in the structure (and hence avoid a potential
> kernel data leak).
>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

1

> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

2

One time is enough :-)

Anyway, I looked at them all and haven't seen any issues on the first glance, so
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> Cc: Sanchayan Maity <maitysanchayan@gmail.com>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Andreas Klinger <ak@it-klinger.de>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
>
> Jonathan Cameron (19):
>   iio: accel: bma180: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: accel: bma220: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: accel: hid: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: accel: kxcjk-1013: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: accel: mxc4005: Fix overread of data and alignment issue.
>   iio: accel: stk8312: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: accel: stk8ba50: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: adc: ti-ads1015: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: adc: vf610: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: gyro: bmg160: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: humidity: am2315: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: prox: srf08: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: prox: pulsed-light: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: prox: as3935: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: magn: hmc5843: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: magn: bmc150: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: light: isl29125: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: light: tcs3414: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>   iio: light: tcs3472: Fix buffer alignment in
>     iio_push_to_buffers_with_timestamp()
>
>  drivers/iio/accel/bma180.c                    | 10 +++++---
>  drivers/iio/accel/bma220_spi.c                | 10 +++++---
>  drivers/iio/accel/hid-sensor-accel-3d.c       | 13 ++++++----
>  drivers/iio/accel/kxcjk-1013.c                | 24 +++++++++++--------
>  drivers/iio/accel/mxc4005.c                   | 10 +++++---
>  drivers/iio/accel/stk8312.c                   | 12 ++++++----
>  drivers/iio/accel/stk8ba50.c                  | 17 +++++++------
>  drivers/iio/adc/ti-ads1015.c                  | 12 ++++++----
>  drivers/iio/adc/vf610_adc.c                   | 10 +++++---
>  drivers/iio/gyro/bmg160_core.c                | 10 +++++---
>  drivers/iio/humidity/am2315.c                 | 16 ++++++++-----
>  drivers/iio/light/isl29125.c                  | 10 +++++---
>  drivers/iio/light/tcs3414.c                   | 10 +++++---
>  drivers/iio/light/tcs3472.c                   | 10 +++++---
>  drivers/iio/magnetometer/bmc150_magn.c        | 11 +++++----
>  drivers/iio/magnetometer/hmc5843.h            |  8 +++++--
>  drivers/iio/magnetometer/hmc5843_core.c       |  4 ++--
>  drivers/iio/proximity/as3935.c                | 10 +++++---
>  .../iio/proximity/pulsedlight-lidar-lite-v2.c | 10 +++++---
>  drivers/iio/proximity/srf08.c                 | 14 +++++------
>  20 files changed, 148 insertions(+), 83 deletions(-)
>
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
