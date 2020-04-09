Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 211EB1A31AD
	for <lists+linux-iio@lfdr.de>; Thu,  9 Apr 2020 11:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDIJRW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Apr 2020 05:17:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42444 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgDIJRW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2020 05:17:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id v2so2250407plp.9
        for <linux-iio@vger.kernel.org>; Thu, 09 Apr 2020 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=166+Rg61EmrM5Xe9u/8IysSUrY+COOe+fljsDUkxeh8=;
        b=fjYfhK2MHVzRbI8vksLE2pN2QHbCidfvHacPlP3bTUCfoJnmESUVNNjYJk1oIVtMiW
         QgtM4Wa5V5w2a5XEN7UinVTpD/rbnrGAeXnIpz7uBglJ+0cJ+jQQJ+s6ik1x39avkeJO
         vESsKlf+GG9BrdglvZ1hLCZ+04qso7nTX91W6JwrcnHA7i9pBVqIr802nx3o+BEl17bw
         L4YMF3Vnx0scikkpK7C3hCGio3AYSD8smlqVxBHiPfoUxGgZSJU+xpqBcgFGbyJ51rWI
         1MGauy1c7kx1K96cZy/XOSP+/j8rsZNUSL6RdVHlflb5f+8fEzaD1T1FpdoNUZQMIpye
         xxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=166+Rg61EmrM5Xe9u/8IysSUrY+COOe+fljsDUkxeh8=;
        b=W0ujnKVN4hkHn1mp/kxvLAiGuPJNCOBcOTrBXXfhsanocybUX8IPbUu0ctEW1Cz+Dt
         ZZs7j/TZe562psgeoLL6wbmBMCqp08JjFn/5PRGEiYi8j2+7E9BKuDXjw1J2VPRM55T0
         kwNlBx0nYnUDn/wNtJ4TAX7ce8A9Xn9iqfHC7guZQZ/UmQUfIuV8D6ZjCkeilX1y6vtP
         MUYHTd26EjeARrNwlvZ4Io/8CfZPRl+lPL9rGGEDINDGloJQzTSl/Rqc2dWW1+VDgmt9
         +1V5B+1OBNBFWRqYdI5WUrT5QUBvmi+p92M/k4mOHyd8tC2UzujeMRw40KjS5mjjplSE
         gIKw==
X-Gm-Message-State: AGi0Pua3ungeUPvqMbCKfS0+4/HxgeemJWAe30H6jfjZDn7lVnaWclKJ
        YP5QwdX7TXTN/FE4WjqcZ66BYQC8N4qq+OaSHtBvSDRVmj4=
X-Google-Smtp-Source: APiQypI2gGZTv8xzev8HQJi/Tae7gDqmg07kjbfLPe5YfjzgOwQVIhqtUW3RY3MwuzOd61vXnpgeYen5zKk6e2+lTAw=
X-Received: by 2002:a17:90a:364c:: with SMTP id s70mr7084962pjb.143.1586423842500;
 Thu, 09 Apr 2020 02:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200409085818.9533-1-alexandre.bard@netmodule.com>
In-Reply-To: <20200409085818.9533-1-alexandre.bard@netmodule.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Apr 2020 12:17:10 +0300
Message-ID: <CAHp75VeqOBVpcVSnd9W+noOZf9auecpEc6J7O+5RhX_V=hKSeg@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix reading array out of bounds
To:     Alexandre Bard <alexandre.bard@netmodule.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 9, 2020 at 12:00 PM Alexandre Bard
<alexandre.bard@netmodule.com> wrote:
>
> Former code was iterating through all possible IDs whereas only a few
> per settings array are really available. Leading to several out of
> bounds readings.
>
> Line is now longer than 80 characters. But since it is a classic for
> loop I think it is better to keep it like this than splitting it.

Agree.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Alexandre Bard <alexandre.bard@netmodule.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 84d219ae6aee..be8882ff30eb 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1350,7 +1350,7 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
>         int err, i, j, data;
>
>         for (i = 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
> -               for (j = 0; j < ST_LSM6DSX_MAX_ID; j++) {
> +               for (j = 0; j < ARRAY_SIZE(st_lsm6dsx_sensor_settings[i].id); j++) {
>                         if (st_lsm6dsx_sensor_settings[i].id[j].name &&
>                             id == st_lsm6dsx_sensor_settings[i].id[j].hw_id)
>                                 break;
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
