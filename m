Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C066F77AEA1
	for <lists+linux-iio@lfdr.de>; Mon, 14 Aug 2023 00:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjHMWxS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Aug 2023 18:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjHMWxC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Aug 2023 18:53:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AC593
        for <linux-iio@vger.kernel.org>; Sun, 13 Aug 2023 15:45:02 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4ff72830927so809923e87.3
        for <linux-iio@vger.kernel.org>; Sun, 13 Aug 2023 15:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1691966700; x=1692571500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eNNWcc82/wmdMGHxAJ5w6sLQEhv4REH7B6W6mtmcsh4=;
        b=UxQmDcrIJ7oHBla6GDIGa/UBD0PUnuAOWTYHUyFHHRP9bdStKWovWTdU7bpjr3Nal0
         PxjrX4bPZw3tfm6zB0yFTPrftLr5cVUifEGQNB4uyfCQ3RPvmxNeXpq17SQXVVSctTFs
         jYWAj+h+PSUyGo2i4BlKUcJc+ylfHAaD72h2FJHIobuh+TC/As7XYKZp/yyAkh5wW/ab
         mSm83HXg+CQcAfgHxvQd7T8ohRAQ2VndvVoZ58AbJvKVp5YiTYc+YmbC1TVXmLZXnTBT
         HceqkQXCBd5PmFuy2VoZ6PmvI96lI3fNLh+IV8uQb0oKn+cR/n77c+/UN/OqG+64MneD
         MShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691966700; x=1692571500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNNWcc82/wmdMGHxAJ5w6sLQEhv4REH7B6W6mtmcsh4=;
        b=JvNMYztZXxRdRR7eXCywbvUA8qPn8aK9Yr2r+UQcjdylkT76M4dgTgf9vUV50ZoWQ6
         Hj/R8nkZXL2kPP6Tw2GWDwO7aqTiEQie4n4IULtdVfIo//vh7XJ/mrGkSg+ZuC+pljBZ
         I7bKM0zPBKsbnLjuB7NZoDNczDrNMNt6bS0EgI5HP7B4ybj34TMdUhbpIT0+AEoGW1wv
         w/nTw/6Af1sRuBsTwOb1Z/YdEkuhOAsugxCwsmZWAigBFeogNIszDBJksUoxixAk/BzY
         5w9REX4Eg6O/zj558zGMi9OdEoGaxePzfc+aUk1O8/C9DFDs7zFNciCA8ek2rIcvX7OQ
         ybbg==
X-Gm-Message-State: AOJu0YyLI9SDfkJ2h8cweEZrRl1MeCLOp3m2XF7Jh2l1Cf4WgD2RvqIP
        DExsDi+oOn/TZyAaJZmpKSpGh9tTMilQrbfA1074uYMQTdXR0X3Lw6Y=
X-Google-Smtp-Source: AGHT+IE0UxoTPUYWQSaYOJ1tLhZrX8DCyi+5KunTxPeUraeigwoLkr6v82QoV3kf3vL5i7pjRT6iE2SFP2Xwe+11lfw=
X-Received: by 2002:ac2:5105:0:b0:4fe:1ecf:8ab4 with SMTP id
 q5-20020ac25105000000b004fe1ecf8ab4mr4964676lfb.18.1691966226497; Sun, 13 Aug
 2023 15:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230812162222.200004-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230812162222.200004-1-biju.das.jz@bp.renesas.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 14 Aug 2023 00:36:31 +0200
Message-ID: <CAKv63uvEu3kPYF=idNyW4RkwVWFgixdstQyvuUhhHzc_rPgqqg@mail.gmail.com>
Subject: Re: [PATCH] iio: mlx90614: Use i2c_get_match_data()
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It should not break some backwards compatibility so:
Acked-by: "Crt Mori <cmo@melexis.com>"

On Sat, 12 Aug 2023 at 18:22, Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Replace device_get_match_data()->i2c_get_match_data() to extend matching
> support for ID table.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/iio/temperature/mlx90614.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index 07bb5df24ab3..740018d4b3df 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -600,7 +600,7 @@ static int mlx90614_probe(struct i2c_client *client)
>         data->client = client;
>         mutex_init(&data->lock);
>         data->wakeup_gpio = mlx90614_probe_wakeup(client);
> -       data->chip_info = device_get_match_data(&client->dev);
> +       data->chip_info = i2c_get_match_data(client);
>
>         mlx90614_wakeup(data);
>
> --
> 2.25.1
>
