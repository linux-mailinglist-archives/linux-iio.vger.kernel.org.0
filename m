Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3206136C05F
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 09:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhD0HqZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 03:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbhD0HqZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 03:46:25 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6E3C061574
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 00:45:42 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p17so2533951pjz.3
        for <linux-iio@vger.kernel.org>; Tue, 27 Apr 2021 00:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ExTdp2fMdbfEOf+XepFo2gM+B52vMO0JOmpXgGdiU68=;
        b=uwTmDCChiXTERiJ/K6TYh2+7EcnBnxUpONZRF0+ChYM2G0QHky6oXd7FhrmilIh74c
         LSDbj4RpkEJ0aWUHJ+m8+bwYyXh8BKsZ1V5DBrUpzz9BccDZ+zYL+8HSf5DiKWfY12XX
         bkm/4Jhw5pqc/1NiGd0GmIZBqlfvkE2ujgnu08ydEeo2Up0zMU3cNkppkSLIN4b4VIXf
         MF2S695hAvaKzod9QeYESju30xnmSgUnziTZ+Ye8QC+EA0VEoY1l4YIdafFUdQYDDVXa
         wWrkBAIQz97J+t07opT2zhxv+ComrCN+n8wFh2aF32pZ3eE1aWiIOpgRHCQfHHDttOQJ
         9SyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ExTdp2fMdbfEOf+XepFo2gM+B52vMO0JOmpXgGdiU68=;
        b=XMleQB44w0hqAy2nPwjr3smAFwnhbHTwF/rTtWZ0yHKE6o2YDoG90Lul4DmVqTyUk7
         DJ6J04VnMBs4iGhqb48eIeZuqyQdfzzF67Fn+cEeHZPHmax9WDv3Arr7kzHoEy1rro2C
         WqgqqWbqRng8+FIcKdDLRxZeVXf2/YHbG8W1bpm+9/4vbSAhHn9U6D2jq7bIFID9di14
         5y4AogEIEWousgwP8DAuyZ3aPhpHSU3FVTvFW28NCVcoe2nuqoKVpzgEATmhzK7bx4Ur
         pg+/dTNsqeL0l7ns4yky5qZTsD9mAkiOyLt8p2VnCd4DSFwkjfm3wsRtb3HYm1r8wBL6
         xXpA==
X-Gm-Message-State: AOAM5335g/YettkXW1mQ88UuvFNpVYuLLk6cVW9iUx95EXyOkfrDVoA4
        L21vt4n92zLsA8my0o/5606k8KxdzNEVTJ2EZM4=
X-Google-Smtp-Source: ABdhPJwQfqH5r2YQyDzMg3ZLplkeqxt04ESI6kEAGGunCLG1xcFACgLKDl6Lruy2deGHv/fda7DK/uAm0k8FczlMiTM=
X-Received: by 2002:a17:902:ed97:b029:ec:acae:109e with SMTP id
 e23-20020a170902ed97b02900ecacae109emr24271180plj.52.1619509541914; Tue, 27
 Apr 2021 00:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210426174911.397061-1-jic23@kernel.org> <20210426174911.397061-3-jic23@kernel.org>
In-Reply-To: <20210426174911.397061-3-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 27 Apr 2021 10:45:30 +0300
Message-ID: <CA+U=Dsow=ry1pSMAWhRiRWe+6c9YseJPSg0a8fmfXqUusfBaGw@mail.gmail.com>
Subject: Re: [PATCH 2/9] iio: avoid shadowing of variable name in to_iio_dev_opaque()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 26, 2021 at 8:50 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> indio_dev was both the macro input parameter and the field name
> in this macro.  That causes trouble if the instance of
> struct iio_dev passed in is not called indio_dev.
>
> Whilst a fix of sorts, no need to backport as it seems we never
> hit this previously due to some very consistent naming in IIO.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/linux/iio/iio-opaque.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index e66b029d99de..f876e3aede2c 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -48,7 +48,7 @@ struct iio_dev_opaque {
>  #endif
>  };
>
> -#define to_iio_dev_opaque(indio_dev)           \
> -       container_of(indio_dev, struct iio_dev_opaque, indio_dev)
> +#define to_iio_dev_opaque(_indio_dev)          \
> +       container_of((_indio_dev), struct iio_dev_opaque, indio_dev)
>
>  #endif
> --
> 2.31.1
>
