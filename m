Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2BB218ED53
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 00:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgCVXkW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 19:40:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46104 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgCVXkV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 19:40:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id q3so2027206pff.13
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2020 16:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LSoiX2KDtuHcjAvxn49iG05bHr7GoZNqUhV+VjEizwk=;
        b=WZ/Ip6wynDqJa9GGL49tMWQvik+WaB0D69d3p+XvJGoesXA3FtD+CMF8+jIW25XvTz
         nJDQhCnczt7zliOOYI6U6j/G9vVgAhL5WK3bH/8H3fxglqA/U98iVQSKQN9lmwVvAIe+
         vKyd0jz08PlxCGq4SD+0EKGcp9S1uAqqHDtKtmo+7dUkFszA15/juQULGJ9t3cwF/ztR
         CFah5QcrIkiCRTYKYTzBq6EUfzuQYuji0qQkYHuNaI4U4YSNk6piKhcyYvVXJzwgTgXQ
         B5CyI0/58j3yKrpHG9aQnnfehWQ53EP5bhEgdafipqbS6a0TZnwtY7GZCT2cRFse9sFY
         mvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LSoiX2KDtuHcjAvxn49iG05bHr7GoZNqUhV+VjEizwk=;
        b=llFo+TKv/qBeorCIehzsyg5wRIH6fs+jwZo54bDm6m0uaLg+8MRDDoShtJuPK4YrmA
         azINZ9SIAsqopucvJSDloW3WlaJbvkY+FfVGO2OVt20QBdQV+rjkKmPzQA4bBxy/1fkY
         lFrgLX9ZG9pZP1139Hf9IRcHXMOWZi6NheMvE3PovnA/ZQpqeKVEvGd+Cc1sIg2HLzkG
         vvvMpOajhB5QOBup0DfUL8z4a8UT1q83XpGyZjX33z1r/bSPajal+SCEllAMrQEQWeRv
         4fKyWZeaDz9Fg8/xCafIQ8yZbQF2i3RjkzVWNGdilyqMapQC0G/g87YBw1hnMNZGvLIW
         /Mxg==
X-Gm-Message-State: ANhLgQ0OaevLi4CNohDrOhe4D/62iYiIWk5HVaFSmRlXqyhT+m+F3Q5P
        ng/MKi5YNxb8ZHv9AJ8N2HCBUSohtrycqNdG0ok=
X-Google-Smtp-Source: ADFU+vuiUrBACFlhwLfR9TRqkxwUj9qxvqw5hLQ2ct/1fuoPnr+YPWVSRdGHMufFTK9RPbAK6ApowfadRK8PkUwVOIE=
X-Received: by 2002:aa7:958f:: with SMTP id z15mr20806386pfj.130.1584920420057;
 Sun, 22 Mar 2020 16:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584904896.git.mh12gx2825@gmail.com> <a5aea6836da9aa2f950449225892ee18f10e217c.1584904896.git.mh12gx2825@gmail.com>
In-Reply-To: <a5aea6836da9aa2f950449225892ee18f10e217c.1584904896.git.mh12gx2825@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 Mar 2020 01:40:08 +0200
Message-ID: <CAHp75VetdASuw60zcp+O=RWK+pmksuPtkGL3smrqYbdfgC98xw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] staging: iio: adc: ad7192: Correct macro names
 from SYNC to SINC
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        kieran.bingham@ideasonboard.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 22, 2020 at 9:57 PM Deepak R Varma <mh12gx2825@gmail.com> wrote:
>
> Three macros include SYNC in their names which is a typo. Update those
> names to SINC.

It is good to elaborate the source of the above statement (e.g.
datasheet pages).

> Fixes: 77f6a23092c0 ("staging: iio: adc: ad7192: Add low_pass_3db_filter_frequency")

>

This blank line should go before Fixes tag. The rule is that tags are
forming a block at the end of commit message.

> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>

The code below looks good to me.


>
> ---
>
> Changes since v2:
>         - None. Version increment to follow patch series versioning.
>
> Changes since v1:
>         - None. Patch added in v2 version as suggested by Stefano.
>
>
>  drivers/iio/adc/ad7192.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 02981f3d1794..d9a220d4217f 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -144,9 +144,9 @@
>  #define AD7192_EXT_FREQ_MHZ_MAX        5120000
>  #define AD7192_INT_FREQ_MHZ    4915200
>
> -#define AD7192_NO_SYNC_FILTER  1
> -#define AD7192_SYNC3_FILTER    3
> -#define AD7192_SYNC4_FILTER    4
> +#define AD7192_NO_SINC_FILTER  1
> +#define AD7192_SINC3_FILTER    3
> +#define AD7192_SINC4_FILTER    4
>
>  /* NOTE:
>   * The AD7190/2/5 features a dual use data out ready DOUT/RDY output.
> @@ -367,7 +367,7 @@ static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
>                 st->conf |= AD7192_CONF_REFSEL;
>
>         st->conf &= ~AD7192_CONF_CHOP;
> -       st->f_order = AD7192_NO_SYNC_FILTER;
> +       st->f_order = AD7192_NO_SINC_FILTER;
>
>         buf_en = of_property_read_bool(np, "adi,buffer-enable");
>         if (buf_en)
> @@ -484,11 +484,11 @@ static void ad7192_get_available_filter_freq(struct ad7192_state *st,
>
>         /* Formulas for filter at page 25 of the datasheet */
>         fadc = DIV_ROUND_CLOSEST(st->fclk,
> -                                AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode));
> +                                AD7192_SINC4_FILTER * AD7192_MODE_RATE(st->mode));
>         freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
>
>         fadc = DIV_ROUND_CLOSEST(st->fclk,
> -                                AD7192_SYNC3_FILTER * AD7192_MODE_RATE(st->mode));
> +                                AD7192_SINC3_FILTER * AD7192_MODE_RATE(st->mode));
>         freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
>
>         fadc = DIV_ROUND_CLOSEST(st->fclk, AD7192_MODE_RATE(st->mode));
> @@ -576,25 +576,25 @@ static int ad7192_set_3db_filter_freq(struct ad7192_state *st,
>
>         switch (idx) {
>         case 0:
> -               st->f_order = AD7192_SYNC4_FILTER;
> +               st->f_order = AD7192_SINC4_FILTER;
>                 st->mode &= ~AD7192_MODE_SINC3;
>
>                 st->conf |= AD7192_CONF_CHOP;
>                 break;
>         case 1:
> -               st->f_order = AD7192_SYNC3_FILTER;
> +               st->f_order = AD7192_SINC3_FILTER;
>                 st->mode |= AD7192_MODE_SINC3;
>
>                 st->conf |= AD7192_CONF_CHOP;
>                 break;
>         case 2:
> -               st->f_order = AD7192_NO_SYNC_FILTER;
> +               st->f_order = AD7192_NO_SINC_FILTER;
>                 st->mode &= ~AD7192_MODE_SINC3;
>
>                 st->conf &= ~AD7192_CONF_CHOP;
>                 break;
>         case 3:
> -               st->f_order = AD7192_NO_SYNC_FILTER;
> +               st->f_order = AD7192_NO_SINC_FILTER;
>                 st->mode |= AD7192_MODE_SINC3;
>
>                 st->conf &= ~AD7192_CONF_CHOP;
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
