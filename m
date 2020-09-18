Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FFD2704B9
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 21:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgIRTKr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Sep 2020 15:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRTKr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Sep 2020 15:10:47 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5882C0613CE
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2020 12:10:45 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y13so8093440iow.4
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2020 12:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j4dR6O2D6vTEUov1AWmf43i6wTcvv1KI8V8tBpPm/5k=;
        b=dNwq4/OgX9nGGt/Ri7A+fAWkE+SUNCoGKxB8QUgPT7eM22dWk4qipzfFNtWRPMxQmr
         cwhsXWtrKp+8C6RmdoKwORLnjobNcXoyFtFQ+8kMGbXhCqcQwF0k5ok5XdvVRjL4d7rj
         0E6c9HaRZufdgeMThuhQxQ+umBD1PrYdvdu8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j4dR6O2D6vTEUov1AWmf43i6wTcvv1KI8V8tBpPm/5k=;
        b=ZJwfwtyYY9JbWzYC6ONqeNotYz8Yprtpzj3ZsGNB5okFUXuSXcmPvlX5OVdOOtHfNG
         jn+ngB0jqwweEzbwuVSw1RLka3TdbT4mY4tDeytTMlO6xMkUYxbiBLRLTvFX6cMmWhEq
         FEUHcwDhZlDYr20xE7p+smwVrsY6iWsx3Q3Pnt/fe1Q+wnmYlmWyD4PKS50fY2uyq539
         EIaMGJdVqJm0SPfqkXjWU785C19l7WVdvTAcD2y0rkZJmROlPtZ1PEWsnWcgW7vDxpmb
         GbuYteEeT/tJ5NJhMTHsAYlbUmWpxGjXu7jRlyaj8VbpUt47ffDEoY9c7dd0R97n9Xnm
         K8/Q==
X-Gm-Message-State: AOAM532NdLT1b8rbLU/qlQF6rerpPCKEQ/mOqkB1mYzlwQVqeEWUuT27
        +lGAmD7YPqkDxRL5BwqfA84h14tYJpiGqvgdjSHyWA==
X-Google-Smtp-Source: ABdhPJx7NB2h1onpwZcyeZooK++DfEqitnFO0ytliL0zZ8ful/H07V5UA/5xCmSxlWjGqjFE65wiwvmzIjzt7yDStPo=
X-Received: by 2002:a5e:9b0e:: with SMTP id j14mr28677404iok.112.1600456243547;
 Fri, 18 Sep 2020 12:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200913121227.764626-1-jic23@kernel.org>
In-Reply-To: <20200913121227.764626-1-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Fri, 18 Sep 2020 12:10:32 -0700
Message-ID: <CAJCx=gmGaOfRjB_uQuWzHqS3WBDvr7T+rLCk=dvHGMFFFjD96w@mail.gmail.com>
Subject: Re: [PATCH] iio:accel:bma180: Fix use of true when should be
 iio_shared_by enum
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 13, 2020 at 5:12 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Given a value of 1 corresponds to IIO_SHARE_BY_TYPE I have replaced
> it with that.  Should cause no functional change.
>

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  drivers/iio/accel/bma180.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 448faed001fd..6b74c2b04c15 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -673,7 +673,7 @@ static const struct iio_chan_spec_ext_info bma023_ext_info[] = {
>  };
>
>  static const struct iio_chan_spec_ext_info bma180_ext_info[] = {
> -       IIO_ENUM("power_mode", true, &bma180_power_mode_enum),
> +       IIO_ENUM("power_mode", IIO_SHARED_BY_TYPE, &bma180_power_mode_enum),
>         IIO_ENUM_AVAILABLE("power_mode", &bma180_power_mode_enum),
>         IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma180_accel_get_mount_matrix),
>         { }
> --
> 2.28.0
>
