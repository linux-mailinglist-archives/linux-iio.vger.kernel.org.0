Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B872E188E
	for <lists+linux-iio@lfdr.de>; Wed, 23 Dec 2020 06:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgLWFkm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Dec 2020 00:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgLWFkl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Dec 2020 00:40:41 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F8DC0613D3
        for <linux-iio@vger.kernel.org>; Tue, 22 Dec 2020 21:40:01 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id v3so14060095ilo.5
        for <linux-iio@vger.kernel.org>; Tue, 22 Dec 2020 21:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wCpJ0YTkWuVc6rGTT6nw4giHLC0mtnxopcpcEXj8EY=;
        b=HBqJzBQHmENzEYomyrLz9SMzZVt/VkyXW1FY6aMpkTRFbeZI2SbaB/zq3wpFO6lxYR
         ZGhsBn3z2Zm5NHMZKINjyAGCY/DgNF5NyW85lG9rPHbmTnZVRZ66feftzJTNDOcylOxs
         WuIaPHKmaB+o6z5sAl1U0/GS1QvUpHoTKUIv8X9HRvSHoltxskZTb7DuNQCImm+RNjw3
         Fv2M4Z7FhhJ3KT7qQlVHlnJ9Bn7dbneGosGrLt5WiaInaO5lKFdDrxZ3QwlOLD8rg0iE
         txFYinzaXBE0FYBNR7YKOoiMriIlg1RMrcoCb9bKfs19SWG+gakloH7bsja0wKOzqKAw
         yW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wCpJ0YTkWuVc6rGTT6nw4giHLC0mtnxopcpcEXj8EY=;
        b=eBeGpIDB45ZTyu2QsjmCd529DEN/XgW1OOkRwHUc4LDQAo+uj7wm0m47eGL8gU3rSN
         hkpvzBasM4RGxJ2nMNt/EM+l5dLJSzmnR+nehB80iJw1gjyr4hTiSgg9Ujc3FkRYCyV4
         xdbOmMt7yCLIaLKQJTnu9jabf+Uu71xHWpOYSgvfu5dwhxolvN960LaMs6mK1Jm3Y64Q
         L6M6Ya3le/nj3Om1v8tplHXVrRTFsZQDdV/tLnp1bNgVx8GehRxq7Yua/LZhpgokFMX4
         WYfeQoyDvgJpfFSBCmAg0A6NuTA2nJmBhmTw2M6hoSHqiLfoYuBKa2ogl4q8WMbJv6WM
         HQlg==
X-Gm-Message-State: AOAM531xz/QFFA4KDto7aDixLFR3kH9v5AlHHLJRw4QRxipl5mfDHHXQ
        HuQ1XjGNJDXrI7t3he8UXjfDBg4mfW581BP62JY=
X-Google-Smtp-Source: ABdhPJx9PH6pV4sWoNQJrSVNLMf7wnqBA7dyiEni2tDseyN5Wg8iYX7olEyDEHtBtcVVmO7qj5LNmQ6zswH2z3ELSiU=
X-Received: by 2002:a92:d8c4:: with SMTP id l4mr23466880ilo.38.1608702000970;
 Tue, 22 Dec 2020 21:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20201222191618.3433-1-lars@metafoo.de>
In-Reply-To: <20201222191618.3433-1-lars@metafoo.de>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 23 Dec 2020 13:39:24 +0800
Message-ID: <CAAfSe-vy6Hv1Zxa+z+9dneGtamJOJ-_fu8VcJTm7EshnNfWTfw@mail.gmail.com>
Subject: Re: [PATCH] iio: sc27xx_adc: Use DIV_ROUND_CLOSEST() instead of
 open-coding it
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 23 Dec 2020 at 03:16, Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> Use DIV_ROUND_CLOSEST() instead of open-coding it. This makes it more clear
> what is going on for the casual reviewer.
>
> Generated using the following the Coccinelle semantic patch.
>
> // <smpl>
> @@
> expression x, y;
> @@
> -((x) + ((y) / 2)) / (y)
> +DIV_ROUND_CLOSEST(x, y)
> // </smpl>
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan

> ---
>  drivers/iio/adc/sc27xx_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index aa32a1f385e2..301cf66de695 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -307,7 +307,7 @@ static int sc27xx_adc_convert_volt(struct sc27xx_adc_data *data, int channel,
>
>         sc27xx_adc_volt_ratio(data, channel, scale, &numerator, &denominator);
>
> -       return (volt * denominator + numerator / 2) / numerator;
> +       return DIV_ROUND_CLOSEST(volt * denominator, numerator);
>  }
>
>  static int sc27xx_adc_read_processed(struct sc27xx_adc_data *data,
> --
> 2.20.1
>
