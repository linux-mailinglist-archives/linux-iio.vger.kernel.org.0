Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72635255641
	for <lists+linux-iio@lfdr.de>; Fri, 28 Aug 2020 10:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgH1ITm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Aug 2020 04:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgH1ITi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2020 04:19:38 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE34C061264;
        Fri, 28 Aug 2020 01:19:38 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ls14so189114pjb.3;
        Fri, 28 Aug 2020 01:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gxJQSpCXxi1WnYAw9Fc5qhKkocoEXmXZKaD/Z9zgRIQ=;
        b=TXdwQ62RwIyScHD9xNQmbm3EqzVQQl5Ok5TEBPSLmLv9GkrnfFZmc5UHifHHUmAEmP
         qlN2Xi/HFJ2VqNOYoehVXMyb0vGYV/ua6NP+VjZNpDBfUIqGgPXwWEShh5RAzUrrLjqT
         ISDYpv1y49L/2OCaOOAAALyS9AIjzp4jzuX63kB02k2Mse6AgPqSBk8gumUx/AzpZ+2S
         EBpZ4HkUaXjvyKjTr2Kg2Unor6pKQVnLZy+wef8HVbKXkVr3eWHG3d4XblgoyZmTrT27
         7X55nmvxWYTz/MkynRaynpl5KWixZq7ojCTy4mNoZSpJYwdi2Tcec1CiIENbAduFl0vX
         iT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxJQSpCXxi1WnYAw9Fc5qhKkocoEXmXZKaD/Z9zgRIQ=;
        b=lMGmSbcrbsH37bzhiRC6P/xUaB44FC4SXKbWo9FaHW3s1naVJg/oRCQjF4xmaf91fK
         DkRw68CKq/TrEUdQrmgROuiTnsjmXuyF6oFUIMYB7s0PYo0RbciwJy7ky3ihtiB7Jrev
         165zQqWpVEQ6QEnE/Qkqw73HSSXubc+SNz0qcz5iSnn06O7T8fIC/mb7vBPhKJuY/zx2
         SEGRBEx8P7upAW2UbobphuERQ34FfgCeU2NT8xUlOjXagyEgFbIhPqTuY3KLb4DL/sm+
         hFN1afJNDticrUm4BujwXzZmw3WbJgBvGCsLiQjnjKRK8bSQIMWUb1zw4gU8pQQDrLVs
         GmHA==
X-Gm-Message-State: AOAM533IW9FGu8q2QnIpiPjChuzdKv7MGiAmoKUFJPSb1OHWD4y4o0UI
        0R5R4sY4oExZF7NYGe8wgFkZIGoVjtNOTEeRxqU=
X-Google-Smtp-Source: ABdhPJxHn+DU4r1ZZG495pnIGcxZ6HwtRZ3XqraQ4JKluQntqsoxRjbrmoAk0shVnBcHuS7Jwm3wKRBVyHV4/ikLWNU=
X-Received: by 2002:a17:902:b194:: with SMTP id s20mr393603plr.321.1598602777844;
 Fri, 28 Aug 2020 01:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200827201707.27075-1-krzk@kernel.org>
In-Reply-To: <20200827201707.27075-1-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 28 Aug 2020 11:19:21 +0300
Message-ID: <CAHp75VcnV8_SRQuiTnzzaWxfA1m37gVXfxgPkH51tbMT+-T2RA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove bouncing email of Beniamin Bia
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 27, 2020 at 11:17 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Emails to Beniamin Bia bounce with no such address so remove him from
> maintainers.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

I guess Reported-by suits better... But okay.

> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio <linux-iio@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  MAINTAINERS | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8107b3d5d6df..523ac1602b62 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -967,9 +967,8 @@ F:  Documentation/devicetree/bindings/iio/dac/ad5758.txt
>  F:     drivers/iio/dac/ad5758.c
>
>  ANALOG DEVICES INC AD7091R5 DRIVER
> -M:     Beniamin Bia <beniamin.bia@analog.com>
>  L:     linux-iio@vger.kernel.org
> -S:     Supported
> +S:     Orphan
>  W:     http://ez.analog.com/community/linux-device-drivers
>  F:     Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
>  F:     drivers/iio/adc/ad7091r5.c
> @@ -1000,7 +999,6 @@ F: drivers/iio/adc/ad7292.c
>
>  ANALOG DEVICES INC AD7606 DRIVER
>  M:     Michael Hennerich <Michael.Hennerich@analog.com>
> -M:     Beniamin Bia <beniamin.bia@analog.com>
>  L:     linux-iio@vger.kernel.org
>  S:     Supported
>  W:     http://ez.analog.com/community/linux-device-drivers
> @@ -1068,7 +1066,6 @@ F:        drivers/iio/imu/adis16475.c
>  F:     Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
>
>  ANALOG DEVICES INC ADM1177 DRIVER
> -M:     Beniamin Bia <beniamin.bia@analog.com>
>  M:     Michael Hennerich <Michael.Hennerich@analog.com>
>  L:     linux-hwmon@vger.kernel.org
>  S:     Supported
> @@ -1136,7 +1133,6 @@ W:        http://ez.analog.com/community/linux-device-drivers
>  F:     drivers/dma/dma-axi-dmac.c
>
>  ANALOG DEVICES INC HMC425A DRIVER
> -M:     Beniamin Bia <beniamin.bia@analog.com>
>  M:     Michael Hennerich <michael.hennerich@analog.com>
>  L:     linux-iio@vger.kernel.org
>  S:     Supported
> @@ -16537,7 +16533,6 @@ F:      drivers/staging/rtl8712/
>
>  STAGING - SEPS525 LCD CONTROLLER DRIVERS
>  M:     Michael Hennerich <michael.hennerich@analog.com>
> -M:     Beniamin Bia <beniamin.bia@analog.com>
>  L:     linux-fbdev@vger.kernel.org
>  S:     Supported
>  F:     Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
