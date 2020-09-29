Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FBB27CE8C
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 15:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgI2NI0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 09:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbgI2NIW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 09:08:22 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAE6C061755;
        Tue, 29 Sep 2020 06:08:22 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n14so4466519pff.6;
        Tue, 29 Sep 2020 06:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=75RviykrydaI5+p5+1zmy+B1rv7DbCDWiFoxtDM1wvg=;
        b=tdORysE3Q9CJek6L48i8saytQFplSecrdCYz9ueRf+epajnoeM/27+ec83dC1eOK86
         BOHjC2LkquYW+TEiK/dIYVXDozKKLvaGM13y2KEDGExtUyymHnyIpmN4MLATah+vVQ/C
         kvmQjJgMPnp1NIX+d5B3F6etg8hlOilVYOgHqgNBKnY8jOHJH1bIwHpA6vEm0QhtZa+e
         3wzMaw4bGQLzpsDIjRholU2zJ1jWxTebBN8EgxYEDnfjiZg0XleOn4D9uTj3QlSPhsEN
         uPjlFbc7qBmH4zKNu3aPHbYgbBziPzcGOqSnJYgpUm3iZlIucaw90YZeSQJrp0d0d/Fu
         CGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=75RviykrydaI5+p5+1zmy+B1rv7DbCDWiFoxtDM1wvg=;
        b=ZWmsqU2Zz6ItU8IO1rRp5M+i1Eh25fQxVFWEG3kTh9gNzPDX/ozh98uwu5Q+v3g6Xv
         WnABbDviqY76S2hjM8B0SSWgmcXhyokFFHUYVojivBhsL66iGSeg0OxVnSycOViPtAyX
         x32qaqXXa0rAJIOBq72PNdh13Ruae5MFUEPv3LhpJrPLVfaJOtnXmazDc8avNN/c3H1A
         K7Qgi253lt8HlCDuehhLpW4lGK4wXIdmwNiHfeX8SeWgXle5NXhBl33a1ZJLC6eaDRFB
         liSwhDvRrKIhVthmG+AMFOUMkJn7T2FMIfPs9nKNMKInchq0IYzQYE4wvdlCpBd8CbHh
         XM3A==
X-Gm-Message-State: AOAM532bsDPdd68vMuaC/HIq3Ua4nr6GRpkD7hY7Lg8O79/RPSFJlBu4
        LvG8pRluOfxqvk6/GJ91ZfjyOY+Py+QsfFVMgiE=
X-Google-Smtp-Source: ABdhPJywwdpgZ9BYYyTCjyOF+DJUOmPWtii1k+2IPRiBu+z/ru3SXrcwD7iu+RuMucG/2Xa3Gwm+FdY9pE+b3WVilnA=
X-Received: by 2002:a17:902:ea8c:b029:d2:8abd:c8de with SMTP id
 x12-20020a170902ea8cb02900d28abdc8demr4679108plb.21.1601384901740; Tue, 29
 Sep 2020 06:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200929125949.69934-1-alexandru.ardelean@analog.com> <20200929125949.69934-8-alexandru.ardelean@analog.com>
In-Reply-To: <20200929125949.69934-8-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 29 Sep 2020 16:08:03 +0300
Message-ID: <CAHp75VerL3x7L=AeLfnT6D01a=FyY3JE4vbwNFMaJz-v=f2k9w@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        groeck@chromium.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 29, 2020 at 3:55 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:

> This change switches to the new devm_iio_triggered_buffer_setup_ext()
> function and removes the iio_buffer_set_attrs() call, for assigning the
> HW FIFO attributes to the buffer.

Sorry, you were too fast with the version, below one nit.

> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../common/cros_ec_sensors/cros_ec_sensors_core.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index c62cacc04672..1eafcf04ad69 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -353,19 +353,22 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>                         if (ret)
>                                 return ret;
>                 } else {
> +                       const struct attribute **fifo_attrs;
> +
> +                       if (has_hw_fifo)
> +                               fifo_attrs = cros_ec_sensor_fifo_attributes;
> +                       else
> +                               fifo_attrs = NULL;
> +
>                         /*
>                          * The only way to get samples in buffer is to set a
>                          * software trigger (systrig, hrtimer).
>                          */
> -                       ret = devm_iio_triggered_buffer_setup(

> +                       ret = devm_iio_triggered_buffer_setup_ext(
>                                         dev, indio_dev, NULL, trigger_capture,
> -                                       NULL);
> +                                       NULL, fifo_attrs);

Perhaps it's time to reformat a bit, i.e. move dev to the first line
and do the rest accordingly?

>                         if (ret)
>                                 return ret;
> -
> -                       if (has_hw_fifo)
> -                               iio_buffer_set_attrs(indio_dev->buffer,
> -                                                    cros_ec_sensor_fifo_attributes);
>                 }
>         }
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
