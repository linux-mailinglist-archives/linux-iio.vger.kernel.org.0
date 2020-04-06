Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65FBE19F39F
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 12:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgDFKf5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 06:35:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39342 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgDFKf5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 06:35:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id g32so7345940pgb.6
        for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2020 03:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5etakOwU3XyVklI2VysvJp4k/EArL8+v49XAvT36GpQ=;
        b=ZloKbOSSL0aZcJbi6jtLN086jeYVCgkv51CJMYUOKvtsYBGqDGkQChjiWAgHcpT5kh
         G+SeUc7Rf6z14rQnma14CpwvpjBLuuWUbuR96DshhKYO5vrT/FO/jDiwQtA52SjrUlBG
         YdefsnbkGN+A23U7hY7OkAu+kqEyNuXaRQ0aAoNvoPNILBytWAtX2plsUwiWitGnHP4x
         W7bdM+GITZrwNL6qGJYMDwUlGJrM6tFhTFIRKqXZtbl+9sPwnAh71HIaCoco/dLdtvYM
         jLNvuvLSI68t9WkJbCyKY0+Y2PGmVsmoXbwjIblsj7tZV6wYbDavA2tTGpseHUjvTaWg
         XwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5etakOwU3XyVklI2VysvJp4k/EArL8+v49XAvT36GpQ=;
        b=jQJpPpPGlZESHwaRWd79hNL2+0lVqsKlfOsnz2hzKRRcwYrRhZfiM3dtRJ2fZddhlX
         BlwtkAFsYZDu0IDKBlZkyWncXLMMVuuL37lylzPkxSiEMCFYW9joRjSZwGsocM8WyHRK
         lQfiWR/MyTzO/rgetyW5MZ2aP2SsgtBeCMfpx9ZMTAfjhdj1/axVRquppy8T8h4Prtve
         xr2suu2F1yPp8TEls8SGd8cpa11tqVlZorMdBSFiYZdUS8ed5iM5OlO7mxtSA2FdlcdG
         fDEJnD1pZ/Pq/Ht6agmKJBW6LqgUQdMSscrHr/b1vbcgWQX6HImwyh0HVG8lDpn14wUZ
         andQ==
X-Gm-Message-State: AGi0PuaWgu6fgDXBtX0dt+4cQpfqEYukkUnYQ4iB8laiRSdNHaw/Mo/1
        AtZTHhLPlBjXgKNFIh6Ps8PkszrDMUR/iGuXRhM=
X-Google-Smtp-Source: APiQypKEC7BSzP1Dy+wzr6fv5Hy5HN+ayMcVKYHHpe4e8Vb22io8a8uTKtt8+fp8QBlq11RObV+SvpD0yS9hgNU7H4Y=
X-Received: by 2002:aa7:958f:: with SMTP id z15mr20142291pfj.130.1586169355742;
 Mon, 06 Apr 2020 03:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <f0ccd740ca61ac0666177425afb5d7067b8074d5.1586168520.git.lorenzo@kernel.org>
In-Reply-To: <f0ccd740ca61ac0666177425afb5d7067b8074d5.1586168520.git.lorenzo@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 Apr 2020 13:35:48 +0300
Message-ID: <CAHp75VeCOYcZwV2eB2Oxg+_EAB7nHP=Ej9mEF3=q7=wRjsoDgQ@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: drop huge include in sensor-hub driver
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        lorenzo.bianconi@redhat.com,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 6, 2020 at 1:23 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> Drop largely unconnected driver include to just introduce default wai
> address and use the value directly st_lsm6dsx_ext_dev_settings register
> map

The commit message is confusing.
Though I now see the issue (the mentioned header is not related to
this certain driver, i.e. st_lsm6dsx).

After addressing commit message issue,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
IIRC it was me, who didn't check this before during review.

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index 280925dd8edb..947ca3a7dcaf 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -28,7 +28,6 @@
>  #include <linux/iio/sysfs.h>
>  #include <linux/bitfield.h>
>
> -#include <linux/iio/common/st_sensors.h>
>  #include "st_lsm6dsx.h"
>
>  #define ST_LSM6DSX_SLV_ADDR(n, base)           ((base) + (n) * 3)
> @@ -93,7 +92,7 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
>         {
>                 .i2c_addr = { 0x1e },
>                 .wai = {
> -                       .addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> +                       .addr = 0x0f,
>                         .val = 0x3d,
>                 },
>                 .id = ST_LSM6DSX_ID_MAGN,
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
