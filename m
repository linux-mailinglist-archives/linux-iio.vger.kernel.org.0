Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E73378AB9
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 14:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbhEJLvu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 07:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236381AbhEJLcF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 May 2021 07:32:05 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEABC061763
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 04:31:00 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n16so8976162plf.7
        for <linux-iio@vger.kernel.org>; Mon, 10 May 2021 04:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3b/6F9CpGbzA9+WzRuGGI/NtKD76xJz+j8B2eG+ekSo=;
        b=gqqqFu2bdD75d8hlon7fXMSS+inPAir7HBTOZLrMpBXDl/4XnT6HLvR1y5qOBbta17
         v5P7DCs7H67opw6dFn95WkEEXrpw5XdvwRuaEhai2jif87Xsbp+Og/vvHXGz8yQP3zN7
         w4DW8uUp9OJvFVzLyAZaSiI4Az8dd1sdOHnvw71Ge6YxU/+ctTed5qpR49sOShdneSCy
         CkHz/QDPmHSISGxJ37SlWMcGa2fY+vyi0KNZQOkPNhp+Avy2pIjWomXk7Dlh0D1+j1IQ
         /HzMiTvGEyE015khHNUbhpe9en/5gm9CgHS2wbePDEejM8bzcXIARiSZ0na9XP0jeLUI
         T19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3b/6F9CpGbzA9+WzRuGGI/NtKD76xJz+j8B2eG+ekSo=;
        b=n3Ke5Sv6jG+xsUkMAfUdcQhGmP5anZQIc170dMMaiWOcAQ5slyyZPTMqPpQIM6IDri
         oKba0ldWhNr+bQxLwFfUK/vHvf//U8gYtnMcswiza5tZExCdXokYQlK1B/b76T4GI2s0
         8ooB7Ly4UT0y/7uBRImADjgP3+4zmMajhTzwW5c6fNkjzVz1rUOc6udnIM/+AUEN7h50
         PQiU5pNIv6yqhlVEnWgxZiSlzM4jS6A0nJ5uxlkeLqfyjvtUbvaiZ6Ug54cJCp/t0Bz6
         ZfJk+ZgZ6C2rQzW+K8cx3Ha19MJDQgjwUve1wMXV3xm8iyv3joKLR6FVoyGPkYzmamvO
         qu2g==
X-Gm-Message-State: AOAM530OHTqV0Jx4XQCMLJWjvgYsy3mPolNbxkEu6e/I1oXRosxAOAzz
        pMhFa+V54I9yjvGHH6QZfqKxdbyO2jIuSGpgGc4=
X-Google-Smtp-Source: ABdhPJxpSlmjVxOBeHjCOK4Jmywj9n8PgwxoE716dtmNikgNXAtm4LYEoKn5FpQgihIb2wYuTxYZ3hrlOm3Df+wiKiM=
X-Received: by 2002:a17:90a:6587:: with SMTP id k7mr4477884pjj.86.1620646259543;
 Mon, 10 May 2021 04:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210509114118.660422-1-jic23@kernel.org>
In-Reply-To: <20210509114118.660422-1-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 10 May 2021 14:30:48 +0300
Message-ID: <CA+U=Dsp5T52yJ9rs1Ov4W9Lxs6mySGa9cndAiKMhEzh0K1-8oQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7192: Avoid disabling a clock that was never enabled.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 9, 2021 at 2:42 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Found by inspection.
>
> If the internal clock source is being used, the driver doesn't
> call clk_prepare_enable() and as such we should not call
> clk_disable_unprepare()
>
> Use the same condition to protect the disable path as is used
> on the enable one.  Note this will all get simplified when
> the driver moves over to a full devm_ flow, but that would make
> backporting the fix harder.
>
> Fix obviously predates move out of staging, but backporting will
> become more complex (and is unlikely to happen), hence that patch
> is given in the fixes tag.
>

This also looks like a conversion to devm_ would help.
But later.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Alexandru Tachici <alexandru.tachici@analog.com>
> Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
> ---
>  drivers/iio/adc/ad7192.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 2ed580521d81..d3be67aa0522 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -1014,7 +1014,9 @@ static int ad7192_probe(struct spi_device *spi)
>         return 0;
>
>  error_disable_clk:
> -       clk_disable_unprepare(st->mclk);
> +       if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
> +           st->clock_sel == AD7192_CLK_EXT_MCLK2)
> +               clk_disable_unprepare(st->mclk);
>  error_remove_trigger:
>         ad_sd_cleanup_buffer_and_trigger(indio_dev);
>  error_disable_dvdd:
> @@ -1031,7 +1033,9 @@ static int ad7192_remove(struct spi_device *spi)
>         struct ad7192_state *st = iio_priv(indio_dev);
>
>         iio_device_unregister(indio_dev);
> -       clk_disable_unprepare(st->mclk);
> +       if (st->clock_sel == AD7192_CLK_EXT_MCLK1_2 ||
> +           st->clock_sel == AD7192_CLK_EXT_MCLK2)
> +               clk_disable_unprepare(st->mclk);
>         ad_sd_cleanup_buffer_and_trigger(indio_dev);
>
>         regulator_disable(st->dvdd);
> --
> 2.31.1
>
