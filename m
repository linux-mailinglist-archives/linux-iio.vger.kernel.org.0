Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6B4204BE2
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jun 2020 10:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbgFWIEM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Jun 2020 04:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731516AbgFWIEM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Jun 2020 04:04:12 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2321FC061573;
        Tue, 23 Jun 2020 01:04:12 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d10so6892294pls.5;
        Tue, 23 Jun 2020 01:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQQ6b8/L+9sBz/aiKlXca9tRv5gX+sjabdZJB9mU9RE=;
        b=alyRb/xuu63Uprh7RDa9xQ4rmpLhmeZbNXp0OLqJlJ2k/omRlsKHSrPar0/n6J0iil
         l16u+1Rlo77I1yBuOqTMhjrG1uYoIzzpFFhUVw8xHlLa2yfVOC56onewRfXob4Qfh+rI
         jQLz9Zv71H5G5Y+s3tAfQU6Sp6Op2K0CgjbOcG/JD3Y03PZSJZiCNuclmuUgyMqJ2Vcp
         Qv4nYIi5f0RUF4ShwGHnF3bCyVryU6vEMIztg1mo3Je/+GYsK2GZYL1UBekpLWPD3YuN
         7Hg2GijtFcUaixhesxGUIOpEL6V13+ckVR/2SC0WK9RGZwqAoWZPrHxFzjVIthuJC90z
         WQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQQ6b8/L+9sBz/aiKlXca9tRv5gX+sjabdZJB9mU9RE=;
        b=ps6pVC2yU707bQWi3U1FMNqjgKeZ11a5MJCL3OW6srn6n+FqvxiBveEAgtQbfgcrF/
         LI5DY20gCvu4/ejMod7aBdqmfNDxyD5WD4GOVuotfzaI/p/OEvNqwXvfByKwLBL7Rw3C
         FEdmpkmqTAhPz3P9TR6nsAmhTkXsF3KRp1wyGJrq//xVK9uHNXZEvLa7Mejm23jIoDWw
         oKAuaTotW2bSPIH0eOzB8oKQppfdnCw6Gq0PyBZOCoIAlVZThiRbvMbJY3cqFK9qc0Ts
         4pAydCYMbRbTr7Em0ljYnl5TImzNKHo06Qn1xWi6OcVrgvaKHvjKsvGBoYt4nbdZyYP8
         OkUw==
X-Gm-Message-State: AOAM533tWk2dw0Xw/sqpRizec+GUCmKpbo/Supl5cUzo2fQInM3bPUVf
        OrpheTgk3z9eNNv9dz29pQtjzvdIJrT19awyQmw=
X-Google-Smtp-Source: ABdhPJwNa0rny5GUWzYvpOwoLS8vL/Q94xTUMDogzOmjviOFyXXHjtdD6h5tWeOr8wax60CpPKWwbjtIVzpGXxUa/Ew=
X-Received: by 2002:a17:90a:b30d:: with SMTP id d13mr21917940pjr.181.1592899451496;
 Tue, 23 Jun 2020 01:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <1592897399-24089-1-git-send-email-jprakash@codeaurora.org> <1592897399-24089-6-git-send-email-jprakash@codeaurora.org>
In-Reply-To: <1592897399-24089-6-git-send-email-jprakash@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 Jun 2020 11:03:58 +0300
Message-ID: <CAHp75VcvvQJOqrarS8BvneZkX+DusUtGV5DS34_T4BOFKpGECQ@mail.gmail.com>
Subject: Re: [PATCH V7 5/7] iio: adc: Update return value checks
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        smohanad@codeaurora.org, kgunda@codeaurora.org,
        aghayal@codeaurora.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 23, 2020 at 10:31 AM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
> Clean up some return value checks to make code more compact.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index dcc7599..3022313 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -301,7 +301,7 @@ static int adc5_configure(struct adc5_chip *adc,
>
>         /* Read registers 0x42 through 0x46 */
>         ret = adc5_read(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
> -       if (ret < 0)
> +       if (ret)
>                 return ret;
>
>         /* Digital param selection */
> @@ -388,7 +388,7 @@ static int adc5_do_conversion(struct adc5_chip *adc,
>
>         if (adc->poll_eoc) {
>                 ret = adc5_poll_wait_eoc(adc);
> -               if (ret < 0) {
> +               if (ret) {
>                         pr_err("EOC bit not set\n");
>                         goto unlock;
>                 }
> @@ -398,7 +398,7 @@ static int adc5_do_conversion(struct adc5_chip *adc,
>                 if (!ret) {
>                         pr_debug("Did not get completion timeout.\n");
>                         ret = adc5_poll_wait_eoc(adc);
> -                       if (ret < 0) {
> +                       if (ret) {
>                                 pr_err("EOC bit not set\n");
>                                 goto unlock;
>                         }
> @@ -516,8 +516,6 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
>         default:
>                 return -EINVAL;
>         }
> -
> -       return 0;
>  }
>
>  static int adc7_read_raw(struct iio_dev *indio_dev,
> @@ -761,7 +759,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>
>                 ret = adc5_read(adc, ADC5_USR_REVISION1, dig_version,
>                                                         sizeof(dig_version));
> -               if (ret < 0) {
> +               if (ret) {
>                         dev_err(dev, "Invalid dig version read %d\n", ret);
>                         return ret;
>                 }
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With Best Regards,
Andy Shevchenko
