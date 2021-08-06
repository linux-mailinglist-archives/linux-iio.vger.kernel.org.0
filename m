Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094453E2D1A
	for <lists+linux-iio@lfdr.de>; Fri,  6 Aug 2021 17:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbhHFPEq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Aug 2021 11:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242357AbhHFPEq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Aug 2021 11:04:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83479C061798
        for <linux-iio@vger.kernel.org>; Fri,  6 Aug 2021 08:04:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id p21so13422573edi.9
        for <linux-iio@vger.kernel.org>; Fri, 06 Aug 2021 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hB2nIjh632OjMM+HCNWWBIFwzRxxUedWPIIoGwvPqnc=;
        b=dXs76HUlXUcFqWMeAcatgqCQwDDVZcGYH/7w6zI9ml10wCRZr7mADYbgY4oRtvwq2g
         //Wwt5rIQjt+VDZv5LxgkWmtSzEBkFhHs6jDwiyc9k7AK+8I/hGGXbNoaEL/fbkJnC3C
         yqgJYE6MmThIYP0TTQaW4LeemgOyjH8vD06fym8Tnftck55TR3lETGuNfEoYtJ/xRCXo
         K0ldqod2iyBfvyquA4dA9n6WIx3VsMXx8HJXWyq7xnkwJf7Z1drNbTopBbksuO4aQlIL
         rjv2/w/h327Z2RlOCdN4SU+bjZkQ7SCgKVOUr2OmCtbaGOVrMOrMuPNFbY9UZB6GwuZp
         BoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hB2nIjh632OjMM+HCNWWBIFwzRxxUedWPIIoGwvPqnc=;
        b=bq+clYNb2Jt87y46AbPLpdrZSu5oT2ynbvvqxCtLDo+xlpK3BxAJGMo489n/a79INp
         ArwvLzqHqZGSpu++KpEmUts0GW6dYLXXiKTeyi9yO5WoQNEzye1zrOh3WcC7QYtfG5bt
         sCdGMu2cWwwZg14aUl4g+xTu+/nu1OR0Y/wVsUX7NTrPL8JBOqpeHXrNUsM6DcrwInp+
         kjEKl/DTJbk7Qj9Zb3oYcMyDf19qhXtw6WYgkC+vKH0StOIQwCp8RpU/S5KOGfDX/lf8
         8svOvSNz1HTiP1sUurofgtVSpgKVDor31kK0n16t70E5M97p6N9Z75+MUY/OwfN+Kd9W
         KEsQ==
X-Gm-Message-State: AOAM532Pk2hLgUHSY8kZwwrH5JQv8Mimnerk3K2jmBnrF9fTAgHRb/pC
        BsLaRYLqcNDot2QlnWbZVdvygt0fymltokKMQpyI9g==
X-Google-Smtp-Source: ABdhPJyrB7Z4cLPe63IBfrz3BFw8VjJxAWK/ZN1xMtFRglWPFlzsxTgYPiZ3644eb4eExRRvEbOBc6EDEodxIKTJ5W0=
X-Received: by 2002:aa7:de98:: with SMTP id j24mr13830209edv.139.1628262268905;
 Fri, 06 Aug 2021 08:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210806130227.69473-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210806130227.69473-1-andriy.shevchenko@linux.intel.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 6 Aug 2021 08:04:18 -0700
Message-ID: <CABXOdTfXzdJE0Nye-rttp50cnTJy-nU9RcFxkONDo3hXvVWDUA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: cros_ec: Fix Kconfig dependency on CROS_EC_SENSORHUB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Jason M ." <jason@montleon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Trying again, text only this time. Sorry for the trouble.

On Fri, Aug 6, 2021 at 6:08 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When CONFIG_CROS_EC_SENSORHUB is set to m, the IIO_CROS_EC_SENSORS_CORE
> can't be built-in.
>
> Fixes: 53067471188c ("iio / platform: cros_ec: Add cros-ec-sensorhub driver")
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213979
> Reported-by: Jason M. <jason@montleon.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/common/cros_ec_sensors/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
> index fefad9572790..b0d67ceaed55 100644
> --- a/drivers/iio/common/cros_ec_sensors/Kconfig
> +++ b/drivers/iio/common/cros_ec_sensors/Kconfig
> @@ -4,7 +4,8 @@
>  #
>  config IIO_CROS_EC_SENSORS_CORE
>         tristate "ChromeOS EC Sensors Core"
> -       depends on SYSFS && CROS_EC_SENSORHUB
> +       depends on CROS_EC_SENSORHUB=y || (CROS_EC_SENSORHUB=m && m)
> +       depends on SYSFS

This seems wrong.  IIO_CROS_EC_SENSORS_CORE should already be limited to m
if CROS_EC_SENSORHUB=m.

Note that I can not reproduce the problem in the bugzilla entry,
neither with mainline
nor with v5.13.6. And the configuration file published there looks fine and
already has IIO_CROS_EC_SENSORS_CORE=m.

Guenter

>         select IIO_BUFFER
>         select IIO_TRIGGERED_BUFFER
>         help
> --
> 2.30.2
>
