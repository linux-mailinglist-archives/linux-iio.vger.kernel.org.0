Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4528A19B17F
	for <lists+linux-iio@lfdr.de>; Wed,  1 Apr 2020 18:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbgDAQf2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Apr 2020 12:35:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36007 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388749AbgDAQf1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2020 12:35:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id n10so198199pff.3;
        Wed, 01 Apr 2020 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nv0PB7OQMBhmTUY0yfkOYmQ8lz6lTwWj9RPSvbAhmZg=;
        b=lneG3+bylYOe+VWYyx4URUoJhBOrtwSx6J84qh6JImO1KXK/y81BfpHS4Nk6jmrx6f
         FwQKNwiRF3ngj47XOZFQOlKHuobZfGkexsOKYMu7HCsMKMxgSTAtSQaoEAm4Gh9YxNEX
         GLYGo2iIEac6fJtC9JZJmUUYPwPBoI6ATPHgnT4YGLXqWydHtqaVR879GefrAbQ919Yc
         3FQgClxUMNncLsRQfiyCg5EyGg+5Npvbi7xzcXRdQ7tRjKxdTHLmsCn/1lIn44HWaUlF
         dNOgBL/Hg5vUKGc/7Ve/y8ao6GKTalXDk5WU2q6bJPMQ9PoC/wqQqj0wzfGWB8IujmLm
         +dXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nv0PB7OQMBhmTUY0yfkOYmQ8lz6lTwWj9RPSvbAhmZg=;
        b=Wc/Y7/PMd/bq/1DMeR7iS81uSq+B38hPcLIV0Ne9V6fNhVfn0XMlHFroP1aWVrGRLC
         /fPF+za3A1LadFrKbBLRKsoI4gcwlgkqRda7BMeot/fs0DeYKUS+HDiwg77Ln5kHWksj
         r6eRY9Afdx+vCtyq+E/0DyyjX3SHKS5LkOYh0k8VIdIZL7njwO3yHPN/GehN9lGSU8rY
         XxWesk4uJqMsj1inApwrJQ2IUtAN2kh+5oKdNReHaf/EIpB11wdBpi44xhLz9/OFgBly
         yeth6APBaXONaotyhDF8KbeIp5z7KJ1LRuj038TmIpXqYmStoqaRbsp/ouzu6nieFttf
         /JcQ==
X-Gm-Message-State: AGi0PuZHvsVup4LfqluyGZHeia6uu28491FAQQ5puog08m88VNCtm2ig
        DmoZYKD57DaaMJWaNDluQKg/btUFmrNN+KtxPrE=
X-Google-Smtp-Source: APiQypIYInYnpmxVEVR4+As3ewJkYDPICTo9pnPQ8lnEBYfZhcIldzFXAraLEALorMmUdTYnZ6YizL46WjW0pqghLyM=
X-Received: by 2002:a63:5859:: with SMTP id i25mr9501810pgm.74.1585758926434;
 Wed, 01 Apr 2020 09:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200401162416.24474-1-i.mikhaylov@yadro.com> <20200401162416.24474-3-i.mikhaylov@yadro.com>
In-Reply-To: <20200401162416.24474-3-i.mikhaylov@yadro.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Apr 2020 19:35:19 +0300
Message-ID: <CAHp75VcdDR-owtFuFMqNLFh_-L902fXODG14_6Dh416tTwjidA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: proximity: Add driver support for vcnl3020
 proximity sensor
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 1, 2020 at 7:24 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
>
> Proximity sensor driver based on light/vcnl4000.c code.
> For now supports only the single on-demand measurement.
>
> The VCNL3020 is a fully integrated proximity sensor. Fully
> integrated means that the infrared emitter is included in the
> package. It has 16-bit resolution. It includes a signal
> processing IC and features standard I2C communication
> interface. It features an interrupt function.

Thank you for an update, my comments below.

...

> +static int get_and_apply_property(struct vcnl3020_data *data, const char *prop,
> +                                 u32 reg)
> +{
> +       int rc;
> +       u32 val;
> +
> +       rc = device_property_read_u32(data->dev, prop, &val);
> +       if (rc)
> +               return 0;
> +
> +       rc = regmap_write(data->regmap, reg, val);
> +       if (rc)

> +               dev_err(data->dev, "Error (%d) setting property (%s)",
> +                       rc, prop);

This requires {} according to the coding style.

> +       return rc;
> +}

...

> +static int vcnl3020_probe(struct i2c_client *client)
> +{

> +       indio_dev->name = VCNL_DRV_NAME;

It's definitely not a driver name. You have to put part number here.

> +}

...

> +static struct i2c_driver vcnl3020_driver = {
> +       .driver = {

> +               .name   = VCNL_DRV_NAME,

Better to spell it explicitly.

> +               .of_match_table = vcnl3020_of_match,
> +       },
> +       .probe_new  = vcnl3020_probe,
> +};

-- 
With Best Regards,
Andy Shevchenko
