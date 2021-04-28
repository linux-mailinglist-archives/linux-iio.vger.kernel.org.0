Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B336D2B2
	for <lists+linux-iio@lfdr.de>; Wed, 28 Apr 2021 08:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbhD1G75 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Apr 2021 02:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhD1G74 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Apr 2021 02:59:56 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCBBC061574
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 23:59:11 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i190so3484856pfc.12
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLhEjfKOgJGYKMGBZQlTD+O6x79WCCSZBckmm9XoeiI=;
        b=kbxK0sXG7Dvtpo1e+W+Z3ISEEnftCkol/mBDo56SzMr98LPPtcthiAmScXkLO/Q3uc
         /mvT2HngrKwQuwi2KQuvpshjM1rWlQVptbhxbSK0f6Vqs1kmJSMePU2OXabQugFvstIL
         8MclDFMHSppLvOfQWbro/4z99qpWJ7FyFqm7erxquLIte8K+xwovXERRWpPzLdqCQthg
         gSyYzCGwoLl2P2GluN9qFa4WCDoiU2sI/Cz96bV2KeVuMoulx/LJk5EMPUFnkluT/ra/
         jXuFbTMH7UtSTst8gJ8PoGlOtZarxuhxylQSc2lFLNCG3w3LxPdo3igVqND6g2ViFQ9y
         SzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLhEjfKOgJGYKMGBZQlTD+O6x79WCCSZBckmm9XoeiI=;
        b=HniB7bdGQjqMApSRhKMT7EHKpOwAqxgYdPrP/SgJvR7CzVg2/5AztbbjjuoqFSYAwg
         Os4vJUgQUON8AswpwNPGcILnKhAcXi2RYvZjhbjcNI2ywyEq43pAYBrHgUNiUNnj1uG2
         41xotO4LrOKSHLav4XMxLM8mEd7iEIO8LeVYDb5V/mc8KYZFUivIkC2vofZeTy8+v3At
         vhU7ThwqJZZHG/9NG0agCkM3E00v1zNTYuk2jipsrbi6wA7Rvncb8twPSIZjAn3NZyHz
         gulS346buzbV2vc/22tLtOn1Apxz0wNOSqrui5DoQYyJz5VAVwIiJwaYS5UZFtqaHZDZ
         Dn7w==
X-Gm-Message-State: AOAM530G/Hn11rzComE+DtfAWPgUagJhX26eTNnRXYi4HX7YyCHp5LCe
        zk8pv367erIN7qKpqFXGbdVWdzExB50p+9rJJj9S2wep4Vc/Rw2i
X-Google-Smtp-Source: ABdhPJwNbblWnRbiwMLhrLRw8aEQTVEcEzUMfoZguO4pGJcRs0g7KLS4ZS3/v9gHXwFmdB+6jLs/AtqarV+ukYcxxuM=
X-Received: by 2002:a63:541b:: with SMTP id i27mr25106507pgb.41.1619593150219;
 Tue, 27 Apr 2021 23:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210427085454.30616-1-nuno.sa@analog.com> <20210427085454.30616-3-nuno.sa@analog.com>
In-Reply-To: <20210427085454.30616-3-nuno.sa@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 28 Apr 2021 09:58:59 +0300
Message-ID: <CA+U=DsrkaVscojNztDedV_04vUnJhNHjMc_B6M1tFuO44wAq+w@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] iio: adis_buffer: update device page after
 changing it
To:     Nuno Sa <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 27, 2021 at 11:53 AM Nuno Sa <nuno.sa@analog.com> wrote:
>
> It makes more sense to update the device page as soon as we we
> successfully changed it. Moreover, a follow up patch will handle
> 'spi_sync' error path which would leave 'current_page' in a inconsistent
> state.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>


> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/imu/adis_buffer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index 0ae551a748eb..4fc0e0ca7561 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -140,6 +140,8 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
>                                 mutex_unlock(&adis->state_lock);
>                                 goto irq_done;
>                         }
> +
> +                       adis->current_page = 0;
>                 }
>         }
>
> @@ -148,10 +150,8 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
>                 dev_err(&adis->spi->dev, "Failed to read data: %d", ret);
>
>
> -       if (adis->data->has_paging) {
> -               adis->current_page = 0;
> +       if (adis->data->has_paging)
>                 mutex_unlock(&adis->state_lock);
> -       }
>
>         iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
>                 pf->timestamp);
> --
> 2.31.1
>
