Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162DE48224C
	for <lists+linux-iio@lfdr.de>; Fri, 31 Dec 2021 06:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhLaFsd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Dec 2021 00:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhLaFsd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Dec 2021 00:48:33 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADFFC061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:48:33 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id y70so31909969iof.2
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 21:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sOs2WNq6IcuOHM6dgUV/rcMfT63DDv+pmGVh5PYDi/g=;
        b=UbuYjpUH9I0lEmXs8IrdS4byTXUpij57n3JMXY+X5/V+adUN0HmrMiQQBViCKe/eC2
         aOAVqonzZfdN7/IvhKORYS756Up0peM3UW7+k1kcx8/+PIeaF+yjWSwBub9/0K1i2CSq
         gdjRiXcliZQi5p4T0j5Vi9lYbD50UN52kUoMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sOs2WNq6IcuOHM6dgUV/rcMfT63DDv+pmGVh5PYDi/g=;
        b=RRleDJ8uyyYj1cPDVAwCLp9SX3v3egx7A5MdJ8tf431UeIaxZgWB7bu+xJ5EAmPzO0
         MTA5HxyBz8ne6HFAv42QZs1Lupm19VA0X5FG3Ss/NdjZEltTsTH/5l9IP57mjasZvnM4
         PMTKXVzRYYKTX2Dgc7mdlOMtFHPLmFcCcSzdFCUBZQye5sRBdj157hztxqg3wt69MQmH
         FYfiIcAfGugISixG9i77fA/d8+ZNHLGKOdu9eOjR0MT7MIuLzw5nY9hUHpLN4cnz4q1u
         7w7l+wmYQ1aeVkvxtiUBCLF3o242mYfxGa0QwrpOtC+tbcpFiTC62U8g4ULmtKfUj4se
         EsEA==
X-Gm-Message-State: AOAM533X+yVQJBg7NviuYF5Ewpd27EYosoXHQTCzcDM4WGkJMYRxhbDb
        FW2sEenRoGuYXFgjZijTFH6whFaYMdBijHdZGRG69JBuC4UcWw==
X-Google-Smtp-Source: ABdhPJxmhJ/LSGvlMaioGQGEfFH63LdeBADGDtpPllU2DrSh0GdwZnjdUp4lfo4UNlOl/EQ9GFhqyFcEMouodmzHJes=
X-Received: by 2002:a02:c72e:: with SMTP id h14mr15727800jao.103.1640929712343;
 Thu, 30 Dec 2021 21:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20211230174911.78291-1-jic23@kernel.org> <20211230174911.78291-7-jic23@kernel.org>
In-Reply-To: <20211230174911.78291-7-jic23@kernel.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 30 Dec 2021 21:48:20 -0800
Message-ID: <CAPUE2uus4Kw5XXv0zHV3HoSBNGg_hmpbi7buZ9A=oyHYV7HWig@mail.gmail.com>
Subject: Re: [PATCH 06/16] iio:proximity:ping: White space cleanup of spacing
 around {} in id tables
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Klinger <ak@it-klinger.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 30, 2021 at 9:44 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The spacing in this driver was inconsistent so make sure we have a space
> after { and before } for the two id tables.
> Avoid providing examples of this inconsistency that get copied into new
> drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andreas Klinger <ak@it-klinger.de>
> ---
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>  drivers/iio/proximity/ping.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
> index 1283ac1c2e03..24a97d41e115 100644
> --- a/drivers/iio/proximity/ping.c
> +++ b/drivers/iio/proximity/ping.c
> @@ -267,8 +267,8 @@ static const struct iio_chan_spec ping_chan_spec[] = {
>  };
>
>  static const struct of_device_id of_ping_match[] = {
> -       { .compatible = "parallax,ping", .data = &pa_ping_cfg},
> -       { .compatible = "parallax,laserping", .data = &pa_laser_ping_cfg},
> +       { .compatible = "parallax,ping", .data = &pa_ping_cfg },
> +       { .compatible = "parallax,laserping", .data = &pa_laser_ping_cfg },
>         {},
>  };
>
> --
> 2.34.1
>
