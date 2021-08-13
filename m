Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857CE3EB3C4
	for <lists+linux-iio@lfdr.de>; Fri, 13 Aug 2021 12:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbhHMKEm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Aug 2021 06:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240037AbhHMKEb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Aug 2021 06:04:31 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C00C061756;
        Fri, 13 Aug 2021 03:04:04 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id a20so11294335plm.0;
        Fri, 13 Aug 2021 03:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHDDEXFDuvFgzelg5YEj3tZBkBln65N3PSUGMLuEUs0=;
        b=OJB6/jiAQWXyZ69kkqoODTuQQuiVaUmwa/Zr1r2yRdbLMglCODldkr6oUgvkwneStF
         ufmSVbfwnzMK+yRulbg8SDakhIWgrRTMktV8h30NZ7WLlofWi9H/pUZgC6dXpld8UnuL
         u47oIx+mjtKD0LttjqlKFbXYTn0dIGjBNOn4JDGLhtCy65lcemYSWSGh66Vaw5P89Qk2
         Qz5tHq6LmfbWEv/2lqG2t3xa31MIMmmjGkhtvasxsn0n2QuoLm62Q/K5CzT7fyzfioEy
         nbPHxnWsJxSUzTxamSobtE0k8rzlNVK97JCO9xFUaw8gTEguL0LtlRtJ2xjcUqmsQF8q
         CClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHDDEXFDuvFgzelg5YEj3tZBkBln65N3PSUGMLuEUs0=;
        b=eoC1fuTw/4EUW+K23pOlwdsj+SWBJ/puK6YXcobypEpqiPNM+sbgI7yFm/UpRjz2X6
         ulaC6rYoOehXnoR4A9CoWuJSLbAOvErp+L1un2ZONjyr8FAq0OAJLId7b2f3BtbcijPH
         BC3k/tGbZCLdRKhlT3HFdbwqBsrJcVLRQu5lMdKK68tLD5Bt3pO91Ig1/11CKfTP+wPZ
         xDfoTEq/b7p4GDTb+MEyMoooz4hOSFIq7hsLaOe+t/DhSH2QUUIgt1mGifMBtQFCB7nG
         yQCApRMJGYPAw7NxRbt9Xzzmu6LxTY3HJqL27XcOaBeUPIYykovf9FMFZgScpQlHFz2Y
         3vtg==
X-Gm-Message-State: AOAM531+Ka4HrME/TVn0v/wUEGq5E5UPnxnczlDhT/syCU8a+bp4jkrc
        7mw6kiOhNTIQFdvPpcNP2oHjYJkq8Wt4j3Y9ADM=
X-Google-Smtp-Source: ABdhPJwyx20o7xFa7iXigi8x85KBmrfugMexJQIQue9+gbQrwJVXrrYLo7B0h3it1DBQDkAnnJh4tirtgweXFHcsAS0=
X-Received: by 2002:aa7:860e:0:b029:3bd:7e49:7a14 with SMTP id
 p14-20020aa7860e0000b02903bd7e497a14mr1804807pfn.40.1628849044422; Fri, 13
 Aug 2021 03:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210813083455.252986-1-puranjay12@gmail.com>
In-Reply-To: <20210813083455.252986-1-puranjay12@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 13 Aug 2021 13:03:25 +0300
Message-ID: <CAHp75VfK3BwVBSQu-A03aiWoapXb1Eo+NhThnKLPp=WA15365Q@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: adxl355: Add triggered buffer support
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Darius <Darius.Berghe@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 13, 2021 at 11:35 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> Provide a way for continuous data capture by setting up buffer support. The
> data ready signal exposed at the DRDY pin of the ADXL355 is exploited as
> a hardware interrupt which triggers to fill the buffer.

...

>   *
>   * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adxl354_adxl355.pdf
>   */
> -

Unrelated change.

...

> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>

I would rather regroup this like

linux/*

asm/*

linux/iio*

...

> +#include <linux/of_irq.h>

Okay, this is due to the absence of generic fwnode_irq_get_byname() or so.

...

>  struct adxl355_data {

> +       int irq;

Depending on container_of and frequency of usage this is not a good
location for this.
Strating from regmap pointer is much better (no pointer arithmetics involved).

>         struct regmap *regmap;
>         struct device *dev;
>         struct mutex lock; /* lock to protect op_mode */

>  };

...

> +       ret = regmap_bulk_read(data->regmap, ADXL355_XDATA3_REG,
> +                              &data->buffer.buf[1],
> +                              3);

ARRAY_SIZE()? Or put this 3 to the previous line, it will be easier to read.

Ditto for the rest of the similar code.

> +       if (ret)
> +               goto out_unlock_notify;

...

> +       /*
> +        * Would be good to move it to the generic version.

Something like "TODO: Would be..." ?

> +        */
> +       ret = of_irq_get_byname(dev->of_node, "DRDY");
> +       if (ret > 0)
> +               data->irq = ret;

-- 
With Best Regards,
Andy Shevchenko
