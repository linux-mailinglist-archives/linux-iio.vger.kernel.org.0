Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E034E2344
	for <lists+linux-iio@lfdr.de>; Mon, 21 Mar 2022 10:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345864AbiCUJ0u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Mar 2022 05:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345861AbiCUJ0u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2022 05:26:50 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877CF4F476
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 02:25:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bg10so28543231ejb.4
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 02:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S11wx+N1rIuHT+Od55CkLZgi6YqeDrAy/vUOwAAT5hU=;
        b=D9ff2TwFEjq1TwvVJ8noCBO1nGdOaKyiIobriKbBiRpP2DjuI4hKhBHmoS3DdizFdn
         7VxLi0QNWXjzBFaXkj0Jr2xL5WOe9CdSSTS3N3IYAUuHGBW4bbVcbbWm5m47bOyyZrMB
         jzkffZBldtv9g0W7yl6W0w7u8lGoLBwH/QcIEFZPygWTMydNVsHn8+B1ULfWbydqH+vw
         4fYwlupT3JsWxGjFgQFe1hnDU1ybL70FiwKZJOC1OttzzTV11fDUGS17r9we8fCwbb0t
         xpZVv7gXLtGh+c7XaIedMNEnBT+bupiZ4scBX/R6F+XaS4FiPjX4BRjA6g9d+iYEGpt0
         +hVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S11wx+N1rIuHT+Od55CkLZgi6YqeDrAy/vUOwAAT5hU=;
        b=f43TECI7SamvEDJtoQcBa6X628FJxxxj4AIbh0Iv3zbjRyBMe6bC1Hz15fWJXhyVSR
         dnEixGyU46Wi+f6QySZHvEN4LA4GnBohd6u5S7goDPHGMqgVhB9T4dq3bEyr10BSGTNH
         dDKsYjpv9kM7zAVadgggFqta6HqYAwQw1WUYT6aJs8uyA8mXOAy7QMQpV1YzupOKeZVj
         3Dbld4F7ecEiD0gDIX8hT+TD/YE+1kJV96urGxRQ4EGEGwxz0VkOBvW5V7DJbce+nzWH
         WbWkjtJH/o6lvUyNahhHz88jcq0D1OY0lMtpMqYrCsc0VaAYaKAA1d532+ZM6Zsas23a
         QrsA==
X-Gm-Message-State: AOAM533FkZYXN53genOp8up1mB9Dr/IbMjG74gBA+TctSDrzRJZZ+/zO
        8oTzPwgeTXrV/w0qB48E7jedlur2Ji54YNYlU3w=
X-Google-Smtp-Source: ABdhPJxqMY7iOMLtGg58oEst9dGNBiH3qJB1teYz7kBE59CpbAmcoFxvEnlI+mdvUgVzb5msbC0g6W6dGyZFMg74R8o=
X-Received: by 2002:a17:907:9703:b0:6da:6412:508a with SMTP id
 jg3-20020a170907970300b006da6412508amr20159445ejc.77.1647854723057; Mon, 21
 Mar 2022 02:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220320181428.168109-1-marex@denx.de> <20220320181428.168109-8-marex@denx.de>
In-Reply-To: <20220320181428.168109-8-marex@denx.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Mar 2022 11:24:12 +0200
Message-ID: <CAHp75VerZC8CdT9uzEierPMtkaoMSE7KWAXfoOwFuEj5Ks=c-w@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] iio: adc: ti-ads1015: Convert to OF match data
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 20, 2022 at 8:14 PM Marek Vasut <marex@denx.de> wrote:
>
> Replace chip type enumeration in match data with pointer to static constant
> structure which contain all the different chip properties in one place, and

contains

> then replace handling of chip type in probe() with simple copy of fields in
> the new match data structure into struct iio_dev.
>
> This reduces code and increases static data.

I like this change! My comments below.

...

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>

If you use mine @kernel.org address it will be enough and reduces a
lot of noise in the commit messages.

> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>

...

> +       chip = (const struct ads1015_chip_data *)
> +               device_get_match_data(&client->dev);

Redundant casting. After dropping it it will become one line.

> +       if (!chip)
> +               chip = (const struct ads1015_chip_data *)id->driver_data;

> +       if (!chip) {
> +               dev_err(&client->dev, "Unknown chip\n");
> +               return -EINVAL;

return dev_err_probe(...);

> +       }

-- 
With Best Regards,
Andy Shevchenko
