Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D48265346
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 23:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgIJVbC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 17:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgIJNvp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2020 09:51:45 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4FDC061796;
        Thu, 10 Sep 2020 06:51:44 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id j7so949550plk.11;
        Thu, 10 Sep 2020 06:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s8hpTJ5jpmu25r8Rx3Kgs3iF4PPo1Ln9S4YDeFEjnfs=;
        b=CFF9tYL5KeE0BlS/F84CUI6dKWsCH+MrmT4ZuZWKR13iqL116kIqKL1o6m842w8bVD
         uL3e4eicEGPy/IHrqguM7QLSYYW7C670Ce4wGcGxAFE/UhiV7fP/g0A+WRGqYVpvb6km
         6PsnW0mkpB6++hV7TRwnFNtuEP8NLhrl7AJqWNtqhbahlOluKnClxol2j9+Yz3OcI6SR
         b3Qt5+w7r6toPI1LyCNeQ69qBZSbkPYmdCiqKsItJ52yw5JZX1zA3PWDzj3wtN0REcCU
         mfxd6ssCbAHJrJbOfDmX4Qr8f232lXABltZ2Zf1ltrrCO3/h4Y5RlHmUtdyPO4RHu5fI
         JU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s8hpTJ5jpmu25r8Rx3Kgs3iF4PPo1Ln9S4YDeFEjnfs=;
        b=agJNeE9Qq5U8Ja391WdDkYiboOOZLC+53W9iFwBOqASmyHlWqaI1mZOPX4v+qBrEGX
         iZRnJBKENF200tx25dGKFI0cD4TAkDz/tNi6Kci+AVGkszGwSLwXk8KDz/KVeNB4hS8k
         DAdEfWiIMcHFoGowBX7IBAh1JeAh9rUfI4nBHVyOM0v0m/GaWTGoZD/jbEC5JX8ag7u9
         gATMYXNMZ696PUsMp4+lVtZSyUNoWWyRiBH4dWlhpkNQEIx08s6irSfiyoQtACE01IxO
         vLwCLoFf4N1zytTURq7qGUVQVpUJbZCMpTWwdLEXwQ4vE0vkaZmbJl101fMFTCBp9aio
         14cQ==
X-Gm-Message-State: AOAM532opxQFTHNok+Nkux0pEdl5u3l2nzENiZVKJgufT6I1HyhIJnGB
        C4LudZM4tSbufB6EDvsr4KQ/JdDdkpKqeGpvbJJcrPkX9yrWM+F3
X-Google-Smtp-Source: ABdhPJz3RqmvrCZbiqBb7VrCUo9x60EzXi4LWBPQA9Ku3MI22FHzXcVDfKsiKq9AIWOmp08oGgBgCXXYTR9Fi6FSgdA=
X-Received: by 2002:a17:90a:fd98:: with SMTP id cx24mr23153pjb.181.1599745904138;
 Thu, 10 Sep 2020 06:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200910122711.16670-1-nish.malpani25@gmail.com>
In-Reply-To: <20200910122711.16670-1-nish.malpani25@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Sep 2020 16:51:26 +0300
Message-ID: <CAHp75VeMJruyOCskBGZtyeR-p3sh7hLk2QH32LULAo7wSX3KUA@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: adxrs290: use hook for devm resource unwinding
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 10, 2020 at 3:27 PM Nishant Malpani
<nish.malpani25@gmail.com> wrote:
>
> Make use of devm_add_action_or_reset() hook to switch device into STANDBY
> mode during standard resource unwinding. The patch includes a helper
> function, in the form of adxrs290_set_mode(), to realise driving the
> device into STANDBY mode.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
> ---
>  drivers/iio/gyro/adxrs290.c | 61 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
> index ff989536d2fb..2864eb443957 100644
> --- a/drivers/iio/gyro/adxrs290.c
> +++ b/drivers/iio/gyro/adxrs290.c
> @@ -192,15 +192,70 @@ static int adxrs290_set_filter_freq(struct iio_dev *indio_dev,
>         return adxrs290_spi_write_reg(st->spi, ADXRS290_REG_FILTER, val);
>  }
>
> +static int adxrs290_set_mode(struct iio_dev *indio_dev, enum adxrs290_mode mode)
> +{
> +       struct adxrs290_state *st = iio_priv(indio_dev);
> +       int val, ret;
> +
> +       if (st->mode == mode)
> +               return 0;
> +
> +       mutex_lock(&st->lock);
> +
> +       ret = spi_w8r8(st->spi, ADXRS290_READ_REG(ADXRS290_REG_POWER_CTL));
> +       if (ret < 0)
> +               goto out_unlock;
> +
> +       val = ret;
> +
> +       switch (mode) {
> +       case ADXRS290_MODE_STANDBY:
> +               val &= ~ADXRS290_MEASUREMENT;
> +               break;
> +       case ADXRS290_MODE_MEASUREMENT:
> +               val |= ADXRS290_MEASUREMENT;
> +               break;
> +       default:
> +               ret = -EINVAL;
> +               goto out_unlock;
> +       }
> +
> +       ret = adxrs290_spi_write_reg(st->spi, ADXRS290_REG_POWER_CTL, val);
> +       if (ret < 0) {
> +               dev_err(&st->spi->dev, "unable to set mode: %d\n", ret);
> +               goto out_unlock;
> +       }
> +
> +       /* update cached mode */
> +       st->mode = mode;
> +
> +out_unlock:
> +       mutex_unlock(&st->lock);
> +       return ret;
> +}
> +
> +static void adxrs290_chip_off_action(void *data)
> +{
> +       struct iio_dev *indio_dev = data;
> +
> +       adxrs290_set_mode(indio_dev, ADXRS290_MODE_STANDBY);
> +}
> +
>  static int adxrs290_initial_setup(struct iio_dev *indio_dev)
>  {
>         struct adxrs290_state *st = iio_priv(indio_dev);
> +       struct spi_device *spi = st->spi;
> +       int ret;
> +
> +       ret = adxrs290_spi_write_reg(spi, ADXRS290_REG_POWER_CTL,
> +                                    ADXRS290_MEASUREMENT | ADXRS290_TSM);
> +       if (ret < 0)
> +               return ret;
>
>         st->mode = ADXRS290_MODE_MEASUREMENT;
>
> -       return adxrs290_spi_write_reg(st->spi,
> -                                     ADXRS290_REG_POWER_CTL,
> -                                     ADXRS290_MEASUREMENT | ADXRS290_TSM);
> +       return devm_add_action_or_reset(&spi->dev, adxrs290_chip_off_action,
> +                                       indio_dev);
>  }
>
>  static int adxrs290_read_raw(struct iio_dev *indio_dev,
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
