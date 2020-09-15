Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F2326ACD0
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgIOTAA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgIOS7t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 14:59:49 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B56C06174A
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 11:59:48 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r9so5342320ioa.2
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 11:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ny4aWWQBGTn4Ah+BS6tRk6kiqyKrRyMF3ugTT8cOAdI=;
        b=nvQ/6kdUin0PQd7TNT8dzn1cO0fCICC8+T7uEA2P9bh3FuJi+gugidwVm07dBAOxTw
         drmxS4egKVCdzQRvwAfpzzNBSz4IH9dZQi458oiaAqyFVopI/uR4ZlmQMgjYYhOYeFZd
         T+g8gWL0ZkqWyMVv98HogXMiQToqycVK+v+50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ny4aWWQBGTn4Ah+BS6tRk6kiqyKrRyMF3ugTT8cOAdI=;
        b=Hx6yTgQybZ3sETqgHzNbUgaK/L41mamTKqbAn6LQTxD1QztJmyM21RsuJgNitAmCWr
         AK9C3PPhxWI9uwQmDxS2Xjwd7lFmS+GyLCOnn/LPoxA+7cunddqgBOe10Gqh3lDqbxAw
         j4nOpKH+4/vZntKRVbYKKLsFFSW7qBiw1ZKMMyhEg+8HlvAifO119xSLPgyJxmaRwP2P
         kOgZftp1EK5zwU7NUQm4JPbKO8W52AYBZtr/gIlebzX2/pp7HUxIw+tHtLSCPSsnnJUU
         Bok4xamnorYC/XzVGsyhimjL6L0aEaRzydX0NGKARlZE3d8YB90ZfAFUDhwGjXE8aaGj
         tMJg==
X-Gm-Message-State: AOAM530L4p3hmGij0g8v52xXGkJpcdd4WA8V3tsE2igU1ocuv0g8JrbF
        VgxDV3cH4I5C2hVyCzToeny8OCj6FGVtu5oP4Wkoog==
X-Google-Smtp-Source: ABdhPJw0ymWgMBEzqevLmcHYkq3n/XLqyICM6o99TiE0fDaxv5wiwd+G/RgMdx+QbloIiLBpE06l2IKv84h9RtvoA1Y=
X-Received: by 2002:a05:6602:168a:: with SMTP id s10mr16051325iow.46.1600196388286;
 Tue, 15 Sep 2020 11:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200910173242.621168-1-jic23@kernel.org> <20200910173242.621168-17-jic23@kernel.org>
In-Reply-To: <20200910173242.621168-17-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 15 Sep 2020 11:59:37 -0700
Message-ID: <CAJCx=gkTwBwVQyTNcLwSq2YRzMQ38=TZ-ZcQL1pq1yA68=u=DA@mail.gmail.com>
Subject: Re: [PATCH 16/38] iio:potentiostat:lmp91000: Drop of_match_ptr and
 use generic fw accessors
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 10, 2020 at 10:35 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This change allows use of this driver with ACPI via PRP0001 and removes
> an example of an anti pattern I'm trying to remove from IIO.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/potentiostat/lmp91000.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index 67ae635a05f3..f34ca769dc20 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -11,7 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/delay.h>
> -#include <linux/of.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/regmap.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -205,13 +205,12 @@ static const struct iio_info lmp91000_info = {
>  static int lmp91000_read_config(struct lmp91000_data *data)
>  {
>         struct device *dev = data->dev;
> -       struct device_node *np = dev->of_node;
>         unsigned int reg, val;
>         int i, ret;
>
> -       ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
> +       ret = device_property_read_u32(dev, "ti,tia-gain-ohm", &val);
>         if (ret) {
> -               if (!of_property_read_bool(np, "ti,external-tia-resistor")) {
> +               if (!device_property_read_bool(dev, "ti,external-tia-resistor")) {
>                         dev_err(dev, "no ti,tia-gain-ohm defined and external resistor not specified\n");
>                         return ret;
>                 }
> @@ -232,7 +231,7 @@ static int lmp91000_read_config(struct lmp91000_data *data)
>                 return ret;
>         }
>
> -       ret = of_property_read_u32(np, "ti,rload-ohm", &val);
> +       ret = device_property_read_u32(dev, "ti,rload-ohm", &val);
>         if (ret) {
>                 val = 100;
>                 dev_info(dev, "no ti,rload-ohm defined, default to %d\n", val);
> @@ -422,7 +421,7 @@ MODULE_DEVICE_TABLE(i2c, lmp91000_id);
>  static struct i2c_driver lmp91000_driver = {
>         .driver = {
>                 .name = LMP91000_DRV_NAME,
> -               .of_match_table = of_match_ptr(lmp91000_of_match),
> +               .of_match_table = lmp91000_of_match,
>         },
>         .probe = lmp91000_probe,
>         .remove = lmp91000_remove,
> --
> 2.28.0
>
