Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512D023B59D
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 09:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgHDH1M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Aug 2020 03:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgHDH1M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2020 03:27:12 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF9DC06174A;
        Tue,  4 Aug 2020 00:27:11 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r11so11799876pfl.11;
        Tue, 04 Aug 2020 00:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+LWBeYipq+ceid3K3seSlGlVrJ1K4pI/42TN0sWehM=;
        b=JL08f7NiIwAPdUelKgqXR0B33MheFeRJI2WxYAJofyVdCfC/wW2Z8UWmk43icFOjrN
         f1xFqzNHo1ZDlqreI/BGgSBpy2TuAFquBxDw5Vb1Zx9uCl9U/K1a8ZFJvXhIPR+5TYzJ
         wNbmd/VlchFsykZFKf1XFM84zth0vkwPx5TMJiWiFWzYKUT5XAgS5jpgXIjGQ9vgRsfp
         A5xpP58DMDAH02oVsbH1ObeYJKF+iY0KDopRgizKqhdSTXZ/bGqDwmt+ralJgh7gIICt
         6y9URjcvaK+YyRsUxiT14u4DvM0WsmtkeWPomewNv4AmHk4gEXWy04dxanF4Hh7cdQ0j
         peHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+LWBeYipq+ceid3K3seSlGlVrJ1K4pI/42TN0sWehM=;
        b=XxG4dDRgaaCf2xUXc5Y/5Rl+kLD8bfN989aL9uJmGxVrgx4+2G4EwOqcro0LnXyKCW
         pVRZNwhGOEvTSF0944t8z5TBSH2sl+Tw899rbAlya2hUxUhelSrMDSHiQjaURxq0d0la
         Nxs5duMbpH5CHxAKK/dEvItNOlHM8aKS7qmfvxTWPfzOADgY2E+cyx6mtxjQHkAUeH2B
         gy3DZ23pQ5hw6WXNFCqAq55SkarHBqeDHoj0T59HDDn7ypPbGijhiFgpysJIreiPvfzP
         SeO/fEM/GaTOmW/3yg9MA7QBsRX7yPq94BPy8nWl86+mEspwfmI0MWgcZDgrMCTsgCxt
         jxyA==
X-Gm-Message-State: AOAM532ZJMC6HIWYr8ceASht80tdK4bPgMBJ5VdfLaJRQarLFcabpDqe
        KCqmY+V1/mu7Jhu2Qk5b0anEf5uUsPmgc2P0X3w=
X-Google-Smtp-Source: ABdhPJwzkKwmjuOmrKa2yDmLHcCsZM911YiteZxUD/AfoRcnOeuCKtwXibuHF4fQqWoUrs+KckSZ815VcF7ExP+mVPE=
X-Received: by 2002:a63:924b:: with SMTP id s11mr17633349pgn.74.1596526031371;
 Tue, 04 Aug 2020 00:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200803235815.778997-1-campello@chromium.org> <20200803175559.v5.3.Idbfcd2e92d2fd89b6ed2e83211bd3e6c06852c33@changeid>
In-Reply-To: <20200803175559.v5.3.Idbfcd2e92d2fd89b6ed2e83211bd3e6c06852c33@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Aug 2020 10:26:55 +0300
Message-ID: <CAHp75VcftUCi-4w=NWXUb=zPYL9zz6BEHw6y1wUKPD8vXcX9zA@mail.gmail.com>
Subject: Re: [PATCH v5 03/15] iio: sx9310: Fix irq handling
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 4, 2020 at 2:58 AM Daniel Campello <campello@chromium.org> wrote:
>
> Fixes enable/disable irq handling at various points. The driver needs to
> only enable/disable irqs if there is an actual irq handler installed.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Daniel Campello <campello@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes in v5: None
> Changes in v4:
>  - Reverted condition check logic on enable/disable_irq methods.
>
> Changes in v3:
>  - Moved irq presence check down to lower methods
>
> Changes in v2:
>  - Reordered error handling on sx9310_resume()
>
>  drivers/iio/proximity/sx9310.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index d7c77fc661ba86..dafee85018aa6d 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -323,11 +323,15 @@ static int sx9310_put_event_channel(struct sx9310_data *data, int channel)
>
>  static int sx9310_enable_irq(struct sx9310_data *data, unsigned int irq)
>  {
> +       if (!data->client->irq)
> +               return 0;
>         return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq, irq);
>  }
>
>  static int sx9310_disable_irq(struct sx9310_data *data, unsigned int irq)
>  {
> +       if (!data->client->irq)
> +               return 0;
>         return regmap_update_bits(data->regmap, SX9310_REG_IRQ_MSK, irq, 0);
>  }
>
> @@ -381,7 +385,7 @@ static int sx9310_read_proximity(struct sx9310_data *data,
>
>         mutex_unlock(&data->mutex);
>
> -       if (data->client->irq > 0) {
> +       if (data->client->irq) {
>                 ret = wait_for_completion_interruptible(&data->completion);
>                 reinit_completion(&data->completion);
>         } else {
> @@ -1010,10 +1014,11 @@ static int __maybe_unused sx9310_resume(struct device *dev)
>
>  out:
>         mutex_unlock(&data->mutex);
> +       if (ret)
> +               return ret;
>
>         enable_irq(data->client->irq);
> -
> -       return ret;
> +       return 0;
>  }
>
>  static const struct dev_pm_ops sx9310_pm_ops = {
> --
> 2.28.0.163.g6104cc2f0b6-goog
>


-- 
With Best Regards,
Andy Shevchenko
