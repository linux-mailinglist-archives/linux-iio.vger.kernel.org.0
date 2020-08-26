Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA21253452
	for <lists+linux-iio@lfdr.de>; Wed, 26 Aug 2020 18:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgHZQEL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Aug 2020 12:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgHZQEF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Aug 2020 12:04:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E380AC061574;
        Wed, 26 Aug 2020 09:04:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mt12so1091990pjb.4;
        Wed, 26 Aug 2020 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYnA2SCibgRU/WISqM1t5OcPtNJ/1IEgy+sMsxjqVJc=;
        b=Ro0RoIoFpw5yQk7ZvooJCT1WTUGt+wJ5SOxQ4f0Hz3xvWR0RlQ1z7jyCWeP7xkl/Ic
         q00Wx1MNqZP9XDzgLXaU+axSjPQtLSrVzHcgfK1VnVirdcVsMEjOagJAVtBG6I4+YaG7
         RuYWM/PGaRhBScXWkMIh7T9Uj4r49q+wyBx9JFJ7AYSSkjk7dIihmLN2A/6+uBobGbN0
         Gfqvc30Zxf6OwyzpId329jBAUbvOSZMMVOmCwRMvxpcC4UvrqI0TyEHwHY8f4Z7zU2Vq
         2qOWkwHkPhHZcsbJQREZFRFiQWCKOa/tFQP6T3XLIo0j1AHS0vRNEYMcz0lRvqZ7TbWy
         9HXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYnA2SCibgRU/WISqM1t5OcPtNJ/1IEgy+sMsxjqVJc=;
        b=bPpQ4zCR65ItC0VnoRpLkwt6+bkPXs3nwfD2XC1DMsGPOo6KtniUKaLExheqaLQtvt
         Y2KLIwOSwmICh8ImyiCrWHL3SJsGqxfdJYTqP0wsYz1PmGC3fh7hhvdQBN2Ve9cJOHrb
         KLmsFDcq/xWNWcAJdVY1s211qp6Qbt1dowfFIRvZyINQGv5lM0Sm4mkVyxH8pVZItjKH
         jbfOnDtqze4b7JGIMlsdUNAx3iFrThbsPcO74gdTW0fwBK2dcmy2yi2vKKd1zzxIeonx
         WCHfqmVcaulPRmmZ0lF+g2vX1tP35Mdmat37J4NUfrJ9wlet0XFAUgUMNGmJFv2RwnB6
         AzMw==
X-Gm-Message-State: AOAM532R34fDcXSNnKU3OsYVX06ZfB75sT9MZ1pdJvYZ87AZltWBxbmw
        R57RbIDJzVeZvmZfdbvC+dy+D9kPUat1PhY0Q5k=
X-Google-Smtp-Source: ABdhPJwddMhqWnxN6SgtsR1zQqgZSBxBX3NV/CXneRN/Ee/tMrxaF7NKqcX5ii/Sj9Izi1h8FF/iOg5M8g1U2crrIBE=
X-Received: by 2002:a17:90b:509:: with SMTP id r9mr6883860pjz.228.1598457843192;
 Wed, 26 Aug 2020 09:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200825101614.2462-1-william.sung@advantech.com.tw>
In-Reply-To: <20200825101614.2462-1-william.sung@advantech.com.tw>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Aug 2020 19:03:46 +0300
Message-ID: <CAHp75VceTBHJ1p3amCQ0PpDSEP8L5+Tf-Qro69+G1WZBrt2oDw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: dac: ad5593r: Dynamically set AD5593R channel modes
To:     William Sung <william.sung@advantech.com.tw>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AceLan Kao <acelan.kao@canonical.com>,
        Campion Kang <Campion.Kang@advantech.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 25, 2020 at 1:19 PM William Sung
<william.sung@advantech.com.tw> wrote:
>
> To use ad5593r more flexibly, we use the module parameter to setting the
> channel modes dynamically whenever the module probe up. Users can pass
> the channel modes to the module parameter for allocating the
> functionality of channels as desired.
>
> For example:
> * Use in the kernel command line:
> Users can add the module parameter in the kernel command line such as
>
>     "ad5593r.ch_mode=88001122"
>
> "88001122" means the channel mode setting for each channel. The most
> left side indicates the mode of channel 7, and the most right side
> indicates the mode of channel 0.
>
> * Use when manually probe the module:
> Similar to the kernel command line usage, users can enter
>
>     "modprobe ad5593r ch_mode=88001122"
>
> to start the ad5593r module with the desired channel mode setting.

> v2: Fix the patch description and remove redundant for loop

This should go after the cutter '---' line below.

> Signed-off-by: William Sung <william.sung@advantech.com.tw>
> ---

...

> +/* Parameters for dynamic channel mode setting */
> +static u8 update_channel_mode;
> +static u8 new_channel_modes[AD559XR_CHANNEL_NR];

Huh?! Global variables?!

...

> +static void ad5592r_set_def_channel_modes(struct ad5592r_state *st)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(st->channel_modes); i++)
> +               st->channel_modes[i] = new_channel_modes[i];
> +}

NIH of memcpy() ?

...

> +void ad5592r_update_default_channel_modes(u8 *new_modes)
> +{
> +       int idx = 0;
> +
> +       update_channel_mode = 1;
> +       for (idx = 0; idx < AD559XR_CHANNEL_NR; idx++)
> +               new_channel_modes[idx] = new_modes[idx];

> +

Redundant blank line.

> +}

Ditto (see memcpy() above).

> +EXPORT_SYMBOL_GPL(ad5592r_update_default_channel_modes);

What?!

...

> +/* Parameters for dynamic channel mode setting */
> +static char *ch_mode = "";
> +module_param(ch_mode, charp, 0400);

We have sysfs ABI, what's wrong with it?

...

> +static void ad5593r_check_new_channel_mode(void)
> +{
> +       char *new_mode = NULL, tmp[2];
> +       u8 new_ch_modes[AD559XR_CHANNEL_NR];

> +       int idx = 0;

Redundant assignment.
Also for new_mode.

> +

> +       if (strlen(ch_mode) != AD559XR_CHANNEL_NR)

This is interesting...

> +               return;
> +
> +       new_mode = ch_mode;
> +
> +       /* Check if all channel modes are valid */
> +       for (idx = 0; idx < AD559XR_CHANNEL_NR; idx++) {
> +               switch (new_mode[idx]) {
> +               case '0':
> +               case '1':
> +               case '2':
> +               case '3':
> +               case '8':
> +                       continue;
> +               default:
> +                       /* There is invalid mode exist, ignore the settings */

> +                       pr_err("%s: invalid(%c) in index(%d)\n",
> +                               __func__, new_mode[idx], idx);

Oh...

> +                       return;
> +               }
> +       }
> +
> +       /* Set the new modes to ad5592r-base driver to setup the new channel modes */
> +       memset(tmp, 0, 2);
> +       for (idx = 0; idx < AD559XR_CHANNEL_NR; idx++) {
> +               tmp[0] = new_mode[idx];

> +               if (kstrtou8(tmp, 10, &new_ch_modes[AD559XR_CHANNEL_NR - idx - 1])) {

Shadowing errors?

> +                       /* Something error when converting the string to integer */
> +                       /* Ignore this settings */

Wrong style of comment.

> +                       pr_err("%s: kstr error idx(%d)\n", __func__, idx);
> +                       return;
> +               }
> +       }
> +
> +       ad5592r_update_default_channel_modes(new_ch_modes);
> +}

-- 
With Best Regards,
Andy Shevchenko
