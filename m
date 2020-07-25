Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329B322D990
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jul 2020 21:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgGYTU5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Jul 2020 15:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGYTU4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Jul 2020 15:20:56 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C3EC08C5C0
        for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2020 12:20:55 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id e64so13104406iof.12
        for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2020 12:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BAKD43YZW+XuTJpWzZ9VYyNMQYro/UXMGluF3fF4RYs=;
        b=Xhf417/RwG3NeXd9PMir029lydvfWTPF/8jJlWtZ2kMEl6apVCGbNy22lOShc2CrJ3
         6fnIVRmhU2MH8kyyigQzB6BYr4f+E9VuXQ6oP7TySgZkjacZl34d4lC4uoSJu2X+1hFG
         PD/Amz7tkEbGbbrMctrB8Ux5faMcAaurEl/N72CcGFuk98JoYpRMEgCv4qHsTHcqo0wZ
         ZQxQYyDYayi+9wtQZ4UwHACQyPddT2V2GsU+SgMaqmOojihG6eO/Anl8mxsIQYRSrMDo
         jlDWC2/3MbLFSliD3ej5bAfhCbvVO/8/PYfVbRZw4b61VKvCvrAAK4Zva6pD1WTHc67C
         +dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BAKD43YZW+XuTJpWzZ9VYyNMQYro/UXMGluF3fF4RYs=;
        b=UUH86/sQNrP45sqBMPGXd30Pd2XrrQo1gT9PX63x3R470fCjKboo2c3gZjkv3qsX7m
         aXprkBa9FGhIHjnR/u/GoZmU6jfVnvjFhRJJ83IsPGqCYXZggh+wPw+s/VJ9BkMtj/OO
         10ZkPfPoVkjAW0lEoX8SfrRfn1OXUCNApVJYNVdNS5aBbDMQ1HXFOMy3bHTunpj3/6nt
         ZRYIMOG2LQz0B7LCNR4/n08m2GxmZY3iwtPec067g0Lk1tT7XeZ0kmh1QRryudfoR4zh
         wBBRSl5KEQ90rHCsMqJgHED7WjUz/puPiaYo6d0JWkxGdY+goN84n0HHfJUZda/UWyIE
         FDIQ==
X-Gm-Message-State: AOAM532JHJyXYq1ZrH8l94XVyDm6OAwCqstmrCpi6R7Sm7EsRz47Ii9J
        E+JW9Wg7RdWuA5jBLEuRGixqn52Hgu7uBkqXwwInZA==
X-Google-Smtp-Source: ABdhPJx6JxsimzPomfM2WuKjX7IWCzlyMb7jOINulu+5K1XUglCEFIKyVyJiLS58iWiQ3f7gDzo6FNe8rcOgwXN1sCs=
X-Received: by 2002:a05:6602:2c01:: with SMTP id w1mr16805753iov.130.1595704854695;
 Sat, 25 Jul 2020 12:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200715092528.8136-1-brgl@bgdev.pl> <20200715092528.8136-2-brgl@bgdev.pl>
In-Reply-To: <20200715092528.8136-2-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 25 Jul 2020 21:20:43 +0200
Message-ID: <CAMRc=Mcjv9ykTy8BQSzvG_FnpP1s_SyhyTMpV=fZ1U=SJTy-iA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] devres: provide devm_krealloc()
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 15, 2020 at 11:25 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Implement the managed variant of krealloc(). This function works with
> all memory allocated by devm_kmalloc() (or devres functions using it
> implicitly like devm_kmemdup(), devm_kstrdup() etc.).
>
> Managed realloc'ed chunks can be manually released with devm_kfree().
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

[snip!]

> +void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
> +{
> +       struct devres *old_dr, *new_dr;
> +       struct list_head old_head;
> +       unsigned long flags;
> +       size_t total_size;
> +       void *ret = NULL;
> +
> +       if (unlikely(!new_size)) {
> +               devm_kfree(dev, ptr);
> +               return ZERO_SIZE_PTR;
> +       }
> +
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
> +       if (!check_dr_size(new_size, &total_size))
> +               return NULL;
> +
> +       spin_lock_irqsave(&dev->devres_lock, flags);
> +
> +       old_dr = find_dr(dev, devm_kmalloc_release, devm_kmalloc_match, ptr);
> +       if (!old_dr) {
> +               spin_unlock_irqrestore(&dev->devres_lock, flags);
> +               WARN(1, "Memory chunk not managed or managed by a different device.");
> +               return NULL;
> +       }
> +
> +       old_head = old_dr->node.entry;
> +
> +       new_dr = krealloc(old_dr, total_size, gfp);

Ugh, I wanted to check up on this patch and, after looking at it now,
realized it's wrong. If the user calls devm_krealloc() with GFP_KERNEL
we may end up sleeping with spinlock taken.

Let me prepare another version.

Bartosz
