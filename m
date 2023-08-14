Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D6A77B8A7
	for <lists+linux-iio@lfdr.de>; Mon, 14 Aug 2023 14:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjHNMbl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 14 Aug 2023 08:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjHNMbk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Aug 2023 08:31:40 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3ECCC;
        Mon, 14 Aug 2023 05:31:38 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6bd3317144fso2236915a34.1;
        Mon, 14 Aug 2023 05:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692016298; x=1692621098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5zdjpAVvPJGjc8hmPe4HUkuvZrJLOWwDr8kFYWsTpU=;
        b=Q8qf5dqva8KmU5/ZP+8EG7HCuBALk6MDPXkKKJp5CWvLkcU9TgyxQI3TCSa6QqiWYp
         S2wcjQgOc9fiOGOOXZEsmbML2ul2LzGa8h3UdbXoDCKS+8+H49FmXNIKzLSFKLgRCLz7
         z1O8fX+4d44+GYHIyF8uRe24eYETGr0E5Sp5+km9cNH2cC+k54oZ109zEprB6Fjw6nb0
         R7LyKUL4JL3ws56g9eX4GV5KL42kfLgTs7A/O0jqcev3ub+cBWbxPJlK2hO0rSkTr9Au
         dmNUmTlSNbQZ1Ro17VjfYpMJ6gTzOeRhFci9cqPy/Tt8K2LcBGeaZEkBeQ55feiGjwPA
         KI8Q==
X-Gm-Message-State: AOJu0YzurgX6Ax1dF3o7aSKKz2LBaMsgC5nAqrUl0tnYvb+L0TyuYM6L
        pHb9Av4fNtSju1+s3/Y4q37IYRKj8mZNfQ==
X-Google-Smtp-Source: AGHT+IHKKjKJh2xdnKMtfNWeyuwL5Vj16WY4her4fyRi+RhTsfXi0i6sRbWlGKR3xVwQxsIpJ9aPkg==
X-Received: by 2002:a05:6870:d10c:b0:19f:9495:95ff with SMTP id e12-20020a056870d10c00b0019f949595ffmr10517035oac.27.1692016297864;
        Mon, 14 Aug 2023 05:31:37 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id r69-20020a0de848000000b00589a5bbeb43sm2728149ywe.117.2023.08.14.05.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 05:31:36 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d3d729a08e4so4220111276.3;
        Mon, 14 Aug 2023 05:31:36 -0700 (PDT)
X-Received: by 2002:a05:6902:4cf:b0:d43:e64f:bdcf with SMTP id
 v15-20020a05690204cf00b00d43e64fbdcfmr9165426ybs.0.1692016296002; Mon, 14 Aug
 2023 05:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230812083204.55346-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230812083204.55346-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Aug 2023 14:31:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXbrh2B8-=v8NqQ2M-4hHqm-eVcO49-0P9L+=MMLLXchg@mail.gmail.com>
Message-ID: <CAMuHMdXbrh2B8-=v8NqQ2M-4hHqm-eVcO49-0P9L+=MMLLXchg@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT] iio: imu: lsm6dsx: Use i2c_get_match_data()
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Biju,

On Sat, Aug 12, 2023 at 10:32 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Replace device_get_match_data() and id lookup for retrieving match data
> by i2c_get_match_data() by converting enum->pointer for data in the
> match table.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> index 911444ec57c0..a2def435c9c2 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -16,6 +16,30 @@
>
>  #include "st_lsm6dsx.h"
>
> +static const int lsm6ds3 = ST_LSM6DS3_ID;
> +static const int lsm6ds3h = ST_LSM6DS3H_ID;

As these are single values, not structures with multiple members,
I see not much value in adding all these variables, which increases
kernel size...

> @@ -23,12 +47,10 @@ static const struct regmap_config st_lsm6dsx_i2c_regmap_config = {
>
>  static int st_lsm6dsx_i2c_probe(struct i2c_client *client)
>  {
> -       int hw_id;
> +       const int *hw_id;
>         struct regmap *regmap;
>
> -       hw_id = (kernel_ulong_t)device_get_match_data(&client->dev);
> -       if (!hw_id)
> -               hw_id = i2c_client_get_device_id(client)->driver_data;
> +       hw_id = i2c_get_match_data(client);
>         if (!hw_id)
>                 return -EINVAL;

So just

    -        hw_id = (kernel_ulong_t)device_get_match_data(&client->dev);
    -       if (!hw_id)
    -               hw_id = i2c_client_get_device_id(client)->driver_data;
    +        hw_id = (kernel_ulong_t)i2c_get_match_data(client);

and be done with it?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
