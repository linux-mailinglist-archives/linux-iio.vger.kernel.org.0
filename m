Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289F535EE53
	for <lists+linux-iio@lfdr.de>; Wed, 14 Apr 2021 09:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhDNH2C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Apr 2021 03:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhDNH2B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Apr 2021 03:28:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CC5C061574
        for <linux-iio@vger.kernel.org>; Wed, 14 Apr 2021 00:27:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u14-20020a17090a1f0eb029014e38011b09so5528115pja.5
        for <linux-iio@vger.kernel.org>; Wed, 14 Apr 2021 00:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QTJCD11VGLwKVPLsNPp8/p1s1dGSfjgo6EKiAkQDceo=;
        b=QY8blT0BOJ0uQsIH2qXipfVCwfYP+rY+hQf/pzu8rPKsbG39TMtOtClSRlHz7GLqZs
         IlPtvVw+diwNW+7IOS+d8QAljNYHgNnHmkVXgqSGXXpW1OMWqQI6u36vspYDRHWGOcYb
         nV/TPqpeVxHJQU/NnUD+DYxkkkUlwxRxYi+rqXrQfJ9djFid5sA9zcXY+/Uk6tyD7WDB
         vjHzWeeqwGZv+jljGHciLkPq8R+0Mle+SnCKEYGu55c0y1W6EHCZy08kc0bfFNknPkDa
         DVfvl3B+LhCRHBi4yQNjso+onnC0ZQOgtjOv3f6YyGbXnNHtyZJ44y7scsEULY+yYn+1
         P5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QTJCD11VGLwKVPLsNPp8/p1s1dGSfjgo6EKiAkQDceo=;
        b=F3Xuxv+UChmI5HjzZiI21XbfiIS4hE+k6dZwer14WWQ7pUw6ZSdmIRO15IKrOo7KHt
         3CWzc1TdvU2N4x9ENK09nmRDFltR4FTWslLGT8wtVb+K6QsNuZdQLaZZdsI99t1Lhgr7
         s6kj78vt4+ufnO8L57TIMCYcM9nEiNThtyqHbD9Pd0qs/rlj+bhdfDb1Xa+5pvHBRK4o
         npRAiFKFpsel+igXLBIrFOy32Zwln9nZ+K8ForRkKn9IXF3Ia8cnyKDrbf6A8Sn11mlv
         RfcXPSKzyP928qcn+UoSRs7TXkRG+RQnFarCIo5q4mM/oTESagvnmAPdpQogAiQCYKuv
         TSog==
X-Gm-Message-State: AOAM531tcH1gDJyDDN/ll2Q1Zeh0SukhgNUwIPpqF/fzTtLkRPkBXK5+
        2/PRcNfKEjjOxFVacsq+xCGxBqVjJGFJFqGaPa8=
X-Google-Smtp-Source: ABdhPJzA27futNkaHtiRsErNz9y5V+XDviUHI10pPuHEYj4ZTTECfA6gksBaFp+3D+Kj7fFexHdfV/kFq8ah+OzuSs4=
X-Received: by 2002:a17:90a:ae10:: with SMTP id t16mr2203740pjq.86.1618385260544;
 Wed, 14 Apr 2021 00:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210413112105.69458-1-nuno.sa@analog.com> <20210413112105.69458-4-nuno.sa@analog.com>
In-Reply-To: <20210413112105.69458-4-nuno.sa@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 14 Apr 2021 10:27:29 +0300
Message-ID: <CA+U=DsqFJ_qJk_vnyvxJeN0Cfm9uN82RfWmvrNV5uDX7qgWPGA@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio: adis16475: do not return ints in irq handlers
To:     Nuno Sa <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 13, 2021 at 5:45 PM Nuno Sa <nuno.sa@analog.com> wrote:
>
> On an IRQ handler we should return normal error codes as 'irqreturn_t'
> is expected.
>
> Fixes: fff7352bf7a3c ("iio: imu: Add support for adis16475")
>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/imu/adis16475.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index 1de62fc79e0f..51b76444db0b 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -1068,7 +1068,7 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
>
>         ret = spi_sync(adis->spi, &adis->msg);
>         if (ret)
> -               return ret;
> +               goto check_burst32;

This is also going to call adis16475_burst32_check().
Which in itself is [probably] an undesired behavior change.

Maybe this needs a new 'irq_done' label?

>
>         adis->spi->max_speed_hz = cached_spi_speed_hz;
>         buffer = adis->buffer;
> --
> 2.31.1
>
