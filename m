Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0FF77AB13
	for <lists+linux-iio@lfdr.de>; Sun, 13 Aug 2023 22:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjHMUJo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Aug 2023 16:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHMUJo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Aug 2023 16:09:44 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC5D10F6;
        Sun, 13 Aug 2023 13:09:46 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-56dd683e9b3so1819631eaf.3;
        Sun, 13 Aug 2023 13:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691957385; x=1692562185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4eOur7xzUuWE1jLJtLsCuNeMunUTcybCDDE4uH7wPE=;
        b=F4fZtLp2rX8V+DZ5Q18M4FanFhhdkVnIIgE8R1kOx30e5EhQSkQuUn66uasA58yxXs
         xAf6sgVpuTdiNFXgEAQHfW1uADZSCR4VQUQIc4H7tTrBe4CbQ2/bX+M+fvRJyk1XkkRz
         euWnVvQAL4YXewO95AOA1MWuKi6iybUqZQNKc5KPBN/pwTn+I/m13n8TxZFybe4Vk3pW
         EcAAyF9CFtZx7lmazxd0VeLEbjg0/tc2TMCJzimI/zu2neCSXgsCQ0yxZuwXuVHH2Xj0
         A9jcDqAO/MYSZM2YvqNAQBk81Taw7TzefNlApD6zZp/oSU2eVVCfqVcT1IUAmycw4TZt
         LY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691957385; x=1692562185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4eOur7xzUuWE1jLJtLsCuNeMunUTcybCDDE4uH7wPE=;
        b=Gl4zmjjDJFC7/FzdRZfaRgRuPaedq9VVzGlTotEQDycV175f8/Z8N3ljqn46Urgd9F
         IkCCJ7GKcZCiT21SYiLqNqjEAHgirzWJkwEvTwU9DfA573Le+KhxqNB6ddIFoFIuCgzY
         Wxx3efgZm9fxc6gmqhy4An58TiEFZHLmSd4tA6wEOOVpbaPCvr93t+TW7kIBUGRaTWR9
         qVbD9gcS7nMLyZYtRSJIYLvAE46p4r2LDyW//p7ggjDkoPKg2/lm9cXgomqB/E9ocjKH
         ViXcdgMRwsg5iwoBRSM1upYACalkBFNNRsA3yDP7pa3XNoHlPIEzf3L+wbqX4CT+yDIk
         VO6Q==
X-Gm-Message-State: AOJu0YxQa4vTvrfRze66YvEp6WbCoRe9SdGaR0OXe1TPpY3zafq4X7+P
        UbAQI58HEBY6xutNBYIenG5hVle0Cb/v69sG1I8=
X-Google-Smtp-Source: AGHT+IFhYQwsIunEs4kvDBkTWiY+u+owL0/TySFP72Y3YDJIr/NrLd62w0jMl3nTiMeraZ8rjD7tS0T3okiouNSVQjU=
X-Received: by 2002:a4a:2a19:0:b0:56c:c061:a9a8 with SMTP id
 k25-20020a4a2a19000000b0056cc061a9a8mr3792658oof.0.1691957385391; Sun, 13 Aug
 2023 13:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230812130130.123243-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230812130130.123243-1-biju.das.jz@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 13 Aug 2023 23:09:09 +0300
Message-ID: <CAHp75VfqGB1OYLGjK6MRPtPCkaFeY=c13RSEXrDH9eC5W9vjmw@mail.gmail.com>
Subject: Re: [PATCH] iio: proximity: sx9310: Convert enum->pointer for match
 data table
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 12, 2023 at 4:01=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Convert enum->pointer for data in match data table, so that
> device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> bus type match support added to it.
>
> Add struct sx931x_info and replace enum->sx931x_info in the match table
> and simplify sx9310_check_whoami().

...

> +       ddata =3D device_get_match_data(dev);
> +       if (ddata->whoami !=3D whoami)
>                 return -EINVAL;

-ENODEV looks better.

...

> +static const struct sx931x_info sx9310_info =3D {
> +       .name =3D "sx9310",
> +       .whoami =3D SX9310_WHOAMI_VALUE

Keep trailing comma.

> +};
> +
> +static const struct sx931x_info sx9311_info =3D {
> +       .name =3D "sx9311",
> +       .whoami =3D SX9311_WHOAMI_VALUE

Ditto.

> +};

...

Otherwise looks good to me
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
