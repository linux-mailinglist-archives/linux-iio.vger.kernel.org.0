Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADFF48225A
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 06:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhLaFuf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Dec 2021 00:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhLaFuf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Dec 2021 00:50:35 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424EAC061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:50:35 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id p65so31920419iof.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kmXnaFJd/rsvzQgN6VjajdUReBMbJ0B3o+OJOguu8JM=;
        b=CadvysXXyohrszwgNnl2ih18Mhupx1bwEQIB4dy505qWHY68YlANwB8/VaZMt0oLiq
         rcl6EeqOhHOsaEK7l18wFDQbTO/VDoeqWeBTDLK5loxFN+PXOkaxnHgSN84KrVhaVshm
         JOqz2byJ0C4rt0+Tm4ysNRkRvJDAZSX8al2n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kmXnaFJd/rsvzQgN6VjajdUReBMbJ0B3o+OJOguu8JM=;
        b=a0WnU5n+2d2qxSRAVofjzFYBZf0artNJ3Ytb0i2l8cwfGR7TmNUlbZwQu1LdjQzhhB
         lNorgEWLUKXJuCsGBP+VgSF7bL+YPgSeyQ3MMtu2D0dNmr3A1V99tVDqd3vu25r669lh
         YozbollZTBYqGy1Z6IoRe1KP1f+iLIDaBL64nfnZu8cUnjyXhVoYo2kKsCzk0p6RPn3M
         nQnEQvES386s6RU6gJRkxy7BoyGvlDierb2P8nsq/6knfXF5lVduoh1QxaAui0Crpyv5
         nl6Emh6uJejDUjohAq/k8tjJp0F5oRgSX64cABukYGGOrMSJ6SP5BxtciKIkUNpBPelR
         f4QQ==
X-Gm-Message-State: AOAM532cnWOylPsKjvf2DvHQi+SeOrJaEvrA8VVlfqYLKhNEYfgqs5Pn
        5jRfjhMo1DhjIyACW1ExxTGnGiNZ32y2Xi+tCiFg0/RPLy65Xw==
X-Google-Smtp-Source: ABdhPJyWdMgjYN0J8T+ZoVBf+fPJgpCTgrHfspJpNyElCpzMzzDc4NOdp9kORNEONlQajyQAzwWlesB5gNReGz++Hcw=
X-Received: by 2002:a02:c72e:: with SMTP id h14mr15729963jao.103.1640929834680;
 Thu, 30 Dec 2021 21:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20211230174911.78291-1-jic23@kernel.org> <20211230174911.78291-15-jic23@kernel.org>
In-Reply-To: <20211230174911.78291-15-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 30 Dec 2021 21:50:23 -0800
Message-ID: <CAPUE2ut1vwj5bm8W3KnG8UatgRdGCKdfQy3Q=VWMLB3siWApSg@mail.gmail.com>
Subject: Re: [PATCH 14/16] iio:light:tsl2722: Fix inconsistent spacing before
 } in id table
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 30, 2021 at 9:44 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The final entry was missing a space. Tidy that up.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>  drivers/iio/light/tsl2772.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index d79205361dfa..729f14d9f2a4 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -1902,7 +1902,7 @@ static const struct i2c_device_id tsl2772_idtable[] = {
>         { "tmd2672", tmd2672 },
>         { "tsl2772", tsl2772 },
>         { "tmd2772", tmd2772 },
> -       { "apds9930", apds9930},
> +       { "apds9930", apds9930 },
>         {}
>  };
>
> --
> 2.34.1
>
