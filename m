Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DAF333149
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 22:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCIVvb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 16:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhCIVvI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 16:51:08 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EED6C06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 13:51:08 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id s1so13566066ilh.12
        for <linux-iio@vger.kernel.org>; Tue, 09 Mar 2021 13:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hzfFvBfh23xH5Nszua//FuwPMAjrRLub85MIlCmec0c=;
        b=Vn+71foxJkhw+gTRxV7MaccRI5peYl1VtJYu+1nx2o9MPZ+8lH3RS1XANtL7zF7hSP
         gZALQIho2/umY2zpR81zrIUCSJMGIRNHOVQnNeSRKpxoU6tWeMzvUCtSmp/GDmC+oju0
         M4WYQN96owcx2YzLtLKhlt+IC3VhjUnUuq9v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hzfFvBfh23xH5Nszua//FuwPMAjrRLub85MIlCmec0c=;
        b=Tyk+4MK0cEbCfhSlmhBuLL8VUBQhUslkNAqg3VY0w7saAfUf0vkSSkyA0j1mQzLzcg
         el+0EXHsNARoZVyZjY4wDkkJCZcHLLRiuFxt8nioBkdhfg1RLTfSfyZJNcFBbGxSfqSl
         zR+0/J0ZIIBKC+50P3OQfzAZZKl9ZLI1lvZcFUpAtZKswIw0c2kXWkjXJF32vdlkCpI4
         6Jv/5QmnokjB96Y9hK85S8OGx5OPLTz++eKFZEhE3lIx7xUTC0DSVq5CpKmttH7MMzi3
         nfBZrYmWCPmru4chH0WX45nYQcvltgox6mkaQ2yGOtcKCkRLNQdDrj4WQXnIDgF4dVzJ
         gg0g==
X-Gm-Message-State: AOAM533wfpYflL/PR99LfsS0tzFjsnN6Xeo0Hgz7+y3Vz16/+5ArkPL5
        ie1k0x7F9jpjcsfl+R3Mdwa6yRnbYFD/EJgpTSnHdw==
X-Google-Smtp-Source: ABdhPJyKXdcMNdr2guFrjn3x+lzhn1TO1TplXDjbuB8H69znrc5PlCgV+TJiLtZhHu4cTCBNb0Gu1v6xA9pfesMKlBs=
X-Received: by 2002:a05:6e02:18ca:: with SMTP id s10mr212732ilu.286.1615326667879;
 Tue, 09 Mar 2021 13:51:07 -0800 (PST)
MIME-Version: 1.0
References: <20210309193620.2176163-1-gwendal@chromium.org> <20210309193620.2176163-7-gwendal@chromium.org>
In-Reply-To: <20210309193620.2176163-7-gwendal@chromium.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 9 Mar 2021 13:50:56 -0800
Message-ID: <CAJCx=gkwZHOriMozVmk7GZYN8x4qvgOq2b16Pu_p9fNx8cT2Nw@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] iio: chemical: atlas: Remove code to set trigger parent
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ardeleanalex@gmail.com,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 9, 2021 at 11:37 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> iio_trigger_set_drvdata() sets the trigger device parent to first
> argument of viio_trigger_alloc(), no need to do it again in the driver
> code.
>
> Given we call devm_iio_trigger_alloc() and devm_iio_device_alloc() with
> &client->dev as parent, we do not have to set data->trig->dev.parent to
> indio_dev->dev.parent anymore.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
> Changes in v4:
> Improve commit message.
>
> No changes in v3.
>
>  drivers/iio/chemical/atlas-sensor.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index cdab9d04dedd0..56ba6c82b501f 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -649,7 +649,6 @@ static int atlas_probe(struct i2c_client *client,
>         data->client = client;
>         data->trig = trig;
>         data->chip = chip;
> -       trig->dev.parent = indio_dev->dev.parent;
>         trig->ops = &atlas_interrupt_trigger_ops;
>         iio_trigger_set_drvdata(trig, indio_dev);
>
> --
> 2.30.1.766.gb4fecdf3b7-goog
>
