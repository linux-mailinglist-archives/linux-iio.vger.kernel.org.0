Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FD221C4C4
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jul 2020 17:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgGKPIl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jul 2020 11:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgGKPIl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jul 2020 11:08:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C328C08C5DD;
        Sat, 11 Jul 2020 08:08:41 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so3441285plo.7;
        Sat, 11 Jul 2020 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQvs3fHvv9Fkjtgdt9Tsxnn3h6ei6m8hcchByCZR5HY=;
        b=epAoZmB/f07JzI9Yc+QctLwKc0hvk4AvWpFa/BT9ZouzIYPP9i8z2n5NrA65EKv/ce
         alBjQSbjOiB+jqnI+cxqp1TMFlqAP3VUWEe090EruPIhzL37jfFkvHgBiwL/p5+FJWOt
         fHp9T37FE1Zcv3RMB9tP8hk692s9V3v4l+1K9BM6Jnjh49lpyaJ3X2qg5Rv813tHQ7Ne
         xPLVV/UZ6yb8wXsbEWlqKroZNzQrWeUwwpY/DJ5OoURTpxvPvQ+203SexbO8wSW8MaAB
         0dmn4p42I3uuQotJAAuy5tO4SgYKJmv0VfyHYCUOLINc/h2mWrpDfeJz6vy0rTfUf6GX
         AtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQvs3fHvv9Fkjtgdt9Tsxnn3h6ei6m8hcchByCZR5HY=;
        b=ao746FefwpbugGw2Hde4Y55rTx81sAwT7SI16UFyioxiqKFCntVokFujToEIbpqw2w
         juxX3bDlh69xPC0lqdz8LrdjrlFWIdLcpPcSw6Oom6RkX5dPXMdwoGz6x7MnMdKuxBDl
         OyKnGcR+VK+WAVYZCXecN23Smvv2UWKoSRQ8kfUzd1YWXfevGh/JMAlLqRpKnpy5wN1E
         UK4TVC2M0igDvhKUUJdCnlS2+fqLBJIEJ63MgkQh0NYLIQJozHt54lTku3ide2x98isa
         isyBBY65xSemy/0SlWaoDPp7B2xdRuv7IRLJjzJtyDVETMC+U0fbY5RByzssU6Xn7TlP
         vSgQ==
X-Gm-Message-State: AOAM532Y9TtHtkxMd/TCrBbgGau53FPjV5jgdQThEZ+F5kx1LPVawVKh
        NdbX1PtaEQRKfIYDkEPRBxrdI7uMhX/B6ThrmmM=
X-Google-Smtp-Source: ABdhPJxB7TW81S/w+nmuDCmaMiUAOIzAO7PFV1t2WxYhZWoZCzifxtm649ch0qn1OIqOD+IhxA6yZfMc2omHXRBZCZM=
X-Received: by 2002:a17:902:7611:: with SMTP id k17mr63884975pll.255.1594480120624;
 Sat, 11 Jul 2020 08:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200710161516.11625-1-brgl@bgdev.pl> <20200710161516.11625-2-brgl@bgdev.pl>
In-Reply-To: <20200710161516.11625-2-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 11 Jul 2020 18:08:24 +0300
Message-ID: <CAHp75VfTDmyWWxAAky-CmuvO2ge0T1q+woJ8MxjdRQqNJwHS4w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] devres: provide devm_krealloc()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 10, 2020 at 7:17 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Implement the managed variant of krealloc(). This function works with
> all memory allocated by devm_kmalloc() (or devres functions using it
> implicitly like devm_kmemdup(), devm_kstrdup() etc.).
>
> Managed realloc'ed chunks can be manually released with devm_kfree().

...

>    devm_kfree()
>    devm_kmalloc()
>    devm_kmalloc_array()
> +  devm_krealloc()
>    devm_kmemdup()
>    devm_kstrdup()
>    devm_kvasprintf()

Order?

...

> +void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)

Do we really need the 'new_' prefix in the parameter?

> +{
> +       struct devres *old_dr, *new_dr;
> +       struct list_head old_head;
> +       unsigned long flags;
> +       void *ret = NULL;
> +       size_t tot_size;

tot -> total.

> +
> +       if (unlikely(!new_size)) {
> +               devm_kfree(dev, ptr);
> +               return ZERO_SIZE_PTR;
> +       }

I guess here we need a comment of the possibilities below to have
ZERO_SIZE_PTR as input.

> +       if (unlikely(ZERO_OR_NULL_PTR(ptr)))
> +               return devm_kmalloc(dev, new_size, gfp);
> +
> +       if (WARN_ON(is_kernel_rodata((unsigned long)ptr)))
> +               /*
> +                * We cannot reliably realloc a const string returned by
> +                * devm_kstrdup_const().
> +                */
> +               return NULL;
> +
> +       if (!check_dr_size(new_size, &tot_size))
> +               return NULL;
> +
> +       spin_lock_irqsave(&dev->devres_lock, flags);
> +
> +       old_dr = find_dr(dev, devm_kmalloc_release, devm_kmalloc_match, ptr);

> +       if (WARN_ON(!old_dr))

Under spin lock? I would rather see spin unlock followed by WARN.

> +               /* Memory chunk not managed or managed by a different device. */
> +               goto out;
> +
> +       old_head = old_dr->node.entry;
> +
> +       new_dr = krealloc(old_dr, tot_size, gfp);
> +       if (!new_dr)
> +               goto out;
> +
> +       if (new_dr != old_dr)
> +               list_replace(&old_head, &new_dr->node.entry);
> +
> +       ret = new_dr->data;
> +
> +out:
> +       spin_unlock_irqrestore(&dev->devres_lock, flags);
> +       return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko
