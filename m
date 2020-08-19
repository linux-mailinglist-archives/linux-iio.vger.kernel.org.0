Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4832497F5
	for <lists+linux-iio@lfdr.de>; Wed, 19 Aug 2020 10:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHSIJM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Aug 2020 04:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgHSIJL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Aug 2020 04:09:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D79C061389;
        Wed, 19 Aug 2020 01:09:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d22so11281725pfn.5;
        Wed, 19 Aug 2020 01:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kc59WmfWj0wRFhybQatbKnZqKnCoVrXgX9brVLjwapA=;
        b=fBM0NL8O7zB5p7pvt1VJfvLqyeyXgAtQDuBHFiXiRhXusYsyhGsWdV2BKRNURNH0V7
         JE2shbP1aMjika8XelFfJ4ndIqClbXGatj63Pqm7XZWn8+kJx8Xmh6tQo6y7xtFvX/NO
         VtIZlWjK/FuaIPoqHkn0kMbPB80o7jnWvINQkHKRtMTW2fHfGHxcw3NnIErKkzXs9IAB
         846wvmJIDGTttODpjHCAtVYewzih+adRrCfmDdXSRW5/A4ImuCsxbsGEz/SX/JMjGZ+4
         txAqbyn7GmhIsSa+U3iqzsY/VqIZKTDSiYUqRRHpZaMqCaB1HsidWRsRPwdFd0zpI0TK
         F9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kc59WmfWj0wRFhybQatbKnZqKnCoVrXgX9brVLjwapA=;
        b=q3z6iA1cgHLOIOei6132do7pF2V96tW6kd8d9ULAORIvTHMlkj0IAhmOUDftBHwJ9M
         QZfi2227kzWUGcyX8eyxKIwlTEhWYjHdfmjCd5bQZCe8KxXjA1uGJkAbNZbsRzB+CtuN
         4DvjosqXaqZGi7BwefSUq9lidzC3h7bUFgRUX0w/+n+46UPPg6jsy30XyGr5dpkTw76t
         Z09Yre8D1FgMjSbTmWTucyif870dZ4kioNbe9FNIJY4oY6A4SgNUClQcbTSKR8UZM8/+
         WksHPYH2j9VRhZJAbVdppKis5FkVh5OmqDqnz28tsffFG47NcFCD2wyM2fXcT4fqpJrS
         fgig==
X-Gm-Message-State: AOAM5331zVsCy/D8REGlBxwbs6wTAGFjlfaNZK4YpDTw7+U6Aa2HegIo
        5pNMwVsYH85QvpYPjqSKiD08MYLlzodlJFGyzQw=
X-Google-Smtp-Source: ABdhPJxmpAOCQs17t7LhAnQD4N4orYj7PORpPk91Tqw3X+IYmx0MWadQ4BGXrYkbI9f9g4JmD5BciQ12Su2GsTAWTew=
X-Received: by 2002:a62:c319:: with SMTP id v25mr17748408pfg.130.1597824550613;
 Wed, 19 Aug 2020 01:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200818213737.140613-1-cmo@melexis.com> <20200818213737.140613-4-cmo@melexis.com>
In-Reply-To: <20200818213737.140613-4-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 19 Aug 2020 11:08:54 +0300
Message-ID: <CAHp75Vcv=GtefqJjvKmCZsOuLDgfbGnfGR-+RwWZRS+tMmFZ-Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] iio:temperature:mlx90632: Convert polling while
 loop to regmap
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 19, 2020 at 12:38 AM Crt Mori <cmo@melexis.com> wrote:
>
> Reduce number of lines and improve readability to convert polling while
> loops to regmap_read_poll_timeout.

Usually we refer to a function as regmap_read_poll_timeout(). Note
parentheses. I think Jonathan can fix when applying, no need to
resend.

Precisely what I meant, thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Crt Mori <cmo@melexis.com>
> ---
>  drivers/iio/temperature/mlx90632.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index ce75f5a3486b..d782634c107f 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -180,25 +180,19 @@ static s32 mlx90632_pwr_continuous(struct regmap *regmap)
>   */
>  static int mlx90632_perform_measurement(struct mlx90632_data *data)
>  {
> -       int ret, tries = 100;
>         unsigned int reg_status;
> +       int ret;
>
>         ret = regmap_update_bits(data->regmap, MLX90632_REG_STATUS,
>                                  MLX90632_STAT_DATA_RDY, 0);
>         if (ret < 0)
>                 return ret;
>
> -       while (tries-- > 0) {
> -               ret = regmap_read(data->regmap, MLX90632_REG_STATUS,
> -                                 &reg_status);
> -               if (ret < 0)
> -                       return ret;
> -               if (reg_status & MLX90632_STAT_DATA_RDY)
> -                       break;
> -               usleep_range(10000, 11000);
> -       }
> +       ret = regmap_read_poll_timeout(data->regmap, MLX90632_REG_STATUS, reg_status,
> +                                      !(reg_status & MLX90632_STAT_DATA_RDY), 10000,
> +                                      100 * 10000);
>
> -       if (tries < 0) {
> +       if (ret < 0) {
>                 dev_err(&data->client->dev, "data not ready");
>                 return -ETIMEDOUT;
>         }
> --
> 2.25.1
>


--
With Best Regards,
Andy Shevchenko
