Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3B0482249
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 06:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhLaFql (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Dec 2021 00:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhLaFql (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Dec 2021 00:46:41 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA70C061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:46:41 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id u8so31863699iol.5
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6UrwMi4B2In5zIIZdw3Z68EpyO2JkBjBC3luTVDDH9k=;
        b=W6BXkaqjITzhRIM0xEtgaivFCGoGedlUooIJO36S4W6+E4r/lQXMo2rFFcvOwQL1qJ
         ZPn0z9dcWZhWpxFYBpwyNvxSy3qbsV+u1lWRCD9BKESSh9dMMBFl5LGMx72lcyGNw0rw
         OGoRgd1BIgupj6VJMo8R4AUuj7O4QPrJTz7q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UrwMi4B2In5zIIZdw3Z68EpyO2JkBjBC3luTVDDH9k=;
        b=JHuP8oOaaySa3RtRlKDWnHjc9Q2nJBYXs3Lk2j4m8YWQ+AoiXIkGSpJXWQf31aTpBM
         d9vYMiKiQC5092EAuSg1kO6Pf8lti7LcGRghvt9N0PQI42gd3B5cUP5OA/BnEPL4HDAp
         UOK3H9H/KbynCj7csMb1Hn5HH2ph9qeItip0/SI6y3IK/CXF0irLEgABVi4rIIDzG0SI
         mYkUYec1njsbdLKQm9EdW0tHBIpIgazTaGcrsKheXNHkXgQ96U9JZ/gnApM2m+Oo82uW
         RU9O0IQyrrrcDdKeU0C6Ng7xPrIVvRpaBH0SwsXLGeBXyY+dSCJDGnuro8+gelkgTzhR
         tbsA==
X-Gm-Message-State: AOAM531f2yWTAi6txp5fEnx3vXPIJle7HUApBXlAVQCNlguakc9oNrOR
        A9tIqMoFWev5gmmS2BAbUSAsftF/lqZDqkIrmxkVIA==
X-Google-Smtp-Source: ABdhPJyD/cO0dtUFSivBM/jyxbJt9J18xFSW/SNVA9Vn4Uldzdyhnjo/RI43FyqXcp5gtEBFSpmGRQqipt4R5ck0wKE=
X-Received: by 2002:a6b:3b51:: with SMTP id i78mr15113569ioa.63.1640929600576;
 Thu, 30 Dec 2021 21:46:40 -0800 (PST)
MIME-Version: 1.0
References: <20211230174911.78291-1-jic23@kernel.org> <20211230174911.78291-4-jic23@kernel.org>
In-Reply-To: <20211230174911.78291-4-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 30 Dec 2021 21:46:28 -0800
Message-ID: <CAPUE2us0gTQ9BGrLCwpkL45cB04fGKc-GP3J3TPAktBGfgA7tg@mail.gmail.com>
Subject: Re: [PATCH 03/16] iio:light:vcnl4035: Trivial whitespace cleanup to
 add space before }
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Parthiban Nallathambi <pn@denx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 30, 2021 at 9:43 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Having a space after the { and not one before the } is inconsistent and
> I'd rather not have examples of this that get copied into new drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Parthiban Nallathambi <pn@denx.de>
> ---
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>  drivers/iio/light/vcnl4035.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index 0db306ee910e..da2bf622a67b 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -651,7 +651,7 @@ static const struct dev_pm_ops vcnl4035_pm_ops = {
>  };
>
>  static const struct i2c_device_id vcnl4035_id[] = {
> -       { "vcnl4035", 0},
> +       { "vcnl4035", 0 },
>         { }
>  };
>  MODULE_DEVICE_TABLE(i2c, vcnl4035_id);
> --
> 2.34.1
>
