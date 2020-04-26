Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838171B928D
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 19:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDZRvx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 13:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbgDZRvx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2020 13:51:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44029C061A0F;
        Sun, 26 Apr 2020 10:51:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p8so7472843pgi.5;
        Sun, 26 Apr 2020 10:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uw0+Guq6S6Cv2z9fBeBwrsQE1txQIDb+j1fEPNoq3fc=;
        b=Kly7fdieLkDI2x4RTUjbz4KYhnoJsaZRVS5ttqQdYfEvrfOtNGQ12bY+d/HG1WTw3u
         2PHVnfcvmBTJfk4uLgv2IjHGilW+p685poXorWzz1JjkmqMpxKgbNh7M5RUkfPpcWzTe
         RYzGnjXjwO6V7AS/8CG1kXOtFBW0oi5zvDAw+NunsEuJxRs2HfpBRhbOifDEr4cF3LG+
         ubJ5TfHNMmmnJ539LvR0Vfe9Uxe7gNOQDUjt51aR39pZp/Jion/OcurAGQmDnXMOACdB
         PgNj4BH0gy2EVWD+OdSSnHbiJqvHfNocwKlVTVfvZpT0UGFyPcA4Eov3SENpTp9eCLel
         zdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uw0+Guq6S6Cv2z9fBeBwrsQE1txQIDb+j1fEPNoq3fc=;
        b=UwJQpSbHH5AxCt4Rs/H78TZpXILS5vFT9JUfsw+ktYPmS+5PPGU4VlrebaAsExEBLk
         1A7JDGe5+akwlkrMCF4GjNqB5ZIqDLQD5tVhhIchFZnJ5baRpmVYZ2bmtXQVMODYqZVT
         HNLVd/LbsjdVKjMbAgdC8J+Yss6LZ99RVtWhq8Ml6So8CtxETRCk9LPjs8VJpP9Mcqb0
         BH4eyN5dW3bHoeNQopCzvGJORZlwLakFxxB+WjeRm/iiHjVaSIL+P+87mY7hgoiG11cO
         01qIVBcaLoo1/VtdDWcFPTVzljhomAOO4jZEByyd/heNjEfNRdIo8w7ujuy2R7HbOkZM
         DDXg==
X-Gm-Message-State: AGi0Pub0+u5wgay6KwekhXXX1wMsTxbI1sLW8VHTPt6Zat1Hl7gXtjF7
        fRmmrRVQCLOpm+NN6YQF1BzmecAL1RzjrdtmHPfj66VZ2IQ=
X-Google-Smtp-Source: APiQypJZgKKxqfzmvDsyACIiuDphgSNH0/1rhxfCIqnt3nSA6R7kyhNGqw/hgNz8ipMd7id16qECqY9X+UT7hSx8qTg=
X-Received: by 2002:a62:f908:: with SMTP id o8mr19585927pfh.170.1587923512792;
 Sun, 26 Apr 2020 10:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200426110256.218186-1-hdegoede@redhat.com> <20200426110256.218186-8-hdegoede@redhat.com>
In-Reply-To: <20200426110256.218186-8-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 26 Apr 2020 20:51:41 +0300
Message-ID: <CAHp75Ve_PJDVOod7yA5d2OygVy7pe-wBvYxBygrqovbbGTeC8Q@mail.gmail.com>
Subject: Re: [PATCH 8/8] iio: light: cm32181: Fix integartion time typo
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 26, 2020 at 2:03 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Fix integartion time typo and while at it improve the comment with
> the typo a bit in general.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

(Applicable to all patches, after addressing corresponding comments)

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/iio/light/cm32181.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index 878fc13632d8..50cfb7d189df 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -237,7 +237,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm32181)
>   *  @cm32181:  pointer of struct cm32181
>   *  @val2:     pointer of int to load the als_it value.
>   *
> - *  Report the current integartion time by millisecond.
> + *  Report the current integration time in milliseconds.
>   *
>   *  Return: IIO_VAL_INT_PLUS_MICRO for success, otherwise -EINVAL.
>   */
> --
> 2.26.0
>


-- 
With Best Regards,
Andy Shevchenko
