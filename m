Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D82C36F79A
	for <lists+linux-iio@lfdr.de>; Fri, 30 Apr 2021 11:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhD3JLm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Apr 2021 05:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhD3JLm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Apr 2021 05:11:42 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D40C06174A;
        Fri, 30 Apr 2021 02:10:54 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b15so3787355pfl.4;
        Fri, 30 Apr 2021 02:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMBkRTRyBJe8566RchXhObOwCiTu3fRmf6ouLD4NYAY=;
        b=VQZwnbbmuEBDy5RDdGd/CIfEeSI/IZJPE7oIKcDHuh4iXuiR2wojK6WP5cnpWbNED1
         R8bUGDrXOGwvUWYPnnxbAUekRoaXuX/kM6cSt4y5KDwrGo1ZMudB2+MdTDrhVgpXlUiN
         2laVNKIugwXCYzXoOH4dC1vZRFAuW2MC+PHRze2oe5C9NQ4Y7SimOJTiT/TGQtRcBA/S
         P8XLm+lkGKjS0Eq0wPsaSqFwyFm097lzWn2PtFqGfT7SUWHmOTJUJf2NLcy2ZP8Vd4GU
         ErBK1JWR1DP7TiCHWVYzTDIGGsCbM0S2Iqbwg2YiaCGGj9/aXJm2XETcdbO3fYLQs2W/
         VCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMBkRTRyBJe8566RchXhObOwCiTu3fRmf6ouLD4NYAY=;
        b=bABMtGkzgaPfoR43fuvrJMNizwYsRN7MbURo/3L0oPsEd760/I+BeBqgkmZPAfg4po
         YvvfYOGGC2Ndkg8a+KhN8bYF3o3yp7WdFjDqjLosMOwDktumf8oM6vNH0fAvk/1Pkd3z
         A/LM66xGN9WX+YY4c6lgWVTibp+9a/381CpVAijWolnEapnxpPV7X2mKciqKhSpByIlo
         /fN/yxQyEeJJ1rqWPYwLJApbDZakmEwiivVhgHbqjQ/58IEHl+0v57a7tjcjTyE9dOw1
         Jx8nLUmNRwyS4CeI+0CQ1lbgu0doMJxmK9v9OoJFp+4c08FsFAerjsxU3eec85cOKHqk
         8KQw==
X-Gm-Message-State: AOAM533MtskCWT5J3hWaVYUgv7Vi5PEdygVE4NIsRGId9GnY2BmNJ+oQ
        1y8B5MR3H0MHLZgVgmT2Bo1j8dwJztRlckMA/go=
X-Google-Smtp-Source: ABdhPJyfCScH2hZyrJoUncFRV5p58wcdmiMiH++2R+/zWxQGXvkyJMaan5rii5L8E9Rn2s034Eys5WF6EntOhiqvZYs=
X-Received: by 2002:a63:a847:: with SMTP id i7mr3700088pgp.203.1619773854302;
 Fri, 30 Apr 2021 02:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210429122806.3814330-1-sean@geanix.com> <20210429122806.3814330-5-sean@geanix.com>
In-Reply-To: <20210429122806.3814330-5-sean@geanix.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Apr 2021 12:10:38 +0300
Message-ID: <CAHp75Vcutrga_WQGpYAfB4DcdMmDfpPNmaGDwvOFUCQM-2+oKw@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] iio: accel: fxls8962af: add hw buffered sampling
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?B?TnVubyBTw6E=?= <Nuno.Sa@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 29, 2021 at 3:28 PM Sean Nyekjaer <sean@geanix.com> wrote:
>
> When buffered sampling is enabled, the accelerometer will dump data into
> the internal fifo and interrupt at watermark. Then the driver flushes
> all data to the iio buffer.
> As the accelerometer doesn't have internal timestamps, they are approximated
> between the current and last interrupt.

...

> +       int ret = 0;

Redundant assignment.

> +       fxls8962af_standby(data);
> +
> +       /* Disable buffer interrupt*/
> +       ret = regmap_update_bits(data->regmap, FXLS8962AF_INT_EN,
> +                       FXLS8962AF_INT_EN_BUF_EN, 0);
> +       if (ret < 0)
> +               return ret;

...

> +       if (reg & FXLS8962AF_BUF_STATUS_BUF_OVF) {
> +               dev_err(dev, "Buffer overflown");

overflow

> +               return -1;

Proper error code, please.

> +       }

...

> +       count = reg & FXLS8962AF_BUF_STATUS_BUF_CNT;

> +

Redundant blank line.

> +       if (!count)
> +               return 0;

-- 
With Best Regards,
Andy Shevchenko
