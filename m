Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 065AB192D93
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 16:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgCYP6A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 11:58:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34464 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgCYP57 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 11:57:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id d37so830695pgl.1;
        Wed, 25 Mar 2020 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W1gJ2xQm9pLhyl3IpAZgE4PmhJL0YaJ4OHDS3ohcGvQ=;
        b=aD/rHuginT6Lh5StzDcokjsw7RapYazNrnsuzEKngjxu9i98RQ+5pE6XvLHWPJc8c/
         1sdiyp39z6xbB0FXTmUqHCc7lH/F5EAE3Hzvws+ORcsksW20imt5SLSOUxdCFwe3apJV
         cnLR9TyiHGeoDUmkVBiRLXXHLSrpgcJjsYtRwIW6xctSawWL3GoIlOGAaEdnPjmVCGvv
         2iRPPbJ/8JX6oeg/MSac0MJAstNcxsMRQTb9Pml7fVjDaZpimWV0SX1jQzlEXbnNhFoL
         fgnqNdi/nf4HFqKs1ee3Ee/yc5Vy58QpNb2htCOYhhzIL2EPlU+BDcJy4iAZv9IHnI/Y
         n+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W1gJ2xQm9pLhyl3IpAZgE4PmhJL0YaJ4OHDS3ohcGvQ=;
        b=Jwe7XHMaonmP53OdfoZLYPz6ds3Ou9xnFyByvUaj91xxLms2EF97r7Iq/nShQJGm/6
         6kQtYPqVIrzCYVX7bpTTEtx3k956mw1gCiWV23l4nKRP2fBBbKi3feeIaoCZJS6YoysD
         k66ZW+ub8LDDoZQ3bNC/iPJa79dZ5OqU+DqTRJmYTN9tcuyAmFzfuV+A/u3rElEVEQQl
         whPqPCwmeYGuzuBbSsAT3hKSF8pMnwS/IDuDtPP7dOzDJjAXscR0IZnVjk7hrrYafAX5
         eRV4DdiMJWKLPh7PvmPKMWP9+k/Fhe2UciJo3FWFmCK2qKhMfvjXx3/DFCpfAmn02/j+
         j/Hw==
X-Gm-Message-State: ANhLgQ26n6g6Hy+q+Eox5TARkGhbTI6aGPH5ikTKzA55Ub4CWym5XcyF
        rtx0l1r0AAXKWPwtkbTVm2lqfLVNx35YR/0b79s=
X-Google-Smtp-Source: ADFU+vsTJnfH3AnZqp3Nc1xcphC1UlOK9BOcoOfM8HM3keeSZptNHrLX7pTNZTz166n2F16IaoaMUP1pITmTjjqgey0=
X-Received: by 2002:a63:5859:: with SMTP id i25mr3671432pgm.74.1585151878262;
 Wed, 25 Mar 2020 08:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200320104031.31701-1-alexandru.ardelean@analog.com> <20200325100112.85107-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200325100112.85107-1-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Mar 2020 17:57:50 +0200
Message-ID: <CAHp75VfVggWZ6WhOa=nUrxyd0dJrTbZd9NnUMhQ_S=kncrAhOw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: buffer: Don't allow buffers without any channels
 enabled to be activated
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.ne>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 25, 2020 at 12:02 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> From: Lars-Peter Clausen <lars@metafoo.de>
>
> Before activating a buffer make sure that at least one channel is enabled.
> Activating a buffer with 0 channels enabled doesn't make too much sense and
> disallowing this case makes sure that individual driver don't have to add
> special case code to handle it.
>
> Currently, without this patch enabling a buffer is possible and no error is
> produced. With this patch -EINVAL is returned.
>
> An example of execution with this patch and some instrumented print-code:
>    root@analog:~# cd /sys/bus/iio/devices/iio\:device3/buffer
>    root@analog:/sys/bus/iio/devices/iio:device3/buffer# echo 1 > enable
>    0: iio_verify_update 748 indio_dev->masklength 2 *insert_buffer->scan_mask 00000000
>    1: iio_verify_update 753
>    2:__iio_update_buffers 1115 ret -22
>    3: iio_buffer_store_enable 1241 ret -22
>    -bash: echo: write error: Invalid argument
> 1, 2 & 3 are exit-error paths. 0 the first print in iio_verify_update()
> rergardless of error path.
>
> Without this patch (and same instrumented print-code):
>    root@analog:~# cd /sys/bus/iio/devices/iio\:device3/buffer
>    root@analog:/sys/bus/iio/devices/iio:device3/buffer# echo 1 > enable
>    0: iio_verify_update 748 indio_dev->masklength 2 *insert_buffer->scan_mask 00000000
>    root@analog:/sys/bus/iio/devices/iio:device3/buffer#
> Buffer is enabled with no error.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>
> Changelog v1 -> v2:
> * moved check in iio_verify_update()
> * added dev_dbg() message; should help some folks understand the message
> * documented steps to reproduce

> * added Fixes tag; hopefully the tag is the good one; if needed, it can be
>   dropped; this has been around for ~8 years; no idea if it's worth
>   backporting

Where?

>
>  drivers/iio/industrialio-buffer.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 5ff34ce8b6a2..e6fa1a4e135d 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -686,6 +686,13 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>         bool scan_timestamp;
>         unsigned int modes;
>
> +       if (insert_buffer &&
> +           bitmap_empty(insert_buffer->scan_mask, indio_dev->masklength)) {
> +               dev_dbg(&indio_dev->dev,
> +                       "At least one scan element must be enabled first\n");
> +               return -EINVAL;
> +       }
> +
>         memset(config, 0, sizeof(*config));
>         config->watermark = ~0;
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
