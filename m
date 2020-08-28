Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F52255649
	for <lists+linux-iio@lfdr.de>; Fri, 28 Aug 2020 10:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgH1IVV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Aug 2020 04:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgH1IVP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2020 04:21:15 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A2AC061264;
        Fri, 28 Aug 2020 01:21:15 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q3so123706pls.11;
        Fri, 28 Aug 2020 01:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hPzPMvRrv77BBmOrhLeE1sCRQ/ZQAnsF0J3gEikAgzA=;
        b=JP+5CFC9J4zq+DPdRvPxJJc+hikHsnoHs89nPFz/04jCXNkslIAMbMoToQN57/KLsZ
         /cah+/0X2sR5OZ0TrcoQlm2zOakwNHdBaVl738kt1YY2/eVMTHAmgKLuaQqkVeIeF3bl
         OkwClLK24jfP3+h6t3go3mAEFyItEyRo7ddm9uLwTBqDJoBYh8XVISaeHVa82xMjzvFU
         VQpoDIvhWGXuAXuO6GDDlP401utltHFI1x73Lg32xy1bLxVTTOVpwbzNwW2oBzAT9tuN
         SeuxrUY/YdzYifBIB70YeLzmv2aghAgXQ6D8K7KuefSrlQ13CjCmv1gzLvlVn6dOHP8M
         0q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hPzPMvRrv77BBmOrhLeE1sCRQ/ZQAnsF0J3gEikAgzA=;
        b=f5mUANTeVDaClbo00dNGKFrqJqg3HyButKbiwHLiXE9r/00vIMfkfDXXF67tcpODgV
         T2RzEVRD8eDOqcTJdecL0u48IvW15DQRkB1nz4AYU6YYJb0o2smnmS1V/BwVLQIxrq85
         tlYDha7CLC4AdMWkeavgharu27ZOCoBVhQGxCG9Jao6XmNAH+NIfC8LRS+QGFB26qj69
         uL6lfuHznpKlrUwLr/HjeHKhpdt6qJgbwJbl9seEYNfZoaxKE2LAPyQ1Yka7U4Vhup96
         Ke7QsgvQpdAYvD4a0dpQKmov9je+/QcPSO+NmYLGrDsNfizEiiNVfGTfug5hG3bf6ml7
         mBVQ==
X-Gm-Message-State: AOAM532HIP/VwBbiMBh/do8ubyuIDq079zSRpGW6HbjFv86wZceBySum
        nUKbf1GbL7R3CeYt6hu/HA5uIP0ctoFawsuWIe443rGcofDDHQ==
X-Google-Smtp-Source: ABdhPJxJexwvDTwE95+piicUKMhxJHBzj01cyOipRmXIaFbQ8CNvt5Lnf/6mEn6Dg7nr1qekqsoS7CojU5ctLQwD83w=
X-Received: by 2002:a17:90a:2c06:: with SMTP id m6mr262760pjd.129.1598602874866;
 Fri, 28 Aug 2020 01:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200827202452.27714-1-krzk@kernel.org>
In-Reply-To: <20200827202452.27714-1-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 28 Aug 2020 11:20:58 +0300
Message-ID: <CAHp75VdE-Nxr7yDPPyRjG2vJZs-nkZowi+daUJTKK348Su_Pow@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Move Hartmut Knaack to Credits
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 27, 2020 at 11:25 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Hartmut Knaack was an active reviewer and contributor to the IIO
> subsystem and drivers.  However last message on LKML from him was sent
> in October 2015.

But this is not a problem we solve here. His address is invalid for a
long time...

> In thanks for Hartmut's effort, move him name to the Credits.
>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio <linux-iio@vger.kernel.org>

> Cc: Hartmut Knaack <knaack.h@gmx.de>

...and this?!

Reported-by: ?

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  CREDITS     | 4 ++++
>  MAINTAINERS | 1 -
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/CREDITS b/CREDITS
> index 32ee70a7562e..edb81e3159b1 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -1953,6 +1953,10 @@ S: Am Bergfried 10
>  S: 63225 Langen
>  S: Germany
>
> +N: Hartmut Knaack
> +E: knaack.h@gmx.de
> +D: IIO subsystem and drivers
> +
>  N: Alain L. Knaff
>  E: Alain.Knaff@lll.lu
>  D: floppy driver
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 523ac1602b62..1276833532c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8532,7 +8532,6 @@ F:        drivers/iio/multiplexer/iio-mux.c
>
>  IIO SUBSYSTEM AND DRIVERS
>  M:     Jonathan Cameron <jic23@kernel.org>
> -R:     Hartmut Knaack <knaack.h@gmx.de>
>  R:     Lars-Peter Clausen <lars@metafoo.de>
>  R:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
>  L:     linux-iio@vger.kernel.org
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
