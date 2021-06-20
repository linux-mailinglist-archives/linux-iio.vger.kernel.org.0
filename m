Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F983ADF39
	for <lists+linux-iio@lfdr.de>; Sun, 20 Jun 2021 17:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhFTPk2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Jun 2021 11:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhFTPk2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Jun 2021 11:40:28 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B81C061574;
        Sun, 20 Jun 2021 08:38:15 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id w4so11465990ior.1;
        Sun, 20 Jun 2021 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t9nRTPbnhGrw692xFrKpmDKEFOhh/bXE3l+WNqjS9YY=;
        b=m7mZ2bkAl82i0pDvmQsv6CZp2BngHDLDC3Kcnyn7dJhZ/7hBn+Lb8bWHgDVljYqOv4
         /xeWCFi0zdwFZRTlq2hO7KQvFZ9ZTS7rIjPbxkitFcDxXIct5m9wAyn/l4PLTqB0i1n5
         TLJZOKC7OJVIRiPT4IWkkhOewy7pyTkM7MaLDAXRkT7SDsD68j3//kV3+uCLd+2nOjis
         8M2rKYzsxhLFH4FJmAgkGhv+1wZTAMEsONkzbHWFFbrfK87yhhwIntP0k+g5IiH8WFyP
         +tSwr1d/mTJ8Y2T4sjIp572FICPdNG6C9wg/aahS3LDwCBlsmmSmj88yqKccv2nCiXm9
         CpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9nRTPbnhGrw692xFrKpmDKEFOhh/bXE3l+WNqjS9YY=;
        b=SmA5rQB2lH6KOEW62yoEPVpNmrfogb0aUlFy7yEstSNfOqW9km4Pvwm/N6QJcV6eLG
         3U8jShvcrNu4MZJsXLI4IgFLGq8B0O9Li94kTdREJ/wmoTo3HdmGKJP9+VJt1hdXXdIU
         8OrpG5iup7uZ8KeTrDdVJKi+bfxUw9o448WbiqnPHby1hEBi3c7i5SRQ/4Q6YieWJc31
         rYJr2iiyiQZeu5FIQi/EKX6RZ8B2gs5sYjVeda2UZzjMb/HqcU41DZMM93YkSToVI+Yy
         98JZYcyJ8zNRu7Cb58yi20VGHQpfcelWEmvjGQatwf/rGO7IxWXKGNwZravB9lddhkcd
         021Q==
X-Gm-Message-State: AOAM530Mv3yCmu8o45l5ftG5KOkju4ETkRN8+8DnjgD+FWvr6jMkUWaA
        RyhYWhhIuT228CgVFHrXxozB6B6sMWlamuotdk8=
X-Google-Smtp-Source: ABdhPJxyS77TVcD48cyioNG5xND9rGryPMELVZx/9zA6zfr0UfoQrcrZRk9EL1TDU4jgVug0rUDhdA9hIbXNkc1n4Os=
X-Received: by 2002:a02:9f12:: with SMTP id z18mr13326563jal.54.1624203495189;
 Sun, 20 Jun 2021 08:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210610012923.146727-1-vilhelm.gray@gmail.com>
In-Reply-To: <20210610012923.146727-1-vilhelm.gray@gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sun, 20 Jun 2021 21:08:03 +0530
Message-ID: <CACG_h5o9gK45k3fNUFLMoDi+i5PAMWJssvfXR-pnj=fyCBjQtA@mail.gmail.com>
Subject: Re: [PATCH] counter: 104-quad-8: Return error when invalid mode
 during ceiling_write
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 6:59 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> The 104-QUAD-8 only has two count modes where a ceiling value makes
> sense: Range Limit and Modulo-N. Outside of these two modes, setting a
> ceiling value is an invalid operation -- so let's report it as such by
> returning -EINVAL.
>
> Fixes: fc069262261c ("counter: 104-quad-8: Add lock guards - generic interface")
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/104-quad-8.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 09a9a77cce06..81f9642777fb 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -715,12 +715,13 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
>         case 1:
>         case 3:
>                 quad8_preset_register_set(priv, count->id, ceiling);
> -               break;
> +               mutex_unlock(&priv->lock);
> +               return len;
>         }
>
>         mutex_unlock(&priv->lock);
>
> -       return len;
> +       return -EINVAL;
>  }
>
>  static ssize_t quad8_count_preset_enable_read(struct counter_device *counter,
> --
> 2.32.0
>

Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>

Thanks
