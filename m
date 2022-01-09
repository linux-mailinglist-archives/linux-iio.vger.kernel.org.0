Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97DC488958
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jan 2022 13:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbiAIM0N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Jan 2022 07:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiAIM0N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jan 2022 07:26:13 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E5DC06173F
        for <linux-iio@vger.kernel.org>; Sun,  9 Jan 2022 04:26:13 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b7so13167280edj.9
        for <linux-iio@vger.kernel.org>; Sun, 09 Jan 2022 04:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Wbjgj0yvx5QKddX/zJ9nMORB1COgHbIx3ukibVc6+M=;
        b=JdlJvTkhz0X+xW2ZG7LvjKJyKY/nF78pygUY9tQDUiTshLmw5PEr1vXPOC1mEZTbi/
         c4om7xRU1l+I7g6D7jC5cPWPz/DjQJgrRvW5F3zrRlb/YA/2Qll6/8CHSmAzIRumCFgI
         93zBRoD6I3ObNZhwYD+Sz+FJQhQyw0GC1kiAzfXSB7tVKZ5JHUry54kYD3SAxLvbw2Dk
         ZtQ2bJGRvWLeGIASP7I5jpT09tWzLYz1wtJAQbgwLYEsOHU5L4dyjA7oJZEB4ofAWlws
         pkFjfEqkbPWHlJ5GWuuU9Y+HOisBw+KDYWHmZ80f1bllp8W7z9Hj3asksWrU0+Bu8707
         zZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Wbjgj0yvx5QKddX/zJ9nMORB1COgHbIx3ukibVc6+M=;
        b=YH7jCPvNQOyl2kq7AU1PJ/5OVZm5E5T7uV3nJ+HVZCEKm/1Ne09ZRqzDLgFIBJLJc/
         59TJ8EpIWHH9eJMleLE93Ewma7iCkHRFbjKVpWXPRLHjXY0GCNhPEiIy71CR0lxjFqdq
         +60OIIRGI7DEhuXNhvk3tSiHxJsxP53+pReewt26okrCv7QwmolJr3HvxyQsYbhsenFG
         K5hAJybhz6igtY2HlvC/9dAUvKIzQdCrKD5jquNVEsaJ3Xu/SkiJi+Th+kPtx4j1ittN
         bTxPA6UlCLLxNiyBNv7VPB4CdQ6J8lC/PmrtZbcdwoxN8fbC7PFbSveiJEo3MAURdrTM
         GZkw==
X-Gm-Message-State: AOAM532U5TROPL9Zo6AxI/hrCEaWlBiu9o8I5zoJpqGRf2P0O+lV4DKI
        lc/ZoBWTqn2H1qm10PVw3JMjkIRz8Ye+zTuVLpI=
X-Google-Smtp-Source: ABdhPJzKzGmWA/CFB6dtpTkj7LL2gIpVbxswBuVD0/OyPOnmwfSlcUWPJ1SGHzhUyz5/DDP83W+0+x8r58OfDtZI6vE=
X-Received: by 2002:aa7:d9c9:: with SMTP id v9mr12489642eds.270.1641731171508;
 Sun, 09 Jan 2022 04:26:11 -0800 (PST)
MIME-Version: 1.0
References: <20220101203817.290512-1-gwendal@chromium.org> <20220101203817.290512-4-gwendal@chromium.org>
In-Reply-To: <20220101203817.290512-4-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 9 Jan 2022 14:25:35 +0200
Message-ID: <CAHp75Ve5OjpdSs3DLvV8PORZMmEz5H+nA=c2Zior-wMTWj0A3w@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] iio: proximity: Add SX9324 support
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 2, 2022 at 6:28 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Semtech SAR sensor SX9324 is an evolution of the SX9310:
> It has 4 phases that can be configure to capture and process data

configured

> from any of 3 CS pins and provide independent detection:
> proximity, table proximity or body proximity.

...

> +static const struct acpi_device_id sx9324_acpi_match[] = {
> +       { "STH9324", SX9324_WHOAMI_VALUE },

So I believe this one is allocated by SEMTECH. Can you confirm?

> +       { }
> +};

...

> +static const struct i2c_device_id sx9324_id[] = {
> +       {"sx9324", SX9324_WHOAMI_VALUE },

Missed space.

> +       { }
> +};

-- 
With Best Regards,
Andy Shevchenko
