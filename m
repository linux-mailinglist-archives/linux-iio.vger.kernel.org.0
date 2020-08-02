Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1B8235650
	for <lists+linux-iio@lfdr.de>; Sun,  2 Aug 2020 12:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgHBKmR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Aug 2020 06:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgHBKmR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2020 06:42:17 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531C0C06174A;
        Sun,  2 Aug 2020 03:42:17 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x6so3162368pgx.12;
        Sun, 02 Aug 2020 03:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKuu7gkvuJE5MzVZfCiHDi/hvmBPhAGao6jq1cGyiFs=;
        b=kUFeeh69Z/EchoJeuQvG9nJrL5hHS9Dy93DvxlI5pn9kVlJRVl67+xGpDR1g/+uF1a
         8FSxfJNH7J3ow+o/+S9934orEh206zq9Skh1aDYY/LFHYZhqkPfsUsjuzoayx6tT3vER
         DIOnMYEF9sqrkBinimpbhx9uUR9dxlhkLTId4/XBVWl+jMmJ1QtHlv5Hqb8eHtYmCOIM
         IN14v30HbaD5hC8gmf1GGC3ownLiOAaoJQMrffY8xDe3Ju+DYq9x3KcY3m09ATUFRX80
         1m5VS23CxmtgRgViO4mmGPaHG3buJ6n2Ku9ZHKdHTatLq70+tQDlu3j/D3Ug0F2kRIi1
         aLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKuu7gkvuJE5MzVZfCiHDi/hvmBPhAGao6jq1cGyiFs=;
        b=i0YXyetUK3vQLkeuSFPSKdK1R/74OworD+G+aumaCT9lehqwAWZkLFL7Nd0xjeopR8
         dciKcU5Qdk9IGtYOxcxZzbPWLXpunjnhOYHT8zFGEf3TwtbgX4OmJcgyMxdXCU7MIVcf
         3aeMXUIBjaQZfuX1ExdyQvfvKE07PVm7MvvqZhcKrSn6p3V8/DjV+e92Dftn8ja7Dndp
         7xvFA5/LeTA3EahRbB93NUkJSjqRT2ZVhc817DfBgeDNfCG/pZVcYLD4b2tLJU03o6L0
         FiEgNOefTPM63m3mbkFE5LhLkSK30LoU7ZyzpLyu31mKBrCdAhG/UVlvMrKTqPUNswQV
         ccgg==
X-Gm-Message-State: AOAM533tLw/9cUzWs69whhFQIryz88RND+l4FC8x5kdUciQSN2/u5Gbw
        ZSBfhXciMUflVf0S3nrdzDfDNncQh63A6xb9z68=
X-Google-Smtp-Source: ABdhPJye3hDyycAIN6Lix7dUCj9VKkyFCicpeILdxfNpMHn7vhRjp22YSirEy8Q2FZFdQc76RIJiv7nMsGNQNs+Vtes=
X-Received: by 2002:a62:758f:: with SMTP id q137mr10827485pfc.170.1596364936651;
 Sun, 02 Aug 2020 03:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200802083458.24323-1-brgl@bgdev.pl> <20200802083458.24323-2-brgl@bgdev.pl>
In-Reply-To: <20200802083458.24323-2-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 2 Aug 2020 13:42:00 +0300
Message-ID: <CAHp75Vfm_vUKZOGkNp+0uTe0b=vk8yDyjs7XPdw_1GRauTBx4g@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] devres: provide devm_krealloc()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 2, 2020 at 11:37 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Implement the managed variant of krealloc(). This function works with
> all memory allocated by devm_kmalloc() (or devres functions using it
> implicitly like devm_kmemdup(), devm_kstrdup() etc.).
>
> Managed realloc'ed chunks can be manually released with devm_kfree().

Some thoughts below. You may ignore nit-picks, of course :-)

...

> + * Managed krealloc(). Resizes the memory chunk allocated with devm_kmalloc().
> + * Behaves similarly to regular krealloc(): if @ptr is NULL or ZERO_SIZE_PTR,

> + * it's the equivalent of devm_kmalloc(). If new_size is zero, it frees the

equivalent for

> + * previously allocated memory and returns ZERO_SIZE_PTR. This function doesn't
> + * change the order in which the release callback for the re-alloc'ed devres
> + * will be called (except when falling back to devm_kmalloc() or when freeing
> + * resources when new_size is zero). The contents of the memory are preserved
> + * up to the lesser of new and old sizes.

Might deserve to say about pointers to RO, but see below.

...

> +       if (WARN_ON(is_kernel_rodata((unsigned long)ptr)))
> +               /*
> +                * We cannot reliably realloc a const string returned by
> +                * devm_kstrdup_const().
> +                */
> +               return NULL;

I was thinking about this bit... Shouldn't we rather issue a simple
dev_warn() and return the existing pointer?
For example in some cases we might want to have resources coming
either from heap or from constant. Then, if at some circumstances we
would like to extend that memory (only for non-constant cases) we
would need to manage this ourselves. Otherwise we may simply call
krealloc().
It seems that devm_kstrdup_const returns an initial pointer. Getting
NULL is kinda inconvenient (and actually dev_warn() might also be
quite a noise, however I would give a message to the user, because
it's something worth checking).

...

> +       spin_lock_irqsave(&dev->devres_lock, flags);
> +       old_dr = find_dr(dev, devm_kmalloc_release, devm_kmalloc_match, ptr);
> +       spin_unlock_irqrestore(&dev->devres_lock, flags);

> +       if (!old_dr) {

I would have this under spin lock b/c of below.

> +               WARN(1, "Memory chunk not managed or managed by a different device.");
> +               return NULL;
> +       }

> +       old_head = old_dr->node.entry;

This would be still better to be under spin lock.

> +       new_dr = krealloc(old_dr, total_size, gfp);
> +       if (!new_dr)
> +               return NULL;

And perhaps spin lock taken already here.

> +       if (new_dr != old_dr) {
> +               spin_lock_irqsave(&dev->devres_lock, flags);
> +               list_replace(&old_head, &new_dr->node.entry);
> +               spin_unlock_irqrestore(&dev->devres_lock, flags);
> +       }

Yes, I understand that covering more code under spin lock does not fix
any potential race, but at least it minimizes scope of the code that
is not under it to see exactly what is problematic.

I probably will think more about a better approach to avoid potential races.

-- 
With Best Regards,
Andy Shevchenko
