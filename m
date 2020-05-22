Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5A51DEC22
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 17:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbgEVPiJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 11:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgEVPiH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 11:38:07 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3155C061A0E;
        Fri, 22 May 2020 08:38:06 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v2so276529pfv.7;
        Fri, 22 May 2020 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7d6Zc97NBhItvRjzjZUUc48PU79OtYvfEiPWCQjEB6k=;
        b=XIUzpkXUgXN4ekr2pr/QNKfYS+PLoKi359Ap1UqdXIlLp2VLZLP+DChRBbloXHl0qO
         7pNz+EDhJdaOAG3SBQX5U3/dN+YB1sQa0HdCt5J2s1B0HrHYpKVp2tLLJq48Iht761yU
         NA/IisBLdmx2Il5HfI+POLJpXfBwCWybjm6VBBYXLc6VDccfvTEQoO7SYWnwjeoTtrMj
         XYTaU5NnSpXZvafqavsy+bqAVU2O2at+nFSf9Rw8i/DpnOX2jdcm2t9SAKeRZ1OkZV0C
         pATE1NvYIirBQtPJX5wmj7xsloZD+ypOl8NbhFDzBv5KvlUJzhiC4qt0v2Vw+YGVcnSL
         o0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7d6Zc97NBhItvRjzjZUUc48PU79OtYvfEiPWCQjEB6k=;
        b=uddXLMzVsi2o/QpvfGI31LgPkHQ7bwfxVqZot09Y4mwDXJtN9RYzNbpcj+aW63q99m
         rZDbTPMGqTlMuJ8kzQ89Id9Z9gYKhtXvWLRPL0cdOTLgqhkEp3ZXurkN8ahgchyXBA9j
         2aJ/l6jmmF8OY+5bO9Tf86E+6V4V+ZvTnx8yDJ6Za0hx9fItgoBUJ10MnDRi4fzttyWc
         zLNomW4+nbRX+1NnRzCRYyZB3d4nAbSdhM47GHO+jHVP7dgSnerZ01Ja7HH02fQuhmqf
         2OiaxuTdWITBXA2ApxTLxGh3eddC9ZAMl9I3qt/JetSAj4yoONGsp7dSSvBZcL078nvm
         o83g==
X-Gm-Message-State: AOAM532DIhcOBHtF0FHyFoC6h9bDzRebjQRMhN0vsO0HdkaY48t+SiiK
        qbU6hxPtKksL9duZSPvwlRnMHSRGnQ81RWoCCso=
X-Google-Smtp-Source: ABdhPJwO/L4Ya2h25wEeCWkhoA3A5fiVzMxVAIXSecKUCGMRueGRPQ/S/bLQTN0mYfvxRnBjkDvp1YOcgWg9UMIA/lo=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr14554351pgb.203.1590161886488;
 Fri, 22 May 2020 08:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <1590157452-27179-1-git-send-email-jprakash@codeaurora.org> <1590157452-27179-4-git-send-email-jprakash@codeaurora.org>
In-Reply-To: <1590157452-27179-4-git-send-email-jprakash@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 May 2020 18:37:55 +0300
Message-ID: <CAHp75Vfgk0-Rye2We1A6_WTWMCK3D-WW4_T3CGPHc=-tB=6M9g@mail.gmail.com>
Subject: Re: [PATCH V5 3/5] iio: adc: Add support for PMIC7 ADC
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

On Fri, May 22, 2020 at 5:25 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
> The ADC architecture on PMIC7 is changed as compared to PMIC5. The
> major change from PMIC5 is that all SW communication to ADC goes through
> PMK8350, which communicates with other PMICs through PBS when the ADC
> on PMK8350 works in master mode. The SID register is used to identify the
> PMICs with which the PBS needs to communicate. Add support for the same.

Below should be in a separate patch, but it's a bikeshedding. So, I
left it to maintainers to decide.
Fine with me
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

...

> @@ -285,7 +304,7 @@ static int adc5_configure(struct adc5_chip *adc,
>
>         /* Read registers 0x42 through 0x46 */
>         ret = adc5_read(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
> -       if (ret < 0)
> +       if (ret)
>                 return ret;
>
>         /* Digital param selection */

...

> @@ -331,7 +391,7 @@ static int adc5_do_conversion(struct adc5_chip *adc,
>
>         if (adc->poll_eoc) {
>                 ret = adc5_poll_wait_eoc(adc);
> -               if (ret < 0) {
> +               if (ret) {
>                         pr_err("EOC bit not set\n");
>                         goto unlock;
>                 }
> @@ -341,7 +401,7 @@ static int adc5_do_conversion(struct adc5_chip *adc,
>                 if (!ret) {
>                         pr_debug("Did not get completion timeout.\n");
>                         ret = adc5_poll_wait_eoc(adc);
> -                       if (ret < 0) {
> +                       if (ret) {
>                                 pr_err("EOC bit not set\n");
>                                 goto unlock;
>                         }

...

> @@ -406,8 +519,38 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
>         default:
>                 return -EINVAL;
>         }
> +}
>
> -       return 0;

(this one looks like standalone change from above)

...

> @@ -570,7 +762,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>
>                 ret = adc5_read(adc, ADC5_USR_REVISION1, dig_version,
>                                                         sizeof(dig_version));
> -               if (ret < 0) {
> +               if (ret) {
>                         dev_err(dev, "Invalid dig version read %d\n", ret);
>                         return ret;
>                 }

...

> +       if (of_device_is_compatible(node, "qcom,spmi-adc7"))
> +               indio_dev->info = &adc7_info;
> +       else
> +               indio_dev->info = &adc5_info;

Can we use driver_data?

...

> +       if (adcmap7_die_temp[0].x > voltage) {
> +               *result_mdec = DIE_TEMP_ADC7_SCALE_1;
> +               return 0;

> +       } else if (adcmap7_die_temp[i].x <= voltage) {

As per previous comment, redundant 'else' and please use value of i
directly here.


-- 
With Best Regards,
Andy Shevchenko
