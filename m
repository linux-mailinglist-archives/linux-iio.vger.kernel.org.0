Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27602441A0A
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 11:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhKAKko (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 06:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhKAKko (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 06:40:44 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDA3C061714
        for <linux-iio@vger.kernel.org>; Mon,  1 Nov 2021 03:38:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id f4so4562928edx.12
        for <linux-iio@vger.kernel.org>; Mon, 01 Nov 2021 03:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U5k1mYRuhv7tpkeXEnr+BD1LNon5UQ2BZD3wW7WjKq4=;
        b=OgJvQWAZ1DJI5qsmtXqDNcb+nywc4RSe0GHCH0CGxW/M51mFU3BPST7CGVbAY188/j
         9ZYe2DGQljzN6awK3TaKID4rjMGz3lj6oWSP0sRWLfwxSHJwVxbqfyawA16/yyn9AW5c
         YhZ5ruUqLEq0PKq0EPlWfjOtSub6uOvdbse5rNhdiSampkPOSAh3M8PJDCMGzPNj19+6
         pdhGd0+zTo6v6+56vOrR8CDYew9yCeuu1xM7wBbwfNPcSoqm9lRXwGUfoPIaa/4nxlO9
         5aL+h0dnHnrhupVdCQ3fOhG0A2eRYll7JvDHIc/Q9yl41s0nnSM2o4b3MQjI7VW4A1v1
         DAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U5k1mYRuhv7tpkeXEnr+BD1LNon5UQ2BZD3wW7WjKq4=;
        b=a7CbMZV1bSYR1hoMAYO35OIMZE5Xhl4J3s6ZGQphAU6PHaGZTU5FZLGm3E5crTzOLk
         pmvICM71uf7nsMZtEI4e5kSVTnZbjCaLstf2t3Rcgpf/byyeh69O7nZ65elKkHHYGoLx
         cY6u23ez+HhpKU/W5XboyenfGLvLmlRFaP/19JwCElWDMLYG0pX7mvSa+PJiR1JFHwQ6
         lq6YeXn4XDVh4tA4Y8Ur8KRWKgd7Ox8LdhWIyjS8u1QfcqVAWmcHnAlzxRsWTKUiPQ/m
         8s4bcAg28dxGltf363B1I7+/v3tKK0GopxEAK+cW1/Hrn+7ppURqzGanmJYL0SFqJQqL
         bfKg==
X-Gm-Message-State: AOAM531mNsbfOIc+DU1GkGAsdRYkUyL55Qbwr64atcPhiPm/rDVmH4RP
        xXNJEjFWOe4dE62j7hgTukbl9HGRzWW8lTJshShFkP2iAgw=
X-Google-Smtp-Source: ABdhPJwrNIEA+NEJe00Tx9mvoYbMj18R1fObYGRTTG6ZnLeKkHkCsr0D579STDBDroxMfEqczSDEE75taD35/Xz5WJI=
X-Received: by 2002:a17:906:6a0a:: with SMTP id qw10mr7907814ejc.141.1635763089421;
 Mon, 01 Nov 2021 03:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211101102734.32291-1-lars@metafoo.de>
In-Reply-To: <20211101102734.32291-1-lars@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Nov 2021 12:37:19 +0200
Message-ID: <CAHp75VfiZOhjTLKPt_b3mTP2KsGMuFqPWk2oG0wX_oC5EognCQ@mail.gmail.com>
Subject: Re: [PATCH] iio: mma8452: Use correct type for return variable in IRQ handler
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Martin Fuzzey <mfuzzey@parkeon.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 1, 2021 at 12:28 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> The IRQ handler's return type is irqreturn_t. The mma8452 uses a variable
> to store the return value, but the variable is of type int. Change this to
> irqreturn_t. This makes it easier to verify that the code is correct.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/iio/accel/mma8452.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 09c7f10fefb6..64b82b4503ad 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1053,7 +1053,7 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
>  {
>         struct iio_dev *indio_dev = p;
>         struct mma8452_data *data = iio_priv(indio_dev);
> -       int ret = IRQ_NONE;
> +       irqreturn_t ret = IRQ_NONE;
>         int src;
>
>         src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
